//
//  PayFlowService.h
//  SuningEBuy
//
//  Created by  on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      PayFlowService
 @abstract    支付流程的service
 @author      刘坤
 @version     v1.0  12-9-28
 */

#import "DataService.h"
#import "StoreInfoDto.h"
#import "AddressInfoDTO.h"
#import "GiftCouponDTO.h"
#import "payFlowDTO.h"
#import "ShopCartV2Service.h"
#import "InsendTimeDTO.h"

/*!
 @abstract  配送方式，分两种，苏宁配送和用户自提
 */
typedef enum {
    ShipModeSuningSend = -1,       //苏宁配送
    ShipModeSelfTake   = -2        //用户自提
}ShipMode;

typedef enum {
    paymentChoose = 1,
    submitInfo,
    saveCardAndCoupon
}ParseSubmitInfoType;

#define SHOPPINGCART_ITEMTYPE_NORMAL             @"NORMALPRODUCT"
#define SHOPPINGCART_ITEMTYPE_SMALLPACKAGE       @"SMALLPACKAGE"
#define SHOPPINGCART_ITEMTYPE_ACCESSORY          @"ACCESSORYPACKAGE"

@class PayFlowService;

@protocol PayFlowServiceDelegate <NSObject>

@optional

/*!
 @abstract      提交订单接口发送完成的回调方法
 @param         isSuccess  是否提交订单成功
 @param         errorMsg   失败时的错误信息
 @param         dto  接口返回后组装完成的支付信息的dto,当dto为空时，直接支付成功
 */
- (void)submitOrderCompletionWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg
                                 payDTO:(payFlowDTO *)dto;

/*!
 @abstract      确认支付完成的回调方法
 @param         isSuccess  是否支付成功
 @param         errorMsg  支付失败的错误信息
 */
- (void)paySubmitCompletionWithResult:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg
                          punchoutUrl:(NSURL *)url
                         punchoutForm:(NSString *)xml
                            sdkstring:sdkstring;

/*!
 @abstract      获取用户最近配送、自提信息完成的回调方法
 @param         isSuccess   是否获取成功
 @param         errorMsg    失败描述
 @param         shipMode    最后选择的配送方式
 @param         pickUpInfo  最近使用的自提点
 @param         shipInfo    最近使用的配送地址
 */
- (void)getLastShipInfoCompletionWithResult:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg
                               lastShipMode:(ShipMode)shipMode
                             lastPickUpInfo:(StoreInfoDto *)pickUpInfo
                               lastShipInfo:(AddressInfoDTO *)shipInfo;
/*!
 @abstract      保存配送地址发送完成的回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         dto  接口返回后组装完成的支付信息的dto,当dto为空时，直接支付成功
 */
- (void)saveDeliveryAndAddressCompletionWithResult:(BOOL)isSuccess
                                          service:(PayFlowService *)service
                                            payDTO:(payFlowDTO *)dto
                                         errorCode:(NSString *)errorCode;

/*!
 @abstract      获取返回的支付方式回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         dto  接口返回后组装完成的支付信息的dto,当dto为空时，直接支付成功
 */
- (void)paymentChooseCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
                                   payDTO:(payFlowDTO *)dto;

/*!
 @abstract      确认支付方式回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         dto  接口返回后组装完成的支付信息的dto,当dto为空时，直接支付成功
 */
- (void)savePayMethodCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
                                   payDTO:(payFlowDTO *)dto;

/*!
 @abstract      确认券、卡回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         dto  接口返回后组装完成的支付信息的dto,当dto为空时，直接支付成功
 */
- (void)saveCardAndCouponCompletionWithResult:(BOOL)isSuccess
                                     errorMsg:(NSString *)errorMsg
                                       payDTO:(payFlowDTO *)dto;

/*!
 @abstract      查询使用运钻发送完成的回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         cloudDiamond     用户云钻总额
 @param         cloudDiamondPay  用户云钻抵现总额
 */
- (void)getCloudDiamondCompletionWithResult:(BOOL)isSuccess
                                    service:(PayFlowService *)service
                               cloudDiamond:(NSString *)cloudDiamond
                            cloudDiamondPay:(NSString *)cloudDiamondPay
                                   errorMsg:(NSString *)errorMsg;

/*!
 @abstract      查询送货时间发送完成的回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         dto        送货时间数据源
 */
- (void)getDelAndTimeCompletionWithResult:(BOOL)isSuccess
                            insendTimeDto:(InsendTimeDTO *)dto
                                 errorMsg:(NSString *)errorMsg;

/*!
 @abstract      查询安装时间发送完成的回调方法
 @param         isSuccess  是否成功
 @param         errorMsg   失败时的错误信息
 @param         dto        安装时间数据源
 */
