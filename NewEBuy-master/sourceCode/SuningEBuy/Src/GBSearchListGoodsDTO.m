//
//  GBSearchListGoodsDTO.m
//  SuningEBuy
//
//  Created by shasha on 13-3-5.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBSearchListGoodsDTO.h"

@implementation GBSearchListGoodsDTO
@synthesize tuanGouType = _tuanGouType;
@synthesize isGood = _isGood;


- (void)encodeFromDictionary:(NSDictionary *)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if (IsNilOrNull(dic)) {
        return;
    }
    
    self.bimg = EncodeStringFromDic(dic, @"imgLUrl");
    self.tuanGouType = EncodeStringFromDic(dic, @"tuanGouType");
    self.isGood = EncodeStringFromDic(dic, @"isGood");
    
}
@end
