//
//  SevenStarsSelectViewController.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenStarsSelectViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface SevenStarsSelectViewController ()

@end

@implementation SevenStarsSelectViewController
@synthesize lotteryHallDto;
@synthesize selectionSheetArray = _selectionSheetArray;
@synthesize topInfoView = topInfoView_;
@synthesize ballChooseSheet = ballChooseSheet_;
@synthesize bottomOperationView = bottomOperationView_;
@synthesize isFromOrder;

#pragma mark - initial/dealloc method
-(id)init
{
    self = [super init];
    if (self) {
        self.isLotteryController = YES;
        self.title = L(@"SevenStars");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
        
        
        UIButton *button =  [[UIButton alloc]init];
        
        UIImage  *buttonImage = [UIImage imageNamed:@"lottery_help.png"];
        
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(showGameRule) forControlEvents:UIControlEventTouchUpInside];
        
        button.enabled = YES;
        
        button.frame =  CGRectMake(0, 0, 45,32);
        
        button.backgroundColor = [UIColor clearColor];
        
        UIBarButtonItem *ruleButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        self.navigationItem.rightBarButtonItem = ruleButton;
        
        TT_RELEASE_SAFELY(ruleButton);
        
        TT_RELEASE_SAFELY(button);
        
        self.isFromOrder = NO;
        
        isEditing_   = NO;
        
        shakeTimes_ = 0;
        
    }
    return self;
}

-(void)dealloc
{
    
    TT_RELEASE_SAFELY(lotteryHallDto);
    
    TT_RELEASE_SAFELY(topInfoView_);
    
    TT_RELEASE_SAFELY(ballChooseSheet_);
    
    TT_RELEASE_SAFELY(bottomOperationView_);
    
    [_motionControl stop];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


-(LotterySelectTopView *)topInfoView
{
    if (!topInfoView_) {
        
        topInfoView_ = [[LotterySelectTopView alloc]init];
        
        topInfoView_.backgroundColor = RGBACOLOR(255, 255, 255, 0.5);
    }
    return topInfoView_;
}

-(SevenStarsChooseView *)ballChooseSheet
{
    if (!ballChooseSheet_) {
        ballChooseSheet_ = [[SevenStarsChooseView alloc]init];
        ballChooseSheet_.sevenStarsdelegate = self;
        [ballChooseSheet_ setAllBallsView];
    }
    return ballChooseSheet_;
}

-(SevenStarsBottomView *)bottomOperationView
{
    if (!bottomOperationView_) {
        bottomOperationView_ = [[SevenStarsBottomView alloc]init];
        bottomOperationView_.delegate = self;
        
    }
    return bottomOperationView_;
}

-(NSMutableArray *)selectionSheetArray
{
    if (!_selectionSheetArray) {
        _selectionSheetArray = [[NSMutableArray alloc]init];
    }
    return _selectionSheetArray;
}

- (LotteryMotionControl *)motionControl
{
    if (!_motionControl) {
        _motionControl = [[LotteryMotionControl alloc] init];
        
        @weakify(self);
        [_motionControl setEventHandler:^{
            
            @strongify(self);
            self.bottomOperationView.finalResultStr = [self createNewNumber];
            
            [self resetSevenStarsBallChooseView];
            
            [self.ballChooseSheet setBallSheetWith:self.bottomOperationView.finalResultStr];
            
            [self setBottomViewInfo];
        }];
    }
    return _motionControl;
}

#pragma mark -life cycle of view
-(void)loadView
{
    [super loadView];
    
    //顶部开奖信息视图
    if (IOS7_OR_LATER)
    {
        self.topInfoView.frame = CGRectMake(0, 0, 320, 45);
    }
    else
        self.topInfoView.frame = CGRectMake(0, 0, 320, 40);
    
    [self.view addSubview:self.topInfoView];
    
    
    //中部选球矩阵
   
    [self.ballChooseSheet setFrame:CGRectMake(0, 45, 320, self.view.frame.size.height - 45 - 44 - 40)];
    
    [self.view addSubview:self.ballChooseSheet];
    
    
    //底部操作显示视图
    if (IOS7_OR_LATER)
    {
        [self.bottomOperationView setFrame:CGRectMake(0, ballChooseSheet_.origin.y + ballChooseSheet_.height-25, self.view.frame.size.width, 40)];
    }
    else
        [self.bottomOperationView setFrame:CGRectMake(0, ballChooseSheet_.origin.y + ballChooseSheet_.height, self.view.frame.size.width, 40)];
    [self.view addSubview:self.bottomOperationView];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.topInfoView setLabelsInfo:self.lotteryHallDto];
    
    [self.bottomOperationView setBottomViewInfo:ballChooseSheet_.chooseNumberArray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollbackTip) name:ROLL_BACK object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.motionControl start];
    //顶部透明按钮  控制返回
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 9777;
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    [window addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:NO];
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    [[window viewWithTag:9777] removeFromSuperview];
    
    [[window viewWithTag:4008365] removeFromSuperview];
    
    [self.motionControl stop];
    
}

