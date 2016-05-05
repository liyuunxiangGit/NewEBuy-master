//
//  LotteryListViewController.m
//  SuningEBuy
//
//  Created by david david on 12-6-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryListViewController.h"
#import "UserChooseLotteryCell.h"
#import "SettlementUtil.h"
#import "LotteryPayPageViewController.h"
#import "SubmitLotteryDto.h"
#import "LotteryDataModel.h"
#import "LottertSelectViewController.h"
#import "ComputeLotteryNumber.h"
#import "LotteryProtocolViewController.h"
#import "LotteryHallViewController.h"
#import "LotteryPayPlugin.h"

#import "ConfirmBetInfoAndCouponViewController.h"

#import "DataService.h"
@interface LotteryListViewController()
{
    HttpMessage     *cateHttpMsg;

}
@property(nonatomic,strong)LottertSelectViewController  *ballSelectViewCotnoller;
@property (nonatomic , strong) NSMutableArray *ballInfoArray;


-(void)compute;

-(NSString *)createNewLotteryNo;  //机选一注号码

-(CGFloat)computeLotteryArrangement:(NSString *)string;  //计算出一组号码的注数

-(void)backToLotteryHall:(id)sender;

-(void)backToLotteryDetail:(id)sender;

-(void)resetItemTitle;

- (void)setItemTitle;

@end

@implementation LotteryListViewController

@synthesize lotteryList = _lotteryList;
@synthesize headerView = _headerView;
@synthesize timesLbl = _timesLbl;
@synthesize footView = _footView;
@synthesize submitLotteryDto = _submitLotteryDto;
@synthesize lotteryHallDto = _lotteryHallDto;
@synthesize delegate;
@synthesize ballSelectViewCotnoller = _ballSelectViewCotnoller;
@synthesize isFromOrder = _isFromOrder;
@synthesize isChecked = _isChecked;
@synthesize tableContainerView = _tableContainerView;
@synthesize isFromLuck = _isFromLuck;
@synthesize navigationBar = _navigationBar;

- (id)initWIthTitle:(NSString *)title andLotteryTimes:(NSString *)lotteryTimes andEndTime:(NSString *)endTime {
    
    self = [super init];
    
    if (self) {
        self.bSupportPanUI = NO;
        _isFromOrder = NO;
        self.isLotteryController = YES;
        
        self.isChecked = YES;
        
        _periods = 1;
        
        _multiple = 1;
        
        _listNumber = 0;
        
        isShouldAlertMessage = YES;
        
        self.isFromLuck = NO;
        
        _titleString = title;
        
        self.title = [NSString stringWithFormat:@"%@%@",_titleString,L(@"List")];
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),[NSString stringWithFormat:@"%@%@",_titleString,L(@"ListY")]];
        
        if (_submitLotteryDto == nil) {
            _submitLotteryDto = [[SubmitLotteryDto alloc]init];
        }
        self.submitLotteryDto.productTimes = lotteryTimes;
        self.submitLotteryDto.productName = title;
        if ([title isEqualToString:L(@"DoubleColor ball")]) {
            self.submitLotteryDto.gid = @"01";
        }else if([title isEqualToString:L(@"BigLotto")]){
            self.submitLotteryDto.gid = @"50";
        }
        if ([endTime length] > 16) {
            self.submitLotteryDto.endTime = [endTime substringToIndex:16];
        }
        
        //        UIBarButtonItem *okButton = [[UIBarButtonItem alloc]initWithTitle:L(@"Ok") style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
        //        self.navigationItem.rightBarButtonItem = okButton;
        //        TT_RELEASE_SAFELY(okButton);
        //        [self compute];
        //
        
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryList);
    
    TT_RELEASE_SAFELY(_headerView);
    
    TT_RELEASE_SAFELY(_timesLbl);
    
    TT_RELEASE_SAFELY(_footView);
    
    TT_RELEASE_SAFELY(_submitLotteryDto);
    
    TT_RELEASE_SAFELY(_ballSelectViewCotnoller);
    
    TT_RELEASE_SAFELY(_lotteryHallDto);
    
    TT_RELEASE_SAFELY(_tableContainerView);
    
    TT_RELEASE_SAFELY(_navigationBar);
    
    TT_RELEASE_SAFELY(_ballInfoArray);
    
    SERVICE_RELEASE_SAFELY(_couponService);

    [LotteryPayPlugin cancelPay];
    
}

