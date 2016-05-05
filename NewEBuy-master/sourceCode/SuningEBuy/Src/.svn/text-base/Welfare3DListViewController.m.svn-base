//
//  Welfare3DListViewController.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-26.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "Welfare3DListViewController.h"
#import "UserChooseLotteryCell.h"
#import "SettlementUtil.h"
#import "LotteryPayPageViewController.h"
#import "SubmitLotteryDto.h"
#import "LotteryDataModel.h"
#import "LottertSelectViewController.h"
#import "ComputeLotteryNumber.h"
#import "LotteryProtocolViewController.h"
#import "LotteryHallViewController.h"
#import "Welfare3DSelectViewController.h"
#import "LotteryPayPlugin.h"
#import "ConfirmBetInfoAndCouponViewController.h"

@interface Welfare3DListViewController() 

@property(nonatomic,strong) Welfare3DSelectViewController  *ballSelectViewCotnoller;
@property (nonatomic , strong) NSMutableArray *ballInfoArray;



-(void)compute;

-(NSString *)createNewLotteryNo;  //机选一注号码

-(CGFloat)computeLotteryArrangement:(NSString *)string ballType:(int)ballType;  //计算出一组号码的注数

-(void)backToLotteryHall:(id)sender;

-(void)backToLotteryDetail:(id)sender;

-(void)resetItemTitle;

- (void)setItemTitle;

@end

@implementation Welfare3DListViewController

@synthesize lotteryList = _lotteryList;
@synthesize headerView = _headerView;
@synthesize timesLbl = _timesLbl;
@synthesize footView = _footView;
@synthesize multiNo;
@synthesize totalLottery = _totalLottery;
@synthesize totalMoney;
@synthesize period;
@synthesize isBuyWin;
@synthesize submitLotteryDto = _submitLotteryDto;
@synthesize lotteryHallDto = _lotteryHallDto;
@synthesize delegate;
@synthesize ballSelectViewCotnoller = _ballSelectViewCotnoller;
@synthesize isFromOrder = _isFromOrder;
@synthesize isChecked = _isChecked;
@synthesize tableContainerView = _tableContainerView;
@synthesize isFromLuck = _isFromLuck;
@synthesize navigationBar = _navigationBar;
@synthesize selectBallType = _selectBallType;

- (id)initWIthTitle:(NSString *)title andLotteryTimes:(NSString *)lotteryTimes andEndTime:(NSString *)endTime {
    
    self = [super init];
    
    if (self) {
        self.bSupportPanUI = NO;
        self.isLotteryController = YES;
        _isFromOrder = NO;
        
        self.isChecked = YES;
        
        self.multiNo = @"1";
        
        self.period = @"1";
        
        isShouldAlertMessage = YES;
        
        self.isFromLuck = NO;
        
        self.isBuyWin = NO;
        
        _titleString = title;
        
        self.title = [NSString stringWithFormat:@"%@%@",_titleString,L(@"List")];
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),[NSString stringWithFormat:@"%@%@",_titleString,L(@"ListY")]];
        if (_submitLotteryDto == nil) {
            _submitLotteryDto = [[SubmitLotteryDto alloc]init];
        }
        self.submitLotteryDto.productTimes = lotteryTimes;
        self.submitLotteryDto.productName = title;
        if ([title isEqualToString:L(@"Welfare 3D")]) {
            self.submitLotteryDto.gid = @"03";
        }
        if ([endTime length] > 16) {
            self.submitLotteryDto.endTime = [endTime substringToIndex:16];
        }
        
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryList);
    
    TT_RELEASE_SAFELY(_headerView);
    
    TT_RELEASE_SAFELY(_timesLbl);
        
    TT_RELEASE_SAFELY(_footView);
    
    TT_RELEASE_SAFELY(multiNo);
    
    TT_RELEASE_SAFELY(_totalLottery);
    
    TT_RELEASE_SAFELY(period);
    
    TT_RELEASE_SAFELY(totalMoney);
    
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
    
    self.view.clipsToBounds = YES;
    
