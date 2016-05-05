//
//  LottertSelectViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-6-28.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LottertSelectViewController.h"
#import "LotteryDataModel.h"
#import "LotterySelectTopView.h"
#import <AudioToolbox/AudioServices.h>
#import "LotterySelectBottomView.h"
#import "SubmitLotteryDto.h"
#import "ComputeLotteryNumber.h"
#import "LotteryRuleViewController.h"
#import "LotteryMotionControl.h"

@interface LottertSelectViewController(){
    
    BOOL         isEditing_;
    
    BOOL         isFromList_;
    
    NSInteger    editIndex_;
    
    NSInteger    maxRedBallCount_;
    
    NSInteger    minRedBallCount_;
    
    NSInteger    maxBlueBallCount_;
    
    NSInteger    minBlueBallCount_;
    
    NSInteger    totalRedBallCount_;
    
    NSInteger    totalBlueBallCount_;
    
    //彩种
    LotteryType  lotteryType_;
    
}

@property(nonatomic,strong)UITableView  *lotteryTableView;
//选中的红球列表
@property(nonatomic,strong)NSMutableArray         *redBallArray;
//选中的蓝球列表
@property(nonatomic,strong)NSMutableArray         *blueBallArray;

@property(nonatomic,strong)LotterySelectTopView    *topView;

@property(nonatomic,strong)LotterySelectBottomView  *bottomView;

@property(nonatomic,strong)LotterySelectBallView  *redBallView;

@property(nonatomic,strong)LotterySelectBallView  *blueBallView;

/** motionControl */
@property (nonatomic, strong) LotteryMotionControl *motionControl;
//将选球页面全部置空
- (void)resetBalls:(LotteryBallType)ballType;
- (void)setSelectedCountText;


/*
 验证是否当前选球符合要求
 （1）不能大于2000元的金额
 （2）红球，蓝球的个数不正确
 */
- (NSString *)valideSelectBalls:(LotteryBallType)ballType;
- (NSString *)valideUnSelectBalls:(LotteryBallType)ballType;
- (NSString *)valideRandomBalls:(LotteryBallType)ballType randomCount:(NSInteger)count;
- (NSString *)valideSubmitBalls;

@end

@implementation LottertSelectViewController
@synthesize lotteryTableView = _lotteryTableView;
@synthesize redBallArray = _redBallArray;
@synthesize blueBallArray = _blueBallArray;
@synthesize lotteryList = _lotteryList;

@synthesize topView = _topView;
@synthesize redBallView = _redBallView;
@synthesize blueBallView = _blueBallView;
@synthesize bottomView = _bottomView;
@synthesize lotteryHallDTO = _lotteryHallDTO;
@synthesize submitList = _submitList;
@synthesize isFromOrder = _isFromOrder;
@synthesize multiNo = _multiNo;
@synthesize leftBetNo = _leftBetNo;

- (void)dealloc {
    
    [_motionControl stop];
}


- (id)init {
    
    self = [super init];
    
    if (self) {
        if (IOS7_OR_LATER)
        {
            self.edgesForExtendedLayout = UIRectEdgeBottom;
            self.iOS7FullScreenLayout = NO;
        }
        self.isLotteryController = YES;
        _redBallArray  =  [[NSMutableArray alloc] init];
        
        _blueBallArray = [[NSMutableArray alloc] init];
        
        isEditing_ = NO;
        
        _isFromOrder = NO;
        
        isFromList_ = NO;
        
        editIndex_ = -1;
        
        self.multiNo = 1;
        
        self.periods = 1;
        
        self.leftBetNo = @"1000";
        
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setBackgroundImage:[UIImage imageNamed:@"lottery_help"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(showGameRule:) forControlEvents:UIControlEventTouchUpInside];
        
        button.enabled = YES;
        
        button.frame =  CGRectMake(0, 0, 45,32);
        
        button.backgroundColor = [UIColor clearColor];
        
        UIBarButtonItem *ruleButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        self.navigationItem.rightBarButtonItem = ruleButton;
        
        TT_RELEASE_SAFELY(ruleButton);
        
    }
    
    return self;
    
}

- (void)showGameRule:(id)sender{
    
    LotteryRuleViewController *controller = [[LotteryRuleViewController alloc] init];
    
    controller.lotteryType = lotteryType_;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = L(@"returnTo_myEuy");
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
    
}

