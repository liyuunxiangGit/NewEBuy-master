//
//  TCWBFriendViewController.m
//  TCWeiBoSDKDemo
//
//  Created by Cui Zhibo on 12-8-20.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWBFriendViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "pinyin.h"
#import "key.h"
#import "FileStreame.h"
#import "UINoteView.h"
#import "Reachability.h"
#import "UITableViewFriendCell.h"

#define TAG_TABLEVIEW_FRIEND  11
#define TAG_IMAGEVIEW_ITEM    12
#define TAG_LABEL_ITEM        13
#define TAG_IMAGEVIEW_SEPARATORLINE_ITEM   14


#define TAG_SEARCHBAR         20
#define TAG_CONTROL_LAYER     21
#define TAG_LABEL_HEADER      22

#define TAG_WAITINGVIEW       23

#define TAG_NOTEVIEW          24
#define TAG_BUTTON_BACK       25
#define TAG_LABEL_TITLE       26

#define TABLEVIEWCELL_HEIGHT  55

#define WAITTINGVIEW_WIDTH    145
#define WAITTINGVIEW_HEIGHT   145

#define NOTEVIEW_WIDTH   160
#define NOTEVIEW_HEIGHT  160


#define kIndexPath        @"indexPath"
#define kIsSearchFriend   @"isSearchFriend"


@implementation TCWBFriendViewController



- (id)init {
    
    if (self = [super init]) {
        
        arrFriend = [[NSMutableArray alloc] init];
        
        arrIndexFriend = [[NSMutableArray alloc] init];
        
        arrSearchFriend = [[NSMutableArray alloc] init];
        
        bSearchFriend = NO;
        
        arrMutualFriend = [[NSMutableArray alloc] init];
        arrIntimateFriend = [[NSMutableArray alloc] init];
                
        strUserName = [[NSMutableString alloc] init];
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        UIView *viewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416 + 88)];
        self.view = viewMain;
    }else {
        UIView *viewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
        self.view = viewMain;
    }
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];

    NSBundle *main = [NSBundle mainBundle];


    // 导航条
    UIImageView *imageviewNavigation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"composeupbg.png"]];
    [imageviewNavigation setFrame:CGRectMake(0, 0, 320, 44)];
    [imageviewNavigation setUserInteractionEnabled:YES];
    
    [self.view addSubview:imageviewNavigation];
    
    
    // 返回
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setTag:TAG_BUTTON_BACK];
    [buttonBack setFrame:CGRectMake(5, 5.5, 52, 33)];
    
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"composequxiaobtn.png"] forState:UIControlStateNormal];
    
    [buttonBack.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [buttonBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    NSString *strCancel = [main localizedStringForKey:kLanguageBack value:nil table:kTCWBTable];
    [buttonBack setTitle:strCancel forState:UIControlStateNormal];
    
	[buttonBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    
    // 标题
    UILabel *labelTitle = [[UILabel alloc] init];
    [labelTitle setTag:TAG_LABEL_TITLE];
    
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    [labelTitle setFont:[UIFont systemFontOfSize:17]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setTextAlignment:UITextAlignmentCenter];
    
    NSString *strFriends = [main localizedStringForKey:kLanguageFriends value:nil table:kTCWBTable];
    [labelTitle setText:strFriends];
    
    CGSize szTitle = [labelTitle.text sizeWithFont:labelTitle.font];
    [labelTitle setFrame:CGRectMake((320 - szTitle.width)/2, (44 - szTitle.height)/2, szTitle.width, szTitle.height)];
    
    [self.view addSubview:labelTitle];
    
    
    
    // 搜索框
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
    [searchbar setTag:TAG_SEARCHBAR];
    
    [searchbar setDelegate:self];
    [searchbar setBarStyle:UIBarStyleDefault];
    [searchbar setPlaceholder:@"搜索"];
    
    [self.view addSubview:searchbar];
    
    
    // 列表框
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, 320, 372 + 88) style:UITableViewStylePlain];
        [tableview setTag:TAG_TABLEVIEW_FRIEND];
        
        [tableview setDelegate:self];
        [tableview setDataSource:self];
        
        [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.view addSubview:tableview];

    }else {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, 320, 372) style:UITableViewStylePlain];
        [tableview setTag:TAG_TABLEVIEW_FRIEND];
        
        [tableview setDelegate:self];
        [tableview setDataSource:self];
        
        [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.view addSubview:tableview];

    }