#pragma mark - delegate of subview
//清空
-(void)setBottomViewInfo
{
    [self.bottomOperationView setBottomViewInfo:self.ballChooseSheet.chooseNumberArray];
}


//选球界面代理事件
-(BOOL)ballSelect:(int)index ballType:(LotteryBallType)ballType
{
    self.ballChooseSheet.lastSelectedBallTag = index + kBallStartTag - 1;
    DLog(@"msg_sn:%d",self.ballChooseSheet.lastSelectedBallTag);
    [self.ballChooseSheet.chooseNumberArray addObject:[NSNumber numberWithInteger:self.ballChooseSheet.lastSelectedBallTag]];
    [self.bottomOperationView setBottomViewInfo:self.ballChooseSheet.chooseNumberArray];
    return YES;
}

-(BOOL)ballUnselect:(int)index ballType:(LotteryBallType)ballType
{
    self.ballChooseSheet.lastSelectedBallTag = index + kBallStartTag -1;
    [self.ballChooseSheet.chooseNumberArray removeObject:[NSNumber numberWithInteger:self.ballChooseSheet.lastSelectedBallTag]];
    [self.bottomOperationView setBottomViewInfo:self.ballChooseSheet.chooseNumberArray];
    return YES;
}

//重置选球
-(void)resetSevenStarsBallChooseView
{
    [self.ballChooseSheet resetAllBallsView];
}

