//
//  AutoLoginCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import "SNSwitch.h"
#import "AutoLoginCommand.h"
#import "SFHFKeychainUtils.h"
#import "PasswdUtil.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "MyEbuyViewController.h"
#import "AuthManagerNavViewController.h"

@implementation AutoLoginCommand

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
            
            TabBarController *v = (TabBarController *)[AppDelegate currentAppDelegate].window.rootViewController;
            AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[v.viewControllers objectAtIndex:4];
            MyEbuyViewController *ebuyv = (MyEbuyViewController *)[[nav childViewControllers] objectAtIndex:0];
            [ebuyv.view showHUDIndicatorViewAtCenter:nil yOffset:-60];
        }
        else
        {
            [service beginLoginWithUsername:userName password:password];
        }
    }
    else
    {
        [self done];
    }
}

- (void)userLoginCompletedWithResult:(BOOL)successfulLogin
                           errorCode:(NSString *)errorCode
{
    //add by zhangbeibei 20140804:启动页dm维护为本地生活,goToLocalLife:(NSString *)tuanGouType snProId:(NSString *)snProId方法里有设置rootViewController，下面的v运行时是一个BBSideBarViewController
    if ([[AppDelegate currentAppDelegate].window.rootViewController isKindOfClass:[TabBarController class]]) {
        TabBarController *v = (TabBarController *)[AppDelegate currentAppDelegate].window.rootViewController;
        AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[v.viewControllers objectAtIndex:4];
        MyEbuyViewController *ebuyv = (MyEbuyViewController *)[[nav childViewControllers] objectAtIndex:0];
        [ebuyv.view hideHUDIndicatorViewAtCenter];
    }
        

    if (successfulLogin)
    {
        //JUST post a notification
        [[NSNotificationCenter defaultCenter] postNotificationName:AUTOLOGIN_OK_MESSAGE object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:AUTOLOGIN_Failed_MESSAGE object:nil];
    }
    
    [self done];
}

@end
