//
//  payFlowDTO.m
//  SuningEBuy
//
//  Created by robin wang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "payFlowDTO.h"

@implementation payFlowDTO

@synthesize isPrepay = _isPrepay;
@synthesize eppPayPwd = _eppPayPwd;
@synthesize langId = _langId;
@synthesize orderId = _orderId;
@synthesize orderPlacerTel = _orderPlacerTel;
@synthesize policyId = _policyId; ////电话支付 @"11602"   /货到付款  11601
@synthesize prepay = _prepay;
@synthesize subpolicyid = _subpolicyid;
@synthesize subCodpolicyId = _subCodpolicyId;

@synthesize catalogId = _catalogId;
@synthesize storeId = _storeId;
@synthesize paymentLimitInfo = _paymentLimitInfo;
@synthesize accountBalance = _accountBalance;
@synthesize accountStatus = _accountStatus;
@synthesize supportCOD = _supportCOD;
@synthesize unSupportCODReason = _unSupportCODReason;
@synthesize supportPos = _supportPos;
@synthesize codUnacceptablePOSReason = _codUnacceptablePOSReason;
@synthesize supportCash = _supportCash;
@synthesize codUnacceptableCASHReason = _codUnacceptableCASHReason;


@synthesize isStoreAcceptable = _isStoreAcceptable;
@synthesize isPickUpAcceptable = _isPickUpAcceptable;
@synthesize storeUnacceptableCode = _storeUnacceptableCode;
@synthesize storeUnacceptableReason = _storeUnacceptableReason;


@synthesize productPrice = _productPrice;
@synthesize portage = _portage;
@synthesize payMode = _payMode;
@synthesize cashPayMode = _cashPayMode;

@synthesize verifyCode = _verifyCode;
@synthesize isNeedValidate = _isNeedValidate;

- (void)dealloc{
    
	TT_RELEASE_SAFELY(_isPrepay);
    TT_RELEASE_SAFELY(_eppPayPwd);
    TT_RELEASE_SAFELY(_langId);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderPlacerTel);
    TT_RELEASE_SAFELY(_policyId);
    TT_RELEASE_SAFELY(_prepay);
    TT_RELEASE_SAFELY(_subpolicyid);
    TT_RELEASE_SAFELY(_subCodpolicyId);
    
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_catalogId);
    TT_RELEASE_SAFELY(_paymentLimitInfo);
    
    TT_RELEASE_SAFELY(_accountBalance);
    TT_RELEASE_SAFELY(_accountStatus);
    TT_RELEASE_SAFELY(_supportCOD);
    TT_RELEASE_SAFELY(_unSupportCODReason);
    TT_RELEASE_SAFELY(_supportPos);
    TT_RELEASE_SAFELY(_codUnacceptablePOSReason);
    TT_RELEASE_SAFELY(_supportCash);
    TT_RELEASE_SAFELY(_codUnacceptableCASHReason);
    
    TT_RELEASE_SAFELY(_productPrice);
    TT_RELEASE_SAFELY(_portage);
    TT_RELEASE_SAFELY(_isNeedValidate);
}

+ (instancetype)payDTOWithOrder:(NSString *)orderId
{
    payFlowDTO *dto = [[payFlowDTO alloc] init];
    dto.orderId = orderId;
    dto.storeId = kHttpRequestHomeStoreValue;
    dto.catalogId = kHttpRequestHomeCatalogIdValue;
    dto.langId = @"-7";
    return dto;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    NSString *__accountBalance = [dic objectForKey:@"accountBalance"];
    NSString *__accountStatus = [dic objectForKey:@"accountStatus"];
    NSString *__codUnacceptableCASHReason = [dic objectForKey:@"codUnacceptableCASHReason"];
    NSString *__codUnacceptablePOSReason = [dic objectForKey:@"codUnacceptablePOSReason"];
    NSString *__orderId = [dic objectForKey:@"orderId"];
    NSString *__orderDiscount = [dic objectForKey:@"orderDiscount"];
    NSString *__paymentLimitInfo = [dic objectForKey:@"paymentLimitInfo"];
    NSString *__portage = [dic objectForKey:@"portage"];
    NSString *__productPrice = [dic objectForKey:@"productPrice"];
    NSString *__sunpackPrice = [dic objectForKey:@"sunpackPrice"];
    NSString *__supportCOD = [dic objectForKey:@"supportCOD"];
    NSString *__supportCash = [dic objectForKey:@"supportCash"];
    NSString *__supportPos = [dic objectForKey:@"supportPos"];
    NSString *__unSupportCODReason = [dic objectForKey:@"unSupportCODReason"];
    NSString *__isNeedValidate = [dic objectForKey:@"needValidate"];
    
    if (NotNilAndNull(__orderId))   self.orderId = __orderId;
    float productPrice = [__productPrice floatValue];//B2C 回过来的优惠前的价格
    float sunpackPrice = [__sunpackPrice floatValue];//B2C 回过来的阳光包价格
    float portage = [__portage floatValue];//B2C 回过来的运费
    float minusPrice = [__orderDiscount floatValue];//优惠的价格            
    float totalPrice = productPrice + sunpackPrice +  portage - minusPrice;          
    NSString *prepayStr = [[NSNumber numberWithFloat:totalPrice] stringValue];
    self.productPrice = NotNilAndNull(__productPrice)?__productPrice:@"";
    self.portage = NotNilAndNull(__portage)?__portage:@"";
    self.prepay = prepayStr;

    
    if (NotNilAndNull(__accountBalance))   self.accountBalance = __accountBalance;
    if (NotNilAndNull(__accountStatus))   self.accountStatus = __accountStatus;
    if (NotNilAndNull(__codUnacceptableCASHReason))   self.codUnacceptableCASHReason = __codUnacceptableCASHReason;
    if (NotNilAndNull(__codUnacceptablePOSReason))   self.codUnacceptablePOSReason = __codUnacceptablePOSReason;
   
    self.isCOrder = [EncodeNumberFromDic(dic, @"isCOrder") boolValue];

    if (NotNilAndNull(__paymentLimitInfo))
    {
        self.paymentLimitInfo = __paymentLimitInfo;
    }
  /*  if (self.isCOrder)
    {
        self.paymentLimitInfo = @"您的订单已提交成功，如果暂不支付，可稍后至网站支付";
    }*/
    if (NotNilAndNull(__supportCOD))   self.supportCOD = __supportCOD;
    if (NotNilAndNull(__supportCash))   self.supportCash = __supportCash;
    if (NotNilAndNull(__supportPos))   self.supportPos = __supportPos;
    if (NotNilAndNull(__unSupportCODReason))   self.unSupportCODReason = __unSupportCODReason;
    if(NotNilAndNull(__isNeedValidate)) self.isNeedValidate  = __isNeedValidate;
    
    self.isStoreAcceptable = EncodeStringFromDic(dic, @"isStoreAcceptable");
    self.isPickUpAcceptable = EncodeStringFromDic(dic, @"isPickUPAcceptable");
    self.storeUnacceptableCode = EncodeStringFromDic(dic, @"storeUnacceptableCode");
    self.storeUnacceptableReason = EncodeStringFromDic(dic, @"storeUnacceptableReason");
    
}

