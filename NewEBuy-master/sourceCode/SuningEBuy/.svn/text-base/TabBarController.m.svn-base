#import "TabBarController.h"
#import "AuthManagerNavViewController.h"
#import "LoginViewController.h"

#import "HomeScrollViewController.h"
#import "SearchViewController.h"
#import "NewSearchViewController.h"
#import "MyEbuyViewController.h"
#import "MoreViewController.h"
#import "CategoryViewController.h"
#import "AllCategoryViewController.h"
#import "UserCenter.h"

#import "HomePageViewController.h"
#import "ShopCartV2ViewController.h"

#import <objc/runtime.h>
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "HomePageViewController.h"

@interface UITabBarSwappableView : UIView

@end

@implementation UITabBarSwappableView

- (void)setTabBarSwappableFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(-2, -1, 64, 49)];
}

@end


@interface TabBarController() 
{
    UIButton                *_badgeValueBtn;
    BOOL                    _firstIn;
}

@property (nonatomic, strong) UIButton *badgeValueBtn;
@end

@implementation TabBarController

@synthesize tabBarDelegate = _tabBarDelegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)init{
    
    self = [super init];
    
    if(self){
        
        _firstIn = YES;
        //启动专题列表请求
        sourceTitle = L(@"APPDelegate_Activity");
        UITabBarItem *item1 = [[UITabBarItem alloc] init];
        item1.tag = 1;
        
        if (IOS7_OR_LATER)
        {
            [item1 setTitle:L(@"home")];
            [item1 setImage:[UIImage imageNamed:@"icon_homePage244_default.png"]];
            [item1 setSelectedImage:[[UIImage imageNamed:@"icon_homePage244_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item1 setTitleTextAttributes:@{UITextAttributeTextColor: HEX_COLOR(0xff6a00)}
                                 forState:UIControlStateSelected];
        }
        else
        {
            [item1 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_home_selected.png"]
                withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home_unselect.png"]];
        }
        
        UITabBarItem *item2 = [[UITabBarItem alloc] init];
        item2.tag = 2;
        
        if (IOS7_OR_LATER)
        {
            [item2 setTitle:L(@"search")];
            [item2 setImage:[UIImage imageNamed:@"icon_search244_default.png"]];
            [item2 setSelectedImage:[[UIImage imageNamed:@"icon_search244_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item2 setTitleTextAttributes:@{UITextAttributeTextColor: HEX_COLOR(0xff6a00)}
                                 forState:UIControlStateSelected];
        }
        else
        {
            [item2 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_search_selected.png"]
                withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_search_unselect.png"]];
        }
        
        UITabBarItem *item3 = [[UITabBarItem alloc] init];
        item3.tag = 3;
        if (IOS7_OR_LATER)
        {
            [item3 setTitle:L(@"Categories")];
            [item3 setImage:[UIImage imageNamed:@"icon_category244_default.png"]];
            [item3 setSelectedImage:[[UIImage imageNamed:@"icon_category244_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item3 setTitleTextAttributes:@{UITextAttributeTextColor: HEX_COLOR(0xff6a00)}
                                 forState:UIControlStateSelected];
        }
        else
        {
            [item3 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_category_selected.png"]
                withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_category_unselect.png"]];
        }

        UITabBarItem *item4 = [[UITabBarItem alloc] init];
        
        item4.tag = 4;
        
        if (IOS7_OR_LATER)
        {
            [item4 setTitle:L(@"shopCart")];
            [item4 setImage:[UIImage imageNamed:@"icon_shopCart244_default.png"]];
            [item4 setSelectedImage:[[UIImage imageNamed:@"icon_shopCart244_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item4 setTitleTextAttributes:@{UITextAttributeTextColor: HEX_COLOR(0xff6a00)}
                                 forState:UIControlStateSelected];
        }
        else
        {
            [item4 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_shopcart_selected.png"]
                withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_shopcart_unselect.png"]];
        }


        UITabBarItem *item5 = [[UITabBarItem alloc] init];
        
        item5.tag = 5;
        
        if (IOS7_OR_LATER)
        {
            [item5 setTitle:L(@"myEbuy")];
            [item5 setImage:[UIImage imageNamed:@"icon_myYigou244_default.png"]];
            [item5 setSelectedImage:[[UIImage imageNamed:@"icon_myYigou244_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item5 setTitleTextAttributes:@{UITextAttributeTextColor: HEX_COLOR(0xff6a00)}
                                 forState:UIControlStateSelected];
        }
        else
        {
            [item5 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_myaccount_selected.png"]
                withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_myaccount_unselect.png"]];
        }


            HomePageViewController *homeController = [[HomePageViewController alloc] init];
            homeController.tabBarItem = item1;
            AuthManagerNavViewController *homeNavController = [[AuthManagerNavViewController alloc] initWithRootViewController:homeController];
            __gNavController0 = homeNavController; // XZoscar 2014-06-18 add
            
            TT_RELEASE_SAFELY(homeController);
        
        
        NewSearchViewController *searchVC = [[NewSearchViewController alloc] init];

        searchVC.tabBarItem = item2;
        
        AuthManagerNavViewController *searchNavController = [[AuthManagerNavViewController alloc] initWithRootViewController:searchVC];
        
        TT_RELEASE_SAFELY(searchVC);

#if kCategoryDebug
        CategoryViewController *cateViewVC = [[CategoryViewController alloc] init];

        cateViewVC.tabBarItem = item3;
        
        AuthManagerNavViewController *cateNavController = [[AuthManagerNavViewController alloc] initWithRootViewController:cateViewVC];
        
        TT_RELEASE_SAFELY(cateViewVC);

#else
        AllCategoryViewController *cateViewVC = [[AllCategoryViewController alloc] init];
        cateViewVC.hasSuspendButton = NO;
        cateViewVC.tabBarItem = item3;
        
        AuthManagerNavViewController *cateNavController = [[AuthManagerNavViewController alloc] initWithRootViewController:cateViewVC];
        
        TT_RELEASE_SAFELY(cateViewVC);

#endif
        ShopCartV2ViewController *shoppingCartVC = [ShopCartV2ViewController sharedShopCart];

        shoppingCartVC.tabBarItem = item4;
        
        AuthManagerNavViewController *gouwucheNavController = [[AuthManagerNavViewController alloc] initWithRootViewController:shoppingCartVC];
        
        TT_RELEASE_SAFELY(shoppingCartVC);
        MyEbuyViewController * MyEbuyLaunchViewVC = [[MyEbuyViewController alloc] init];

        MyEbuyLaunchViewVC.tabBarItem = item5;
        AuthManagerNavViewController *myEbuyNavController = [[AuthManagerNavViewController alloc] initWithRootViewController:MyEbuyLaunchViewVC];
        
        self.viewControllers = [NSArray arrayWithObjects:homeNavController,searchNavController,cateNavController,gouwucheNavController,myEbuyNavController, nil];
        
        self.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(loginSessionFailure) 
                                                     name:LOGIN_SESSION_FAILURE_NEED_LOGIN
                                                   object:nil];
                
        return  self;
    }
    return  nil;
}

- (void)loadView
{
    [super loadView];
    //修改高度
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tabBarHeight = 49;
    self.tabBar.frame = CGRectMake(0, height-tabBarHeight, width, tabBarHeight);
    self.tabBar.clipsToBounds = YES;
    UIView *transitionView = [[self.view subviews] objectAtIndex:0];
    transitionView.height = height-tabBarHeight;
    
    if (!IOS7_OR_LATER)
    {
        
        Class kClass = NSClassFromString(@"UITabBarSwappableImageView");
        UITabBarSwappableView *view = [[UITabBarSwappableView alloc] init];
        class_replaceMethod(kClass, @selector(setFrame:), [view methodForSelector:@selector(setTabBarSwappableFrame:)], nil);
        TT_RELEASE_SAFELY(view);
    }
}

- (UIButton *)badgeValueBtn
{
    if (!_badgeValueBtn)
    {
        _badgeValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    _badgeValueBtn.backgroundColor = RGBCOLOR(234, 89, 10);
        [_badgeValueBtn setBackgroundImage:[UIImage streImageNamed:@"Service_Detail_List_Cell_Point.png"] forState:UIControlStateDisabled];
        [_badgeValueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _badgeValueBtn.alpha = 0;
        //    _badgeValueBtn.layer.cornerRadius = 7.0;
        [_badgeValueBtn setTitleEdgeInsets:UIEdgeInsetsMake(1, 2, 0, 0)];
        _badgeValueBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        //    _badgeValueBtn.layer.borderColor = RGBCOLOR(251, 195, 0).CGColor;
        //    _badgeValueBtn.layer.borderWidth = 0.5;
        _badgeValueBtn.enabled = NO;
        _badgeValueBtn.frame = CGRectMake(170 + 70, 1, 20, 20);
        _badgeValueBtn.layer.zPosition = 1;
    }
    return _badgeValueBtn;
}

-(void)showBadgeValue:(NSString*)number
{
    if ([number isEqualToString:@"0"] || IsStrEmpty(number))
    {
        self.badgeValueBtn.alpha = 0;
    }
    else
    {
        if ([number intValue] > 99) {
            number = @"99+";
        }
        int length = [number length];
        
        CGSize size = [@"9" sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(64, 20)];
        
        CGRect rect = self.badgeValueBtn.frame;
        rect.size.width = size.width * (length + 0.5)>20?size.width*(length+0.5):20;
        rect.size.height = size.height> 20 ?size.height:20;
        rect.origin.x = 190 + 70 - rect.size.width - 5;
        rect.origin.y = 0.5;//self.tabBar.bottom - 46;
        [self.badgeValueBtn setBackgroundImage:[UIImage streImageNamed:@"Service_Detail_List_Cell_Point.png"] forState:UIControlStateDisabled];

        self.badgeValueBtn.frame = rect;
        [self.badgeValueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.badgeValueBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];

        self.badgeValueBtn.alpha = 1.0;
        [self.badgeValueBtn setTitle:number forState:UIControlStateNormal];
        [self.badgeValueBtn setTitle:number forState:UIControlStateDisabled];
    }
}

-(void)setBadgeValue:(NSNotification*)data
{
    NSString *strNum = [data object];
    
    [self showBadgeValue:strNum];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (_firstIn)
    {
        [self.tabBar addSubview:self.badgeValueBtn];
//        [self.tabBar.layer insertSublayer:self.badgeValueBtn.layer atIndex:[self.tabBar.layer.sublayers count]];
        
//        AuthManagerNavViewController *auth = (AuthManagerNavViewController *)[self.viewControllers objectAtIndex:3];
//        
//        ShopCartV2ViewController *shoppingCartVC = [ShopCartV2ViewController sharedShopCart];
//        
        _firstIn = NO;
    }
}

- (void)loginSessionFailure
{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.loginDelegate = self;
    loginViewController.loginDidCancelSelector = @selector(loginDidCancel);
    AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc] 
                                             initWithRootViewController:loginViewController];
    
    [self presentModalViewController:userNav animated:YES];
    
    TT_RELEASE_SAFELY(loginViewController);
    TT_RELEASE_SAFELY(userNav);
}

- (void)loginDidCancel
{
    if (self.selectedIndex == 4) {
        AuthManagerNavViewController *navController = [self.viewControllers objectAtIndex:4];
        [navController popToRootViewControllerAnimated:YES];
        [self setSelectedIndex:0];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    return YES;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    
//    if (selectedIndex == 4)
//    {
//        if ([self checkUserLoginOrNot])
//        {
//            [super setSelectedIndex:selectedIndex];
//        }
//    }
//    else
//    {
        [super setSelectedIndex:selectedIndex];
//    }
    
#if kPanUISwitch
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[self.viewControllers objectAtIndex:selectedIndex];
    UIImage *image = [nav.arrayScreenshot lastObject];
    if (image)
        [AppDelegate currentAppDelegate].screenshotView.imgView.image = image;
#endif
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120004 + self.selectedIndex], nil]];
    sourcePageTitle = nil;
    daoPageTitle = nil;
    
    if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.tabBarDelegate performSelector:@selector(tabBarController:didSelectViewController:)];
    }
    
#if kPanUISwitch
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[self.viewControllers objectAtIndex:self.selectedIndex];
    UIImage *image = [nav.arrayScreenshot lastObject];
    if (image)
        [AppDelegate currentAppDelegate].screenshotView.imgView.image = image;
#endif
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
//    if (item.tag == 1 && self.selectedIndex == 0) {
//        AuthManagerNavViewController *homeNavC = [self.viewControllers objectAtIndex:0];
//        if ([[homeNavC viewControllers] count] <= 1) {
//            HomeScrollViewController *homeScrollViewVC = [homeNavC.viewControllers objectAtIndex:0];
////            NSInteger page = homeScrollViewVC.currentPage > 0 ? homeScrollViewVC.currentPage-1 : 0;
//            [homeScrollViewVC setCurrentPage:0];
//        }
//    }    
}

- (void)loginDidOk
{
    [self setSelectedIndex:4];
}


- (BOOL)checkUserLoginOrNot{
    /*
    if([SuningEBuyAppDelegate  currentAppDelegate].userInfoDTO==nil){
        
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        loginViewController.isFromHome = YES;
        
        loginViewController.loginDelegate = self;
        loginViewController.loginDidOkSelector = @selector(loginDidOk);
        
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc] 
                                                 initWithRootViewController:loginViewController];
        
        [self presentModalViewController:userNav animated:YES];
        [Config currentConfig].checkUserLoginOrNot = [NSNumber numberWithBool:YES];
        
        TT_RELEASE_SAFELY(loginViewController);
        TT_RELEASE_SAFELY(userNav);
        return NO;
    }else{
        return YES;
    }
     */
    
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginViewController = [[LoginViewController alloc] init];

        loginViewController.loginDelegate = self;
        loginViewController.loginDidOkSelector = @selector(loginDidOk);
        loginViewController.loginDidCancelSelector = @selector(loginDidCancel);
        
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc] 
                                                 initWithRootViewController:loginViewController];
        
        [self presentModalViewController:userNav animated:YES];
        
        TT_RELEASE_SAFELY(loginViewController);
        TT_RELEASE_SAFELY(userNav);
        return NO;
    }
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationPortrait==interfaceOrientation);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	DLog(@"TabBarController didReceiveMemoryWarning \n");
    // Release any cached data, images, etc that aren't in use.
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}


#pragma mark -
#pragma mark tab bar delegate


@end
