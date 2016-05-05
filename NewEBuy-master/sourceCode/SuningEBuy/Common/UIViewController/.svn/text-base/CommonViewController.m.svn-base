
//
//  CommonViewController.m
//  WingLetter
//
//  Created by zhaojw on 10-10-11.
//  Copyright 2010 Wingletter. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"
#import "MBProgressHUD.h"
#import "AuthManagerNavViewController.h"
#import "LoginViewController.h"
#import "SNSwitch.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "ScreenShotNavViewController.h"
#import "RightSideToolView.h"
#import "SNGraphics.h"
#import "SNWebViewController.h"
#import "PruductList244ViewController.h"
#import "SalePromotionViewController.h"
#import "SecondPageViewController.h"

// XZoscar add 2014-06-18
// 首页 navigation controller
AuthManagerNavViewController *__gNavController0;
NSString *sourceTitle;
NSString *sourcePageTitle;//渠道详情
NSString *daoTitle;//来源页面的渠道
NSString *daoPageTitle;//渠道详情
NSString *erWeiMaDanPageTitle;
NSString *erWeiMaPageTitle;//渠道详情
NSString *remotePageTitle;
NSString *searchTitle;
@interface CommonViewController() 
{
    
}

@end

//@interface UITableView(UIPanGes)
//- (void)setDataSource:(id<UITableViewDataSource>)dataSource;
//@end
//
//@implementation UITableView(UIPanGes)
//- (void)setDataSource:(id<UITableViewDataSource>)dataSource
//{
//    [super ]


//}
//@end

@implementation CommonViewController

@synthesize  tableView = _tableView;

@synthesize  groupTableView = _groupTableView;

@synthesize tpTableView = _tpTableView;

@synthesize tpGroupTableView = _tpGroupTableView;

@synthesize  dlgTimer = _dlgTimer;

@synthesize pageInTime = _pageInTime;

@synthesize isNeedBackItem = _isNeedBackItem;

@synthesize rightBtnItem = _rightBtnItem;

@synthesize titleViewLabel = _titleViewLabel;

@synthesize isLotteryController = _isLotteryController;

@synthesize hasSuspendButton = _hasSuspendButton;

@synthesize iOS7FullScreenLayout = _iOS7FullScreenLayout;

+ (id)controller
{
    return [[self alloc] init];
}

- (id)init{
	
    self = [super init];
	
    if (self) {
        self.isLotteryController = NO;
        self.isNeedBackItem = YES;
        self.hasNav = YES;
        self.bSupportPanUI = YES;
        self.iOS7FullScreenLayout = NO;
        
    }
    return self;
}

