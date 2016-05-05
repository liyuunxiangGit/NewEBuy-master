//
//  GBShopsListDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBShopsListDTO.h"

@implementation GBShopsListDTO

@synthesize shopName            = _shopName;
@synthesize address             = _address;
@synthesize telephone           = _telephone;
@synthesize trafficTips         = _trafficTips;


- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.shopName           = EncodeStringFromDic(dic, @"shopName");
    self.address            = EncodeStringFromDic(dic, @"address");
    self.telephone          = EncodeStringFromDic(dic, @"telephone");
    self.trafficTips        = EncodeStringFromDic(dic, @"trafficTips");
}

@end
