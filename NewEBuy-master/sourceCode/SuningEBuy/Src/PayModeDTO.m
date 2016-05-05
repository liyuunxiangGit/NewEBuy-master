//
//  PayModeDTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PayModeDTO.h"
#import "SNSwitch.h"

@implementation PayModeDTO

+ (PayModeDTO *)POSOnDeliveryDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCashOnDelivery;
    dto.mainDesc = [NSString stringWithFormat:@"%@——%@",L(@"PFCashOnDelivery"),L(@"PFPayByCard")];
    dto.detailDesc = L(@"PFOnlyNeedSwingCard");
    dto.detailUnsupportDesc = payDTO.unSupportCODReason.length?payDTO.unSupportCODReason:L(@"PFDonotSupportCashOnDelivery");
    if ([payDTO.supportCOD isEqualToString:@"false"])      //  不支持货到付款
    {
        dto.supportPay = NO;
    }
    else    // 支持货到付款
    {
        dto.supportPay = YES;
        
        dto.subPayMode = CashOnDeliveryPOSPay;
        dto.detailUnsupportDesc = payDTO.codUnacceptablePOSReason.length?payDTO.codUnacceptablePOSReason:L(@"PFDonotSupportPayByCard");
        if ([payDTO.supportPos isEqualToString:@"false"]) // 不支持刷卡支持
        {
            dto.supportPay = NO;
        }
        else
        {
            dto.supportPay = YES;
        }
    }
    return dto;
}

+ (PayModeDTO *)cashOnDeliveryDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCashOnDelivery;
    dto.mainDesc = [NSString stringWithFormat:@"%@——%@",L(@"PFCashOnDelivery"),L(@"PFCash")];
    dto.detailDesc = L(@"PFCanPayByCash");
    dto.detailUnsupportDesc = payDTO.unSupportCODReason.length?payDTO.unSupportCODReason:L(@"PFDonotSupportCashOnDelivery");
    if ([payDTO.supportCOD isEqualToString:@"false"])      //  不支持货到付款
    {
        dto.supportPay = NO;
    }
    else    // 支持货到付款
    {
        dto.supportPay = YES;
        //现金支付
        dto.subPayMode = CashOnDeliveryCashPay;
        dto.detailUnsupportDesc = payDTO.codUnacceptableCASHReason.length?payDTO.codUnacceptableCASHReason:L(@"PFDonotSupportPayByCash");
        if ([payDTO.supportCash isEqualToString:@"false"]) // 不支持刷卡支持
        {
            dto.supportPay = NO;
        }
        else
        {
            dto.supportPay = YES;
        }
    }
    return dto;
}

//易付宝支付方式
+ (PayModeDTO *)efubaoDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeEfubao;
    dto.mainDesc = L(@"choosePayWayFor30");
    dto.detailDesc = L(@"choosePayWayFor31");
    
    // 2.是否支持易付宝支付的逻辑判断，如果不支持，则将错误信息保存到对应的变量
    if ([self isEppActive])
    {
        // 易付宝余额不足
        if (![payDTO isEfubaoBanlanceEnough])
        {
            NSString *errorInfoy = [NSString stringWithFormat:@"%@,%@: %@ %@",
                                    L(@"Insufficient efubao balance"),L(@"PFCurrentBalance"),
                                    payDTO.accountBalance,
                                    L(@"Constant_RMB")];
            dto.detailUnsupportDesc = errorInfoy;
            dto.supportPay = NO;
        }
        else
        {
            dto.supportPay = YES;
        }
    }
    else
    {
        // 易付宝尚未激活
        dto.detailUnsupportDesc = L(@"PFEfubaoUnactivatedAndGoToMyEfubao");
        dto.supportPay = NO;
    }
    return dto;
}

