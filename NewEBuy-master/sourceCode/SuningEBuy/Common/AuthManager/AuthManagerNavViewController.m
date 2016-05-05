//
//  AuthManagerNavViewController.m
//  
//
//  Created by Hubert Ryan on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthManagerNavViewController.h"
#import "AuthNavigationBar.h"
#import "LotteryNavigationBar.h"
#import <objc/runtime.h>
#import "UserCenter.h"
#import "LoginViewController.h"
#import "ConsultationViewController.h"
#import "ServiceTrackListViewController.h"
#import "MYEfubaoViewController.h"
#import "MyFavoriteViewController.h"
#import "LottertSelectViewController.h"
#import "LotteryDealsViewController.h"
#import "NewProductConsultantViewController.h"
#import "MobilePayQueryViewController.h"
#import "MobilePayViewController.h"
#import "MobilePayByYiFuBaoViewController.h"
#import "OrderSubmitRootViewController.h"
#import "HotelOrderListViewController.h"
#import "MyTicketListViewController.h"
#import "PayServiceQueryViewController.h"
#import "ReceiveInfoViewController.h"
#import "PayServicePaymentViewController.h"
#import "HotelOrderSubmitViewController.h"
#import "LotteryPayPageViewController.h"
#import "GBPayViewController.h"
#import "GBPayByEfubaoViewController.h"
#import "GBOrderListViewController.h"
#import "SKQRCodeReadController.h"
#import "UserConsultantViewController.h"
#import "UserFeedBackNewViewController.h"
#import "IWantconsultViewController.h"
#import "NewGetRedPackEntryViewController.h"

//彩票相关类
#import "LotteryHallViewController.h"
#import "Welfare3DSelectViewController.h"
#import "Welfare3DListViewController.h"
#import "SevenLeListViewController.h"
#import "SevenLeSelectViewController.h"
#import "ArrangeListViewController.h"
#import "ArrangeBallViewController.h"
#import "SevenStarsListViewController.h"
#import "SevenStarsSelectViewController.h"
#import "NoticeViewController.h"
#import "HistoryLotteryCodeViewController.h"
#import "LotteryOrderDetailViewController.h"
#import "LotteryDealsViewController.h"
#import "LotteryPayPageViewController.h"
#import "LotteryListViewController.h"
#import "LotteryProtocolViewController.h"
#import "LottertSelectViewController.h"
#import "LotteryRuleViewController.h"
#import "JASidePanelController.h"
#import "SNGraphics.h"

#import "AllOrderListViewController.h"
#import "AddressInfoListViewController.h"
#import "UserFeedBackController.h"
#import "EvaluationViewController.h"
#import "ReturnGoodsQueryViewController.h"

#import "NewSearchViewController.h"
#import "NewGetRedPackViewController.h"
#import "NewInviteFriendViewController.h"
#import "BrowsingHistoryViewController.h"
// TV扫描支付需要登录，XZoscar add,2014-05-04
#import "PaymentModeViewController.h"

#import "MyCouponViewController.h"
#import "MyCardViewController.h"
#import "AfterSaleViewController.h"
//声波签到
#import "VoiceSignViewController.h"
//因只需要一个array就可以了，故使用一个static变量
//刘坤修改于12-10-31
static NSArray *loginAuthClassArray = nil;

static NSArray *lotteryClassArray = nil;


@implementation AuthManagerNavViewController

@synthesize backgroundView = _backgroundView;

