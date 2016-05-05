//
//  SuningMainClick.m
//  SuningEBuy
//
//  Created by xy ma on 11-12-27.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import "SuningMainClick.h"
#import "AppDelegate.h"
#import "CommonViewController.h"
#import "UserCenter.h"
#import "InformationCollectService.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "SNSwitch.h"
#import "SFHFKeychainUtils.h"

@interface SuningMainClick()
{
    //    BOOL    isFirstUsing;       //是否是应用程序刚启动
}


@property (nonatomic, strong) NSOperationQueue *dataCollectQueue;


@end

/*********************************************************************/

@implementation SuningMainClick

@synthesize currentPageTitle = _currentPageTitle;
@synthesize currentPageInTime = _currentPageInTime;
@synthesize dataCollectQueue = _dataCollectQueue;


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_currentPageInTime);
    TT_RELEASE_SAFELY(_currentPageTitle);
    TT_RELEASE_SAFELY(_dataCollectQueue);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        _dataCollectQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark application life

- (CommonViewController *)getVisibleViewController
{
    TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
    
    UINavigationController *currentNav = (UINavigationController *)tabBarVC.presentedViewController;
    
    if (!currentNav) {
        currentNav = (UINavigationController *)[tabBarVC selectedViewController];
    }
    
    CommonViewController *visibleVC = nil;
    if ([currentNav isKindOfClass:[UINavigationController class]])
    {
        if ([currentNav.topViewController isKindOfClass:[CommonViewController class]]) {
            visibleVC = (CommonViewController *)currentNav.topViewController;

        }
    }
    else if ([currentNav isKindOfClass:[CommonViewController class]])
    {
        visibleVC = (CommonViewController *)currentNav;
    }
    
    return visibleVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    SuningPageObject *obj = [SuningMainClick sharedInstance].currentPageObj;
    if (obj) {
        [obj outColletion:nil];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    if ([SNSwitch isSuningBISDKOn]) {
//        [SSAIOSSNDataCollection useInfoEndCollecting:kAppName];
//    }
}

- (void)sendLastInformationCollect
{
    InformationCollectService *informationTask = [[InformationCollectService alloc] init];
    
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:AppStartSendDataStat],kInfoDataType,nil];
    
    informationTask.collectDataDic = infoDic;
    
    // 发送数据并清空表
    [self.dataCollectQueue addOperation:informationTask];
    
    TT_RELEASE_SAFELY(informationTask);
    
    GetAllSysInfo *systemTask = [[GetAllSysInfo alloc] init];
    
    //在发送数据完成后收集系统信息
    if ([self.dataCollectQueue operationCount] > 0)
    {
        InformationCollectService *theBeforeTask = [[self.dataCollectQueue operations] lastObject];
        
        [systemTask addDependency:theBeforeTask];
    }
    
    // 存储系统信息
    [self.dataCollectQueue addOperation:systemTask];
    
    if ([Config currentConfig].pageKey != 0) {
        
        [Config currentConfig].pageKey=[NSNumber numberWithInt:0];
    }
    
    TT_RELEASE_SAFELY(systemTask);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    SuningPageObject *obj = [SuningMainClick sharedInstance].currentPageObj;
    if (obj) {
        [obj inColletion];
    }
}

#pragma mark -
#pragma mark enigne
+ (void)endPage:(NSString*)aName
{
    if ([SNSwitch isSuningBISDKOn])
    {
        [SSAIOSSNDataCollection singlePageOutCollection:aName];
    }
}

+ (void)startPage
{
    [SuningMainClick sharedInstance].currentPageInTime=[Preferences systemTimeInfo];
    if ([SNSwitch isSuningBISDKOn])
    {
        [SSAIOSSNDataCollection singlePageInCollection];
    }

}

+ (void)start
{
    //    [SuningMainClick sharedInstance]->isFirstUsing = YES;
    [SuningMainClick appLaunched];
    [[SuningMainClick sharedInstance] sendLastInformationCollect];
}

+ (void)appLaunched{
    
    [Config currentConfig].startTime = [Preferences systemTimeInfo];    
}

