//
//  ArrangeBallViewController.m
//  SuningLottery
//
//  Created by yangbo on 4/3/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "ArrangeBallViewController.h"
#import "ArrangeListViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "LotteryRuleViewController.h"
#import "LotteryDataModel.h"
#import "LotteryHallViewController.h"

#define ARRANGE_BACK_BTN_TAG    9666   //返回按钮tag

@implementation ArrangeBallViewController
@synthesize delegate = _delegate;

- (void)dealloc
{
    [_motionControl stop];
}

- (id)initWithLotteryType:(LotteryType)type subType:(LotterySelectionType)subType hallDTO:(LotteryHallDto *)dto isFromOrder:(BOOL)yesOrNo
{
    if(self = [super init])
    {
        _isFromOrder = yesOrNo;
        self.isLotteryController = YES;
        _index = 0;
        
        _lotteryOrderListDto  = [[LotteryOrderListDTO alloc] initWithType:type];
        
        _lotteryOrderListDto.multiple = 1;
        
        _lotteryOrderListDto.periods = 1;
        
        _lotteryOrderListDto.isStopBuyWhenWin = NO;
        
        _lotteryOrderListDto.maxPay = 2000;
        
        _lotteryHallDto = dto;
        
        //初始化添加一个空的彩票购买方案
        BallNumberDTO *dto = [[BallNumberDTO alloc] initWithType:type subType:subType];
        [_lotteryOrderListDto addNewBallNumberDto:dto];
        
        self.title = [LotteryDataModel lotteryNameWithType:type];
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
        
    }
    return self;
}

