//
//  AppDelegate.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright Suning 2012年. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkReach.h"
#import "TabBarController.h"
#import "DAO.h"
#import "SuningMainClick.h"
#import "MessagePushService.h"
#import "GlobalDataCenter.h"
#import "CheckUpdateCommand.h"
#import "Reachability.h"
#import "LocateCityCommand.h"
#import "MessagePushCommand.h"
#import "CollectDeviceTokenCommand.h"

#import "LaunchAdViewController.h"
#import "AppHelperViewController.h"

#import "AdModel2ViewController.h"
#import "AdModel3ViewController.h"

#import "SNActivityViewController.h"

#import "SNCache.h"
#import "HomeScrollViewController.h"
#import "HomePageViewController.h"

#import "SNRouter.h"
#import "SNSwitch.h"
#import "OpenUDID.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "WeiboSDK.h"
#import "dvSoundDecoder.h"

// 百度地图 ak 注册 xzoscar 2014/08/14 add
#import "BMapKit.h"

//NBS, 越狱打开
#ifdef DISTRIBUTION_JAILBROKEN
#import <libNBSAppAgent/NBSAppAgent.h>
#endif

//科大讯飞语音识别
#import "iflyMSC/iflySetting.h"
//#import "Definition.h"
#import "iflyMSC/IFlySpeechUtility.h"

#import "DMOrderService.h"


#define APPID_VALUE @"541bcbfa"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位
#define BEST_URL_VALUE        @"1"                // best_search_url 最优搜索路径


#define SEARCH_AREA_VALUE     @"安徽省合肥市"
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"


//友盟应用key
#define UMENG_APPKEY    @"50651095527015300a000201"
#define UMENG_TEST_APPKEY @"50d96cb452701506b2000008"
#define kAppKey	 			@"2344735905"

#define  WeiXinAppKey   @"wxe386966df7b712ca"
#define WeiXinAppSecret  @"68da87e88cc50eaa76c395807c290d86"

// 百度地图 ak
//百度账号suningebuy1@163.com,百度账号密码与邮箱密码均是12312a  add by wxj
#define kBMapAccessKey @"tPOv0XtdyPYb6xpViD3sTUZs"

#if kPanUISwitch
static char szListenTabbarViewMove[] = "listenTabViewMove";
#endif
/*//本地通知
 #define DayNumber          7
 #define HourNumber         60
 #define MinuteNumber     60
 #define SecondsNumber  60
 
 #define kTimeOffset    (DayNumber*HourNumber*MinuteNumber*SecondsNumber)
 */


@interface AppDelegate()<BMKGeneralDelegate>

@property (nonatomic, strong) AppHelperViewController *helperScrollView;
@property (nonatomic, strong) LaunchAdViewController *launchAdView;

@property (nonatomic, strong) DMOrderService         *DMService;

- (void)checkVersionUpdate;
- (void)ShowPushMessage;

// 百度地图 引擎
@property (nonatomic,strong) BMKMapManager *bmkmapEngine;

@end

/*********************************************************************/

@implementation AppDelegate

@synthesize window = _window;
@synthesize netReach = netReach_;
@synthesize tabBarViewController = tabBarViewController_;
@synthesize homeViewController = _homeViewController;


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_window);
    TT_RELEASE_SAFELY(netReach_);
    TT_RELEASE_SAFELY(tabBarViewController_);
    TT_RELEASE_SAFELY(_homeViewController);
    TT_RELEASE_SAFELY(_helperScrollView);
    TT_RELEASE_SAFELY(_launchAdView);
    TT_RELEASE_SAFELY(_dmResultDto);
    SERVICE_RELEASE_SAFELY(_DMService);
    
}

- (NetworkReach *)netReach
{
    if (!netReach_) {
        netReach_ = [[NetworkReach alloc] init];
    }
    return netReach_;
}

