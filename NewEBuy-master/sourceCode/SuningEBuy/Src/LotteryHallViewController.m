//
//  LotteryHallViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LotteryHallViewController.h"
#import "LotteryHallDto.h"
#include "LotteryItemCell.h"
#import "NoticeAndOrderCell.h"
#import "NoticeViewController.h"
#import "LotteryDealsViewController.h"
#import "LotteryOrderDetailViewController.h"
#import "LottertSelectViewController.h"
#import "Welfare3DSelectViewController.h"
#import "SevenStarsSelectViewController.h"
#import "ArrangeBallViewController.h"
#import "SevenLeSelectViewController.h"
#import "MoreLotteryTypeCell.h"
#import "SNSwitch.h"

@implementation LotteryHallViewController

@synthesize lotteryCatArray = _lotteryCatArray;

@synthesize lotteryAllArray =_lotteryAllArray;

@synthesize service =_service;

@synthesize systemDate = _systemDate;

@synthesize isLoaded = _isLoaded;

@synthesize userOperation = _userOperation;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryCatArray);
    
    TT_RELEASE_SAFELY(_lotteryAllArray);
    
    SERVICE_RELEASE_SAFELY(_service);
    
    TT_RELEASE_SAFELY(_systemDate);
    
}

- (BOOL)isOpenLottery
{
    return [SNSwitch isOpenLottery];
}

- (id)init {
    self = [super init];
    if (self) {
        self.isLotteryController = YES;
        self.title = L(@"LotteryHall");
        self.pageTitle = L(@"virtual_lottery_lotteryHall");
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        self.lotteryCatArray = tempArray1;
        TT_RELEASE_SAFELY(tempArray1);
        
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        self.lotteryAllArray = tempArray2;
        TT_RELEASE_SAFELY(tempArray2);
        
        _service = [[LotteryHallService alloc]init];
        
        _service.delegate = self;
        
        _isLoaded = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(goToOrderDetail:)
                                                     name:@"GoToLotteryOrderDetail"
                                                   object:nil];
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)loadView{
    
    [super loadView];
    
	self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	self.tableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:(UIView *) self.refreshHeaderView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_isLoaded == NO) {
        
        [self refreshData];
    }
    
}
- (void) lotteryHallRequestCompletedWithResult:(NSMutableArray *)lotteryCatList
                             andLotreryAllList:(NSMutableArray *)lotteryAllList
                                     isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    
    [self refreshDataComplete];
    
    if (isSuccess == NO) {
        
        if (!IsStrEmpty(self.service.errorMsg)) {
            [self presentSheet:self.service.errorMsg];
        }else{
            [self presentSheet:!IsStrEmpty(errorCode)?errorCode:L(@"Failed to get lottery hall")];
        }
    }
    else
    {
        _isLoaded = YES;
        
        if ([self isOpenLottery]) {
            self.lotteryCatArray = lotteryCatList;
            
            if ([self.lotteryCatArray count] == 0)
            {
                [self presentSheet:L(@"Request failed,please restart this application")];
            }
        }
        
        self.lotteryAllArray = lotteryAllList;
        
        [self sortLotteryList];
    }
    [self updateTable];
}

- (void)updateTable{
    
    [self.tableView reloadData];
}

