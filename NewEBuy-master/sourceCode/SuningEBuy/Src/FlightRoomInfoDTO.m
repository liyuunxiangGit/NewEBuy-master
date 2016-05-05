//
//  FlightRoomInfoDTO.m
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightRoomInfoDTO.h"

@implementation FlightRoomInfoDTO
@synthesize room = _room;
@synthesize sysPrice = _sysPrice;
@synthesize sysPriceC = _sysPriceC;
@synthesize roomB = _roomB;
@synthesize sysBPrice = _sysBPrice;
@synthesize sysBPriceC = _sysBPriceC;
@synthesize cliPrice = _cliPrice;
@synthesize cliPriceC = _cliPriceC;
@synthesize last = _last;
@synthesize rule = _rule;
@synthesize offRate = _offRate;
@synthesize offPrice = _offPrice;
@synthesize retPrice = _retPrice;
@synthesize price = _price;
@synthesize offPriceC = _offPriceC;
@synthesize retPriceC = _retPriceC;
@synthesize priceC = _priceC;
@synthesize index = _index;

@synthesize supplyId = _supplyId;
@synthesize supplyPolicyId = _supplyPolicyId;
@synthesize promotionOffParm = _promotionOffParm;
@synthesize promotionSupOffParm = _promotionSupOffParm;
@synthesize md5Str = _md5Str;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    NSString *roomStr = [dic objectForKey:@"room"];
    NSNumber *sysPriceStr = [dic objectForKey:@"sysPrice"];
    NSNumber *sysPriceCStr = [dic objectForKey:@"sysPriceC"];
    NSString *roomBStr = [dic objectForKey:@"roomB"];
    NSNumber *sysBPriceStr = [dic objectForKey:@"sysBPrice"];
    NSNumber *sysBPriceCStr = [dic objectForKey:@"sysBPriceC"];
    NSNumber *cliPriceStr  = [dic objectForKey:@"cliPrice"];
    NSNumber *cliPriceCStr = [dic objectForKey:@"cliPriceC"];
    NSString *lastStr = [dic objectForKey:@"last"];
    NSString *ruleStr = [dic objectForKey:@"rule"];
    NSNumber *offRateStr = [dic objectForKey:@"offRate"];
    NSNumber *offPriceStr = [dic objectForKey:@"offPrice"];
    NSNumber *retPriceStr = [dic objectForKey:@"retPrice"];
    NSNumber *priceStr = [dic objectForKey:@"price"];
    NSNumber *offPriceCStr = [dic objectForKey:@"offPriceC"];
    NSNumber *retPriceCStr = [dic objectForKey:@"retPriceC"];
    NSNumber *priceCStr = [dic objectForKey:@"priceC"];
    NSNumber *indexStr = [dic objectForKey:@"index"];
    NSString *__supplyId = [dic objectForKey:@"supplyId"];
    NSString *__supplyPolicyId = [dic objectForKey:@"supplyPolicyId"];
    NSNumber *__promotionOffParm = [dic objectForKey:@"promotionOffParm"];
    NSNumber *__promotionSupOffParm = [dic objectForKey:@"promotionSupOffParm"];
    NSString *__md5Str = [dic objectForKey:@"md5Str"];
    
    self.room = IsNilOrNull(roomStr)?@"":roomStr;
    self.sysPrice = IsNilOrNull(sysPriceStr)?@"":[sysPriceStr stringValue];
    self.sysPriceC = IsNilOrNull(sysPriceCStr)?@"":[sysPriceCStr stringValue];
    self.roomB = IsNilOrNull(roomBStr)?@"":roomBStr;
    self.sysBPrice = IsNilOrNull(sysBPriceStr)?@"":[sysBPriceStr stringValue];
    self.sysBPriceC = IsNilOrNull(sysBPriceCStr)?@"":[sysBPriceCStr stringValue];
    self.cliPrice = IsNilOrNull(cliPriceStr)?@"":[cliPriceStr stringValue];
    self.cliPriceC = IsNilOrNull(cliPriceCStr)?@"":[cliPriceCStr stringValue];
    self.last = IsNilOrNull(lastStr)?@"":lastStr;
    self.rule = IsNilOrNull(ruleStr)?@"":ruleStr;
    self.offRate = IsNilOrNull(offRateStr)?@"":[offRateStr stringValue] ;
    self.offPrice = IsNilOrNull(offPriceStr)?@"":[offPriceStr stringValue];
    self.retPrice = IsNilOrNull(retPriceStr)?@"":[retPriceStr stringValue];
    self.price = IsNilOrNull(priceStr)?@"":[priceStr stringValue];
    self.offPriceC = IsNilOrNull(offPriceCStr)?@"":[offPriceCStr stringValue];
    self.retPriceC = IsNilOrNull(retPriceCStr)?@"":[retPriceCStr stringValue];
    self.priceC = IsNilOrNull(priceCStr)?@"":[priceCStr stringValue];
    self.index = IsNilOrNull(indexStr)?@"":[indexStr stringValue];
    
    if (NotNilAndNull(__supplyId))   self.supplyId = __supplyId;
    if (NotNilAndNull(__supplyPolicyId))   self.supplyPolicyId = __supplyPolicyId;
    if (NotNilAndNull(__promotionOffParm))
        self.promotionOffParm = [__promotionOffParm stringValue];
    if (NotNilAndNull(__promotionSupOffParm))
        self.promotionSupOffParm = [__promotionSupOffParm stringValue];
    if (NotNilAndNull(__md5Str))   self.md5Str = __md5Str;
}

