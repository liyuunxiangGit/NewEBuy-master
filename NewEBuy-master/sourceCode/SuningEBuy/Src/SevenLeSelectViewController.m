//
//  SevenLeSelectViewController.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-4.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenLeSelectViewController.h"
#import "LotteryRuleViewController.h"
#import "LotteryDataModel.h"
#import <AudioToolbox/AudioServices.h>
#import "SubmitLotteryDto.h"
#import "ComputeLotteryNumber.h"


@implementation SevenLeSelectViewController

- (void)dealloc
{
    [_motionControl stop];
}

- (id)init
{
    if (self = [super init])
    {
        self.isLotteryController = YES;
        totalBallCount_ = 30;
        
        minBallCount_ = 7;
        
        maxBallCount_ = 12;
        
        _ballArray  =  [[NSMutableArray alloc] init];
        
        isEditing_ = NO;
        
        _isFromOrder = NO;
        
        isFromList_ = NO;
        
        editIndex_ = -1;
        
        self.multiNo = 1;
        
        self.leftBetNo = @"2000";
        
        self.periods = 1;
        
        self.title = L(@"Seven Le Lottery");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
        
        if (self.isFromOrder == NO) {
            
            _lotteryList = [[NSMutableArray alloc] init];
        }
        
    }
    
    return self;
}
- (void)loadView
{
    [super loadView];
    
    
    //     [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
    
    UIButton *showGameRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    showGameRuleBtn.frame = CGRectMake(0, 0, 45,32);
    
    [showGameRuleBtn setImage:[UIImage imageNamed:@"lottery_help.png"] forState:UIControlStateNormal];
    
    [showGameRuleBtn addTarget:self action:@selector(showGameRule:) forControlEvents: UIControlEventTouchUpInside ];
    
    UIBarButtonItem *RuleBtnItem = [[UIBarButtonItem alloc]initWithCustomView:showGameRuleBtn];
    
    self.navigationItem.rightBarButtonItem = RuleBtnItem;
    
    TT_RELEASE_SAFELY(RuleBtnItem);
    
    //添加顶部上期开奖信息
    [self.view addSubview:self.topView];
    
    [self.topView setLabelsInfo:self.lotteryHallDto];
    //添加选球试图
    [self.view addSubview:self.selectBallView];
    
    [self.view addSubview:self.bottomView];
    //if (IOS7_OR_LATER)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 9777;
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    [window addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
    
    
    [self.motionControl start];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    [self.motionControl stop];
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    [[window viewWithTag:9777] removeFromSuperview];
    
    [[window viewWithTag:4008365] removeFromSuperview];
    
    [self.selectBallView removeView];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:NO];
    
    [self becomeFirstResponder];
    
    [self resetBalls];
    
}


-(void)showGameRule:(id)sender
{
    LotteryRuleViewController *controller = [[LotteryRuleViewController alloc] init];
    
    controller.lotteryType = sevenLe;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = L(@"returnTo_myEuy");
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
}

- (SevenLeTopView *)topView
{
    if (!_topView)
    {
        _topView = [[SevenLeTopView alloc]init];
        if (IOS7_OR_LATER)
        {
            _topView.frame = CGRectMake(0, 0, 320, 45);
        }
        else
            _topView.frame = CGRectMake(10, 0, 320, 40);
        
    }
    
    return _topView;
}

- (SevenLeSelectBallView *)selectBallView
{
    if (!_selectBallView)
    {
        _selectBallView = [[SevenLeSelectBallView alloc]initWithBallCount:totalBallCount_ minNumber:minBallCount_ maxNumber:maxBallCount_];
        
        _selectBallView.frame = CGRectMake(0, 0, 320, self.view.height - 40 -44);
        
        _selectBallView.ballSelectDelegate = self;
        
        [self.selectBallView setBall];
        
    }
    
    return _selectBallView;
}