+ (void)appTerminated{
    
    if ([Config currentConfig].md5Timestring!=nil&&![[Config currentConfig].md5Timestring isEqualToString:@""])
    {
        [Config currentConfig].md5Timestring=@"";
        
    }
    
    
    InformetionCollectDTO *_iphoneUserInfo=[[InformetionCollectDTO alloc]init];
    
    //1-登陆状态
    if(![UserCenter defaultCenter].isLogined){
        //访客
        [_iphoneUserInfo setIsLogin:@"G"];
        
    }else{
        //登陆用户
        [_iphoneUserInfo setIsLogin:@"R"];
    }
    // DLog(@"isLogin is %@",_iphoneUserInfo.isLogin);
    
    //2-用户账户（可选,可以为空）
    
    NSString *loginName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
    
    [_iphoneUserInfo setLoginName:loginName];
    
    //DLog(@"loginName=%@",_iphoneUserInfo.loginName);
    
    //3-开始时间
    [_iphoneUserInfo setAppStartTime:[Config currentConfig].startTime];
    
    //DLog(@"startTime=%@",_iphoneUserInfo.appStartTime);
    
    
    //SuningEBuyAppDelegate *appDelegate = [SuningEBuyAppDelegate currentAppDelegate];
    //4－用户离开时间
    [Config currentConfig].stopTime=[Preferences systemTimeInfo];
    
    [_iphoneUserInfo setAppStopTime:[Config currentConfig].stopTime];
    
    // DLog(@"stopTime=%@",_iphoneUserInfo.appStopTime);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:IphoneUsingStat], kInfoDataType, _iphoneUserInfo, kInfoDataValue, nil];
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    
    [collect saveCollectedDataWithDic:dic];
    
    TT_RELEASE_SAFELY(collect);
    
    TT_RELEASE_SAFELY(_iphoneUserInfo);
    
    
    // InformationCollectDAO *dao = [[InformationCollectDAO alloc] init];
    
    // [dao insertCollectedInformation:appDelegate.iphoneUseTbl withType:IphoneUsingStat];
    
}

- (void)getUserRegisterNameAndSave:(NSString *)registerName{
    if ([SNSwitch isSuningBISDKOn]) {
        [SSAIOSSNDataCollection RegisterNameCollection:registerName];
        return;
    }
    
    InformetionCollectDTO *_registerInfo = [[InformetionCollectDTO alloc]init];
    
    //1-登陆状态
    if(![UserCenter  defaultCenter].isLogined){
        //访客
        [_registerInfo setIsLogin:@"G"];
        
    }else{
        //登陆用户
        [_registerInfo setIsLogin:@"R"];
    }
    //DLog(@"login is %@",_registerInfo.isLogin);
    
    //2-用户账户（可选,可以为空）
    
    NSString *loginName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
    
    //DLog(@"loginName is = %@\n",loginName);
    
    [_registerInfo setLoginName:loginName];
    
    //3-用户注册用户名
    
    [_registerInfo setRegisterName:registerName];
    
    //DLog(@"registerName=%@",_registerInfo.registerName);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:UserRegisterStat], kInfoDataType, _registerInfo, kInfoDataValue, nil];
    
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    collect.collectDataDic = dic;
    
    [self.dataCollectQueue addOperation:collect];
    
    TT_RELEASE_SAFELY(collect);
    
    TT_RELEASE_SAFELY(_registerInfo);
    
    
}

- (void)getOrderAndSave:(NSString *)order{
    if ([SNSwitch isSuningBISDKOn]) {
        if (IsStrEmpty(order))
        {
            return;
        }
        [SSAIOSSNDataCollection OrderNumCollection:order];
        return;
    }
    
    InformetionCollectDTO *_orderInfo=[[InformetionCollectDTO alloc]init];
    
    //1-登陆状态
    if(![UserCenter  defaultCenter].isLogined){
        //访客
        [_orderInfo setIsLogin:@"G"];
        
    }else{
        //登陆用户
        [_orderInfo setIsLogin:@"R"];
    }
    //DLog(@"login is %@",_orderInfo.isLogin);
    
    //2-用户账户（可选,可以为空）
    
    NSString *loginName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
    
    //DLog(@"loginName is = %@\n",loginName);
    
    [_orderInfo setLoginName:loginName];
    
    //3-订单号
    [_orderInfo setOrderNum:order];
    //DLog(@"orderNum=%@",_orderInfo.orderNum);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:UserOrderNumStat], kInfoDataType, _orderInfo, kInfoDataValue, nil];
    
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    collect.collectDataDic = dic;
    
    [self.dataCollectQueue addOperation:collect];
    
    TT_RELEASE_SAFELY(collect);
    
    TT_RELEASE_SAFELY(_orderInfo);
    
}


