//
//  CheckInViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CheckInViewController.h"
#import "CICalendarView.h"
#import "LoginViewController.h"
#import "SNSwitch.h"

#import "SNWebViewController.h"
#import "DJGroupRuleView.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "QYaoYiYaoViewCtrler.h"


@interface CheckInViewController () <CICalendarViewDelegate, EGOImageButtonDelegate>
{
    BOOL    isDataLoad;
}

@property (nonatomic, strong) UILabel *continuousResgistrationLabel;
@property (nonatomic, strong) UILabel *currentDateLabel;
@property (nonatomic, strong) UILabel *continueDayNumLabel;
//@property (nonatomic, strong) UIView *bottomRuleView;
//@property (nonatomic, strong) UIButton *blackShadowBtn;
@property (nonatomic, strong) CICalendarView *calendarView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) EGOImageButton *onCouponButton;

@end

@implementation CheckInViewController

- (void)dealloc
{
    _calendarView.delegate = nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
//        self.isNeedBackItem = NO;
//        
//        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(0, 0, 66, 44);
//        view.backgroundColor = [UIColor clearColor];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(5, 0, 46, 44);
//        btn.backgroundColor = [UIColor clearColor];
//        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
//        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [btn setImage:[UIImage imageNamed:@"regist_home_back_btn.png"]
//             forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
//        
//        [view addSubview:btn];
//        
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
//        self.navigationItem.leftBarButtonItem = leftItem;
        
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"MyEBuy_Rules")];
        self.pageTitle = L(@"PageTitleYunzuan_Home_Sign");
        
        self.hidesBottomBarWhenPushed=YES;
        
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)righBarClick
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"531501"], nil]];
    UIWindow *window = self.appDelegate.window;
    
    DJGroupRuleView *ruleView = [[DJGroupRuleView alloc]initWithFrame:window.bounds andTitle:L(@"internal rule") andText:self.checkInDto.checkRuleDesc];
    
    [ruleView showInView:window];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isDataLoad) {
        [self refreshData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.scrollView];
    
    self.calendarView = [[CICalendarView alloc] initWithDelegate:self dataSource:self.checkInDto];
    self.calendarView.top = 40; self.calendarView.left = (320-kCICalendarWidth)/2;
    [self.scrollView addSubview:self.calendarView];
    self.title = self.checkInDto.checkTitle;
        
    if ([UserCenter defaultCenter].isLogined)
    {
        self.continueDayNumLabel.text = [NSString stringWithFormat:@"%@%@",self.checkInDto.checkCount?self.checkInDto.checkCount:@"",L(@"GBDay")] ;
    }
    else
    {
        self.continueDayNumLabel.text = [NSString stringWithFormat:@"0%@",L(@"GBDay")] ;
    }
    
    
    
    [self.scrollView addSubview:self.continueDayNumLabel];
    [self.scrollView addSubview:self.continuousResgistrationLabel];
    
    self.currentDateLabel.text= [NSString stringWithFormat:@"%d%@%d%@%d%@",
                                 self.checkInDto.currentDate.year,L(@"Product_Year"),
                                 self.checkInDto.currentDate.month,L(@"Product_Month"),
                                 self.checkInDto.currentDate.day,L(@"Product_Day")];
    [self.scrollView addSubview:self.currentDateLabel];
    
//    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
//    self.bottomRuleView.top = frame.size.height-25;
//    [self.view addSubview:self.bottomRuleView];
  
/*
 2014-04-16 21:13:00 ,需求要求 去掉领券入口 ,By XZoscar
*/
/*
    //添加领券入口
    NSURL *imageUrl = nil, *webUrl = nil;
    if ([SNSwitch isOnCouponForImageUrl:&imageUrl webUrl:&webUrl])
    {
        self.onCouponButton.imageURL = imageUrl;
        [self.scrollView addSubview:self.onCouponButton];
        
        __unsafe_unretained CheckInViewController *weakSelf = self;
        self.calendarView.gridContentHeightChangeBlock = ^{
            
            [weakSelf sizeToFitOnCouponButton];
        };
        
        [self sizeToFitOnCouponButton];
    }
*/
    
/*
 2014-04-16 21:13:00 ,需求要求 添加摇易摇入口 , XZoscar add
*/
    if (!_bYaoYiYaoEntrance) { //
        //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            NSString *entranceUrl = [SNSwitch yaoYiYaoEntranceAtQianDao];
            if (nil != entranceUrl
                && [entranceUrl hasPrefix:@"http"]) {
                //dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.onCouponButton.imageURL = [NSURL URLWithString:entranceUrl];
                    [self.scrollView addSubview:self.onCouponButton];
                
                    CheckInViewController *__weak weakSelf = self;
                    self.calendarView.gridContentHeightChangeBlock = ^{
                        
                        [weakSelf sizeToFitOnCouponButton];
                    };
                    
                    [self sizeToFitOnCouponButton];
                    
                //});
            }
        //});
    }
}

