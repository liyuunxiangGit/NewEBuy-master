//
//  AppDelegate.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright Suning 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"
#import "WXApi.h"
#import "DMOrderDTO.h"
#if kPanUISwitch
#import "ScreenShotView.h"
#endif
#undef APP_DELEGATE
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])


@class NetworkReach;
@class TabBarController;

@class HomePageViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    @private
    NetworkReach *netReach_;
    
    TabBarController *tabBarViewController_;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly, strong) NetworkReach *netReach;

@property (nonatomic, readonly, strong) TabBarController *tabBarViewController;

@property (nonatomic, strong) HomePageViewController *homeViewController;

@property (nonatomic, strong) DMOrderResultDTO *dmResultDto;

@property (nonatomic) ActivityFromType fromType;

@property (nonatomic, assign) CFAbsoluteTime resignTime;  //记录进入后台的时间
@property (nonatomic, assign) CFAbsoluteTime currentTime;  //记录进入后台的时间
#if kPanUISwitch
@property (strong, nonatomic) ScreenShotView *screenshotView;
#endif
+ (AppDelegate *)currentAppDelegate;

//网络是否连接
- (BOOL)isNetReachable;

- (BOOL)isHeightQuailtyImg;

- (void)startSuningBI;

- (void)checkVersionUpdate;

-(NSDictionary*)hasDownloadDm;

@end
