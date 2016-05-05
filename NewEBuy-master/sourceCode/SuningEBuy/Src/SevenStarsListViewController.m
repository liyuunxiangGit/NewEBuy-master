//
//  SevenStarsListViewController.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenStarsListViewController.h"
#import "SevenStarsSelectViewController.h"
#import "LotteryHallViewController.h"
#import "LotteryPayPlugin.h"
#import "ConfirmBetInfoAndCouponViewController.h"

@implementation SevenStarsListViewController

@synthesize lotteryList;
@synthesize lotteryhallDto;
@synthesize submitLotteryDto = _submitLotteryDto;
@synthesize topView = _topView;
@synthesize endline = _endline;
@synthesize tableContainerView = _tableContainerView;
@synthesize delegate;
@synthesize listFootView = _listFootView;
@synthesize isBuyWhenWin;
@synthesize multiNo;
@synthesize isChecked;
@synthesize isFromOrder;

-(void)dealloc
{
    
    TT_RELEASE_SAFELY(lotteryList);
    TT_RELEASE_SAFELY(lotteryhallDto);
    TT_RELEASE_SAFELY(_submitLotteryDto);
    TT_RELEASE_SAFELY(_listFootView);
    TT_RELEASE_SAFELY(_endline);
    TT_RELEASE_SAFELY(_tableContainerView);
    TT_RELEASE_SAFELY(multiNo);
    TT_RELEASE_SAFELY(_totalLottery);
    TT_RELEASE_SAFELY(_totalMoney);
    TT_RELEASE_SAFELY(_periods);
    TT_RELEASE_SAFELY(_topView);
    TT_RELEASE_SAFELY(_ballInfoArray);
    SERVICE_RELEASE_SAFELY(_couponService);

    [LotteryPayPlugin cancelPay];
    
}

- (id)initWithLotteryTimes:(NSString *)lotteryTimes andEndTime:(NSString *)endTime
{
    
    self = [super init];
    
    if (self) {
        self.bSupportPanUI = NO;
        self.isLotteryController = YES;
        self.title = [NSString stringWithFormat:@"%@%@",L(@"SevenStars"),L(@"List")];
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),[NSString stringWithFormat:@"%@%@",L(@"SevenStars"),L(@"ListY")]];
        self.submitLotteryDto.productTimes = lotteryTimes;
        self.submitLotteryDto.productName = L(@"SevenStars");
        self.submitLotteryDto.gid = @"51";
        if ([endTime length] > 16) {
            self.submitLotteryDto.endTime = [endTime substringToIndex:16];
        }
        self.isBuyWhenWin = NO;
        self.isChecked = YES;
        self.isFromOrder = NO;
    }
    return self;
}

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

-(SubmitLotteryDto *)submitLotteryDto
{
    if (!_submitLotteryDto) {
        _submitLotteryDto = [[SubmitLotteryDto alloc]init];
    }
    return _submitLotteryDto;
}



-(UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
        //if (IOS7_OR_LATER)
        //{
            imageView.backgroundColor = [UIColor uiviewBackGroundColor];
        //}
//        else
//        imageView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
        
        [_topView addSubview:imageView];
        
        
        _topView.backgroundColor = [UIColor clearColor];
        
        [_topView addSubview:self.endline];
    }
    return _topView;
}

-(UILabel *)endline
{
    if (!_endline) {
        
        _endline = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 35)];
        
        _endline.backgroundColor = [UIColor clearColor];
        
        _endline.textAlignment = UITextAlignmentCenter;
        
        _endline.font = [UIFont systemFontOfSize:14.0];
        
        NSString *endTime = [self.submitLotteryDto.endTime substringWithRange:NSMakeRange(0, 16)];
        
        _endline.text = [NSString stringWithFormat:@"%@%@ %@",self.submitLotteryDto.productTimes,L(@"Period EndTime"),endTime];
        
        _endline.textColor = [UIColor darkGrownColor];
    }
    return _endline;
}