//是否是版本更新后首次打开
- (BOOL)isVersionUpdated
{
    NSString *updateVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *helperVersion =  [Config currentConfig].helperVersion;
    if ([helperVersion isEqualToString:@""] || helperVersion == nil) {
        [Config currentConfig].helperVersion = updateVersion;
        return YES;
    }
    if ([updateVersion isEqualToString:helperVersion]) {
        return NO;
    }else{
        [Config currentConfig].helperVersion = updateVersion;
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark umeng

- (void)startSuningBI
{
    if ([SNSwitch isSuningBISDKOn]) {
        //设置环境
//#if kReleaseH
//        [SSAIOSSNDataCollection setSSAServer:kSetPrd];
//#else
//        [SSAIOSSNDataCollection setSSAServer:kSetSit];   
//#endif
//        [SSAIOSSNDataCollection selfSetDeviceMode:@"ebuy"];
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            [SSAIOSSNDataCollection startWithAppkey:kAppName channel:kDownloadChannelNum cityName:!IsStrEmpty([Config currentConfig].locationCity)?[Config currentConfig].locationCity:@"南京市"];            
//        });
    }else{
        [SuningMainClick start];
    }
    [SuningMainClick sharedInstance].isSuningMainClickStart = YES;
}

#pragma mark -
#pragma mark swithList

- (void)ShowPushMessage
{
    MessagePushCommand *cmd = [MessagePushCommand command];
    [CommandManage excuteCommand:cmd completeBlock:nil];
}

- (void)checkVersionUpdate
{
    //检查更新
    if (![CheckUpdateCommand autoChecked])
    {
        CheckUpdateCommand *command = [[CheckUpdateCommand alloc] initWithCheckUpdateMode:AutoCheck];
        [CommandManage excuteCommand:command completeBlock:^(id<Command> cmd) {
            
            [self ShowPushMessage];
            
            //如果因网络或其他原因导致未检查成功,监听网络
            if (![CheckUpdateCommand autoChecked])
            {
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(reachabilityChanged:)
                                                             name:kReachabilityChangedNotification
                                                           object:nil];
            }
        }];
    }
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    if ([self isNetReachable])
    {
//        [self checkVersionUpdate];
    }
}

#pragma mark -
#pragma mark application life cycle

- (BMKMapManager *)bmkmapEngine {
    if (nil == _bmkmapEngine) {
        _bmkmapEngine = [[BMKMapManager alloc] init];
    }
    return _bmkmapEngine;
}

/**
 *返回授权验证错误
 *@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
 */
- (void)onGetPermissionState:(int)iError {
    if (BMKErrorOk == iError) {
        DLog(@"百度地图 ak 成功！\n\n");
    }else {
        DLog(@"百度地图 ak 失败！\n\n");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.bmkmapEngine start:kBMapAccessKey generalDelegate:self];
    
    [WeiboSDK registerApp:kAppKey];

    [WXApi registerApp:WeiXinAppKey];
    
    [GlobalDataCenter defaultCenter].homeDataVersion = @"-1";
    
    //语音识别初始化
    //设置log等级，此处log为默认在documents目录下的msc.log文件
    [IFlySetting setLogFile:LVL_ALL];
    
    //输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",APPID_VALUE,TIMEOUT_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
#ifdef DEBUGLOG
    [SNLogger startWithLogLevel:SNLogLevelDEBUG];
#else
    [SNLogger startWithLogLevel:SNLogLevelOFF];
#endif
    SNImageCacheConfig();
    
    /*建表*/
    [DAO createTablesNeeded];
    
    /*初始化网络判断*/
    [self.netReach initNetwork];
    
//    /*数据收集*/
//    [self startSuningBI];
    
    //NBS数据收集
#ifdef DISTRIBUTION_JAILBROKEN
    [NBSAppAgent startWithAppID:@"8c8dfbd4111f4566b39f3efb6f74d2b2"];
#endif
    
    /*梦之声*/
    [[dvSoundDecoder instance] setappid:@"3"];
    

    /*初始化视图*/
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:frame];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    tabBarViewController_ = [[TabBarController alloc] init];
    self.window.rootViewController = tabBarViewController_;
    //active
    [self.window makeKeyAndVisible];
    
    //setStatusBar
#ifdef __IPHONE_7_0
    if (IOS7_OR_LATER)
    {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
#else
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
#endif
    
    [Config currentConfig].nearByUnLocate = @YES;
    
    //判断是否需要显示指引页,无指引页时展示广告页
//    BOOL isFirstStarted = [self  isVersionUpdated];
    if ([self  isVersionUpdated])
    {
        self.helperScrollView = [[AppHelperViewController alloc] init];
        __weak AppDelegate *weakSelf = self;
        [self.helperScrollView setDismissBlock:^{
            weakSelf.helperScrollView = nil;
            //检查更新
//            [weakSelf checkVersionUpdate];
            //定位
            LocateCityCommand *cmd_ = [[LocateCityCommand alloc] init];
            cmd_.timeOutDefault = 60.0f;
            [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
                
                if (cmd_.responseStatus == LocateCitySuccess)
                {
                    [LocateCityCommand saveCityToConfig:cmd_.cityName];
                }
            }];
            
            [weakSelf postNotificationOfFirstLoadHome];
        }];
        [self.helperScrollView showOnWindow:self.window];
    }
    else
    {
        //有远程消息进远程消息信息 否则走dm单流程
        NSDictionary *remoteNotificationInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        //        remoteNotificationInfo = @{
        //        @"adTypeCode" : @"25",
        //        @"adId" : @"107",
        //        @"activityTitle" : @"11",
        //        @"activityRule" : @"11",
        //        @"activityPictureUrl" : @"http://image1.suning.cn/images/9/bl111_1200.jpg",
        //        };
        
        if (remoteNotificationInfo)
        {
            [self performSelector:@selector(receiveRemoteNotification:) withObject:remoteNotificationInfo afterDelay:1];
//            [self checkVersionUpdate];
            
            [self postNotificationOfFirstLoadHome];
        }
        else{
            
            NSDictionary *dmDict = [self hasDownloadDm];
            
            if (dmDict)
            {
                self.launchAdView = [[LaunchAdViewController alloc] init];
                
                __weak AppDelegate *weakSelf = self;
                
                _launchAdView.dmInfoDict = dmDict;
                
                [self.launchAdView setDismissBlock:^{
                    
                    weakSelf.launchAdView = nil;
                    //检查更新
//                    [weakSelf checkVersionUpdate];
                    
                    [weakSelf postNotificationOfFirstLoadHome];
                }];
                
                [self.launchAdView showOnWindow:self.window];
                
            }else{
                
//                [self checkVersionUpdate];
                
                [self postNotificationOfFirstLoadHome];
            }
        }
        //定位
        LocateCityCommand *cmd_ = [[LocateCityCommand alloc] init];
        
        cmd_.timeOutDefault = 60.0;
        
        [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
            
            if (cmd_.responseStatus == LocateCitySuccess)
            {
                [LocateCityCommand saveCityToConfig:cmd_.cityName];
            }

        }];
    }
    
    [self getDMList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getDMList)
                                                 name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                               object:nil];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //获取deviceToken
    if (IOS8_OR_LATER) {

        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:notiSettings];
        
    }else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
    
    //本地生活城市列表置空
    [Config currentConfig].gbCityList = nil;
