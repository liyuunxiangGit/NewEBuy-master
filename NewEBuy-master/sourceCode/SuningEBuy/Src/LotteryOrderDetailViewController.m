//
//  LotteryOrderDetailViewController.m
//  SuningEBuy
//
//  Created by david on 12-7-3.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryOrderDetailViewController.h"
#import "LotteryListViewController.h"
#import "LotteryHallDto.h"
#import "BallSelectConstant.h"
#import "Welfare3DListViewController.h"
#import "OrderDetailNumbersView.h"
#import "OrderDetailPeriodsView.h"
#import "OrderDetailView.h"
#import "OrderDetailLotteryNumberView.h"
#import "LotteryDataModel.h"
#import "ArrangeBallViewController.h"
#import "SevenLeListViewController.h"
#import "SevenStarsListViewController.h"
#import "LoginViewController.h"
#import "AuthManagerNavViewController.h"

@interface LotteryOrderDetailViewController() <OrderDetailViewDelegate>{
    
    BOOL                            isLoadOK;
    OrderDetailView                 *_orderDetailView;   //订单明细
    
    OrderDetailNumbersView        *_betNumbersView;     //投注内容视图
    
    OrderDetailPeriodsView        *_buyPeriodsView;     //追号列表视图
    
    OrderDetailLotteryNumberView *_lotteryNumberView; //开奖号码视图
    
    UIView                            *_noDataTipView;      //没有数据时tipview
    
    UIImageView                      *_bottomView;         //底部视图
}

@end


@implementation LotteryOrderDetailViewController


- (void)dealloc 
{
    
    SERVICE_RELEASE_SAFELY(_orderService);
    TT_RELEASE_SAFELY(_orderDetailView);
    TT_RELEASE_SAFELY(_betNumbersView);
    TT_RELEASE_SAFELY(_buyPeriodsView);
    TT_RELEASE_SAFELY(_lotteryNumberView);
    TT_RELEASE_SAFELY(_noDataTipView);
    TT_RELEASE_SAFELY(_bottomView);
    
    SERVICE_RELEASE_SAFELY(_lotteryHallService);
    SERVICE_RELEASE_SAFELY(_couponService);

}


- (id)initWithListDto:(id)dto isCustomLotteryList:(BOOL)yesOrNo
{
    
    self = [super init];
    
    if (self) 
    {
        self.isLotteryController = YES;
        _isCustomLotteryList = yesOrNo;
        
        _orderService = [[LotteryOrderDetailService alloc] init];
        _orderService.listDto = dto;
        _orderService.delegate = self;
        isLoadOK = NO;
        self.title = L(@"Order details");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery_lotteryOrderList"),self.title];
    }
    
    return self;
}

- (id)initWithProjId:(NSString *)projid gid:(NSString *)gid isCustomLotteryList:(BOOL)yesOrNo
{
    isLoadOK = NO;
    if(yesOrNo)
    {
        LotteryDealsDto *dto = [[LotteryDealsDto alloc] init];
        dto.projid = projid;
        dto.gid = gid;
        
        return [self initWithListDto:dto isCustomLotteryList:yesOrNo];
    }else{
        LotteryDealsSerialNumberDto *dto = [[LotteryDealsSerialNumberDto alloc] init];
        dto.zhid = projid;
        dto.gid = gid;
        
        return [self initWithListDto:dto isCustomLotteryList:yesOrNo];
    }
}

- (CouponService *)couponService{
    
    
    if (!_couponService) {
        
        _couponService = [[CouponService alloc] init];
        
        _couponService.delegate = self;
    }
    return _couponService;
}