-(LotteryListFootView *)listFootView
{
    if (!_listFootView) {
      
        _listFootView = [[LotteryListFootView alloc]initWithYOrigin:self.view.height - LOTTERY_LIST_FOOT_VIEW_HEIGHT - 44];//减去导航条高度
        [_listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];
        _listFootView.delegate = self;
    }
    return _listFootView;
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


#pragma mark - lifeCycle of view
-(void)loadView
{
    [super loadView];
    
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.topView];
//    if (!IOS7_OR_LATER)
//    {
//        
//        CGRect frame = CGRectMake(0,-200,310,self.view.height + 200 - 44- 40 - 140);
//        self.tableView.frame = frame;
//    }
//    else
//    {
//        self.tableView.backgroundColor = [UIColor whiteColor];
//        self.tableView.separatorInset = UIEdgeInsetsZero;
//        
//    }
//    
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
//    
//    if (!IOS7_OR_LATER)
//    {
//        [self.tableContainerView addSubview:self.tableView];
//        
//        [self.view addSubview:self.tableContainerView];
//    }
//    else
//    {
//        
//    }
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (IOS7_OR_LATER)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.listFootView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.topView.frame = CGRectMake(0, 0, 320, 70);
    self.listFootView.frame = CGRectMake(0, self.view.bounds.size.height - LOTTERY_LIST_FOOT_VIEW_HEIGHT, 320, LOTTERY_LIST_FOOT_VIEW_HEIGHT);
    self.tableView.frame = CGRectMake(0, 40, 320, self.view.bounds.size.height - self.listFootView.frame.size.height - 40);
    
    [self.tableView reloadData];
    
    //得到所有注数 赋值给self.totallottery
    [self getAllCellLotteryCount];
    
    [self.listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];
    //修改按钮提示字
//    [self setItemTitle];
    if (isFromOrder == YES) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backToLotteryDetail:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = 9666;
        
        UIWindow *window = [AppDelegate currentAppDelegate].window;
        [window addSubview:backButton];
        TT_RELEASE_SAFELY(backButton);
    }else
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backToLotteryHall:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = 9666;
        
        UIWindow *window = [AppDelegate currentAppDelegate].window;
        [window addSubview:backButton];
        TT_RELEASE_SAFELY(backButton);
    }
    self.title = [NSString stringWithFormat:@"%@%@",L(@"SevenStars"),L(@"List")];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    for (UIView *view in window.subviews) {
        
        if (view.tag == 9777||view.tag == 9666) {
            
            [view removeFromSuperview];
            
        }
    }
    //修改按钮提示字
//    [self resetItemTitle];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [self resetItemTitle];
}

#pragma mark - tableview delegate and datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //[self.lotteryList count]+2;
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
//        }
//        
//        return cell;
//        
//    }
    //if (indexPath.row == [self.lotteryList count]+1) {
        if (indexPath.row == [self.lotteryList count]) {
        static NSString *lotteryProtocolCellIdentifier = @"lotteryProtocolCellIdentifier";
        
        LotteryProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:lotteryProtocolCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[LotteryProtocolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lotteryProtocolCellIdentifier];
            
            cell.delegate = self;
            //if (IOS7_OR_LATER)
            {
                UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 1)];
                v.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
                [cell addSubview:v];
                cell.backgroundColor = [UIColor whiteColor];
            }
            
        }
        
        return cell;
    }
    
    static NSString *userChooseLotteryCellIdentifier = @"userChooseLotteryCellIdentifier";
    
    SevenStarsListCell *cell = [tableView dequeueReusableCellWithIdentifier:userChooseLotteryCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[SevenStarsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userChooseLotteryCellIdentifier];
    }
    
    //NSString *tempString = [self.lotteryList objectAtIndex:indexPath.row-1];
    NSString *tempString = [self.lotteryList objectAtIndex:indexPath.row];
    //获得彩票注数
    cell.lotteryNumber = [self getSingleCellLotteryCount:tempString];
    
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
    //if (index == [self.lotteryList count]+1)
    if (index == [self.lotteryList count]) {
        
        return;
        
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        
        if ([delegate conformsToProtocol:@protocol(SevenStarsListViewControllerDelegate) ]) {
            
            if([delegate respondsToSelector:@selector(returnUserDeleteLotteryCell:andMultiNo:andPeriods:andOnlyCouldChooseMoney:)]){
                
                double userCouldChooseMoney = 2000 - [self.totalLottery doubleValue]*2*[self.periods integerValue]*[self.multiNo integerValue];
                
                [delegate returnUserDeleteLotteryCell:self.lotteryList
                                           andMultiNo:self.multiNo
                                           andPeriods:self.periods andOnlyCouldChooseMoney:userCouldChooseMoney];
            }
        }
        
        //[self.lotteryList removeObjectAtIndex:index-1];
        [self.lotteryList removeObjectAtIndex:index];
        
        [self getAllCellLotteryCount];
        
        [self.listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];
        [self.tableView reloadData];
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    if (indexPath.row == [self.lotteryList count]) {
        
        return;
        
    }
    
    if (isFromOrder == YES) {
        [self initBallSelectControllerWhenComeFromOrder];
    }
    
    if ([self.delegate conformsToProtocol:@protocol(SevenStarsListViewControllerDelegate) ]) {
        
        if ([self.delegate respondsToSelector:@selector(returnUserEditLotteryCell:andIndex:andMultiNo:andPeriods:andOnlyCouldChooseMoney:)]) {
            
            NSString * tempStr = [self.lotteryList objectAtIndex:indexPath.row];
            
            double temp = 0.0;
            
            if ([self.title hasPrefix:L(@"SevenStars")]) {
                
                temp= [ComputeLotteryNumber computeLotterySevenStarsNumber:tempStr];
                
            }
            
            double userCouldChooseMoney = 2000 - ([self.totalLottery doubleValue]-temp)*2*[self.multiNo integerValue]*[self.periods integerValue];
            
            DLog(@"userCouldChooseMoney ====== %f", userCouldChooseMoney);
            
            [self.delegate returnUserEditLotteryCell:self.lotteryList
                                       andIndex:indexPath.row
                                     andMultiNo:self.multiNo
             andPeriods:self.periods andOnlyCouldChooseMoney:userCouldChooseMoney];
        }
    }
}
#pragma mark - delegate of LotteryFootView  底部信息修改回调


