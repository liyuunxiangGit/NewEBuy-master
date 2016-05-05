//
//  SuningStoreDetailInfoDTO.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SuningStoreDetailInfoDTO.h"

@implementation SuningStoreDetailInfoDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if(NotNilAndNull([dic objectForKey:@"storeId"]))
    {
        self.storeId = [dic objectForKey:@"storeId"];
    }
    if(NotNilAndNull([dic objectForKey:@"name"]))
    {
        self.name = [dic objectForKey:@"name"];
    }
    if(NotNilAndNull([dic objectForKey:@"workdayBeginTime"]))
    {
        self.workdayBeginTime = [dic objectForKey:@"workdayBeginTime"];
    }
    if(NotNilAndNull([dic objectForKey:@"workdayEndTime"]))
    {
        self.workdayEndTime = [dic objectForKey:@"workdayEndTime"];
    }
    if(NotNilAndNull([dic objectForKey:@"weekendBeginTime"]))
    {
        self.weekendBeginTime = [dic objectForKey:@"weekendBeginTime"];
    }
    if(NotNilAndNull([dic objectForKey:@"weekendEndTime"]))
    {
        self.weekendEndTime = [dic objectForKey:@"weekendEndTime"];
    }
    if(NotNilAndNull([dic objectForKey:@"address"]))
    {
        self.address = [dic objectForKey:@"address"];
    }
    if (NotNilAndNull([dic objectForKey:@"businessDistrict"])) {
        self.businessDistrict = [dic objectForKey:@"businessDistrict"];
    }
    if(NotNilAndNull([dic objectForKey:@"surroundBuildings"]))
    {
        self.surroundBuildings = [dic objectForKey:@"surroundBuildings"];
    }
    if(NotNilAndNull([dic objectForKey:@"longitude"]))
    {
        self.longitude = [dic objectForKey:@"longitude"];
    }
    if(NotNilAndNull([dic objectForKey:@"latitude"]))
    {
        self.latitude = [dic objectForKey:@"latitude"];
    }
    if(NotNilAndNull([dic objectForKey:@"parkDetail"]))
    {
        self.parkDetail = [dic objectForKey:@"parkDetail"];
    }
    if(NotNilAndNull([dic objectForKey:@"telephone"]))
    {
        self.telephone = [dic objectForKey:@"telephone"];
    }
    if(NotNilAndNull([dic objectForKey:@"busLine"]))
    {
        self.busLine = [dic objectForKey:@"busLine"];
    }
    if(NotNilAndNull([dic objectForKey:@"subwayDetail"]))
    {
        self.subwayDetail = [dic objectForKey:@"subwayDetail"];
    }
    if (NotNilAndNull([dic objectForKey:@"floorInfo"])) {
        self.floorInfo = [dic objectForKey:@"floorInfo"];
    }
    if (NotNilAndNull([dic objectForKey:@"isFavo"])) {
        self.isFavo = [dic objectForKey:@"isFavo"];
    }
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.workdayBeginTime forKey:@"workdayBeginTime"];
    [aCoder encodeObject:self.workdayEndTime forKey:@"workdayEndTime"];
    [aCoder encodeObject:self.weekendBeginTime forKey:@"weekendBeginTime"];
    [aCoder encodeObject:self.weekendEndTime forKey:@"weekendEndTime"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.businessDistrict forKey:@"businessDistrict"];
    [aCoder encodeObject:self.surroundBuildings forKey:@"surroundBuildings"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.parkDetail forKey:@"parkDetail"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.busLine forKey:@"busLine"];
    [aCoder encodeObject:self.subwayDetail forKey:@"subwayDetail"];
    [aCoder encodeObject:self.floorInfo forKey:@"floorInfo"];
    [aCoder encodeObject:self.isFavo forKey:@"isFavo"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.storeId = [aDecoder decodeObjectForKey:@"storeId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.workdayBeginTime = [aDecoder decodeObjectForKey:@"workdayBeginTime"];
        self.workdayEndTime = [aDecoder decodeObjectForKey:@"workdayEndTime"];
        self.weekendBeginTime = [aDecoder decodeObjectForKey:@"weekendBeginTime"];
        self.weekendEndTime = [aDecoder decodeObjectForKey:@"weekendEndTime"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.businessDistrict = [aDecoder decodeObjectForKey:@"businessDistrict"];
        self.surroundBuildings = [aDecoder decodeObjectForKey:@"surroundBuildings"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.parkDetail = [aDecoder decodeObjectForKey:@"parkDetail"];
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.busLine = [aDecoder decodeObjectForKey:@"busLine"];
        self.subwayDetail = [aDecoder decodeObjectForKey:@"subwayDetail"];
        self.floorInfo = [aDecoder decodeObjectForKey:@"floorInfo"];
        self.isFavo = [aDecoder decodeObjectForKey:@"isFavo"];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_workdayBeginTime);
    TT_RELEASE_SAFELY(_workdayEndTime);
    TT_RELEASE_SAFELY(_weekendBeginTime);
    TT_RELEASE_SAFELY(_weekendEndTime);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_businessDistrict);
    TT_RELEASE_SAFELY(_surroundBuildings);
    TT_RELEASE_SAFELY(_longitude);
    TT_RELEASE_SAFELY(_latitude);
    TT_RELEASE_SAFELY(_parkDetail);
    TT_RELEASE_SAFELY(_telephone);
    TT_RELEASE_SAFELY(_busLine);
    TT_RELEASE_SAFELY(_subwayDetail);
    TT_RELEASE_SAFELY(_floorInfo);
    TT_RELEASE_SAFELY(_isFavo);
}

@end