//    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, 320, 372) style:UITableViewStylePlain];
    
    
    
    // 覆盖层
    UIControl *controlLayer = [[UIControl alloc]initWithFrame:CGRectMake(0, 88, 320, 372)];
	[controlLayer setTag:TAG_CONTROL_LAYER];
    
	[controlLayer setBackgroundColor:[UIColor blackColor]];
    [controlLayer setAlpha:0.7f];
    
	[controlLayer addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchUpInside];
	[controlLayer setHidden:YES];
    
	[self.view addSubview:controlLayer];
    
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (bSearchFriend) {
        
        return 1;
    }
    return [arrIndexFriend count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (bSearchFriend) {
        
        return [arrSearchFriend count];
    }
    
    NSDictionary *dicIndexFriend = [arrIndexFriend objectAtIndex:section];
    NSArray *arrayIndexFriend = [dicIndexFriend objectForKey:kIndexFriend];
    return [arrayIndexFriend count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (bSearchFriend && [indexPath row] == 0) {
        
        NSString *identifier = @"keyCell";
        NSDictionary *dickey = [arrSearchFriend objectAtIndex:0];
        
        UITableViewCell *cell = [self createKeyCell:tableView identifier:identifier data:dickey];
        
        return cell;
    }
    else {
        
        NSMutableDictionary *dicFriend = nil;
        
        if (bSearchFriend) {
            
            dicFriend = [arrSearchFriend objectAtIndex:[indexPath row]];
        }
        else {
            
            NSDictionary *dicIndexFriend = [arrIndexFriend objectAtIndex:[indexPath section]];
            NSArray *arrayIndexFriend = [dicIndexFriend objectForKey:kIndexFriend];
            dicFriend = [arrayIndexFriend objectAtIndex:[indexPath row]];
        }
        
        
        NSString *identifier = @"friendCell";
        UITableViewCell *cell = [self createFriendCell:tableView  identifier:identifier indexPath:indexPath data:dicFriend];
        
        return cell;
        
    }
    
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (bSearchFriend) {
        
        return nil;
    }
    
    
    NSDictionary *dicIndexFriend = [arrIndexFriend objectAtIndex:section];
    NSString *strIndex = [dicIndexFriend objectForKey:kIndex];
    
    return strIndex;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if (bSearchFriend) {
        
        return nil;
    }
    
    
    NSMutableArray *arrIndex = [NSMutableArray array];
    
    for (int i = 0; i < [arrIndexFriend count]; i ++) {
        
        NSDictionary *dicIndexFriend = [arrIndexFriend objectAtIndex:i];
        NSString *strIndex = [dicIndexFriend objectForKey:kIndex];
        
        [arrIndex addObject: strIndex];
    }
    
    if ([arrIntimateFriend count] > 0) {
        
        [arrIndex replaceObjectAtIndex:0 withObject:@"常"];
    }
    
    return arrIndex;
}


#pragma mark 列表框 委托  

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return TABLEVIEWCELL_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (bSearchFriend) {
        
        NSDictionary *dicFriend = [arrSearchFriend objectAtIndex:[indexPath row]];

        if ([indexPath row] == 0) {
            
            NSString *strNick = [dicFriend objectForKey:kWeiboNick];
            NSString *text = [NSString stringWithFormat:@"@%@ ",strNick];
            [rebroadcastviewController insertTextAtCurrentIndex:text];
        }
        else {
            
            NSString *strName = [dicFriend objectForKey:kWeiboName];
            NSString *text = [NSString stringWithFormat:@"@%@ ",strName];
            
            [rebroadcastviewController insertTextAtCurrentIndex:text];
        }

    }
    else {
        
        NSDictionary *dicIndexFriend = [arrIndexFriend objectAtIndex:[indexPath section]];
        NSArray *arrayIndexFriend = [dicIndexFriend objectForKey:kIndexFriend];
        NSDictionary *dicFriend = [arrayIndexFriend objectAtIndex:[indexPath row]];   
        
        NSString *strName = [dicFriend objectForKey:kWeiboName];
        NSString *text = [NSString stringWithFormat:@"@%@ ",strName];
        
        [rebroadcastviewController insertTextAtCurrentIndex:text];
    }
    
    
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark 滚动视图 委托

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UISearchBar *searchbar = (UISearchBar *)[self.view viewWithTag:TAG_SEARCHBAR];
    [searchbar resignFirstResponder];
    
    
    for (id cc in [searchbar subviews]) {
		if ([cc isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *)cc;
			[button setEnabled:YES];
		}
	}
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (decelerate == NO) {
        
        [self loadHeadForOnScreen:bSearchFriend];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self loadHeadForOnScreen:bSearchFriend];
}



