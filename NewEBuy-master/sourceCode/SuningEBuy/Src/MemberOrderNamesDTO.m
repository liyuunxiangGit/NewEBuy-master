//
//  MemberOrderNames.m
//  SuningEMall
//
//  Created by lcj lcj on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderNamesDTO.h"

@implementation MemberOrderNamesDTO
@synthesize	orderId=_orderId;
@synthesize	prepayAmount=_prepayAmount;
@synthesize	lastUpdate=_lastUpdate;
@synthesize	oiStatus=_oiStatus;

@synthesize policyDesc = _policyDesc;
@synthesize merchantOrder = _merchantOrder;
@synthesize canTwiceBuy = _canTwiceBuy;
@synthesize canReturnOrder = _canReturnOrder;
@synthesize ormOrder = _ormOrder;



- (void)encodeFromDictionary:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
	NSString *orderId		=	[dic objectForKey:kResponseMemberOrderId];
	NSString *prepayAmount	=	[dic objectForKey:kResponseMemberPrepayAmount];
	NSString *lastUpdate	=	[dic objectForKey:kResponseMemberLastUpdate];
	NSString *oiStatus		=	[dic objectForKey:kResponseMemberOiStatus];
    
    NSString *polDesc       =   [dic objectForKey:kResponseMemberPolicyDesc];
    NSString *merOrder      =   [dic objectForKey:kResponseMemberMerchantOrder];
    NSString *orderRemark   =   [dic objectForKey:kResponseMemberOrderRemark];
	if (NotNilAndNull(orderId)) {
		self.orderId = orderId;
	}
	
	if (NotNilAndNull(prepayAmount)) {
		self.prepayAmount = prepayAmount;
	}
	
	if (NotNilAndNull(lastUpdate)) {
		self.lastUpdate = lastUpdate;
	}
	
	if (NotNilAndNull(oiStatus)) {
        if ([oiStatus isEqualToString:L(@"MyEBuy_Completed")]) {
            oiStatus = @"SC";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_WaitingForPay")])
        {
            oiStatus = @"M";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_SomeGoodsDelivered")])
        {
            oiStatus = @"SOMED";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_HaveBeenDelivered")])
        {
            oiStatus = @"SD";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_HavePaid")])
        {
            oiStatus = @"C";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_HaveReturned")])
        {
            oiStatus = @"r";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_HaveCanceled")])
        {
            oiStatus = @"X";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_OrderAbnormal")] || [oiStatus isEqualToString:L(@"MyEBuy_OrderProcessing")])
        {
            oiStatus = @"e";
        }
        else if ([oiStatus isEqualToString:L(@"MyEBuy_WaitingDeliver")])
        {
            oiStatus = @"WD";
        }
		self.oiStatus = oiStatus;
	}
    
    if (NotNilAndNull(polDesc)) {
        self.policyDesc = polDesc;
    }
    
    if (NotNilAndNull(merOrder)) {
        self.merchantOrder = merOrder;
    }
    if (NotNilAndNull(orderRemark)) {
        self.orderRemark = orderRemark;
    }
    
    self.canTwiceBuy = EncodeStringFromDic(dic, @"canTwiceBuy");
    self.canReturnOrder = EncodeStringFromDic(dic, @"canReturnOrder");
    self.ormOrder = EncodeStringFromDic(dic, @"ormOrder");
    
    //xmy
    self.totalShipPrice = EncodeStringFromDic(dic, @"totalShipPrice");
    self.canCheckLogistics = [EncodeStringFromDic(dic, @"canCheckLogistics") isEqualToString:@"1"];
    self.canConfirmAccept = [EncodeStringFromDic(dic, @"canConfirmAccept") isEqualToString:@"true"];
    
    self.totalPrice = EncodeStringFromDic(dic, @"totalPrice");
    self.totalDiscount = EncodeStringFromDic(dic, @"totalDiscount");
    self.comments = EncodeStringFromDic(dic, @"comments");
    self.supplierCode = EncodeStringFromDic(dic, @"supplierCode");
    self.cShopName = EncodeStringFromDic(dic, @"cShopName");
    
    self.canTwiceBuyNew = [EncodeStringFromDic(dic, @"canTwiceBuy") isEqualToString:@"1"];
    self.merchantOrderNew = [EncodeStringFromDic(dic, @"merchantOrder") isEqualToString:@"1"];
    self.canMerchantOrder = [EncodeStringFromDic(dic, @"canMerchantOrder") isEqualToString:@"1"];
    self.totalShipCharge = EncodeStringFromDic(dic, @"totalShipCharge");
}

- (BOOL)canCancelOrder
{
    //可取消订单或退货，且不是货到付款订单
    if ([_merchantOrder isEqualToString:@"1"] && ![self isCanCancelOrder])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)canSecondPay
{
    //如果返回了canTwiceBuy字段，则使用该字段判断
    if (self.canTwiceBuy)
    {
        if ([self.canTwiceBuy isEqualToString:@"1"] && ![self isCanTwiceBuy])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
//        if ([_oiStatus hasPrefix:@"M"] && ![self isCanTwiceBuy])
//        {
//            return YES;
//        }
//        else
//        {
            return NO;
//        }
    }
    
    
}
//
- (BOOL)isCanCancelOrder
{
    return [_ormOrder isEqualToString:@"11601"]; //[_policyDesc hasPrefix:@"货到付款"];
}
//货到付款和门店支付都不能二次支付
- (BOOL)isCanTwiceBuy
{
    return [_ormOrder isEqualToString:@"11601"] || [_ormOrder isEqualToString:@"11701"]; //[_policyDesc hasPrefix:@"货到付款"];
}

@end


@implementation NewOrderSupplierListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *supplierCode =	[dic objectForKey:@"supplierCode"];
	NSString *cShopName = [dic objectForKey:@"cShopName"];
	
	
    if (NotNilAndNull(supplierCode)) {
        
        self.supplierCode = supplierCode;
        
    }
    
	if (NotNilAndNull(cShopName)) {
		self.cShopName = cShopName;
	}
    
}

@end

@implementation NewOrderItemListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *orderItemId =	[dic objectForKey:@"orderItemId"];
	NSString *productCode = [dic objectForKey:@"productCode"];
    NSString *productId =	[dic objectForKey:@"productId"];
	NSString *productName = [dic objectForKey:@"productName"];
    NSString *quantity =	[dic objectForKey:@"quantity"];
	NSString *itemPrice = [dic objectForKey:@"itemPrice"];
	
	
    if (NotNilAndNull(orderItemId)) {
        
        self.orderItemId = orderItemId;
    }
    
	if (NotNilAndNull(productCode)) {
		self.productCode = productCode;
	}
    
    if (NotNilAndNull(productId)) {
        
        self.productId = productId;
    }
    
	if (NotNilAndNull(productName)) {
		self.productName = productName;
	}
    
    if (NotNilAndNull(quantity)) {
        
        self.quantity = quantity;
    }
    
	if (NotNilAndNull(itemPrice)) {
		self.itemPrice = itemPrice;
	}
    
}


@end