//提交所选信息
-(void)submitSelection:(NSString *)selectionStr
{
    //是否所有项都有所选数字
    if ([self checkIsAnyBitNull:selectionStr]) {
        if (self.isFromOrder == YES) {
            if (!isEditing_) {
                //添加到队列中
                [self.selectionSheetArray insertObject:selectionStr atIndex:0];
            }else
            {
                [self.selectionSheetArray replaceObjectAtIndex:editIndex_ withObject:selectionStr];
            }
            
            for (UIViewController *ctrl in self.navigationController.viewControllers) {
                if ([ctrl isKindOfClass:[SevenStarsListViewController class]]) {
                    SevenStarsListViewController *resultListController = (SevenStarsListViewController *)ctrl;
                    //订单数列
                    resultListController.lotteryList = self.selectionSheetArray;
                    //顶部显示信息
                    resultListController.lotteryhallDto = self.lotteryHallDto;
                    
                    resultListController.isFromOrder = self.isFromOrder;
                    //倍数
                    resultListController.multiNo = [NSString stringWithFormat:@"%d",self.bottomOperationView.mutipleTimes];
                    //期数
                    resultListController.periods = [NSString stringWithFormat:@"%d",self.bottomOperationView.periods];
                    
                    resultListController.delegate = self;
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (!isEditing_) {
                //添加到队列中
                [self.selectionSheetArray insertObject:selectionStr atIndex:0];
            }else
            {
                [self.selectionSheetArray replaceObjectAtIndex:editIndex_ withObject:selectionStr];
            }
            
            SevenStarsListViewController *resultListController = [[SevenStarsListViewController alloc]initWithLotteryTimes:self.lotteryHallDto.nowpid andEndTime:self.lotteryHallDto.nowendtime];
            //订单数列
            
            resultListController.lotteryList = self.selectionSheetArray;
            //顶部显示信息
            resultListController.lotteryhallDto = self.lotteryHallDto;
            
            resultListController.isFromOrder = self.isFromOrder;
            //倍数
            resultListController.multiNo = [NSString stringWithFormat:@"%d",self.bottomOperationView.mutipleTimes];
            //期数
            resultListController.periods = [NSString stringWithFormat:@"%d",self.bottomOperationView.periods];
            
            resultListController.delegate = self;
            
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back to Lottery hall")
                                                                                     style:UIBarButtonItemStyleBordered
                                                                                    target:nil
                                                                                    action:nil];
            
            [self.navigationController pushViewController:resultListController animated:YES];
            TT_RELEASE_SAFELY(resultListController);
        }
        
        isEditing_ = NO;
    }else
    {
        [self presentSheet:L(@"Each select at least one ball")];
    }
}

#pragma mark - delegate of alertmessage
- (void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index
{
    if (tag == 226) {
        if (index == 0) {
            
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - delegate of sevenstarslistviewcontroller
//刷新选球页面的倍数
-(void)returnUserChooseMulitNo:(NSString *)multiNo andPeriods:(NSString *) period
{
    self.bottomOperationView.mutipleTimes = [multiNo integerValue];
    
    self.bottomOperationView.periods = [period integerValue];
}

/*
 彩票结果列表页面，增加彩票结果行项目的Delegate方法
 */
-(void)returnUserAddLotteryCell:(NSMutableArray *)array andMultiNo:(NSString *)multiNo andPeriods:(NSString *) period
        andOnlyCouldChooseMoney:(CGFloat)money isAuto:(BOOL) isAuto{
    
    if (isAuto == NO) {//手选
        
        isEditing_ = NO;
        
        self.selectionSheetArray = array;
        
        self.bottomOperationView.mutipleTimes = [multiNo integerValue];
        
        self.bottomOperationView.leftMoney = (NSInteger)money;
        
        self.bottomOperationView.periods = [period integerValue];
        
        DLog(@"%d", self.bottomOperationView.leftMoney);
        
        self.bottomOperationView.finalResultStr = nil;
        
        [self.ballChooseSheet resetAllBallsView];
        
        [self.navigationController popToViewController:self animated:YES];
    }else//机选
    {
        self.selectionSheetArray = array;
    }
}

//删除一行数据更新
-(void)returnUserDeleteLotteryCell:(NSMutableArray *)array andMultiNo:(NSString *)multiNo andPeriods:(NSString *) period
           andOnlyCouldChooseMoney:(CGFloat)money{
    
    self.bottomOperationView.mutipleTimes = [multiNo integerValue];
    
    self.bottomOperationView.periods = [period integerValue];
    
    self.bottomOperationView.leftMoney = (NSInteger)money;
    
}


/*
 彩票结果列表页面，修改彩票结果行项目的Delegate方法
 */

-(void)returnUserEditLotteryCell:(NSMutableArray *)array andIndex:(NSInteger)index andMultiNo:(NSString *)multiNo andPeriods:(NSString *) period
         andOnlyCouldChooseMoney:(CGFloat)money
{
    isEditing_ = YES;
    
    editIndex_ = index;
    
    self.bottomOperationView.mutipleTimes = [multiNo integerValue];
    
    self.bottomOperationView.leftMoney = (NSInteger)money;
    
    self.bottomOperationView.periods = [period integerValue];
    
    self.selectionSheetArray = array;
    
    NSString *resultString = [[self.selectionSheetArray objectAtIndex:index] copy];
    
    [self.ballChooseSheet resetAllBallsView];
    
    self.bottomOperationView.finalResultStr = resultString;
    
    [self.ballChooseSheet setBallSheetWith:self.bottomOperationView.finalResultStr];
    
    [self setBottomViewInfo];
    
    TT_RELEASE_SAFELY(resultString);
    
    [self.navigationController popToViewController:self animated:YES];
    
}

#pragma mark - shake delegate
-(BOOL)canBecomeFirstResponder {
    
    return YES;
    
}


-(void)showGameRule
{
    //显示彩票规则
    LotteryRuleViewController *controller = [[LotteryRuleViewController alloc] init];
    
    controller.lotteryType = sevenStars;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = L(@"returnTo_myEuy");
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
}


//点击返回的事件
-(void)backToLotteryHall:(UIButton *) backButton
{
    NSString *errorMsg;
    
    if (self.isFromOrder) {
        
        errorMsg = [NSString stringWithFormat:@"%@%@%@",L(@"Back"),self.title,L(@"Will clear all the selected number")];
    }else{
        
        errorMsg = L(@"Back lottery hall will clear all the selected number");
    }
    
    if (self.isFromOrder) {//来自于订单详情
        if ([self.ballChooseSheet.chooseNumberArray count] == 0) {
            //界面无选球
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    if ([self.selectionSheetArray count]==0&&[self.ballChooseSheet.chooseNumberArray count] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:errorMsg customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertView show];
    
    TT_RELEASE_SAFELY(alertView);
    
}

/*
 * 检测提交的结果是否靠谱 （是否每一位都有）
 * 参数：降序 带分隔符 空格 数列
 */
-(BOOL)checkIsAnyBitNull:(NSString *) resultStr
{
    //以@" | "为分割切出各个位上所选
    NSArray *stringArray = [resultStr componentsSeparatedByString:@" | "];
    if ([stringArray count] == 7) {
        return YES;
    }else
    {
        return NO;
    }
}

//回滚提示
-(void)rollbackTip
{
    [self presentSheet:L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan")];
}

//机选一注
-(NSString *)createNewNumber
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [LotteryDataModel getRandomArray:array randomNumCount:7 maxCount:9];
    
    NSMutableString *number = [[NSMutableString alloc]init];
    for (NSNumber *value in array) {
        //是否是最后一个
        if ([array lastObject] == value) {//地址是否相同  是否是同一个
            [number appendString:[NSString stringWithFormat:@"%d",[value integerValue]]];
        }else
        {
            [number appendString:[NSString stringWithFormat:@"%d | ",[value integerValue]]];
        }
    }
    TT_RELEASE_SAFELY(array);
    return number;
}

@end