#if kPanUISwitch
    self.screenshotView = [[ScreenShotView alloc] initWithFrame:CGRectMake(0, 0, self.window.size.width, self.window.size.height)];
    [self.window insertSubview:_screenshotView atIndex:0];
    
    [self.window.rootViewController.view addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:szListenTabbarViewMove];
    
    self.screenshotView.hidden = YES;
#endif
    
    return YES;
}

#if kPanUISwitch
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == szListenTabbarViewMove)
    {
        NSValue *value  = [change objectForKey:NSKeyValueChangeNewKey];
        CGAffineTransform newTransform = [value CGAffineTransformValue];
        [self.screenshotView showEffectChange:CGPointMake(newTransform.tx, 0) ];
    }
}
#endif

- (void)postNotificationOfFirstLoadHome
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HOME_FIRST_LOADED_MESSAGE object:nil];
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    DLog(@"handle url: %@",url);
    NSComparisonResult comparR = [[url absoluteString] compare:kURLSchemeSuningEBuy
                                                       options:NSCaseInsensitiveSearch
                                                         range:NSMakeRange(0, 24)];
    if (comparR == NSOrderedSame)
    {
        if (_launchAdView) {
            [_launchAdView dismissAd];
        }
        return [SNRouter handleOpenUrl:url onChecking:^(SNRouterObject *obj) {
            [self.window showHUDIndicatorViewAtCenter:L(@"Loading")];
        } shouldRoute:^BOOL(SNRouterObject *obj) {
            [self.window hideHUDIndicatorViewAtCenter];
            if (obj.errorMsg.length) [self.window showTipViewAtCenter:obj.errorMsg];
            return YES;
        } didRoute:NULL];
    }
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    DLog(@"handle url: %@",url);
    NSComparisonResult comparR = [[url absoluteString] compare:kURLSchemeSuningEBuy
                                                       options:NSCaseInsensitiveSearch
                                                         range:NSMakeRange(0, 24)];
    if (comparR == NSOrderedSame)
    {
        if (_launchAdView) {
            [_launchAdView dismissAd];
        }
        return [SNRouter handleOpenUrl:url onChecking:^(SNRouterObject *obj) {
            
        } shouldRoute:^BOOL(SNRouterObject *obj) {
            
            return YES;
        } didRoute:NULL];
    }
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    //记录进入后台的时间
    self.resignTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    
    /*    //本地通知
     UILocalNotification *notification=[[UILocalNotification alloc] init];
     
     if (notification!=nil) {
     
     NSTimeInterval secondsPerDay = kTimeOffset;
     
     NSDate  *lateDay = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
     
     notification.fireDate=lateDay;
     notification.timeZone=[NSTimeZone defaultTimeZone];
     notification.alertBody=@"您已经有7天没有打开苏宁易购";
     notification.repeatInterval = 0;//循环次数
     
     [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
     
     [notification release];
     }
     */
    
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    //点击提示框的打开
//    application.applicationIconBadgeNumber = 0;
//}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    if ([SNSwitch isSuningBISDKOn])
    {
        [SSAIOSSNDataCollection useInfoEndCollecting:kAppName];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // add by 崔正来  进入后台时清空热门促销商品, modify by liukun ，使用nscache
    [[SNMemoryCache defaultCache] removeObjectForKey:@"sn.hotsale"];
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //当应用进入后台时间超过5分钟，默认为下一次进入，刷新活动开关
    self.currentTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    
    if (self.resignTime != 0 && self.currentTime - self.resignTime > 600)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:INTO_BACKGROUND_OVER_5_MIN object:nil];
    }
    //    //取消本地通知
    //    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if ([SNSwitch isSuningBISDKOn])
    {
#if kReleaseH
        [SSAIOSSNDataCollection setSSAServer:kSetPrd];
#else
        [SSAIOSSNDataCollection setSSAServer:kSetSit];
#endif
        [SSAIOSSNDataCollection ShutDownHttpWatch];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [SSAIOSSNDataCollection startWithAppkey:kAppName channel:kDownloadChannelNum cityName:!IsStrEmpty([Config currentConfig].locationCity)?[Config currentConfig].locationCity:L(@"NanjingCity")];
        });
        
        [SSAIOSSNDataCollection useInfoStartCollecting:kAppName];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
   if (deviceToken)
    {
        CollectDeviceTokenCommand *command = [CollectDeviceTokenCommand command];
        command.deviceToken = deviceToken;
        [command execute];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    DLog(@"receive RemoteNotification: %@", userInfo);
    
    if (application.applicationState == UIApplicationStateInactive)
    {
        //[self receiveRemoteNotification:userInfo isActive:NO];
        [self performSelector:@selector(receiveRemoteNotification:) withObject:userInfo afterDelay:1];
    }
    else if (application.applicationState == UIApplicationStateActive)
    {
        //[self receiveRemoteNotification:userInfo isActive:YES];
    }
    
}