//返回是否超过2000元上限
-(BOOL)isMoneyOverFlowWithMultiple:(int)multiple andPeriods:(int)periods
{
    [self getAllCellLotteryCount];
    if ([self.totalLottery integerValue]*2 * multiple *periods > 2000) {
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];

        return YES;
    }
    return NO;
}

//修改倍数
-(void)changeLotteryMultiple:(int)multiple
{
    self.multiNo = [NSString stringWithFormat:@"%d",multiple];
}

//修改期数
-(void)changeLotteryPeriods:(int)periods
{
    self.periods = [NSString stringWithFormat:@"%d",periods];
}

//是否停止追号
-(void)isStopBuyWhenWin:(BOOL)yesOrNo
{
    self.isBuyWhenWin = yesOrNo;
}



//清空
-(void)clearAllNumbers
{
    if ([self.lotteryList count]!=0) {
        
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:L(@"Will clear all number")  customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            [self.lotteryList removeAllObjects];
            [self.tableView reloadData];
            self.totalLottery = nil;
            self.multiNo = @"1";
            self.periods = @"1";
            self.isBuyWhenWin = NO;
            
            [self getAllCellLotteryCount];
            
            [self.listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];
        }];
        
        [alertView show];
        
    }
}

//机选
-(void)addRandomNumber
{
    //机选一注
    NSString *newNoString =[self createNewNumber];
    
    CGFloat newZhuShu = 0;
    
    if ([self.title hasPrefix:L(@"SevenStars")]) {
        
        newZhuShu = [ComputeLotteryNumber computeLotterySevenStarsNumber:newNoString];
    }
    
    if (([self.totalLottery doubleValue]*[self.multiNo integerValue]*[self.periods integerValue]+ newZhuShu*[self.multiNo doubleValue]*[self.periods integerValue])>1000) {
        
        [self getAllCellLotteryCount];
        
        [self.listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];
        
        [ self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    [self.lotteryList insertObject:newNoString atIndex:0];
    
    [self getAllCellLotteryCount];
    
    [self.listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];
    
    [self.tableView reloadData];
    
    
    if ([delegate conformsToProtocol:@protocol(SevenStarsListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserAddLotteryCell:andMultiNo: andPeriods:andOnlyCouldChooseMoney:isAuto:)]) {
            
            double userCouldChooseMoney = 2000 - [self.totalLottery doubleValue]*2;
            
            [delegate returnUserAddLotteryCell:self.lotteryList
                                    andMultiNo:self.multiNo
                                    andPeriods:self.periods
                       andOnlyCouldChooseMoney:userCouldChooseMoney isAuto:YES];
        }
    }
}

//手选
-(void)addNewNumber
{
    //手选一注
    if ([self.totalLottery doubleValue]*[self.multiNo integerValue]*[self.periods integerValue] + [self.multiNo integerValue]*[self.periods integerValue]> 1000) {
        
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    if (isFromOrder == YES) {
        [self initBallSelectControllerWhenComeFromOrder];
    }
    
    if ([delegate conformsToProtocol:@protocol(SevenStarsListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserAddLotteryCell:andMultiNo: andPeriods:andOnlyCouldChooseMoney:isAuto:)]) {
            
            double userCouldChooseMoney = 2000 - [self.totalLottery doubleValue]*[self.multiNo integerValue]*[self.periods integerValue]*2;
            
            [delegate returnUserAddLotteryCell:self.lotteryList
                                    andMultiNo:self.multiNo
                                    andPeriods:self.periods
                       andOnlyCouldChooseMoney:userCouldChooseMoney isAuto:NO];
        }
    }
}

//付款
-(void)gotoPayForLottery
{
    [self checkLoginWithLoginedBlock:^{
        if ([self.lotteryList count] == 0) {
            
            [self presentSheet:L(@"You have not made any bets")];
            
            return;
        }
        
        if (self.isChecked == NO) {
            
            [self presentSheet :L(@"Make sure that you have agreed to the the User Purchasing Agreement and User Information Security Agreement")];
            
            return;
        }
        
        NSString *buyCode = @"";
        [self.ballInfoArray removeAllObjects];
        for (NSString * temp in self.lotteryList) {
            
            NSString *redBallStr = [NSString stringWithFormat:@"<font color=red>%@</font>",temp];
            
            [self.ballInfoArray addObject:redBallStr];
            
            NSString *tempT = [temp stringByReplacingOccurrencesOfString:@" | " withString:@","];
            tempT = [tempT stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            if (temp != [self.lotteryList lastObject]) {
                buyCode = [buyCode stringByAppendingFormat:@"%@:%@",tempT,@"1:1;"];
            }else
            {
                buyCode = [buyCode stringByAppendingFormat:@"%@:%@",tempT,@"1:1"];
            }
        }
        
        [self getAllCellLotteryCount];
        
        self.submitLotteryDto.productMoney = self.totalMoney;
        
        self.submitLotteryDto.multiNo = self.multiNo;
        
        self.submitLotteryDto.buyCodes = buyCode;
        if ([self.periods integerValue] == 1) {
            
            self.submitLotteryDto.saleType = L(@"purchasing");
            
            [self displayOverFlowActivityView];
            
            [self.couponService couponQueryWithSubmitLotteryDto:self.submitLotteryDto];
        }else if ([self.periods integerValue] > 1)
        {
            self.submitLotteryDto.saleType = L(@"serialpurchasing");
            
            self.submitLotteryDto.periods = self.periods;
            
            self.submitLotteryDto.stopWhenWin = self.isBuyWhenWin;
            
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
    } loginCancelBlock:nil];
}

#pragma mark - delegate of LotteryProtocol
- (void)presentModalProtocolView{
    
    LotteryProtocolViewController *controller = [[LotteryProtocolViewController alloc] initWithNameData:L(@"SevenStars")];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
    
}

-(void)returnUserCheck:(BOOL)checked{
    
    self.isChecked = checked;
    
}


#pragma mark - delegate of alertmessage
-(void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index
{
    if (tag == 226) {
        if (index == 0) {
            return;
        }else
        {
            for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                
                if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                    
                    [self.navigationController popToViewController:ctrl animated:YES];
                }
            }
        }
    }else if (tag == 227)
    {
        if (index == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (tag == 228)
    {
        if (index == 1) {
            
            [self.lotteryList removeAllObjects];
            [self.tableView reloadData];
            self.totalLottery = nil;
            self.multiNo = @"1";
            self.periods = @"1";
            self.isBuyWhenWin = NO;
            
            [self getAllCellLotteryCount];
            
            [self.listFootView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.periods integerValue] isBuyWhenWin:self.isBuyWhenWin];

        }
    }
}


#pragma mark - self-define  method
//算出总列表注数给self.totalLottery  不包含倍数、期数
-(void)getAllCellLotteryCount
{
    NSInteger listTotalCount = 0;
    for (NSString *value in self.lotteryList) {
        listTotalCount = [self getSingleCellLotteryCount:value] + listTotalCount;
    }
    self.totalLottery = [NSString stringWithFormat:@"%d",listTotalCount];
    self.totalMoney = [NSString stringWithFormat:@"%d",listTotalCount*[self.multiNo integerValue]*[self.periods integerValue]*2];
}

//算出相应的注数
-(NSInteger)getSingleCellLotteryCount:(NSString *) resultStr
{
    NSInteger lotteryCount = 0;
    
    NSArray *resultArray = nil;
    
    resultArray = [resultStr componentsSeparatedByString:@" | "];
    
    if ([resultArray count] == 7) {
        lotteryCount = 1;
    }else
    {
        //此时为0
        return lotteryCount;
    }
    
    //注数
    NSInteger  number = 1;
    //统计注数
    for (NSString *temp in resultArray) {
        NSArray *sameDegreeNumberArray = [temp componentsSeparatedByString:@" "];
        number = number * [sameDegreeNumberArray count];
        DLog(@"msg_sn:%d",number);
        lotteryCount = number;
    }
    return lotteryCount;
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
            //if (IOS7_OR_LATER)
//            {
//                 [number appendString:[NSString stringWithFormat:@"%d   ",[value integerValue]]];
//            }
//            else
            [number appendString:[NSString stringWithFormat:@"%d | ",[value integerValue]]];
        }
    }
    TT_RELEASE_SAFELY(array);
    return number;
}

//返回大厅
-(void)backToLotteryHall:(id)sender{
    if ([self.lotteryList count] == 0) {
        
        for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
            
            if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                
                [self.navigationController popToViewController:ctrl animated:YES];
            }
        }
        return;
    }
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:L(@"Back lottery hall will clear all the selected number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel")  otherButtonTitles:L(@"Ok")];
    
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