/*
 // Function : initWithNibName: bundle:
 // Description : load view from xib
 // Date : 2014-04-03 11:00:00
 // Author : XZoscar
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.isLotteryController = NO;
        self.isNeedBackItem = YES;
        self.hasNav = YES;
        self.bSupportPanUI = YES;
        
        //self.iOS7FullScreenLayout = NO;
    }
    
    return self;
}

- (void)setIOS7FullScreenLayout:(BOOL)iOS7FullScreenLayout
{
    _iOS7FullScreenLayout = iOS7FullScreenLayout;
    if (IOS7_OR_LATER)
    {
        if (_iOS7FullScreenLayout)
        {
            self.edgesForExtendedLayout = UIRectEdgeAll;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
        else
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (void)HttpRelease
{
    
}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_titleViewLabel);
    
    TT_RELEASE_SAFELY(_rightBtnItem);
    
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    TT_RELEASE_SAFELY(_tableView);
    
    _groupTableView.dataSource = nil;
    _groupTableView.delegate = nil;
    TT_RELEASE_SAFELY(_groupTableView);
    
    _tpTableView.dataSource = nil;
    _tpTableView.delegate = nil;
    TT_RELEASE_SAFELY(_tpTableView);
    
    _tpGroupTableView.delegate = nil;
    _tpGroupTableView.dataSource = nil;
    TT_RELEASE_SAFELY(_tpGroupTableView);
    
    [_dlgTimer invalidate];
    TT_RELEASE_SAFELY(_dlgTimer);
    
    TT_RELEASE_SAFELY(_pageInTime);
    
    TT_RELEASE_SAFELY(_specialViewTitle);
    
    [self dismissAllCustomAlerts];
    
    [self HttpRelease];
    
    [SNRouter cancelCurrentTask];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
//    if (!self.isLotteryController) {
        UILabel *_titleView = [[UILabel alloc] init];
        _titleView.textColor = [UIColor colorWithRGBHex:0x313131];
//        _titleView.shadowColor = [UIColor navTintColor];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.font = [UIFont systemFontOfSize:19.0f];
        _titleView.textAlignment = NSTextAlignmentCenter;

//        CGSize size = [title sizeWithFont:_titleView.font];
//        _titleView.frame = CGRectMake(0, 5, size.width, 34);
        CGRect frame = _titleView.frame;
        if (!IOS6_OR_LATER) {
            frame.size.width = 120;
        }
        _titleView.frame = CGRectMake(frame.origin.x, 5, frame.size.width, 34);
        self.navigationItem.titleView = _titleView;
        _titleView.text = title;
        
//    }else{
//        self.navigationItem.titleView = nil;
//    }
}

- (UILabel *)titleViewLabel
{
    if (!_titleViewLabel) {
        _titleViewLabel = [[UILabel alloc] init];
        _titleViewLabel.textColor = [UIColor colorWithRGBHex:0x776D61];
        _titleViewLabel.shadowColor = [UIColor navTintColor];
        _titleViewLabel.backgroundColor = [UIColor clearColor];
        _titleViewLabel.font = [UIFont boldSystemFontOfSize:21.0];
        _titleViewLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleViewLabel;
}

- (void)setHasSuspendButton:(BOOL)hasSuspendButton
{
    _hasSuspendButton = hasSuspendButton;
    
    if (_hasSuspendButton)
    {
        [self.view addSubview:self.suspendButton];
    }
    else
    {
        [_suspendButton removeFromSuperview];
        self.suspendButton = nil;
    }
}

- (void)setHasAnalyzeButton:(BOOL)hasAnalyzeButton
{
    _hasAnalyzeButton = hasAnalyzeButton;
    
    if (_hasAnalyzeButton)
    {
        [self.view addSubview:self.analyzeButton];
    }
    else
    {
        [_analyzeButton removeFromSuperview];
        self.analyzeButton = nil;
    }
}

- (UIButton *)suspendButton
{
    if (!_suspendButton)
    {
        _suspendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _suspendButton.frame = CGRectMake(263, 0, 44, 44);
        [_suspendButton setBackgroundColor:[UIColor clearColor]];
        [_suspendButton setImage:[UIImage imageNamed:@"yi_suspend_btn.png"]
                        forState:UIControlStateNormal];
        
//        [_suspendButton setTitle:@"易" forState:UIControlStateNormal];
//        [_suspendButton setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
//        
//        _suspendButton.backgroundColor = RGBACOLOR(255, 255, 255, 0.7);
//        _suspendButton.frame = CGRectMake(260, 0, 50, 50);
//        _suspendButton.layer.zPosition = 2;
//       
//        _suspendButton.layer.cornerRadius = 25.;
//        _suspendButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _suspendButton.layer.borderWidth = 0.5;
        [_suspendButton addTarget:self
                           action:@selector(showRightSideView)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _suspendButton;
}

- (UIButton *)analyzeButton
{
    if (!_analyzeButton)
    {
        _analyzeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _analyzeButton.frame = CGRectMake(263, 160, 44, 44);
        [_analyzeButton setBackgroundColor:[UIColor redColor]];
        [_analyzeButton setTitle:@"抓包" forState:UIControlStateNormal];
        
        [_analyzeButton addTarget:self
                           action:@selector(showAnalyzeView)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _analyzeButton;
}

- (void)showAnalyzeView
{
    [[AnalyzeViewController sharedAnalyzeViewController] showAnalyzeView];
}

//订单底部易购按钮展示侧滑
- (void)orderYiGouBtnShowRightSideView
{
    [self showRightSideView];
}

- (void)showRightSideView
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"820501"], nil]];
    [RightSideToolView show];
}

- (BottomNavBar *)bottomNavBar
{
    if (!_bottomNavBar) {
        _bottomNavBar = [[BottomNavBar alloc] init];
        _bottomNavBar.layer.zPosition = 1;
        [_bottomNavBar.backButton addTarget:self
                                     action:@selector(backForePage)
                           forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomNavBar.ebuyBtn addTarget:self
                                  action:@selector(showRightSideView)
                        forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomNavBar;
}

- (void)useBottomNavBar
{
    self.bottomNavBar.visible = YES;
    [self.view addSubview:self.bottomNavBar];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (_bottomNavBar.visible)
    {
        _bottomNavBar.bottom = self.view.bounds.size.height + self.view.bounds.origin.y;
    }
    
    if (_suspendButton)
    {
        _suspendButton.bottom = self.view.bounds.size.height + self.view.bounds.origin.y - 10 - 10;
        
        if (!_suspendButton.superview) {
            [self.view addSubview:_suspendButton];
        }
    }
    
    if (_analyzeButton)
    {
        _analyzeButton.bottom = 160;
        
        if (!_analyzeButton.superview) {
            [self.view addSubview:_analyzeButton];
        }
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (_bottomNavBar.visible)
    {
        if (_bottomNavBar != self.view.subviews.lastObject)
        {
            [self.view bringSubviewToFront:_bottomNavBar];
        }
        
        UIScrollView *rsv = nil;
        for (UIView *subView in self.view.subviews)
        {
            if ([subView isKindOfClass:[UIScrollView class]])
            {
                rsv = (UIScrollView *)subView;
                break;
            }
        }
        if (rsv && rsv.bottom > _bottomNavBar.top)
        {
            UIEdgeInsets oldInset = rsv.contentInset;
            rsv.contentInset = UIEdgeInsetsMake(oldInset.top, oldInset.left, rsv.bottom-_bottomNavBar.top, oldInset.right);
        }
    }
    
    if (_suspendButton)
    {
        if (_suspendButton != self.view.subviews.lastObject)
        {
            [self.view bringSubviewToFront:_suspendButton];
        }
    }
    
    if (_analyzeButton)
    {
        if (_analyzeButton != self.view.subviews.lastObject)
        {
            [self.view bringSubviewToFront:_analyzeButton];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if ([self.pageTitle isEqualToString:L(@"PageTitleFirstPageShow")])
    {
        [self snclick_viewWillAppear];
    }
    if (self.isNeedBackItem) {
        
        SNUIBarButtonItem *item = [SNUIBarButtonItem itemWithTitle:nil
                                                             Style:SNNavItemStyleBack
                                                            target:self
                                                            action:@selector(backForePage)];
        self.navigationItem.leftBarButtonItem = item;
    }

    if (IOS7_OR_LATER) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }

    DLog(@"sourcePageTitle:%@",sourcePageTitle);

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([sourcePageTitle length] == 0)
    {
        sourcePageTitle = [NSString stringWithFormat:@"%@",self.
                           pageTitle];
    }
    else
    {
        sourcePageTitle = [NSString stringWithFormat:@"%@_%@",sourcePageTitle,self.pageTitle];
    }
    [self snclick_viewWillAppear];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self snclick_viewWillDisappear];
}

- (void)backForePage
{
    DLog(@"sourcePageTitle:%@",sourcePageTitle);
    DLog(@"sourcePageTitle_backForePage");
    sourcePageTitle = nil;
    daoPageTitle = nil;
    //erWeiMaPageTitle = nil;
    //remotePageTitle = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self snclick_viewWillDisappear];
}

- (void)loadView
{
	[super loadView];
//    self.hasAnalyzeButton = YES;
    [self.view setExclusiveTouch:YES];
    self.view.backgroundColor = [UIColor uiviewBackGroundColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIBarButtonItem *)rightBtnItemWithTitle:(NSString *)name
{
    if (!_rightBtnItem) {
        
        _rightBtnItem = [SNUIBarButtonItem itemWithTitle:name
                                                   Style:SNNavItemStyleDone
                                                  target:self
                                                  action:@selector(righBarClick)];
    }
    return _rightBtnItem;
}

- (void)righBarClick
{
    
}

- (void)setDlgTimer:(NSTimerHelper *)dlgTimer
{
    if (dlgTimer != _dlgTimer) {
        TT_INVALIDATE_TIMER(_dlgTimer);
        _dlgTimer = dlgTimer;
    }
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle{
	
	[self.view showHUDIndicatorViewAtCenter:indiTitle];
	
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}

- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time
{
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
	
	if (time > 0.0f) {
        self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:time*1.5
                                                               target:self 
                                                             selector:@selector(timeOutRemoveHUDView)
                                                             userInfo:nil 
                                                              repeats:NO];
    }else{
        self.dlgTimer = nil;
    }
	
	return;
}


- (void)displayOverFlowActivityView{
	
	[self.view showHUDIndicatorViewAtCenter:L(@"Loading...")];
    
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle yOffset:(CGFloat)y{
	
	[self.view showHUDIndicatorViewAtCenter:indiTitle yOffset:y];
	
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}

- (void)timeOutRemoveHUDView
{
    [self.view hideHUDIndicatorViewAtCenter];
}


- (void)timerOutRemoveOverFlowActivityView
{
	
	[self.view hideActivityViewAtCenter ];
	
	return;
	
	
}

- (void)removeOverFlowActivityView
{
    [self.view hideHUDIndicatorViewAtCenter];
    
    TT_INVALIDATE_TIMER(_dlgTimer);
	
}

- (void)presentSheet:(NSString*)indiTitle{
	
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle];
}
- (void)presentSheet:(NSString *)indiTitle timer:(int)aTimer
{
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle timer:aTimer];
}

- (void)presentSheet:(NSString*)indiTitle posY:(CGFloat)y{
	
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle posY:y];
    
}

- (void)presentSheetOnNav:(NSString *)indiTitle
{
    [self.navigationController.view showTipViewAtCenter:indiTitle];
}


//添加可展示两行的sheet
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg
{
    [self.view showTipViewAtCenter:indiTitle message:msg];
}

- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg posY:(CGFloat)y
{
    [self.view showTipViewAtCenter:indiTitle message:msg posY:y];
}



- (void)presentCustomDlg:(NSString*)indiTitle{
	
    BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                      Title:L(@"system-info")
                                                    message:indiTitle
                                                 customView:nil
                                                   delegate:self
                                          cancelButtonTitle:L(@"Confirm")
                                          otherButtonTitles:nil];
    [alert show];

}

- (UITableView *)tableView{
	
	if(!_tableView){
		
		_tableView = [UITableView tableView];
		
		_tableView.delegate =self;
		
		_tableView.dataSource =self;
        
        if ([_tableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        {
            if ([_tableView.dataSource isKindOfClass:[UIViewController class]])
            {
                UIViewController *v = (UIViewController *)_tableView.dataSource;
                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
                {
                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
                    for (UIGestureRecognizer *ges in _tableView.gestureRecognizers) {
                        [nav.panGes requireGestureRecognizerToFail:ges];
                    }
                }
            }
        }
	}
	
	return _tableView;
}

- (UITableView *)groupTableView{
	
	if(!_groupTableView){
		
        if (IOS7_OR_LATER) {
            _groupTableView = [UITableView groupTableView];
        }else{
            _groupTableView = [UITableView tableView];
        }
		
		_groupTableView.delegate =self;
		
		_groupTableView.dataSource =self;
		
        if ([_groupTableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        {
            if ([_groupTableView.dataSource isKindOfClass:[UIViewController class]])
            {
                UIViewController *v = (UIViewController *)_groupTableView.dataSource;
                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
                {
                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
                    for (UIGestureRecognizer *ges in _groupTableView.gestureRecognizers) {
                        [nav.panGes requireGestureRecognizerToFail:ges];
                    }
                }
            }
        }
	}
	
	return _groupTableView;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
	if(!_tpTableView)
    {
		
//        if (IOS7_OR_LATER) {
//            _tpTableView = [TPKeyboardAvoidingTableView groupTableView];
//        }else{
            _tpTableView = [TPKeyboardAvoidingTableView tableView];
//        }
        
		_tpTableView.delegate =self;
		
		_tpTableView.dataSource =self;
        
        if ([_tpTableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        {
            if ([_tpTableView.dataSource isKindOfClass:[UIViewController class]])
            {
                UIViewController *v = (UIViewController *)_tpTableView.dataSource;
                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
                {
                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
                    for (UIGestureRecognizer *ges in _tpTableView.gestureRecognizers) {
                        [nav.panGes requireGestureRecognizerToFail:ges];
                    }
                }
            }
        }
	}
	return _tpTableView;
}

- (TPKeyboardAvoidingTableView *)tpGroupTableView
{
	if(!_tpGroupTableView)
    {
		
        //        if (IOS7_OR_LATER) {
        //            _tpTableView = [TPKeyboardAvoidingTableView groupTableView];
        //        }else{
        _tpGroupTableView = [TPKeyboardAvoidingTableView groupTableView];
        //        }
        
		_tpGroupTableView.delegate =self;
		
		_tpGroupTableView.dataSource =self;
        
        if ([_tpGroupTableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        {
            if ([_tpGroupTableView.dataSource isKindOfClass:[UIViewController class]])
            {
                UIViewController *v = (UIViewController *)_tpGroupTableView.dataSource;
                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
                {
                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
                    for (UIGestureRecognizer *ges in _tpGroupTableView.gestureRecognizers) {
                        [nav.panGes requireGestureRecognizerToFail:ges];
                    }
                }
            }
        }
	}
	return _tpGroupTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 0;	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

	
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    DLog(@"Commmon didReceiveMemoryWarning \n");
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)login
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010201"], nil]];
    if([UserCenter defaultCenter].isLogined == NO){
        
        DLog(@"needLogonAuth \n");
        
        LoginViewController *_LoginViewController=[[LoginViewController alloc]init];
        _LoginViewController.nextController = self;
        _LoginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:_LoginViewController];
        [self presentModalViewController:userNav animated:YES];
        return;
    }
}

- (LoginViewController *)checkLoginWithLoginedBlock:(SNBasicBlock)loginedBlock
                                   loginCancelBlock:(SNBasicBlock)cancelBlock
{
    return [self checkLogin:loginedBlock cancel:cancelBlock callBackAfterDismissed:NO];
}

- (LoginViewController *)checkLoginWithLoginedBlockAfterDismissed:(SNBasicBlock)loginedBlock
                                                 loginCancelBlock:(SNBasicBlock)cancelBlock
{
    return [self checkLogin:loginedBlock cancel:cancelBlock callBackAfterDismissed:YES];
}

-(LoginViewController*)checkLogin:(SNBasicBlock)loginSuccessBlock cancel:(SNBasicBlock)cancelBlock callBackAfterDismissed:(BOOL)yesOrNo
{
    if([UserCenter defaultCenter].isLogined == NO){
        
        DLog(@"needLogonAuth \n");
        
        LoginViewController *_LoginViewController = [[LoginViewController alloc] init];
        _LoginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _LoginViewController.loginOkBlock = loginSuccessBlock;
        _LoginViewController.loginCancelBlock = cancelBlock;
        _LoginViewController.callBackAfterDismissed = yesOrNo;
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:_LoginViewController];
        [self presentModalViewController:userNav animated:YES];
        return _LoginViewController;
    }
    else
    {
        if (loginSuccessBlock) {
            loginSuccessBlock();
        }
        return nil;
    }
}

#pragma mark -
#pragma mark utils

- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar
{
    if (IOS7_OR_LATER && self.isIOS7FullScreenLayout)
    {
        //全屏布局
        CGRect frame = [[UIScreen mainScreen] bounds];
        return frame;
    }
    else
    {
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.size.height -= 20;
        if (hasNav) {
            frame.size.height -= 44;
        }
        if (hasTabBar) {
            frame.size.height -= 48;
        }
        return frame;
    }
}

#pragma mark -
#pragma mark 页面路由

- (void)routeWithUrl:(NSString *)url complete:(void (^)(BOOL, NSString *))completeBlock
{
    @weakify(self);
    [SNRouter handleURL:url
             onChecking:^(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self displayOverFlowActivityView];
                 
             } shouldRoute:^BOOL(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self removeOverFlowActivityView];
                 if ([obj errorMsg].length) {
                     return NO;
                 }else{
                     obj.navController = self.navigationController;
                     return YES;
                 }
                 
             } didRoute:^(SNRouterObject *obj) {
                 
                 if (completeBlock) {
                     completeBlock(![obj isErrorOrDoNothing], obj.errorMsg);
                 }
                 
             } source:SNRouteSourceSomeUrl];
}

- (void)routeWithAdTypeCode:(NSString *)adTypeCode adId:(NSString *)adId complete:(void(^)(BOOL isSuccess))completeBlock
{
    @weakify(self);
    [SNRouter handleAdTypeCode:adTypeCode
                          adId:adId
                        chanId:nil
                       qiangId:nil
             onChecking:^(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self displayOverFlowActivityView];
                 
             } shouldRoute:^BOOL(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self removeOverFlowActivityView];
                 if ([obj errorMsg].length) {
                     [self presentSheet:obj.errorMsg];
                     return NO;
                 }else{
                     obj.navController = self.navigationController;
                     return YES;
                 }
                 
             } didRoute:^(SNRouterObject *obj) {
                 
                 if (completeBlock) {
                     completeBlock(![obj isErrorOrDoNothing]);
                 }
                 
             } source:SNRouteSourceSomeCode];
}

- (void)goAround
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010203"], nil]];
    [self goAroundWithCompleteBlock:NULL];
}

- (void)goAroundWithCompleteBlock:(SNBasicBlock)callback
{
    NSString *url = [SNSwitch goAround];
    
    if (url)
    {
        @weakify(self);
        [SNRouter handleURL:url
                 onChecking:^(SNRouterObject *obj) {
                     
                     @strongify(self);
                     [self displayOverFlowActivityView];
                     
                 } shouldRoute:^BOOL(SNRouterObject *obj) {
                     
                     @strongify(self);
                     [self removeOverFlowActivityView];
                     if ([obj isErrorOrDoNothing]) {
                         [self jumpToHomeBoard];
                         return NO;
                     }else{
                         return YES;
                     }
                     
                 } didRoute:^(SNRouterObject *obj) {
                     
                     if (callback) {
                         callback();
                     }
                     
                 } source:SNRouteSourceQuGuangGuang];
    }
    else
    {
        [self jumpToHomeBoard];
        if (callback) {
            callback();
        }
    }
}


/**
 *  基础类里处理页面跳转
 *
 *  @param targetType 跳转类型
 *  @param targetURL  目标url
 */
