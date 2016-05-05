//
//  SevenLeListViewController.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenLeListViewController.h"
#import "ChooseSevenLeListCell.h"
#import "SettlementUtil.h"
#import "LotteryPayPageViewController.h"
#import "SubmitLotteryDto.h"
#import "LotteryDataModel.h"
#import "SevenLeSelectViewController.h"
#import "ComputeLotteryNumber.h"
#import "LotteryProtocolViewController.h"
#import "LotteryHallViewController.h"
#import "LotteryPayPlugin.h"
#import "ConfirmBetInfoAndCouponViewController.h"

@interface SevenLeListViewController()

@property(nonatomic,strong) SevenLeSelectViewController  *ballSelectViewCotnoller;
@property (nonatomic , strong) NSMutableArray *ballInfoArray;


-(void)compute;

-(NSString *)createNewLotteryNo;  //机选一注号码

-(CGFloat)computeLotteryArrangement:(NSString *)string;  //计算出一组号码的注数

-(void)backToLotteryHall:(id)sender;

-(void)backToLotteryDetail:(id)sender;

-(void)resetItemTitle;

- (void)setItemTitle;

@end

@implementation SevenLeListViewController

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
        self.isLotteryController = YES;
        _isFromOrder = NO;
        
        self.isChecked = YES;
        
        _multiple = 1;
        
        _periods = 1;
        
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
        self.submitLotteryDto.gid = @"07";
        if ([endTime length] > 16) {
            self.submitLotteryDto.endTime = [endTime substringToIndex:16];
        }
        
        _lotteryList = [[NSMutableArray alloc]init];
        
        }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryList);
    
    TT_RELEASE_SAFELY(_headerView);
    
    TT_RELEASE_SAFELY(_timesLbl);
    
    TT_RELEASE_SAFELY(_submitLotteryDto);
    
    TT_RELEASE_SAFELY(_ballSelectViewCotnoller);
    
    TT_RELEASE_SAFELY(_lotteryHallDto);
    
    TT_RELEASE_SAFELY(_tableContainerView);
    
    TT_RELEASE_SAFELY(_navigationBar);
    
    TT_RELEASE_SAFELY(_footView);
    
    TT_RELEASE_SAFELY(_ballInfoArray);

    SERVICE_RELEASE_SAFELY(_couponService);

    [LotteryPayPlugin cancelPay];
    
}

-(void)loadView{
    
    [super loadView];
    
    [self compute];
    self.view.clipsToBounds = YES;
    
//	CGRect frame = CGRectMake(0,-200,310,self.view.frame.size.height-30);
//    
//    
//    if (IOS7_OR_LATER)
//    {
//        self.tableView.backgroundColor = [UIColor whiteColor];
//        frame = CGRectMake(0,-200,320,self.view.frame.size.height-30);
//    }
//    self.tableView.frame = frame;
    
    
    [self.view addSubview:self.headerView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (IOS7_OR_LATER)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:self.tableView];
    //[self.tableContainerView addSubview:self.tableView];
    
   // [self.view addSubview:self.tableContainerView];
    
    //添加底部视图
//    if (IOS7_OR_LATER)
//    {
//         _footView = [[LotteryListFootView alloc] initWithYOrigin:self.view.frame.size.height-  LOTTERY_LIST_FOOT_VIEW_HEIGHT-42];
//    }
//    else
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
    [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
    
    
    [self compute];
    
    if (self.isFromOrder == YES) {
        
        [self.tableView reloadData];
        
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
    
    self.title = [NSString stringWithFormat:@"%@%@",_titleString,L(@"List")];
//    [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
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

- (NSMutableArray *)ballInfoArray {
    if (!_ballInfoArray) {
        _ballInfoArray = [[NSMutableArray alloc] init];
    }
    return _ballInfoArray;
}

- (CouponService *)couponService{
    
    
    if (!_couponService) {
        
        _couponService = [[CouponService alloc] init];
        
        _couponService.delegate = self;
    }
    return _couponService;
}

-(UIView *)tableContainerView{
    
    if (_tableContainerView == nil) {
        
        _tableContainerView = [[UIView alloc]init];
        if ([SystemInfo is_iPhone_5]) {
            _tableContainerView.frame = CGRectMake(5, 42, 310, 266 + 88);
        }else{
            _tableContainerView.frame = CGRectMake(5, 42, 310, 266);
        }
        
        _tableContainerView.backgroundColor = [UIColor clearColor];
        
        _tableContainerView.clipsToBounds = YES;
        
    }
    
    return _tableContainerView;
    
}


-(UIView *)headerView{
    
    if (_headerView == nil) {
        
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
        //if (IOS7_OR_LATER)
        {
            _headerView.backgroundColor = [UIColor uiviewBackGroundColor];
        }
//        else
//        {
//            imageView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
//            
//            [_headerView addSubview:imageView];
//            _headerView.backgroundColor = [UIColor clearColor];
//        }
        
        [_headerView addSubview:self.timesLbl];
        
    }
    return _headerView;
    
}

-(UILabel *)timesLbl{
    
    if (_timesLbl == nil) {
        
        _timesLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 35)];
        
        _timesLbl.backgroundColor = [UIColor clearColor];
        
        _timesLbl.textAlignment = UITextAlignmentCenter;
        
        _timesLbl.font = [UIFont systemFontOfSize:14.0];
        
        NSString *endTime = [self.submitLotteryDto.endTime substringWithRange:NSMakeRange(0, 16)];
        
        _timesLbl.text = [NSString stringWithFormat:@"%@%@%@",self.submitLotteryDto.productTimes,L(@"Period EndTime"),endTime];
        
        _timesLbl.textColor = [UIColor darkGrownColor];
        
    }
    
    return _timesLbl;
    
}

-(SevenLeSelectViewController *)ballSelectViewCotnoller{
    
    if (!_ballSelectViewCotnoller) {
        
        _ballSelectViewCotnoller = [[SevenLeSelectViewController alloc] init];
        
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
            //if (IOS7_OR_LATER)
            {
                UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1,320 , 1)];
                v.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
                [cell addSubview:v];
            }
        }
        
        return cell;
    }
    
    static NSString * ChooseSevenLeListCellIdentifier = @"ChooseSevenLeListCellIdentifier";
    
    ChooseSevenLeListCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseSevenLeListCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[ChooseSevenLeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChooseSevenLeListCellIdentifier];
        
        if (self.isFromLuck == YES) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    NSString *tempString = [self.lotteryList objectAtIndex:indexPath.row];
    
    cell.lotteryNo = [ComputeLotteryNumber  computeSevenLeNumber :tempString];
    
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
        
        if ([delegate conformsToProtocol:@protocol(SevenLeListViewControllerDelegate) ]) {
            
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
        
        
        [self.tableView reloadData];
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
        
        self.ballSelectViewCotnoller.lotteryHallDto = self.lotteryHallDto;
        
        self.delegate = self.ballSelectViewCotnoller;
        
        self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
        
        self.ballSelectViewCotnoller.isFromOrder = YES;
        
        [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];
        
    }
    
    
