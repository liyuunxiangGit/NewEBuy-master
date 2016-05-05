//
//  SNApi.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNApi.h"
#import "NSObject+BoardManage.h"

#import "SNWebViewController.h"
#import "AdModel2ViewController.h"
#import "AdModel3ViewController.h"
#import "AdModel4ViewController.h"
#import "AdModel5ViewController.h"
#import "AdModel6ViewController.h"
#import "AdModelService.h"

#import "SNSpecialSubjectViewController.h"
#import "SpecialSubjectService.h"

#import "SNActivityViewController.h"
#import "SNActivityService.h"

#import "PurchaseProductListViewController.h"
#import "PurchaseDetailViewController.h"
#import "PurchaseService.h"

#import "SNSpecialListViewController.h"
#import "LotteryHallViewController.h"
#import "PaymentCenterViewController.h"
#import "HotSaleViewController.h"
#import "ServiceTrackListViewController.h"
#import "BrowsingHistoryViewController.h"
#import "MyFavoriteViewController.h"
#import "SearchViewController.h"
#import "BBSideBarViewController.h"
#import "LotteryPayPlugin.h"
#import "SearchListViewController.h"
#import "HomePageViewController.h"
#import "MyEbuyViewController.h"

#import "ProductDetailViewController.h"
#import "ProductDetailService.h"
#import "RegexKitLite.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "SNSwitch.h"

#import "PlayVoiceViewController.h"

// TV 扫码支付，XZoscar add, 2014-05-04 14:00
#import "PaymentModeViewController.h"
#import "LoginViewController.h"

#import "ScanerAuthoViewController.h"


@interface SNApi() <AdModelServiceDelegate,SpecialSubjectServiceDelegate,SNActivityServiceDelegate,PurchaseServiceDelegate,ProductDetailServiceDelegate>
{
    BOOL _busy;
}

@property (nonatomic, weak) id<SNApiDMDelegate> delegate;
@property (nonatomic, strong) id service;

@end

/*********************************************************************/

@implementation SNApi
@synthesize isWap = _isWap;
@synthesize isWapOrder = _isWapOrder;
@synthesize isWapSearch = _isWapSearch;
@synthesize isWapDetail = _isWapDetail;
DEF_SINGLETON(SNApi);


+ (void)cancelDelegate:(id<SNApiDMDelegate>)delegate
{
    [[SNApi sharedInstance] cancelDelegate:delegate];
}

- (void)cancelDelegate:(id<SNApiDMDelegate>)delegate
{
    if (self.delegate == delegate)
    {
        self.delegate = nil;
        
        if ([_service respondsToSelector:@selector(setDelegate:)])
        {
            [self.service setDelegate:nil];
        }
        TT_RELEASE_SAFELY(_service);
    }
}

+ (BOOL)busy
{
    return [SNApi sharedInstance]->_busy;
}

#pragma mark ----------------------------- handle methods

+ (void)handleDMURL:(NSString *)url delegate:(id<SNApiDMDelegate>)delegate
{
    [[SNApi sharedInstance] handleDMURL:url delegate:delegate];
}

- (void)handleDMURL:(NSString *)url delegate:(id<SNApiDMDelegate>)delegate
{
    self.delegate = delegate;
    url = url.trim; //去掉两端的空格
    //判断是否是http协议的url
    if ([url isMatchedByRegex:@"^http(s)?:.*" options:RKLCaseless inRange:NSMakeRange(0, url.length) error:NULL])
    {
        NSRange range = [url rangeOfString:@"?"];
        if (range.location == NSNotFound)
        {
            //未知的url
            [self handleUnknownUrl:url];
        }
        else
        {
            NSString *result = [url substringFromIndex:range.location+1];
            NSDictionary *paramDic = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
            NSString *adTypeCode = EncodeStringFromDic(paramDic, @"adTypeCode").trim;
            
            //如果没有，就查找utm_term
            if (!adTypeCode.length) {
                adTypeCode = EncodeStringFromDic(paramDic, @"utm_term").trim;
            }
            
            NSString *adId = EncodeStringFromDic(paramDic, @"adId").trim;
            
            if (!adId.length) {
                adId = EncodeStringFromDic(paramDic, @"utm_content");
            }
            
            NSString *chanId = EncodeStringFromDic(paramDic, @"chanId").trim;
            NSString *qiangId = EncodeStringFromDic(paramDic, @"qiangId").trim;
            NSString *store = EncodeStringFromDic(paramDic, @"store").trim;
            if (adTypeCode.length) {
                if ([delegate isKindOfClass:[SNReaderController class]])
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
                        if (chanId)
                        {
                            strchanId = [NSString stringWithFormat:@"%@",chanId];
                        }
                        [SSAIOSSNDataCollection CustomEventCollection:@"qrcode" keyArray: [NSArray arrayWithObjects:@"adtype", @"adid", @"channelid", nil]valueArray: [NSArray arrayWithObjects:stradTypeCode, stradId, strchanId, nil]];
                        sourceTitle  = L(@"SNRouteSwitch_QRCode");
                        daoPageTitle = [store substringToIndex:4];
                    }
                }
                
                // TV扫码支付 adTypeCode=2000
                if (2000 == adTypeCode.integerValue) {
                    
                    NSString *loginId  = EncodeStringFromDic(paramDic, @"loginId");
                    NSString *payValue = EncodeStringFromDic(paramDic, @"shouldPay");
                    NSString *orderId  = EncodeStringFromDic(paramDic, @"orderId");
                    
                    [self handleTVScannerCodeToPay:loginId orderId:orderId PayValue:payValue];
                    
                }
                else if (1012 == adTypeCode.integerValue) {
                    //扫码跳转店铺首页
                    [self handleCShopURL:url adId:adId];
                }
                else {
                    [self handleDMCode:adTypeCode
                                  adId:adId
                                chanId:chanId
                               qiangId:qiangId
                              delegate:delegate];
                }
                
            }else{
                if ([url hasPrefix:@"http:"] || [url hasPrefix:@"https:"]) {
                    
                    if ([url hasPrefix:@"http://mapp.suning.com/a.php?"]) {
                         // XZoscar 2014-06-19 ad // 扫码登录、注册 (非本地登录和注册，而是传递信息给passport)
                        NSString *uuid = paramDic[@"uuid"];
                        NSString *actionTag = paramDic[@"actionTag"];
                        if (nil != uuid
                            && uuid.length > 0
                            && (nil != actionTag
                                &&([actionTag isEqualToString:@"1"]
                                   ||[actionTag isEqualToString:@"2"]))) {
                            [self handleScanerCodeToLoginOrRegister:actionTag.integerValue uuid:uuid];
                        }else {
                             [self handleUnknownUrl:url];
                        }
                    }else {
                        [self handleUnknownUrl:url];
                    }
                }else{
                    DLog(@"Waring: unrecognized Page");
                    [self onFailWithError:nil];
                }
            }
        }
        
    }
    else
    {
        //非http的url，不能识别就失败
        [self onFailWithError:nil];
        return;
    }
}