- (void)getInstallDateCompletionWithResult:(BOOL)isSuccess
                            installDateArr:(NSArray *)installDateArr
                                  errorMsg:(NSString *)errorMsg;
@end


@interface PayFlowService : DataService <ShopCartV2ServiceDelegate>
{
    HttpMessage     *submitOrderHttpMsg;
    HttpMessage     *paySubmitHttpMsg;
    HttpMessage     *lastShipInfoHttpMsg;
    
    HttpMessage     *confirmDeliveryAddressHttpMsg;
    HttpMessage     *paymentChooseHttpMsg;
    HttpMessage     *savePayMethoHttpMsg;
    
    HttpMessage     *saveCardAndCouponHttpMsg;
    
    HttpMessage     *getAndUseCloudDiamondMsg;
    HttpMessage     *getDelAndInsTimeMsg;
    HttpMessage     *getInstallTimeMsg;
}

@property (strong) NSMutableArray *shopCartItemList;
@property (nonatomic, strong) NSNumber *productAllPrice; //总价格
@property (nonatomic, strong) NSNumber *userPayAllPrice; //应付总金额
@property (nonatomic, strong) NSNumber *sunpgkPrice; //阳光包金额
@property (nonatomic, strong) NSNumber *totalDiscount; //折扣价格
@property (nonatomic, strong) NSNumber *totalShipPrice; //总运费

@property (nonatomic, assign) BOOL      canUseEleInvoice;       //是否可用电子发票
@property (nonatomic, assign) BOOL      eleInvoiceIsDefault;    //电子发票是否可默认

@property (nonatomic, weak) id<PayFlowServiceDelegate> delegate;

@property (nonatomic, assign) BOOL              canTake;
@property (nonatomic, strong) ShopCartV2Service *shopCartService;

@property (nonatomic, strong) StoreInfoDto *storeInfoDto;
@property (nonatomic, strong) AddressInfoDTO *addressInfoDto;


/*!
 @abstract      提交订单的接口请求发送
 @discussion    在结算信息页面点击提交订单时发送
 @param         shipMode   配送方式
 @param         addressId  配送地址id，在shipMode=-1时传入
 @param         storeInfo  门店信息，在shipMode=-2时传入
 @param         ivoice     发票抬头
 @param         couponList 使用的易购券列表  不传入时默认不使用易购券
 */
- (void)beginSubmitOrderRequest:(ShipMode)shipMode
                    addressInfo:(AddressInfoDTO *)addressInfo
                      storeInfo:(StoreInfoDto *)storeInfo
                        invoice:(NSString *)invoice
                    invoiceType:(NSString *)invoiceType
                        ecoupon:(NSArray *)couponList
                     codeString:(NSString *)codeString
                 orderRemarkStr:(NSString *)orderRemarkStr;
;


/*!
 @abstract      确认支付的接口请求发送
 @param         payDTO  包含支付信息的dto
 */
- (void)beginPaySubmitRequest:(payFlowDTO *)payDTO;

/*!
 @abstract      获取用户最近的配送或自提信息
 */
- (void)beginGetLastShipInfoRequest;

/*!
 @abstract      确认地址
 */
- (void)beginConfirmDeliveryAddressRequest:(ShipMode)shipMode
                               addressInfo:(AddressInfoDTO *)addressInfo
                                 storeInfo:(StoreInfoDto *)storeInfo;
/*!
 @abstract      可支持的支付方式
 */
- (void)beginGetPaymentChooseInfoRequest;

/*!
 @abstract      确认支付方式
 */
- (void)beginSavePayMethodRequest:(NSString *)payMethod
                     subPayMethod:(NSString *)subPayMethod;

/*!
 @abstract      确认券
 */
- (void)beginSaveCardAndCouponRequest:(NSString *)allianceFlag
                              ecoupon:(NSArray *)couponList
                           codeString:(NSString *)codeString;

/*!
 @abstract      使用云钻抵现，查询云钻
 @param         isCloudDiamondUsed  云钻使用标示符 (1使用，0不使用,2查询)

 */
- (void)beginGetCloudDiamond:(NSString *)isCloudDiamondUsed;

/*!
 @abstract      获取配送时间
 @param         storeId         商店id       固定值10052
 @param         catalogId       商品目录id    固定值10052
 */
- (void)beginGetDelAndInsTime;

/*!
 @abstract      获取安装时间
 @param         storeId         商店id       固定值10052
 @param         catalogId       商品目录id    固定值10052
 @param         deliverTime     配送日期
 @param         dayTime         配送时间
 @param         orderItemIds    订单行号
 */
- (void)beginGetInstallDateWithdeliverTime:(NSString *)deliverTime dayTime:(NSString *)dayTime orderItemIds:(NSString *)orderItemIds;

@end