//web收银台支付方式
+ (PayModeDTO *)webEfubaoDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeWebEfubao;
    dto.mainDesc = L(@"PFPayByEfubao");
    
    //如果开关配置了描述文字
    NSString *detailLbl_dic6 = [SNSwitch webEppPaymodeDesc];
    if (detailLbl_dic6.length)
    {
        dto.detailDesc = detailLbl_dic6;
    }
    else
    {
        dto.detailDesc = L(@"PFSupportEfubaoBalanceFastAndOtherPayment");
    }
    
    // 如果还需要判断易付宝是否激活
    if ([SNSwitch isOpenWebEppPayCheckEppStatus] && ![self isEppActive])
    {
        // 易付宝尚未激活
        dto.detailUnsupportDesc = L(@"PFEfubaoUnactivatedAndGoToMyEfubao");
        dto.supportPay = NO;
    }
    else
    {
        dto.supportPay = YES;
    }
    return dto;
}

//银联2.0
+ (PayModeDTO *)uppay2_0DTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeUPPay2_0;
    dto.mainDesc = L(@"PFUnionPayMobilePhonePayment");
    
    //开关中是否配置了描述文字
    NSString *detailLbl_dic7 = [SNSwitch unionPaymodeDesc];
    if (detailLbl_dic7.length)
    {
        dto.detailDesc = detailLbl_dic7;
    }
    else
    {
        dto.detailDesc = L(@"support bank card");
    }
    
    /* 刘坤，2.3.3版本开始支持c店支付 replace with dto.supportPay = YES;
     if (payDTO.isCOrder) {
     dto.supportPay = NO;
     dto.detailUnsupportDesc = @"对不起，您订单中的商品暂不支持银联支付";
     }else{
     dto.supportPay = YES;
     }
     */
    dto.supportPay = YES;
    
    return dto;
}


//易付宝sdk支付
+ (PayModeDTO *)SNPaySDkDTO:(payFlowDTO *)payDTO{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeSNSDK;
    dto.mainDesc = L(@"PFPayByEfubao");
    
    
    //如果开关配置了描述文字
    NSString *detailLbl_dic6 = [SNSwitch SNPaySDKDesc];
    if (detailLbl_dic6.length)
    {
        dto.detailDesc = detailLbl_dic6;
    }
    else
    {
        dto.detailDesc = @"support bank card";
    }
    
    // 如果还需要判断易付宝是否激活
    if ([SNSwitch isOpenSDKEppPayCheckEppStatus] && ![self isEppActive])
    {
        // 易付宝尚未激活
        dto.detailUnsupportDesc = L(@"PFEfubaoUnactivatedAndGoToMyEfubao");
        dto.supportPay = NO;
    }
    else
    {
        dto.supportPay = YES;
    }
    return dto;
}

//门店支付
+ (PayModeDTO *)onStoreDTO:(payFlowDTO *)payDTO shipMode:(ShipMode)shipMode
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeOnStore;
    dto.mainDesc = L(@"PFSuningStorePay");
    
    if (shipMode == ShipModeSuningSend)
    {
        dto.detailDesc = L(@"PFSubmitOrderAndPayInAnySuningStore");
        
        if ([payDTO.isStoreAcceptable isEqualToString:@"1"]) {
            dto.supportPay = YES;
        }else{
            dto.supportPay = NO;
        }
    }else{
        dto.detailDesc = L(@"PFSubmitOrderAndTakeInStore");
        
        if ([payDTO.isPickUpAcceptable isEqualToString:@"1"]) {
            dto.supportPay = YES;
        }else{
            dto.supportPay = NO;
        }
    }
    dto.detailUnsupportDesc = payDTO.storeUnacceptableReason.length?payDTO.storeUnacceptableReason:L(@"PFDonotSupportPayInStore");
    return dto;
}

//异度支付
+ (PayModeDTO *)cyberPayDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCyberPay;
    dto.mainDesc = L(@"PFDiversityPayment");
    
    //开关中是否配置了描述文字
    NSString *detailLbl_dic7 = [SNSwitch cyberPaymodeDesc];
    if (detailLbl_dic7.length)
    {
        dto.detailDesc = detailLbl_dic7;
    }
    else
    {
        dto.detailDesc = L(@"PFSafeConvenientSupportAllBankPayment");
    }
    
    /* 刘坤，2.3.3版本开始支持c店支付 replace with dto.supportPay = YES;
     if (payDTO.isCOrder) {
     dto.supportPay = NO;
     dto.detailUnsupportDesc = @"对不起，您订单中的商品暂不支持异度支付";
     }else{
     dto.supportPay = YES;
     }
     */
    dto.supportPay = YES;
    
    dto.isNew = YES;
    return dto;
}


