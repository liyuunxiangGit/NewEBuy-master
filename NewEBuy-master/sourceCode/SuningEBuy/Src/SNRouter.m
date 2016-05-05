//
//  SNRouter.m
//  SuningEBuy
//
//  Created by liukun on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNRouter.h"
#import "LotteryPayPlugin.h"
#import "SNWebViewController.h"
#import "SNSpecialListViewController.h"
#import "LotteryHallViewController.h"
#import "PaymentCenterViewController.h"
#import "HotSaleViewController.h"
#import "ServiceTrackListViewController.h"
#import "BrowsingHistoryViewController.h"
#import "MyFavoriteViewController.h"
#import "SNSpecialSubjectViewController.h"
#import "SNActivityViewController.h"
#import "ProductDetailViewController.h"
#import "BBSideBarViewController.h"
#import "AllOrderListViewController.h"
#import "SearchListViewController.h"
#import "AdModel2ViewController.h"
#import "AdModel3ViewController.h"
#import "AdModel4ViewController.h"
#import "AdModel5ViewController.h"
#import "AdModel6ViewController.h"
#import "PlayVoiceViewController.h"
#import "NearbySuningMainViewController.h"
#import "PurchaseProductListViewController.h"
#import "CheckInViewController.h"
#import "MyEbuyViewController.h"
#import "MyCardViewController.h"
#import "EvaluationViewController.h"
#import "EvalutionContentViewController.h"
#import "NewOrderSnxpressViewController.h"
#import "ServiceDetailViewController.h"
#import "ProductDisOrderSubmitViewController.h"
#import "ReturnGoodsListViewController.h"
#import "NewInviteFriendViewController.h"
#import "NewGetRedPackEntryViewController.h"
#import "AddressInfoListViewController.h"
#import "UserFeedBackNewViewController.h"
#import "QYaoYiYaoViewCtrler.h"
#import "PaymentModeViewController.h"
#import "ScanerAuthoViewController.h"
#import "CheckUpdateCommand.h"
#import "QYaoYiYaoScoreViewCtrler.h"
#import "SNInformationViewController.h"
#import "MyIntegralExchangeViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "SNWebViewController.h"
#import "HomePage244/Controller/LianBanZhuanTiViewController.h"
#import "SalePromotionViewController.h"
#import "ZhuanTiService244.h"
#import "MoreViewController.h"
#import "NewRegisterViewController.h"
#import "PruductList244ViewController.h"

@interface SNRouter() <AdModelServiceDelegate,SpecialSubjectServiceDelegate,SNActivityServiceDelegate,PurchaseServiceDelegate,ProductDetailServiceDelegate,EightBannerADServiceDelegate>
{
    NSDictionary    *__routeFilter;
}

@property (nonatomic, strong) id service;

@end

#pragma mark -

@implementation SNRouter

+ (instancetype)sharedInstance
{
    static SNRouter *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SNRouter alloc] init];
    });
    return _instance;
}

+ (void)cancelCurrentTask
{
    [[SNRouter sharedInstance] _cancelCurrentTask];
}

- (void)_cancelCurrentTask
{
    if (_service) {
        SERVICE_RELEASE_SAFELY(_service);
    }
}

#pragma mark - parse route info

+ (void)handleURL:(NSString *)url
       onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
      shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
         didRoute:(void (^)(SNRouterObject *))didRouteBlock
           source:(SNRouteSource)source
{
    [[SNRouter sharedInstance] _handleURL:url
                               onChecking:onCheckingBlock
                              shouldRoute:shouldRouteBlock
                                 didRoute:didRouteBlock
                                   source:source];
}


+ (void)handleURL:(NSString *)url
       onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
      shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
         didRoute:(void (^)(SNRouterObject *))didRouteBlock
           source:(SNRouteSource)source
    navController:(UINavigationController *)navCon
{
    [[SNRouter sharedInstance] _handleURL:url
                               onChecking:onCheckingBlock
                              shouldRoute:shouldRouteBlock
                                 didRoute:didRouteBlock
                                   source:source
                                navController:navCon];
}

+ (BOOL)handleOpenUrl:(NSURL *)openUrl
           onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
          shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
             didRoute:(void (^)(SNRouterObject *))didRouteBlock
{
    [[SNRouter sharedInstance] _handleURL:[openUrl absoluteString]
                               onChecking:onCheckingBlock
                              shouldRoute:shouldRouteBlock
                                 didRoute:didRouteBlock
                                   source:SNRouteSourceOpenUrl];
    return YES;
}

+ (void)handleAdTypeCode:(NSString *)adTypeCode
                    adId:(NSString *)adId
                  chanId:(NSString *)chanId
                 qiangId:(NSString *)qiangId
              onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
             shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
                didRoute:(void (^)(SNRouterObject *))didRouteBlock
                  source:(SNRouteSource)source
{
    [[SNRouter sharedInstance] _handleAdTypeCode:adTypeCode
                                            adId:adId
                                          chanId:chanId
                                         qiangId:qiangId
                                      onChecking:onCheckingBlock
                                     shouldRoute:shouldRouteBlock
                                        didRoute:didRouteBlock
                                          source:source];
}

- (NSDictionary *)routefilter
{
    if (!__routeFilter) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SNRouter" ofType:@"plist"];
        __routeFilter = [NSDictionary dictionaryWithContentsOfFile:path];
        NSAssert([__routeFilter isKindOfClass:[NSDictionary class]], @"Error Reading `SNRouter.plist` file");
    }
    return __routeFilter;
}

- (void)_handleURL:(NSString *)url
        onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
       shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
          didRoute:(void (^)(SNRouterObject *))didRouteBlock
            source:(SNRouteSource)source
{
    //根据url生成对象
    SNRouterObject *obj = [[SNRouterObject alloc] initWithURLString:url source:source];
    obj.onCheckingBlock = [onCheckingBlock copy];
    obj.shouldRouteBlock = [shouldRouteBlock copy];
    obj.didRouteBlock = [didRouteBlock copy];
    [self routingObject:obj];
}


- (void)_handleURL:(NSString *)url
        onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
       shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
          didRoute:(void (^)(SNRouterObject *))didRouteBlock
            source:(SNRouteSource)source
     navController:(UINavigationController *)navCon {
    //根据url生成对象
    SNRouterObject *obj = [[SNRouterObject alloc] initWithURLString:url source:source];
    obj.onCheckingBlock = [onCheckingBlock copy];
    obj.shouldRouteBlock = [shouldRouteBlock copy];
    obj.didRouteBlock = [didRouteBlock copy];
    obj.navController = navCon;
    [self routingObject:obj];
}

- (void)_handleAdTypeCode:(NSString *)adTypeCode
                     adId:(NSString *)adId
                   chanId:(NSString *)chanId
                  qiangId:(NSString *)qiangId
               onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
              shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
                 didRoute:(void (^)(SNRouterObject *))didRouteBlock
                   source:(SNRouteSource)source

{
    SNRouterObject *obj = [[SNRouterObject alloc] initWithAdTypeCode:adTypeCode adId:adId chanId:chanId qiangId:qiangId source:source];
    obj.onCheckingBlock = [onCheckingBlock copy];
    obj.shouldRouteBlock = [shouldRouteBlock copy];
    obj.didRouteBlock = [didRouteBlock copy];
    [self routingObject:obj];
}

- (void)routingObject:(SNRouterObject *)obj
{
    [self _cancelCurrentTask];
    //检查obj是否合法
    NSString *adTypeCode = obj.adTypeCode;
    if (!adTypeCode.length) {
        //adTypeCode为空，默认是未识别
        obj.adTypeCode = kRouterUnrecognizedTypeCode;
    }
    
    //根据filter跳转对应的方法
    NSString *selectorString = [[self routefilter] objectForKey:obj.adTypeCode];
    
    obj.isReady = YES;
    if (selectorString.length)
    {
        SEL selector = NSSelectorFromString(selectorString);
        if ([self respondsToSelector:selector]) {
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL, SNRouterObject*) = (void *)imp;
            func(self, selector, obj);
        }else{
            //未实现该方法，默认是不做任何事情
            [self routeDoNothing:obj];
        }
    }
    else
    {
        //未找到，默认是未识别
        [self routeUnrecognized:obj];
    }
    
    [self finalJump:obj];
    DLog(@"SNRouter did route: %@", obj);
}