- (void)sortLotteryList{
    //重新排列彩票大厅双色球和大乐透的位置
    // 重新排列双色球和大乐透的位置
    if ([self.lotteryCatArray count] > 1)
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", @"", @"", @"", nil];
        
        for (LotteryHallDto *dto in self.lotteryCatArray)
        {
            if ([dto.gid isEqualToString:@"01"])
            {
                [array replaceObjectAtIndex:0 withObject:dto];
            }
            
            if ([dto.gid isEqualToString:@"50"])
            {
                [array replaceObjectAtIndex:1 withObject:dto];
            }
            
            if ([dto.gid isEqualToString:@"03"])
            {
                [array replaceObjectAtIndex:2 withObject:dto];
            }
            
            if ([dto.gid isEqualToString:@"51"])
            {
                [array replaceObjectAtIndex:3 withObject:dto];
            }
            
            if ([dto.gid isEqualToString:@"53"])
            {
                [array replaceObjectAtIndex:4 withObject:dto];
            }
            
            if ([dto.gid isEqualToString:@"52"])
            {
                [array replaceObjectAtIndex:5 withObject:dto];
            }
            
            if ([dto.gid isEqualToString:@"07"])
            {
                [array replaceObjectAtIndex:6 withObject:dto];
            }
        }

        NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:[self.lotteryCatArray count]];
        for (int i = 0; i < [array count]; i ++) {
            id dto = [array objectAtIndex:i];
            if ([dto isKindOfClass:[LotteryHallDto class]]) {
                [list addObject:dto];
            }
        }
        self.lotteryCatArray = list;
    }
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.lotteryCatArray count] + 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 96;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [indexPath section];
    
    if (index < [self.lotteryCatArray count])
    {
        
        LotteryItemCell *cell = [[LotteryItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor view_Back_Color];
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        [cell setItem:dto];
                
        return cell;
        
    }else// if (index == [self.lotteryAllArray count] + 1 || index == [self.lotteryAllArray count] + 2)
    {
        static NSString *noticeAndHallCellIdentifier = @"noticeAndHallCellIdentifier";
        
        NoticeAndOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeAndHallCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[NoticeAndOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeAndHallCellIdentifier];
            cell.backgroundColor = [UIColor view_Back_Color];

        }
        
        if (index == [self.lotteryCatArray count]) {
            
            [cell setItem:YES];//开奖公告
        }else{
            
            [cell setItem:NO];//我的订单
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = indexPath.section;
    NSDate *systemTime = [NSDate date];
    NSDate *nowendtime = [NSDate date];
    LotteryHallDto *dto = nil;
    
    //更多彩种提示
//    if (index == [self.lotteryCatArray count])
//    {
//        
//        NSURL *url = [NSURL URLWithString:@"http://caipiao.suning.com"];
//        
//        [[UIApplication sharedApplication] openURL:url];
//        
//    }

    if(index <7 && !IsArrEmpty(self.lotteryCatArray))
    {
        
        dto = [self.lotteryCatArray objectAtIndex:index];
        
        NSString *systemTimeStr = dto.date == nil?@"":dto.date;
        
        NSString *nowendtimeStr = dto.nowendtime == nil?@"":dto.nowendtime;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        systemTime = [formatter dateFromString:systemTimeStr];
        
        nowendtime = [formatter dateFromString:nowendtimeStr];
        
        
        if (([dto.isale integerValue] == 0) || ([dto.isale integerValue] == 2))
        {
            [self presentSheet:L(@"LOSuspentSale")];
            
            return;

        }        
    }
    
    //双色球
    if ([self.lotteryCatArray count] > 0 && index == 0)
    {
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            
            [self presentSheet :L(@"Current betting time has ended")];
            
            return;
        }
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        LottertSelectViewController *selectCtrl = [[LottertSelectViewController alloc]init];
        
        selectCtrl.hidesBottomBarWhenPushed = YES;
        
        selectCtrl.lotteryHallDTO = dto;
        
        selectCtrl.isFromOrder = NO;
        
        [self.navigationController pushViewController:selectCtrl animated:YES];
        
    }
    //大乐透
    else if ([self.lotteryCatArray count] > 1 && index == 1)
    {
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            [self presentSheet :L(@"Current betting time has ended")];
            
            return;
        }
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        LottertSelectViewController *selectCtrl = [[LottertSelectViewController alloc]init];
        
        selectCtrl.hidesBottomBarWhenPushed = YES;
        
        selectCtrl.lotteryHallDTO = dto;
        
        selectCtrl.isFromOrder = NO;
        
        [self.navigationController pushViewController:selectCtrl animated:YES];
        
    }
    
    //福彩3D
    else if([self.lotteryCatArray count]>2&& index == 2)
    {
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            [self presentSheet: L(@"Current betting time has ended")];
            
            return;
        }
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        Welfare3DSelectViewController  *welfare3DVc = [[Welfare3DSelectViewController alloc]init];
        
        welfare3DVc.lotteryHallDTO = dto;
        
        welfare3DVc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:welfare3DVc animated:YES];
        
        
    }
    //七星彩
    else if ([self.lotteryCatArray count]>3&& index == 3)
    {
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            [self presentSheet: L(@"Current betting time has ended")];
            
            return;
        }
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        SevenStarsSelectViewController *sevenStars = [[SevenStarsSelectViewController alloc]init];
        
        sevenStars.lotteryHallDto = dto;
        
        sevenStars.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:sevenStars animated:YES];
        
        TT_RELEASE_SAFELY(sevenStars);
        
    }
    //排列三
    else if([self.lotteryCatArray count]>4 && index == 4)
    {
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            [self presentSheet:L(@"Current betting time has ended")];
            
            return;
        }
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        ArrangeBallViewController *arrange3Controller = [[ArrangeBallViewController alloc] initWithLotteryType:ArrangeThree subType:zhiXuan hallDTO:dto isFromOrder:NO];
        
        arrange3Controller.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:arrange3Controller animated:YES];
        
    }
    //排列五
    else if ([self.lotteryCatArray count]>5&&index == 5)
    {
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            [self presentSheet :L(@"Current betting time has ended")];
            
            return;
        }
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        ArrangeBallViewController *arrange5Controller = [[ArrangeBallViewController alloc] initWithLotteryType:ArrangeFive subType:zhiXuan hallDTO:dto isFromOrder:NO];
        
        arrange5Controller.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:arrange5Controller animated:YES];
        
    }
    
    //七乐彩
    else if([self.lotteryCatArray count]>6&& index == 6)
    {
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:index];
        
        if ([[systemTime laterDate:nowendtime]isEqualToDate:systemTime])
        {
            [self presentSheet:L(@"Current betting time has ended")];
            
            return;
        }
        
        SevenLeSelectViewController *sevenLe = [[SevenLeSelectViewController alloc] init];
        
        sevenLe.lotteryHallDto = dto;
        
        sevenLe.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:sevenLe animated:YES];
        
        
    }
    //开奖公告
    
    else if (index == [self.lotteryCatArray count])
    {
        
        if (IsArrEmpty(self.lotteryAllArray)) {
            [self presentSheet:L(@"LOPleaseRefreshPage")];
            return;
        }
        
        NoticeViewController *ctrl = [[NoticeViewController alloc]init];
        
        ctrl.allLotteryArray = self.lotteryAllArray;
        
        [self.navigationController pushViewController:ctrl animated:YES];
        
        
    }
    //我的订单
    else  if (index == [self.lotteryCatArray count] + 1)
    {
        if (IsArrEmpty(self.lotteryAllArray)) {
            [self presentSheet:L(@"LOPleaseRefreshPage")];
            return;
        }   
        LotteryDealsViewController *listCtrl = [[LotteryDealsViewController alloc]init];
        
        listCtrl.isFormLotteryHall = YES;
        
        [self.navigationController pushViewController:listCtrl animated:YES];
        
        
    }
    
}



