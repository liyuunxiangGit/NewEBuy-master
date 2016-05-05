//
//  Welfare3DSelectViewController.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "Welfare3DSelectViewController.h"
#import "LotteryDataModel.h"
#import <AudioToolbox/AudioServices.h>
#import "LotteryRuleViewController.h"
#import "ComputeLotteryNumber.h"

@interface Welfare3DSelectViewController(){
    
    NSInteger     ballCount;
    NSInteger     minNum_;
    NSInteger     leastNum_;
    NSInteger     ballSelectType_;
    
    BOOL          isFromList_;
    BOOL          isEditing_;
    NSInteger     editIndex_;
}
@property (nonatomic, strong) UILabel                         *selectTypeDesc;
@property (nonatomic, strong) Welfare3DBottomView             *bottomView;
@property (nonatomic, strong) LotterySelectTopView            *topView;
@property (nonatomic, strong) Welfare3DBallChooseView         *ballSelectView;

@property (nonatomic, strong) NSString                        *leftBetNo;

- (NSString *)valideRandomBalls:(LotteryBallType)ballType withBallArray:(NSMutableArray *)array;


@end

@implementation Welfare3DSelectViewController

@synthesize ballSelectView                    = _ballSelectView;
@synthesize welfare3DTypeSelectView           = _welfare3DTypeSelectView;
@synthesize selectTypeDesc                    = _selectTypeDesc;
@synthesize bottomView                        = _bottomView;
@synthesize topView                           = _topView;
@synthesize lotteryHallDTO                    = _lotteryHallDTO;
@synthesize welfare3DArray                    = _welfare3DArray;
//@synthesize numberBufferDic                   = _numberBufferDic;
@synthesize multiNo                           = _multiNo;
@synthesize period                            = _period;
@synthesize lotteryList                       = _lotteryList;
@synthesize leftBetNo                         = _leftBetNo;
@synthesize isFromOrder                       = _isFromOrder;

- (void)dealloc {
    
    [_motionControl stop];
}


- (id)init {
    self = [super init];
    if (self) {
        self.isLotteryController = YES;
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = L(@"Welfare 3D");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
        self.multiNo = @"1";
        self.period = @"1";
        self.leftBetNo = @"1000";
        self.isFromOrder = NO;
        isFromList_ = NO;
        ballCount = 30;
        minNum_ = 0;
        leastNum_ = 1;
        ballSelectType_ = zhiXuan;
        
        if (!_lotteryHallDTO) {
            _lotteryHallDTO = [[LotteryHallDto alloc] init];
        }
        if (!_welfare3DArray) {
            _welfare3DArray = [[NSMutableArray alloc] init];
        }
        if (!_lotteryList) {
            _lotteryList = [[NSMutableArray alloc] init];
        }
        
        UIButton *button =  [[UIButton alloc]init];
        
        UIImage  *buttonImage = [UIImage imageNamed:@"lottery_help.png"];
        
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(showGameRule:) forControlEvents:UIControlEventTouchUpInside];
        
        button.enabled = YES;
        
        button.frame =  CGRectMake(0, 0, 45,32);
        
        button.backgroundColor = [UIColor clearColor];
        
        UIBarButtonItem *ruleButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        self.navigationItem.rightBarButtonItem = ruleButton;
        
        TT_RELEASE_SAFELY(ruleButton);
        
        TT_RELEASE_SAFELY(button);
        
    }
    return self;
}

- (void)loadView{
    
    [super loadView];
    
    if (self.isFromOrder == NO && !_lotteryList) {
        
        _lotteryList = [[NSMutableArray alloc] init];
    }
    
	UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 50;
	
	frame.size.height = contentView.bounds.size.height - 92-50 ;
    
}


