//
//  GuessDataDTO.m
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GuessDataDTO.h"

@implementation GuessDataDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.productId          = EncodeStringFromDic(dict, @"sugGoodsId");
    self.productCode        = EncodeStringFromDic(dict, @"sugGoodsCode");
    self.productName        = EncodeStringFromDic(dict, @"sugGoodsName");
    self.productDescription = EncodeStringFromDic(dict, @"sugGoodsDes");
    self.productPrice       = EncodeStringFromDic(dict, @"price");
    self.supplierId         = EncodeStringFromDic(dict, @"vendorId");
    self.percentage         = EncodeStringFromDic(dict, @"persent");
    self.handWork           = EncodeStringFromDic(dict, @"handwork");
}

@end