- (id)copyWithZone:(NSZone *)zone{
    FlightRoomInfoDTO *copy = [[self.class allocWithZone:zone] init];
    copy.room = self.room;
    copy.sysPrice = self.sysPrice;
    copy.sysBPriceC = self.sysBPriceC;
    copy.roomB = self.roomB;
    copy.sysBPrice = self.sysBPrice;
    copy.sysBPriceC = self.sysBPriceC;
    copy.cliPrice = self.cliPrice;
    copy.cliPriceC = self.cliPriceC;
    copy.last = self.last;
    copy.rule = self.rule;
    copy.offRate = self.offRate;
    copy.offPrice = self.offPrice;
    copy.retPrice = self.retPrice;
    copy.price =self.price;
    copy.offPriceC = self.offPriceC;
    copy.retPriceC = self.retPriceC;
    copy.price = self.price;
    copy.offPriceC = self.offPriceC;
    copy.retPriceC = self.retPriceC;
    copy.priceC = self.priceC;
    copy.index = self.index;
    copy.supplyId = self.supplyId;
    copy.supplyPolicyId = self.supplyPolicyId;
    copy.promotionOffParm = self.promotionOffParm;
    copy.promotionSupOffParm = self.promotionSupOffParm;
    copy.md5Str = self.md5Str;
    return copy;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_room);
    TT_RELEASE_SAFELY(_sysPrice);
    TT_RELEASE_SAFELY(_sysPriceC);
    TT_RELEASE_SAFELY(_roomB);
    TT_RELEASE_SAFELY(_sysBPrice);
    TT_RELEASE_SAFELY(_sysBPriceC);
    TT_RELEASE_SAFELY(_cliPrice);
    TT_RELEASE_SAFELY(_cliPriceC);
    TT_RELEASE_SAFELY(_last);
    TT_RELEASE_SAFELY(_rule);
    TT_RELEASE_SAFELY(_offRate);
    TT_RELEASE_SAFELY(_offPrice);
    TT_RELEASE_SAFELY( _retPrice);
    TT_RELEASE_SAFELY(_price);
    TT_RELEASE_SAFELY(_offPriceC);
    TT_RELEASE_SAFELY(_priceC);
    TT_RELEASE_SAFELY(_index);
    TT_RELEASE_SAFELY(_supplyId);
    TT_RELEASE_SAFELY(_supplyPolicyId);
    TT_RELEASE_SAFELY(_promotionOffParm);
    TT_RELEASE_SAFELY(_promotionSupOffParm);
    TT_RELEASE_SAFELY(_md5Str);
    
}

@end