- (void)showGameRule:(id)sender{
    
    LotteryRuleViewController *controller = [[LotteryRuleViewController alloc] init];
    
    controller.lotteryType = welfare3D;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = L(@"Back");
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 9777;
    
    UIWindow *widow = [AppDelegate currentAppDelegate].window;
    [widow addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
    
    [self.view addSubview:self.welfare3DTypeSelectView];
    
    [self.view addSubview:self.selectTypeDesc];
    
    //    [[AppDelegate currentAppDelegate].tabBarViewController.hidesBottomBarWhenPushed = YES;
    
    self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height - 46, 320, 46);
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
    self.topView.frame = CGRectMake(0, 0, 320, 40);
    
    [self.view addSubview:self.topView];
    
    [self.topView setLabelsInfo:self.lotteryHallDTO];
    
    [self.ballSelectView reloadBallCount:ballCount minNumber:minNum_ BallType:ballSelectType_];
    
    [self.ballSelectView randomChooseBall:self.welfare3DArray];
    
    [self.view addSubview:self.ballSelectView];
    
    [self.motionControl start];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:NO];
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    [[window viewWithTag:9777] removeFromSuperview];
    
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
            //机选号码
            [self randomBallSelect:eRedBallType randomCount:self->leastNum_];
        }];
    }
    return _motionControl;
}

- (void)backToLotteryHall:(id)sender{
    
    
    NSString *errorMsg = nil;
    if (self.isFromOrder) {
        
        errorMsg = [NSString stringWithFormat:@"%@%@%@",L(@"Back"),self.title,L(@"Will clear all the selected number")];
    }else{
        
        errorMsg = L(@"Back lottery hall will clear all the selected number");
    }
    
    if (self.isFromOrder) {//来自于订单详情
        if ([self.welfare3DArray count] == 0) {
            //界面无选球
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    if ([self.lotteryList count]==0&&[self.welfare3DArray count] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:errorMsg customView:nil delegate:nil cancelButtonTitle:L(@"Cancel")  otherButtonTitles:L(@"Ok")];
    
    [alertView show];
    
    [alertView setConfirmBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}


//-(BOOL)checkBufferIsNull
//{
//    for (int i = zhiXuan; i <= zuLiuHeZhi ; i++) {
//        NSMutableArray *temp = [self.numberBufferDic objectForKey:[NSString stringWithFormat:@"%d",i]];
//        if ([temp count] > 0) {
//            return NO;
//        }
//    }
//    return YES;
//}

//-(void)makeBufferEmpty:(LotterySelectionType) type
//{
//    if (type == 0) {
//        //清空所有
//        TT_RELEASE_SAFELY(_numberBufferDic);
//    }else
//    {
//        for (int i = zhiXuan; i <= zuLiuHeZhi ; i++) {
//            if (i == type) {
//                continue;
//            }
//            NSMutableArray *temp = [self.numberBufferDic objectForKey:[NSString stringWithFormat:@"%d",i]];
//            [temp removeAllObjects];
//        }
//    }
//}

#pragma mark - AlertMessageViewDelegate
-(void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index{
    
    if (index == 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (Welfare3DTypeSelectView *)welfare3DTypeSelectView{
    
    if (!_welfare3DTypeSelectView) {
        
        _welfare3DTypeSelectView = [[Welfare3DTypeSelectView alloc] initWithFrame:CGRectMake(0, 45, 320, 60)];
        
        _welfare3DTypeSelectView.delegate = self;
    }
    
    return _welfare3DTypeSelectView;
}

- (void)didSelectWelfare3DTypeOK:(int)selectType{
    
    [self.ballSelectView removeFromSuperview];
    
    ballSelectType_ = selectType;
    
    [self.welfare3DArray removeAllObjects];
    switch (selectType) {
        case zhiXuan:
            self.selectTypeDesc.text = L(@"Each select at least one ball");
            leastNum_ = 1;
            ballCount = 30;
            minNum_ = 0;
            break;
        case zuSan:
            self.selectTypeDesc.text = L(@"Please select at least two balls");
            leastNum_ = 2;
            ballCount = 10;
            minNum_ = 0;
            break;
        case zuLiu:
            self.selectTypeDesc.text = L(@"Please select at least three balls");
            leastNum_ = 3;
            ballCount = 10;
            minNum_ = 0;
            break;
        case zhiXuanHeZhi:
            self.selectTypeDesc.text = L(@"Please select at least one balls");
            leastNum_ = 1;
            ballCount = 28;
            minNum_ = 0;
            break;
        case zuSanHeZhi:
            self.selectTypeDesc.text = L(@"Please select at least one balls");
            leastNum_ = 1;
            ballCount = 26;
            minNum_ = 1;
            break;
        case zuLiuHeZhi:
            self.selectTypeDesc.text = L(@"Please select at least one balls");
            ballCount = 22;
            leastNum_ = 1;
            minNum_ = 3;
            break;
        default:
            break;
    }
    
    [_ballSelectView reloadBallCount:ballCount minNumber:minNum_ BallType:selectType];
    
    //    NSMutableArray *tempBufferList = [self.numberBufferDic objectForKey:[NSString stringWithFormat:@"%d",ballSelectType_]];
    
    //    [self.ballSelectView randomChooseBall:tempBufferList];
    
    [self.welfare3DArray removeAllObjects];
    
    //    for (NSNumber *value in tempBufferList) {
    //        [self.welfare3DArray addObject:value];
    //    }
    
    [self.view addSubview:self.ballSelectView];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
}

- (UILabel *)selectTypeDesc{
    
    if (!_selectTypeDesc) {
        
        _selectTypeDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, self.welfare3DTypeSelectView.bottom, 320, 25)];
        
        _selectTypeDesc.backgroundColor = [UIColor clearColor];
        
        _selectTypeDesc.text = L(@"Each select at least one ball");
        
        _selectTypeDesc.textColor = RGBCOLOR(87, 87, 87);
        
        _selectTypeDesc.textAlignment = UITextAlignmentCenter;
    }
    
    return _selectTypeDesc;
}

#pragma mark -
#pragma mark Customize UI Methods

- (LotterySelectTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[LotterySelectTopView alloc] init];
        
       // _topView.backgroundColor = RGBACOLOR(255, 255, 255, 0.5);
        
    }
    
    return _topView;
}


- (Welfare3DBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[Welfare3DBottomView alloc] init];
        
        _bottomView.bottomDelegate = self;
        
    }
    return _bottomView;
}