- (void)loadView
{
    [super loadView];
    
    [self useBottomNavBar];
    
	CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
	
	self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    [self.view addSubview:self.tableView];
    
    //添加底部视图
//    _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-48 - 44, CGRectGetWidth(self.view.frame), 48)];
//    _bottomView.image = [[UIImage imageNamed:@"ball_select_bottom.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    _bottomView.userInteractionEnabled = YES;
//    [self.view addSubview:_bottomView];
//
    self.bottomNavBar.backButton.hidden = YES;
    self.bottomNavBar.ebuyBtn.hidden = NO;
    
    if([_orderService.listDto isKindOfClass:[LotteryDealsDto class]] && [((LotteryDealsDto *)_orderService.listDto).istate integerValue]==-1 && !((LotteryDealsDto *)_orderService.listDto).isExpired)
    {
        
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 81, 9, 66, 30);
        [buyBtn addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
        [buyBtn setTitle:L(@"LOGoToPay") forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        buyBtn.right = self.bottomNavBar.ebuyBtn.left - 10;
        [self.bottomNavBar addSubview:buyBtn];
    }else{
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 81, 9, 66, 30);
        [buyBtn addTarget:self action:@selector(goToLotteryListPage) forControlEvents:UIControlEventTouchUpInside];
        [buyBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"]
                          forState:UIControlStateNormal];
        [buyBtn setTitle:L(@"LOContinueToBuy") forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        buyBtn.right = self.bottomNavBar.ebuyBtn.left - 10;
        [self.bottomNavBar addSubview:buyBtn];
    }
    
//    [_bottomView addSubview:buyBtn];
    
    
    self.bottomNavBar.hidden = YES;
    
    _bottomView.hidden = YES;
     
}

-(void)goToPay
{
    [self displayOverFlowActivityView];
    [self.couponService payRemainMenoyWith:(LotteryDealsDto *)_orderService.listDto];
}

#pragma mark -CouponServiceDelegate
- (void)goToPayUrl:(CouponService *)service payUrl:(NSString *)payUrl
{
    [self removeOverFlowActivityView];
    
    [self checkLoginWithLoginedBlock:^{
        if (payUrl) {
            NSString *myUrl = [payUrl stringByReplacingOccurrencesOfString:@"@" withString:@"&"];
            NSURL *url = [NSURL URLWithString:myUrl];
            
            [[UIApplication sharedApplication] openURL:url];
            
        }else
        {
            [self presentSheet:L(@"LOSystermError")];
        }
    } loginCancelBlock:nil];
}

- (void)cancelCouponSuccess:(CouponService *)service success:(BOOL)success
{
    [self removeOverFlowActivityView];
    if (success) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[LotteryDealsViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                [(LotteryDealsViewController *)vc presentSheet:L(@"GBCancelSuccess")];
                [(LotteryDealsViewController *)vc reloadTableViewDataSource];
                
                return;
            }
        }
    }else
    {
        [self presentSheet:L(@"NearbySuning_CancelFailed")];
    }
}

#pragma mark - OrderDetailViewDelegate

- (void)cancelButtonClicked{
    [self displayOverFlowActivityView];
    [self.couponService cancelCoupon:(LotteryDealsDto *)_orderService.listDto];
}

- (LotteryHallService *)lotteryHallService
{
    if (!_lotteryHallService) {
        _lotteryHallService = [[LotteryHallService alloc] init];
        _lotteryHallService.delegate = self;
    }
    return _lotteryHallService;
}


//为追求显示效果  将两个方法里均添加这个
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    

    if (!isLoadOK) {
        [self displayOverFlowActivityView];
        
        //是否从支付页面跳转到详情界面
        if([_orderService.listDto isKindOfClass:[LotteryDealsSerialNumberDto class]] && [_orderService.listDto pid] == nil)
        {
            [self sendFollowPeriodProjectHttpRequest];
        }else{
            [self sendLotteryOrderDetailHttpRequest];
        }
    
    }    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)lotteryHallRequestCompletedWithResult:(NSMutableArray *)lotteryCatList andLotreryAllList:(NSMutableArray *)lotteryAllList isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorCode
{
    if (isSuccess) {
        [self goToLotteryListPage];
    }else{
        [self presentSheet:L(@"LOGetLotteryBatchFail")];
    }
}

#pragma mark - action

 //跳转到订单列表进行投注
