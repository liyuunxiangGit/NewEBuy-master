//
//  NSObject+BoardManage.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NSObject+BoardManage.h"
#import "MyEbuyViewController.h"
#import "HomeScrollViewController.h"
#import "CategoryViewController.h"
#import "HomePageControlView.h"

@implementation NSObject (BoardManage)

- (AppDelegate *)appDelegate
{
    return [AppDelegate currentAppDelegate];
}

- (UserInfoDTO *)user
{
    return [UserCenter defaultCenter].userInfoDTO;
}

- (BOOL)isEppActive
{
    return ([UserCenter defaultCenter].efubaoStatus == eLoginByPhoneActive) ||
    ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailActive);
}

- (double)eppBalance
{
    return [[UserCenter defaultCenter].userInfoDTO.yifubaoBalance doubleValue];
}

- (HomeScrollViewController *)homeBoard
{
    UINavigationController *nav = [self.appDelegate.tabBarViewController.viewControllers objectAtIndex:0];
    return [[nav viewControllers] objectAtIndex:0];
}

- (HomePageControlView *)homeBoardNew
{
    UINavigationController *nav = [self.appDelegate.tabBarViewController.viewControllers objectAtIndex:0];
    return [[nav viewControllers] objectAtIndex:0];
}


- (NewSearchViewController *)searchBoard
{
    UINavigationController *nav = [self.appDelegate.tabBarViewController.viewControllers objectAtIndex:1];
    return [[nav viewControllers] objectAtIndex:0];
}

- (ShopCartV2ViewController *)shoppingCartBoard
{
    UINavigationController *nav = [self.appDelegate.tabBarViewController.viewControllers objectAtIndex:3];
    return [[nav viewControllers] objectAtIndex:0];
}

- (MyEbuyViewController *)myEbuyBoard
{
    UINavigationController *nav = [self.appDelegate.tabBarViewController.viewControllers objectAtIndex:4];
    return [[nav viewControllers] objectAtIndex:0];
}

- (CategoryViewController *)categoryBoard
{
    UINavigationController *nav = [self.appDelegate.tabBarViewController.viewControllers objectAtIndex:2];
    return [[nav viewControllers] objectAtIndex:0];
}

#pragma mark -

- (void)jumpToHomeBoard
{
    //case have a modalviewcontroller
    UITabBarController *tabBarVC = self.appDelegate.tabBarViewController;
    if ([tabBarVC presentedViewController])
    {
        [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
    }
    [self.homeBoard.navigationController popToRootViewControllerAnimated:NO];
    tabBarVC.selectedIndex = 0;
}


//跳转订单中心

- (void)jumpToOrderCenterBoard:(SNBasicBlock)callback
{
 
        UITabBarController *tabBarVC = self.appDelegate.tabBarViewController;
        if ([tabBarVC presentedViewController])
        {
            [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
        }
        tabBarVC.selectedIndex = 4;
        MyEbuyViewController *ebuy = self.myEbuyBoard;
        
        if ([ebuy.navigationController.viewControllers count] > 1)
        {
            [ebuy.navigationController popToRootViewControllerAnimated:NO];
        }
        
        [ebuy gotoOrderCenter];
//    }
        if (callback) {
            callback();
        }
}

//跳转到订单中心
- (void)jumpToOrderCenterBoard
{
    //case have a modalviewcontroller
    UITabBarController *tabBarVC = self.appDelegate.tabBarViewController;
    if ([tabBarVC presentedViewController])
    {
        [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
    }
    tabBarVC.selectedIndex = 4;
    MyEbuyViewController *ebuy = self.myEbuyBoard;
    
    if ([ebuy.navigationController.viewControllers count] > 1)
    {
        [ebuy.navigationController popToRootViewControllerAnimated:NO];
    }
    
    [ebuy gotoOrderCenter];
}


- (void)jumpToActivityEfubao
{
    //case have a modalviewcontroller
    UITabBarController *tabBarVC = self.appDelegate.tabBarViewController;
    if ([tabBarVC presentedViewController])
    {
        [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
    }
    self.appDelegate.tabBarViewController.selectedIndex = 4;
    MyEbuyViewController *ebuy = self.myEbuyBoard;
    
    if ([ebuy.navigationController.viewControllers count] > 1)
    {
        [ebuy.navigationController popToRootViewControllerAnimated:NO];
    }
    
    [ebuy gotoEfubao];
}

- (void)jumpToMyIntegal
{
    //case have a modalviewcontroller
    UITabBarController *tabBarVC = self.appDelegate.tabBarViewController;
    if ([tabBarVC presentedViewController])
    {
        [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
    }
    self.appDelegate.tabBarViewController.selectedIndex = 4;
    MyEbuyViewController *ebuy = self.myEbuyBoard;
    
    if ([ebuy.navigationController.viewControllers count] > 1)
    {
        [ebuy.navigationController popToRootViewControllerAnimated:NO];
    }
    
    [ebuy gotoIntegral];
}

@end