#pragma mark ----------------------------- onCoupon button delegate

- (void)imageButtonLoadedImage:(EGOImageButton *)imageButton
{
    CGFloat w = imageButton.currentImage.size.width;
    CGFloat h = imageButton.currentImage.size.height;
    self.onCouponButton.height = h * 300 /w;
    [self sizeToFitOnCouponButton];
}

- (void)sizeToFitOnCouponButton
{
    self.onCouponButton.top = self.calendarView.gridContentView.bottom + self.calendarView.top + 40;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.onCouponButton.bottom+10);
}

- (void)goToGetCoupon
{
    NSURL *imageUrl = nil, *webUrl = nil;
    if ([SNSwitch isOnCouponForImageUrl:&imageUrl webUrl:&webUrl] && webUrl)
    {
        SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": [webUrl absoluteString]}];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Calendar Delegate Method

- (void)reloadViews
{
    if ([UserCenter defaultCenter].isLogined)
    {
        self.continueDayNumLabel.text = [NSString stringWithFormat:@"%@%@",self.checkInDto.checkCount,L(@"GBDay")] ;
    }
    else
    {
        self.continueDayNumLabel.text = [NSString stringWithFormat:@"0%@",L(@"GBDay")] ;
    }
    
    self.currentDateLabel.text = [NSString stringWithFormat:@"%d%@%d%@%d%@",
                                 self.checkInDto.currentDate.year,L(@"Product_Year"),
                                 self.checkInDto.currentDate.month,L(@"Product_Month"),
                                 self.checkInDto.currentDate.day,L(@"Product_Day")];
    
    [self.calendarView reloadWithDatasource:self.checkInDto];
}

- (void)updateContiueDays
{
    CICheckState todayState = [self.checkInDto checkStateInDate:self.checkInDto.currentDate];
    CICheckState yesterdayState = [self.checkInDto checkStateInDate:self.checkInDto.currentDate.yesterday];
    if (todayState == yesterdayState)
    {
        self.checkInDto.checkCount = STR_FROM_INT([self.checkInDto.checkCount intValue]+1);
        self.continueDayNumLabel.text = [NSString stringWithFormat:@"%@%@",self.checkInDto.checkCount,L(@"GBDay")];
    }
    else
    {
        self.checkInDto.checkCount = @"1";
        self.continueDayNumLabel.text = [NSString stringWithFormat:@"%@%@",self.checkInDto.checkCount,L(@"GBDay")];
    }
}

- (void)showMessage:(RegistrationDetailDTO *)dto
{
    NSString *detailStr = nil;
    if ([dto.isSucess isEqualToString:@"1"]) {
        if (![dto.largessPoints isEqualToString:@"0"] && ![dto.couponValue isEqualToString:@"0"]) {
            detailStr = [NSString stringWithFormat:@"%@%@%@+%@优惠券",L(@"CheckIn_RegisterSuccessAndGet"),dto.largessPoints ,L(@"Integeral"), dto.couponValue,L(@"coupon")];
        }
        else if ([dto.largessPoints isEqualToString:@"0"] && ![dto.couponValue isEqualToString:@"0"])
        {
            detailStr = [NSString stringWithFormat:@"%@%@%@",L(@"CheckIn_RegisterSuccessAndGet"), dto.couponValue,L(@"coupon")];
        }
        else
        {
            detailStr = [NSString stringWithFormat:@"%@%@%@",L(@"CheckIn_RegisterSuccessAndGet"),dto.largessPoints,L(@"Integeral")];
        }
        
        [self presentSheet:L(@"Registration Success") subMessage:detailStr posY:295];
    }
    else
    {
        detailStr = dto.errorMessage.trim.length?dto.errorMessage:L(@"CheckIn_CheckNetworkOrRetry");
        [self presentSheet:L(@"CheckIn_SomethingGoWrong") subMessage:detailStr posY:295];
    }
}

#pragma mark - Customer Controls

- (UILabel *)continuousResgistrationLabel
{
    if (!_continuousResgistrationLabel) {
        _continuousResgistrationLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 20, 60, 20)];
        _continuousResgistrationLabel.textAlignment = UITextAlignmentLeft;
        _continuousResgistrationLabel.text=L(@"Continuous Resgistration:");
        _continuousResgistrationLabel.font = [UIFont systemFontOfSize:12];
        _continuousResgistrationLabel.textColor = [UIColor light_Black_Color];
        _continuousResgistrationLabel.backgroundColor = [UIColor clearColor];
        
    }
    return _continuousResgistrationLabel;
}