//	CGRect frame = CGRectMake(0,-200,310,self.view.frame.size.height-30);
//    
//    self.tableView.frame = frame;
    
    [self.view addSubview:self.headerView];
    
//    [self.tableContainerView addSubview:self.tableView];
//    
//    [self.view addSubview:self.tableContainerView];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.footView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tableView.frame = CGRectMake(0, 40, 320, self.view.bounds.size.height - 40 - LOTTERY_LIST_FOOT_VIEW_HEIGHT);
    
    self.footView.frame = CGRectMake(0, self.view.bounds.size.height - LOTTERY_LIST_FOOT_VIEW_HEIGHT, 320, LOTTERY_LIST_FOOT_VIEW_HEIGHT);
    
    [self compute];
    
    [self.footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
    
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
    
//    if (self.isFromLuck == YES) {
//        
//        [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
//    }
    
//    [[AppDelegate currentAppDelegate].tabBarViewController hidesTabBar:YES animated:YES];
    
    self.title = [NSString stringWithFormat:@"%@%@",_titleString,L(@"List")];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
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
        
        DLog(@"msg_sn:%f",[UIScreen mainScreen].bounds.size.height);
        
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
//        
//        imageView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
//        
//        [_headerView addSubview:imageView];
        
        
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
        
        _timesLbl.text = [NSString stringWithFormat:@"%@%@ %@",self.submitLotteryDto.productTimes,L(@"Period EndTime"),endTime];
        
        _timesLbl.textColor = [UIColor darkGrayColor];
        
        
    }
    
    return _timesLbl;
    
}