-(void)loadView{
    
    [super loadView];
    
    [self compute];
    
    self.view.clipsToBounds = YES;
    
//	CGRect frame = CGRectMake(0,-200,320,self.view.frame.size.height-30);
//    
//    self.tableView.frame = frame;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
 //   [self.tableContainerView addSubview:self.tableView];
    
 //   [self.view addSubview:self.tableContainerView];
    
//    [self.view addSubview:self.footView];
    
    //添加底部视图
    _footView = [[LotteryListFootView alloc] initWithYOrigin:self.view.frame.size.height-  LOTTERY_LIST_FOOT_VIEW_HEIGHT-42];
    _footView.delegate = self;
    [self.view addSubview:_footView];
    
    [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //    self.footView.isCurrentPage = YES;
    
    self.headerView.frame = CGRectMake(0, 0, 320, 70);
    self.footView.frame = CGRectMake(0, self.view.bounds.size.height - LOTTERY_LIST_FOOT_VIEW_HEIGHT, 320, LOTTERY_LIST_FOOT_VIEW_HEIGHT);
    self.tableView.frame = CGRectMake(0, 40, 320, self.view.bounds.size.height - self.footView.frame.size.height - 40);
    
    [self compute];
        
    if (self.isFromOrder == YES) {
        
        [self.tableView reloadData];
        
        //        [self.footView refreshViewWithList:self.lotteryList];
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backToLotteryDetail:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = 9666;
        
        UIWindow *window = [AppDelegate currentAppDelegate].window;
        [window addSubview:backButton];
        TT_RELEASE_SAFELY(backButton);
        
        
    }else{
//        [self setItemTitle];
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = 9666;
        
        UIWindow *window = [AppDelegate currentAppDelegate].window;
        [window addSubview:backButton];
        TT_RELEASE_SAFELY(backButton);
    }
    
    //    if (self.isFromLuck == YES) {
    //
    //        [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
    //    }
//    [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
    
    [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
    
    self.title = [NSString stringWithFormat:@"%@%@",_titleString,L(@"List")];;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //    self.footView.isCurrentPage = NO;
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    for (UIView *view in window.subviews) {
        
        if (view.tag == 9666) {
            
            [view removeFromSuperview];
        }
    }
//    [self resetItemTitle];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [self resetItemTitle];
}


#pragma mark - UIView

- (CouponService *)couponService{
    
    
    if (!_couponService) {
        
        _couponService = [[CouponService alloc] init];
        
        _couponService.delegate = self;
    }
    return _couponService;
}

- (NSMutableArray *)ballInfoArray {
    if (!_ballInfoArray) {
        _ballInfoArray = [[NSMutableArray alloc] init];
    }
    return _ballInfoArray;
}

-(UIView *)tableContainerView{
    
    if (_tableContainerView == nil) {
        
        _tableContainerView = [[UIView alloc]init];
        
        if ([SystemInfo is_iPhone_5]) {
            _tableContainerView.frame = CGRectMake(0, 42, 320, 266 + 88);
        }else{
            _tableContainerView.frame = CGRectMake(0, 42, 320, 266);
        }

        _tableContainerView.backgroundColor = [UIColor clearColor];
        
        _tableContainerView.clipsToBounds = YES;
        
    }
    
    return _tableContainerView;
    
}


-(UIView *)headerView{
    
    if (_headerView == nil) {
        
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
        
        imageView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
        
        //[_headerView addSubview:imageView];
        
        
        _headerView.backgroundColor = [UIColor clearColor];
        
        [_headerView addSubview:self.timesLbl];
        
    }
    return _headerView;
    
}

-(UILabel *)timesLbl{
    
    if (_timesLbl == nil) {
        
        _timesLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        
        _timesLbl.backgroundColor = [UIColor clearColor];
        
        _timesLbl.textAlignment = UITextAlignmentCenter;
        
        _timesLbl.font = [UIFont systemFontOfSize:14.0];
        
        NSString *endTime = [self.submitLotteryDto.endTime substringWithRange:NSMakeRange(0, 16)];
        
        _timesLbl.text = [NSString stringWithFormat:@"%@%@%@",self.submitLotteryDto.productTimes,L(@"Period EndTime"),endTime];
        
        _timesLbl.textColor = [UIColor darkGrownColor];
        
    }
    
    return _timesLbl;
    
}



-(LottertSelectViewController *)ballSelectViewCotnoller{
    
    if (!_ballSelectViewCotnoller) {
        
        _ballSelectViewCotnoller = [[LottertSelectViewController alloc] init];
        
    }
    
    return _ballSelectViewCotnoller;
    
}

#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.lotteryList count]+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//        
//        return 200;
//        
//    }
    if (indexPath.row == [self.lotteryList count]) {
        
        return 50;
    }
    
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//        
//        static NSString *lotteryProtocolCellIdentifiers = @"lotteryProtocolCellIdentifiers";
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lotteryProtocolCellIdentifiers];
//        
//        if (cell == nil) {
//            
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lotteryProtocolCellIdentifiers];
//            
//            //            UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
//            //
//            //            backgroundImageView.image = [UIImage imageNamed:@"lottery_top_background.png"];
//            //
//            //            [cell.contentView addSubview:backgroundImageView];
//            //
//            //            TT_RELEASE_SAFELY(backgroundImageView);
//        }
//        
//        return cell;
//        
//    }
    if (indexPath.row == [self.lotteryList count]) {
        
        static NSString *lotteryProtocolCellIdentifier = @"lotteryProtocolCellIdentifier";
        
        LotteryProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:lotteryProtocolCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[LotteryProtocolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lotteryProtocolCellIdentifier];
            
            cell.delegate = self;
        }
        
        return cell;
    }
    
    static NSString *userChooseLotteryCellIdentifier = @"userChooseLotteryCellIdentifier";
    
    UserChooseLotteryCell *cell = [tableView dequeueReusableCellWithIdentifier:userChooseLotteryCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UserChooseLotteryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userChooseLotteryCellIdentifier];
        
        if (self.isFromLuck == YES) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    NSString *tempString = [self.lotteryList objectAtIndex:indexPath.row];
    
    cell.lotteryNo = [self computeLotteryArrangement:tempString];
    
    [cell setItem:tempString indexRow:indexPath.row];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.lotteryList count]) {
        
        return  NO;
    }
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    
    if (index == [self.lotteryList count]) {
        
        return;
        
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        
        if ([delegate conformsToProtocol:@protocol(LotteryListViewControllerDelegate) ]) {
            
            if([delegate respondsToSelector:@selector(returnUserDeleteLotteryCell:andMultiNo:periods:andOnlyCouldChooseMoney:)]){
                
                double userCouldChooseMoney = 2000 - _totalListNumber*2;
                
                [delegate returnUserDeleteLotteryCell:self.lotteryList
                                           andMultiNo:_multiple
                                              periods:_periods
                              andOnlyCouldChooseMoney:userCouldChooseMoney];
            }
        }
        
        isShouldAlertMessage = NO; //删除时，不弹超过2000元的提示框
        
        [self.lotteryList removeObjectAtIndex:index];
        
        [self compute];
        
        [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
        
        //        [self.tableView beginUpdates];
        //        NSMutableArray *insertion = [[[NSMutableArray alloc] init] autorelease];
        //        [insertion addObject:indexPath];
        //        [self.tableView deleteRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        //        [self.tableView endUpdates];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isFromLuck == YES) {
        return;
    }
    
    if (indexPath.row == [self.lotteryList count]) {
        
        return;
        
    }
    
    
    if (self.isFromOrder == YES) {
        
        self.ballSelectViewCotnoller.lotteryHallDTO = self.lotteryHallDto;
        
        self.delegate = self.ballSelectViewCotnoller;
        
        self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
        
        self.ballSelectViewCotnoller.isFromOrder = YES;
        
        [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];
        
    }
    
//    [self resetItemTitle];
    
    if ([delegate conformsToProtocol:@protocol(LotteryListViewControllerDelegate) ]) {
        
        if ([delegate respondsToSelector:@selector(returnUserEditLotteryCell:andIndex:andMultiNo:periods:andOnlyCouldChooseMoney:)]) {
            
            NSString * tempStr = [self.lotteryList objectAtIndex:indexPath.row];
            
            double temp = 0.0;
            
            if ([self.title hasPrefix:L(@"DoubleColor ball")]) {
                
                temp = [ComputeLotteryNumber computeLotterySSQNumber:tempStr];
                
            }else if([self.title hasPrefix:L(@"BigLotto")]){
                
                temp = [ComputeLotteryNumber computeLotteryDLTNumber:tempStr];
            }
            DLog(@"temp ====== %f", temp);
            
            DLog(@"temp ====== %d", _totalListNumber);
            
            double userCouldChooseMoney = 2000 - (_totalListNumber-temp*_multiple*_periods)*2;
            DLog(@"userCouldChooseMoney ====== %f", userCouldChooseMoney);
            
            [delegate returnUserEditLotteryCell:self.lotteryList
                                       andIndex:indexPath.row
                                     andMultiNo:_multiple
                                        periods: _periods
                        andOnlyCouldChooseMoney:userCouldChooseMoney];
        }
    }
}

