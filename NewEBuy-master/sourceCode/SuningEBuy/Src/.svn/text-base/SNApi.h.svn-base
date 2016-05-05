//
//  SNApi.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

enum _SNDMAdType{
    DMAdModel = 100,
    DMSpecialSubject = 200,
    DMActivityView = 201,
    DMRushPurchaseList = 12,
    DMRushPurchaseDetail = 121,
    DMBangDan = 13,
    DMCategory = 14,
    DMLottery = 15,
    DMMobileCharge = 16,
    DMHotSale = 17,
    DMDeliveryInstall = 18,
    DMWaterElecGas = 19,
    DMBrowseHistory = 20,
    DMMyFavorite = 21,
    DMAppStore = 22,
    DMSearch = 23,
    DMShopCart = 24,
    DMMyEBuy = 25,
    DMProductDetail = 26,
    DMLocalLife = 27,
    DMLocalLifeDetail = 28,
    DMCShopMainPage = 1012,
    DMUnknownUrl    = 2012,
};

@protocol SNApiDMDelegate <NSObject>

//开始检查dm逻辑是否正确，一般是在调接口
- (void)dmOnChecking;

//检查dm是否正确完成，isValid是是否正确，并询问delegate是否可以跳转, paramDic中包含参数
// adType: 为跳转页面类型, 值为_SNDMAdType
- (BOOL)dmOnResponseShouldGoToPageWithParamDic:(NSDictionary *)paramDic;

//添加方法，更灵活 (现在需求只要展示商品已下架等错误，所以只有商品详情时errorMsg才有值）
- (void)dmOnFailWithError:(NSString *)errorMsg;

@optional
//dm从第几个tab进行push
- (NSInteger)dmPushTabIndex:(NSDictionary *)paramDic;

//从第几个navPush
- (UINavigationController *)dmPushNavController:(NSDictionary *)paramDic;

@end

__attribute__((deprecated("废弃类sice 2.4.2")))
@interface SNApi : NSObject

AS_SINGLETON(SNApi);

//from DM
+ (void)handleDMURL:(NSString *)url delegate:(id<SNApiDMDelegate>)delegate;
+ (void)handleDMCode:(NSString *)adTypeCode
                adId:(NSString *)adId
            delegate:(id<SNApiDMDelegate>)delegate;
+ (void)handleDMCode:(NSString *)adTypeCode
                adId:(NSString *)adId
              chanId:(NSString *)chanId
             qiangId:(NSString *)qiangId
            delegate:(id<SNApiDMDelegate>)delegate;
+ (void)cancelDelegate:(id<SNApiDMDelegate>)delegate;
+ (BOOL)busy;

//from Open URL
+ (BOOL)handleOpenURL:(NSURL *) url;

/*!
 @abstract      去一个八联版的内页
 @discussion    参数中字段要求  @{@"adId": 广告id, 
                                @"model": 模板类型,
                                @"activeName": 活动名称,
                                @"activeRule": 活动规则,
                                @"innerImage": 内页图链接,
                                @"define": 说明,
                                @"background":背景图片链接}
 */
+ (void)goToAdModel:(NSDictionary *)paramDic;

/*!
 @abstract      去促销模板页
 @discussion    参数中字段要求  @{
 @"dto": SNSpecialSubjectDTO的对象}
 */
+ (void)goToSpecialSubject:(NSDictionary *)paramDic;

/*!
 @abstract      去促销模板内页
 @discussion    参数中字段要求  @{
 @"actName": 活动名称
 @"actId"  : 活动id
 @"sortType":排序方式 1，2，3分别代表1行几个商品}
 */
+ (void)goToActivityView:(NSDictionary *)paramDic;

/*!
 @abstract      去抢购列表页面
 @discussion    不需要参数
 */
+ (void)goToRushPurchaseList:(NSDictionary *)paramDic;

/*!
 @abstract      去抢购详情页面
 @discussion    参数 @{
 @"dto":PanicPurchaseDTO对象}
 */
+ (void)goToRushPurchaseDetail:(NSDictionary *)paramDic;

/*!
 @abstract      去榜单列表
 @discussion    不需要参数
 */
+ (void)goToBangDanList:(NSDictionary *)paramDic;

/*!
 @abstract      去分类列表
 @discussion    不需要参数
 */
+ (void)goToCategory:(NSDictionary *)paramDic;

/*!
 @abstract      去彩票
 @discussion    不需要参数
 */
+ (void)goToLottery:(NSDictionary *)paramDic;

/*!
 @abstract      去手机充值
 @discussion    不需要参数
 */
+ (void)goToMobileCharge:(NSDictionary *)paramDic;

/*!
 @abstract      去热门促销
 @discussion    不需要参数
 */
+ (void)goToHostSale:(NSDictionary *)paramDic;

/*!
 @abstract      去送货安装
 @discussion    不需要参数
 */
+ (void)goToDeliveryInstall:(NSDictionary *)paramDic;

/*!
 @abstract      去水电煤缴费
 @discussion    不需要参数
 */
+ (void)goToWaterElecGasCharge:(NSDictionary *)paramDic;

/*!
 @abstract      去浏览历史
 @discussion    不需要参数
 */
+ (void)goToBrowseHistory:(NSDictionary *)paramDic;

/*!
 @abstract      去我的收藏
 @discussion    不需要参数
 */
+ (void)goToMyFavorite:(NSDictionary *)paramDic;

/*!
 @abstract      去应用商店， ios暂不支持
 @discussion    不需要参数
 */
+ (void)goToAppStore:(NSDictionary *)paramDic;

/*!
 @abstract      去搜索
 @discussion    不需要参数
 */
+ (void)goToSearch:(NSDictionary *)paramDic;

/*!
 @abstract      去购物车
 @discussion    不需要参数
 */
+ (void)goToShopCart:(NSDictionary *)paramDic;

/*!
 @abstract      去我的易购
 @discussion    不需要参数
 */
+ (void)goToMyEbuy:(NSDictionary *)paramDic;

/*!
 @abstract      去商品详情
 @discussion    不需要参数
 */
+ (void)goToProductDetail:(NSDictionary *)paramDic;

/*!
 @abstract      去本地生活
 @discussion    不需要参数
 */
+ (void)goToLocalLife:(NSDictionary *)paramDic;

/*!
 @abstract      去声波
 @discussion    不需要参数
 */
+ (void)goToPlayVoice:(NSDictionary *)paramDic;
/*!
 @abstract      去彩票支付完成页面
 @discussion    参数如： com.suning.suningebuy://DGFQ?out_order_no=C1111005&total_fee=200&is_success=T&error=&desc=%E6%98%93%E4%BB%98%E5%AE%9D%E6%94%AF%E4%BB%98&payment=&balance_amount=200&detail=%3Csuning%3E%3Citem%3E%3Cout_item_no%3E50DG13090511116065_FQ11712973%3C%2Fout_item_no%3E%3Camount%3E200%3C%2Famount%3E%3C%2Fitem%3E%3C%2Fsuning%3E&sign=42a3fad64c7149a2a993156f8cb7d914&sign_type=md5
 */
+ (void)goToLotteryPayOkPage:(NSDictionary *)paramDic;
/**
 *  是否是我的易购的wap引流
 */
@property (nonatomic,assign)BOOL isWap;
/**
 *  是否是订单wap引流
 */
@property (nonatomic,assign)BOOL isWapOrder;
/**
 *  是否是搜索结果页面的wap引流
 */
@property (nonatomic,assign)NSInteger isWapSearch;
/**
 *  是否是商品详情的wap引流
 */
@property (nonatomic,assign)NSInteger isWapDetail;
@end