- (void)handleTargetType:(NSString *)targetType targetURLString:(NSString *)targetURL {
    
    ////跳转类型 1:促销专题   2:商品集  3:连版专题  4:URL 5:页面集
    if ([targetType isEqualToString:@"1"]) {
        //进入促销专题
        SalePromotionViewController *controller = [[SalePromotionViewController alloc] init];
        controller.targetModuleID = targetURL;
        [self.navigationController pushViewController:controller animated:YES];
        TT_RELEASE_SAFELY(controller);
    }
    else if ([targetType isEqualToString:@"2"]) {
        //进入商品列表页面
        PruductList244ViewController *controller = [[PruductList244ViewController alloc] init];
        controller.targetModuleID = targetURL;
        [self.navigationController pushViewController:controller animated:YES];
        TT_RELEASE_SAFELY(controller);
        
    }
    else if ([targetType isEqualToString:@"3"]) {
        LianBanZhuanTiViewController *controller = [[LianBanZhuanTiViewController alloc] init];
        controller.targetModuleID = targetURL;
        [self.navigationController pushViewController:controller animated:YES];
        TT_RELEASE_SAFELY(controller);
    }
    else if ([targetType isEqualToString:@"4"]) {
        if (IsStrEmpty(targetURL)) {
            return;
        }
        else if ([targetURL rangeOfString:@"adTypeCode"].location != NSNotFound) {
            //            @weakify(self);
            //            NSString *newTargetURL = [NSString stringWithFormat:@"%@&tabIndex=0",moduleDTO.targetURL];
            
            [SNRouter handleURL:targetURL
                     onChecking:^(SNRouterObject *obj) {
                         //                         @strongify(self);
                         //                         [self displayOverFlowActivityView];
                         
                     } shouldRoute:^BOOL(SNRouterObject *obj) {
                         
                         //                         @strongify(self);
                         //                         [self removeOverFlowActivityView];
                         if (obj.errorMsg) {
                             //                             [self showMessage:obj.errorMsg];
                             return NO;
                         }else{
                             return YES;
                         }
                     } didRoute:^(SNRouterObject *obj) {
                         
                         
                     } source:SNRouteSourceSomeUrl
                  navController:self.navigationController];
            
        }
        else {
            //普通url，进入web页面
            //判断当前是哪个lei
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCommon attributes:@{@"url": targetURL}];
            
            if ([self isKindOfClass:NSClassFromString(@"HomePageViewController")]) {
                vc.controllerSourceType = 1;
            }
            else if ([self isKindOfClass:NSClassFromString(@"SecondPageViewController")]) {
                vc.controllerSourceType = 2;
            }
            else if ([self isKindOfClass:NSClassFromString(@"SalePromotionViewController")]) {
                vc.controllerSourceType = 3;
            }
            else if ([self isKindOfClass:NSClassFromString(@"LianBanZhuanTiViewController")]) {
                vc.controllerSourceType = 4;
            }
            else if ([self isKindOfClass:NSClassFromString(@"PruductList244ViewController")]) {
                vc.controllerSourceType = 5;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if ([targetType isEqualToString:@"5"]) {
        //页面集
        SecondPageViewController *controller = [[SecondPageViewController alloc] init];
        controller.pageID = targetURL;
        [self.navigationController pushViewController:controller animated:YES];
        TT_RELEASE_SAFELY(controller);
    }
    else {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                        message:L(@"Common_CurrentClientNotSupport")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"AlertIKnow")
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark ----------------------------- ios7 兼容

#ifdef __IPHONE_7_0

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#endif

@end