//    [self resetItemTitle];
    
    if ([delegate conformsToProtocol:@protocol(SevenLeListViewControllerDelegate) ])
    {
        
        if ([delegate respondsToSelector:@selector(returnUserEditLotteryCell:andIndex:andMultiNo: periods:andOnlyCouldChooseMoney:)]) {
            
            NSString * tempStr = [self.lotteryList objectAtIndex:indexPath.row];
            
            double temp = 0.0;
            
            temp = [ComputeLotteryNumber computeSevenLeNumber:tempStr];
            DLog(@"temp ====== %f", temp);
            
            DLog(@"temp ====== %d",_totalListNumber);
            
            double userCouldChooseMoney = 2000 - (_totalListNumber-temp*_multiple*_periods)*2;
            
            DLog(@"userCouldChooseMoney ====== %f", userCouldChooseMoney);
            
            [delegate returnUserEditLotteryCell:self.lotteryList
                                       andIndex:indexPath.row
                                     andMultiNo:_multiple
                                        periods:_periods
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
    
    if (_buyMoney+addMoney >2000) {
        
        [self presentSheet :L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    if (self.isFromOrder == YES) {
        
        self.ballSelectViewCotnoller.lotteryHallDto = self.lotteryHallDto;
        
        self.ballSelectViewCotnoller.isFromOrder = YES;
        
        self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
        
        self.delegate = self.ballSelectViewCotnoller;
        
        [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];
        
    }
    
    if ([delegate conformsToProtocol:@protocol(SevenLeListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserAddLotteryCell:andMultiNo: periods:andOnlyCouldChooseMoney:)]) {
            
            double userCouldChooseMoney = 2000 - _totalListNumber*2;
            
            [delegate returnUserAddLotteryCell:self.lotteryList
                                    andMultiNo:_multiple
                                       periods:_periods
                       andOnlyCouldChooseMoney:userCouldChooseMoney];
        }
    }
   
    
}
//机选一注
- (void)addRandomNumber
{
    [self compute];
    NSString *newNoString = [self createNewLotteryNo];
    
    CGFloat newZhuShu = 0;
    
    newZhuShu = [ComputeLotteryNumber computeSevenLeNumber:newNoString];
    
    if (_buyMoney+newZhuShu*_multiple*_periods*2>2000) {
        
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    [self.lotteryList insertObject:newNoString atIndex:0];
    
    _listNumber = _listNumber+newZhuShu;
    
    [self.tableView reloadData];
    
    [self compute];
    
    [_footView updateWithMultiple:_multiple bets:_listNumber periods:_periods isBuyWhenWin:_isStopBuyWhenWin];
    
    
}
- (void)changeLotteryPeriods:(int)periods;
{
    _periods = periods;
    
    if ([delegate conformsToProtocol:@protocol(SevenLeListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChoosePeriods:)]) {
            
            [delegate returnUserChoosePeriods:_periods];
        }
    }
    
    
}
- (void)changeLotteryMultiple:(int)multiple;
{
    _multiple = multiple;
    
    if ([delegate conformsToProtocol:@protocol(SevenLeListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChooseMulitNo:)]) {
            
            [delegate returnUserChooseMulitNo:_multiple];
        }
    }
    
    
    
}

-(BOOL)isMoneyOverFlowWithMultiple:(int)multiple andPeriods:(int)periods;
{
    int buyTotalListNumber = _listNumber*multiple*periods;
    int buyLottteryMoney = buyTotalListNumber*2;
    if (buyLottteryMoney >2000)
    {
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return YES;
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
        
//        BBAlertView *alertView = [[BBAlertView alloc]initWithTitle:L(@"system-error") message:(@"Will clear all number") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        
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


-(void)gotoPayForLottery
{
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
        for (__strong NSString *tempStr in self.lotteryList)
        {
            NSString *redBallStr = [NSString stringWithFormat:@"<font color=red>%@</font>",tempStr];
            
            [self.ballInfoArray addObject:redBallStr];
            
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@","];
            
            buyCodes = [buyCodes stringByAppendingFormat:@"%@:1:1;",[tempStr substringToIndex:[tempStr length]-1]];
            
        }
        
        buyCodes = [buyCodes substringToIndex:[buyCodes length]-1];
        
        [self compute];
        
        self.submitLotteryDto.productMoney = [NSString  stringWithFormat:@"%d",_buyMoney];
        
        self.submitLotteryDto.multiNo = [NSString  stringWithFormat:@"%d",_multiple];
        
        
        if ([self.submitLotteryDto.productMoney doubleValue] > 2000) {
            
            [self presentSheet: L(@"The single orders bets up to 2000 yuan")];
            
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


-(void)compute{
    
    _listNumber = 0;
    
    for (NSString *string in self.lotteryList)
    {
        
        int temp = 0;
        
        
        temp = [ComputeLotteryNumber computeSevenLeNumber:string];
        
        
        
        _listNumber +=temp;
        
    }
    
    double danbeijine = _listNumber*2;
    
    _totalListNumber = _listNumber*_periods*_multiple;
    
    _buyMoney = danbeijine*_periods*_multiple;
    
    if ([delegate conformsToProtocol:@protocol(SevenLeListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChooseListNumber:)]) {
            
            [delegate returnUserChooseListNumber:_listNumber];
        }
    }
    
}

-(NSString *)createNewLotteryNo{
    
    NSMutableArray *ballArray = [[NSMutableArray alloc]init];
    
    
    [LotteryDataModel getRandomArray:ballArray randomNumCount:7 maxCount:30];
    
    [LotteryDataModel sortFromLowToHigh:ballArray];
    NSString *ballString = @"";
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    if ([ballArray count] > 0) {
        
        for (__strong NSNumber *number in ballArray) {
            
            int tempNo = [number intValue];
            
            tempNo++;
            
            number = [NSNumber numberWithInt:tempNo];
            
            if ([ballString isEqualToString:@""]) {
                
                NSString *tempString = [numberFormatter stringFromNumber:number];
                //如果获取的数字仅有个位，则在前面加上一个0
                if ([tempString length] == 1) {
                    
                    ballString = [NSString stringWithFormat:@"0%@",tempString];
                }else{
                    
                    ballString = tempString;
                }
                
            }else{
                
                NSString *tempString = [numberFormatter stringFromNumber:number];
                //如果获取的数字仅有个位，则在前面加上一个0
                if ([tempString length] == 1) {
                    
                    tempString = [NSString stringWithFormat:@"0%@",tempString];
                }
                
                ballString = [NSString stringWithFormat:@"%@ %@",ballString,tempString];
                
            }
        }
    }
    
    NSString *newNoString = ballString;
    newNoString = [NSString stringWithFormat:@"%@ ",newNoString];
    
    TT_RELEASE_SAFELY(ballArray);
    
    TT_RELEASE_SAFELY(numberFormatter);
    
    return newNoString;
}


-(CGFloat)computeLotteryArrangement:(NSString *)string
{
    
    return [ComputeLotteryNumber computeSevenLeNumber:string];
}



-(void)backToLotteryHall:(id)sender{
    
    if ([self.lotteryList count] >0)
    {
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:L(@"Back lottery hall will clear all the selected number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];

        
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

-(void)backToLotteryDetail:(id)sender
{
    
    if ([self.lotteryList count] >0)
    {
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:L(@"Back Order details will clear all the selected number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            
            [self.navigationController popViewControllerAnimated:YES];

        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView)

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
        
        if(item.title && [item.title isEqualToString:L(@"Back to Lottery hall")])
        {
            
            
            [item setTitle:L(@"Seven Le Lottery")];
            
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

@end
