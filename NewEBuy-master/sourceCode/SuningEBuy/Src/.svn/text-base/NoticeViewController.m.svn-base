//
//  NoticeViewController.m
//  SuningEBuy
//
//  Created by david david on 12-6-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "NoticeViewController.h"
#import "HistoryLotteryCodeViewController.h"

@implementation NoticeViewController

@synthesize allLotteryArray = _allLotteryArray;

- (id)init {
    self = [super init];
    if (self) {
        self.isLotteryController = YES;
        self.title = L(@"Lottery Notice");
        self.pageTitle = L(@"virtual_lottery_notice");
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        self.allLotteryArray = tempArray;
        TT_RELEASE_SAFELY(tempArray);
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_allLotteryArray);
    
}

-(void)loadView{
    
    [super loadView];
    
    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.backgroundColor = [UIColor view_Back_Color];
	[self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
}


#pragma mark -tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.allLotteryArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 83;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [indexPath section];
    
    static NSString *noticeItemCellIdentifier = @"noticeItemCellIdentifier";
    
    NoticeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeItemCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[NoticeItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeItemCellIdentifier];
        cell.backgroundColor = [UIColor view_Back_Color];
    }
    
    LotteryHallDto *dto = [self.allLotteryArray objectAtIndex:index];
    
    [cell setItem:dto];
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryLotteryCodeViewController *historyCodeViewController = [[HistoryLotteryCodeViewController alloc]init];
    LotteryHallDto *dto = [self.allLotteryArray objectAtIndex:indexPath.section];
    
    historyCodeViewController.lotteryDto = dto;
    
    [self.navigationController pushViewController:historyCodeViewController animated:YES];
    
    TT_RELEASE_SAFELY(historyCodeViewController);
}


@end
