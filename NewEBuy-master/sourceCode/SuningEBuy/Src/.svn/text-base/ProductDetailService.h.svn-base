//
//  ProductDetailService.h
//  SuningEBuy
//
//  Created by  on 12-9-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      ProductDetailService
 @abstract    商品详情的service, 1、请求商品详情， 2、加入收藏夹
 @author      刘坤
 @version     v1.0.001  12-9-10
 */

#import "DataService.h"
#import "DataProductBasic.h"
#import "BigSaleDTO.h"
#import "AppointmentDTO.h"

@class ProductDetailService;

@protocol ProductDetailServiceDelegate <NSObject>

@optional
- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess 
                                    errorMsg:(NSString *)errorMsg 
                               productDetail:(DataProductBasic *)product;


- (void)addToFavoriteCompletionWithResult:(BOOL)isSuccess 
                                 errorMsg:(NSString *)errorMsg
                                errorCode:(NSString *)errorCode;

- (void)getRecommendListCompletionWithResult:(BOOL)isSuccess
                                   errorCode:(NSString *)errorMsg
                                        list:(NSArray *)array;

- (void)getBigSaleProductCompletionWithResult:(BOOL)isSuccess
                                      service:(ProductDetailService *)service
                                     errorMsg:(NSString *)errorMsg
                                bigSaleDetail:(BigSaleDTO *)dto;

- (void)getAppointmentProductCompletionWithResult:(BOOL)isSuccess
                                          service:(ProductDetailService *)service
                                         errorMsg:(NSString *)errorMsg
                                appointmentDetail:(AppointmentDTO *)dto;

- (void)appointmentActionCompletionWithResult:(BOOL)isSuccess
                                     errorMsg:(NSString *)errorMsg;

- (void)scScodeActionCompletionWithResult:(BOOL)isSuccess
                           redirectStatus:(NSString *)redirectStatus
                                 errorMsg:(NSString *)errorMsg;

- (void)getIsSpotSupportedWithResult:(BOOL)isSucess;
@end




@interface ProductDetailService : DataService
{
    HttpMessage     *getProductDetailHttpMsg;
    HttpMessage     *addToFavoriteHttpMsg;
    HttpMessage     *getProductRecListHttpMsg;
    HttpMessage     *getProductBigSaleHttpMsg;
    HttpMessage     *getProductAppointmentHttpMsg;
    HttpMessage     *AppointmentActionHttpMsg;
    HttpMessage     *ScScodeActionHttpMsg;
    HttpMessage     *getProductSpotSupportHttpMsg;
}

@property (nonatomic, weak) id<ProductDetailServiceDelegate> delegate;
@property (nonatomic, assign) BOOL isRequestError;

@property (nonatomic, strong) NSString *djhActiveStatusStr;     //大聚惠当前状态

@property (nonatomic)   BOOL    isScProduct;    //是否是S码商品

/*!
 @abstract      请求商品详情
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含三个基本参数productCode, productId, cityCode
 */
- (void)beginGetProductDetailInfo:(DataProductBasic *)basicDto;

- (void)beginGetProductDetailInfoWithIsbn:(NSString *)isbn;

/*!
 @abstract      添加购物车
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含三个基本参数productCode, productId, cityCode
 */
- (void)beginAddToFavorite:(DataProductBasic *)basicDto;


//add by kb
/*!
 @abstract      请求推荐商品
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含两个基本参数productCode , cityCode
 */
- (void)beginGetProductRecommendList:(DataProductBasic *)basicDto;

/*!
 @abstract      请求大聚惠详情
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含两个基本参数productCode , vendorCode
 */
- (void)beginGetProductBigSaleInfo:(DataProductBasic *)basicDto;

/*!
 @abstract      请求预约详情
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含两个基本参数productCode , vendorCode
 */
- (void)beginGetProductAppointmentInfo:(DataProductBasic *)basicDto;

/*!
 @abstract      预约商品购买资格校验
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含两个基本参数productCode , vendorCode
 */
- (void)beginAppointmentAction:(DataProductBasic *)basicDto;

/*!
 @abstract      请求预约详情
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含两个基本参数productCode , vendorCode ， actionId
 */
- (void)beginScScodeProductBuyAction:(DataProductBasic *)basicDto;

/*!
 @abstract      请求是否支持附近现货
 @param         basicDto  包含请求参数的dto
 @discussion    参数dto中需要包含基本参数partnumber
 */
- (void)beginGetProductIsSpotSupported:(DataProductBasic *)basicDto;

@end