- (SevenLeBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[SevenLeBottomView alloc]init];
        
        
        
        _bottomView.bottomDelegate = self;
        
        if (IOS7_OR_LATER)
        {
            _bottomView.frame = CGRectMake(0, self.view.bounds.size.height-85-20, 320, 40);
            _bottomView.backgroundColor = [UIColor uiviewBackGroundColor];
        }
        else
        {
            _bottomView.backgroundColor = [UIColor clearColor];
            _bottomView.frame = CGRectMake(0, self.view.bounds.size.height-85-20+20, 320, 40);
        }
        
    }
    
    return _bottomView;
}

- (void)backToLotteryHall:(id)sender{
    
    NSString *errorMsg = nil;
    if (self.isFromOrder) {
        
        errorMsg = [NSString stringWithFormat:@"%@%@%@",L(@"Back"),self.title,L(@"Will clear all the selected number")];
    }else{
        
        errorMsg = L(@"Back lottery hall will clear all the selected number");
    }
    
    if (self.isFromOrder) {//来自于订单详情
        if ([self.ballArray count] == 0) {
            //界面无选球
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    if ([self.lotteryList count]==0&&[self.ballArray count] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:errorMsg customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertView show];
    
    TT_RELEASE_SAFELY(alertView);
    
}


#pragma mark - AlertMessageViewDelegate
-(void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index{
    
    if (index == 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark-SevenLeSelectBallViewDelegate

/*
 Notes：
 
 根据ballArray重新布局页面。
 
 */

- (void)resetBalls
{
    
    
    [self.selectBallView randomChooseBall:self.ballArray];
    
    [self.selectBallView setSelectedCountText:[self.ballArray count]];
    
    [self.bottomView setResultChoice:self.ballArray  multiNo:self.multiNo periods:self.periods];
    
    [self setSelectedCountText];
    
}


- (void)setSelectedCountText{
    
    
    [self.selectBallView setSelectedCountText:[self.ballArray count]];
    
}




- (BOOL)ballSelect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType
{
    
    NSString *errorDesc = nil;
    
    errorDesc = [self valideRandomBalls:[self.ballArray count]+1];
    
    if (![errorDesc isEqualToString:@""]&&!(errorDesc == nil)) {
        
        [self presentSheet:errorDesc];
        
        return NO;
    }
    
    
    [self.ballArray addObject:[NSNumber numberWithInt:ballIndex -1]];
    
    [LotteryDataModel sortFromLowToHigh:self.ballArray];
    
    [self.bottomView setResultChoice:self.ballArray multiNo:self.multiNo periods:self.periods];
    
    [self setSelectedCountText];
    
    return YES;
}


/*
 Notes：
 
 点击单个球，由选中状态变为非选中状态
 
 */
- (BOOL)ballUnselect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType
{
    
    [LotteryDataModel deleteFromArray:self.ballArray deletedElement:ballIndex-1];
    
    [self.bottomView setResultChoice:self.ballArray  multiNo:self.multiNo periods:self.periods];
    
    [self setSelectedCountText];
    
    return YES;
}

/*
 Notes：
 
 点击选择随机数
 
 */
- (BOOL)randomBallSelect:(NSInteger)randomCount
{
    
    NSString *errorDesc = [self valideRandomBalls:randomCount];
    
    if (![errorDesc isEqualToString:@""]&& !(errorDesc == nil))
    {
        
        [self presentSheet:errorDesc];
        
        return NO;
    }
    
    [LotteryDataModel getRandomArray:self.ballArray randomNumCount:randomCount maxCount:totalBallCount_];
    
#ifdef DEBUGLOG
    
    for (NSNumber *value in self.ballArray) {
        
        DLog(@"value is %d", [value intValue]);
        
    }
    
#endif
    
    [self.selectBallView randomChooseBall:self.ballArray];
    
    [LotteryDataModel sortFromLowToHigh:self.ballArray];
    
    
    
    [self.bottomView setResultChoice:self.ballArray multiNo:self.multiNo periods:self.periods];
    
    [self setSelectedCountText];
    
    return YES;
    
}

/*
 
 Notes：
 点击选择随机数个数
 
 */
- (BOOL)ballCountSelect:(NSInteger)ballCount{
    
    return  [self randomBallSelect:ballCount];
    
}

- (NSString *)valideSelectBalls{
    
    NSString *errorDesc = nil;
    
    if ([self.ballArray count] > 0) {
        
        if ([self.ballArray count] > maxBallCount_) {
            
            errorDesc = [NSString stringWithFormat:@"%@%d%@",L(@"The number of  balls can only have a maximum of"),maxBallCount_,L(@"Number")];
            
            
        }
        
    }
    return errorDesc;
    
}


- (NSString *)valideUnSelectBalls
{
    
    NSString *errorDesc = nil;
    
    if ([self.ballArray count] > 0) {
        
        if ([self.ballArray count] < minBallCount_) {
            
            errorDesc = [NSString stringWithFormat:@"%@%d%@",L(@"At least the number of  balls"),minBallCount_,L(@"Number")];
            
            
        }
        
    }
    return errorDesc;
    
}




- (NSString *)valideRandomBalls:(NSInteger)count
{
    
    NSString *errorDesc = nil;
    
    
    NSInteger  ballCount = 0;//投注数
    
    NSInteger ballSelectCount = count;
    
    ballCount =  [ComputeLotteryNumber computeLotterySevenLeNumber:ballSelectCount];
    
    ballCount = _listNumber+ballCount;
    
    if (ballCount *_periods*_multiNo*2> 2000)
    {
        
        errorDesc = L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan");
        
        DLog("the text === %d",ballCount *_periods*_multiNo*2);
        
        DLog("the text === %d",[self.leftBetNo intValue]);
    }
    return errorDesc;
    
    
}

- (NSString *)valideSubmitBalls{
    
    NSString *errorDesc = nil;
    
    NSInteger ballCount = 0;//投注数
    
    if (self.ballArray != nil) {
        
        NSMutableString *ballString = [[NSMutableString alloc] init];
        
        for (NSNumber *value in _ballArray)
        {
            
            if ([value intValue]+1<10)
            {
                
                [ballString appendString:[NSString stringWithFormat:@"0%d ",[value intValue] + 1]];
                
            }else
            {
                
                [ballString appendString:[NSString stringWithFormat:@"%d ",[value intValue] + 1]];
            }
            
            
        }
        
        
        ballCount =  [ComputeLotteryNumber  computeSevenLeNumber:ballString];
        
        TT_RELEASE_SAFELY(ballString);
        
    }
    
    if (ballCount == 0) {
        
        errorDesc = [NSString stringWithFormat:@"%@%d%@",L(@"Please select at least"),minBallCount_,L(@"Number of ball")];
        
        return errorDesc;
    }
    
    ballCount = _listNumber+ballCount;
    
    if (ballCount *_periods*_multiNo*2 >2000) {
        
        errorDesc = L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan");
        
        
        
    }
    
    return errorDesc;
    
}

#pragma mark -
#pragma mark LotteryListViewController Methods  彩票结果列表页面交互

/*
 Notes：
 
 提交了彩票选择的结果至结果列表。
 
 resultStr：“01 02 11 15 23 24  07”的形式的结果。
 
 */

-(void)submit:(NSString *)resultStr{
    
    NSString *errorDesc = [self valideSubmitBalls];
    
    if (![errorDesc isEqualToString:@""]&&!(errorDesc == nil)) {
        
        [self presentSheet:errorDesc];
        
        return;
    }
    
    if (isEditing_ == YES) {
        
        [self.lotteryList replaceObjectAtIndex:editIndex_ withObject:resultStr];
        
        isEditing_ = NO;
        
        editIndex_ = -1;
        
    }else{
        
        [self.lotteryList insertObject:resultStr atIndex:0];
        DLog(@"the text == %@",self.lotteryList);
        
    }
    
    if (self.isFromOrder == YES) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        SevenLeListViewController *contoller = [[SevenLeListViewController alloc] initWIthTitle:self.title andLotteryTimes:self.lotteryHallDto.nowpid  andEndTime:self.lotteryHallDto.nowendtime];
        
        contoller.lotteryList = self.lotteryList;
        
        DLog(@"the text == %@",self.lotteryList);
        
        contoller.isFromOrder = self.isFromOrder;
        
        contoller.multiple = self.multiNo;
        
        contoller.periods = self.periods;
        
        contoller.delegate = self;
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back to Lottery hall")
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:nil
                                                                                action:nil];
        
        [self.navigationController pushViewController:contoller animated:YES];
        
        TT_RELEASE_SAFELY(contoller);
        
    }
    
}

/*
 Notes：
 
 清空当前选择
 
 */
-(void)reChoose{
    
    [self.ballArray removeAllObjects];
    
    [self resetBalls];
    
}
/*
 Notes：
 
 彩票结果列表页面，修改彩票投注倍数时的Delegate方法；这样可以实时修改倍数，避免用户点击左上角返回按钮产生的问题
 
 */
-(void)returnUserChooseMulitNo:(int)multiNo{
    
    self.multiNo = multiNo;
}

- (void)returnUserChoosePeriods:(int)periods;
{
    self.periods = periods;
}

- (void)returnUserChooseListNumber:(int)listNumber
{
    _listNumber = listNumber;
}


/*
 Notes：
 
 彩票结果列表页面，修改彩票结果行项目的Delegate方法
 
 */

- (void)returnUserEditLotteryCell:(NSMutableArray *)array andIndex:(NSInteger)index andMultiNo:(int)multiNo  periods:(int)periods  andOnlyCouldChooseMoney:(CGFloat)money{
    
    isEditing_ = YES;
    
    editIndex_ = index;
    
    self.multiNo = multiNo;
    self.periods = periods;
    
    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/multiNo/periods];
    
    DLog(@"%d", [self.lotteryList count]);
    
    NSString *resultString = [self.lotteryList objectAtIndex:index];
    
    NSArray *arr =  [resultString componentsSeparatedByString:@" "];
    
    [self.ballArray removeAllObjects];
    
    if ([arr count] > 0) {
        
        
        
        for (NSString *str in arr) {
            
            if (![str isEqualToString:@""])
            {
                [self.ballArray addObject:[NSNumber numberWithInt:[str intValue]-1]];
                
            }
            
            
        }
        
        [self resetBalls];
        
    }
    
    NSInteger  ballCount = 0;//投注数
    
    ballCount =  [ComputeLotteryNumber computeLotterySevenLeNumber:[self.ballArray count]];
    
    _listNumber = _listNumber-ballCount;
    
    
    _listNumber = _listNumber < 0 ? 0 :_listNumber;
    DLog(@"the ballArray === %@",self.ballArray);
    
    
    
    
    if (self.isFromOrder == YES) {
        
        [self resetBalls];
        
    }else{
        
        [self.navigationController popToViewController:self animated:YES];
        
    }
    
}

/*
 Notes：
 
 彩票结果列表页面，增加彩票结果行项目的Delegate方法
 */


- (void)returnUserAddLotteryCell:(NSMutableArray *)array andMultiNo:(int)multiNo periods:(int)periods  andOnlyCouldChooseMoney:(CGFloat)money{
    
    isEditing_ = NO;
    
    editIndex_ = -1;
    
    self.multiNo = multiNo;
    
    self.periods = periods;
    
    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/multiNo/periods];
    
    isFromList_ = YES;
    
    DLog(@"%@", self.leftBetNo);
    
    [self.ballArray removeAllObjects];
    
    [self resetBalls];
    
    [self.navigationController popToViewController:self animated:YES];
    
}

-(void)returnUserDeleteLotteryCell:(NSMutableArray *)array andMultiNo:(int)multiNo periods:(int)periods andOnlyCouldChooseMoney:(CGFloat)money{
    
    self.multiNo = multiNo;
    self.periods =periods;
    
    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/multiNo/periods];
    
}
#pragma mark -
#pragma mark Catch Phone shaking  Method


/*
 
 Notes：
 
 摇一摇机选一注
 
 */

-(BOOL)canBecomeFirstResponder {
    
    return YES;
    
}

- (LotteryMotionControl *)motionControl
{
    if (!_motionControl) {
        _motionControl = [[LotteryMotionControl alloc] init];
        
        @weakify(self);
        [_motionControl setEventHandler:^{
            
            @strongify(self);
            [self randomBallSelect:self->minBallCount_];
        }];
    }
    return _motionControl;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