#pragma mark -LotteryListFootViewDelegate
//手选一注
- (void)addNewNumber
{
    [self compute];
    int addMoney = 1*_multiple*_periods*2;
    
    if (_buyMoney+addMoney > 2000)
    {
        
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    if (self.isFromOrder == YES) {
        
        self.ballSelectViewCotnoller.lotteryHallDTO = self.lotteryHallDto;
        
        self.ballSelectViewCotnoller.isFromOrder = YES;
        
        self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
        
        self.delegate = self.ballSelectViewCotnoller;
        
        [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];
        
    }
    
    if ([delegate conformsToProtocol:@protocol(LotteryListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserAddLotteryCell:andMultiNo:periods:andOnlyCouldChooseMoney:)]) {
            
            double userCouldChooseMoney = 2000 - _totalListNumber*2;
            
            [delegate returnUserAddLotteryCell:self.lotteryList
                                    andMultiNo:_multiple
                                       periods:_periods
                       andOnlyCouldChooseMoney:userCouldChooseMoney];
        }
        
        
        [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
    }
    
}
//机选一注
- (void)addRandomNumber
{
    
    NSString *newNoString = [self createNewLotteryNo];
    
    CGFloat newZhuShu = 0;
    
    if ([self.title hasPrefix:L(@"DoubleColor ball")])
    {
        
        newZhuShu = [ComputeLotteryNumber computeLotterySSQNumber:newNoString];
        
    }
    else if([self.title hasPrefix:L(@"BigLotto")])
    {
        
        newZhuShu = [ComputeLotteryNumber computeLotteryDLTNumber:newNoString];
    }
    
    if (_buyMoney+newZhuShu*_multiple*_periods*2>2000)
    {
        
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    [self.lotteryList insertObject:newNoString atIndex:0];
    
    _listNumber = _listNumber+newZhuShu;
    
    [self compute];
    
    [self.tableView reloadData];
    
    [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
    
}
- (void)changeLotteryPeriods:(int)periods;
{
    _periods = periods;
    
    if ([delegate conformsToProtocol:@protocol(LotteryListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChoosePeriods:)]) {
            
            [delegate returnUserChoosePeriods:_periods];
        }
    }
    
    
}
- (void)changeLotteryMultiple:(int)multiple;
{
    _multiple = multiple;
    
    if ([delegate conformsToProtocol:@protocol(LotteryListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChooseMulitNo:)]) {
            
            [delegate returnUserChooseMulitNo:_multiple];
        }
    }
    
    
    
}

-(BOOL)isMoneyOverFlowWithMultiple:(int)multiple andPeriods:(int)periods;
{
    _totalListNumber = _listNumber*multiple*periods;
    
    if (_totalListNumber*2 >2000)
    {

        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];

        return YES;
    }
    else
    {
        _buyMoney = _totalListNumber*2;
    }
    
    return NO;
}
- (void)isStopBuyWhenWin:(BOOL)yesOrNo;
{
    _isStopBuyWhenWin = yesOrNo;
}