-(Welfare3DBallChooseView *)ballSelectView{
    
    if (!_ballSelectView) {
        
        _ballSelectView  = [[Welfare3DBallChooseView alloc] init];
        
        _ballSelectView.frame = CGRectMake(0, self.selectTypeDesc.bottom, 320, 245);
        
        _ballSelectView.backgroundColor = [UIColor clearColor];
        
        _ballSelectView.autoresizingMask = UIViewAutoresizingNone;
        
        _ballSelectView.userInteractionEnabled = YES;
        
        _ballSelectView.tag = 200 ;
        
        [_ballSelectView setBallType:eRedBallType];
        
        _ballSelectView.welfare3DDelegate = self;
        
    }
    
    return _ballSelectView;
}


- (BOOL)ballSelect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType{
    
    NSMutableArray *arrayLsit = [self.welfare3DArray mutableCopy];
    
    //    NSMutableArray *bufferList = [self.numberBufferDic objectForKey:[NSString stringWithFormat:@"%d",ballType]];
    
    //    [bufferList addObject:[NSNumber numberWithInt:ballIndex -1]];
    
    [arrayLsit addObject:[NSNumber numberWithInt:ballIndex -1]];
    
    [LotteryDataModel sortFromLowToHigh:arrayLsit];
    
    NSString *errorDesc = [self valideRandomBalls:ballType withBallArray:arrayLsit];
    
    if (![errorDesc isEqualToString:@""]) {
        
        [self presentSheet:errorDesc];
        
        [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
        
        TT_RELEASE_SAFELY(arrayLsit);
        
        return NO;
    }
    
    self.welfare3DArray = arrayLsit;
    
    [LotteryDataModel sortFromLowToHigh:self.welfare3DArray];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
    
    return YES;
}


/*
 Notes：
 
 点击单个球，由选中状态变为非选中状态
 
 */
- (BOOL)ballUnselect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType{
    
    //    NSMutableArray *bufferList = [self.numberBufferDic objectForKey:[NSString stringWithFormat:@"%d",ballType]];
    
    //    [bufferList addObject:[NSNumber numberWithInt:ballIndex -1]];
    
    [LotteryDataModel deleteFromArray:self.welfare3DArray deletedElement:ballIndex-1];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
    return YES;
}

//-(NSMutableDictionary *)numberBufferDic
//{
//    if (!_numberBufferDic) {
//        _numberBufferDic = [[NSMutableDictionary alloc]init];
//
//
//        //字典中存在6个 tab的选号缓冲数组
//        for (int i = 0; i < 6; i++) {
//            NSMutableArray *tempBufferArray = [[NSMutableArray alloc]init];
//            [_numberBufferDic setObject:tempBufferArray forKey:[NSString stringWithFormat:@"%d",zhiXuan + i]];
//            TT_RELEASE_SAFELY(tempBufferArray);
//        }
//
//
//    }
//    return _numberBufferDic;
//}

#pragma mark - shake delegate
-(BOOL)canBecomeFirstResponder {
    
    return YES;
    
}

#pragma mark -
#pragma mark LotterSelectBallView Delegate Method

/*
 Notes：
 
 重新布局页面。
 */

- (void)resetBalls:(LotteryBallType)ballType{
    
    [self.ballSelectView randomChooseBall:self.welfare3DArray];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
}


/*
 Notes：
 
 清空当前选择
 */
-(void)reChoose{
    
    [self.welfare3DArray removeAllObjects];
    
    [self resetBalls:eRedBallType];
}



- (NSString *)valideRandomBalls:(LotteryBallType)ballType withBallArray:(NSMutableArray *)array{
    
    NSString *errorDesc = nil;
    
    [self.bottomView setResultChoice:array LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
    NSInteger ballSelectCount = [ComputeLotteryNumber  computeLotteryFC3DNumber:self.bottomView.resultStr ballType:ballSelectType_];
    
    if (ballSelectCount >[self.leftBetNo intValue]) {
        
        errorDesc = L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan");
        
        return errorDesc;
    }
    
    errorDesc = @"";
    
    return errorDesc;
    
}


- (void)submit:(NSString *)resultStr{
    
    [self valideRandomBalls:ballSelectType_ withBallArray:self.welfare3DArray];
    
    NSInteger resultCount = [ComputeLotteryNumber computeLotteryFC3DNumber:resultStr ballType:ballSelectType_];
    
    if (resultStr.trim.length == 0 || resultCount == 0) {
        
        if ([self.selectTypeDesc.text isEqualToString:L(@"One, ten, one hundred and value combinations Betting")]) {
            
            [self presentSheet:L(@"One, Ten, one hundred and value combination bets, at least choose one ball")];
        }else
        {
            [self presentSheet:self.selectTypeDesc.text];
        }
        
        return;
    }
    
    NSString *resultString = [NSString stringWithFormat:@"%@%d",resultStr,ballSelectType_];
    
    if (isEditing_ == YES) {
        
        [self.lotteryList replaceObjectAtIndex:editIndex_ withObject:resultString];
        
        isEditing_ = NO;
        
        editIndex_ = -1;
        
    }else{
        
        [self.lotteryList insertObject:resultString atIndex:0];
    }
    
    if (self.isFromOrder == YES) {
        
        for (UIViewController *ctrl in self.navigationController.viewControllers)
        {
            if ([ctrl isKindOfClass:[Welfare3DListViewController class]]) {
                
                Welfare3DListViewController  *tempctrl = (Welfare3DListViewController *) ctrl;
                
                tempctrl.lotteryList = self.lotteryList;
                
                tempctrl.isFromOrder = self.isFromOrder;
                
                tempctrl.selectBallType = ballSelectType_;
                
                tempctrl.multiNo = self.multiNo;
                
                tempctrl.period = self.period;
                
                tempctrl.delegate = self;
                
                [self.navigationController popViewControllerAnimated:YES];
                
                break;
            }
        }
        
        
        
    }else{
        
        Welfare3DListViewController *contoller = [[Welfare3DListViewController alloc] initWIthTitle:self.title andLotteryTimes:self.lotteryHallDTO.nowpid  andEndTime:self.lotteryHallDTO.nowendtime];
        
        contoller.lotteryList = self.lotteryList;
        
        contoller.isFromOrder = self.isFromOrder;
        
        contoller.selectBallType = ballSelectType_;
        
        contoller.multiNo = self.multiNo;
        
        contoller.period = self.period;
        
        contoller.delegate = self;
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back to Lottery hall")
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:nil
                                                                                action:nil];
        
        
        self.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:contoller animated:YES];
        
        TT_RELEASE_SAFELY(contoller);
    }
}