- (void)handleScanerCodeToLoginOrRegister:(NSInteger)actionTag uuid:(NSString *)uuid {
    
    [SNApi pushController:nil atTabBarIndex:kHomeTabIndex];
    
    if (actionTag == 1) { // 到登录界面
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
    }else if (actionTag == 2) { // 到注册界面
        
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
    
}

/*
 Function:loadPaymentModeViewController
 Description: TV扫码支付 视图
 Date: 2014-04-30 10:43
 Author:XZoscar
 */
- (void)loadPaymentModeViewController:(NSString *)loginId
                                     :(NSString *)orderId
                                     :(NSString *)payVal {
    
    payFlowDTO *bean    = [payFlowDTO payDTOWithOrder:orderId];
    bean.prepay         = payVal;
    [bean setPaymentLimitInfo:L(@"SNRouteSwitch_Tips")];
    
    PaymentModeViewController *ctrler = nil;
    ctrler = [[PaymentModeViewController alloc] initWithPayFlowDTO:bean andShipMode:ShipModeSuningSend];
    UINavigationController *navCtrler = [SNApi pushController:ctrler atTabBarIndex:kHomeTabIndex];
    
    if (loginId != nil) {
        UINavigationController *presentedCtrler = nil;
        presentedCtrler = (UINavigationController *)[[navCtrler topViewController] presentedViewController];
        if ([presentedCtrler.topViewController isKindOfClass:[LoginViewController class]]) {
            LoginViewController *ctrler = (LoginViewController *)presentedCtrler.topViewController;
            ctrler.externAccount = loginId;
        }
    }
}

/*
 Function: handleTVScannerCodeToPay
 Description:adTypeCodeId == 1000 直接跳转到支付界面，
            若当前已登录且登录账户和扫码中的账户相同，不再登录 直接跳转到支付界面，
            若未登录或与扫码账户不同，跳转到登录界面并带入账户，登陆后跳转到支付界面。
 Date: 2014-04-30 10:43
 Author:XZoscar
 */
- (void)handleTVScannerCodeToPay:(NSString *)loginId
                         orderId:(NSString *)orderId
                        PayValue:(NSString *)payVal {
    
    if (nil != loginId
        && nil != orderId) {
        
        // 当前未登录
        if (![UserCenter defaultCenter].isLogined) {
            [self loadPaymentModeViewController:loginId :orderId :payVal];

        }else { // 当前已登录
            
            // 和当前loginId 一致，直接跳转到支付页面（购买确认页面）
            if ([[UserCenter defaultCenter].userInfoDTO.logonId isEqualToString:loginId]) {
                [self loadPaymentModeViewController:nil :orderId :payVal];
            }else {
                // 走未登录流程
                // 是否要 注销当前账户  (协商后仅清本地)
                [[UserCenter defaultCenter] clearUserInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_OK_NOTIFICATION
                                                                    object:nil
                                                                  userInfo:nil];
                [self loadPaymentModeViewController:loginId :orderId :payVal];
            }
        }
    }
}

/**
 *  处理店铺URL
 *  targetURL : 二维码原始URL
 *  targetAdId : 商户编码
 */
- (void)handleCShopURL:(NSString *)targetURL adId:(NSString *)targetAdId {
    //进入店铺首页
    NSDictionary *dic = @{
                          @"url" : targetURL,
                          @"shopId" :targetAdId};
    [SNApi goToShopMainPage:dic];
}

- (void)handleUnknownUrl:(NSString *)url
{
    NSURL *nUrl = [NSURL URLWithString:url];
    if (nUrl)
    {
        NSDictionary *paramDic = @{@"adType" : @(DMUnknownUrl), @"url": nUrl};
        if ([_delegate dmOnResponseShouldGoToPageWithParamDic:paramDic])
        {
            [SNApi goToUnknownUrl:paramDic];
        }
    }
    else
    {
        [self onFailWithError:L(@"SNRouteSwitch_IncorrectNetwork")];
    }
}

+ (void)handleDMCode:(NSString *)adTypeCode
                adId:(NSString *)adId
            delegate:(id<SNApiDMDelegate>)delegate
{
    [[SNApi sharedInstance] handleDMCode:adTypeCode
                                    adId:adId
                                  chanId:nil
                                 qiangId:nil
                                delegate:delegate];
}

+ (void)handleDMCode:(NSString *)adTypeCode
                adId:(NSString *)adId
              chanId:(NSString *)chanId
             qiangId:(NSString *)qiangId
            delegate:(id<SNApiDMDelegate>)delegate
{
    [SNApi sharedInstance].isWap = NO;
    [SNApi sharedInstance].isWapOrder = NO;
    [SNApi sharedInstance].isWapSearch = 0;
    [SNApi sharedInstance].isWapDetail = 0;
    [[SNApi sharedInstance] handleDMCode:adTypeCode
                                    adId:adId
                                  chanId:chanId
                                 qiangId:qiangId
                                delegate:delegate];
}

- (NSDictionary *)parseAdId:(NSString *)adId
{
    NSArray *partDic = [adId componentsSeparatedByString:@"_"];
    
    NSString *productId = [partDic safeObjectAtIndex:0];
    NSString *shopCode = [partDic safeObjectAtIndex:1];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:productId?productId:@"" forKey:@"productId"];
    if (shopCode) {
        [dic setObject:shopCode forKey:@"shopCode"];
    }
    return [dic copy];
}