- (UILabel *)continueDayNumLabel
{
    if (!_continueDayNumLabel) {
        _continueDayNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(71, 20, 60, 20)];
        _continueDayNumLabel.textAlignment = UITextAlignmentLeft;
        _continueDayNumLabel.font = [UIFont systemFontOfSize:12];
        _continueDayNumLabel.textColor = [UIColor orange_Light_Color];
        _continueDayNumLabel.backgroundColor = [UIColor clearColor];
    }
    return _continueDayNumLabel;
}

- (UILabel *)currentDateLabel
{
    if (!_currentDateLabel) {
        _currentDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 20, 100, 20)];
        _currentDateLabel.textAlignment = UITextAlignmentRight;
        _currentDateLabel.font = [UIFont systemFontOfSize:12];
        _currentDateLabel.textColor = [UIColor light_Black_Color];
        _currentDateLabel.backgroundColor = [UIColor clearColor];
    }
    return _currentDateLabel;
}

//- (UIView *)bottomRuleView
//{
//    if (!_bottomRuleView) {
//        _bottomRuleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25+225)];
//        
//        UIImageView *arrawUpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
//        [arrawUpImageView setImage:[UIImage imageNamed:@"qiandaoguizhexia_icon@2x.png"]];
//        arrawUpImageView.tag = 101;
//        [_bottomRuleView addSubview:arrawUpImageView];
//        
//        UIImageView *arrawDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
//        [arrawDownImageView setImage:[UIImage imageNamed:@"qiandaoguizhe_icon@2x.png"]];
//        arrawDownImageView.tag = 102;
//        arrawDownImageView.hidden = YES;
//        [_bottomRuleView addSubview:arrawDownImageView];
//        
//        UIImageView *contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 320, 225)];
//        [contentImageView setImage:[UIImage imageNamed:@"ruleContent_background@2x.png"]];
//        [_bottomRuleView addSubview:contentImageView];
//        
//        UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(109, 0, 101, 25)];
//        [upBtn addTarget:self action:@selector(showRule) forControlEvents:UIControlEventTouchUpInside];
//        upBtn.backgroundColor = [UIColor clearColor];
//        upBtn.userInteractionEnabled = YES;
//        upBtn.tag = 103;
//        [_bottomRuleView addSubview:upBtn];
//        
//        UIButton *downBtn = [[UIButton alloc] initWithFrame:CGRectMake(109, 0, 101, 25)];
//        [downBtn addTarget:self action:@selector(hideRule) forControlEvents:UIControlEventTouchUpInside];
//        downBtn.backgroundColor = [UIColor clearColor];
//        downBtn.userInteractionEnabled = YES;
//        downBtn.hidden=YES;
//        downBtn.tag = 104;
//        [_bottomRuleView addSubview:downBtn];
//        
//        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, 293, 212)];
//        textView.backgroundColor = [UIColor clearColor];
//        textView.font = [UIFont systemFontOfSize:12];
//        textView.textColor = RGBCOLOR(180, 135, 88);
//        textView.textAlignment = UITextAlignmentLeft;
//        textView.editable = NO;
//        textView.text = [NSString stringWithFormat:@"        %@",self.checkInDto.checkRuleDesc];
//        [_bottomRuleView addSubview:textView];
//    }
//    return _bottomRuleView;
//}
//
//- (UIView *)blackShadowBtn
//{
//    if (!_blackShadowBtn) {
//        _blackShadowBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//        _blackShadowBtn.backgroundColor = [UIColor blackColor];
//        [_blackShadowBtn addTarget:self action:@selector(hideRule) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _blackShadowBtn;
//}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (EGOImageButton *)onCouponButton
{
    if (!_onCouponButton) {
        _onCouponButton = [[EGOImageButton alloc] init];
        _onCouponButton.delegate = self;
        _onCouponButton.frame = CGRectMake(10, 0, 300, 0);
        _onCouponButton.placeholderImage = nil;
        [_onCouponButton addTarget:self
                            action:@selector(/*goToGetCoupon*/goToYaoYiYao)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _onCouponButton;
}

/*
// Function    : goToYaoYiYao
// Description : 签到页面，进入摇易摇
// Date        : 2014-04-16 21:40:00
// Author      : XZoscar
*/

- (void)goToYaoYiYao {
    // 云钻摇易摇
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"531601"], nil]];
    QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:1];
    [self.navigationController pushViewController:ctrler animated:YES];
}