/*
 Notes：
 
 选择随机数
 
 */
- (BOOL)randomBallSelect:(LotteryBallType)ballType randomCount:(NSInteger)randomCount{
    
    if (ballSelectType_ == zhiXuan) {
        
        [self.welfare3DArray removeAllObjects];
        
        for (int i = 0; i < 3; i++) {
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            [LotteryDataModel getRandomArray:array randomNumCount:randomCount maxCount:ballCount/3];
            
            [self.welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:0] intValue] + i *10]];
            
        }
        
    }else{
        
        [LotteryDataModel getRandomArray:self.welfare3DArray randomNumCount:randomCount maxCount:ballCount];
    }
    
    NSString *errorDesc = [self valideRandomBalls:ballType withBallArray:self.welfare3DArray];
    
    if (![errorDesc isEqualToString:@""]) {
        
        [self presentSheet:errorDesc];
        
        [self.welfare3DArray removeAllObjects];
        
        [self.ballSelectView randomChooseBall:self.welfare3DArray];
        
        [LotteryDataModel sortFromLowToHigh:self.welfare3DArray];
        
        [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
        
        return NO;
    }
    
#ifdef DEBUGLOG
    
    for (NSNumber *value in self.welfare3DArray) {
        
        DLog(@"value is %d", [value intValue]);
        
    }
    
#endif
    
    //    NSMutableArray *bufferList = [self.numberBufferDic objectForKey:[NSString stringWithFormat:@"%d",ballSelectType_]];
    
    //    [bufferList removeAllObjects];
    
    //    for (NSNumber *value in self.welfare3DArray) {
    //        [bufferList addObject:value];
    //    }
    
    
    [self.ballSelectView randomChooseBall:self.welfare3DArray];
    
    [LotteryDataModel sortFromLowToHigh:self.welfare3DArray];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
    return YES;
    
}