- (void)finalJump:(SNRouterObject *)obj
{
    if (!obj.isReady) {
        return;
    }
    
    BOOL shouldGo = obj.errorMsg.length?NO:YES; //根据error来判断是否跳转
    if (obj.shouldRouteBlock) {
        shouldGo &= obj.shouldRouteBlock(obj); //回调
    }
    
    if (shouldGo)
    {
        if (obj.doRouteBlock) {     //自定义block跳转法
            obj.doRouteBlock(obj);
        }else if (obj.targetController){    //跳转到targetController
            
            //记录页面的来源
            [obj.targetController setRouteSource:obj.source];
            
            if (obj.navController)
            {
                TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
                //case have a modalviewcontroller
                if ([tabBarVC presentedViewController])
                {
                    [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
                }
                
                //如果设定了跳转的navController
                [obj.navController pushViewController:obj.targetController animated:YES];
            }
            else
            {
                //如果是默认的跳转
                //跳转对应tab的根页面
                TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
                //case have a modalviewcontroller
                if ([tabBarVC presentedViewController])
                {
                    [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
                }
                [tabBarVC setSelectedIndex:obj.defaultTabIndex];
                UINavigationController *navController = [[tabBarVC viewControllers] safeObjectAtIndex:obj.defaultTabIndex];
                [navController popToRootViewControllerAnimated:NO];
                [navController pushViewController:obj.targetController animated:YES];
            }
        } else if ([obj.adTypeCode isEqualToString:kRouterDoNothingTypeCode]) {
            // do nothing
        }
        else{
            
            //跳转对应tab的根页面
            TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
            //case have a modalviewcontroller
            if ([tabBarVC presentedViewController])
            {
                [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
            }
            
            [tabBarVC setSelectedIndex:obj.defaultTabIndex];
            UINavigationController *navController = [[tabBarVC viewControllers] safeObjectAtIndex:obj.defaultTabIndex];
            [navController popToRootViewControllerAnimated:NO];
            
            //记录来源
            UIViewController *targetVC = [[navController viewControllers] safeObjectAtIndex:0];
            [targetVC setRouteSource:obj.source];
        }
    }
    
    if (obj.didRouteBlock) {
        obj.didRouteBlock(obj);
    }
}

#pragma mark - route method

//DGFQ, 彩票在Safari中支付完成回调
- (void)routeLotteryPaySuccess:(SNRouterObject *)obj
{
    __block NSString *urlString = obj.adId;
    
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        
        TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
        
        UINavigationController *ctrl = (UINavigationController*)[tabBarVC selectedViewController];
        
        UIViewController *visibleCtrl = [ctrl visibleViewController];
        
        if ([visibleCtrl  isKindOfClass:[SNWebViewController class]])
        {
            SNWebViewController *webController = (SNWebViewController*)visibleCtrl;
            
            webController.request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            
            [webController loadRequest];
        }
        
    };
}

//UnknownHttpUrl，普通的URL
- (void)routeUnknownHttpUrl:(SNRouterObject *)obj
{
    NSURL *url = [NSURL URLWithString:obj.originUrl];
    SNWebViewController *vc = [[SNWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//Unrecognized
- (void)routeUnrecognized:(SNRouterObject *)obj
{
    obj.errorMsg = L(@"SNRouteSwitch_CannotIndentfyLink");
}

//DoNothing
- (void)routeDoNothing:(SNRouterObject *)obj
{
    //do nothing
    if (!obj.adTypeCode.length) {
        obj.adTypeCode = kRouterDoNothingTypeCode;
    }
}

//ScanToLoginOrRegist, 扫码登录或注册
- (void)routeScanToLoginOrRegist:(SNRouterObject *)obj
{
    NSDictionary *paramDic = obj.allParams;
    NSString *uuid = paramDic[@"uuid"];
    NSString *actionTag = paramDic[@"actionTag"];
    if (uuid.length > 0 && ([actionTag isEqualToString:@"1"] || [actionTag isEqualToString:@"2"]) )
    {
        obj.doRouteBlock = ^(SNRouterObject *obj_) {
            
            if ([actionTag isEqualToString:@"1"]) { // 到登录界面
                if ([UserCenter defaultCenter].isLogined) {
                    // 直接到授权界面,在授权页面进行扫描信息验证
                    ScanerAuthoViewController *ctrler = [[ScanerAuthoViewController alloc]
                                                         initWithNibName:@"ScanerAuthoViewController" bundle:nil];
                    ctrler.authoUuid = uuid;
                    AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
                    [__gNavController0 presentViewController:navCtrler animated:YES
                                                  completion:nil];
                }else {
                    // 到登录界面
                    LoginViewController *ctrler = [[LoginViewController alloc] init];
                    ctrler.dismissViewControllerComplete = ^ {
                        // 登录成功 走已登录逻辑
                        ScanerAuthoViewController *ctrler = [[ScanerAuthoViewController alloc]
                                                             initWithNibName:@"ScanerAuthoViewController" bundle:nil];
                        ctrler.authoUuid = uuid;
                        AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
                        [__gNavController0 presentViewController:navCtrler animated:YES
                                                      completion:nil];
                    };
                    AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
                    [__gNavController0 presentViewController:navCtrler animated:NO
                                                  completion:nil];
                    
                }
            }else if ([actionTag isEqualToString:@"2"]) { // 到注册界面
                
                LoginViewController *ctrler = [[LoginViewController alloc] init];
                LoginViewController *__weak weakCtrler = ctrler;
                ctrler.dismissViewControllerComplete = ^ {
                    // 登录成功 走已登录逻辑
                    ScanerAuthoViewController *ctrler = [[ScanerAuthoViewController alloc]
                                                         initWithNibName:@"ScanerAuthoViewController" bundle:nil];
                    ctrler.authoUuid = uuid;
                    AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
                    [__gNavController0 presentViewController:navCtrler animated:YES
                                                  completion:nil];
                };
                AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
                [__gNavController0 presentViewController:navCtrler animated:NO
                                              completion:^{
                                                  [weakCtrler showRegisterViewController:1]; // 注册页面
                                              }];
            }
        };
        
    }
    else
    {
        //直接跳转逻辑
        [self routeUnknownHttpUrl:obj];
    }
}

//12
- (void)routeRushBuyListOrDetail:(SNRouterObject *)obj
{
    if (obj.adId.length)
    {
        //从adId中解析出productId和shopCode
        NSArray *partArr = [obj.adId componentsSeparatedByString:@"_"];
        NSString *productId = [partArr safeObjectAtIndex:0];
        NSString *shopCode = [partArr safeObjectAtIndex:1];
        if (!shopCode) {
            shopCode = @""; //默认自营
        }
        
        //抢购详情
        PanicPurchaseDTO *dto = [[PanicPurchaseDTO alloc] init];
        dto.rushPurId = obj.allParams[@"qiangId"];
        dto.catentryId = productId;
        dto.shopCode = shopCode;
        
        //商品详情
        DataProductBasic *product = [[DataProductBasic alloc] init];
        product.productId = productId;
        product.shopCode = shopCode;
        
        //使用定位城市
        NSString *cityCode = [Config currentConfig].gpsCityCode;
        if (!cityCode.length) {
            cityCode = [Config currentConfig].defaultCity;
        }
        product.cityCode = cityCode;
        
        [obj addParams:@{@"productId": productId?productId:@"",
                         @"shopCode": shopCode,
                         @"cityCode": cityCode?cityCode:@""}];
        
        
        ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
        productViewController.type = 2;
        productViewController.productType = FromPanicProduct;
        productViewController.panicDTO = dto;
        NSString *chanId = [obj.allParams objectForKey:@"chanId"];
        if ([chanId isEqualToString:@"1"]) {
            productViewController.panicChannel = PanicChannelB2C;
        }else if ([chanId isEqualToString:@"2"]){
            productViewController.panicChannel = PanicChannelMobile;
        }else if ([chanId isEqualToString:@"3"]){
            productViewController.panicChannel = PanicChannelReadBaby;
        }
        
        obj.targetController = productViewController;
        obj.defaultTabIndex = kHomeTabIndex;
    }
    else
    {
        //抢购列表
        [self routeRushBuyList:obj];
    }
}

//13, 1018
- (void)routeBangDanList:(SNRouterObject *)obj
{
    SNSpecialListViewController *vc = [[SNSpecialListViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//14, 1004
- (void)routeCategoryList:(SNRouterObject *)obj
{
    obj.defaultTabIndex = kCateTabIndex;
}

//15, 1007
- (void)routeLotteryHall:(SNRouterObject *)obj
{
    NSDictionary *dict = nil;
    
    if (obj.adId)
    {
        dict = @{@"url":obj.adId};
    }
    
    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCaiPiao attributes:dict];
    
    obj.targetController = vc;
    
    obj.defaultTabIndex = kHomeTabIndex;
}

//16
- (void)routeMobileCharge:(SNRouterObject *)obj
{
    PaymentCenterViewController *vc = [[PaymentCenterViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//17
- (void)routeHotsaleListOrProductDetail:(SNRouterObject *)obj
{
    if (obj.adId.length) {
        [self routeProductDetail:obj];
    }else{
        HotSaleViewController *vc = [[HotSaleViewController alloc] init];
        obj.targetController = vc;
        obj.defaultTabIndex = kHomeTabIndex;
    }
}

//18
- (void)routeDeliveryInstall:(SNRouterObject *)obj
{
    ServiceTrackListViewController *vc = [[ServiceTrackListViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//19
- (void)routeWaterElecGas:(SNRouterObject *)obj
{
    PaymentCenterViewController *vc = [[PaymentCenterViewController alloc] init];
    [vc setSegmentIndex:1];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//20, 1042
- (void)routeBrowsingHistory:(SNRouterObject *)obj
{
    BrowsingHistoryViewController *vc = [[BrowsingHistoryViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//21, 1010
- (void)routeMyFavorites:(SNRouterObject *)obj
{
    MyFavoriteViewController *vc = [[MyFavoriteViewController alloc] init];
    
    obj.targetController = vc;
    
    obj.defaultTabIndex = kMyEbuyTabIndex;
    
}

//23, 1022
- (void)routeSearch:(SNRouterObject *)obj
{
    obj.defaultTabIndex = kSearchTabIndex;
}

//24, 1024
- (void)routeShopCart:(SNRouterObject *)obj
{
    obj.defaultTabIndex = kShopCartTabIndex;
}

//25, 1025
- (void)routeMyEBuy:(SNRouterObject *)obj
{
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//26
- (void)routeProductDetail:(SNRouterObject *)obj
{
    //从adId中解析productId和shopCode:
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    NSString *productId = [partArray safeObjectAtIndex:0];
    NSString *shopCode = [partArray safeObjectAtIndex:1];
    
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    dto.productId = productId;
    dto.shopCode = shopCode;
    if (obj.source == SNRouteSourceScan)
    {
            NSDictionary *paramDic = [[obj.originUrl trim] queryDictionaryUsingEncoding:NSUTF8StringEncoding];
            NSString *adTypeCode = obj.adTypeCode;
            NSString *adId = obj.adId;
            NSString *store = EncodeStringFromDic(paramDic, @"store").trim;
            if (adTypeCode.length)
            {//二维码统计信息
                if ([SNSwitch isSuningBISDKOn])
                    {/*扫码统计：qrcode
                      1. 活动类型：adtype
                      2. 活动id：adid
                      3. 渠道id：channelid*/
                        NSString* stradTypeCode = [NSString stringWithFormat:@"null"];
                        if (adTypeCode)
                        {
                            stradTypeCode = [NSString stringWithFormat:@"%@",adTypeCode];
                        }
                        NSString* stradId = [NSString stringWithFormat:@"null"];
                        if (adId)
                        {
                            stradId = [NSString stringWithFormat:@"%@",adId];
                        }
                        NSString* strchanId = [NSString stringWithFormat:@"null"];
                        if (store)
                        {
                            strchanId = [NSString stringWithFormat:@"%@",store];
                        }
                        [SSAIOSSNDataCollection CustomEventCollection:@"qrcode" keyArray: [NSArray arrayWithObjects:@"adtype", @"adid", @"storeid", nil]valueArray: [NSArray arrayWithObjects:stradTypeCode, stradId, [store substringToIndex:4], nil]];
                        sourceTitle  = @"二维码";
                        erWeiMaDanPageTitle = [store substringToIndex:4];
                }
            }

    }
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//27
- (void)routeLocalLife:(SNRouterObject *)obj
{
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        [BBSideBarViewController goToLocalLife:@"" snProId:@""];
    };
}

//28
- (void)routeLocalLifeDetail:(SNRouterObject *)obj
{
    NSArray *array = [obj.adId componentsSeparatedByString:@","];
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        if ([array count] == 4) { //本地生活团购详情
            [Config currentConfig].gbDefaultCityId = [array objectAtIndex:2];
            [Config currentConfig].gbDefaultCityName = [array objectAtIndex:3];
            [BBSideBarViewController goToLocalLife:[array objectAtIndex:0] snProId:[array objectAtIndex:1]];
        }else{
            [BBSideBarViewController goToLocalLife:@"" snProId:@""];
        }
    };
}

//29, 1031
- (void)routeOrderAll:(SNRouterObject *)obj
{
    AllOrderListViewController *orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eProductOrderList];
    orderListVC.selectRow = 0;
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.bottomCell.backBtn.hidden = YES;
    obj.targetController = orderListVC;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//30，可详细定制搜索的内容
- (void)routeSearchResult:(SNRouterObject *)obj
{
    NSDictionary *paramDic = obj.allParams;
    NSString *keyword = paramDic[@"keyword"];
    NSString *cp = paramDic[@"cp"];
    NSString *ps = paramDic[@"ps"];
    NSString *st = paramDic[@"st"];
    NSString *set = paramDic[@"set"];
    NSString *cf = paramDic[@"cf"];
    NSString *iv = paramDic[@"iv"];
    NSString *ci = paramDic[@"ci"];
    
    SearchType type = keyword.length?SearchTypeKeyword:SearchTypeCategory_3;
    SearchParamDTO *param = [[SearchParamDTO alloc] initWithSearchType:type set:[set intValue]];
    param.sortType = [st intValue];
    if (keyword.length) param.keyword = keyword;
    if (cp.length) param.currentPage = cp;
    if (ps.length) param.pageSize = ps;
    if (cf.length) [param setCF:cf];
    if (iv.length) param.inventory = iv;
    if (ci.length) param.categoryId = ci;
    
    obj.targetController = [SearchListViewController searchPageWithParamDTO:param];
    obj.defaultTabIndex = kSearchTabIndex;
}

- (void)goToAdModel:(SNRouterObject *)obj
{
    NSDictionary *paramDic = obj.allParams;
    NSString *advertiseId = EncodeStringFromDic(paramDic, @"advertiseId");
    NSInteger model = EncodeStringFromDic(paramDic, @"model").integerValue;
    NSString *activeName = EncodeStringFromDic(paramDic, @"activeName");
    NSString *activeRule = EncodeStringFromDic(paramDic, @"activeRule");
    NSString *innerImage = EncodeStringFromDic(paramDic, @"innerImage");
    NSString *define = EncodeStringFromDic(paramDic, @"define");
    NSString *backgroundUrl = EncodeStringFromDic(paramDic, @"background");
    
    if (backgroundUrl.length)
    {
        NSString *url = backgroundUrl.trim;
        if (url.length)
        {
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": url, @"activeName": activeName?activeName:@""}];
            obj.targetController = vc;
        }
    }
    else
    {
        switch (model) {
            case kModel1:
            {
                NSString *url = innerImage.trim;
                if (url.length)
                {
                    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": url, @"activeName": activeName?activeName:@""}];
                    obj.targetController = vc;
                }
            }
            case kModel2:
            {
                AdModel2ViewController *vc = [[AdModel2ViewController alloc] initWithAdvertiseId:advertiseId];
                vc.activeName = activeName;
                vc.activeRule = activeRule;
                vc.activeInnerImageUrl = innerImage;
                obj.targetController = vc;
                break;
            }
            case kModel3:
            {
                AdModel3ViewController *vc = [[AdModel3ViewController alloc] initWithAdvertiseId:advertiseId];
                vc.activeName = activeName;
                vc.activeRule = activeRule;
                vc.activeInnerImageUrl = innerImage;
                obj.targetController = vc;
                break;
            }
            case kModel4:
            {
                AdModel4ViewController *vc = [[AdModel4ViewController alloc] initWithAdvertiseId:advertiseId];
                vc.activeName = activeName;
                vc.activeRule = activeRule;
                vc.activeInnerImageUrl = innerImage;
                obj.targetController = vc;
                break;
            }
            case kModel5:
            {
                AdModel5ViewController *vc = [[AdModel5ViewController alloc] initWithAdvertiseId:advertiseId];
                vc.activeName = activeName;
                vc.define = define;
                obj.targetController = vc;
                break;
            }
            case kModel6:
            {
                AdModel6ViewController *vc = [[AdModel6ViewController alloc] initWithAdvertiseId:advertiseId];
                vc.activeName = activeName;
                vc.activeRule = activeRule;
                vc.activeInnerImageUrl = innerImage;
                obj.targetController = vc;
                break;
            }
            default:
                break;
        }
    }
    
    obj.defaultTabIndex = kHomeTabIndex;
    
    if (!obj.targetController && !obj.errorMsg.length) {
        obj.errorMsg = kSNRouterAdNotFoundDefaultError;
    }
    
    if (!obj.isReady) {
        obj.isReady = YES;
        [self finalJump:obj];
    }
}

//101, 102, 103, 104, 105, 106, 1003
- (void)routeEightBanner:(SNRouterObject *)obj
{
    if (!obj.adId.length) {
        obj.errorMsg = kSNRouterAdNotFoundDefaultError;
        return;
    }
    //如果是从二维码扫描过来的，只能进入二维码频道的活动
    if (obj.source == SNRouteSourceScan)
    {
        //拉取二维码频道的所有广告列表
        if (obj.onCheckingBlock) {
            obj.onCheckingBlock(obj);
        }
        
        obj.isReady = NO;
        EightBannerADService *service = [[EightBannerADService alloc] init];
        service.appType = BannerAppTypeQRCode;
        service.context = obj;
        service.delegate = self;
        self.service = service;
        [service requestBannerListWithAdType:eHomeEightBannerType];
    }
    else        //全部都可以进入
    {
        NSString *adId = obj.adId;
        //先直接从缓存中取,取到就直接回调
        NSArray *cachedList = [Config currentConfig].advInfoList;
        cachedList = [cachedList arrayByAddingObjectsFromArray:[Config currentConfig].topAdList];
        if ([cachedList count] > 0) {
            for (HomeTopScrollAdDTO *dto in cachedList)
            {
                if ([dto respondsToSelector:@selector(advertiseId)] && [dto.advertiseId eq:adId])
                {
                    NSDictionary *paramDic =
                    @{
                      @"advertiseId" : dto.advertiseId?dto.advertiseId:@"",
                      @"model" : dto.model?dto.model:@"",
                      @"activeName" : dto.activeName?dto.activeName:@"",
                      @"innerImage" : dto.innerImageURL?dto.innerImageURL:@"",
                      @"activeRule" : dto.activeRule?dto.activeRule:@"",
                      @"define" : dto.define?dto.define:@"",
                      @"background" : dto.backgroundURL?dto.backgroundURL:@""
                      };
                    
                    [obj addParams:paramDic];
                    [self goToAdModel:obj];
                    return;
                }
            }
        }
        
        if (obj.onCheckingBlock) {
            obj.onCheckingBlock(obj);
        }
        
        obj.isReady = NO;
        AdModelService *service = [[AdModelService alloc] init];
        service.context = obj;
        service.delegate = self;
        self.service = service;
        [service requestModelListWithAdId:adId];
    }
}

- (void)service:(EightBannerADService *)service requestEightBannerComplete:(BOOL)isSuccess
{
    SNRouterObject *obj = [self.service context];
    if (isSuccess)
    {
        NSArray *adList = service.allAdList;
        BOOL isFinded = NO;
        for (HomeTopScrollAdDTO *dto in adList)
        {
            if ([dto.advertiseId isEqualToString:obj.adId])
            {
                isFinded = YES;
                NSDictionary *paramDic = @{
                                           @"advertiseId" : dto.advertiseId?dto.advertiseId:@"",
                                           @"model" : dto.model?dto.model:@"",
                                           @"activeName" : dto.activeName?dto.activeName:@"",
                                           @"innerImage" : dto.innerImageURL?dto.innerImageURL:@"",
                                           @"activeRule" : dto.activeRule?dto.activeRule:@"",
                                           @"define" : dto.define?dto.define:@"",
                                           @"background" : dto.backgroundURL?dto.backgroundURL:@""
                                           };
                [obj addParams:paramDic];
            }
        }
        
        if (!isFinded) {
            obj.errorMsg = kSNRouterAdNotFoundDefaultError;
        }
    }
    else
    {
        obj.errorMsg = service.errorMsg;
    }
    [self goToAdModel:obj];
}

- (void)service:(AdModelService *)service getAdModelListComplete:(BOOL)isSuccess
{
    SNRouterObject *obj = [self.service context];
    HomeTopScrollAdDTO *dto = service.dto;
    if (isSuccess && (dto.backgroundURL.length || dto.advertiseId.length))
    {
        NSDictionary *paramDic = @{
                                   @"advertiseId" : dto.advertiseId?dto.advertiseId:@"",
                                   @"model" : dto.model?dto.model:@"",
                                   @"activeName" : dto.activeName?dto.activeName:@"",
                                   @"innerImage" : dto.innerImageURL?dto.innerImageURL:@"",
                                   @"activeRule" : dto.activeRule?dto.activeRule:@"",
                                   @"define" : dto.define?dto.define:@"",
                                   @"background" : dto.backgroundURL?dto.backgroundURL:@""
                                   };
        [obj addParams:paramDic];
    }
    else
    {
        obj.errorMsg = service.errorMsg;
    }
    
    self.service = nil;
    [self goToAdModel:obj];
}

- (void)goToSpecialSubject:(SNRouterObject *)obj
{
    SNSpecialSubjectDTO *dto = [obj.allParams objectForKey:@"specialDto"];
    
    if (dto) {
        SNSpecialSubjectViewController *vc = [[SNSpecialSubjectViewController alloc] init];
        vc.specialSubjectDto = dto;
        obj.targetController = vc;
        obj.defaultTabIndex = kHomeTabIndex;
    }else{
        if (!obj.errorMsg) {
            obj.errorMsg = kSNRouterAdNotFoundDefaultError;
        }
    }
    
    if (!obj.isReady) {
        obj.isReady = YES;
        [self finalJump:obj];
    }
}

//200, 1020
- (void)routeActivitySubjectPage:(SNRouterObject *)obj
{
    //先直接从缓存中取,取到就直接回调
    NSString *adId = obj.adId;
    NSArray *cachedList = [Config currentConfig].specialSubjectList;
    if ([cachedList count] > 0)
    {
        for (SNSpecialSubjectDTO *specialDto in cachedList)
        {
            if ([specialDto respondsToSelector:@selector(areaId)]&&[specialDto.areaId eq:adId])
            {
                [obj setParam:specialDto forKey:@"specialDto"];
                [self goToSpecialSubject:obj];
                return;
            }
        }
    }
    
    //缓存中没有，调用接口查询
    if (obj.onCheckingBlock) {
        obj.onCheckingBlock(obj);
    }
    
    obj.isReady = NO;
    SpecialSubjectService *service = [[SpecialSubjectService alloc] init];
    service.context = obj;
    service.delegate = self;
    self.service = service;
    [service beginGetSpecialSubjectsRequest:@"10" withPomAreaId:adId];
}

//新1019,1020
- (void)routeNewCuXiaoPage:(SNRouterObject *)obj
{
    if ([obj.adTypeCode isEqualToString:@"1019"])
    {
        PruductList244ViewController *controller = [[PruductList244ViewController alloc] init];
        
        controller.targetModuleID = obj.adId;
        
        controller.whereFrom = obj.source;
        
        obj.targetController = controller;
        
        obj.defaultTabIndex = kHomeTabIndex;
        
    }else{
        SalePromotionViewController *ctrler = [[SalePromotionViewController alloc] init];
        
        ctrler.targetModuleID = obj.adId;
        
        ctrler.whereFrom = obj.source;
        
        obj.targetController = ctrler;
        
        obj.defaultTabIndex = kHomeTabIndex;
    }
}



- (void)getSpecialSubjectsCompletionWithResult:(BOOL)isSuccess
                                      errorMsg:(NSString *)errorMsg
                                   subjectList:(NSArray *)list
{
    SNRouterObject *obj = [self.service context];
    if (isSuccess && [list count])
    {
        SNSpecialSubjectDTO *specialDto = [list objectAtIndex:0];
        NSMutableDictionary *allParams = [obj.allParams mutableCopy];
        [allParams setObject:specialDto forKey:@"specialDto"];
        obj.allParams = [allParams copy];
    }
    else
    {
        obj.errorMsg = errorMsg;
    }
    
    self.service = nil;
    [self goToSpecialSubject:obj];
}

- (void)goToActivityView:(SNRouterObject *)obj
{
    NSDictionary *paramDic = obj.allParams;
    NSString *actName = [paramDic objectForKey:@"actName"];
    NSString *activityId = [paramDic objectForKey:@"activityId"];
    NSString *sortType = [paramDic objectForKey:@"sortType"];
    if ([activityId length])
    {
        SNActivityViewController *vc = [[SNActivityViewController alloc] initWithActName:actName areaName:nil];
        vc.activityId = activityId;
        vc.prdSortType = sortType;
        obj.targetController = vc;
        obj.defaultTabIndex = kHomeTabIndex;
    }
    else
    {
        if (!obj.errorMsg) {
            obj.errorMsg = kSNRouterAdNotFoundDefaultError;
        }
    }
    
    if (!obj.isReady) {
        obj.isReady = YES;
        [self finalJump:obj];
    }
}

//201, 202, 203, 1019
- (void)routeActivityProductList:(SNRouterObject *)obj
{
    //先直接从缓存中取,取到就直接回调
    NSString *adId = obj.adId;
    NSMutableArray *cachedList = [NSMutableArray array];
    for (SNSpecialSubjectDTO *specialDto in [Config currentConfig].specialSubjectList)
    {
        [cachedList addObjectsFromArray:specialDto.actList];
    }
    [cachedList addObjectsFromArray:[Config currentConfig].actList];
    for (SNActivityDTO *dto in cachedList)
    {
        if ([dto respondsToSelector:@selector(activityId)] && [dto.activityId eq:adId])
        {
            NSDictionary *paramDic =
            @{@"actName": dto.actName?dto.actName:@"",
              @"activityId":dto.activityId?dto.activityId:@"",
              @"sortType":dto.prdSortType?dto.prdSortType:@""
              };
            
            [obj addParams:paramDic];
            [self goToActivityView:obj];
            return;
        }
    }
    
    //调用接口查询
    if (obj.onCheckingBlock) {
        obj.onCheckingBlock(obj);
    }
    
    obj.isReady = NO;
    SNActivityService *service = [[SNActivityService alloc] init];
    service.delegate = self;
    service.context = obj;
    self.service = service;
    [service beginGetActivityProdcuctDetailList:adId currentPage:1];
}

- (void)getActivityProductListCompletionWithResult:(BOOL)isSuccess
                                          errorMsg:(NSString *)errorMsg
                                  SNActivityDetail:(SNActivityDTO *)dto
                            SNActivityProductArray:(NSArray *)array
                                           pageNum:(NSInteger)pageNum
                                         pageCount:(NSInteger)pageCount
                                           actRule:(NSString *)actRule
{
    SNRouterObject *obj = [self.service context];
    
    if (isSuccess && [array count] !=0)
    {
        NSDictionary *paramDic =
        @{@"actName": dto.actName?dto.actName:@"",
          @"activityId":dto.activityId?dto.activityId:@"",
          @"sortType":dto.prdSortType?dto.prdSortType:@""};
        
        [obj addParams:paramDic];
    }
    else
    {
        obj.errorMsg = errorMsg;
    }
    
    self.service = nil;
    [self goToActivityView:obj];
}

//204
- (void)routePlayVoice:(SNRouterObject *)obj
{
    PlayVoiceViewController *playvoice = [[PlayVoiceViewController alloc] init];
    obj.targetController = playvoice;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1000, 1016
- (void)routeYunXinPay:(SNRouterObject *)obj
{
#warning TODO
}

//1001
- (void)routeHome:(SNRouterObject *)obj
{
    obj.defaultTabIndex = kHomeTabIndex;
}

//1002
- (void)routeWebView:(SNRouterObject *)obj
{
    NSURL *url = [NSURL URLWithString:obj.adId];
    if (url.absoluteString)
    {
        SNWebViewController *vc = [[SNWebViewController alloc] initWithRequestUrl:obj.adId];
        obj.targetController = vc;
        obj.defaultTabIndex = kHomeTabIndex;
    }
    else
    {
        obj.errorMsg = L(@"SNRouteSwitch_CannotIndentfyLink");
    }
}

//1005
- (void)routeCategoryResultList:(SNRouterObject *)obj
{
    //从adId中解析ci和cf:
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    NSString *ci = [partArray safeObjectAtIndex:0];
    NSString *cf = nil;
    if (partArray.count == 2) {
        cf = [partArray objectAtIndex:1];
    }else if (partArray.count > 2) {
        cf = [[partArray subarrayWithRange:NSMakeRange(1, [partArray count]-1)] componentsJoinedByString:@"_"];
    }
    
    if (ci.length || cf.length) {
        [obj addParams:@{@"ci": ci?ci:@"",
                         @"cf": cf?cf:@""}];
        
        SearchParamDTO *dto = [[SearchParamDTO alloc] initWithSearchType:SearchTypeCategory_3 set:SearchSetMix];
        dto.categoryId = ci;
        if (cf.length) [dto setCF:cf];
        UIViewController *vc = [SearchListViewController searchPageWithParamDTO:dto];
        obj.targetController = vc;
        obj.defaultTabIndex = kCateTabIndex;
    } else {
        obj.errorMsg = L(@"SNRouteSwitch_CannotFindThisCategory");
    }
}

//1006
- (void)routeCharge:(SNRouterObject *)obj
{
    PaymentCenterViewController *vc = [[PaymentCenterViewController alloc] init];
    
    if ([obj.adId isEqualToString:@"A001"]) { //手机充值
        [vc setSegmentIndex:0];
    } else if ([obj.adId isEqualToString:@"B001"]) { //水费
        [vc setSegmentIndex:1];
        vc.WEGPaymentView.payType = payWater;
    } else if ([obj.adId isEqualToString:@"B002"]) { //电费
        [vc setSegmentIndex:1];
        vc.WEGPaymentView.payType = payElectricity;
    } else if ([obj.adId isEqualToString:@"B003"]) { //煤气费
        [vc setSegmentIndex:1];
        vc.WEGPaymentView.payType = payGas;
    } else if ([obj.adId isEqualToString:@"C001"]) { //易付宝充值
        [vc setSegmentIndex:2];
    } else {
        [vc setSegmentIndex:0];
    }
    
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1008
- (void)routeMessageCenter:(SNRouterObject *)obj
{
    SNInformationViewController *vc = [[SNInformationViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1009
- (void)routeLogisticsQuery:(SNRouterObject *)obj
{
    ServiceTrackListViewController *vc = [[ServiceTrackListViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1011
- (void)routeNearBySuning:(SNRouterObject *)obj
{
    NearbySuningMainViewController *VC = [[NearbySuningMainViewController alloc]init];
    obj.targetController = VC;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1012
- (void)routeCStoreHome:(SNRouterObject *)obj
{
    if (obj.adId.length)
    {
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^\\d{3,18}$" options:0 error:NULL];
        if ([expression matchesInString:obj.adId options:NSMatchingCompleted range:NSMakeRange(0, obj.adId.length)])
        {
            NSString *shopCodeStr = obj.adId;
            if (shopCodeStr.length != 10) {
                shopCodeStr = [NSString stringWithFormat:@"00%@",shopCodeStr];
            }
            //added by gyj 251店铺地址更换,店铺ID 10位/8位无所谓，web端做了兼容
            NSString *url = [NSString stringWithFormat:@"%@/%@.html?client=app",kMHostAddressForHttp,shopCodeStr?shopCodeStr:@""];
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCShop attributes:@{@"url": url, @"shopId": obj.adId?obj.adId:@"",@"SNRouteSourceScan":obj.source == SNRouteSourceScan?@"1":@"0"}];
            obj.targetController = vc;
            obj.defaultTabIndex = kHomeTabIndex;
            
            if (obj.source == SNRouteSourceScan)
            {
                NSDictionary *paramDic = [[obj.originUrl trim] queryDictionaryUsingEncoding:NSUTF8StringEncoding];
                NSString *adTypeCode = obj.adTypeCode;
                NSString *adId = obj.adId;
                NSString *store = EncodeStringFromDic(paramDic, @"store").trim;
                if (adTypeCode.length)
                {//二维码统计信息
                    if ([SNSwitch isSuningBISDKOn])
                    {/*扫码统计：qrcode
                      1. 活动类型：adtype
                      2. 活动id：adid
                      3. 渠道id：channelid*/
                        NSString* stradTypeCode = [NSString stringWithFormat:@"null"];
                        if (adTypeCode)
                        {
                            stradTypeCode = [NSString stringWithFormat:@"%@",adTypeCode];
                        }
                        NSString* stradId = [NSString stringWithFormat:@"null"];
                        if (adId)
                        {
                            stradId = [NSString stringWithFormat:@"%@",adId];
                        }
                        NSString* strchanId = [NSString stringWithFormat:@"null"];
                        if (store)
                        {
                            strchanId = [NSString stringWithFormat:@"%@",store];
                        }
                        [SSAIOSSNDataCollection CustomEventCollection:@"qrcode" keyArray: [NSArray arrayWithObjects:@"adtype", @"adid", @"storeid ", nil]valueArray: [NSArray arrayWithObjects:stradTypeCode, stradId, [store substringToIndex:4], nil]];
                        sourceTitle  = L(@"SNRouteSwitch_QRCode");
                        erWeiMaPageTitle = [store substringToIndex:4];
                    }
                }
                
            }
        }
        else
        {
            obj.errorMsg = L(@"SNRouteSwitch_StoreVisitedNotExist");
        }
    }
    else
    {
        obj.errorMsg = L(@"SNRouteSwitch_StoreVisitedNotExist");
    }
}

//1013
- (void)routeProductDetail2:(SNRouterObject *)obj
{
    //从adId中解析productId和shopCode:
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    NSString *productCode = [partArray safeObjectAtIndex:0];
    NSString *shopCode = [partArray safeObjectAtIndex:1];
    
    NSString *bigJuHuiAdId = [partArray safeObjectAtIndex:2];
    NSString *bigJuHuiChanId = [partArray safeObjectAtIndex:3];
    
    [obj addParams:@{@"productCode": productCode?productCode:@"",
                     @"shopCode": shopCode?shopCode:@"",
                     @"bigJuHuiAdId": bigJuHuiAdId?bigJuHuiAdId:@"",
                     @"bigJuHuiChanId": bigJuHuiChanId?bigJuHuiChanId:@""}];
    
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    dto.productCode = productCode;
    dto.shopCode = shopCode;
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1014
- (void)routeRushBuyList:(SNRouterObject *)obj
{
    PurchaseProductListViewController *vc = [[PurchaseProductListViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1015
- (void)routeRushBuyDetail:(SNRouterObject *)obj
{
    //从adId中解析出参数
    NSString *productCode = nil;
    NSString *qiangId = nil;
    NSString *chanId = nil;
    NSString *shopCode = nil;
    
    NSArray *partArr = [obj.adId componentsSeparatedByString:@"_"];
    if ([partArr count] == 3) {
        
        productCode = [partArr safeObjectAtIndex:0];
        qiangId = [partArr safeObjectAtIndex:1];
        chanId = [partArr safeObjectAtIndex:2];
        shopCode = @"";
        
    }else if ([partArr count] == 4){
        
        productCode = [partArr safeObjectAtIndex:0];
        shopCode = [partArr safeObjectAtIndex:1];
        qiangId = [partArr safeObjectAtIndex:2];
        chanId = [partArr safeObjectAtIndex:3];
        
    }else{
        [self routeUnrecognized:obj];
        return;
    }
    
    //使用定位城市
    NSString *cityCode = [Config currentConfig].gpsCityCode;
    if (!cityCode.length) {
        cityCode = [Config currentConfig].defaultCity;
    }
    
    [obj addParams:@{@"productCode": productCode?productCode:@"",
                     @"shopCode": shopCode?shopCode:@"",
                     @"qiangId": qiangId?qiangId:@"",
                     @"chanId": chanId?chanId:@"",
                     @"cityCode": cityCode?cityCode:@""}];
    
    //抢购详情
    PanicPurchaseDTO *dto = [[PanicPurchaseDTO alloc] init];
    dto.rushPurId = obj.allParams[@"qiangId"];
    dto.partNumber = productCode;
    dto.shopCode = shopCode;
    
    //商品详情
    DataProductBasic *product = [[DataProductBasic alloc] init];
    product.productCode = productCode;
    product.shopCode = shopCode;
    
    ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
    productViewController.type = 2;
    productViewController.productType = FromPanicProduct;
    productViewController.panicDTO = dto;
    if ([chanId isEqualToString:@"1"]) {
        productViewController.panicChannel = PanicChannelB2C;
    }else if ([chanId isEqualToString:@"2"]){
        productViewController.panicChannel = PanicChannelMobile;
    }else if ([chanId isEqualToString:@"3"]){
        productViewController.panicChannel = PanicChannelReadBaby;
    }
    
    obj.targetController = productViewController;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1021
- (void)routeCheckIn:(SNRouterObject *)obj
{
    CheckInViewController *vc = [[CheckInViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1023 关键词搜索
- (void)routeSearchResult2:(SNRouterObject *)obj
{
    NSString *keyword = obj.adId;
    SearchParamDTO *param = [[SearchParamDTO alloc] initWithSearchType:SearchTypeKeyword
                                                                   set:SearchSetMix];
    param.keyword = keyword;
    
    obj.targetController = [SearchListViewController searchPageWithParamDTO:param];
    obj.defaultTabIndex = kSearchTabIndex;
}

//1026
- (void)routeMyEpp:(SNRouterObject *)obj
{
    //因激活易付宝逻辑较为复杂，不做询问，直接跳转
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        [self jumpToActivityEfubao];
    };
}

//1027
- (void)routeMyIntegal:(SNRouterObject *)obj
{
    MyIntegralExchangeViewController *vc = [[MyIntegralExchangeViewController alloc] init];
    obj.targetController = vc;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1028
- (void)routeMyCoupon:(SNRouterObject *)obj
{
    MyCouponViewController *egq = [[MyCouponViewController alloc] initWithTotalAmount:[UserCenter defaultCenter].userDiscountInfoDTO.coupon];
    obj.targetController = egq;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1029
- (void)routeMyEGiftCard:(SNRouterObject *)obj
{
    MyCouponViewController *egq = [[MyCouponViewController alloc] initWithTotalAmount:[UserCenter defaultCenter].userDiscountInfoDTO.coupon];
    egq.segment.currentIndex = 1;
    obj.targetController = egq;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1030
- (void)routeMyMemberCard:(SNRouterObject *)obj
{
    MyCardViewController *mycard = [[MyCardViewController alloc] init];
    obj.targetController = mycard;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1032
- (void)routeOrderToBePaid:(SNRouterObject *)obj
{
    AllOrderListViewController *orderListVC = [[AllOrderListViewController alloc]init];
    orderListVC.selectRow = 0;
    orderListVC.orderStatus = @"M";
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.hasNav = YES;
    orderListVC.bottomCell.backBtn.hidden = NO;
    orderListVC.title = L(@"SNRouteSwitch_WaitingForPay");
    orderListVC.arrowImg.hidden = YES;
    orderListVC.hasSuspendButton = NO;
    obj.targetController = orderListVC;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1033
- (void)routeOrderDetail:(SNRouterObject *)obj
{
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    NSString *orderId = [partArray safeObjectAtIndex:0];
    NSString *shopCode = [partArray safeObjectAtIndex:1];
    NSString *orderStatus = [partArray safeObjectAtIndex:2];
    
    if ([shopCode isEqualToString:@"0000000000"])
    {
        shopCode = nil;
    }
    
    [obj addParams:@{@"orderId": orderId?orderId:@"",
                     @"shopCode": shopCode?shopCode:@"",
                     @"orderStatus": orderStatus?orderStatus:@"",}];
    
    MemberOrderNamesDTO *memberDto = [[MemberOrderNamesDTO alloc] init];
    memberDto.orderId = orderId;
    memberDto.supplierCode = shopCode;
    
    OrderDetailViewController  *orderDetailVC = [[OrderDetailViewController alloc]initWithDTO:memberDto];
    orderDetailVC.orderSt = orderStatus;
    
    
    orderDetailVC.supplierCode = shopCode;
    orderDetailVC.isCShopProduct = shopCode.length?YES:NO;
    orderDetailVC.hasNav = YES;
    orderDetailVC.hidesBottomBarWhenPushed = YES;
    
    obj.targetController = orderDetailVC;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1034
- (void)routeOrderUponReceipt:(SNRouterObject *)obj
{
    AllOrderListViewController *orderListVC = [[AllOrderListViewController alloc]initWithData:@"C000" WithSelect:eProductOrderList];
    
    orderListVC.selectRow = 0;
    orderListVC.orderStatus = @"C000";//@"C000";
    
    orderListVC.hidesBottomBarWhenPushed = YES;
    orderListVC.hasNav = YES;
    orderListVC.bottomCell.backBtn.hidden = NO;
    orderListVC.title = L(@"SNRouteSwitch_WaitingForReceive");
    orderListVC.arrowImg.hidden = YES;
    orderListVC.hasSuspendButton = NO;
    
    obj.targetController = orderListVC;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1035 物流详情
- (void)routeOrderLogisticsDetail:(SNRouterObject *)obj
{
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"*"];
    
    NSString *omsOrderItemId = [partArray safeObjectAtIndex:0];                //oms订单项id
    NSString *omsOrderId = [partArray safeObjectAtIndex:1];                    //oms订单id
    NSString *orderItemId = [partArray safeObjectAtIndex:2];                   //订单项id
    NSString *orderId = [partArray safeObjectAtIndex:3];                       //订单id
    NSString *sapOrderNo = [partArray safeObjectAtIndex:4];                    //sap订单号
    NSString *productCode = [partArray safeObjectAtIndex:5];                   //商品编码
    NSString *productName = [partArray safeObjectAtIndex:6];                   //商品名称
    NSString *supplierCode = [partArray safeObjectAtIndex:7];                  //供应商编码
    
    if ([supplierCode length] == 8)
    {
        supplierCode = [@"00" stringByAppendingString:supplierCode];
    }
    
    if ([supplierCode isEqualToString:@"0000000000"])
    {
        supplierCode = nil;
    }
    
    [obj addParams:@{@"productCode": productCode?productCode:@"",
                     @"productName": productName?productName:@"",
                     @"supplierCode": supplierCode?supplierCode:@"",
                     @"orderId": orderId?orderId:@"",
                     @"orderItemId": orderItemId?orderItemId:@"",
                     @"omsOrderId": omsOrderId?omsOrderId:@"",
                     @"omsOrderItemId": omsOrderItemId?omsOrderItemId:@"",
                     @"sapOrderNo": sapOrderNo?sapOrderNo:@""}];
    
    ProductListDTO *orderProductListDTO = [[ProductListDTO alloc] init];
    orderProductListDTO.orderID = orderId;
    orderProductListDTO.orderItemId = orderItemId;
    orderProductListDTO.productCode = productCode;
    orderProductListDTO.productName = productName;
    orderProductListDTO.supplierCode = supplierCode;
    
    if (supplierCode.length) //C店订单
    {
        NewOrderSnxpressViewController *ctrl = [[NewOrderSnxpressViewController alloc] initWithStatus:eCShopDeliveryNew];
        ctrl.orderId = orderId;
        ctrl.orderItemId = orderItemId;
        ctrl.cShopCode = supplierCode;
        
        ctrl.hasNav = YES;
        ctrl.hidesBottomBarWhenPushed = YES;
        ctrl.isOrderDetailLogisticsQuery = NO;
        obj.targetController = ctrl;
        
    } else if (orderId.length) {  //通过订单号查询
        
        ServiceDetailViewController *detailController = [[ServiceDetailViewController alloc] initWithStatus:eOrderCenterDelivery];
        detailController.orderId = orderId;
        detailController.orderItemId = orderItemId;
        detailController.orderProductListDTO = orderProductListDTO;
        obj.targetController = detailController;
    } else if (omsOrderId.length) {  //通过oms订单号查询
        
        ServiceDetailViewController *detailController = [[ServiceDetailViewController alloc] initWithStatus:eShopOrderDelivery];
        detailController.orderId = omsOrderId;
        detailController.orderItemId = omsOrderItemId;
        detailController.orderProductListDTO = orderProductListDTO;
        obj.targetController = detailController;
    } else if (sapOrderNo.length) {  //通过销售单号查询
        
        ServiceDetailViewController *detailController = [[ServiceDetailViewController alloc] initWithStatus:eHomeDelivery];
        detailController.salNum = sapOrderNo;
        detailController.orderProductListDTO = orderProductListDTO;
        obj.targetController = detailController;
    }
    
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1036
- (void)routeOrderToBeAppraise:(SNRouterObject *)obj
{
    EvaluationViewController *orderCenterVC = [[EvaluationViewController alloc] init];
    orderCenterVC.hasNav = YES;
    orderCenterVC.hidesBottomBarWhenPushed = YES;
    orderCenterVC.bottomCell.backBtn.hidden = NO;
    obj.targetController = orderCenterVC;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1037 我要晒单
- (void)routeIWantShowOrder:(SNRouterObject *)obj
{
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    NSString *productCode = [partArray safeObjectAtIndex:0];
    NSString *orderId = [partArray safeObjectAtIndex:1];
    NSString *orderItemId = [partArray safeObjectAtIndex:2];
    NSString *orderTime = [partArray safeObjectAtIndex:3];
    NSString *productName = [partArray safeObjectAtIndex:4];
    NSString *productId = [partArray safeObjectAtIndex:5];
    NSString *shopName = [partArray safeObjectAtIndex:6];
    
    [obj addParams:@{@"productCode": productCode?productCode:@"",
                     @"orderId": orderId?orderId:@"",
                     @"orderItemId": orderItemId?orderItemId:@"",
                     @"orderTime": orderTime?orderTime:@"",
                     @"productName": productName?productName:@"",
                     @"productId": productId?productId:@"",
                     @"shopName": shopName?shopName:@"",}];
    
    MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
    dto.orderId = orderId;
    dto.orderItemId = orderItemId;
    dto.productId = productId;
    dto.productCode = productCode;
    dto.productName = productName;
    dto.cShopName = shopName;

    ProductDisOrderSubmitViewController *productSubmitViewController = (ProductDisOrderSubmitViewController *)[[ProductDisOrderSubmitViewController alloc] initWithDTO:dto isMember:YES];
    
    obj.targetController = productSubmitViewController;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1038 我要评价
- (void)routeIWantAppraise:(SNRouterObject *)obj
{
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    NSString *productCode = [partArray safeObjectAtIndex:0];
    NSString *orderId = [partArray safeObjectAtIndex:1];
    NSString *orderItemId = [partArray safeObjectAtIndex:2];
    NSString *orderTime = [partArray safeObjectAtIndex:3];
    NSString *productName = [partArray safeObjectAtIndex:4];
    NSString *shopName = [partArray safeObjectAtIndex:5];
    
    [obj addParams:@{@"productCode": productCode?productCode:@"",
                     @"orderId": orderId?orderId:@"",
                     @"orderItemId": orderItemId?orderItemId:@"",
                     @"orderTime": orderTime?orderTime:@"",
                     @"productName": productName?productName:@"",
                     @"shopName": shopName?shopName:@"",}];
    
    EvalutionDetailDTO *evaDetailDto = [[EvalutionDetailDTO alloc] init];
    evaDetailDto.partNumber = productCode;
    evaDetailDto.orderItemId = orderItemId;
    evaDetailDto.supplierName = shopName;
    evaDetailDto.catentryName = productName;
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
    {
        evaDetailDto.productUrl = [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize160x160];
    }
    else
    {
        evaDetailDto.productUrl = [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize100x100];
    }
    
    EvalutionContentViewController *next = [[EvalutionContentViewController alloc] init];
    next.evalutionDto = evaDetailDto;
    next.evalDto.orderId = orderId;
    next.hasNav = YES;
    next.hidesBottomBarWhenPushed = YES;
    obj.targetController = next;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1039
- (void)routeOrderInReturning:(SNRouterObject *)obj
{
    ReturnGoodsQueryViewController *vc = [[ReturnGoodsQueryViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    obj.targetController = vc;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1040
- (void)routeCPACPS:(SNRouterObject *)obj
{
    NewInviteFriendViewController *vc = [[NewInviteFriendViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    obj.targetController = vc;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1041
- (void)routeCPACPSReward:(SNRouterObject *)obj
{
    NewGetRedPackEntryViewController *vc  = [[NewGetRedPackEntryViewController alloc] init];
    //    vc.activeurl =invitaDto.actRuleURL;
    //    vc.activetitle = invitaDto.actTitle;
    //    vc.activerule =invitaDto.actContent;
    obj.targetController = vc;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1043
- (void)routeAddressManager:(SNRouterObject *)obj
{
    AddressInfoListViewController *vc = [AddressInfoListViewController controller];
    vc.cellType = FromEbuy;
    obj.targetController = vc;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1044
- (void)routeUserFeedback:(SNRouterObject *)obj
{
    UserFeedBackNewViewController *vc = [UserFeedBackNewViewController controller];
    obj.targetController = vc;
    obj.defaultTabIndex = kMyEbuyTabIndex;
}

//1045
- (void)routeDownloadUpgrade:(SNRouterObject *)obj
{
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        CheckUpdateCommand *command = [[CheckUpdateCommand alloc] initWithCheckUpdateMode:ManualCleck];
        [CommandManage excuteCommand:command completeBlock:NULL];
    };
}

//1046
- (void)routeYaoYiYaoFromPromotion:(SNRouterObject *)obj
{
    // 大促摇易摇
    QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:2];
    ctrler.activeTypeId = @"80d5c8b0d4e04b1596b92aaf3b5b4534";
    obj.targetController = ctrler;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1047
- (void)routeIntegalPlayground:(SNRouterObject *)obj
{
    QYaoYiYaoScoreViewCtrler *ctrler = [[QYaoYiYaoScoreViewCtrler alloc] init];
    obj.targetController = ctrler;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1048
- (void)routeYaoYiYaoFromIntegalPlayground:(SNRouterObject *)obj
{
    // 云钻摇易摇
    QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:1];
    obj.targetController = ctrler;
    obj.defaultTabIndex = kHomeTabIndex;
}

//1050 联版专题
- (void)routeUnitedEditionTopics:(SNRouterObject *)obj
{
    LianBanZhuanTiViewController *ctrler = [[LianBanZhuanTiViewController alloc] init];
    
    ctrler.whereFrom = obj.source;
    
    ctrler.targetModuleID = obj.adId;
    
    obj.targetController = ctrler;
    
    obj.defaultTabIndex = kHomeTabIndex;
}

//1051 设置
- (void)routeSetting:(SNRouterObject *)obj
{
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        
        TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
        
        if ([tabBarVC presentedViewController])
        {
            [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
        }
        [tabBarVC setSelectedIndex:4];
        
        UINavigationController *navController = [[tabBarVC viewControllers] safeObjectAtIndex:4];
        
        [navController popToRootViewControllerAnimated:NO];
        
        MyEbuyViewController *ctrl = [navController.viewControllers safeObjectAtIndex:0];
        
        [ctrl gotoSetting];
        
    };
}

//1052 登录
- (void)routeLogin:(SNRouterObject *)obj
{
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        
        TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
        
        if ([tabBarVC presentedViewController])
        {
            [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
        }
        [tabBarVC setSelectedIndex:4];
        
        UINavigationController *navController = [[tabBarVC viewControllers] safeObjectAtIndex:4];
        
        [navController popToRootViewControllerAnimated:NO];
        
        MyEbuyViewController *ctrl = [navController.viewControllers safeObjectAtIndex:0];
        
        [ctrl loginBtnAction];
        
    };
}

//1053 注册
- (void)routeRegiste:(SNRouterObject *)obj
{
    obj.doRouteBlock = ^(SNRouterObject *obj_){
        
        TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
        
        if ([tabBarVC presentedViewController])
        {
            [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
        }
        [tabBarVC setSelectedIndex:4];
        
        UINavigationController *navController = [[tabBarVC viewControllers] safeObjectAtIndex:4];
        
        [navController popToRootViewControllerAnimated:NO];
        
        NewRegisterViewController *registViewController = [[NewRegisterViewController alloc] init];
        
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:registViewController];
        
        MyEbuyViewController *ctrl = [navController.viewControllers safeObjectAtIndex:0];
        
        [ctrl presentModalViewController:userNav animated:YES];
        
    };
}

//2000 TV扫码支付
- (void)routeTVScanToPay:(SNRouterObject *)obj
{
    NSDictionary *paramDic = obj.allParams;
    NSString *loginId  = EncodeStringFromDic(paramDic, @"loginId");
    NSString *orderId  = EncodeStringFromDic(paramDic, @"orderId");
    
    if (nil != loginId
        && nil != orderId) {
        
        // 当前未登录
        if (![UserCenter defaultCenter].isLogined) {
            [self gotoPaymentModeViewController:obj];
            
        }else { // 当前已登录
            
            // 和当前loginId 一致，直接跳转到支付页面（购买确认页面）
            if ([[UserCenter defaultCenter].userInfoDTO.logonId isEqualToString:loginId]) {
                [self gotoPaymentModeViewController:obj];
            }else {
                // 走未登录流程
                // 是否要 注销当前账户  (协商后仅清本地)
                [[UserCenter defaultCenter] clearUserInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_OK_NOTIFICATION
                                                                    object:nil
                                                                  userInfo:nil];
                [self gotoPaymentModeViewController:obj];
            }
        }
    }
    else
    {
        obj.errorMsg = L(@"SNRouteSwitch_WrongQRCode");
    }
}

//1017 扫码支付2
- (void)routeTVScanToPay2:(SNRouterObject *)obj
{
    NSArray *partArray = [obj.adId componentsSeparatedByString:@"_"];
    
    NSString *loginId = [partArray safeObjectAtIndex:0];
    NSString *orderId = [partArray safeObjectAtIndex:1];
    NSString *payValue = [partArray safeObjectAtIndex:2];
    
    [obj addParams:@{@"loginId":loginId?loginId:@"",
                     @"orderId":orderId?orderId:@"",
                     @"shouldPay":payValue?payValue:@"",}];
    
    if (nil != loginId
        && nil != orderId) {
        
        // 当前未登录
        if (![UserCenter defaultCenter].isLogined) {
            [self gotoPaymentModeViewController:obj];
            
        }else { // 当前已登录
            
            // 和当前loginId 一致，直接跳转到支付页面（购买确认页面）
            if ([[UserCenter defaultCenter].userInfoDTO.logonId isEqualToString:loginId]) {
                [self gotoPaymentModeViewController:obj];
            }else {
                // 走未登录流程
                // 是否要 注销当前账户  (协商后仅清本地)
                [[UserCenter defaultCenter] clearUserInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_OK_NOTIFICATION
                                                                    object:nil
                                                                  userInfo:nil];
                [self gotoPaymentModeViewController:obj];
            }
        }
    }
    else
    {
        obj.errorMsg = L(@"SNRouteSwitch_WrongQRCode");
    }
}

- (void)gotoPaymentModeViewController:(SNRouterObject *)obj {
    
    NSDictionary *paramDic = obj.allParams;
    NSString *orderId  = EncodeStringFromDic(paramDic, @"orderId");
    NSString *payValue = EncodeStringFromDic(paramDic, @"shouldPay");
    NSString *loginId  = EncodeStringFromDic(paramDic, @"loginId");
    
    payFlowDTO *bean    = [payFlowDTO payDTOWithOrder:orderId];
    bean.prepay         = payValue;
    [bean setPaymentLimitInfo:L(@"SNRouteSwitch_Tips")];
    
    PaymentModeViewController *ctrler = nil;
    ctrler = [[PaymentModeViewController alloc] initWithPayFlowDTO:bean andShipMode:ShipModeSuningSend];
    
    obj.targetController = ctrler;
    obj.defaultTabIndex = kHomeTabIndex;
    
    obj.didRouteBlock = ^(SNRouterObject *obj_){
        //设置登陆账号
        UINavigationController *presentedCtrler = (UINavigationController *)[[[AppDelegate currentAppDelegate] tabBarViewController] presentedViewController];
        if ([presentedCtrler isKindOfClass:[UINavigationController class]] &&
            [presentedCtrler.topViewController isKindOfClass:[LoginViewController class]])
        {
            LoginViewController *ctrler = (LoginViewController *)presentedCtrler.topViewController;
            ctrler.externAccount = loginId;
        }
    };
}

@end
