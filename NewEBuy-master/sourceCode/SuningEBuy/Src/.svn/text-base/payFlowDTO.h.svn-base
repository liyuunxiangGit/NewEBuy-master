//
//  payFlowDTO.h
//  SuningEBuy
//
//  Created by robin wang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
/*!
 @header      payFlowDTO
 @abstract    支付信息的DTO
 @author      刘坤修改
 @version     v1.0  12-9-29
 */

#import <Foundation/Foundation.h>

/*!
 @abstract  支付方式
 */
typedef enum {
    PayModeUnSelect        = -1,     //未选择
    PayModeCashOnDelivery  = 0,  //货到付款  11601
    PayModeEfubao          = 1,  //易付宝支付  11608  15501          abandon at v2.2.6,replace by PayModeWebEfubao
    PayModeHuiFuWeb        = 4,  //汇付天下网页支付 11611   18001
    PayModeUPPay1_0        = 2,  //银联支付1.0
    PayModeOnStore         = 3, //门店支付
    PayModeWebEfubao       = 5, //web收银台   11613   20001
    PayModeUPPay2_0        = 6, //银联支付2.0
    PayModeCyberPay        = 7, //中信异度支付
    PayModeSNSDK           = 8,//易付宝sdk支付
    
    PayModeCard2CashOnDelivery = 9,
    PayModeCard2OnLine         = 10, //在线支付
    PayModeCard2OnStore        = 11, //门店支付
}PayMode;

/*!
 @abstract  货到付款的支付方式
 */
typedef enum {
    CashOnDeliveryUnSelect = -1,    //
    CashOnDeliveryPhonePay = 0,     //货到付款电话支付
    CashOnDeliveryPOSPay   = 1,     //货到付款POS机刷卡支付
    CashOnDeliveryCashPay  = 2,     //货到付款现金支付
    CashOnDeliveryMention  = 3,     //门店支付 自提
    CashOnDeliveryStore    = 4      //门店支付 
}CashOnDeliveryPayMode;

@interface payFlowDTO : NSObject
{
    NSString *_eppPayPwd;//password
    NSString *_isPrepay;
    NSString *_langId;
    NSString *_orderId;
    NSString *_orderPlacerTel;
    NSString *_policyId;
    NSString *_prepay; 
    NSString *_subCodpolicyId;
    NSString *_subpolicyid;
    
    NSString *_catalogId;
    NSString *_storeId;
    NSString *_accountBalance;//易付宝余额
    NSString *_accountStatus;//易付宝状态 0未激活，1激活，2未完善资料
    NSString *_supportCOD;//是否支付货到付款
    NSString *_unSupportCODReason;//不支持货到付款的原因
    NSString *_supportPos;//是否支持pos机货到支付
    NSString *_codUnacceptablePOSReason;//不支持pos机支付的原因
    NSString *_supportCash;//是否支持现金支付
    NSString *_codUnacceptableCASHReason;//不支持现金支付的原因
    NSString *_paymentLimitInfo;
    
    NSString *_productPrice;
    NSString *_portage;
    
    PayMode  _payMode;
    CashOnDeliveryPayMode _cashPayMode;
    
    NSString  *verifyCode;  //超过200，支付验证码
    NSString  *isNeedValidate;
}

@property (nonatomic, copy) NSString *eppPayPwd;
@property (nonatomic, copy) NSString *isPrepay;
@property (nonatomic, copy) NSString *langId;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *policyId;
@property (nonatomic, copy) NSString *orderPlacerTel;
@property (nonatomic, copy) NSString *prepay;
@property (nonatomic, copy) NSString *subCodpolicyId;
@property (nonatomic, copy) NSString *subpolicyid;

@property (nonatomic, copy) NSString *catalogId;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *paymentLimitInfo;
@property (nonatomic, copy) NSString *accountBalance;
@property (nonatomic, copy) NSString *accountStatus;
@property (nonatomic, copy) NSString *supportCOD;
@property (nonatomic, copy) NSString *unSupportCODReason;
@property (nonatomic, copy) NSString *supportPos;
@property (nonatomic, copy) NSString *codUnacceptablePOSReason;
@property (nonatomic, copy) NSString *supportCash;
@property (nonatomic, copy) NSString *codUnacceptableCASHReason;

@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, copy) NSString *portage;

@property (nonatomic, assign) PayMode payMode;
@property (nonatomic, assign) CashOnDeliveryPayMode cashPayMode;

@property (nonatomic, strong) NSString *verifyCode;

@property (nonatomic, copy) NSString *isNeedValidate;

@property (nonatomic, copy) NSString *isStoreAcceptable;//1可以门店支付 0不可以门店支付
@property (nonatomic, copy) NSString *isPickUpAcceptable;//1可以货到付款门店自提 0不可以货到付款门店自提
@property (nonatomic, copy) NSString *storeUnacceptableCode;//不支持门店支付原因错误码
@property (nonatomic, copy) NSString *storeUnacceptableReason;//不支持门店支付原因

@property (nonatomic, assign) BOOL    isCOrder;

+ (instancetype)payDTOWithOrder:(NSString *)orderId;

- (void)encodeFromDictionary:(NSDictionary *)dic;

- (BOOL)isEfubaoBanlanceEnough;

@end
