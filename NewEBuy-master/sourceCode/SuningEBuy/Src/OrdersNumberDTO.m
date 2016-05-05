//
//  OrdersNumberDTO.m
//  SuningEBuy
//
//  Created by YANG on 14-5-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrdersNumberDTO.h"

@implementation OrdersNumberDTO
- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    self.isSuccess = EncodeStringFromDic(dic, @"isSuccess");
    self.waitDeliveryCounts = EncodeStringFromDic(dic, @"waitDeliveryCounts");
    self.waitPayCounts = EncodeStringFromDic(dic, @"waitPayCounts");
    self.ordersInReturnCounts = EncodeStringFromDic(dic, @"ordersInReturnCounts");
}

@end
