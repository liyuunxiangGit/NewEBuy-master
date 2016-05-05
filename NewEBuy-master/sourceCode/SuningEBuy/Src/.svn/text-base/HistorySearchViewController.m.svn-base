//
//  HistorySearchViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "HistorySearchViewController.h"

@interface HistorySearchViewController ()

@end

@implementation HistorySearchViewController

@synthesize historySearchView = _historySearchView;
@synthesize historyKeywordsList = _historyKeywordsList;
@synthesize historySearchDealegate = _historySearchDealegate;
@synthesize service = _service;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_historySearchView);
    TT_RELEASE_SAFELY(_historyKeywordsList);
    SERVICE_RELEASE_SAFELY(_service);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (id)init
{
    self = [super init];
    if (self) {
    _historySearchView = [[HistorySearchView alloc] initWithOwner:self];
    
    self.view = _historySearchView;
    }
    return self;
}



- (void)viewDidAppear:(BOOL)animated{
    
    [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
        self.historyKeywordsList = list;
        [self reloadHistoryTableViewData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SearchService *)service
{
    if (!_service) {
        _service = [[SearchService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)reloadHistoryTableViewData
{
    if (self.historyKeywordsList == nil || [self.historyKeywordsList count] == 0) {
        _historySearchView.tableView.tableFooterView = _historySearchView.noHistoryLabel;
        
    }else {
        _historySearchView.tableView.tableFooterView = _historySearchView.delAllButtonView;
    }
    
    [_historySearchView.tableView reloadData];
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyKeywordsList?[self.historyKeywordsList count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    
    for (UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"    %@",[self.historyKeywordsList objectAtIndex:indexPath.row] ];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.textColor=[UIColor colorWithRGBHex:0x444444];
    
    UIImageView *line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
    line.frame=CGRectMake(0, 39, 320, 1);
    [cell.contentView addSubview:line];
    TT_RELEASE_SAFELY(line);
    
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *keyword = [self.historyKeywordsList objectAtIndex:indexPath.row];
    
    if (_historySearchDealegate && [_historySearchDealegate respondsToSelector:@selector(didSelectKeyword:)]) {
        [_historySearchDealegate didSelectKeyword:keyword];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *keyword = [self.historyKeywordsList objectAtIndex:indexPath.row];
    
    [self.service deleteKeywordFromDB:keyword completionBlock:^(NSArray *list){
        self.historyKeywordsList = list;
        [self reloadHistoryTableViewData];
    }];
}


- (void)clearSearchHistorys
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Confirm clear search history")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"confirm")];
    [alert setConfirmBlock:^{
        [self.service deleteAllKeywordsFromDBWithCompletionBlock:^(NSArray *list){
            self.historyKeywordsList = list;
            [self reloadHistoryTableViewData];
        }];
        
    }];
    [alert show];
}
@end