/*
 Notes：
 
 彩票结果列表页面，修改彩票投注倍数时的Delegate方法；这样可以实时修改倍数，避免用户点击左上角返回按钮产生的问题
 
 */
-(void)returnUserChooseMulitNo:(NSString *)multiNo{
    
    self.multiNo = multiNo;
}

/*
 Notes：
 
 彩票结果列表页面，修改彩票结果行项目的Delegate方法
 
 */

- (void)returnUserEditLotteryCell:(NSMutableArray *)array andIndex:(NSInteger)index andMultiNo:(NSString *)multiNo andPeriods:(NSString *)period andOnlyCouldChooseMoney:(CGFloat)money{
    
    isEditing_ = YES;
    
    editIndex_ = index;
    
    self.multiNo = multiNo;
    
    self.period = period;
    
    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/[multiNo intValue]/[period integerValue]];
    
    DLog(@"%d", [self.lotteryList count]);
    
    //    [self makeBufferEmpty:ballSelectType_];
    
    NSString *resultString = [self.lotteryList objectAtIndex:index];
    
    ballSelectType_ = [[resultString substringWithRange:NSMakeRange([resultString length] - 3, 3)] intValue];
    
    [self.welfare3DArray removeAllObjects];
    
    NSString *ballString = [resultString substringWithRange:NSMakeRange(0, [resultString length] - 3)];
    
    switch (ballSelectType_) {
        case zhiXuan:{
            NSArray *array = [ballString componentsSeparatedByString:@" |"];
            
            for (int i = 0; i < [array count]; i ++ ) {
                
                NSString *bitsString = [array objectAtIndex:i];
                
                NSArray *bitArr = [bitsString componentsSeparatedByString:@" "];
                
                for (int j = 1 ; j < [bitArr count]; j ++) {
                    
                    [self.welfare3DArray addObject:[NSNumber numberWithInt:[[bitArr objectAtIndex:j] intValue] + 10*i]];
                    
                }
            }
            ballCount = 30;
            self.selectTypeDesc.text = L(@"Each select at least one ball");
            leastNum_ = 1;
            minNum_ = 0;
        }
            break;
        case zuSan:{
            
            NSArray *array = [ballString componentsSeparatedByString:@" "];
            
            for (int i = 1 ; i < [array count]; i ++) {
                
                [self.welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:i] intValue]]];
            }
            ballCount = 10;
            self.selectTypeDesc.text = L(@"Please select at least two balls");
            leastNum_ = 2;
            minNum_ = 0;
        }
            break;
        case zuLiu:{
            NSArray *array = [ballString componentsSeparatedByString:@" "];
            
            for (int i = 1 ; i < [array count]; i ++) {
                
                [self.welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:i] intValue]]];
            }
            ballCount = 10;
            self.selectTypeDesc.text = L(@"Please select at least three balls");
            leastNum_ = 3;
            minNum_ = 0;
        }
            break;
        case zhiXuanHeZhi:{
            NSArray *array = [ballString componentsSeparatedByString:@" "];
            
            for (int i = 1 ; i < [array count]; i ++) {
                
                [self.welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:i] intValue]]];
            }
            ballCount = 28;
            self.selectTypeDesc.text = L(@"Please select at least one balls");
            leastNum_ = 1;
            minNum_ = 0;
        }
            break;
        case zuSanHeZhi:{
            NSArray *array = [ballString componentsSeparatedByString:@" "];
            
            for (int i = 1 ; i < [array count]; i ++) {
                
                [self.welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:i] intValue] - 1]];
            }
            ballCount = 26;
            self.selectTypeDesc.text = L(@"Please select at least one balls");
            leastNum_ = 1;
            minNum_ = 1;
        }
            break;
        case zuLiuHeZhi:{
            NSArray *array = [ballString componentsSeparatedByString:@" "];
            
            for (int i = 1 ; i < [array count]; i ++) {
                
                [self.welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:i] intValue] - 3]];
            }
            ballCount = 22;
            self.selectTypeDesc.text = L(@"Please select at least one balls");
            leastNum_ = 1;
            minNum_ = 3;
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController popToViewController:self animated:YES];
    
    if (ballSelectType_ == zuLiuHeZhi) {
        minNum_ = 3;
    }else if(ballSelectType_ == zuSanHeZhi){
        minNum_ = 1;
    }else{
        minNum_ = 0;
    }
    
    [self.welfare3DTypeSelectView changeBallType:ballSelectType_];
    
    [self.ballSelectView reloadBallCount:ballCount minNumber:minNum_ BallType:ballSelectType_];
    
    [self.ballSelectView randomChooseBall:self.welfare3DArray];
    
    [self.bottomView setResultChoice:self.welfare3DArray LottertType:ballSelectType_ multiNo:self.multiNo period:self.period];
    
    
}

