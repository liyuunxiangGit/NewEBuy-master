//
//  NewSnxpressDTO.m
//  SuningEBuy
//
//  Created by xmy on 6/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewSnxpressDTO.h"

@implementation NewSnxpressDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.deliveryItemList = EncodeArrayFromDic(dic, @"deliveryItemList");
    self.deliveryAddress = EncodeStringFromDic(dic, @"deliveryAddress");
    self.deliveryDate = EncodeStringFromDic(dic, @"deliveryDate");
    self.packageNum = EncodeStringFromDic(dic, @"packagenum");
    self.productList = EncodeArrayFromDic(dic, @"prodList");
    self.statusList = EncodeArrayFromDic(dic, @"statusList");
    self.expressNo = EncodeStringFromDic(dic, @"expressNo");
    self.expressCompany = EncodeStringFromDic(dic, @"expressCompany");
    self.dlAddress = EncodeStringFromDic(dic, @"dlAddress");
}

@end
