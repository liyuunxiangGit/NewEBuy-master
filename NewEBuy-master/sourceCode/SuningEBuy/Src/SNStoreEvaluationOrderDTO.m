//
//  SNStoreEvaluationOrderDTO.m
//  SuningEBuy
//
//  Created by snping on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNStoreEvaluationOrderDTO.h"

@implementation SNStoreEvaluationOrderDTO

-(void)parseOrderItmFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)||![dic isKindOfClass:[NSDictionary class]]||dic.count==0) {
        return;
    }
    
    self.omsOrderId       = EncodeStringFromDic(dic, @"omsOrderId");
    self.omsOrderItemId   = EncodeStringFromDic(dic, @"omsOrderItemId");
    self.commodityName    = EncodeStringFromDic(dic, @"commodityName");
    self.supplierCode     = EncodeStringFromDic(dic, @"supplierCode");
    self.orderTime        = EncodeStringFromDic(dic, @"orderTime");
    
}

@end