- (void)backForePage {
    //[super backForePage];
    [self backToLotteryHall:nil];
}

- (LotteryMotionControl *)motionControl
{
    if (!_motionControl) {
        _motionControl = [[LotteryMotionControl alloc] init];
        
        @weakify(self);
        [_motionControl setEventHandler:^{
            
            @strongify(self);
            //机选号码
            [self  randomBallSelect:eRedBallType randomCount:self->minRedBallCount_];
            
            [self  randomBallSelect:eBlueBallType randomCount:self->minBlueBallCount_];
        }];
    }
    return _motionControl;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
//    backButton.backgroundColor = [UIColor clearColor];
//    [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
//    backButton.tag = 9777;
//    
//    UIWindow *window = [AppDelegate currentAppDelegate].window;
//    [window addSubview:backButton];
//    TT_RELEASE_SAFELY(backButton);
    
    self.lotteryTableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 42);
    
    self.topView.frame = CGRectMake(0, 0, 320, 40);
    
    //    self.bottomView.frame = CGRectMake(0, self.lotteryTableView.bottom, 320, 40);
    self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-42, 320, 42);
    
    [self.motionControl start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    [self.motionControl stop];
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    [[window viewWithTag:9777] removeFromSuperview];
    
    [[window viewWithTag:4008365] removeFromSuperview];
    
    [self removeBallCountView];
}