/*
 Notes：
 
 彩票结果列表页面，增加彩票结果行项目的Delegate方法
 */


- (void)returnUserAddLotteryCell:(NSMutableArray *)array andMultiNo:(NSString *)multiNo andPeriods:(NSString *)period andOnlyCouldChooseMoney:(CGFloat)money isAuto:(BOOL)isAuto{
    
    if (isAuto == NO) {
        
        isEditing_ = NO;
        
        editIndex_ = -1;
        
        isFromList_ = YES;
        
        self.multiNo = multiNo;
        
        self.period = period;
        
        self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/[multiNo intValue]/[period integerValue]];
        
        DLog(@"%@", self.leftBetNo);
        
        //        [self makeBufferEmpty:0];
        
        [self.welfare3DArray removeAllObjects];
        
        [self.navigationController popToViewController:self animated:YES];
        
        [self.ballSelectView randomChooseBall:self.welfare3DArray];
        
        [self didSelectWelfare3DTypeOK:ballSelectType_];
        DLog(@"ballSelectType_  ====  %d",ballSelectType_);
    }else
    {
        
        self.multiNo = multiNo;
        
        self.period = period;
    }
}

-(void)returnUserDeleteLotteryCell:(NSMutableArray *)array andMultiNo:(NSString *)multiNo andPeriods:(NSString *)period andOnlyCouldChooseMoney:(CGFloat)money{
    
    self.multiNo = multiNo;
    
    self.period = period;
    
    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/[multiNo intValue]/[period integerValue]];
    
}




@end
