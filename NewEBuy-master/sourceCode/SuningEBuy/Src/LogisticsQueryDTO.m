//
//  LogisticsQueryDTO.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LogisticsQueryDTO.h"

@implementation OrderItemDTO

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderItemId = EncodeStringFromDic(dic, @"orderItemId");
    self.productCode = EncodeStringFromDic(dic, @"productCode");
    self.productId = EncodeStringFromDic(dic, @"productId");
    self.productName = EncodeStringFromDic(dic, @"productName");
    self.quantityInIntValue = EncodeStringFromDic(dic, @"quantityInIntValue");
    self.totalProduct = EncodeStringFromDic(dic, @"totalProduct");
}

@end
@implementation LogisticsQueryDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.prepayAmount = EncodeStringFromDic(dic, @"prepayAmount");
    self.lastUpdate = EncodeStringFromDic(dic, @"lastUpdate");
    self.oiStatus = EncodeStringFromDic(dic, @"oiStatus");

    self.orderItemArray = [EncodeArrayFromDicUsingParseBlock(dic, @"orderitems", ^id(NSDictionary *innerDic) {
        
        OrderItemDTO *dto = [[OrderItemDTO alloc] init];
        [dto encodeFromDictionary:dic];
        return dto;
    }) mutableCopy];
   
}

-(NSMutableArray *)orderItemArray{
    
    if (!_orderItemArray) {
    
        _orderItemArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return _orderItemArray;
}


@end