//购物车2门店支付
+ (PayModeDTO *)onStoreCard2DTO:(payFlowDTO *)payDTO shipMode:(ShipMode)shipMode
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCard2OnStore;
    dto.mainDesc = L(@"PFSuningStorePay");
    
    if (shipMode == ShipModeSuningSend)
    {
        dto.detailDesc = L(@"PFSubmitOrderAndPayInAnySuningStore");
        
        if ([payDTO.isStoreAcceptable isEqualToString:@"1"]) {
            dto.supportPay = YES;
        }else{
            dto.supportPay = NO;
        }
    }else{
        dto.detailDesc = L(@"PFSubmitOrderAndTakeInStore");
        
        if ([payDTO.isPickUpAcceptable isEqualToString:@"1"]) {
            dto.supportPay = YES;
        }else{
            dto.supportPay = NO;
        }
    }
    dto.detailUnsupportDesc = payDTO.storeUnacceptableReason.length?payDTO.storeUnacceptableReason:L(@"PFDonotSupportPayInStore");
    return dto;
}

//购物车2POS支付
+ (PayModeDTO *)POSCard2OnDeliveryDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCard2CashOnDelivery;
    dto.mainDesc = [NSString stringWithFormat:@"%@——%@",L(@"PFCashOnDelivery"),L(@"PFPayByCard")];
    dto.detailDesc = L(@"PFOnlyNeedSwingCard");
    dto.detailUnsupportDesc = payDTO.unSupportCODReason.length?payDTO.unSupportCODReason:L(@"PFDonotSupportCashOnDelivery");
    if ([payDTO.supportCOD isEqualToString:@"false"])      //  不支持货到付款
    {
        dto.supportPay = NO;
    }
    else    // 支持货到付款
    {
        dto.supportPay = YES;
        
        dto.subPayMode = CashOnDeliveryPOSPay;
        dto.detailUnsupportDesc = payDTO.codUnacceptablePOSReason.length?payDTO.codUnacceptablePOSReason:L(@"PFDonotSupportPayByCard");
        if ([payDTO.supportPos isEqualToString:@"false"]) // 不支持刷卡支持
        {
            dto.supportPay = NO;
        }
        else
        {
            dto.supportPay = YES;
        }
    }
    return dto;
}

//购物车2现金支付
+ (PayModeDTO *)cashCard2OnDeliveryDTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCard2CashOnDelivery;
    dto.mainDesc = [NSString stringWithFormat:@"%@——%@",L(@"PFCashOnDelivery"),L(@"PFCash")];
    dto.detailDesc = L(@"PFCanPayByCash");
    dto.detailUnsupportDesc = payDTO.unSupportCODReason.length?payDTO.unSupportCODReason:L(@"PFDonotSupportCashOnDelivery");
    if ([payDTO.supportCOD isEqualToString:@"false"])      //  不支持货到付款
    {
        dto.supportPay = NO;
    }
    else    // 支持货到付款
    {
        dto.supportPay = YES;
        //现金支付
        dto.subPayMode = CashOnDeliveryCashPay;
        dto.detailUnsupportDesc = payDTO.codUnacceptableCASHReason.length?payDTO.codUnacceptableCASHReason:L(@"PFDonotSupportPayByCash");
        if ([payDTO.supportCash isEqualToString:@"false"]) // 不支持刷卡支持
        {
            dto.supportPay = NO;
        }
        else
        {
            dto.supportPay = YES;
        }
    }
    return dto;
}


//购物车2在线支付
+ (PayModeDTO *)onLineCard2DTO:(payFlowDTO *)payDTO
{
    PayModeDTO *dto = [[PayModeDTO alloc] init];
    dto.payMode = PayModeCard2OnLine;
    dto.mainDesc = L(@"PFOnlinePayment");
    
    dto.detailDesc = L(@"PFSupportEfubaoCreditCardDebitCard");
    
    dto.supportPay = YES;
    
    return dto;
}


@end