- (void)removeBallCountView
{
    UITableViewCell *redCell = [self.lotteryTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    LotterySelectBallView *redBallView = (LotterySelectBallView *)[redCell viewWithTag:200];
    
    [redBallView removeView];
    
    UITableViewCell *blueCell = [self.lotteryTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    LotterySelectBallView *blueBallView = (LotterySelectBallView *)[blueCell viewWithTag:201];
    
    [blueBallView removeView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:NO];
    
    [self becomeFirstResponder];
    
    [self resetBalls:eRedBallType];
    
    [self resetBalls:eBlueBallType];
    
}

- (void)backToLotteryHall:(id)sender{
    
    NSString *errorMsg = nil;
    if (self.isFromOrder) {
        
        errorMsg = [NSString stringWithFormat:@"%@%@%@",L(@"Back"),self.title,L(@"Will clear all the selected number")];
    }else{
        
        errorMsg = L(@"Back lottery hall will clear all the selected number");
    }
    
    if (self.isFromOrder) {//来自于订单详情
        if ([self.redBallArray count] == 0 && [self.blueBallArray count] == 0) {
            //界面无选球
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    if ([self.redBallArray count] == 0 && [self.blueBallArray count] == 0 &&[self.lotteryList count] == 0) {
        //界面无选球 列表无需选球
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:errorMsg customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    
    UINavigationController *__weak nav = self.navigationController;
    [alertView setConfirmBlock:^{
        [nav popViewControllerAnimated:YES];
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


-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:NO];
    
}

-(void)loadView{
    
    [super loadView];
    
    if (self.isFromOrder == NO) {
        
        _lotteryList = [[NSMutableArray alloc] init];
    }
    
    switch ([self.lotteryHallDTO.gid intValue]) {
            
        case 1:{
            
            self.title = L(@"DoubleColor ball");
            
            lotteryType_ = eColorBall;
            
            maxRedBallCount_ = 12;
            
            minRedBallCount_ = 6;
            
            maxBlueBallCount_ = 16;
            
            minBlueBallCount_ = 1;
            
            totalRedBallCount_ = 33;
            
            totalBlueBallCount_ = 16;
            
            self.bottomView.ballType = eColorBall;
            
        }
            
            break;
            
        case 50:{
            
            self.title = L(@"BigLotto");
            
            lotteryType_ = eBigLottery;
            
            maxRedBallCount_ = 12;
            
            minRedBallCount_ = 5;
            
            maxBlueBallCount_ = 12;
            
            minBlueBallCount_ = 2;
            
            totalRedBallCount_ = 35;
            
            totalBlueBallCount_ = 12;
            
            self.bottomView.ballType = eBigLottery;
        }
            break;
            
        default:
            break;
    }
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
    
    self.view.clipsToBounds = YES;
    
    [self.view addSubview:self.lotteryTableView];
    
   
    DLog(@"%f  %f",self.lotteryTableView.bottom,self.view.bounds.size.height);
    
    [self.view addSubview:self.bottomView];
    
    [self.topView setLabelsInfo:self.lotteryHallDTO];
    
}

#pragma mark -
#pragma mark Catch Phone shaking  Method


/*
 
 Notes：
 
 加速计实现摇一摇机选一注
 
 */

-(BOOL)canBecomeFirstResponder {
    
    return YES;
    
}

#pragma mark -
#pragma mark LotterSelectBallView Delegate Method

/*
 Notes：
 
 根据redBallArray，blueBallArray重新布局页面。
 
 */

- (void)resetBalls:(LotteryBallType)ballType{
    
    UITableViewCell *cell = [self.lotteryTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ballType inSection:0]];
    LotterySelectBallView *ballView = (LotterySelectBallView *)[cell viewWithTag:200 +ballType];
    
    if (ballType == eRedBallType) {
        
        [ballView randomChooseBall:self.redBallArray];
        
        [ballView setSelectedCountText:[self.redBallArray count]];
        
    }else{
        
        
        [ballView randomChooseBall:self.blueBallArray];
        
        [ballView setSelectedCountText:[self.blueBallArray count]];
        
        
    }
    
    
    [self.bottomView setResultChoice:self.blueBallArray redArr:self.redBallArray LottertType:eColorBall multiNo:self.multiNo periods:self.periods];
    
    [self setSelectedCountText];
    
}



- (void)setSelectedCountText{
    
    UITableViewCell *cell = [self.lotteryTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    LotterySelectBallView *redBallView = (LotterySelectBallView *)[cell viewWithTag:200];
    
    [redBallView setSelectedCountText:[self.redBallArray count]];
    
    UITableViewCell *blueCell = [self.lotteryTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    LotterySelectBallView *blueBallView = (LotterySelectBallView *)[blueCell viewWithTag:201];
    
    [blueBallView setSelectedCountText:[self.blueBallArray count]];
    
}


- (BOOL)ballSelect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType{
    
    NSString *errorDesc = nil;
    
    errorDesc = [self valideSelectBalls:ballType];
    
    if (![errorDesc isEqualToString:@""]) {
        
        [self presentSheet:errorDesc];
        
        return NO;
        
    }
    
    
    if (ballType == eRedBallType) {
        
        errorDesc = [self valideRandomBalls:ballType randomCount:[self.redBallArray count]+1];
        
        if (![errorDesc isEqualToString:@""]) {
            
            [self presentSheet:errorDesc];
            
            return NO;
        }
        
        
        [self.redBallArray addObject:[NSNumber numberWithInt:ballIndex -1]];
        
        [LotteryDataModel sortFromLowToHigh:self.redBallArray];
        
    }else{
        
        errorDesc = [self valideRandomBalls:ballType randomCount:[self.blueBallArray count]+1];
        
        if (![errorDesc isEqualToString:@""]) {
            
            [self presentSheet:errorDesc];
            
            return NO;
        }
        
        
        [self.blueBallArray addObject:[NSNumber numberWithInt:ballIndex -1]];
        
        [LotteryDataModel sortFromLowToHigh:self.blueBallArray];
        
    }
    
    [self.bottomView setResultChoice:self.blueBallArray redArr:self.redBallArray LottertType:eColorBall multiNo:self.multiNo  periods:self.periods];
    
    [self setSelectedCountText];
    
    return YES;
}


/*
 Notes：
 
 点击单个球，由选中状态变为非选中状态
 
 */
- (BOOL)ballUnselect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType{
    
    //    NSString *errorDesc = [self valideUnSelectBalls:ballType];
    //
    //    if ( ![errorDesc isEqualToString:@""]) {
    //
    //        [self presentSheet:errorDesc];
    //
    //        return NO;
    //
    //    }
    
    if (ballType == eRedBallType) {
        
        [LotteryDataModel deleteFromArray:self.redBallArray deletedElement:ballIndex-1];
        
    }else{
        
        [LotteryDataModel deleteFromArray:self.blueBallArray deletedElement:ballIndex-1];
    }
    
    [self.bottomView setResultChoice:self.blueBallArray redArr:self.redBallArray LottertType:eColorBall multiNo:self.multiNo  periods:self.periods];
    
    [self setSelectedCountText];
    
    return YES;
}

/*
 Notes：
 
 点击选择随机数
 
 */
- (BOOL)randomBallSelect:(LotteryBallType)ballType randomCount:(NSInteger)randomCount{
    
    NSString *errorDesc = [self valideRandomBalls:ballType randomCount:randomCount];
    
    if (![errorDesc isEqualToString:@""]) {
        
        [self presentSheet:errorDesc];
        
        return NO;
    }
    
    
    UITableViewCell *cell = [self.lotteryTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ballType inSection:0]];
    
    LotterySelectBallView *ballView = (LotterySelectBallView *)[cell viewWithTag:200 +ballType];
    
    if (ballType == eRedBallType) {
        
        [LotteryDataModel getRandomArray:self.redBallArray randomNumCount:randomCount maxCount:totalRedBallCount_];
        
#ifdef DEBUGLOG
        
        for (NSNumber *value in self.redBallArray) {
            
            DLog(@"value is %d", [value intValue]);
            
        }
#endif
        
        [ballView randomChooseBall:self.redBallArray];
        
        [LotteryDataModel sortFromLowToHigh:self.redBallArray];
        
        
    }else{
        
        [LotteryDataModel getRandomArray:self.blueBallArray randomNumCount:randomCount maxCount:totalBlueBallCount_];
#ifdef DEBUGLOG
        
        for (NSNumber *value in self.blueBallArray) {
            
            DLog(@"value is %d", [value intValue]);
            
        }
        
#endif
        
        
        [ballView randomChooseBall:self.blueBallArray];
        
        [LotteryDataModel sortFromLowToHigh:self.blueBallArray];
        
    }
    
    [self.bottomView setResultChoice:self.blueBallArray redArr:self.redBallArray LottertType:eColorBall multiNo:self.multiNo  periods:self.periods];
    
    [self setSelectedCountText];
    
    return YES;
    
}

/*
 
 Notes：
 点击选择随机数个数
 
 */
- (BOOL)ballCountSelect:(LotteryBallType)ballType ballNumCount:(NSInteger)ballCount{
    
    return  [self randomBallSelect:ballType randomCount:ballCount];
    
}

- (NSString *)valideSelectBalls:(LotteryBallType)ballType{
    
    NSString *errorDesc = nil;
    
    switch (ballType) {
        case eRedBallType:{
            
            if ([self.redBallArray count] > 0) {
                
                if ([self.redBallArray count] >= maxRedBallCount_) {
                    
                    errorDesc = [NSString stringWithFormat:L(@"the max red ball number is %d"),maxRedBallCount_];
                    
                    return errorDesc;
                    
                }
                
            }
        }
            
            break;
            
        case eBlueBallType:{
            
            if ([self.blueBallArray count] > 0) {
                
                if ([self.blueBallArray count]>=maxBlueBallCount_) {
                    
                    errorDesc = [NSString stringWithFormat:@"%@%d%@。",L(@"The number of blue balls can only have a maximum of"),maxBlueBallCount_,L(@"Number")];
                    
                    return errorDesc;
                }
                
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
    errorDesc = @"";
    
    return errorDesc;
    
}

- (NSString *)valideUnSelectBalls:(LotteryBallType)ballType{
    
    NSString *errorDesc = nil;
    
    switch (ballType) {
        case eRedBallType:{
            
            if ([self.redBallArray count] > 0) {
                
                if ([self.redBallArray count] <= minRedBallCount_) {
                    
                    errorDesc = [NSString stringWithFormat:@"%@%d%@",L(@"At least the number of red balls"),minRedBallCount_,L(@"Number")];
                    
                    return errorDesc;
                    
                }
                
            }
        }
            
            break;
            
        case eBlueBallType:{
            
            if ([self.blueBallArray count] > 0) {
                
                if ([self.blueBallArray count]<=minBlueBallCount_) {
                    
                    errorDesc = [NSString stringWithFormat:@"%@%d%@。",L(@"At least the number of blue balls"),minBlueBallCount_,L(@"Number")];
                    
                    return errorDesc;
                    
                }
                
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
    errorDesc = @"";
    
    return errorDesc;
    
}



- (NSString *)valideRandomBalls:(LotteryBallType)ballType randomCount:(NSInteger)count{
    
    NSString *errorDesc = nil;
    
    switch (ballType) {
            
        case eRedBallType:{
            
            NSInteger redCout = [ComputeLotteryNumber  arrangement:count andSmallNo:minRedBallCount_];
            
            NSInteger  blueCount = 0;
            
            if (self.blueBallArray != nil) {
                
                blueCount = [ComputeLotteryNumber  arrangement:[self.blueBallArray count] andSmallNo:minBlueBallCount_];
            }
            
            int totalCount = blueCount * redCout;
            totalCount = totalCount+_listNumber;//订单列表的单倍单期投注注数和新投注的注数之和
            if (totalCount*self.multiNo*self.periods  >[self.leftBetNo intValue]) {
                
                errorDesc = L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan");
                
                return errorDesc;
                
            }
            
        }
            
            break;
            
        case eBlueBallType:{
            
            NSInteger blueCount = [ComputeLotteryNumber  arrangement:count andSmallNo:minBlueBallCount_];
            
            NSInteger  redCount = 0;
            
            if (self.redBallArray != nil) {
                
                redCount = [ComputeLotteryNumber  arrangement:[self.redBallArray count] andSmallNo:minRedBallCount_];
            }
            
            int totalCount = blueCount * redCount;//订单列表的单倍单期投注注数和新投注的注数之和
            totalCount = totalCount+_listNumber;
            
            if (totalCount*self.multiNo*self.periods >[self.leftBetNo intValue]) {
                
                errorDesc = L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan");
                
                return errorDesc;
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
    errorDesc = @"";
    
    return errorDesc;
    
}

- (NSString *)valideSubmitBalls{
    
    NSString *errorDesc = nil;
    
    NSInteger blueCout = 0;
    
    if (self.blueBallArray != nil) {
        
        blueCout =  [ComputeLotteryNumber  arrangement:[self.blueBallArray count] andSmallNo:minBlueBallCount_];
    }
    
    NSInteger redCout = 0;
    
    if (self.redBallArray != nil) {
        
        redCout = [ComputeLotteryNumber  arrangement:[self.redBallArray count] andSmallNo:minRedBallCount_];
        
    }
    
    if (redCout*blueCout == 0) {
        
        errorDesc = [NSString stringWithFormat:@"%@%d%@%d%@",L(@"Please select at least"),minRedBallCount_,L(@"Number of red ball and"),minBlueBallCount_,L(@"Number of blue ball")];
        
        return errorDesc;
    }
    
    int totalCount = redCout * blueCout;
    totalCount = totalCount+_listNumber;//订单列表的投注注数和新投注的注数之和
    
    if (totalCount*self.multiNo*self.periods >[self.leftBetNo intValue]) {
        
        errorDesc = L(@"Sorry, the amount of each purchase lottery shall not be more than 2000 yuan");
        
        return errorDesc;
        
    }
    
    errorDesc = @"";
    
    return errorDesc;
    
}



#pragma mark -
#pragma mark Table View Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(0, 0, 320, 40);
    
    view.backgroundColor = [UIColor clearColor];
    
    return view;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
	NSInteger row = [indexPath row];
    
	if (row == 0)
    {
        
        static NSString *tableViewCellIdentifier = @"BallCell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.height =  [LotterySelectBallView height:totalRedBallCount_] + 20;
            
        }
        
        DLog(@"cell height is %f", cell.frame.size.height) ;
        
        LotterySelectBallView *ballView = (LotterySelectBallView *)[cell viewWithTag:200+row];
        
        if (ballView == nil) {
            
            LotterySelectBallView *redBallView = [[LotterySelectBallView alloc] initWithBallCount:totalRedBallCount_ minNumber:minRedBallCount_ maxNumber:maxRedBallCount_];
            
            redBallView.frame = CGRectMake(0, 0, 320, cell.height-20);
            
            redBallView.backgroundColor = [UIColor clearColor];
            
            redBallView.autoresizingMask = UIViewAutoresizingNone;
            
            redBallView.userInteractionEnabled = YES;
            
            redBallView.tag = 200 + row;
            
            redBallView.ballSelectDelegate = self;
            
            [redBallView setBallType:eRedBallType];
            
            //            UIImage *image = [[UIImage imageNamed:@"library_shelf.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            //
            //            UIImageView *view = [[UIImageView alloc] initWithImage:image];
            //
            //            view.frame = CGRectMake(0, 0, 320, cell.height);
            //
            //            [view addSubview:redBallView];
            //
            //            view.userInteractionEnabled = YES;
            
            [redBallView randomChooseBall:self.redBallArray];
            
            [redBallView setSelectedCountText:[self.redBallArray count]];
            
            
            //
            [cell.contentView addSubview:redBallView];
            
            
            //
            //            TT_RELEASE_SAFELY(view);
            
            TT_RELEASE_SAFELY(redBallView);
            
        }
        
        return cell;
        
	}else {
        
        static NSString *tableViewCellIdentifier = @"BallCell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.height =  [LotterySelectBallView height:totalBlueBallCount_] + 20;
        }
        
        DLog(@"cell height is %f", cell.frame.size.height) ;
        
        LotterySelectBallView *ballView = (LotterySelectBallView *)[cell viewWithTag:200+row];
        
        if (ballView == nil) {
            
            LotterySelectBallView *blueBallView = [[LotterySelectBallView alloc] initWithBallCount:totalBlueBallCount_ minNumber:minBlueBallCount_ maxNumber:maxBlueBallCount_];
            
            blueBallView.tag = 200 + row;
            
            blueBallView.frame = CGRectMake(0, 0, 320, cell.height -20);
            
            blueBallView.userInteractionEnabled = YES;
            
            blueBallView.ballSelectDelegate = self;
            
            [blueBallView setBallType:eBlueBallType];
            
            [blueBallView randomChooseBall:self.blueBallArray];
            
            [blueBallView setSelectedCountText:[self.blueBallArray count]];
            
            
            //            UIImage *image = [[UIImage imageNamed:@"library_shelf.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            //
            //            UIImageView *view = [[UIImageView alloc] initWithImage:image];
            //
            //            view.frame = CGRectMake(0, 0, 320, cell.height);
            //
            //            [view addSubview:blueBallView];
            //
            //            view.userInteractionEnabled = YES;
            //
            [cell.contentView addSubview:blueBallView];
            
            
            //
            //            TT_RELEASE_SAFELY(view);
            
            TT_RELEASE_SAFELY(blueBallView);
            
        }
        
        return cell;
        
	}
    
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //add separate line
//    UIImageView *separatorLine = (UIImageView *)[cell.contentView viewWithTag:9876];
//
//    if (separatorLine == nil)
//    {
//        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.contentView.bottom-1, 320, 2)];
//
//        separatorLine.tag = 9876;
//
//        separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
//
//        [cell.contentView addSubview:separatorLine];
//
//        TT_RELEASE_SAFELY(separatorLine);
//    }
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
	
    if (row == 0) {
        
        return [LotterySelectBallView height:totalRedBallCount_];
        
    }else{
        
        DLog(@"cell height is %f",  [LotterySelectBallView height:totalBlueBallCount_]);
        
        return[LotterySelectBallView height:totalBlueBallCount_];
        
    }
    
}

#pragma mark -
#pragma mark LotteryListViewController Methods  彩票结果列表页面交互

/*
 Notes：
 
 提交了彩票选择的结果至结果列表。
 
 resultStr：“01 02 11 15 23 24 | 07”的形式的结果。
 
 */

-(void)submit:(NSString *)resultStr{
    
    NSString *errorDesc = [self valideSubmitBalls];
    
    if (![errorDesc isEqualToString:@""]) {
        
        [self presentSheet:errorDesc];
        
        return;
    }
    
    if (isEditing_ == YES) {
        
        [self.lotteryList replaceObjectAtIndex:editIndex_ withObject:resultStr];
        
        isEditing_ = NO;
        
        editIndex_ = -1;
        
    }else{
        
        [self.lotteryList insertObject:resultStr atIndex:0];
        
    }
    
    if (self.isFromOrder == YES) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        LotteryListViewController *contoller = [[LotteryListViewController alloc] initWIthTitle:self.title andLotteryTimes:self.lotteryHallDTO.nowpid  andEndTime:self.lotteryHallDTO.nowendtime];
        
        contoller.lotteryList = self.lotteryList;
        
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
    
    [self.redBallArray removeAllObjects];
    
    [self.blueBallArray removeAllObjects];
    
    [self resetBalls:eRedBallType];
    
    [self resetBalls:eBlueBallType];
    
}

/*
 Notes：
 
 彩票结果列表页面，修改彩票投注倍数时的Delegate方法；这样可以实时修改倍数，避免用户点击左上角返回按钮产生的问题
 
 */
-(void)returnUserChooseMulitNo:(int)multiNo
{
    
    self.multiNo = multiNo;
}

/*
 Notes：
 
 彩票结果列表页面，修改彩票追号期数时的Delegate方法；这样可以实时修改追号期数数
 
 */

-(void)returnUserChoosePeriods:(int)periods
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

- (void)returnUserEditLotteryCell:(NSMutableArray *)array andIndex:(NSInteger)index andMultiNo:(int)multiNo periods:(int)periods   andOnlyCouldChooseMoney:(CGFloat)money{
    
    isEditing_ = YES;
    
    editIndex_ = index;
    
    self.multiNo = multiNo;
    
    self.periods = periods;
    
    //    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/[multiNo intValue]];
    
    DLog(@"%d", [self.lotteryList count]);
    
    NSString *resultString = [self.lotteryList objectAtIndex:index];
    
    NSArray *arr =  [resultString componentsSeparatedByString:@" | "];
    
    [self.redBallArray removeAllObjects];
    
    NSString *redString = [arr objectAtIndex:0];
    
    NSArray *redArr = [redString componentsSeparatedByString:@" "];
    
    if ([redArr count] > 0) {
        
        for (NSString *str in redArr) {
            
            [self.redBallArray addObject:[NSNumber numberWithInt:[str intValue]-1]];
            
        }
        
    }
    
    
    
    NSString *blueString = [arr objectAtIndex:1];
    
    NSArray *blueArr = [blueString componentsSeparatedByString:@" "];
    
    [self.blueBallArray removeAllObjects];
    
    if ([blueArr count] > 0) {
        
        for (NSString *str in blueArr) {
            
            [self.blueBallArray addObject:[NSNumber numberWithInt:[str intValue]-1]];
        }
    }
    
    NSInteger blueCout = 0;
    
    if (self.blueBallArray != nil) {
        
        blueCout =  [ComputeLotteryNumber  arrangement:[self.blueBallArray count] andSmallNo:minBlueBallCount_];
    }
    
    NSInteger redCout = 0;
    
    if (self.redBallArray != nil) {
        
        redCout = [ComputeLotteryNumber  arrangement:[self.redBallArray count] andSmallNo:minRedBallCount_];
        
    }
    
    _listNumber = _listNumber - redCout*blueCout;
    
    _listNumber = _listNumber < 0 ? 0 : _listNumber;
    
    [self resetBalls:eRedBallType];
    
    [self resetBalls:eBlueBallType];
    
    if (self.isFromOrder == YES) {
        
        //        [self resetBalls:eRedBallType];
        //
        //        [self resetBalls:eBlueBallType];
        
        [self.lotteryTableView reloadData];
        
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
    
    //    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/multiNo/periods];
    
    isFromList_ = YES;
    
    DLog(@"%@", self.leftBetNo);
    
    [self.redBallArray removeAllObjects];
    
    [self.blueBallArray removeAllObjects];
    
    [self resetBalls:eRedBallType];
    
    [self resetBalls:eBlueBallType];
    
    [self.navigationController popToViewController:self animated:YES];
    
}

-(void)returnUserDeleteLotteryCell:(NSMutableArray *)array andMultiNo:(int)multiNo periods:(int)periods andOnlyCouldChooseMoney:(CGFloat)money{
    
    self.multiNo = multiNo;
    
    self.periods = periods;
    
    //    self.leftBetNo = [NSString stringWithFormat:@"%d",(int)money/2/multiNo/periods];
    
}

#pragma mark -
#pragma mark Customize UI Methods

- (LotterySelectTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[LotterySelectTopView alloc] init];
        
        //        _topView.backgroundColor = RGBACOLOR(255, 255, 255, 0.5);
        
        [self.view addSubview:_topView];
        
    }
    
    return _topView;
}

- (LotterySelectBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[LotterySelectBottomView alloc] init];
        
        _bottomView.bottomDelegate = self;
        
        //        [self.view addSubview:_bottomView];
    }
    
    return _bottomView;
    
}

- (UITableView *)lotteryTableView{
    
    if(!_lotteryTableView){
		
        _lotteryTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
		
		[_lotteryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_lotteryTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_lotteryTableView.scrollEnabled = YES;
		
		_lotteryTableView.userInteractionEnabled = YES;
		
		_lotteryTableView.delegate =self;
		
		_lotteryTableView.dataSource =self;
		
		_lotteryTableView.backgroundColor =[UIColor whiteColor];
        
	}
	
	return _lotteryTableView;
    
}


@end