#pragma mark - action

-(void)goToOrderDetail:(NSNotification *)notification{
    
    if (notification == nil) return;
    
//    NSDictionary *dic = [notification object];
    
    for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
        
        if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
            
            [self.navigationController popToViewController:ctrl animated:NO];
        }
    }
    
    LotteryDealsViewController *listCtrl = [[LotteryDealsViewController alloc]init];
    
//    listCtrl.lotteryCatArray = self.lotteryCatArray;
    
    [self.navigationController pushViewController:listCtrl animated:NO];
    
    
    
//    LotteryOrderDetailViewController *detailCtrl = [[LotteryOrderDetailViewController alloc]init];
    
//    detailCtrl.projid = [dic objectForKey:@"projid"]==nil?@"":[dic objectForKey:@"projid"];
//    
//    detailCtrl.gid = [dic objectForKey:@"gid"]==nil?@"":[dic objectForKey:@"gid"];
//    
//    detailCtrl.lotteryCatArray = self.lotteryCatArray;
//    
//    [self.navigationController pushViewController:detailCtrl animated:YES];
//    
//    [detailCtrl release];
//    
}


- (void)refreshData
{
    
    [super refreshData];
    
    [self displayOverFlowActivityView];
    
    [self.service sendLotteryHallInfoHttpRequest];
    
}




@end