- (void)handleDMCode:(NSString *)adTypeCode
                adId:(NSString *)adId
              chanId:(NSString *)chanId
             qiangId:(NSString *)qiangId
            delegate:(id<SNApiDMDelegate>)delegate
{
    self.delegate = delegate;
    
    if (adTypeCode)
    {
        int code = [adTypeCode intValue];
        switch (code)
        {
                //八联版
            case 101:
            case 102:
            case 103:
            case 104:
            case 105:
            case 106:
            {
                [self checkAdMode:adId];
                break;
            }
                //促销专栏
            case 200:
            {
                [self checkSpecialSubject:adId];
                break;
            }
                //促销专栏内页
            case 201:
            case 202:
            case 203:
            {
                [self checkActivity:adId];
                break;
            }
                //收听声音
            case 204:
            {
                [SNApi goToPlayVoice:nil];
                break;
            }
                //抢购
            case 12:
            {
                if (adId.length)
                {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self parseAdId:adId]];
                    if (chanId) [dic setObject:chanId forKey:@"chanId"];
                    if (qiangId) [dic setObject:qiangId forKey:@"qiangId"];
                    
                    if (qiangId.length && chanId.length)
                    {
                        [self checkRushPurchaseDetail:dic];
                    }
                    else
                    {
                        [self onFailWithError:L(@"SNRouteSwitch_SorryActivityEnd")];
                    }
                }
                else
                {
                    NSDictionary *dic = @{@"adType":@(DMRushPurchaseList)};
                    if ([self onResponseWithparamDic:dic])
                    {
                        [SNApi goToRushPurchaseList:dic];
                    }
                }
                break;
            }
            case 13: //榜单
            {
                NSDictionary *dic = @{@"adType":@(DMBangDan)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToBangDanList:dic];
                }
                
                break;
            }
            case 14: //类目
            {
                NSDictionary *dic = @{@"adType":@(DMCategory)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToCategory:dic];
                }
                break;
            }
            case 15: //彩票
            {
                NSDictionary *dic = @{@"adType":@(DMLottery)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToLottery:dic];
                }
                break;
            }
            case 16: //手机充值
            {
                NSDictionary *dic = @{@"adType":@(DMMobileCharge)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToMobileCharge:dic];
                }
                break;
            }
            case 17: //热销
            {
                if (adId.length)
                {
                    [self checkProductDetail:[self parseAdId:adId]];
                }
                else
                {
                    NSDictionary *dic = @{@"adType":@(DMHotSale)};
                    if ([self onResponseWithparamDic:dic])
                    {
                        [SNApi goToHostSale:dic];
                    }
                }
                break;
            }
            case 18: //送货安装
            {
                NSDictionary *dic = @{@"adType":@(DMDeliveryInstall)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToDeliveryInstall:dic];
                }
                break;
            }
            case 19: //水电煤缴费
            {
                NSDictionary *dic = @{@"adType":@(DMWaterElecGas)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToWaterElecGasCharge:dic];
                }
                break;
            }
            case 20: //浏览历史
            {
                NSDictionary *dic = @{@"adType":@(DMBrowseHistory)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToBrowseHistory:dic];
                }
                break;
            }
            case 21: //我的收藏
            {
                NSDictionary *dic = @{@"adType":@(DMMyFavorite)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToMyFavorite:dic];
                }
                break;
            }
                //            case 22:
                //            {
                //                [SNApi goToAppStore:paramDic];
                //                break;
                //            }
            case 23: //搜索
            {
                NSDictionary *dic = @{@"adType":@(DMSearch)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToSearch:dic];
                }
                break;
            }
            case 24: //购物车
            {
                NSDictionary *dic = @{@"adType":@(DMShopCart)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToShopCart:dic];
                }
                break;
            }
            case 25: //我的易购
            {
                NSDictionary *dic = @{@"adType":@(DMMyEBuy)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToMyEbuy:dic];
                }
                break;
            }
            case 26: //商品详情
            {
                if (adId.length)
                {
                    [self checkProductDetail:[self parseAdId:adId]];
                }
                else
                {
                    [self onFailWithError:nil];
                }
                break;
            }
            case 27: //本地生活
            {
                NSDictionary *dic = @{@"adType":@(DMLocalLife)};
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToLocalLife:dic];
                }
                break;
            }
            case 28://本地生活团购详情
            {
                NSDictionary *dic = @{
                                      @"adType" : @(DMLocalLifeDetail),
                                      @"adId" :adId};
                
                if ([self onResponseWithparamDic:dic])
                {
                    [SNApi goToLocalLife:dic];
                }
                break;
            }
            case 1000:  //扫码支付
            {
                [self onFailWithError:L(@"SNRouteSwitch_NotSupportScanPay")];
                break;
            }
            default:
            {
                DLog(@"Waring: unrecognized Page");
                [self onFailWithError:nil];
                break;
            }
        }
    }
    else
    {
        DLog(@"Waring: unrecognized Page");
        [self onFailWithError:nil];
    }
}