-(LotteryListFootView *)footView
{
    if (!_footView) {
        _footView = [[LotteryListFootView alloc]initWithYOrigin:self.view.height - LOTTERY_LIST_FOOT_VIEW_HEIGHT - 44];//减去导航条高度
        [_footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
        _footView.delegate = self;
    }
    return _footView;
}

-(Welfare3DSelectViewController *)ballSelectViewCotnoller{
    
    if (!_ballSelectViewCotnoller) {
        
        _ballSelectViewCotnoller = [[Welfare3DSelectViewController alloc] init];
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
////            UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
////            
////            backgroundImageView.image = [UIImage imageNamed:@"lottery_top_background.png"];
////            
////            [cell.contentView addSubview:backgroundImageView];
////            
////            TT_RELEASE_SAFELY(backgroundImageView);
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
    
    Welfare3DListCell *cell = [tableView dequeueReusableCellWithIdentifier:userChooseLotteryCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[Welfare3DListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userChooseLotteryCellIdentifier];
        
        if (self.isFromLuck == YES) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
        }
    }
    
    NSString *tempString = [self.lotteryList objectAtIndex:indexPath.row];

    DLog(@"msg_sn: 号码是%@",tempString);
    
    NSString *ballType = [tempString substringWithRange:NSMakeRange([tempString length] - 3, 3)];
    
    cell.lotteryNo = [self computeLotteryArrangement:[tempString substringWithRange:NSMakeRange(0, [tempString length] - 3)] ballType:[ballType intValue]];
    
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
        
        if ([delegate conformsToProtocol:@protocol(Welfare3DListViewControllerDelegate) ]) {
            
            if([delegate respondsToSelector:@selector(returnUserDeleteLotteryCell:andMultiNo:andPeriods:andOnlyCouldChooseMoney:)]){
                
                double userCouldChooseMoney = 2000 - [self.totalLottery doubleValue]*[self.period integerValue]*[self.multiNo integerValue]*2;
                
                [delegate returnUserDeleteLotteryCell:self.lotteryList andMultiNo:self.multiNo andPeriods:self.period andOnlyCouldChooseMoney:userCouldChooseMoney];
            }
        }
        
        isShouldAlertMessage = NO; //删除时，不弹超过2000元的提示框
        
        [self.lotteryList removeObjectAtIndex:index];
        
        [self compute];
        
        [self.footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
        
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
        
        self.ballSelectViewCotnoller.lotteryHallDTO = self.lotteryHallDto;
        
        self.delegate = self.ballSelectViewCotnoller;
        
        self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
        
        self.ballSelectViewCotnoller.isFromOrder = YES;
        
        [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];
        
    }
    
//    [self resetItemTitle];
    
    if ([delegate conformsToProtocol:@protocol(Welfare3DListViewControllerDelegate) ]) {
        
        if ([delegate respondsToSelector:@selector(returnUserEditLotteryCell:andIndex:andMultiNo:andPeriods:andOnlyCouldChooseMoney:)]) {
            
            [self compute];
            
            NSString * tempStr = [self.lotteryList objectAtIndex:indexPath.row];
            
            double temp = 0.0;
            
            if ([self.title hasPrefix:L(@"Welfare 3D")]) {
                
                temp= [self computeLotteryArrangement:[tempStr substringWithRange:NSMakeRange(0, [tempStr length] - 3)] ballType:[[tempStr substringWithRange:NSMakeRange([tempStr length] - 3, 3)] intValue]]; 
                
            }            
    
            double userCouldChooseMoney = 2000 - ([self.multiNo integerValue]*[self.period integerValue]*([self.totalLottery doubleValue]-temp))*2;
            
            DLog(@"userCouldChooseMoney ====== %f", userCouldChooseMoney);
            
            [delegate returnUserEditLotteryCell:self.lotteryList andIndex:indexPath.row andMultiNo:self.multiNo andPeriods:self.period andOnlyCouldChooseMoney:userCouldChooseMoney];
        }
    }
}

#pragma mark - LotteryFootViewDelegate 获取用户选择的倍数信息
//添加手选号码
- (void)addNewNumber
{
    [self compute];
    
    if ([self.totalLottery doubleValue]*[self.period integerValue]*[self.multiNo integerValue] +[self.period integerValue]*[self.multiNo integerValue] >1000) {
        
        [self presentSheet: L(@"The single orders bets up to 2000 yuan")];
        
        return;
    }
    
    if (self.isFromOrder == YES) {
        
        self.ballSelectViewCotnoller.lotteryHallDTO = self.lotteryHallDto;
        
        self.ballSelectViewCotnoller.isFromOrder = YES;
        
        self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
        
        self.delegate = self.ballSelectViewCotnoller;
        
        [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];
        
    }
    
    if ([delegate conformsToProtocol:@protocol(Welfare3DListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserAddLotteryCell:andMultiNo:andPeriods:andOnlyCouldChooseMoney:isAuto:)]) {
            
            double userCouldChooseMoney = 2000 - [self.period integerValue]*[self.multiNo integerValue]*[self.totalLottery doubleValue]*2;
            
            [delegate returnUserAddLotteryCell:self.lotteryList andMultiNo:self.multiNo andPeriods:self.period andOnlyCouldChooseMoney:userCouldChooseMoney isAuto:NO];
        }
    }
    
}

//添加机选号码
- (void)addRandomNumber
{
    [self compute];
    
    //机选一注
        
    NSString *newNoString =[NSString stringWithFormat:@"%@%d",[self createNewLotteryNo],self.selectBallType];
    
    CGFloat newZhuShu = 0;
    
    if ([self.title hasPrefix:L(@"Welfare 3D")]) {
        
        newZhuShu = [ComputeLotteryNumber computeLotteryFC3DNumber:[newNoString substringWithRange:NSMakeRange(0, [newNoString length] - 3)] ballType:self.selectBallType];
    }
    
    if ((([self.totalLottery doubleValue] + newZhuShu)*[self.multiNo doubleValue]*[self.period integerValue])>1000) {

        
//        [  alertMessage:L(@"The single orders bets up to 2000 yuan")];

        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];
        return;
    }
    
    [self.lotteryList insertObject:newNoString atIndex:0];
    
    [self compute];
    
    [self.footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
    
    [self.tableView reloadData];
    
    if ([delegate conformsToProtocol:@protocol(Welfare3DListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserAddLotteryCell:andMultiNo:andPeriods:andOnlyCouldChooseMoney:isAuto:)]) {
            
            double userCouldChooseMoney = 2000 - [self.totalLottery doubleValue]*2;
            
            [delegate returnUserAddLotteryCell:self.lotteryList andMultiNo:self.multiNo andPeriods:self.period andOnlyCouldChooseMoney:userCouldChooseMoney isAuto:YES];
        }
    }

    
}