- (BOOL)isEfubaoBanlanceEnough
{
    DLog(@"prepay:%f", [self.prepay doubleValue]);
    DLog(@"accountBalance:%f", [self.accountBalance doubleValue]);    
    
    if ([self.prepay doubleValue] <= [self.accountBalance doubleValue])
    {
        return YES;
    }
    return NO;
}

- (void)setPayMode:(PayMode)payMode
{
    _payMode = payMode;
    switch (_payMode) {
        case PayModeCashOnDelivery:
        {
            self.policyId = @"11601";
            break;
        }
        case PayModeEfubao:
        {
            self.policyId = @"11608";
            self.subpolicyid = @"15501";
            self.isPrepay = @"true";
            break;
        }
        case PayModeHuiFuWeb:
        {
            self.policyId = @"11611";
            self.subpolicyid = @"18001";
            break;
        }
        case PayModeUnSelect:
        case PayModeUPPay1_0:
        {
            self.policyId = @"11611";
            self.subpolicyid =  @"18002";
            self.isPrepay = @"false";
            break;
        }
        case PayModeOnStore:
        {
            if ([self.isStoreAcceptable isEqualToString:@"1"])
            {
                self.policyId = @"11701";
            }else if([self.isPickUpAcceptable isEqualToString:@"1"])
            {
                self.policyId = @"11601";
            }
            break;
        }
        case PayModeUPPay2_0:
        {
            self.policyId = @"11611";
            self.subpolicyid =  @"18003";
            break;
        }
        case PayModeCyberPay:
        {
            self.policyId = @"11611";
            self.subpolicyid =  @"18004";
            break;
        }
        case PayModeWebEfubao:
        {
            self.policyId = @"11613";
            self.subpolicyid = @"20001";
            break;
        }
        case PayModeCard2OnLine:
        {
            self.policyId = @"11613";
            self.subpolicyid = @"20001";
            break;
        }
        case PayModeCard2OnStore:
        {
            self.policyId = @"11701";
            self.subpolicyid = @"20001";
            break;
        }
        case PayModeCard2CashOnDelivery:
        {
            self.policyId = @"11601";
            self.subpolicyid = @"20001";
            break;
        }
        case PayModeSNSDK:
        {
            self.policyId = @"11613";
            self.subpolicyid = @"20001";
            break;
        }
        default:
        {
            self.policyId = nil;
            self.subpolicyid = nil;
            self.subCodpolicyId = nil;
            break;
        }
    }
    
    if (_payMode == PayModeEfubao || _payMode == PayModeWebEfubao)
    {
        self.isPrepay = @"true";
    }else{
        self.isPrepay = @"false";
    }
}

- (void)setCashPayMode:(CashOnDeliveryPayMode)cashPayMode
{
    _cashPayMode = cashPayMode;
    switch (_cashPayMode) {
        case CashOnDeliveryPhonePay:
            self.subCodpolicyId = @"01";
            break;
        case CashOnDeliveryPOSPay:
            self.subCodpolicyId = @"02";
            break;
        case CashOnDeliveryCashPay:
            self.subCodpolicyId = @"03";
            break;
        case CashOnDeliveryMention:
            self.subCodpolicyId = @"04";
            break;
        case CashOnDeliveryStore:
            self.subCodpolicyId = @"05";
            break;
        case CashOnDeliveryUnSelect:
            self.subCodpolicyId = nil;
            break;
        default:
            break;
    }
}

@end
