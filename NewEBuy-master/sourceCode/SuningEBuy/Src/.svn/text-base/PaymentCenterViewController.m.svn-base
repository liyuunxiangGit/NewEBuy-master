//
//  PaymentCenterViewController.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PaymentCenterViewController.h"
#import "MobileRechargeViewController.h"

#import "SNSwitch.h"
#import "LoginViewController.h"
#import "SNWebViewController.h"

@interface PaymentCenterViewController ()
{
    MobilePaymentView *_mobilePaymentView;
    WaterElectricGasPaymentView *_WEGPaymentView;
    SNWebViewController *_eppChargeView;
    
    BOOL isEppChargeLoaded;
    BOOL isEppChargeLoading;
    BOOL isFirstChangeSeg;
}

@property (nonatomic, strong) MobilePaymentView *mobilePaymentView;
@property (nonatomic, strong) SNWebViewController *eppChargeView;

@property (nonatomic, strong) CustomSegment *segment;

@end

@implementation PaymentCenterViewController


- (void)dealloc
{
    //add by zhangbeibei 20140810:解决缴纳水费成功点击确定，程序崩溃的问题。单号5876
//    TT_RELEASE_SAFELY(_mobilePaymentView);
//    TT_RELEASE_SAFELY(_WEGPaymentView);
    _segment.delegate = nil;
//    TT_RELEASE_SAFELY(_segment);
    
}

- (void)lostKeyboard
{
    [self.eppChargeView.webView stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}



-(id)init
{
    self = [super init];
    if (self)
    {
        isFirstChangeSeg = YES;
        
        self.title = L(@"rechargePayment");
        
        self.pageTitle = L(@"finance_chargeCenter");
        
        self.hidesBottomBarWhenPushed =YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.segment];
    
    [self.view addSubview:self.mobilePaymentView];
    self.mobilePaymentView.hidden = NO;
    self.mobilePaymentView.isActivity = YES;
    self.WEGPaymentView.hidden = YES;
    self.eppChargeView.view.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //检查易付宝登录
    if (self.segment.currentIndex == 2) {
        if (!self.user)
        {
            [self checkLoginWithLoginedBlock:^{
                [[self segment] setCurrentIndex:2];
            } loginCancelBlock:^{
                [[self segment] setCurrentIndex:0];
            }];
            return;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.WEGPaymentView.payRegionTextField resignFirstResponder];
    [self.WEGPaymentView.payCompanyTextField resignFirstResponder];
    [self.WEGPaymentView.payAccountTextField resignFirstResponder];
}

#pragma mark - Custom Controls

- (void)setSegmentIndex:(NSInteger)index
{
    if (index < 3 && index >= 0)
    {
        self.segment.currentIndex = index;
    }
}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    [self removeOverFlowActivityView];
    if (index == 0)
    {
        [self lostKeyboard];
        self.mobilePaymentView.hidden=NO;
        self.mobilePaymentView.isActivity=YES;
        
        self.WEGPaymentView.hidden = YES;
        self.eppChargeView.view.hidden = YES;
        [self.WEGPaymentView.payRegionTextField resignFirstResponder];
        [self.WEGPaymentView.payCompanyTextField resignFirstResponder];
        [self.WEGPaymentView.payAccountTextField resignFirstResponder];
    }
    else if (index == 1)
    {
        self.mobilePaymentView.hidden=YES;
        self.mobilePaymentView.isActivity=NO;

        [self lostKeyboard];
        [self.view addSubview:self.WEGPaymentView];

        if (isFirstChangeSeg) {
            [self.WEGPaymentView dataInit];
            isFirstChangeSeg = NO;
        }else{
            [self.WEGPaymentView viewAppear];
        }
        
        self.WEGPaymentView.hidden = NO;
        self.eppChargeView.view.hidden = YES;
    }
    else if (index == 2)
    {
        if (!self.user)
        {
            [self checkLoginWithLoginedBlock:^{
                [[self segment] setCurrentIndex:2];
            } loginCancelBlock:^{
                [[self segment] setCurrentIndex:0];
            }];
            return;
        }
        else if (!self.isEppActive)
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:L(@"VPDoYouWantToActivateEbuy")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Cancel")
                                                  otherButtonTitles:L(@"Ok")];
            [alert setCancelBlock:^{
                [[self segment] setCurrentIndex:0];
            }];
            [alert setConfirmBlock:^{
                [[self segment] setCurrentIndex:0];
                [self jumpToActivityEfubao];
            }];
            [alert show];
            return;
        }
        self.mobilePaymentView.hidden=YES;
        self.mobilePaymentView.isActivity=NO;
                
        if (!self.eppChargeView.view.superview) {
            [self.eppChargeView willMoveToParentViewController:self];
            [self addChildViewController:self.eppChargeView];
            [self.view addSubview:self.eppChargeView.view];
            [self.eppChargeView didMoveToParentViewController:self];
        }
        
        self.WEGPaymentView.hidden = YES;
        self.eppChargeView.view.hidden = NO;
        [self.WEGPaymentView.payRegionTextField resignFirstResponder];
        [self.WEGPaymentView.payCompanyTextField resignFirstResponder];
        [self.WEGPaymentView.payAccountTextField resignFirstResponder];
        
        if (!isEppChargeLoaded && !isEppChargeLoading)
        {
            NSString *url = [NSString stringWithFormat:@"%@/%@", kEppHostAddress, kMobileEppShowCharge];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            self.eppChargeView.request = request;
            [self.eppChargeView loadRequest];
            
        }
    }
}

- (CustomSegment *)segment
{
    if (!_segment)
    {
        _segment = [[CustomSegment alloc] init];
        _segment.delegate = self;
        if ([SNSwitch isOpenWebEppCharge])
        {
            [_segment setItems:@[L(@"Mobile Payment"), L(@"WaterElectricGas Payment"), L(@"Efubao")]];
        }
        else
        {
            [_segment setItems:@[L(@"Mobile Payment"), L(@"WaterElectricGas Payment")]];
        }
    }
    return _segment;
}

-(MobilePaymentView *)mobilePaymentView
{
    if (!_mobilePaymentView) {
        _mobilePaymentView = [[MobilePaymentView alloc] initWithContentController:self];
        _mobilePaymentView.frame = CGRectMake(0, self.segment.height, 320, self.view.height-self.segment.height-44);
    }
    return _mobilePaymentView;
}

-(WaterElectricGasPaymentView *)WEGPaymentView
{
    if (!_WEGPaymentView) {
        _WEGPaymentView=[[WaterElectricGasPaymentView alloc] initWithContentController:self];
        _WEGPaymentView.frame = CGRectMake(0, self.segment.height, 320, self.view.height-self.segment.height-44);
    }
    return _WEGPaymentView;
}

- (SNWebViewController *)eppChargeView
{
    if (!_eppChargeView) {
        NSString *url = [NSString stringWithFormat:@"%@/%@", kEppHostAddress, kMobileEppShowCharge];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        
        _eppChargeView=[[SNWebViewController alloc] initWithType:SNWebViewTypeEppCharge attributes:@{@"request": request}];
        _eppChargeView.webView.backgroundColor = [UIColor whiteColor];
        _eppChargeView.view.frame = CGRectMake(0, self.segment.height, 320, self.view.height-self.segment.height-44);
    }
    return _eppChargeView;
}

@end
