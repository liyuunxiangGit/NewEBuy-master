//
//  GBSubmitBackDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-6-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBSubmitBackDTO.h"

@implementation GBSubmitBackDTO

@synthesize ifSuccess = _ifSuccess;
@synthesize orderId = _orderId;
@synthesize orderPrice = _orderPrice;


- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.ifSuccess = EncodeStringFromDic(dic, @"ifSuccess");
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.orderPrice = EncodeStringFromDic(dic, @"orderPrice");
}

@end
