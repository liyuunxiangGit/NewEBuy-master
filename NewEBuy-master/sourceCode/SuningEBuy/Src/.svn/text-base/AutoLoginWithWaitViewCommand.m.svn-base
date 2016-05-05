//
//  AutoLoginWithWaitViewCommand.m
//  SuningEBuy
//
//  Created by chupeng on 14-3-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
#import "SNSwitch.h"
#import "AutoLoginWithWaitViewCommand.h"
#import "UserLoginService.h"
#import "LoginViewController.h"
#import "TabBarController.h"
#import "SFHFKeychainUtils.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "MyEbuyViewController.h"
#import "AuthManagerNavViewController.h"
@implementation AutoLoginWithWaitViewCommand

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(service);
}

- (void)cancel
{
    service.delegate = nil;
    service = nil;

    [super cancel];
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)execute
{
    [self showWaitingView];

    NSString *userName;
    NSString *password;
    NSString *passwd;
    
    userName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    passwd = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginPasswdKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    
    password = [PasswdUtil decryptString:passwd
                                  forKey:kLoginPasswdParamEncodeKey
                                    salt:kPBEDefaultSalt];
    //    userName = [Config currentConfig].username;
    //    password = [Config currentConfig].password;//[NSString decryptUseDES:[Config currentConfig].password
    //    //                                             key:kPasswordEncryptKey];
    if (userName.trim.length && password.trim.length)
    {
        if (!service)
        {
            service = [[UserLoginService alloc] init];
            service.delegate = self;
        }

        if ([SNSwitch isPassportLogin])
        {
            [service beginLoginWithUsername:userName password:password verifyCode:nil];
             [[NSNotificationCenter defaultCenter] postNotificationName:AUTOLOGIN_BEGIN object:nil];
        }
        else
        {
            [service beginLoginWithUsername:userName password:password];
        }
    }
    else
    {
        [self removeWaitingSubViews];
        [self done];
    }
}

- (void)showWaitingView
{
    TabBarController *v = (TabBarController *)[AppDelegate currentAppDelegate].window.rootViewController;
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[v.viewControllers objectAtIndex:4];
    MyEbuyViewController *ebuyv = (MyEbuyViewController *)[[nav childViewControllers] objectAtIndex:0];
    [ebuyv.view showHUDIndicatorViewAtCenter:nil yOffset:-60];
//
//
//    TabBarController *tab = (TabBarController*)keyWindow.rootViewController;
//    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[tab selectedViewController];
//    //UIViewController *v = [nav topViewController];
//    
//    [keyWindow addSubview:self.waitingViewController.view];
}

- (void) removeWaitingSubViews
{
    TabBarController *v = (TabBarController *)[AppDelegate currentAppDelegate].window.rootViewController;
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[v.viewControllers objectAtIndex:4];
    MyEbuyViewController *ebuyv = (MyEbuyViewController *)[[nav childViewControllers] objectAtIndex:0];
    [ebuyv.view hideHUDIndicatorViewAtCenter];
//    TabBarController *tab = (TabBarController*)keyWindow.rootViewController;
//    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[tab selectedViewController];
//    UIViewController *v = [nav topViewController];
//    [self.waitingViewController.view removeFromSuperview];
//    
//    
//    //手动刷新一下，让v重新请求页面数据
//    [v viewWillAppear:NO];
}

- (AutoLoginWaitingViewController *)waitingViewController
{
    if (!_waitingViewController)
    {
        _waitingViewController = [[AutoLoginWaitingViewController alloc] init];
    }
    return _waitingViewController;
}

- (void)userLoginCompletedWithResult:(BOOL)successfulLogin
                           errorCode:(NSString *)errorCode
{
    [self removeWaitingSubViews];

    if (successfulLogin)
    {
        self.isLoginOk = YES;
//        [self.delegate commandDidFinish:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:AUTOLOGIN_OK_MESSAGE object:nil];
        
    }
    else
    {
         [[NSNotificationCenter defaultCenter] postNotificationName:AUTOLOGIN_Failed_MESSAGE object:nil];
//        [self.delegate commandDidFailed:self];
//        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:@"自动登录失败，请手动登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
//        [alertView setConfirmBlock:^{
//            
//        }];
//        [alertView show];
//        TT_RELEASE_SAFELY(alertView);
    }
    [self done];
}

@end