+ (BOOL)handleOpenURL:(NSURL *)url
{
    NSComparisonResult comparR = [[url absoluteString] compare:kURLSchemeSuningEBuy
                                                       options:NSCaseInsensitiveSearch
                                                         range:NSMakeRange(0, 24)];
    [SNApi sharedInstance].isWap = NO;
    [SNApi sharedInstance].isWapOrder = NO;
    [SNApi sharedInstance].isWapSearch = 0;
    [SNApi sharedInstance].isWapDetail = 0;
    if (comparR == NSOrderedSame)
    {
        DLog(@"handle App Open With URL: %@", url);
        NSString *subStr = [[url absoluteString] substringFromIndex:24];
        NSRange range = [subStr rangeOfString:@"?"];
        if (range.location == NSNotFound)
        {
            return YES;
        }
        else
        {
            NSString *action = [subStr substringToIndex:range.location];
            NSString *result = [subStr substringFromIndex:range.location+1];
            NSDictionary *paramDic = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
            if ([action isEqualToString:@"EBuyEightBanner"])
            {
                [self goToAdModel:paramDic];
            }
            else if ([action isEqualToString:@"EBuySpecialSubject"])
            {
                [self goToSpecialSubject:paramDic];
            }
            else if ([action isEqualToString:@"EBuyActivityView"])
            {
                [self goToActivityView:paramDic];
            }
            else if ([action isEqualToString:@"EBuyRushPurchaseList"])
            {
                [self goToRushPurchaseList:paramDic];
            }
            else if ([action isEqualToString:@"EBuyBangDanList"])
            {
                [self goToBangDanList:paramDic];
            }
            else if ([action isEqualToString:@"EBuyCategory"])
            {
                [self goToCategory:paramDic];
            }
            else if ([action isEqualToString:@"EBuyLottery"])
            {
                [self goToLottery:paramDic];
            }
            else if ([action isEqualToString:@"EBuy_MobileCharge"])
            {
                [self goToMobileCharge:paramDic];
            }
            else if ([action isEqualToString:@"EBuyHotSale"])
            {
                [self goToHostSale:paramDic];
            }
            else if ([action isEqualToString:@"EBuyDeliveryInstall"])
            {
                [self goToDeliveryInstall:paramDic];
            }
            else if ([action isEqualToString:@"EBuyWaterElecGasCharge"])
            {
                [self goToWaterElecGasCharge:paramDic];
            }
            else if ([action isEqualToString:@"EBuyBrowseHistory"])
            {
                [self goToBrowseHistory:paramDic];
            }
            else if ([action isEqualToString:@"EBuyMyFavorite"])
            {
                [self goToMyFavorite:paramDic];
            }
            else if ([action isEqualToString:@"EBuySearch"])
            {
                [self goToSearch:paramDic];
            }
            else if ([action isEqualToString:@"EBuyShopCart"])
            {
                [self goToShopCart:paramDic];
            }
            else if ([action isEqualToString:@"EBuyMyEBuy"])
            {
                [self goToMyEbuy:paramDic];
            }
            else if ([action isEqualToString:@"EBuyProductDetail"])
            {
                [self goToProductDetail:paramDic];
            }
            else if ([action isEqualToString:@"EBuyLocalLife"])
            {
                [self goToLocalLife:paramDic];
            }
            else if ([action isEqualToString:@"DGFQ"])
            {
                //彩票支付完成
                [self goToLotteryPayOkPage:paramDic];
            }
            else if ([action isEqualToString:@"wapToEbuy"]) //wap页到客户端对应页面
            {
                NSString *adTypeCode = paramDic[@"adTypeCode"];
                
                if ([adTypeCode eq:@"25"])
                {
                    //我的易购
                    [self goToMyEbuy:paramDic];
                    [SNApi sharedInstance].isWap = YES;
                    //弹登录框
                    if (![UserCenter defaultCenter].isLogined)
                    {
                        [[SNApi sharedInstance].myEbuyBoard loginBtnAction];
                    }
                    
                }
                else if ([adTypeCode eq:@"26"])
                {
                    //商品详情
                    [SNApi sharedInstance].isWapDetail = 1;
                    TabBarController *tabbar = APP_DELEGATE.tabBarViewController;
                    tabbar.selectedIndex = kHomeTabIndex;
                    UINavigationController *nav = [tabbar.viewControllers safeObjectAtIndex:kHomeTabIndex];
                    [nav popToRootViewControllerAnimated:NO];
                    [self handleDMCode:adTypeCode
                                  adId:paramDic[@"adId"]
                              delegate:[SNApi sharedInstance].homeBoardNew];
                }
                else if ([adTypeCode eq:@"29"])
                {
                    //我的订单
                    [SNApi sharedInstance].isWapOrder = YES;
                    [self goToOrderCenter:paramDic];
                }
                else if ([adTypeCode eq:@"30"])
                {
                    //搜索结果页
                    [SNApi sharedInstance].isWapSearch = 1;
                    [self goToSearchResult:paramDic];
                }
            }
            else
            {
                DLog(@"Waring: unrecognized action, Just Open App");
            }
            return YES;
        }
        
    }
    else
    {
        DLog(@"Waring: SNApi can't handle this url");
        return NO;
    }
}