//返回订单详情
-(void)backToLotteryDetail:(id)sender
{
    if ([self.lotteryList count] >0)
    {
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:L(@"Back Order details will clear all the selected number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            
             [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

//列表界面出现设置按钮提示字
-(void)setItemTitle{
    if (isFromOrder == NO) {
    
        UINavigationBar *navBar = [self.navigationController navigationBar];
        
        for (UINavigationItem *item in navBar.items) {
            
            if(item.title && [self.title hasPrefix:item.title]){
                
                [item setTitle:L(@"Back to Lottery hall")];
                
                break;
            }
        }
    }else
    {
        UINavigationBar *navBar = [self.navigationController navigationBar];
        
        for (UINavigationItem *item in navBar.items) {
            
            if(item.title && [self.title hasPrefix:item.title]){
                
                [item setTitle:L(@"Order details")];
                
                break;
            }
        }
    }
}

//列表界面消失设置按钮提示字
-(void)resetItemTitle{
    if (isFromOrder == NO) {
        
        UINavigationBar *navBar = [self.navigationController navigationBar];
        
        for (UINavigationItem *item in navBar.items) {
            
            if(item.title && [item.title isEqualToString:L(@"Back to Lottery hall")]){
                
                if ([self.submitLotteryDto.gid isEqualToString:@"51"]) {
                    
                    [item setTitle:L(@"SevenStars")];
                }
            }
        }
    }else
    {
        UINavigationBar *navBar = [self.navigationController navigationBar];
        
        for (UINavigationItem *item in navBar.items) {
            
            if(item.title && [item.title isEqualToString:L(@"Order details")]){
                
                if ([self.submitLotteryDto.gid isEqualToString:@"51"]) {
                    
                    [item setTitle:L(@"SevenStars")];
                }
            }
        }

    }
}

//反编译选择号码字符串
-(void)decodeSubmitCodes:(NSString *) codes
{
    if (!lotteryList) {
        lotteryList = [[NSMutableArray alloc]init];
    }
    NSArray *array = nil;
    array = [codes componentsSeparatedByString:@":1:1"];
    for (__strong NSString *code in array) {
        code = [code stringByReplacingOccurrencesOfString:@";" withString:@""];
        code = [code stringByReplacingOccurrencesOfString:@"," withString:@"|"];
        
        //由于之前的号码加入了空格以方便显示 再次转化字符串
        NSMutableString *mutableCode = [[NSMutableString alloc]initWithString:code];
        
        NSInteger number = mutableCode.length;
        
        for (int i = 1;  i < number ; i++) {
            [mutableCode insertString:@" " atIndex:(2*i - 1)];
        }
        
        DLog(@"msg_sn:%@",mutableCode);
//        mutableCode 
        DLog(@"msg_sn:%@",mutableCode);
        if ([code isEqualToString:@""]||code == nil) {
            TT_RELEASE_SAFELY(mutableCode);
            continue;
        }
        DLog(@"msg_sn:%@",code);
        [self.lotteryList addObject:mutableCode];
        TT_RELEASE_SAFELY(mutableCode);
    }
    
    [self.tableView reloadData];
    
    [self getAllCellLotteryCount];
    
}

//从订单详情进入 需要重新创建选球界面
-(void)initBallSelectControllerWhenComeFromOrder
{
        
    if (delegate) {
        [self.navigationController pushViewController:(SevenStarsSelectViewController *)delegate animated:YES];
        return;
    }else
    {
        SevenStarsSelectViewController *sevenStars = [[SevenStarsSelectViewController alloc]init];
    
        self.delegate = sevenStars;
        
        sevenStars.isFromOrder = YES;
    
        sevenStars.lotteryHallDto = self.lotteryhallDto;
        
        sevenStars.selectionSheetArray = self.lotteryList;
    
        [self.navigationController pushViewController:sevenStars animated:YES];
    
        TT_RELEASE_SAFELY(sevenStars);
    }
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
