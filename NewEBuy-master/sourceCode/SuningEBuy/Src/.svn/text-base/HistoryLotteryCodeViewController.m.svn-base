//
//  HistoryLotteryCodeViewController.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "HistoryLotteryCodeViewController.h"
#import "BeforeLotteryPidCodeCell.h"
#import "HistoryCodeDto.h"
#import "HistoryLotteryPidCodeCell.h"

#define kHistoryCodeObservingKey @"historyCodeErrorMsg"

@interface HistoryLotteryCodeViewController () {
    UIImageView *_centerNoneDataView;
}

@end

@implementation HistoryLotteryCodeViewController
@synthesize centerNoneDataView = _centerNoneDataView;
- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_historyCodeRequestService);
    TT_RELEASE_SAFELY(_centerNoneDataView);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isLotteryController = YES;
        _historyCodeRequestService = [[HistoryCodeRequestService alloc] init];
        _historyCodeRequestService.delegate = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    self.title = _lotteryDto.gname;
    self.pageTitle = [NSString stringWithFormat:@"%@-%@%@",L(@"virtual_lottery"),self.title,L(@"LOLotteryHistory")];
    
    [self.view addSubview:self.tableView];

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor view_Back_Color];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    self.tableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.tableView addSubview:self.refreshHeaderView];
    
    [self displayOverFlowActivityView];

    [_historyCodeRequestService sendHistoryCodeRequest:self.lotteryDto.gid];
}


- (void)historyCodeRequestServiceComplete:(HistoryCodeRequestService *)service isSuccess:(BOOL)isSuccess
{
    [self refreshDataComplete];
    
    if (isSuccess)
    {
        self.historyCodeArray = _historyCodeRequestService.historyCodeList;
    }
    else
    {
        [self presentSheet:_historyCodeRequestService.errorMsg];
    }

    [self.tableView reloadData];
        
    [self removeOverFlowActivityView];

}

- (UIImageView *)centerNoneDataView
{
    if (!_centerNoneDataView)
    {
        _centerNoneDataView = [[UIImageView alloc] init];
        _centerNoneDataView.image = [UIImage imageNamed:@"face.png"];
        _centerNoneDataView.frame = CGRectMake(60, 80, 194, 132);

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 194, 30)];
        lab.textAlignment = UITextAlignmentCenter;
        //        lab.text = L(@"NoCommendSoftware");
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = RGBCOLOR(224, 219, 206);

        [_centerNoneDataView addSubview:lab];
        TT_RELEASE_SAFELY(lab);
    }

    return _centerNoneDataView;
}

#pragma mark -tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.historyCodeArray count] == 0)
    {
        return 0;
    }

    return [self.historyCodeArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 100;
    }

    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];

    if (index == 0)
    {
        static NSString *beforeLotteryPidCodeCellIdentifier = @"beforeLotteryPidCodeCellIdentifier";

        BeforeLotteryPidCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:beforeLotteryPidCodeCellIdentifier];

        if (cell == nil)
        {
            cell = [[BeforeLotteryPidCodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:beforeLotteryPidCodeCellIdentifier];
            cell.backgroundColor = [UIColor view_Back_Color];
        }

        if (self.historyCodeArray)
        {
            HistoryCodeDto *dto = [self.historyCodeArray objectAtIndex:index];

            [cell setItem:dto lotteryID:[self.lotteryDto.gid intValue]];
        }

        return cell;
    }
    else
    {
        static NSString *historyLotteryPidCodeCellIdentifer = @"historyLotteryPidCodeCellIdentifier";

        HistoryLotteryPidCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:historyLotteryPidCodeCellIdentifer];

        if (cell == nil)
        {
            cell = [[HistoryLotteryPidCodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyLotteryPidCodeCellIdentifer];
            cell.backgroundColor = [UIColor view_Back_Color];
        }

        if (self.historyCodeArray)
        {
            HistoryCodeDto *dto = [self.historyCodeArray objectAtIndex:index];

            [cell setItem:dto lotteryID:[self.lotteryDto.gid intValue]];
        }

        return cell;
    }
}

- (void)reloadTableViewDataSource
{
    [super reloadTableViewDataSource];

    [_historyCodeRequestService sendHistoryCodeRequest:self.lotteryDto.gid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