+ (void)initialize
{
    if (self == [AuthManagerNavViewController class]) {
        
        loginAuthClassArray = [[NSArray alloc]  initWithObjects:
                               
                               [ServiceTrackListViewController class],
                               [MYEfubaoViewController class],
                               [MyFavoriteViewController class],
                               [LotteryDealsViewController class],
                               [NewProductConsultantViewController class],
                               [MobilePayQueryViewController class],
                               [MobilePayViewController class],
                               [MobilePayByYiFuBaoViewController class],                                   
                               [OrderSubmitRootViewController class],
                               [HotelOrderListViewController class],
                               [MyTicketListViewController class],
                               [PayServiceQueryViewController class],
                               [ReceiveInfoViewController class],
                               [PayServicePaymentViewController class],
                               [HotelOrderSubmitViewController class],
                               [LotteryPayPageViewController class],
                               [GBPayViewController class],
                               [GBPayByEfubaoViewController class],
                               [GBOrderListViewController class],
                               [SKQRCodeReadController class],
                               [UserConsultantViewController class],
                               [GBPayViewController class],
                               [AllOrderListViewController class],
                               //[BrowsingHistoryViewController class],
                               //[AddressInfoListViewController class],
                               // [UserFeedBackController class],
                               [EvaluationViewController class],
                               [ReturnGoodsQueryViewController class],
                               //[UserFeedBackNewViewController class],
                               [NewInviteFriendViewController class],
                               [NewGetRedPackViewController class],
                               [PaymentModeViewController  class], // TV扫码支付需要登录
                               [MyCouponViewController class],
                               //[MyCardViewController class],
                               [AfterSaleViewController class],
                               //[ConsultationViewController class],
                               [IWantconsultViewController class],
                               [NewGetRedPackEntryViewController class],
                               [VoiceSignViewController class],
                               NSClassFromString(@"MyIntegralExchangeViewController"),
                               nil];

        lotteryClassArray =  [[NSArray alloc]  initWithObjects:
                              [LotteryHallViewController class],
                              [Welfare3DListViewController class],
                              [Welfare3DSelectViewController class],
                              [SevenLeListViewController class],
                              [SevenLeSelectViewController class],
                              [ArrangeBallViewController class],
                              [ArrangeListViewController class],
                              [SevenStarsListViewController class],
                              [SevenStarsSelectViewController class],
                              [NoticeViewController class],
                              [HistoryLotteryCodeViewController class],
                              [LotteryOrderDetailViewController class],
                              [LotteryDealsViewController class],
                              [LotteryPayPageViewController class],
                              [LotteryListViewController class],
                              [LotteryProtocolViewController class],
                              [LottertSelectViewController class],
                              [LotteryRuleViewController class],
                              nil];
    }
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_backgroundView);
    
}

- (id)initWithRootViewController:(UIViewController *)rootViewController{
	
    return [self initWithRootViewController:rootViewController hasTopRoundCorner:YES];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController hasTopRoundCorner:(BOOL)isTopRound
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        isLastStatus = NO;
		[self setNavigationBackground:NO];
        
        self.delegate = self;
        
        if ([rootViewController isKindOfClass:[CommonViewController class]])
        {
            if (![(CommonViewController *)rootViewController hasNav])
            {
                self.navigationBarHidden = YES;
            }
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    if (0)
    {
        self.navigationBar.layer.shadowColor = [UIColor lightTextColor].CGColor;
        self.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);
        self.navigationBar.layer.shadowOpacity = 0.25;
        self.navigationBar.layer.shadowRadius = 1;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor uiviewBackGroundColor];
//    [self.view addSubview:self.backgroundView];
//    [self.view sendSubviewToBack:_backgroundView];
}

- (void)changeBarTextColor:(BOOL)isLottery
{
    if (isLottery) {
        self.navigationBar.titleTextAttributes = nil;
    }else
    {
        UIColor *cc = [UIColor flatTextColor];
        NSDictionary * dict =  [NSDictionary dictionaryWithObjectsAndKeys:cc,UITextAttributeTextColor,[NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)],UITextAttributeTextShadowOffset, nil];//[NSDictionary dictionaryWithObject:cc forKey:UITextAttributeTextColor];
        self.navigationBar.titleTextAttributes = dict;
    }
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        CGRect frame = [[UIScreen mainScreen] bounds];
        _backgroundView.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        _backgroundView.backgroundColor = [UIColor view_Back_Color];