-(void)goToLotteryListPage
{
 
    if(_orderService.tradeOrderDetailDto == nil && _orderService.followPeroidArray == nil)
        return;
    
    LotteryHallDto *tempDto = nil;
    
    NSArray *lotteryCatArray = [NSArray arrayWithArray:[Config currentConfig].lotteryCatArray];
    
    if (IsArrEmpty(lotteryCatArray)) {
        
        [self.lotteryHallService sendLotteryHallInfoHttpRequest];
        
        return;
    }
    
    for (LotteryHallDto *dto in lotteryCatArray)
    {
        
        if ([[_orderService gid] isEqualToString:dto.gid])
        {
            
            tempDto = dto;
            
            break;
        }
    }
    
    NSString *systemTimeStr = tempDto.date == nil?@"":tempDto.date;
    
    NSString *nowfendtimeStr = tempDto.nowendtime == nil?@"":tempDto.nowendtime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *systemTime = [formatter dateFromString:systemTimeStr];
    
    NSDate *nowfendtime = [formatter dateFromString:nowfendtimeStr];
    
    
    if ([[systemTime laterDate:nowfendtime]isEqualToDate:systemTime])
    {
   
        [self presentSheet:L(@"Current betting time has ended")];
        
        return;
    }

    
    if ([tempDto.gid isEqualToString:@"03"])
    {      //福彩3D
        
        Welfare3DListViewController *contoller = [[Welfare3DListViewController alloc] initWIthTitle:tempDto.gname andLotteryTimes:tempDto.nowpid  andEndTime:tempDto.nowendtime];
        
        contoller.lotteryList = [self dealWith3DCodeList];
        
        contoller.isFromOrder = YES;
        
        contoller.lotteryHallDto = tempDto;
        
        NSString *lastBallString = [contoller.lotteryList objectAtIndex:[contoller.lotteryList count] - 1];
           
        NSString *ballTypeString = [lastBallString substringWithRange:NSMakeRange(lastBallString.length - 3, 3)];

        contoller.selectBallType = [ballTypeString intValue];
        
        [self.navigationController pushViewController:contoller animated:YES]; 
        
        TT_RELEASE_SAFELY(contoller);
        
    }
    else if([tempDto.gid isEqualToString:@"01"] || [tempDto.gid isEqualToString:@"50"])
    {   //双色球 大乐透
        LotteryListViewController *contoller = [[LotteryListViewController alloc] initWIthTitle:tempDto.gname andLotteryTimes:tempDto.nowpid  andEndTime:tempDto.nowendtime];
        
        contoller.lotteryList = [self dealWithCodeList];
        
        contoller.isFromOrder = YES;
        
        contoller.lotteryHallDto = tempDto;
                
        [self.navigationController pushViewController:contoller animated:YES]; 
        
        TT_RELEASE_SAFELY(contoller);
    }
    else if([tempDto.gid isEqualToString:@"53"] || [tempDto.gid isEqualToString:@"52"])    //排列三 排列五
    {
        LotteryOrderListDTO *dto = [[LotteryOrderListDTO alloc] initWithType:[LotteryDataModel lotterTypeWithgid:tempDto.gid]];
        dto.multiple = 1;
        dto.periods = 1;
        dto.isStopBuyWhenWin = YES;
        dto.maxPay = 2000;

        [dto addBetsWithCcodes:[_orderService getCcodes]];
        
        ArrangeListViewController *controller = [[ArrangeListViewController alloc] initWithLotteryHallDto:tempDto andLotteryOrderListDto:dto isFromOrder:YES];
        TT_RELEASE_SAFELY(dto);
        
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
        
        TT_RELEASE_SAFELY(controller);
        
    }
    else if([tempDto.gid isEqualToString:@"51"]) //七星彩
    {
        SevenStarsListViewController *controller = [[SevenStarsListViewController alloc]initWithLotteryTimes:tempDto.nowpid andEndTime:tempDto.nowendtime];
        controller.lotteryhallDto = tempDto;
        controller.multiNo = @"1";
        controller.periods = @"1";
        controller.isBuyWhenWin = NO;
        controller.isFromOrder = YES;
        [controller decodeSubmitCodes:[_orderService getCcodes]];
        
        [self.navigationController pushViewController:controller animated:YES];
        
        TT_RELEASE_SAFELY(controller);
        
    }
    else if([tempDto.gid isEqualToString:@"07"]) //七乐彩
    {
        SevenLeListViewController *controller = [[SevenLeListViewController alloc]initWIthTitle:L(@"Seven Le Lottery") andLotteryTimes:tempDto.nowpid andEndTime:tempDto.nowendtime];
        controller.multiple = 1;
        controller.periods = 1;
        controller.isStopBuyWhenWin = NO;
        controller.isFromOrder = YES;
        controller.lotteryList = [self dealWithSevenLeCodeList];
        controller.lotteryHallDto = tempDto;
        
        [self.navigationController pushViewController:controller animated:YES];
        
        TT_RELEASE_SAFELY(controller);
    }
    
}