#pragma mark -
#pragma mark 签到

- (RegistrationService *)service
{
    if (!_service) {
        _service = [[RegistrationService alloc] init];
        _service.delegate= self;
    }
    return _service;
}

- (void)loginCancel
{
    
}

- (void)loginSuccess
{
    [self refreshData];
}

- (void)refreshData
{
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    [self displayOverFlowActivityView];
    [self.service beginSendRegistrationPrepareRequest:userId];
}

- (void)didSendRegistrationPrepareRequestComplete:(RegistrationService *)service Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        isDataLoad = YES;
        self.checkInDto = service.checkInDto;
        self.title = self.checkInDto.checkTitle;
        [self reloadViews];
    }
    else
    {
        [self presentSheet:service.errorMsg?service.errorMsg:kSERVERBUSY_ERRORDESC];
    }
}

- (void)didSelectGridView:(CICalendarGridView *)gridView forDate:(CIDate *)date
{
    //如果未登录，先登录
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"531401"], nil]];
    if (![UserCenter defaultCenter].isLogined)
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        loginViewController.loginDelegate = self;
        loginViewController.loginDidOkSelector = @selector(loginSuccess);
        loginViewController.loginDidCancelSelector = @selector(loginCancel);
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                  initWithRootViewController:loginViewController];
        [self presentModalViewController:userNav animated:YES];
        return;
    }
    
    if ([date isEqual:self.checkInDto.currentDate])
    {
        if ([self.checkInDto.isCheck isEqualToString:@"0"]) {
            [self displayOverFlowActivityView];
            RegistrationDetailBaseDTO *detailBaseDto = [[RegistrationDetailBaseDTO alloc] init];
            detailBaseDto.userId = [UserCenter defaultCenter].userInfoDTO.userId;
            detailBaseDto.checkType = @"0";
            detailBaseDto.distance = @"0";
            detailBaseDto.latitudeAndLongitude = @"0_0";
            detailBaseDto.checkCodeId = self.checkInDto.checkType;
            detailBaseDto.storeId = @"";
            detailBaseDto.custNum = [UserCenter defaultCenter].userInfoDTO.custNum;
            [self.service beginSendRegistrationDetailRequest:detailBaseDto];
        }else
        {
            [self presentSheet:L(@"CheckIn_RegisterAlreadyToday")];
        }
    }
}

- (void)didSendRegistrationDetailRequestComplete:(RegistrationService *)service
                                          Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        [self showMessage:service.registDetailDto];
        
        if ([service.registDetailDto.isSucess isEqualToString:@"1"])
        {
            [self.checkInDto setStateCheckedToToday];
            [self updateContiueDays];
            [self.calendarView reloadWithDatasource:self.checkInDto];
        }
    }
    else
    {
        [self showMessage:service.registDetailDto];
    }
}

#pragma mark - Custom Method

- (void)toggleBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)showRule
//{
//    self.blackShadowBtn.alpha = 0;
//    [UIView animateWithDuration:0.5f animations:^{
//        self.bottomRuleView.top -= 225;
//        for (UIImageView *imageView in self.bottomRuleView.subviews) {
//            if (imageView.tag == 101) {
//                imageView.hidden = YES;
//            }
//            if (imageView.tag == 102) {
//                imageView.hidden = NO;
//            }
//        }
//        
//        for (UIButton *button in self.bottomRuleView.subviews) {
//            if (button.tag == 103) {
//                button.hidden = YES;
//            }
//            if (button.tag == 104) {
//                button.hidden = NO;
//            }
//        }
//        self.blackShadowBtn.alpha = 0.5;
//        [self.view insertSubview:self.blackShadowBtn belowSubview:self.bottomRuleView];
//    }];
//}
//
//-(void)hideRule
//{
//    [UIView animateWithDuration:0.5f animations:^{
//        self.bottomRuleView.top += 225;
//        for (UIImageView *imageView in self.bottomRuleView.subviews) {
//            if (imageView.tag == 101) {
//                imageView.hidden = NO;
//            }
//            if (imageView.tag == 102) {
//                imageView.hidden = YES;
//            }
//        }
//        
//        for (UIButton *button in self.bottomRuleView.subviews) {
//            if (button.tag == 103) {
//                button.hidden = NO;
//            }
//            if (button.tag == 104) {
//                button.hidden = YES;
//            }
//        }
//        self.blackShadowBtn.alpha = 0;
//    }completion:^(BOOL finished){
//        [self.blackShadowBtn removeFromSuperview];
//    }];
//}


@end
