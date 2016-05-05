//
//  ProductUtil.h
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProductBasic.h"

typedef enum {
    ProductImageSize30x30       = 30,
    ProductImageSize60x60       = 60,
    ProductImageSize100x100     = 100,
    ProductImageSize120x120     = 120,
    ProductImageSize160x160     = 160,
    ProductImageSize200x200     = 200,
    ProductImageSize400x400     = 400,
    ProductImageSize800x800     = 800
}ProductImageSize;

@interface ProductUtil : NSObject

/*!
 @abstract      根据商品编码和图片规格大小，获取商品的第一张图的url
 @discussion    类方法，直接调用
 示例：productCode＝000000000103126617
 http://image.suning.cn/b2c/catentries/000000000103126617_1_SIZExSIZE.jpg
 @param         code  商品编码
 @param         size  图片规格
 @result        第一张图的url
 */
+ (NSURL *)getImageUrlWithProductCode:(NSString *)code size:(ProductImageSize)size;



/*!
 @abstract      根据商品详情dto，获取商品的图片URL的列表
 @discussion    类方法，直接调用
 示例：productCode＝000000000103126617  N：第几张图片， size：图片规格
 http://image.suning.cn/b2c/catentries/000000000103126617_N_SIZExSIZE.jpg
 @param         item  商品详情dto， 用到productCode 和 imageNum
 @param         size  图片规格
 @result        图的urlList
 */
+ (NSArray *)getImageUrlListWithProduct:(DataProductBasic *)item size:(ProductImageSize)size;

/*!
 @abstract      根据商品id获取商品价格图片的URL
 @discussion    类方法，直接调用
 示例：productId＝1601628  cityId=9173
 http://price1.suning.cn/webapp/wcs/stores/prdprice/1601628_9173_10052_10-3.png
 @param         proId  商品id
 @param         cityId  城市编码
 @result        第一张图的url
 */
+ (NSURL *)priceImageUrlOfProductId:(NSString *)proId city:(NSString *)cityId;

#pragma mark - 通码价格图片
//根据商品通码获取价格图片
+ (NSURL *)getPriceImageUrlWithPartNumber:(NSString *)partnumber city:(NSString *)cityId;

+ (NSURL *)minPriceImageOfPartNumber:(NSString *)partnumber city:(NSString *)cityId;

#pragma mark -
/*!
 @abstract      根据商品id获取商家数目图片的URL
 @discussion    类方法，直接调用
 示例：productId＝1601628  cityId=9173
 http://price1.suning.cn/webapp/wcs/stores/prdprice/1601628_9173_10001_10-3.png
 @param         proId  商品id
 @param         cityId  城市编码
 @result        第二张图的url
 */

+ (NSURL *)supplierNumImageOfProductId:(NSString *)proId city:(NSString *)cityId;

/*!
 @abstract      根据商品id获取商品最低价格图片的URL
 @discussion    类方法，直接调用
 示例：productId＝1601628  cityId=9173
 http://price1.suning.cn/webapp/wcs/stores/prdprice/1601628_9173_10002_10-3.png
 @param         proId  商品id
 @param         cityId  城市编码
 @result        第三张图的url
 */

+ (NSURL *)minPriceImageOfProductId:(NSString *)proId city:(NSString *)cityId;

/**
 *  获取商品最低价格，逻辑是：若shopCode为空，则取最优商家;若shopCode为“0000000000”,则获取苏宁自营的商品价格;若shopCode为C店，则返回指定C店的商品价格(使用商品编码来组合url)
 *
 *  @param proId    商品ID
 *  @param proCode  商品编码
 *  @param cityId   城市ID
 *  @param shopCode 供应商编码
 *
 *  @return 商品价格图片URL
 */
+ (NSURL *)minPriceImageOfProductId:(NSString *)proId productCode:(NSString *)proCode city:(NSString *)cityId shopCode:(NSString *)shopCode;

/*!
 @abstract      根据商品id获取商品最优价格图片的URL
 @discussion    类方法，直接调用
 示例：productId＝1601628  cityId=9173
 http://price1.suning.cn/webapp/wcs/stores/prdprice/1601628_9173_10000_10-3.png
 @param         proId  商品id
 @param         cityId  城市编码
 @result        第一张图的url
 */

+ (NSURL *)bestPriceImageOfProductId:(NSString *)proId city:(NSString *)cityId;


/*!
 @abstract      商品详情DTO获取手机商品详情的链接
 @discussion    类方法，直接调用
 @param         product  商品详情dto
 @param         size  图片规格
 @result        m.suning.com的url
 */
+ (NSURL *)mobileWebSuningUrlWithProduct:(DataProductBasic *)product;


@end




#pragma mark ----------------------------- Deprecated (废弃的方法）
//废弃的方法
@interface ProductUtil(SNDeprecated)


+ (NSURL *)imageUrl_ls_ForProduct:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

+ (NSURL *)imageUrl_ls1_ForProduct:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据商品详情的dto获取商品的小图url列表
 @discussion    类方法，直接调用
 @param         item  商品详情dto
 @result        小图url的list
 */
+ (NSArray *)getSmallImageUrlList:(DataProductBasic *)item __attribute__((deprecated("Use -getImageUrlListWithProduct:size: instead")));


/*!
 @abstract      根据商品详情的dto获取商品的第一张小图的url
 @discussion    类方法，直接调用，在商品详情页面的动画需要到
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/fullimage/000000000103126617_1.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getFirstSmallImageUrl:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据商品详情的dto获取商品的大图url列表
 @discussion    类方法，直接调用
 @param         item  商品详情dto
 @result        大图url的list getImageUrlListWithProduct
 */
+ (NSArray *)getBigImageUrlList:(DataProductBasic *)item __attribute__((deprecated("Use -getImageUrlListWithProduct:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取图片的url
 @discussion    类方法，直接调用，参考大小400*400
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/fullimage/000000000103126617_1.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_fullimage_1:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取图片的url
 @discussion    类方法，直接调用，参考大小800*800
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/fullimage/000000000103126617_1f.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_fullimage_1f:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取图片的url
 @discussion    类方法，直接调用，参考大小60*60
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/000000000103126617_tn.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_tn:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取图片的url
 @discussion    类方法，直接调用，参考大小100*100
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/000000000103126617_ls.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_ls:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取图片的url
 @discussion    类方法，直接调用，参考大小160*160
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/000000000103126617_ls1.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_ls1:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取辅图图片的url
 @discussion    类方法，直接调用，参考大小400*400
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/fullimage/000000000103126617_2.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_fullimage_2:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));

/*!
 @abstract      根据获取商品的partnumber获取图片的url
 @discussion    类方法，直接调用，参考大小800*800
 示例：productCode＝000000000103126617
 http://image.suning.cn/content/catentries/00000000010312/000000000103126617/fullimage/000000000103126617_2f.jpg
 @param         productCode  商品详情dto
 @result        第一张小图的url
 */
+ (NSURL *)getImageUrl_fullimage_2f:(NSString *)productCode __attribute__((deprecated("Use -getImageUrlWithProductCode:size: instead")));


@end