- (NSMutableArray *)dealWith3DCodeList{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    NSArray *codeList = [[_orderService getCcodes] componentsSeparatedByString:@";"];
    
    for (__strong NSString *tempString in codeList)
    {

        NSRange range = [tempString rangeOfString:@":"];
        
        NSString *ballTypeString = [tempString substringWithRange:NSMakeRange(range.location + 1, [tempString length] - range.location - 1)];
        tempString = [tempString substringToIndex:range.location];

        int ballType = 0;
        NSString *replaceString = @"";
        if ([ballTypeString isEqualToString:@"1:1"]) {
            ballType = zhiXuan;
         
            NSString *zhixuanString = @" ";
            
            NSArray *ballList = [[tempString substringToIndex:range.location] componentsSeparatedByString:@","];
            
            NSString *ballString1;
            
            for (NSString *string in ballList) {
              
                ballString1 = [string substringWithRange:NSMakeRange(0, 1)];
                
                for (int i = 1 ; i < string.length ; i ++) {
                
                    ballString1 = [NSString stringWithFormat:@"%@ %@",ballString1,[string substringWithRange:NSMakeRange(i, 1)]];
                }
                if ([zhixuanString isEqualToString:@" "]) {
               
                    zhixuanString = ballString1;
                }else{
                    
                    zhixuanString = [NSString stringWithFormat:@"%@,%@",zhixuanString,ballString1];    
                }

                DLog(@"ballString1 = %@", zhixuanString);
            }
            tempString = zhixuanString;
            replaceString = @" | ";
        }else if([ballTypeString isEqualToString:@"1:4"]){
          
            ballType = zhiXuanHeZhi;
            
            replaceString = @" ";
        }else if([ballTypeString isEqualToString:@"2:3"]){
            
            ballType = zuSan;
            
            replaceString = @" ";
        }else if([ballTypeString isEqualToString:@"2:4"]){
            
            ballType = zuSanHeZhi;
            
            replaceString = @" ";
        }else if([ballTypeString isEqualToString:@"3:3"]){
            
            ballType = zuLiu;
            
            replaceString = @" ";
        }else if([ballTypeString isEqualToString:@"3:4"]){
            
            ballType = zuLiuHeZhi;
            
            replaceString = @" ";
        }
        tempString = [tempString stringByReplacingOccurrencesOfString:@"," withString:replaceString];
        tempString = [NSString stringWithFormat:@" %@%d",tempString,ballType];

        [tempArray addObject:tempString];
    }
    
    return tempArray;
}

-(NSMutableArray *)dealWithSevenLeCodeList
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    NSArray *codeList = [[_orderService getCcodes] componentsSeparatedByString:@";"];

    for (__strong NSString *tempString in codeList)
    {
        
        NSRange range = [tempString rangeOfString:@":"];
        
        tempString = [tempString substringToIndex:range.location];
        
        tempString = [tempString stringByReplacingOccurrencesOfString:@"," withString:@" "];
        
        tempString = [tempString stringByAppendingString:@" "];
        
        [tempArray addObject:tempString];
    }
    
    return tempArray;

    
}


