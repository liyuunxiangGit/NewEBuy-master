//
//  ArrangeListViewController.m
//  SuningLottery
//
//  Created by yangbo on 4/7/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "ArrangeListViewController.h"
#import "LotteryListCell.h"
#import "LotteryProtocolViewController.h"
#import "LotteryPayPageViewController.h"
#import "ArrangeBallViewController.h"
#import "LotteryPayPlugin.h"
#import "ConfirmBetInfoAndCouponViewController.h"

#define ARRANGE_LIST_BACK_BTN_TAG 9666                     //返回按钮tag

#define ARRANGE_LIST_ALERT_CLEAR_TAG 200                  //清空号码警告框tag

#define ARRANGE_LIST_ALERT_BACK_TO_HALL_TAG 201         //返回彩票大厅警告框tag

@interface ArrangeListViewController () <ArrangeBallViewControllerDelegate>
@property (nonatomic, strong)    UIView              *topView;

@end

@implementation ArrangeListViewController
@synthesize delegate = _delegate;
@synthesize topView = _topView;
@synthesize lottertOrderListDto = _lottertOrderListDto;
@synthesize hallDto = _hallDto;
@synthesize lastSelectionType =_lastSelectionType;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_submitLotteryDto);
    TT_RELEASE_SAFELY(_lotteryFootView);
    TT_RELEASE_SAFELY(_lottertOrderListDto);
    TT_RELEASE_SAFELY(_hallDto);

    SERVICE_RELEASE_SAFELY(_couponService);
    [LotteryPayPlugin cancelPay];

}

- (id)initWithLotteryHallDto:(LotteryHallDto *)lotteryHallDto andLotteryOrderListDto:(LotteryOrderListDTO *)dto isFromOrder:(BOOL)yesOrNo
{
    self = [super init];
    
    if(self)
    {
        self.bSupportPanUI = NO;
        self.isLotteryController = YES;
        _isFromOrder = yesOrNo;
        
        _hallDto = lotteryHallDto;
        
        _lottertOrderListDto = dto;
        
        _isChecked = YES;
        
        _lastSelectionType = zhiXuan;
        
        self.title = [self.submitLotteryDto.productName stringByAppendingFormat:@"%@",L(@"List")];
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),[self.submitLotteryDto.productName stringByAppendingFormat:@"%@",L(@"ListY")]];

    }
    return self;
}

- (CouponService *)couponService{
    
    
    if (!_couponService) {
        
        _couponService = [[CouponService alloc] init];
        
        _couponService.delegate = self;
    }
    return _couponService;
}

- (SubmitLotteryDto *)submitLotteryDto{
    if (!_submitLotteryDto) {
        _submitLotteryDto = [[SubmitLotteryDto alloc] init];
        _submitLotteryDto.productTimes = _hallDto.nowpid;
        _submitLotteryDto.productName = _hallDto.gname;
        _submitLotteryDto.gid = _hallDto.gid;
        
        if ([_hallDto.nowendtime length] > 16) {
            _submitLotteryDto.endTime = [_hallDto.nowendtime substringToIndex:16];
        }
    }
    return _submitLotteryDto;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20 - 44);
    
    
    
    //添加投注方案列表
    
}

-(void)loadView
{
    [super loadView];
    //添加顶部视图
    [self addTopView];
    
    
    //self.tableView.frame = CGRectMake(5, 42, 310, [self.view bounds].size.height - 92 - LOTTERY_LIST_FOOT_VIEW_HEIGHT);
//    if (IOS7_OR_LATER)
//    {
//        self.tableView.backgroundColor = [UIColor whiteColor];
//        self.tableView.frame = CGRectMake(0, 42, 320, [self.view bounds].size.height - 92 - LOTTERY_LIST_FOOT_VIEW_HEIGHT);
//    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
     self.tableView.backgroundColor = [UIColor whiteColor];
    if (IOS7_OR_LATER)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
//    self.tableView.dataSource = self;
//    
//    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    //添加底部视图
    _lotteryFootView = [[LotteryListFootView alloc] initWithYOrigin:self.view.frame.size.height-  LOTTERY_LIST_FOOT_VIEW_HEIGHT-42];
    _lotteryFootView.delegate = self;
    [self.view addSubview:_lotteryFootView];
    
    [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];
    
    //[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topView.frame = CGRectMake(0, 0, 320, 70);
    _lotteryFootView.frame = CGRectMake(0, self.view.bounds.size.height - LOTTERY_LIST_FOOT_VIEW_HEIGHT, 320, LOTTERY_LIST_FOOT_VIEW_HEIGHT);
    self.tableView.frame = CGRectMake(0, 35, 320, self.view.bounds.size.height - _lotteryFootView.frame.size.height - 35);
    //添加返回按钮到window上
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = ARRANGE_LIST_BACK_BTN_TAG;
    
    UIWindow *widow = [AppDelegate currentAppDelegate].window;
    [widow addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
    
    [self.tableView reloadData];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //移除返回按钮
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    for(UIWindow *window in windows)
    {
        if([window viewWithTag:ARRANGE_LIST_BACK_BTN_TAG] != nil)
        {
            [[window viewWithTag:ARRANGE_LIST_BACK_BTN_TAG] removeFromSuperview];
            break;
        }
    }
}

//返回按钮点击事件
- (void)backToLotteryHall:(id)sender
{
    //号码列表为空时，直接返回
    if ([_lottertOrderListDto getCountOfNumbers] == 0) {
            [_delegate goBackWithArrangeListViewController:self andLotteryOrderListDto:_lottertOrderListDto];
        return;
    }
    
    //号码列表存在号码时，显示提示框
    
    NSString *messageStr = !_isFromOrder ? L(@"Back lottery hall will clear all the selected number") : L(@"Back Order details will clear all the selected number");
    
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:messageStr customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
       
        if(_delegate && [_delegate respondsToSelector:@selector(goBackWithArrangeListViewController:andLotteryOrderListDto:)])
        {
        
            [_delegate goBackWithArrangeListViewController:self andLotteryOrderListDto:_lottertOrderListDto];
        }
        
    }];
    
    [alertView show];
    
    TT_RELEASE_SAFELY(alertView);
    
}