//追号
- (void)changeLotteryPeriods:(int)periods
{
    self.period = [NSString stringWithFormat:@"%d",periods];
}

//倍投
- (void)changeLotteryMultiple:(int)multiple
{
    self.multiNo = [NSString stringWithFormat:@"%d",multiple];
}


//清空
-(void)clearAllNumbers
{
    if ([self.lotteryList count]>0)
    {
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:L(@"Will clear all number") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];

        [alertView setConfirmBlock:^{
            
            [self.lotteryList removeAllObjects];
            [self.tableView reloadData];
            self.totalLottery = nil;
            self.multiNo = @"1";
            self.period = @"1";
            self.isBuyWin = NO;
            
            [self compute];
            
            [self.footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
            
        }];
        
        [alertView show];

    }
    
    else
    {
        [self.lotteryList removeAllObjects];
        [self.tableView reloadData];
        self.totalLottery = nil;
        self.multiNo = @"1";
        self.period = @"1";
        self.isBuyWin = NO;
        
        [self compute];
        
        [self.footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
    }
  }


//去付款
- (void)gotoPayForLottery
{
    [self checkLoginWithLoginedBlock:^{
        if ([self.lotteryList count] == 0) {
            
            
            [self presentSheet:L(@"You have not made any bets")];
            //        [self.alertView alertMessage:L(@"You have not made any bets")];
            
            return;
        }
        
        if ([self.multiNo isEqualToString:@"0"]) {
            
            [self presentSheet:L(@"Please select at least 1 times the bet multiples")];
            
            //        [self.alertView alertMessage:L(@"Please select at least 1 times the bet multiples")];
            
            return;
            
        }
        
        if (self.isChecked == NO) {
            
            [self presentSheet: L(@"Make sure that you have agreed to the the User Purchasing Agreement and User Information Security Agreement")];
            
            return;
            
        }
        
        //将彩票号码列表转换为一个字符串，传给支付界面
        NSString *buyCodes = @"";
        [self.ballInfoArray removeAllObjects];
        for (__strong NSString *tempStr in self.lotteryList) {
            
            NSString *subString = [tempStr substringWithRange:NSMakeRange(0, [tempStr length] - 3)];
            
            int ballType = [[tempStr substringWithRange:NSMakeRange([tempStr length] - 3, 3)] intValue];
            
            if (ballType == zhiXuan) {
                
                NSString *redBallStr = [NSString stringWithFormat:@"<font color=red>%@</font>",subString];
                
                [self.ballInfoArray addObject:redBallStr];
                
                NSArray *arr = [subString componentsSeparatedByString:@" | "];
                
                if ([arr count] == 3) {
                    
                    NSString *bitString = [arr objectAtIndex:0];
                    
                    bitString = [bitString stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    NSString *tenString = [arr objectAtIndex:1];
                    
                    tenString = [tenString stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    NSString *hundString = [arr objectAtIndex:2];
                    
                    hundString = [hundString stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    tempStr = [NSString stringWithFormat:@"%@,%@,%@:1:1",bitString,tenString,hundString];
                }
            }
            else{
                NSString *lastString = @"";
                switch (ballType) {
                    case zhiXuanHeZhi:
                        lastString = @"1:4";
                        break;
                    case zuSan:
                        lastString = @"2:3";
                        break;
                    case zuLiu:
                        lastString = @"3:3";
                        break;
                    case zuSanHeZhi:
                        lastString = @"2:4";
                        break;
                    case zuLiuHeZhi:
                        lastString = @"3:4";
                        break;
                    default:
                        break;
                }
                subString = [subString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
                
                NSString *redBallStr = [NSString stringWithFormat:@"<font color=red>%@</font>",subString];
                
                [self.ballInfoArray addObject:redBallStr];
                
                subString = [subString stringByReplacingOccurrencesOfString:@" " withString:@","];
                
                tempStr = [NSString stringWithFormat:@"%@:%@",subString,lastString];
            }
            if ([buyCodes isEqualToString:@""]) {
                
                buyCodes = tempStr;
                
            }else{
                buyCodes = [NSString stringWithFormat:@"%@;%@",buyCodes,tempStr];
            }
        }
        
        [self compute];
        
        self.submitLotteryDto.productMoney = self.totalMoney;
        
        self.submitLotteryDto.multiNo = self.multiNo;
        
        self.submitLotteryDto.buyCodes = buyCodes;
        
        self.submitLotteryDto.periods = self.period;
        
        if ([self.submitLotteryDto.periods isEqualToString:@"1"]) {
            self.submitLotteryDto.saleType = L(@"purchasing");
            
            [self displayOverFlowActivityView];
            [self.couponService couponQueryWithSubmitLotteryDto:self.submitLotteryDto];
        }else
        {
            self.submitLotteryDto.saleType = L(@"serialpurchasing");
            
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

//是否中奖后停止追号
- (void)isStopBuyWhenWin:(BOOL)yesOrNo
{
    self.isBuyWin = yesOrNo;
}

//判断输入的追号期数和倍投是否超过单笔订单最大投注金额
- (BOOL)isMoneyOverFlowWithMultiple:(int)multiple andPeriods:(int)periods
{
    double danbeizhushu = 0;
    
    for (NSString *string in self.lotteryList) {
        
        double temp = 0;
        
        NSString *ballType = [string substringWithRange:NSMakeRange([string length] - 3, 3)];
        
        NSString *ballString =[string substringWithRange:NSMakeRange(0, [string length] - 3)];
        
        if ([self.title hasPrefix:L(@"Welfare 3D")]) {
            
            temp = [ComputeLotteryNumber computeLotteryFC3DNumber:ballString ballType:[ballType intValue]];
        }
        
        danbeizhushu +=temp;
        
    }
    
    if(danbeizhushu * multiple * periods * 2 > 2000)
    {
        [self presentSheet:L(@"The single orders bets up to 2000 yuan")];

        return YES;
    }
    return NO;
}

-(void)returnMultiNoAndTotalLottery:(CGFloat)userChooseMultiNo andTotalLottery:(CGFloat)totalLottery{
    
    double money = 2*totalLottery;
    
    if (money > 2000 && isShouldAlertMessage) {
        
        [self presentSheet:L(@"The single orders bets up to 2000 yuan") posY:50.0];
        
        return;
    }
    
    isShouldAlertMessage = YES;
    
    if (userChooseMultiNo > 99) {
        
        [self presentSheet:L(@"You can select up to 99 times") posY:50.0];
        
        return;
    }
    
    self.multiNo = [NSString stringWithFormat:@"%0.f",userChooseMultiNo];
    
    self.totalLottery = [NSString stringWithFormat:@"%0.f",totalLottery];
    
    self.totalMoney = [NSString stringWithFormat:@"%0.f",money];
    
    if ([delegate conformsToProtocol:@protocol(Welfare3DListViewControllerDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserChooseMulitNo:andPeriods:)]) {
            
            [delegate returnUserChooseMulitNo:self.multiNo andPeriods:self.period];
        }
    }
}


#pragma mark - action
-(void)compute{
    
    double danbeizhushu = 0;
    
    for (NSString *string in self.lotteryList) {
        
        double temp = 0;
        
        NSString *ballType = [string substringWithRange:NSMakeRange([string length] - 3, 3)];
        
        NSString *ballString =[string substringWithRange:NSMakeRange(0, [string length] - 3)];

        if ([self.title hasPrefix:L(@"Welfare 3D")]) {
            
            temp = [ComputeLotteryNumber computeLotteryFC3DNumber:ballString ballType:[ballType intValue]];
        }
        
        danbeizhushu +=temp;
        
    }
    
    double danbeijine = danbeizhushu*2;
    
    self.totalLottery = [NSString stringWithFormat:@"%0.f",danbeizhushu];
    
    self.totalMoney = [NSString stringWithFormat:@"%0.f",danbeijine*[self.multiNo doubleValue]*[self.period integerValue]];
    
}

-(NSString *)createNewLotteryNo{
    
    NSMutableArray *welfare3DArray = [[NSMutableArray alloc] init];
    
    NSInteger ballCount = 0;
    
    NSInteger leastNum_ = 0;
    
    switch (self.selectBallType) {
        case zhiXuan:
            leastNum_ = 1;
            ballCount = 30;
            break;
        case zuSan:
            leastNum_ = 2;
            ballCount = 10;
            break;
        case zuLiu:
            leastNum_ = 3;
            ballCount = 10;
            break;
        case zhiXuanHeZhi:
            leastNum_ = 1;
            ballCount = 28;
            break;
        case zuSanHeZhi:
            leastNum_ = 1;
            ballCount = 26;
            break;
        case zuLiuHeZhi:
            ballCount = 22;
            leastNum_ = 1;
            break;
        default:
            break;
    }
    
    if (self.selectBallType == zhiXuan) {
                
        for (int i = 0; i < 3; i++) {         
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            [LotteryDataModel getRandomArray:array randomNumCount:leastNum_ maxCount:ballCount / 3];
            
            [welfare3DArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:0] intValue] + i *10]];  
            
        }
        
    }else{
        
        [LotteryDataModel getRandomArray:welfare3DArray randomNumCount:leastNum_ maxCount:ballCount];
    }
            
    [LotteryDataModel sortFromLowToHigh:welfare3DArray];

    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    switch (self.selectBallType) {
        case zhiXuan:{
            
            int ten = 0;
            int hund = 0;
            
            for (NSNumber *value in welfare3DArray) {
                
                if ([value intValue] >= 20) {
                    if (hund == 0) {
                        [resultString appendFormat:@" |"];
                    }
                    hund ++;
                    [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] - 20]];
                }
                else if ([value intValue] >= 10) {
                    if (ten == 0) {
                        [resultString appendFormat:@" |"];
                    }
                    ten ++;
                    [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] - 10]];
                }
                else{
                    [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue]]];
                }
            }  
        }
            break;
        case zuSanHeZhi:
            for (NSNumber *value in welfare3DArray) {
                
                [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] + 1]];
            }
            break;            
        case zuLiuHeZhi:
            for (NSNumber *value in welfare3DArray) {
                
                [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] + 3]];
            }
            break;            
        default:
            
            for (NSNumber *value in welfare3DArray) {
                
                [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue]]];
            }
            break;
    }
    
    
    return resultString;
}

