//
//  StoreListDTO.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreListDTO.h"

@implementation StoreListDTO
@synthesize storeId = _storeId;
@synthesize storeName = _storeName;
@synthesize storeAddress =_storeAddress;
@synthesize storeLevel =_storeLevel;
@synthesize storeDistance =_storeDistance;
@synthesize latitude = _latitude;
@synthesize longtitude =_longtitude;
@synthesize isCollected = _isCollected;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_storeName);
    TT_RELEASE_SAFELY(_storeLevel);
    TT_RELEASE_SAFELY(_storeDistance);
    TT_RELEASE_SAFELY(_storeAddress);
    TT_RELEASE_SAFELY(_latitude);
    TT_RELEASE_SAFELY(_longtitude);
    TT_RELEASE_SAFELY(_isCollected);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (NotNilAndNull([dic objectForKey:@"storeId"])) {
        self.storeId = EncodeStringFromDic(dic, @"storeId");
    }
    if (NotNilAndNull([dic objectForKey:@"storeName"])) {
        self.storeName = EncodeStringFromDic(dic, @"storeName");
    }
    if (NotNilAndNull([dic objectForKey:@"storeAddress"])) {
        self.storeAddress = EncodeStringFromDic(dic, @"storeAddress");
    }
    if (NotNilAndNull([dic objectForKey:@"storeType"])) {
        self.storeLevel = EncodeStringFromDic(dic, @"storeType");
    }
    if (NotNilAndNull([dic objectForKey:@"storeDistance"])) {
        self.storeDistance = EncodeStringFromDic(dic, @"storeDistance");
    }
    if (NotNilAndNull([dic objectForKey:@"gpsLongitude"])) {
        self.longtitude = EncodeStringFromDic(dic, @"gpsLongitude");
    }
    if (NotNilAndNull([dic objectForKey:@"gpsLatitude"])) {
        self.latitude = EncodeStringFromDic(dic, @"gpsLatitude");
    }
    if (NotNilAndNull([dic objectForKey:@"isCollect"])) {
        self.isCollected = EncodeStringFromDic(dic, @"isCollect");
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
    [aCoder encodeObject:self.storeName forKey:@"storeName"];
    [aCoder encodeObject:self.storeLevel forKey:@"storeType"];
    [aCoder encodeObject:self.storeAddress forKey:@"storeAddress"];
    [aCoder encodeObject:self.storeDistance forKey:@"storeDistance"];
    [aCoder encodeObject:self.longtitude forKey:@"gpsLongitude"];
    [aCoder encodeObject:self.latitude forKey:@"gpsLatitude"];
    [aCoder encodeObject:self.isCollected forKey:@"isCollect"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.storeId = [aDecoder decodeObjectForKey:@"storeId"];
        self.storeName = [aDecoder decodeObjectForKey:@"storeName"];
        self.storeLevel  = [aDecoder decodeObjectForKey:@"storeType"];
        self.storeAddress = [aDecoder decodeObjectForKey:@"storeAddress"];
        self.storeDistance = [aDecoder decodeObjectForKey:@"storeDistance"];
        self.longtitude = [aDecoder decodeObjectForKey:@"gpsLongitude"];
        self.latitude  = [aDecoder decodeObjectForKey:@"gpsLatitude"];
        self.isCollected = [aDecoder decodeObjectForKey:@"isCollect"];
    }
    return self;
}

@end