- (id)initWithLotteryListDto:(LotteryOrderListDTO *)listDto index:(NSInteger)index hallDto:(LotteryHallDto *)dto isFromOrder:(BOOL)yesOrNo
{
    if(self = [super init])
    {
        self.isLotteryController = YES;
        _lotteryOrderListDto = listDto;
        _index = index;
        _lotteryHallDto = dto;
        
        _isFromOrder = yesOrNo;
        
        self.title = [LotteryDataModel lotteryNameWithType:listDto.type];
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height- 20 - 44);
    
    _lotterySelectTopView = [[LotterySelectTopView alloc] init];
    [_lotterySelectTopView setLabelsInfo:_lotteryHallDto];
    [self.view addSubview:_lotterySelectTopView];
	
    _arrangeSelectBottomView = [[ArrangeSelectBottomView alloc] initWithFrame:CGRectMake(0, [self.view bounds].size.height-40, [[UIScreen mainScreen] bounds].size.width, 40)];
    _arrangeSelectBottomView.delegate = self;
    [_arrangeSelectBottomView setBets:0
                             multiple:_lotteryOrderListDto.multiple
                              periods:_lotteryOrderListDto.periods
                                price:2
                         numberString:nil];
    [self.view addSubview:_arrangeSelectBottomView];
    
    _arrangeBallSelectView = [[ArrangeBallSelectView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45-CGRectGetHeight(_arrangeSelectBottomView.frame) - 20 - 44) ballNumberDto:[[_lotteryOrderListDto ballNumberDtoWithIndex:_index] deepCopy]];
    //if (IOS7_OR_LATER)
    {
        _arrangeBallSelectView.backgroundColor = [UIColor whiteColor];
    }
    _arrangeBallSelectView.delegate = self;
    [self.view addSubview:_arrangeBallSelectView];
    
    
    UIButton *ruleBtn = [[UIButton alloc] init];
    ruleBtn.frame = CGRectMake(0, 0, 45,32);
    [ruleBtn setBackgroundImage:[UIImage imageNamed:@"lottery_help.png"] forState:UIControlStateNormal];
    [ruleBtn addTarget:self action:@selector(showRule:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:ruleBtn];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    //    [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
}

- (void)showRule:(id)sender
{
    LotteryRuleViewController *controller = [[LotteryRuleViewController alloc] init];
    
    controller.lotteryType = [_arrangeBallSelectView getSelectionBallNumber].type;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = L(@"returnTo_myEuy");
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = ARRANGE_BACK_BTN_TAG;
    
    UIWindow *widow = [AppDelegate currentAppDelegate].window;
    [widow addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
    
    [self.motionControl start];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    [[window viewWithTag:ARRANGE_BACK_BTN_TAG] removeFromSuperview];
    
    [[window viewWithTag:4008365] removeFromSuperview];
    
    
    [self.motionControl stop];
}

- (LotteryMotionControl *)motionControl
{
    if (!_motionControl) {
        _motionControl = [[LotteryMotionControl alloc] init];
        
        @weakify(self);
        [_motionControl setEventHandler:^{
            
            @strongify(self);
            [self->_arrangeBallSelectView randomSelectNumber];
        }];
    }
    return _motionControl;
}

-(BOOL)canBecomeFirstResponder {
    
    return YES;
    
}

- (void)backToLotteryHall:(id)sender
{
    
    if(_isFromOrder)
    {
        if([[_arrangeBallSelectView getSelectionBallNumber].ballArray count] == 0)
        {
            if([[_lotteryOrderListDto ballNumberDtoWithIndex:_index].ballArray count] == 0)
            {
                [_lotteryOrderListDto removeBallNumberDtoWithIndex:_index];
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }else{
        if([[_arrangeBallSelectView getSelectionBallNumber].ballArray count] == 0 && [[_lotteryOrderListDto ballNumberDtoWithIndex:_index].ballArray count] == 0 && [_lotteryOrderListDto getCountOfNumbers] == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    NSString *messageStr = !_isFromOrder ? L(@"Back lottery hall will clear all the selected number") : [NSString stringWithFormat:@"%@%@%@",L(@"Back"),self.title,L(@"Will clear all the selected number")];
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:messageStr customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        if([[_lotteryOrderListDto ballNumberDtoWithIndex:_index].ballArray count] == 0)
        {
            [_lotteryOrderListDto removeBallNumberDtoWithIndex:_index];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertView show];
    
    TT_RELEASE_SAFELY(alertView);
    
}

#pragma mark - LotterySelectBottomViewDelegate

//确定投注
- (void)submit
{
    
    if(![_arrangeBallSelectView isSelectNumbersValid])
    {
        
        NSString *messageStr = [[_arrangeBallSelectView getSelectionBallNumber] tipStringForAlert:YES];
        
        [self presentSheet:messageStr];
        
        return;
    }
    
    [_lotteryOrderListDto replaceBallNumberDtoAtIndex:_index withDto:[_arrangeBallSelectView getSelectionBallNumber]];
    
    if(_isFromOrder)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(quitWithLastSelectionType:)])
        {
            [_delegate quitWithLastSelectionType:[_arrangeBallSelectView getSelectionBallNumber].subType];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    ArrangeListViewController *controller = [[ArrangeListViewController alloc]
                                             initWithLotteryHallDto:_lotteryHallDto
                                             andLotteryOrderListDto:_lotteryOrderListDto isFromOrder:NO];
    controller.delegate = self;
    controller.lastSelectionType = [_arrangeBallSelectView  getSelectionBallNumber].subType;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back to Lottery hall")
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:nil
                                                                            action:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)clear
{
    [_arrangeBallSelectView clearSelectedNumber];
    
    [_arrangeSelectBottomView setBets:0
                             multiple:_lotteryOrderListDto.multiple
                              periods:_lotteryOrderListDto.periods
                                price:2
                         numberString:nil];
}

#pragma mark - ArrangeBallSelectViewDelegate
//选择或取消选择某个号码
- (void)selectOrCancelSelectBall
{
    BallNumberDTO *ballNumberDto = [_arrangeBallSelectView getSelectionBallNumber];
    
    [_arrangeSelectBottomView setBets:[ballNumberDto bets]
                             multiple:_lotteryOrderListDto.multiple
                              periods:_lotteryOrderListDto.periods
                                price:2
                         numberString:[ballNumberDto numberShowString]];
}

- (BOOL)isTotalPayOverflow
{
    
    BallNumberDTO *dto = [_lotteryOrderListDto ballNumberDtoWithIndex:_index];
    
    //当前的注数 = _lotteryOrderListDto号码列表计算的注数 - _lotteryOrderListDto中正在修改的号码的注数 + 选球界面所选号码的注数
    if(([_lotteryOrderListDto computeBets] - [dto bets] + [[_arrangeBallSelectView getSelectionBallNumber] bets]) * _lotteryOrderListDto.multiple *_lotteryOrderListDto.periods * 2.0> _lotteryOrderListDto.maxPay)
    {
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return YES;
    }else
        return NO;
}

#pragma mark - AlertMessageViewDelegate
- (void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index
{
    if (index == 1) {
        
        if([[_lotteryOrderListDto ballNumberDtoWithIndex:_index].ballArray count] == 0)
        {
            [_lotteryOrderListDto removeBallNumberDtoWithIndex:_index];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ArrangeListViewControllerDelegate

- (void)arrangeListViewController:(ArrangeListViewController *)controller changedBallNumberDtoIndex:(int)index andLotteryOrderListDto:(LotteryOrderListDTO *)dto
{
    BallNumberDTO *numberDto = [dto ballNumberDtoWithIndex:index];
    
    _index = index;
    
    [_arrangeSelectBottomView setBets:[numberDto bets]
                             multiple:dto.multiple
                              periods:_lotteryOrderListDto.periods
                                price:2
                         numberString:[numberDto numberShowString]];
    
    [_arrangeBallSelectView refreshViewWithBallDTO:[numberDto deepCopy]];
}

//返回手选一注
- (void)goToSelectNewNumberWithArrangeListViewController:(ArrangeListViewController *)controller andLotteryOrderListDto:(LotteryOrderListDTO *)dto
{
    
    BallNumberDTO *numberDto = [[BallNumberDTO alloc] initWithType:dto.type subType:controller.lastSelectionType];
    [dto addNewBallNumberDto:numberDto];
    
    _index = 0 ;
    
    [_arrangeBallSelectView refreshViewWithBallDTO:[numberDto deepCopy]];
    [_arrangeSelectBottomView setBets:[numberDto bets]
                             multiple:dto.multiple
                              periods:_lotteryOrderListDto.periods
                                price:2
                         numberString:[numberDto numberShowString]];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//点击返回按钮
- (void)goBackWithArrangeListViewController:(ArrangeListViewController *)controller
                     andLotteryOrderListDto:(LotteryOrderListDTO *)dto
{
    for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
        
        if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
            
            [self.navigationController popToViewController:ctrl animated:YES];
        }
    }
}
@end
