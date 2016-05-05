//
//  TCWBTopicViewController.m
//  TCWeiBoSDKDemo
//
//  Created by Cui Zhibo on 12-8-20.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWBTopicViewController.h"
#import "pinyin.h"
#import "key.h"
#import "Reachability.h"
#import "UINoteView.h"


#define TAG_SEARCHBAR   11
#define TAG_TABLEVIEW   12

#define TAG_IMAGEVIEW_SEPARATORLINE_ITEM  13

#define TAG_NOTEVIEW   14


#define NOTEVIEW_WIDTH   160
#define NOTEVIEW_HEIGHT  160


@implementation TCWBTopicViewController

- (id)init {
    
    if (self = [super init]) {
        
        arrTopic = [[NSMutableArray alloc] init];
        arrSearchedTopic = [[NSMutableArray alloc] init];
        
        bSearching = NO;
    }
    
    return self;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 导航条
    [self.navigationController setNavigationBarHidden:YES];

    
    // 搜索框
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [searchbar setTag:TAG_SEARCHBAR];
    
    [searchbar setDelegate:self];
    [searchbar setBarStyle:UIBarStyleDefault];
    
    NSBundle *main = [NSBundle mainBundle];
    NSString *strSearchTopic = [main localizedStringForKey:kLanguageSearchTopic value:nil table:kTCWBTable];
    [searchbar setPlaceholder:strSearchTopic];
    
    
    [self.view addSubview:searchbar];
    
    [searchbar setShowsCancelButton:YES animated:YES];
    
    for (id cc in [searchbar subviews]) {
		if ([cc isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *)cc;
            
            NSBundle *main = [NSBundle mainBundle];
            NSString *strCancel = [main localizedStringForKey:KLanguageCancel value:nil table:kTCWBTable];
			[button setTitle:strCancel forState:UIControlStateNormal];
            [button setEnabled:YES];
		}
	}
    

    // 列表框
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 416 + 88) style:UITableViewStylePlain];
        [tableview setTag:TAG_TABLEVIEW];
        
        [tableview setDelegate:self];
        [tableview setDataSource:self];
        
        [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.view addSubview:tableview];
        
    } else {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 416) style:UITableViewStylePlain];
        [tableview setTag:TAG_TABLEVIEW];
        
        [tableview setDelegate:self];
        [tableview setDataSource:self];
        
        [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.view addSubview:tableview];

    }
    
    
    UINoteView *noteview = [[UINoteView alloc] initWithFrame:CGRectMake((320 - NOTEVIEW_WIDTH)/2, 85, NOTEVIEW_WIDTH, NOTEVIEW_HEIGHT)];
    [noteview setTag:TAG_NOTEVIEW];
    
    [self.view addSubview:noteview];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewDidAppear:(BOOL)animated {
    
    // 检测网络
    if (([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == NotReachable) 
		&& ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)){
        
        NSString *strNote = @"网络请求失败,稍候请重试";
        [self performSelector:@selector(showNoteView:) withObject:strNote afterDelay:1];
    }
    
}


#pragma mark 列表框 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (bSearching) {
        
        return [arrSearchedTopic count];
    }
    return [arrTopic count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellid = @"cellid";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (bSearching) {
        
        NSString *strTopic = [arrSearchedTopic objectAtIndex:[indexPath row]];
        strTopic = [NSString stringWithFormat:@"#%@#",strTopic];
        [cell.textLabel setText:strTopic];
    }
    else {
        
        NSString *strTopic = [arrTopic objectAtIndex:[indexPath row]];
        strTopic = [NSString stringWithFormat:@"#%@#",strTopic];
        [cell.textLabel setText:strTopic];
    }
    
    
    // 分隔线
    UIImageView *imageviewSeparator = (UIImageView *)[cell.contentView viewWithTag:TAG_IMAGEVIEW_SEPARATORLINE_ITEM];
    if (imageviewSeparator == nil) {
        
        imageviewSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44 - 1, 320, 1)];
        [imageviewSeparator setTag:TAG_IMAGEVIEW_SEPARATORLINE_ITEM];
        
        [cell.contentView addSubview:imageviewSeparator];
        
    }
    
    UIImage *imageSeparator = [UIImage imageNamed:@"separatorLine.png"];
    [imageviewSeparator setImage:imageSeparator];
    return cell;
}


#pragma mark 列表框 委托

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (bSearching) {
        
        NSString *strTopic = [NSString stringWithFormat:@"#%@#",[arrSearchedTopic  objectAtIndex:[indexPath row]]];
        [rebroadcastviewController insertTextAtCurrentIndex:strTopic];
    }
    else {
        
        NSString *strTopic = [NSString stringWithFormat:@"#%@#",[arrTopic  objectAtIndex:[indexPath row]] ];
        [rebroadcastviewController insertTextAtCurrentIndex:strTopic];

    }
    
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark   搜索框 委托

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSString *text = [searchBar text];
    
    if ([text isEqualToString:@""]) {
        
        bSearching = NO;
        
    }
    else {
        
        bSearching = YES;
        [arrSearchedTopic removeAllObjects];
        
        [arrSearchedTopic addObject:text];
        
        // 匹配
        for (int i = 0; i < [arrTopic count]; i ++) {
            
            NSString *strTopic = [arrTopic objectAtIndex:i];
            NSRange range = [strTopic rangeOfString:text];
            if (range.location != NSNotFound) {
                
                [arrSearchedTopic addObject:strTopic];
            }
        }
    }
    
    UITableView *tableview = (UITableView *)[self.view viewWithTag:TAG_TABLEVIEW];
    [tableview reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark  功能函数

- (BOOL)setTopic:(NSArray *)arrayTopic {
    
    if (arrayTopic == nil || [arrayTopic count] <= 0) {
        
        return NO;
    }
    
    [arrTopic setArray:arrayTopic];
    
    return YES;
}


- (BOOL)setRebroadcatstMsgViewController:(TCWBRebroadcastMsgViewController *)rebroadcastMsg {
    
    if (rebroadcastMsg == nil) {
        
        return NO;
    }
    
    rebroadcastviewController = rebroadcastMsg;
    
    return YES;
}


- (void)showNoteView:(NSString *)strText {
    
    UINoteView *noteview = (UINoteView *)[self.view viewWithTag:TAG_NOTEVIEW];
    [noteview setNoteText:strText];
    [noteview showNoteView];
}


@end
