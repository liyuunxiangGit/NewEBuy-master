//
//  BBSideBarViewController.m
//  SuningEBuy
//
//  Created by shasha on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BBSideBarViewController.h"
#import "SNGraphics.h"
#import "GBListViewController.h"

@implementation BBSideBarViewController

static BBSideBarViewController *sharedSideController = nil;
//去本地生活 
+ (void)goToLocalLife:(NSString *)tuanGouType snProId:(NSString *)snProId
{
    GBListViewController *rootViewController = [[GBListViewController alloc] init];
    AuthManagerNavViewController *GBNaviController = [[AuthManagerNavViewController alloc] initWithRootViewController:rootViewController hasTopRoundCorner:NO];
    BBSideBarViewController *vc = [[BBSideBarViewController alloc] initWithRootViewController:GBNaviController];
    sharedSideController = vc;
    AppDelegate *appDelegate = [AppDelegate currentAppDelegate];
    //先回到首页
    [appDelegate jumpToHomeBoard];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    
    [appDelegate.window.layer addAnimation:animation forKey:nil];
    
    appDelegate.window.rootViewController = vc;
    
    [rootViewController firstCallQueryCity:tuanGouType snProId:snProId];
}

//回ebuy
+ (void)backToEbuy
{
    [self backToEbuyAnimated:YES];
}

+ (void)backToEbuyAnimated:(BOOL)animated
{
    if (sharedSideController)
    {
        AppDelegate *appDelegate = [AppDelegate currentAppDelegate];
        if (animated) {
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.35f];
            [animation setFillMode:kCAFillModeForwards];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromLeft];
            [appDelegate.window.layer addAnimation:animation forKey:nil];
        }
        
        ///begin 切换window.rootViewController 后 tabBarController的bottomBar 又出现了
        appDelegate.window.rootViewController = appDelegate.tabBarViewController;
        
        UITabBarController *tabBarVC = appDelegate.tabBarViewController;
        
        UINavigationController *nav = [[tabBarVC viewControllers] safeObjectAtIndex:0];
        
        if (2 <= [nav.viewControllers count]) {
            
            Class topClass = [nav.topViewController class];
            
            [nav popViewControllerAnimated:NO];
            
            UIViewController *v = [[topClass alloc] init];
            
            [nav pushViewController:v animated:NO];
            
        }
        ///end
        
        sharedSideController = nil;
    }
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.directionsToShowBounce = PPRevealSideDirectionRight;
        self.panInteractionsWhenClosed = PPRevealSideInteractionContentView;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect frame;
    if (IOS7_OR_LATER) {
        frame = [[UIScreen mainScreen] bounds];
    }
    else
    {
        frame = self.view.frame;
    }
    
}

@end
