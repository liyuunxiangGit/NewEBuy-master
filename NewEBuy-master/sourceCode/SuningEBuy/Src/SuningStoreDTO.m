//
//  SuningStoreDTO.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SuningStoreDTO.h"

@implementation SuningStoreDTO

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_longitude);
    TT_RELEASE_SAFELY(_latitude);
    TT_RELEASE_SAFELY(_distance);
    TT_RELEASE_SAFELY(_telephone);
    TT_RELEASE_SAFELY(_isFavo);
    TT_RELEASE_SAFELY(_isTopStore);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (NotNilAndNull([dic objectForKey:@"storeId"])) {
        self.storeId = EncodeStringFromDic(dic, @"storeId");
    }
    if (NotNilAndNull([dic objectForKey:@"name"])) {
        self.name = EncodeStringFromDic(dic, @"name");
    }
    if (NotNilAndNull([dic objectForKey:@"address"])) {
        self.address = EncodeStringFromDic(dic, @"address");
    }
    if (NotNilAndNull([dic objectForKey:@"longitude"])) {
        self.longitude = EncodeStringFromDic(dic, @"longitude");
    }
    if (NotNilAndNull([dic objectForKey:@"latitude"])) {
        self.latitude = EncodeStringFromDic(dic, @"latitude");
    }
    if (NotNilAndNull([dic objectForKey:@"distance"])) {
        self.distance = EncodeStringFromDic(dic, @"distance");
    }
    if (NotNilAndNull([dic objectForKey:@"telephone"])) {
        self.telephone = EncodeStringFromDic(dic, @"telephone");
    }
    if (NotNilAndNull([dic objectForKey:@"isFavo"])) {
        self.isFavo = EncodeStringFromDic(dic, @"isFavo");
    }
    if (NotNilAndNull([dic objectForKey:@"isTopStore"])) {
        self.isTopStore = EncodeStringFromDic(dic, @"isTopStore");
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.distance forKey:@"distance"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.isFavo forKey:@"isFavo"];
    [aCoder encodeObject:self.isTopStore forKey:@"isTopStore"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.storeId = [aDecoder decodeObjectForKey:@"storeId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.address  = [aDecoder decodeObjectForKey:@"address"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.latitude  = [aDecoder decodeObjectForKey:@"latitude"];
        self.distance = [aDecoder decodeObjectForKey:@"distance"];
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.isFavo = [aDecoder decodeObjectForKey:@"isFavo"];
        self.isTopStore = [aDecoder decodeObjectForKey:@"isTopStore"];
    }
    return self;
}

@end