- (void)getSearchAndSave:(NSArray *)array{
    if ([SNSwitch isSuningBISDKOn]) {
        
        NSString *str0 = [array safeObjectAtIndex:0];
        NSString *str1 = [array safeObjectAtIndex:1];
        int num = 0;
        if (!IsStrEmpty(str1))
        {
            num = [str1 intValue];
        }
        NSString *str2 = [array safeObjectAtIndex:2];
        [SSAIOSSNDataCollection SearchInfoCollection:str0
                            resultCount:num
                                     searchStyle:str2];
        //[SSAIOSSNDataCollection SearchInfoCollection:[array objectAtIndex:0] resultCount:[[array objectAtIndex:1] intValue]];
        return;
    }
    
    InformetionCollectDTO *_searchInfo=[[InformetionCollectDTO alloc]init];
    
    //1-登陆状态
    if(![UserCenter  defaultCenter].isLogined){
        //访客
        [_searchInfo setIsLogin:@"G"];
        
    }else{
        //登陆用户
        [_searchInfo setIsLogin:@"R"];
    }
    // DLog(@"login is %@",_searchInfo.isLogin);
    
    //2-用户账户（可选,可以为空）
    
    NSString *loginName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
    
    // DLog(@"loginName is = %@\n",loginName);
    
    [_searchInfo setLoginName:loginName];
    
    //    SearchListViewController *searchList=[[[SearchListViewController alloc]init]autorelease];
    //
    //    NSArray *resultDate= searchList.getkeyanddata;
    
    //3-搜索关键词
    [_searchInfo setSearchKey:[array objectAtIndex:0]];
    
    // DLog(@"searchKey=%@",[array objectAtIndex:0]);
    
    //4－搜索结果数
    [_searchInfo setSearchResult:[array objectAtIndex:1]];
    //DLog(@"searchResult=%@",[array objectAtIndex:1]);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ProductSearchStat], kInfoDataType, _searchInfo, kInfoDataValue, nil];
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    
    [collect saveCollectedDataWithDic:dic];
    
    TT_RELEASE_SAFELY(collect);
    
    
    TT_RELEASE_SAFELY(_searchInfo);
    
}

- (void)entryBackPageAndSave:(NSString *)aStr{
    
    if ([SNSwitch isSuningBISDKOn])
    {
        if (aStr.length)
        {
            [SSAIOSSNDataCollection singlePageOutCollection:aStr];
        }
        
        return;
    }
}

- (void)getPageAndSave:(NSArray *)array{
    
    if ([SNSwitch isSuningBISDKOn])
    {

        return;
    }
    
    InformetionCollectDTO *_pageInfo=[[InformetionCollectDTO alloc]init];
    
    //1-登陆状态
    if(![UserCenter defaultCenter].isLogined){
        //访客
        [_pageInfo setIsLogin:@"G"];
        
    }else{
        //登陆用户
        [_pageInfo setIsLogin:@"R"];
    }
    // DLog(@"login is %@",_pageInfo.isLogin);
    
    //2-用户账户（可选,可以为空）
    
    NSString *loginName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
    
    //DLog(@"loginName is = %@\n",loginName);
    
    [_pageInfo setLoginName:loginName];
    
    //3-页面序号
    
    [_pageInfo setPageKey:[array objectAtIndex:0]];
    
    // DLog(@"pagKey=%@",_pageInfo.pageKey);
    
    //4-页面名称
    
    [_pageInfo setPageName:[array objectAtIndex:1]];

    //DLog(@"pageName=%@",_pageInfo.pageName);
    
    //5－页面进入时间
    
    [_pageInfo setPageInTime:[array objectAtIndex:2]];
    //DLog(@"pageInTime=%@",_pageInfo.pageInTime);
    
    //6－页面离开时间
    
    [_pageInfo setPageOutTime:[array objectAtIndex:3]];
    // DLog(@"pageOutTime=%@",_pageInfo.pageOutTime);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:PageAccessingStat], kInfoDataType, _pageInfo, kInfoDataValue, nil];
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    
    [collect saveCollectedDataWithDic:dic];
    
    TT_RELEASE_SAFELY(collect);
    
    TT_RELEASE_SAFELY(_pageInfo);
    
}

- (void)getCrashAndsave:(NSString *)crashInfo{
    
    InformetionCollectDTO *_crashInfo=[[InformetionCollectDTO alloc]init];
    
    //1-登陆状态
    if(![UserCenter defaultCenter].isLogined){
        //访客
        [_crashInfo setIsLogin:@"G"];
        
    }else{
        //登陆用户
        [_crashInfo setIsLogin:@"R"];
    }
    // DLog(@"login is %@",_crashInfo.isLogin);
    
    //2-用户账户（可选,可以为空）
    
    NSString *loginName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
    
    // DLog(@"loginName is = %@\n",loginName);
    
    [_crashInfo setLoginName:loginName];
    
    //3-崩溃信息
    
    [_crashInfo setCrashInfo:crashInfo];
    
    // DLog(@"crashInfo=%@",_crashInfo.crashInfo);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:SystemCrashDownStat], kInfoDataType, _crashInfo,kInfoDataValue, nil];
    
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    
    [collect saveCollectedDataWithDic:dic];
    
    TT_RELEASE_SAFELY(collect);
    
    TT_RELEASE_SAFELY(_crashInfo);
    
}

- (void)loginInApp
{
    NSString *username = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username
    if ([SNSwitch isSuningBISDKOn]) {
        [SSAIOSSNDataCollection LoginNameCollection:kAppName channel:kDownloadChannelNum loginName:username];
    }
}

#pragma mark Singleton methods
#pragma mark 单例方法

static SuningMainClick *_instance = nil;

+ (SuningMainClick *)sharedInstance
{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[SuningMainClick alloc] init];
            
        }
    }
    return _instance;
}

@end