- (void)addTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    _topView.backgroundColor = [UIColor clearColor];
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
    //if (IOS7_OR_LATER)
    {
        headView.backgroundColor = [UIColor uiviewBackGroundColor];
    }
//    else
//    {
//        headView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
//        headView.backgroundColor = [UIColor clearColor];
//    }
    
    
    UILabel *endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 35)];
    endTimeLabel.backgroundColor = [UIColor clearColor];
    endTimeLabel.textAlignment = UITextAlignmentCenter;
    endTimeLabel.font = [UIFont systemFontOfSize:14.0];
    
    NSString *endTime = [self.submitLotteryDto.endTime substringWithRange:NSMakeRange(0, 16)];
    endTimeLabel.text = [NSString stringWithFormat:@"%@%@ %@",self.submitLotteryDto.productTimes,L(@"Period EndTime"),endTime];
    endTimeLabel.textColor = [UIColor darkGrownColor];
    
    [headView addSubview:endTimeLabel];
    [_topView addSubview:headView];
    [self.view addSubview:_topView];
    
}

//判断是否是否超过单笔订单最大投注金额
-(BOOL)judgePayMoneyOverFlowWithMultiple:(int)multiple periods:(int)periods bets:(int)bets
{
    
    if(bets * multiple * periods * 2.0 > _lottertOrderListDto.maxPay)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - AlertMessageViewDelegate
- (void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index
{

    if (index == 1) {
        
        if(tag == ARRANGE_LIST_ALERT_CLEAR_TAG){        //点击清空按钮弹出的警告框
            [_lottertOrderListDto removeAllNumbers];
            [self.tableView reloadData];
            [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];
            
        }else if(tag == ARRANGE_LIST_ALERT_BACK_TO_HALL_TAG &&  //点击返回大厅按钮弹出的警告框
                 _delegate &&
                 [_delegate respondsToSelector:@selector(goBackWithArrangeListViewController:andLotteryOrderListDto:)]){
            [_delegate goBackWithArrangeListViewController:self andLotteryOrderListDto:_lottertOrderListDto];
        }
    }
}

#pragma mark - LotteryListFootViewDelegate
//添加手选号码
- (void)addNewNumber
{
    if(![_lottertOrderListDto shouldAddNewNumberWithBet:1])
    {

        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    //手选一注
    
    if(_isFromOrder)
    {
        BallNumberDTO *ballNumberDto = [[BallNumberDTO alloc] initWithType:_lottertOrderListDto.type subType:_lastSelectionType];
        [_lottertOrderListDto addNewBallNumberDto:ballNumberDto];
        
        ArrangeBallViewController *arrangeBallViewController = [[ArrangeBallViewController alloc] initWithLotteryListDto:_lottertOrderListDto index:0 hallDto:_hallDto isFromOrder:YES];
        arrangeBallViewController.delegate = self;
        
        [self.navigationController pushViewController:arrangeBallViewController animated:YES];
        return;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(goToSelectNewNumberWithArrangeListViewController:andLotteryOrderListDto:)])
        [_delegate goToSelectNewNumberWithArrangeListViewController:self andLotteryOrderListDto:_lottertOrderListDto];
}

//添加机选号码
- (void)addRandomNumber
{
    //机选一注号码
    BallNumberDTO *dto = [[BallNumberDTO alloc] initWithType:_lottertOrderListDto.type subType:_lastSelectionType];
    [dto randomSelectNumber];
    
    if(![_lottertOrderListDto shouldAddNewNumberWithBet:[dto bets]])
    {
        
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];

        return;
    }
    
    [_lottertOrderListDto addNewBallNumberDto:dto];
    
    [self.tableView reloadData];
    
    //刷新底部试图
    [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];
}

//追号
- (void)changeLotteryPeriods:(int)periods
{
    _lottertOrderListDto.periods = periods;
}

//倍投
- (void)changeLotteryMultiple:(int)multiple
{
    _lottertOrderListDto.multiple = multiple;
}

//清除所有号码
- (void)clearAllNumbers
{
    if ([_lottertOrderListDto getCountOfNumbers] > 0)
    {
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:L(@"Will clear all number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            
            [_lottertOrderListDto removeAllNumbers];
            [self.tableView reloadData];
            [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];

            
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
    }
    else
    {
        [_lottertOrderListDto removeAllNumbers];
        [self.tableView reloadData];
        [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];

    }
}

//去付款
- (void)gotoPayForLottery
{
    [self checkLoginWithLoginedBlock:^{
        if ([_lottertOrderListDto getCountOfNumbers] == 0) {
            
            [self presentSheet:L(@"You have not made any bets")];
            
            return;
        }
        
        if (_lottertOrderListDto.multiple == 0) {
            
            [self presentSheet:L(@"Please select at least 1 times the bet multiples")];
            
            return;
        }
        
        if (_isChecked == NO) {
            
            [self presentSheet:L(@"Make sure that you have agreed to the the User Purchasing Agreement and User Information Security Agreement")];
            
            return;
        }
        
        self.submitLotteryDto.productMoney = [_lottertOrderListDto totalMoney];
        
        self.submitLotteryDto.multiNo = [NSString stringWithFormat:@"%d",_lottertOrderListDto.multiple];
        
        self.submitLotteryDto.buyCodes = [_lottertOrderListDto codes];
        
        if(_lottertOrderListDto.periods > 1)
        {
            self.submitLotteryDto.saleType = L(@"serialpurchasing");
            
            self.submitLotteryDto.periods = [NSString stringWithFormat:@"%d",_lottertOrderListDto.periods];
            self.submitLotteryDto.stopWhenWin = _lottertOrderListDto.isStopBuyWhenWin;
            
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

//是否中奖后停止追号
- (void)isStopBuyWhenWin:(BOOL)yesOrNo
{
    _lottertOrderListDto.isStopBuyWhenWin = yesOrNo;
}

//判断输入的追号期数和倍投是否超过单笔订单最大投注金额
- (BOOL)isMoneyOverFlowWithMultiple:(int)multiple andPeriods:(int)periods
{
    BOOL isSuccess = [self judgePayMoneyOverFlowWithMultiple:multiple periods:periods bets:[_lottertOrderListDto computeBets]];
    
    if (isSuccess) {
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
    }
    
    return isSuccess;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == [_lottertOrderListDto getCountOfNumbers])
        return 50;
    
    return LOTTERY_LIST_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isFromOrder)
    {
        ArrangeBallViewController *ballViewController = [[ArrangeBallViewController alloc] initWithLotteryListDto:_lottertOrderListDto index:[indexPath row] hallDto:_hallDto isFromOrder:YES];
        ballViewController.delegate = self;
        [self.navigationController pushViewController:ballViewController animated:YES];
        
        return;
    }
    
    //修改已选的号码
    if(_delegate && [_delegate respondsToSelector:@selector(arrangeListViewController:changedBallNumberDtoIndex:andLotteryOrderListDto:)])
    [_delegate arrangeListViewController:self changedBallNumberDtoIndex:[indexPath row] andLotteryOrderListDto:_lottertOrderListDto];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_lottertOrderListDto getCountOfNumbers]+1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == [_lottertOrderListDto getCountOfNumbers])
    {
        LotteryProtocolCell *cell = [[LotteryProtocolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        //if (IOS7_OR_LATER)
        {
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
            v.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
            [cell addSubview:v];
        }
        cell.delegate = self;
        
        return cell;
    }else{
        
        LotteryListCell *cell = [[LotteryListCell alloc] initWithBallNumberDto:[_lottertOrderListDto ballNumberDtoWithIndex:[indexPath row]] index:[indexPath row]];
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == [_lottertOrderListDto getCountOfNumbers])
        return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_lottertOrderListDto removeBallNumberDtoWithIndex:[indexPath row]];
        
        [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];
        
        [tableView reloadData];
    }
}

#pragma mark - LotteryProtocolCellDelegate
-(void)returnUserCheck:(BOOL)checked
{
    _isChecked = checked;
}

-(void)presentModalProtocolView
{
    LotteryProtocolViewController *controller = [[LotteryProtocolViewController alloc] initWithNameData:self.submitLotteryDto.productName];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
}

#pragma mark - ArrangeBallViewControllerDelegate
- (void)quitWithLastSelectionType:(LotterySelectionType)subType
{
    _lastSelectionType = subType;
    
    [_lotteryFootView updateWithMultiple:_lottertOrderListDto.multiple bets:[_lottertOrderListDto computeBets] periods:_lottertOrderListDto.periods isBuyWhenWin:_lottertOrderListDto.isStopBuyWhenWin];
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
        controller.ballInfoArray = [_lottertOrderListDto showStrArray];
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