#pragma mark 按钮响应函数

- (void)onButtonBack {
    
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark 搜索框 委托 

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (id cc in [searchBar subviews]) {
		if ([cc isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *)cc;
			[button setTitle:@"取消" forState:UIControlStateNormal];
		}
	}
    
    UIControl *controlLayer = (UIControl *)[self.view viewWithTag:TAG_CONTROL_LAYER];
	if (controlLayer) {
		[controlLayer setHidden:NO];
	}
    
    return YES;
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
	return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	
    bSearchFriend = NO;
    
	[searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setText:@""];
    
    
    UIControl *controlLayer = (UIControl *)[self.view viewWithTag:TAG_CONTROL_LAYER];
	if (controlLayer) {
		[controlLayer setHidden:YES];
	}
    
    
    UITableView *tableview = (UITableView *)[self.view viewWithTag:TAG_TABLEVIEW_FRIEND];
    [tableview reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    UIControl *controlLayer = (UIControl *)[self.view viewWithTag:TAG_CONTROL_LAYER];
	if (controlLayer) {
		[controlLayer setHidden:YES];
	}
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSString *strKey = [searchBar text];
    
    if ([strKey length] > 0) {
        
        bSearchFriend = YES;
        
        UIControl *controlLayer = (UIControl *)[self.view viewWithTag:TAG_CONTROL_LAYER];
        if (controlLayer) {
            [controlLayer setHidden:YES];
        }
        
        [arrSearchFriend removeAllObjects];
        
        
        
        NSMutableDictionary *dicFriend = [NSMutableDictionary dictionaryWithCapacity:1];
        [dicFriend setObject:strKey forKey:kWeiboNick];
        [arrSearchFriend addObject:dicFriend];
        
        
        NSMutableString *strKeyConsonant = [NSMutableString string];
        
        for (int i = 0; i < [strKey length]; i ++) {
            
            char c = pinyinFirstLetter([strKey characterAtIndex:i]);
            [strKeyConsonant appendFormat:@"%c",c];
        }
        
        
        for (int i = 0; i < [arrFriend count]; i ++) {
            
            NSDictionary *dicFriend = [arrFriend objectAtIndex:i];
            NSString *strNick = [dicFriend objectForKey:kWeiboNick];
            
            NSMutableString *strNickConsonant = [NSMutableString string];
            
            for (int j = 0; j < [strNick length]; j ++) {
                
                char c = pinyinFirstLetter([strNick characterAtIndex:j]);
                [strNickConsonant appendFormat:@"%c",c];
                
                if (j == [strNick length] - 1) {
                    
                    NSRange range = [strNickConsonant rangeOfString:strKeyConsonant];
                    if (range.location != NSNotFound) {
                        
                        [arrSearchFriend addObject:dicFriend];
                    }
                }
            }
        }
        
    }
    else {
        
        bSearchFriend = NO;
        
        UIControl *controlLayer = (UIControl *)[self.view viewWithTag:TAG_CONTROL_LAYER];
        if (controlLayer) {
            [controlLayer setHidden:NO];
        }
    }
    
    
    UITableView *tableview = (UITableView *)[self.view viewWithTag:TAG_TABLEVIEW_FRIEND];
    [tableview reloadData];
}


#pragma mark 功能函数

- (void)backgroundTap:(id)sender
{
	UISearchBar *searchBar = (UISearchBar*)[self.view viewWithTag:TAG_SEARCHBAR];
	if(searchBar ){
		[searchBar resignFirstResponder];
	}	
	
    [searchBar setShowsCancelButton:NO animated:YES];
    
	UIControl *controlLayer = (UIControl *)[self.view viewWithTag:TAG_CONTROL_LAYER];
	if (controlLayer) {
		[controlLayer setHidden:YES];
	}
    
    
}


- (BOOL)setUserName:(NSString *)userName {
    
    if (userName == nil || [userName length] <= 0) {
        
        return NO;
    }
    
    [strUserName setString:userName];
    
    return YES;
}



- (BOOL)setRebroadcatstMsgViewController:(TCWBRebroadcastMsgViewController *)rebroadcastMsg {
    
    if (rebroadcastMsg == nil) {
        
        return NO;
    }
    
    rebroadcastviewController = rebroadcastMsg;
    
    return YES;
}


- (BOOL)setFriend:(NSArray *)arrayMutualFriend intimateFriend:(NSArray *)arrayIntimateFriend {
    
    if (arrayMutualFriend == nil) {
        return NO;
    }
    
    if (arrayIntimateFriend == nil) {
        return NO;
    }
    
    [arrMutualFriend setArray:arrayMutualFriend];
    [arrIntimateFriend setArray:arrayIntimateFriend];
    
    
    // 添加 互听好友
    [arrFriend setArray:arrayMutualFriend];
    
    if([arrFriend count] <= 0) {
        
        [arrFriend setArray:arrayIntimateFriend];
    }
    else {
        
        for (int i = 0; i < [arrayIntimateFriend count]; i ++) {
            
            NSDictionary *dicIntimateFriend = [arrayIntimateFriend objectAtIndex:i];
            NSString *strFriendName = [dicIntimateFriend objectForKey:kWeiboName];
            
            for (int j = 0; j < [arrFriend count]; j++) {
                
                NSDictionary *intimateFriend = [arrFriend objectAtIndex:j];
                NSString *friendName = [intimateFriend objectForKey:kWeiboName];
                
                if ([strFriendName isEqualToString:friendName]) {
                    break;
                }
                
                if (j == [arrFriend count] - 1 && ![strFriendName isEqualToString:friendName]) {
                    
                    [arrFriend addObject:dicIntimateFriend];
                    break;
                }
                
            }
            
        }
    }

    
    
    for (int i = 0; i < [arrMutualFriend count]; i ++) {
        
        
        NSMutableDictionary *dicFriend = [arrMutualFriend objectAtIndex:i];
        [dicFriend removeObjectForKey:kFriendPortrait];
        
        NSString *strNick = [dicFriend objectForKey:kWeiboNick];
        
        char c = pinyinFirstLetter([strNick characterAtIndex:0]);
        c = toupper(c);
        NSString  *strIndex = [NSString stringWithFormat:@"%hhd",c];
        
        
        // 当 arrFriend 为空时
        if ([arrIndexFriend count] == 0) {
            
            NSMutableDictionary *indexFriend = [NSMutableDictionary dictionaryWithCapacity:2];
            
            [indexFriend setObject:strIndex forKey:kIndex];
            
            NSMutableArray *arrayIndexFriend = [NSMutableArray array];
            [arrayIndexFriend addObject:dicFriend];
            
            [indexFriend setObject:arrayIndexFriend forKey:kIndexFriend];
            
            [arrIndexFriend addObject:indexFriend];
            
        }
        else {
            
            for (int j = 0; j < [arrIndexFriend count]; j ++ ) {
                
                NSDictionary *indexFriend = [arrIndexFriend objectAtIndex:j];
                NSString *index = [indexFriend objectForKey:kIndex];
                
                // 索引小于
                if ([strIndex compare:index] == NSOrderedAscending) {
                    
                    NSMutableDictionary *indexFriend = [NSMutableDictionary dictionaryWithCapacity:2];
                    
                    [indexFriend setObject:strIndex forKey:kIndex];
                    
                    NSMutableArray *arrayIndexFriend = [NSMutableArray array];
                    [arrayIndexFriend addObject:dicFriend];
                    
                    [indexFriend setObject:arrayIndexFriend forKey:kIndexFriend];
                    
                    [arrIndexFriend insertObject:indexFriend atIndex:j];
                    
                    break;
                }
                // 索引等于
                else if ([strIndex isEqualToString:index]) {
                    
                    NSMutableArray *arrayIndexFriend = [indexFriend objectForKey:kIndexFriend];
                    [arrayIndexFriend addObject:dicFriend];
                    
                    break;
                }
                // 索引大于 && 到达最后一个
                else if([strIndex compare:index] == NSOrderedDescending  && j == [arrIndexFriend count] - 1) {
                    
                    NSMutableDictionary *indexFriend = [NSMutableDictionary dictionaryWithCapacity:2];
                    
                    [indexFriend setObject:strIndex forKey:kIndex];
                    
                    NSMutableArray *arrayIndexFriend = [NSMutableArray array];
                    [arrayIndexFriend addObject:dicFriend];
                    
                    [indexFriend setObject:arrayIndexFriend forKey:kIndexFriend];
                    
                    [arrIndexFriend addObject:indexFriend];
                    
                    break;
                }
            }
        }
        
        
    }
    
    
    // 添加常用联系人
    if ([arrIntimateFriend count] > 0) {
        
        NSMutableDictionary *indexFriend = [NSMutableDictionary dictionaryWithCapacity:2];
        
        [indexFriend setObject:@"常用联系人" forKey:kIndex];
        
        for (int i = 0; i < [arrIntimateFriend count]; i ++) {
            
            NSMutableDictionary *dicFriend = [arrIntimateFriend objectAtIndex:i];
            [dicFriend removeObjectForKey:kFriendPortrait];
        }
        [indexFriend setObject:arrIntimateFriend forKey:kIndexFriend];
        
        
        [arrIndexFriend insertObject:indexFriend atIndex:0];
    }
    
        
    return YES;
}


- (BOOL)isLoadingHead:(NSString *)headURL loadQueue:(NSArray *)arrayLoadQueue {
    
    if (headURL == nil || [headURL length] <= 0) {
        return YES;
    }
    
    if (arrayLoadQueue == nil) {
        return YES;
    }
    
    for (int i = 0; i < [arrayLoadQueue count]; i ++) {
        
        if ([headURL isEqualToString:[arrayLoadQueue objectAtIndex:i]]) {
            
            return YES;
        }
    }
    
    return NO;
}




- (void)loadHeadForOnScreen:(BOOL)bSearch {
    
    if (bSearch) {
        
        return;
    }
    
    
    UITableView *tableView = (UITableView *)[self.view viewWithTag:TAG_TABLEVIEW_FRIEND];
    
	// 屏幕上看见的行
	NSArray *arrIndexPath = [tableView indexPathsForVisibleRows];
    
	for (int i = 0; i < [arrIndexPath count]; i ++) {
		
		NSIndexPath *indexPath = [arrIndexPath objectAtIndex:i];
        
        NSDictionary *dicIndexFriend = [arrIndexFriend objectAtIndex:[indexPath section]];
        NSArray *arrayFriend = [dicIndexFriend objectForKey:kIndexFriend];
        NSDictionary *dicFriend = [arrayFriend objectAtIndex:[indexPath row]];
        
                
        // 判断是否存在
        UIImage *imagePortrait = [dicFriend objectForKey:kFriendPortrait];
        if (imagePortrait) {
            continue;
        }
        
        NSString *strHeadURL = [dicFriend objectForKey:kWeiboHead];
        
        NSString *strHeadPath = [FileStreame getHeadPath:strUserName headURL:strHeadURL];
        UITableViewFriendCell *cell = (UITableViewFriendCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell setHeadPath:strHeadPath];
        
        strHeadURL = [strHeadURL stringByAppendingFormat:@"/100"];
        [cell startDownloadHead:strHeadURL];

   	}
}



- (void)showNoteView:(NSString *)strText {
    
    UINoteView *noteview = (UINoteView *)[self.view viewWithTag:TAG_NOTEVIEW];
    [noteview setNoteText:strText];
    [noteview showNoteView];
}


#pragma mark 创建 cell 函数

- (UITableViewCell *)createFriendCell:(UITableView *)tableView identifier:(NSString *)strIdentifier indexPath:(NSIndexPath *)indexPath  data:(NSMutableDictionary *)dicItem {
    
    
    UITableViewFriendCell *cell = (UITableViewFriendCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
    }

    // 取消下载图片
    [cell stopDownloadHead];

    // 头像
    UIImageView *imageviewPortrait = [cell imageviewHead];
    
    UIImage *imagePortrait = [dicItem objectForKey:kFriendPortrait];
    [imageviewPortrait setImage:imagePortrait];
    
    if (imagePortrait == nil ) {
        
        NSString *strHeadURL = [dicItem objectForKey:kWeiboHead];        
        
        NSString *strHeadPath = [FileStreame getHeadPath:strUserName headURL:strHeadURL];
        
        
        // 文件内读取
        if ([[NSFileManager defaultManager] fileExistsAtPath:strHeadPath]) {
            
            imagePortrait = [UIImage imageWithContentsOfFile:strHeadPath];
            
            [dicItem setObject:imagePortrait forKey:kFriendPortrait];
            [imageviewPortrait setImage:imagePortrait];
        }
        // 网络请求数据
        else {
            
            // 加载默认图片
            UIImage *imagePortrait = [UIImage imageNamed:@"friendPortrait.png"];
            [imageviewPortrait setImage:imagePortrait];
            

            // 下载头像
            if (tableView.dragging == NO && tableView.decelerating == NO && !bSearchFriend) {
                
                NSString *strHeadURL = [dicItem objectForKey:kWeiboHead];
                
                NSString *strHeadPath = [FileStreame getHeadPath:strUserName headURL:strHeadURL];
                [cell setHeadPath:strHeadPath];

                strHeadURL = [strHeadURL stringByAppendingFormat:@"/100"];
                [cell startDownloadHead:strHeadURL];
            }
        }
        
    }
    
    // 昵称
    UILabel *labelNick = (UILabel *)[cell.contentView viewWithTag:TAG_LABEL_ITEM];
    if (labelNick == nil) {
        
        labelNick = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 200, TABLEVIEWCELL_HEIGHT)];
        [labelNick setTag:TAG_LABEL_ITEM];
        
        [labelNick setBackgroundColor:[UIColor clearColor]];
        [labelNick setFont:[UIFont systemFontOfSize:15]];
        [labelNick setTextColor:[UIColor blackColor]];
        [labelNick setTextAlignment:UITextAlignmentLeft];
        
        [cell.contentView addSubview:labelNick];
    }
    NSString *strNick = [dicItem objectForKey:kWeiboNick];
    [labelNick setText:strNick];
    
    
    // 分隔线
    UIImageView *imageviewSeparator = (UIImageView *)[cell.contentView viewWithTag:TAG_IMAGEVIEW_SEPARATORLINE_ITEM];
    if (imageviewSeparator == nil) {
        
        imageviewSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(0, TABLEVIEWCELL_HEIGHT - 1, 320, 1)];
        [imageviewSeparator setTag:TAG_IMAGEVIEW_SEPARATORLINE_ITEM];
        
        [cell.contentView addSubview:imageviewSeparator];
        
    }
    
    UIImage *imageSeparator = [UIImage imageNamed:@"separatorLine.png"];
    [imageviewSeparator setImage:imageSeparator];
    
    return cell;
}


- (UITableViewCell *)createKeyCell:(UITableView *)tableView identifier:(NSString *)strIdentifier  data:(NSDictionary *)dicItem {
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
    }
    
    NSString *strKey = [dicItem objectForKey:kWeiboNick];
    [cell.textLabel setText:strKey];
    
    
    // 分隔线
    UIImageView *imageviewSeparator = (UIImageView *)[cell.contentView viewWithTag:TAG_IMAGEVIEW_SEPARATORLINE_ITEM];
    if (imageviewSeparator == nil) {
        
        imageviewSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(0, TABLEVIEWCELL_HEIGHT - 1, 320, 1)];
        [imageviewSeparator setTag:TAG_IMAGEVIEW_SEPARATORLINE_ITEM];
        
        [cell.contentView addSubview:imageviewSeparator];
        
    }
    
    UIImage *imageSeparator = [[UIImage imageNamed:@"separatorLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    [imageviewSeparator setImage:imageSeparator];
    
    
    return cell;
}


@end