- (void)clearAllNumbers
{
    if ([self.lotteryList count]>0)
    {
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:L(@"Will clear all number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
           
            [self.lotteryList removeAllObjects];
            
            [self.tableView reloadData];
            self.multiple = 1;
            self.periods = 1;
            _isStopBuyWhenWin = NO;
            [self compute];
            
            [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
    }
    else
    {
        [self.lotteryList removeAllObjects];
        
        [self.tableView reloadData];
        self.multiple = 1;
        self.periods = 1;
        _isStopBuyWhenWin = NO;
        [self compute];
        
        [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
        
        
    }
    
}


- (void)gotoPayForLottery
{
    
    DLog(@"提交订单");
    
    [self checkLoginWithLoginedBlock:^{
        if ([self.lotteryList count] == 0) {
            
            [self presentSheet:L(@"You have not made any bets")];
            
            return;
        }
        
        if (self.isChecked == NO) {
            
            [self presentSheet:L(@"Make sure that you have agreed to the the User Purchasing Agreement and User Information Security Agreement")];
            
            return;
            
        }
        
        //将彩票号码列表转换为一个字符串，传给支付界面
        NSString *buyCodes = @"";
        [self.ballInfoArray removeAllObjects];
        
        for (__strong NSString *tempStr in self.lotteryList) {
            
            NSArray *arr = [tempStr componentsSeparatedByString:@" | "];
            
            if ([arr count] == 2) {
                
                NSString *redString = [arr objectAtIndex:0];
                
                NSString *redBallStr = [NSString stringWithFormat:@"<font color=red>%@</font>",redString];
                
                redString = [redString stringByReplacingOccurrencesOfString:@" " withString:@","];
                
                NSString *blueString = [arr objectAtIndex:1];
                
                NSString *blueBallStr = [NSString stringWithFormat:@"<font color=blue>%@</font>",blueString];

                blueString = [blueString stringByReplacingOccurrencesOfString:@" " withString:@","];
                
                tempStr = [NSString stringWithFormat:@"%@|%@:1:1",redString,blueString];
                
                [self.ballInfoArray addObject:[NSString stringWithFormat:@"%@ | %@",redBallStr,blueBallStr]];
            }
            
            
            if ([buyCodes isEqualToString:@""]) {
                
                buyCodes = tempStr;
                
            }else{
                
                buyCodes = [NSString stringWithFormat:@"%@;%@",buyCodes,tempStr];
                
            }
        }
        
        self.submitLotteryDto.productMoney = [NSString  stringWithFormat:@"%d",_buyMoney];
        
        self.submitLotteryDto.multiNo = [NSString  stringWithFormat:@"%d",_multiple];
        
        
        if ([self.submitLotteryDto.productMoney doubleValue] > 2000) {
            
            [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
            
            return;
        }
        
        self.submitLotteryDto.buyCodes = buyCodes;
        
        if(_periods > 1)
        {
            self.submitLotteryDto.saleType = L(@"serialpurchasing");
            self.submitLotteryDto.periods = [NSString  stringWithFormat:@"%d",_periods];
            self.submitLotteryDto.stopWhenWin = _isStopBuyWhenWin;
            
            if ([LotteryPayPlugin open])
            {
                [LotteryPayPlugin startPayWithDto:self.submitLotteryDto
                                   fromController:self];
            }
            else
            {
                LotteryPayPageViewController *ctrl = [[LotteryPayPageViewController alloc]initWithSubmitLotteryDTO:self.submitLotteryDto];
                
                [self.navigationController pushViewController:ctrl animated:YES];
                
                TT_RELEASE_SAFELY(ctrl);
            }
            
        }else{
            self.submitLotteryDto.saleType = L(@"purchasing");
            [self displayOverFlowActivityView];
            [self.couponService couponQueryWithSubmitLotteryDto:self.submitLotteryDto];
            
        }
    } loginCancelBlock:nil];
    
}

#pragma mark -CouponServiceDelegate
- (void)couponQueryFinished:(CouponService *)service withInfoArray:(NSArray *)infoArray
{
    [self removeOverFlowActivityView];
    if ([infoArray count] >0)
    {
        ConfirmBetInfoAndCouponViewController *controller =  [[ConfirmBetInfoAndCouponViewController alloc]init];
        controller.submitDto = _submitLotteryDto;
        controller.couponInfoArray = infoArray;
        controller.ballInfoArray = self.ballInfoArray;
        
        [self.navigationController pushViewController:controller animated:YES];
        
        TT_RELEASE_SAFELY(controller);
        
    }
    else
    {
        if ([LotteryPayPlugin open])
        {
            [LotteryPayPlugin startPayWithDto:self.submitLotteryDto
                               fromController:self];
        }
        else
        {
            LotteryPayPageViewController *ctrl = [[LotteryPayPageViewController alloc]initWithSubmitLotteryDTO:self.submitLotteryDto];
            
            [self.navigationController pushViewController:ctrl animated:YES];
            
            TT_RELEASE_SAFELY(ctrl);
        }
    }

}

#pragma mark - action
-(void)compute{
    
    _listNumber = 0;
    
    for (NSString *string in self.lotteryList) {
        
        double temp = 0;
        
        if ([self.title hasPrefix:L(@"DoubleColor ball")]) {
            
            temp = [ComputeLotteryNumber computeLotterySSQNumber:string];
            
        }else if([self.title hasPrefix:L(@"BigLotto")]){
            
            temp = [ComputeLotteryNumber computeLotteryDLTNumber:string];
        }
        
        _listNumber +=temp;
        
    }
    
    double danbeijine = _listNumber*2;
    
    _totalListNumber = _listNumber*_periods*_multiple;
    
    _buyMoney = danbeijine*_periods*_multiple;
    
    if ([delegate conformsToProtocol:@protocol(LotteryListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChooseListNumber:)]) {
            
            [delegate returnUserChooseListNumber:_listNumber];
        }
    }
    
}

-(NSString *)createNewLotteryNo{
    
    NSMutableArray *redArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *blueArray = [[NSMutableArray alloc]init];
    
    if ([self.title hasPrefix:L(@"DoubleColor ball")]) {
        
        [LotteryDataModel getRandomArray:redArray randomNumCount:6 maxCount:33];
        
        [LotteryDataModel getRandomArray:blueArray randomNumCount:1 maxCount:16];
        
    }else if([self.title hasPrefix:L(@"BigLotto")]){
        
        [LotteryDataModel getRandomArray:redArray randomNumCount:5 maxCount:35];
        
        [LotteryDataModel getRandomArray:blueArray randomNumCount:2 maxCount:12];
    }
    
    [LotteryDataModel sortFromLowToHigh:redArray];
    
    [LotteryDataModel sortFromLowToHigh:blueArray];
    
    NSString *redString = @"";
    
    NSString *blueString = @"";
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    if ([redArray count] > 0) {
        
        for (__strong NSNumber *number in redArray) {
            
            int tempNo = [number intValue];
            
            tempNo++;
            
            number = [NSNumber numberWithInt:tempNo];
            
            if ([redString isEqualToString:@""]) {
                
                NSString *tempString = [numberFormatter stringFromNumber:number];
                //如果获取的数字仅有个位，则在前面加上一个0
                if ([tempString length] == 1) {
                    
                    redString = [NSString stringWithFormat:@"0%@",tempString];
                }else{
                    
                    redString = tempString;
                }
                
            }else{
                
                NSString *tempString = [numberFormatter stringFromNumber:number];
                //如果获取的数字仅有个位，则在前面加上一个0
                if ([tempString length] == 1) {
                    
                    tempString = [NSString stringWithFormat:@"0%@",tempString];
                }
                
                redString = [NSString stringWithFormat:@"%@ %@",redString,tempString];
                
            }
        }
    }
    //如果获取的数字仅有个位，则在前面加上一个0
    if ([blueArray count] == 1) {   //双色球,机选一个蓝球
        
        NSNumber *number = [blueArray objectAtIndex:0];
        
        int tempNo = [number intValue];
        
        tempNo++;
        
        number = [NSNumber numberWithInt:tempNo];
        
        NSString *tempString = [numberFormatter stringFromNumber:number];
        
        if ([tempString length] == 1) {
            
            blueString = [NSString stringWithFormat:@"0%@",tempString];
            
        }else{
            
            blueString = tempString;
            
        }
    }else{//大乐透  机选两个蓝球
        
        for (__strong NSNumber *number in blueArray) {
            
            int tempNo = [number intValue];
            
            tempNo++;
            
            number = [NSNumber numberWithInt:tempNo];
            
            if ([blueString isEqualToString:@""]) {
                
                NSString *tempString = [numberFormatter stringFromNumber:number];
                //如果获取的数字仅有个位，则在前面加上一个0
                if ([tempString length] == 1) {
                    
                    blueString = [NSString stringWithFormat:@"0%@",tempString];
                    
                }else{
                    
                    blueString = tempString;
                }
                
            }else{
                
                NSString *tempString = [numberFormatter stringFromNumber:number];
                //如果获取的数字仅有个位，则在前面加上一个0
                if ([tempString length] == 1) {
                    
                    tempString = [NSString stringWithFormat:@"0%@",tempString];
                }
                
                blueString = [NSString stringWithFormat:@"%@ %@",blueString,tempString];
                
            }
        }
        
        
    }
    
    NSString *newNoString = [NSString stringWithFormat:@"%@ | %@",redString,blueString];
    
    TT_RELEASE_SAFELY(redArray);
    
    TT_RELEASE_SAFELY(blueArray);
    
    TT_RELEASE_SAFELY(numberFormatter);
    
    return newNoString;
}

-(CGFloat)computeLotteryArrangement:(NSString *)string{
    
    if ([self.submitLotteryDto.gid isEqualToString:@"01"]) {
        
        return [ComputeLotteryNumber computeLotterySSQNumber:string];
        
    }else if([self.submitLotteryDto.gid isEqualToString:@"50"]){
        
        return [ComputeLotteryNumber computeLotteryDLTNumber:string];
    }
    return 0;
}

-(void)backToLotteryHall:(id)sender{
    
    if ([self.lotteryList count]>0)
    {
        
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:L(@"Back lottery hall will clear all the selected number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok") ];
        
        [alertView setConfirmBlock:^{
            
            for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                
                if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                    
                    [self.navigationController popToViewController:ctrl animated:YES];
                }
            }
            
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);

        
    }
    else
    {
        for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
            
            if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                
                [self.navigationController popToViewController:ctrl animated:YES];
            }
        }
        
    }
    
    
}

