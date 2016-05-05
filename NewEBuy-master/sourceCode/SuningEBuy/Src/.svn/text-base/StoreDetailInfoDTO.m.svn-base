//
//  StoreDetailInfoDTO.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreDetailInfoDTO.h"

@implementation StoreDetailInfoDTO

@synthesize storeId = _storeId;
@synthesize storeName = _storeName;
@synthesize address = _address;
@synthesize openingTime = _openingTime;
@synthesize busChannel = _busChannel;
@synthesize parkLotInfo = _parkLotInfo;
@synthesize storePicture = _storePicture;
@synthesize subwayChannel = _subwayChannel;

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if(NotNilAndNull([dic objectForKey:@"storeId"]))
    {
        self.storeId = [dic objectForKey:@"storeId"];
    }
    
    if(NotNilAndNull([dic objectForKey:@"storePicture"]))
    {
        self.storePicture = [dic objectForKey:@"storePicture"];
    }
    if(NotNilAndNull([dic objectForKey:@"storeName"]))
    {
        self.storeName = [dic objectForKey:@"storeName"];
    }
    if(NotNilAndNull([dic objectForKey:@"storeAddress"]))
    {
        self.address = [dic objectForKey:@"storeAddress"];
    }
    if(NotNilAndNull([dic objectForKey:@"openingTime"]))
    {
        self.openingTime = [dic objectForKey:@"openingTime"];
    }
    if(NotNilAndNull([dic objectForKey:@"busChannel"]))
    {
        self.busChannel = [dic objectForKey:@"busChannel"];
    }
    
    if(NotNilAndNull([dic objectForKey:@"parkLotInfo"]))
    {
        self.parkLotInfo = [dic objectForKey:@"parkLotInfo"];
    }
    if (NotNilAndNull([dic objectForKey:@"subwayChannel"])) {
        self.subwayChannel = [dic objectForKey:@"subwayChannel"];
    }
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
    [aCoder encodeObject:self.storePicture forKey:@"storePicture"];
    [aCoder encodeObject:self.storeName forKey:@"storeName"];
    
    [aCoder encodeObject:self.address forKey:@"storeAddress"];
    [aCoder encodeObject:self.openingTime forKey:@"openingTime"];
    [aCoder encodeObject:self.busChannel forKey:@"busChannel"];
    [aCoder encodeObject:self.subwayChannel forKey:@"subwayChannel"];
    [aCoder encodeObject:self.parkLotInfo forKey:@"parkLotInfo"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.storeId = [aDecoder decodeObjectForKey:@"storeId"];
        self.storePicture = [aDecoder decodeObjectForKey:@"storePicture"];
        
        self.storeName = [aDecoder decodeObjectForKey:@"storeName"];
        
        self.address = [aDecoder decodeObjectForKey:@"storeAddress"];
        self.openingTime = [aDecoder decodeObjectForKey:@"openingTime"];
        self.busChannel = [aDecoder decodeObjectForKey:@"busChannel"];
        self.subwayChannel = [aDecoder decodeObjectForKey:@"subwayChannel"];
        self.parkLotInfo = [aDecoder decodeObjectForKey:@"parkLotInfo"];
        
    }
    return self;
}



-(void)dealloc
{
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_storePicture);
    
    TT_RELEASE_SAFELY(_storeName);
    
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_openingTime);
    TT_RELEASE_SAFELY(_busChannel);
    
    TT_RELEASE_SAFELY(_parkLotInfo);
    TT_RELEASE_SAFELY(_subwayChannel);
}

@end


//@implementation StoreServiceDTO
//@synthesize serviceName = _serviceName;
//@synthesize servicePosition = _servicePosition;
//@synthesize serviceDescription = _serviceDescription;
//
//-(void)encodeFromDictionary:(NSDictionary *)dic
//{
//    if (NotNilAndNull([dic objectForKey:@"servicePosition"])) {
//        self.servicePosition = EncodeStringFromDic(dic, @"servicePosition");
//    }
//    if (NotNilAndNull([dic objectForKey:@"serviceDescription"])) {
//        self.serviceDescription = EncodeStringFromDic(dic, @"serviceDescription");
//    }
//    if (NotNilAndNull([dic objectForKey:@"serviceName"])) {
//        self.serviceName = EncodeStringFromDic(dic, @"serviceName");
//    }
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.servicePosition forKey:@"servicePosition"];
//    [aCoder encodeObject:self.serviceDescription forKey:@"serviceDescription"];
//    [aCoder encodeObject:self.serviceName forKey:@"serviceName"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//
//    if (self = [super init])
//    {
//        self.servicePosition = [aDecoder decodeObjectForKey:@"servicePosition"];
//        self.serviceDescription = [aDecoder decodeObjectForKey:@"serviceDescription"];
//        self.serviceName = [aDecoder decodeObjectForKey:@"serviceName"];
//    }
//    return self;
//}
//
//- (void)dealloc
//{
//    TT_RELEASE_SAFELY(_servicePosition);
//    TT_RELEASE_SAFELY(_serviceDescription);
//    TT_RELEASE_SAFELY(_serviceName);
//}
//
//@end

@implementation FloorInfoDTO

@synthesize floorNo = _floorNo;

@synthesize brandType = _brandType;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_floorNo);
    TT_RELEASE_SAFELY(_brandType);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.floorNo = [aDecoder decodeObjectForKey:@"floorNo"];
        self.brandType = [aDecoder decodeObjectForKey:@"brandType"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.floorNo forKey:@"floorNo"];
    [aCoder encodeObject:self.brandType forKey:@"brandType"];
}

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (NotNilAndNull([dic objectForKey:@"brandType"])) {
        self.brandType = EncodeStringFromDic(dic, @"brandType");
    }
    if (NotNilAndNull([dic objectForKey:@"floorNo"])) {
        self.floorNo = EncodeStringFromDic(dic, @"floorNo");
    }
}


@end
