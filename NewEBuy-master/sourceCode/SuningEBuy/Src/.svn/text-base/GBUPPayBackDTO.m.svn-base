//
//  GBUPPayBackDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-6-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBUPPayBackDTO.h"

@implementation GBUPPayBackDTO

@synthesize orderId = _orderId;
@synthesize totalPrice = _totalPrice;
@synthesize eppAmount = _eppAmount;
@synthesize payAmount = _payAmount;
@synthesize paymentType = _paymentType;
@synthesize bankCode = _bankCode;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.totalPrice = EncodeStringFromDic(dic, @"totalPrice");
    self.eppAmount = EncodeStringFromDic(dic, @"eppAmount");
    self.payAmount = EncodeStringFromDic(dic, @"payAmount");
    self.paymentType = EncodeStringFromDic(dic, @"paymentType");
    self.bankCode = EncodeStringFromDic(dic, @"bankCode");
}


@end