//        _backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kNavControllerBackgroundImage]];
    }
    return _backgroundView;
}

#pragma mark -
#pragma mark logon auth

- (BOOL)needLogonAuth:(UIViewController *)viewController{
	BOOL need = NO;
	for (id class in loginAuthClassArray) {
		if ([[viewController class] isSubclassOfClass:class]) {
			need = YES;
			break;
		}
	}
	
	return need;
}

- (BOOL)isLotteryController:(UIViewController *)viewController{
    BOOL isLottery = NO;
	for (id class in lotteryClassArray) {
		if ([[viewController class] isSubclassOfClass:class]) {
			isLottery = YES;
			break;
		}
	}	
	return isLottery;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	if ([self needLogonAuth:viewController]) {
        if (![[UserCenter defaultCenter] isLogined])
        {
            DLog(@"needLogonAuth \n");
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.nextController = viewController;
            loginVC.nextNavigationController = self;
            loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
            TT_RELEASE_SAFELY(loginVC);
            
            [self presentModalViewController:navController animated:YES];
            TT_RELEASE_SAFELY(navController);
            
            return;
        }
				
        if ([self.viewControllers containsObject:viewController]) {
            //[viewController viewWillAppear:animated];
            return;
        }
	}
    
    if ([self isLotteryController:viewController] && !isLastStatus) {
        [self setNavigationBackground:YES];
    }else if(![self isLotteryController:viewController] && isLastStatus){
        [self setNavigationBackground:NO];
    }
	
	[super pushViewController:viewController animated:animated];
    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    [viewController.view addGestureRecognizer:swipeRight];
//    [swipeRight release];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated{
	
	[super dismissModalViewControllerAnimated:animated];
	
	DLog(@"dismissModalViewControllerAnimated \n");
    
}


- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}

- (void)setNavigationBackground:(BOOL)isLottery
{
    if (isLottery)
    {
        [self setNavBarBackgoundWithColor:RGBACOLOR(247, 247, 248, 0.8)];

//        [self setNavBarBackgoundWithColor:RGBACOLOR(198, 50, 53, 1)];
    }
    else
    {
        [self setNavBarBackgoundWithColor:RGBACOLOR(247, 247, 248, 0.8)];
    }
}

- (void)setNavBarBackgoundWithColor:(UIColor *)color
{
    self.navigationBar.alpha = 0.8f;
    if (IOS7_OR_LATER)
    {
        self.navigationBar.barTintColor = color;
    }
    else
    {
        UIImage *image = [UIImage imageWithColor:color size:self.navigationBar.size];

        if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
        {
            [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            self.navigationBar.layer.contents = (id)image.CGImage;
        }
    }
}

#pragma mark ----------------------------- navigationController delegate

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    NSAssert(delegate == self, @"AuthNavViewController can only accept self as delegate");
    [super setDelegate:delegate];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[CommonViewController class]])
    {
        if (![(CommonViewController *)viewController hasNav])
        {
            if (!self.navigationBarHidden) [self setNavigationBarHidden:YES animated:animated];
            
#ifdef __IPHONE_7_0
            
            if (IOS7_OR_LATER && ![[UIApplication sharedApplication] isStatusBarHidden] && ![(CommonViewController *)viewController isIOS7FullScreenLayout])
            {
                //搜索功能全屏布局 modified by chupeng 2014.2.8
                if ([viewController isKindOfClass:[JASidePanelController class]])
                    return;
                
                CGRect bounds = viewController.view.bounds;
                bounds.origin.y = -20;
                viewController.view.bounds = bounds;
            }
#endif
        }
        else
        {
            if (self.navigationBarHidden) [self setNavigationBarHidden:NO animated:animated];
        }
    }
    else
    {
        DLog(@"use CommonViewController as super please");
    }
}

@end