#pragma mark ----------------------------- page jump action

//跳转页面

+ (UINavigationController *)pushController:(UIViewController *)vc atTabBarIndex:(NSInteger)index
{
    TabBarController *tabBarVC = APP_DELEGATE.tabBarViewController;
    
    if ([[tabBarVC viewControllers] count] > index)
    {
        tabBarVC.selectedIndex = index;
        UINavigationController *navController = [[tabBarVC viewControllers] objectAtIndex:index];
        [navController popToRootViewControllerAnimated:NO];
        //case have a modalviewcontroller
        if ([navController presentedViewController])
        {
            [navController dismissViewControllerAnimated:NO completion:NULL];
        }
        
        if (vc && [vc isKindOfClass:[UIViewController class]])
        {
            [navController pushViewController:vc animated:YES];
        }
        
        return navController;
    }
    
    return nil;
}

+ (void)goToAdModel:(NSDictionary *)paramDic
{
    NSString *adId = EncodeStringFromDic(paramDic, @"adId");
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
            [self pushController:vc atTabBarIndex:kHomeTabIndex];
        }
        return;
    }
    
    switch (model) {
        case kModel1:
        {
            NSString *url = innerImage.trim;
            if (url.length)
            {
                SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel
                 attributes:@{@"url": url, @"activeName": activeName?activeName:@""}];
                [self pushController:vc atTabBarIndex:kHomeTabIndex];
            }
        }
        case kModel2:
        {
            AdModel2ViewController *vc = [[AdModel2ViewController alloc] initWithAdvertiseId:adId];
            vc.activeName = activeName;
            vc.activeRule = activeRule;
            vc.activeInnerImageUrl = innerImage;
            [self pushController:vc atTabBarIndex:kHomeTabIndex];
            break;
        }
        case kModel3:
        {
            AdModel3ViewController *vc = [[AdModel3ViewController alloc] initWithAdvertiseId:adId];
            vc.activeName = activeName;
            vc.activeRule = activeRule;
            vc.activeInnerImageUrl = innerImage;
            [self pushController:vc atTabBarIndex:kHomeTabIndex];
            break;
        }
        case kModel4:
        {
            AdModel4ViewController *vc = [[AdModel4ViewController alloc] initWithAdvertiseId:adId];
            vc.activeName = activeName;
            vc.activeRule = activeRule;
            vc.activeInnerImageUrl = innerImage;
            [self pushController:vc atTabBarIndex:kHomeTabIndex];
            break;
        }
        case kModel5:
        {
            AdModel5ViewController *vc = [[AdModel5ViewController alloc] initWithAdvertiseId:adId];
            vc.activeName = activeName;
            vc.define = define;
            [self pushController:vc atTabBarIndex:kHomeTabIndex];
            break;
        }
        case kModel6:
        {
            AdModel6ViewController *vc = [[AdModel6ViewController alloc] initWithAdvertiseId:adId];
            vc.activeName = activeName;
            vc.activeRule = activeRule;
            vc.activeInnerImageUrl = innerImage;
            [self pushController:vc atTabBarIndex:kHomeTabIndex];
            break;
        }
        default:
            break;
    }
}

+ (void)goToSpecialSubject:(NSDictionary *)paramDic
{
    SNSpecialSubjectDTO *dto = [paramDic objectForKey:@"dto"];
    
    if (dto)
    {
        SNSpecialSubjectViewController *vc = [[SNSpecialSubjectViewController alloc] init];
        vc.specialSubjectDto = dto;
        [self pushController:vc atTabBarIndex:kHomeTabIndex];
    }
}

+ (void)goToActivityView:(NSDictionary *)paramDic
{
    NSString *actName = [paramDic objectForKey:@"actName"];
    NSString *actId = [paramDic objectForKey:@"actId"];
    NSString *sortType = [paramDic objectForKey:@"sortType"];
    if ([actId length])
    {
        SNActivityViewController *vc = [[SNActivityViewController alloc] initWithActName:actName areaName:nil];
        vc.activityId = actId;
        vc.prdSortType = sortType;
        [self pushController:vc atTabBarIndex:kHomeTabIndex];
    }
}