-(void)backToLotteryDetail:(id)sender{
    
    if ([self.lotteryList count]>0)
    {
        
        BBAlertView  *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:L(@"Back Order details will clear all the selected number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel")otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
           
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);

    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)setItemTitle{
    
    UINavigationBar *navBar = [self.navigationController navigationBar];
    
    for (UINavigationItem *item in navBar.items) {
        
        if(item.title && [self.title hasPrefix:item.title]){
            
            [item setTitle:L(@"Back to Lottery hall")];
            
            break;
        }
    }
}

-(void)resetItemTitle{
    
    UINavigationBar *navBar = [self.navigationController navigationBar];
    
    for (UINavigationItem *item in navBar.items) {
        
        if(item.title && [item.title isEqualToString:L(@"Back to Lottery hall")]){
            
            if ([self.submitLotteryDto.gid isEqualToString:@"01"]) {
                
                [item setTitle:L(@"DoubleColor ball")];
                
            }else if([self.submitLotteryDto.gid isEqualToString:@"50"]){
                
                [item setTitle:L(@"BigLotto")];
            }else{
                [item setTitle:L(@"Welfare 3D")];
            }
        }
    }
    
}


#pragma mark - AlertMessageViewDelegate
-(void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index{
    
    if (tag == 226) {
        
        if (index == 1) {
            
            for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                
                if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                    
                    [self.navigationController popToViewController:ctrl animated:YES];
                }
            }
        }
    }else if (tag == 227){
        
        if (index == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        if (index == 1)
        {
            [self.lotteryList removeAllObjects];
            
            [self.tableView reloadData];
            self.multiple = 1;
            self.periods = 1;
            _isStopBuyWhenWin = NO;
            [self compute];
            
            [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
            
            
        }
        
    }
}
#pragma mark - LotteryProtocolCellDelegate

- (void)presentModalProtocolView{
    
    LotteryProtocolViewController *controller = [[LotteryProtocolViewController alloc] initWithNameData:_titleString];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
    
}

-(void)returnUserCheck:(BOOL)checked{
    
    self.isChecked = checked;
    
}
@end