-(CGFloat)computeLotteryArrangement:(NSString *)string ballType:(int)ballType{
    
    return  [ComputeLotteryNumber computeLotteryFC3DNumber:string ballType:ballType];
}

-(void)backToLotteryHall:(id)sender{
    if ([self.lotteryList count] == 0) {
        
        for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
            
            if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                
                [self.navigationController popToViewController:ctrl animated:YES];
            }
        }
        return;
    }
    
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

-(void)backToLotteryDetail:(id)sender{
    
     if ([self.lotteryList count] > 0)
     {
         BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:L(@"Back Order details will clear all the selected number")  customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];

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
            
            if ([self.submitLotteryDto.gid isEqualToString:@"03"]) {
                
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
    }else if(tag == 228)
    {
        if (index == 1) {
            
            [self.lotteryList removeAllObjects];
            [self.tableView reloadData];
            self.totalLottery = nil;
            self.multiNo = @"1";
            self.period = @"1";
            self.isBuyWin = NO;
            
            [self compute];
            
            [self.footView updateWithMultiple:[self.multiNo integerValue] bets:[self.totalLottery integerValue] periods:[self.period integerValue] isBuyWhenWin:self.isBuyWin];
        }
    }else
    {
        
        if (index == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];      
        }
    }
    
}

#pragma mark - LotteryProtocolCellDelegate

- (void)presentModalProtocolView{
    
    LotteryProtocolViewController *controller = [[LotteryProtocolViewController alloc] initWithNameData:_titleString];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
    
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

-(void)returnUserCheck:(BOOL)checked{
    
    self.isChecked = checked;
    
}
@end