-(NSMutableArray *)dealWithCodeList
{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    NSArray *codeList = [[_orderService getCcodes] componentsSeparatedByString:@";"];
    
    for (__strong NSString *tempString in codeList) 
    {
        
        NSRange range = [tempString rangeOfString:@":"];
        
        tempString = [tempString substringToIndex:range.location];
        
        tempString = [tempString stringByReplacingOccurrencesOfString:@"," withString:@" "];
        
        tempString = [tempString stringByReplacingOccurrencesOfString:@"|" withString:@" | "];
        
        [tempArray addObject:tempString];
    }
    
    return tempArray;
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_orderService.tradeOrderDetailDto == nil && [_orderService.followPeroidArray count] == 0)
    {
        if(_noDataTipView == nil)
        {
            //请求异常提示view
            _noDataTipView = [[UIView alloc]initWithFrame:self.tableView.frame];
            
            UIImage *facePNG = [UIImage imageNamed:@"face.png"];
            UIImageView *face = [[UIImageView alloc]initWithImage:facePNG];
            face.size = facePNG.size;
            face.center = _noDataTipView.center;
            [_noDataTipView addSubview:face];
            
        }
        
        if(_orderService.errorMsg != nil){
            [self.tableView addSubview:_noDataTipView];
        }
        
        _bottomView.hidden = YES;
        self.bottomNavBar.hidden = YES;

        return 0;
    }
    
    _bottomView.hidden = NO;
    self.bottomNavBar.hidden = NO;

    [_noDataTipView removeFromSuperview];
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
//        case 0:
//        {
//            if(_orderDetailView == nil)
//            {
//                _orderDetailView = [[OrderDetailView alloc] initWithOrderDetailService:_orderService];
//                
//            }
//            return CGRectGetHeight(_orderDetailView.frame);
//        }
//            break;
        case 0:
        {
            if(_orderDetailView == nil)
            {
                _orderDetailView = [[OrderDetailView alloc] initWithOrderDetail:_orderService.tradeOrderDetailDto followList:_orderService.followPeroidArray withListDTO:_orderService.listDto];
                _orderDetailView.delegate=self;
                
                if(_isCustomLotteryList)    //代购订单详情
                {
                    if ([((LotteryDealsDto *)_orderService.listDto).istate integerValue] ==-1 && [((LotteryDealsDto *)_orderService.listDto).coupon floatValue]>0) {
                        _orderDetailView.cancleCoupon.hidden = NO;
                    }
                }
            }
            return CGRectGetHeight(_orderDetailView.frame);
        }
            break;

        case 1:
        {
            if(_betNumbersView == nil)
            {
                NSString *multiple = nil;
                if([_orderService.followPeroidArray count] > 0)
                {
                    multiple = nil;
                }else
                    multiple = _orderService.tradeOrderDetailDto.mulity;
                
                _betNumbersView = [[OrderDetailNumbersView alloc] initWithNumbersString:[_orderService getCcodes] multiple:multiple lotteryType:[LotteryDataModel lotterTypeWithgid:[_orderService gid]]];
            }
            return CGRectGetHeight(_betNumbersView.frame);
        }
            break;
        case 2:
        {
            if(_isCustomLotteryList)
            {
                if(_lotteryNumberView == nil)
                {
                    _lotteryNumberView = [[OrderDetailLotteryNumberView alloc] initWithAwardNumber: _orderService.tradeOrderDetailDto.awardcode];
                }
                
                return CGRectGetHeight(_lotteryNumberView.frame);
            }else{
                if(_buyPeriodsView == nil)
                {
                    _buyPeriodsView = [[OrderDetailPeriodsView alloc] initWithService:_orderService];
                }
                return CGRectGetHeight(_buyPeriodsView.frame);
            }
        }
            break;
        default:
            return 0;
            break;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch ([indexPath row]) {
//        case 0:
//        {
//            if(_orderDetailView == nil)
//            {
//                _orderDetailView = [[OrderDetailView alloc] initWithOrderDetailService:_orderService];
//                
//            }
//        
//            [cell.contentView addSubview:_orderDetailView];
//            
////            if (IOS4_OR_LATER) {
////                [_orderDetailView setNeedsDisplay];
////            }
//
//        }
//            break;
        case 0:
        {
            if(_orderDetailView == nil)
            {
                _orderDetailView = [[OrderDetailView alloc] initWithOrderDetail:_orderService.tradeOrderDetailDto followList:_orderService.followPeroidArray withListDTO:_orderService.listDto];
                //                   _orderDetailView.delegate=self;
            }
            
            [cell.contentView addSubview:_orderDetailView];
        }
            break;

        case 1:
        {
            if(_betNumbersView == nil)
            {
                NSString *multiple = nil;
                if([_orderService.followPeroidArray count] > 0)
                {
                    FollowPerodDetailDto *dto = [_orderService.followPeroidArray objectAtIndex:0];
                    multiple = dto.imulity;
                }else
                    multiple = _orderService.tradeOrderDetailDto.mulity;
                
                _betNumbersView = [[OrderDetailNumbersView alloc] initWithNumbersString:[_orderService getCcodes] multiple:multiple lotteryType:[LotteryDataModel lotterTypeWithgid:[_orderService gid]]];
            }
            [cell.contentView addSubview:_betNumbersView] ;
        }
            break;
        case 2:
        {
            if(_isCustomLotteryList)
            {
                if(_lotteryNumberView == nil)
                {
                    _lotteryNumberView = [[OrderDetailLotteryNumberView alloc] initWithAwardNumber: _orderService.tradeOrderDetailDto.awardcode];
                }
                
                [cell.contentView addSubview:_lotteryNumberView];
            }else{
                if(_buyPeriodsView == nil)
                {
                    _buyPeriodsView = [[OrderDetailPeriodsView alloc] initWithService:_orderService];
                }
                
                [cell.contentView addSubview:_buyPeriodsView];
            }

        }
            break;
        default:
            return 0;
            break;
    }
    
    return cell;
}


#pragma mark - Http Request

- (void)sendFollowPeriodProjectHttpRequest
{
    
    NSDictionary *postDic = [[NSDictionary alloc] initWithObjectsAndKeys:POST_VALUE([_orderService projid]),@"zhid",@"1",@"json", nil];

    [_orderService sendRequestWithPostDic:postDic andCmdCode:CC_FollowOrderProject];
    
}

