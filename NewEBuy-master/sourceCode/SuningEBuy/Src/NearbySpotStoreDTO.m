//
//  SuningStoreDTO.m
//  SuningEBuy
//
//  Created by Kristopher on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearbySpotStoreDTO.h"

@implementation NearbySpotStoreDTO

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeCode);
    TT_RELEASE_SAFELY(_storeName);
    TT_RELEASE_SAFELY(_storeAddress);
    TT_RELEASE_SAFELY(_distance);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (NotNilAndNull([dic objectForKey:@"storeId"])) {
        self.storeCode = EncodeStringFromDic(dic, @"storeId");
    }
    if (NotNilAndNull([dic objectForKey:@"storeName"])) {
        self.storeName = EncodeStringFromDic(dic, @"storeName");
    }
    if (NotNilAndNull([dic objectForKey:@"storeAccess"])) {
        self.storeAddress = EncodeStringFromDic(dic, @"storeAccess");
    }
    if (NotNilAndNull([dic objectForKey:@"distance"])) {
        self.distance = EncodeStringFromDic(dic, @"distance");
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeCode forKey:@"storeCode"];
    [aCoder encodeObject:self.storeName forKey:@"storeName"];
    [aCoder encodeObject:self.storeAddress forKey:@"storeAddress"];
    [aCoder encodeObject:self.distance forKey:@"distance"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.storeCode = [aDecoder decodeObjectForKey:@"storeCode"];
        self.storeName = [aDecoder decodeObjectForKey:@"storeName"];
        self.storeAddress  = [aDecoder decodeObjectForKey:@"storeAddress"];
        self.distance = [aDecoder decodeObjectForKey:@"distance"];
    }
    return self;
}

@end