- (void)receiveRemoteNotification:(NSDictionary *)userInfo
{
    [self receiveRemoteNotification:userInfo isActive:NO];
}

- (void)receiveRemoteNotification:(NSDictionary *)userInfo isActive:(BOOL)active
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications] ;
    
    if (active) {
        
        return;
    }
    
    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:0];
    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
    remotePageTitle = L(@"Product_Push");
    //dm
    [SNRouter handleAdTypeCode:EncodeStringFromDic(userInfo, @"adTypeCode")
                          adId:EncodeStringFromDic(userInfo, @"adId")
                        chanId:EncodeStringFromDic(userInfo, @"activityRule")
                       qiangId:EncodeStringFromDic(userInfo, @"activityTitle")
                    onChecking:^(SNRouterObject *obj) {
                        [self.window showHUDIndicatorViewAtCenter:L(@"Loading")];
                    } shouldRoute:^BOOL(SNRouterObject *obj) {
                        [self.window hideHUDIndicatorViewAtCenter];
//                        if (obj.errorMsg.length) [self.window showTipViewAtCenter:obj.errorMsg];
                        return YES;
                    } didRoute:NULL
                        source:SNRouteSourceRemoteNotification];
}

#pragma mark -
#pragma mark custom methods

+ (AppDelegate *)currentAppDelegate
{
    
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
}

- (BOOL)isNetReachable
{
    return self.netReach.isNetReachable;
}

- (BOOL)isHeightQuailtyImg{
    
    ImageQuailty quailty = [[Config currentConfig].imageQuailty intValue];
    
    if (HEIGHT_QUAILTY == quailty) {
        
        return YES;
    }
    
    if (LOW_QUAILTY == quailty) {
        
        return NO;
    }
    
    if (ReachableViaWiFi == [self.netReach.hostReach currentReachabilityStatus]) {
        
        return YES;
    }
    
    return NO;
}

//返回在生效期内dm的image data
-(NSDictionary*)hasDownloadDm
{
    NSMutableArray *dmArray = [Config currentConfig].launchDms;
    
    if (IsArrEmpty(dmArray))
    {
        return nil;
    }else{
        for (NSDictionary *item in dmArray)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *endTime = [dateFormatter dateFromString:[item objectForKey:@"dmEndTime"]];
            
            NSDate *startTime = [dateFormatter dateFromString:[item objectForKey:@"dmStartTime"]];
            
            if ([[NSDate date] compare:startTime] == NSOrderedDescending&&[[NSDate date] compare:endTime] == NSOrderedAscending)
            {
                return item;
            }
        }
        
        return nil;
    }
}

-(void)getDMList
{
    //更新dm
    [self.DMService getDMArrayRequest:[Config currentConfig].defaultCity];
}

-(DMOrderService *)DMService{
    
    if (!_DMService) {
        
        _DMService = [[DMOrderService alloc] init];
        
    }
    
    return _DMService;
}

@end