-(void)sendLotteryOrderDetailHttpRequest
{
    
    NSString *projid = POST_VALUE([_orderService projid]);
    
    NSString *gid = POST_VALUE([_orderService gid]);
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    [postDataDic setObject:@"1" forKey:@"json"];
    [postDataDic setObject:gid forKey:@"gid"];
    [postDataDic setObject:POST_VALUE(@"2") forKey:@"source"];
    
    if(_isCustomLotteryList)    //代购订单详情
    {
        [postDataDic setObject:projid forKey:@"hid"];
        
        [_orderService sendRequestWithPostDic:postDataDic andCmdCode:CC_LotteryOrderDetail];
    }else{                      //追号订单详情
        [postDataDic setObject:projid forKey:@"tid"];
        
        //页面大小
        [postDataDic setObject:@"100" forKey:@"ps"];
        //当前页码
        [postDataDic setObject:@"0" forKey:@"pn"];
        //总页数
        [postDataDic setObject:@"0" forKey:@"tp"];
        //总记录数
        [postDataDic setObject:@"0" forKey:@"tr"];
        
        //flag
        [postDataDic setObject:@"19" forKey:@"flag"];
        [_orderService sendRequestWithPostDic:postDataDic andCmdCode:CC_FollowOrderDetail];
    }
    
    
}

- (void)lotteryOrderDetailComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];

    [self refreshDataComplete];
    
    if ([_orderService.errorMsg isEqualToString:@"common.2.userNotLoggedIn"] || [_orderService.errorMsg isEqualToString:L(@"bindIntegral_5015")]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        isLoadOK = NO;
        return;
    }
    
    if (isSuccess) {
        
        isLoadOK = YES;
        //如果详情dto为nil，发送获取订单详情httprequest
        if(_orderService.tradeOrderDetailDto == nil && _orderService.followPeroidArray == nil)
        {
            if([_orderService.errorMsg length] == 0 || _orderService.errorMsg == nil)
            {
                [self sendLotteryOrderDetailHttpRequest];
            }else{
                
                [self removeOverFlowActivityView];
                
                BBAlertView *alert = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:_orderService.errorMsg customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
  
                [alert show];
                

                [self updateTable];
            }
            
            return;
        }
        
        [_orderDetailView removeFromSuperview];
        TT_RELEASE_SAFELY(_orderDetailView);
        [_betNumbersView removeFromSuperview];
        TT_RELEASE_SAFELY(_betNumbersView);
        [_buyPeriodsView removeFromSuperview];
        TT_RELEASE_SAFELY(_buyPeriodsView);
        [_lotteryNumberView removeFromSuperview];
        TT_RELEASE_SAFELY(_lotteryNumberView);
                    
        if (IsStrEmpty(_orderService.errorMsg))
        {
            if(_noDataTipView.superview)
                [_noDataTipView removeFromSuperview];
            
                [self updateTable];
        }
        else
        {
            BBAlertView *alert =  [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:_orderService.errorMsg customView:nil delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
            
            [alert show];
            
            
        }
        
        [self updateTable];
        
    }else{
        isLoadOK = NO;
        
        [self presentSheet:_orderService.errorMsg];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    //需要重新登录
    if([_orderService.errorCode isEqualToString:@"common.2.userNotLoggedIn"] )
    {
        [self removeOverFlowActivityView];
        
        [Config currentConfig].logined = [NSNumber numberWithBool:NO];
        
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        loginViewController.loginDelegate = self;
        loginViewController.loginDidOkSelector = @selector(didLoginOk);
        
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:loginViewController];
        
        [self presentModalViewController:userNav animated:YES];
        
    }
    
    
}


-(void)updateTable{
    
    [self.tableView reloadData];
    
}


#pragma mark - ArrangeListViewControllerDelegate

//点击返回按钮
- (void)goBackWithArrangeListViewController:(ArrangeListViewController *)controller
                     andLotteryOrderListDto:(LotteryOrderListDTO *)dto
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)reloadTableViewDataSource
{
    [super reloadTableViewDataSource];
    
    //是否从支付页面跳转到详情界面
    if([_orderService.listDto isKindOfClass:[LotteryDealsSerialNumberDto class]] && [_orderService.listDto pid] == nil)
    {
        [self sendFollowPeriodProjectHttpRequest];
    }else{
        [self sendLotteryOrderDetailHttpRequest];
    }
}

//登录成功回调
- (void)didLoginOk
{
    [self startRefreshLoading];
}

@end