+ (void)goToRushPurchaseList:(NSDictionary *)paramDic
{
    PurchaseProductListViewController *vc = [[PurchaseProductListViewController alloc] init];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToRushPurchaseDetail:(NSDictionary *)paramDic
{
    PanicPurchaseDTO *dto = [paramDic objectForKey:@"dto"];
    NSString *cityCode = [paramDic objectForKey:@"cityCode"];
    NSString *chanId = [paramDic objectForKey:@"chanId"];
//    NSString *shopCode = [paramDic objectForKey:@"shopCode"];
    
    if (dto)
    {
        DataProductBasic *dataProductBasic = dto.transformToProductDTO;
        
        ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
        productViewController.type = 2;
        productViewController.productBase.cityCode = cityCode;
        productViewController.productType = FromPanicProduct;
        productViewController.panicDTO = dto;
        if ([chanId isEqualToString:@"1"]) {
            productViewController.panicChannel = PanicChannelB2C;
        }else if ([chanId isEqualToString:@"2"]){
            productViewController.panicChannel = PanicChannelMobile;
        }else if ([chanId isEqualToString:@"3"]){
            productViewController.panicChannel = PanicChannelReadBaby;
        }
        [self pushController:productViewController atTabBarIndex:kHomeTabIndex];
        return;
        
//        PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:dto];
//        vc.productBase.cityCode = cityCode;
////        vc.productBase.shopCode = shopCode;
//        if ([chanId isEqualToString:@"1"]) {
//            vc.panicChannel = PanicChannelB2C;
//        }else if ([chanId isEqualToString:@"2"]){
//            vc.panicChannel = PanicChannelMobile;
//        }else if ([chanId isEqualToString:@"3"]){
//            vc.panicChannel = PanicChannelReadBaby;
//        }
//        vc.productType = PanicProduct;
//        [self pushController:vc atTabBarIndex:kHomeTabIndex];
    }
}

+ (void)goToBangDanList:(NSDictionary *)paramDic
{
    SNSpecialListViewController *special = [[SNSpecialListViewController alloc] init];
    [self pushController:special atTabBarIndex:kHomeTabIndex];
}

+ (void)goToCategory:(NSDictionary *)paramDic
{
    [self pushController:nil atTabBarIndex:kCateTabIndex];
}

+ (void)goToPlayVoice:(NSDictionary *)paramDic
{
    PlayVoiceViewController *playvoice = [[PlayVoiceViewController alloc] init];
    [self pushController:playvoice atTabBarIndex:kHomeTabIndex];
}

+ (void)goToLottery:(NSDictionary *)paramDic
{
    LotteryHallViewController *ctrl = [[LotteryHallViewController alloc]init];
    [self pushController:ctrl atTabBarIndex:kHomeTabIndex];
}

+ (void)goToMobileCharge:(NSDictionary *)paramDic
{
    PaymentCenterViewController *vc = [[PaymentCenterViewController alloc] init];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToHostSale:(NSDictionary *)paramDic
{
    HotSaleViewController *vc = [[HotSaleViewController alloc] init];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToDeliveryInstall:(NSDictionary *)paramDic
{
    ServiceTrackListViewController *vc = [[ServiceTrackListViewController alloc] init];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToWaterElecGasCharge:(NSDictionary *)paramDic
{
    PaymentCenterViewController *vc = [[PaymentCenterViewController alloc] init];
    [vc setSegmentIndex:1];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToBrowseHistory:(NSDictionary *)paramDic
{
    BrowsingHistoryViewController *vc = [[BrowsingHistoryViewController alloc] init];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToMyFavorite:(NSDictionary *)paramDic
{
    MyFavoriteViewController *vc = [[MyFavoriteViewController alloc] init];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToAppStore:(NSDictionary *)paramDic
{
    //do nothing
}

+ (void)goToSearch:(NSDictionary *)paramDic
{
    [self pushController:nil atTabBarIndex:kSearchTabIndex];
}

+ (void)goToSearchResult:(NSDictionary *)paramDic
{
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
    
    TabBarController *tabbar = APP_DELEGATE.tabBarViewController;
    UINavigationController *nav = [tabbar.viewControllers safeObjectAtIndex:kSearchTabIndex];
    [nav popToRootViewControllerAnimated:NO];
    [SearchListViewController goToSearchResultWithParamDTO:param fromNav:nav];
    tabbar.selectedIndex = kSearchTabIndex;
    
}

+ (void)goToShopCart:(NSDictionary *)paramDic
{
    [self pushController:nil atTabBarIndex:kShopCartTabIndex];
}

+ (void)goToMyEbuy:(NSDictionary *)paramDic
{
    [self pushController:nil atTabBarIndex:kMyEbuyTabIndex];
}

+ (void)goToOrderCenter:(NSDictionary *)paramDic
{
    [[SNApi sharedInstance] jumpToOrderCenterBoard];
}

+ (void)goToProductDetail:(NSDictionary *)paramDic
{
    DataProductBasic *dto = [paramDic objectForKey:@"dto"];
    
    if (dto)
    {
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
        [self pushController:vc atTabBarIndex:kHomeTabIndex];
    }
}

/**
 *  跳转到店铺web首页
 *  paramDic: 字典，里面包含url和shopId字段
 */
+ (void)goToShopMainPage:(NSDictionary *)paramDic {

    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCShop attributes:paramDic];
    [self pushController:vc atTabBarIndex:kHomeTabIndex];
}

+ (void)goToLocalLife:(NSDictionary *)paramDic
{
    NSString *appId = [paramDic objectForKey:@"adId"];
    [self pushController:nil atTabBarIndex:kHomeTabIndex];
    if (IsStrEmpty(appId)) {
        [BBSideBarViewController goToLocalLife:@"" snProId:@""];
    }else{
        NSArray *array = [appId componentsSeparatedByString:@","];
        if ([array count] == 4) {
            [Config currentConfig].gbDefaultCityId = [array objectAtIndex:2];
            [Config currentConfig].gbDefaultCityName = [array objectAtIndex:3];
            [BBSideBarViewController goToLocalLife:[array objectAtIndex:0] snProId:[array objectAtIndex:1]];
        }else{
            [BBSideBarViewController goToLocalLife:@"" snProId:@""];
        }
    }
}

+ (void)goToLotteryPayOkPage:(NSDictionary *)paramDic
{
    [LotteryPayPlugin lastOrderPayedOk];
}

+ (void)goToUnknownUrl:(NSDictionary *)paramDic
{
    NSURL *url = [paramDic objectForKey:@"url"];

    if (url) {
        SNWebViewController *vc = [[SNWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
        [self pushController:vc atTabBarIndex:kHomeTabIndex];
    }
    
}

#pragma mark ----------------------------- call backs

- (void)onChecking
{
    _busy = YES;
    
    if ([_delegate respondsToSelector:@selector(dmOnChecking)])
    {
        [_delegate dmOnChecking];
    }
}

- (BOOL)onResponseWithparamDic:(NSDictionary *)paramDic
{
    _busy = NO;
    
    if ([_delegate respondsToSelector:@selector(dmOnResponseShouldGoToPageWithParamDic:)])
    {
        return [_delegate dmOnResponseShouldGoToPageWithParamDic:paramDic];
    }
    return NO;
}

- (void)onFailWithError:(NSString *)errorMsg
{
    if ([_delegate respondsToSelector:@selector(dmOnFailWithError:)])
    {
        [_delegate dmOnFailWithError:errorMsg];
    }
}

#pragma mark ----------------------------- check methods & call services

#pragma mark check adModel
- (void)checkAdMode:(NSString *)adId
{
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
                  @"adType" : @(DMAdModel),
                  @"adId" : dto.advertiseId?dto.advertiseId:@"",
                  @"model" : dto.model?dto.model:@"",
                  @"activeName" : dto.activeName?dto.activeName:@"",
                  @"innerImage" : dto.innerImageURL?dto.innerImageURL:@"",
                  @"activeRule" : dto.activeRule?dto.activeRule:@"",
                  @"define" : dto.define?dto.define:@"",
                  @"background" : dto.backgroundURL?dto.backgroundURL:@""
                  };
                if ([self onResponseWithparamDic:paramDic])
                {
                    [SNApi goToAdModel:paramDic];
                }
                return;
            }
        }
    }
    
    //缓存中没有则调用接口检查
    [self onChecking];
    
    AdModelService *service = [[AdModelService alloc] init];
    service.delegate = self;
    self.service = service;
    [service requestModelListWithAdId:adId];
}

- (void)service:(AdModelService *)service getAdModelListComplete:(BOOL)isSuccess
{
    HomeTopScrollAdDTO *dto = service.dto;
    if (isSuccess && (dto.backgroundURL.length || dto.advertiseId.length))
    {
        NSDictionary *paramDic = @{
                                   @"adType" : @(DMAdModel),
                                   @"adId" : dto.advertiseId?dto.advertiseId:@"",
                                   @"model" : dto.model?dto.model:@"",
                                   @"activeName" : dto.activeName?dto.activeName:@"",
                                   @"innerImage" : dto.innerImageURL?dto.innerImageURL:@"",
                                   @"activeRule" : dto.activeRule?dto.activeRule:@"",
                                   @"define" : dto.define?dto.define:@"",
                                   @"background" : dto.backgroundURL?dto.backgroundURL:@""
                                   };
        
        if ([self onResponseWithparamDic:paramDic])
        {
            [SNApi goToAdModel:paramDic];
        }
    }
    else
    {
        [self onFailWithError:service.errorMsg];
    }
    
    self.service = nil;
}

#pragma mark checkSpecialSubject

- (void)checkSpecialSubject:(NSString *)adId
{
    //先直接从缓存中取,取到就直接回调
    NSArray *cachedList = [Config currentConfig].specialSubjectList;
    if ([cachedList count] > 0)
    {
        for (SNSpecialSubjectDTO *specialDto in cachedList)
        {
            if ([specialDto respondsToSelector:@selector(areaId)]&&[specialDto.areaId eq:adId])
            {
                NSDictionary *paramDic = @{@"dto":specialDto,@"adType":@(DMSpecialSubject)};
                if ([self onResponseWithparamDic:paramDic])
                {
                    [SNApi goToSpecialSubject:paramDic];
                }
                return;
            }
        }
    }
    
    //缓存中没有，调用接口查询
    [self onChecking];
    
    SpecialSubjectService *service = [[SpecialSubjectService alloc] init];
    service.delegate = self;
    self.service = service;
    [service beginGetSpecialSubjectsRequest:@"10" withPomAreaId:adId];
}

- (void)getSpecialSubjectsCompletionWithResult:(BOOL)isSuccess
                                      errorMsg:(NSString *)errorMsg
                                   subjectList:(NSArray *)list
{
    if (isSuccess && [list count])
    {
        NSDictionary *paramDic = @{@"dto":[list objectAtIndex:0],@"adType":@(DMSpecialSubject)};
        if ([self onResponseWithparamDic:paramDic])
        {
            [SNApi goToSpecialSubject:paramDic];
        }
    }
    else
    {
        [self onFailWithError:errorMsg];
    }
    
    self.service = nil;
}

#pragma mark -
#pragma mark check checkActivity

- (void)checkActivity:(NSString *)adId
{
    //先直接从缓存中取,取到就直接回调
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
              @"actId":dto.activityId?dto.activityId:@"",
              @"sortType":dto.prdSortType?dto.prdSortType:@"",
              @"adType":@(DMActivityView)};
            if ([self onResponseWithparamDic:paramDic])
            {
                [SNApi goToActivityView:paramDic];
            }
            
            return;
        }
    }
    
    //调用接口查询
    [self onChecking];
    
    SNActivityService *service = [[SNActivityService alloc] init];
    service.delegate = self;
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
    if (isSuccess && [array count] !=0)
    {
        NSDictionary *paramDic =
        @{@"actName": dto.actName?dto.actName:@"",
          @"actId":dto.activityId?dto.activityId:@"",
          @"sortType":dto.prdSortType?dto.prdSortType:@"",
          @"adType":@(DMActivityView)};
        
        if ([self onResponseWithparamDic:paramDic])
        {
            [SNApi goToActivityView:paramDic];
        }
    }
    else
    {
        [self onFailWithError:errorMsg];
    }
    
    self.service = nil;
}

#pragma mark -
#pragma mark checkRushPurchaseDetail

- (void)checkRushPurchaseDetail:(NSDictionary *)paramDic
{
    NSString *qiangId = paramDic[@"qiangId"];
    NSString *chanId = paramDic[@"chanId"];
    //    NSString *productId = paramDic[@"productId"];
    NSString *shopCode = paramDic[@"shopCode"];
    shopCode = shopCode?shopCode:@"";   //默认自营
    
    [self onChecking];
    
    PurchaseService *service = [[PurchaseService alloc] init];
    if ([chanId isEqualToString:@"1"]) {
        service.panicChannel = PanicChannelB2C;
    }else if ([chanId isEqualToString:@"2"]){
        service.panicChannel = PanicChannelMobile;
    }else if ([chanId isEqualToString:@"3"]){
        service.panicChannel = PanicChannelReadBaby;
    }
    service.delegate = self;
    self.service = service;
    
    //请求抢购详情
    NSString *cityCode = [Config currentConfig].gpsCityCode;
    if (!cityCode.length) {
        cityCode = [Config currentConfig].defaultCity;
    }
    
    service.context = @{@"cityCode": cityCode, @"shopCode":shopCode};
    [service beginGetPanicPurchaseDetailList:qiangId cityId:cityCode];
}

- (void)getPanicPurchaseDetailCompletionWithResult:(BOOL)isSuccess
                                          errorMsg:(NSString *)errorMsg
                               panicPurchaseDetail:(PanicPurchaseDTO *)dto
                                         errorCode:(NSString *)errorCode
{
    if (isSuccess && errorMsg == nil && dto.rushPurId.length)
    {
        PurchaseService *service = (PurchaseService *)self.service;
        NSDictionary *contextDic = [service context];
        
        NSString *cityCode = contextDic[@"cityCode"];
        NSString *shopCode = contextDic[@"shopCode"];
        if (!dto.shopCode.length) dto.shopCode = shopCode;
        
        NSString *chanId = [NSString stringWithFormat:@"%d", service.panicChannel];
        
        cityCode = cityCode?cityCode:[Config currentConfig].defaultCity;
        shopCode = shopCode?shopCode:@"";
        NSDictionary *paramDic = @{@"dto":dto,
                                   @"adType":@(DMRushPurchaseDetail),
                                   @"cityCode":cityCode,
                                   @"chanId":chanId,
                                   @"shopCode":shopCode};
        if ([self onResponseWithparamDic:paramDic])
        {
            [SNApi goToRushPurchaseDetail:paramDic];
        }
    }
    else
    {
        [self onFailWithError:errorMsg.length?errorMsg:L(@"SNRouteSwitch_PurchaseEndOrNoInfo")];
    }
    
    self.service = nil;
}

#pragma mark -
#pragma mark check productDetail

- (void)checkProductDetail:(NSDictionary *)paramDic
{
    NSString *productId = paramDic[@"productId"];
    NSString *shopCode = paramDic[@"shopCode"];
    
    [self onChecking];
    
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    dto.productId = productId;
    dto.shopCode = shopCode;
    
    //取gpsCity
    NSString *cityCode = [Config currentConfig].gpsCityCode;
    if (!cityCode.length) {
        cityCode = [Config currentConfig].defaultCity;
    }
    dto.cityCode = cityCode;
    ProductDetailService *service = [[ProductDetailService alloc] init];
    service.delegate = self;
    self.service = service;
    
    [service beginGetProductDetailInfo:dto];
}

- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg
                               productDetail:(DataProductBasic *)product
{    
    if (isSuccess && product)
    {
        NSDictionary *paramDic = @{@"dto":product,@"adType":@(DMProductDetail)};
        if ([self onResponseWithparamDic:paramDic])
        {
            [SNApi goToProductDetail:paramDic];
        }
    }
    else
    {
        [self onFailWithError:errorMsg];
    }
    
    self.service = nil;
}

@end
