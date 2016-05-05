//
//  HomeProductDTO.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomeProductDTO.h"

@implementation HomeProductDTO


- (void)parseFromDict:(NSDictionary *)dict {
    if (NotNilAndNull(dict)) {
        self.orderNO = EncodeStringFromDic(dict, @"orderno");
        self.productID = EncodeStringFromDic(dict, @"productid");
        self.productName = EncodeStringFromDic(dict, @"productname");
        self.productCode = EncodeStringFromDic(dict, @"procode");
        self.providerCode = EncodeStringFromDic(dict, @"providercode");
        self.bigBang = EncodeStringFromDic(dict, @"bigbang");
        self.promIcon = EncodeStringFromDic(dict, @"promicon");
        self.productDescription = EncodeStringFromDic(dict, @"description");
    }
}


@end
