//
//  StoreServiceDTO.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreServiceDTO.h"

@implementation StoreServiceDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (NotNilAndNull([dic objectForKey:@"serviceId"])) {
        self.serviceId = EncodeStringFromDic(dic, @"serviceId");
    }
    if (NotNilAndNull([dic objectForKey:@"serviceName"])) {
        self.serviceName = EncodeStringFromDic(dic, @"serviceName");
    }
    if (NotNilAndNull([dic objectForKey:@"description"])) {
        self.serveDescription = EncodeStringFromDic(dic, @"description");
    }
    if (NotNilAndNull([dic objectForKey:@"logoUrl"])) {
        self.logoUrl = EncodeStringFromDic(dic, @"logoUrl");
    }
    if (NotNilAndNull([dic objectForKey:@"isTopService"])) {
        self.isTopService = EncodeStringFromDic(dic, @"isTopService");
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.serviceId forKey:@"serviceId"];
    [aCoder encodeObject:self.serviceName forKey:@"serviceName"];
    [aCoder encodeObject:self.serveDescription forKey:@"description"];
    [aCoder encodeObject:self.logoUrl forKey:@"logoUrl"];
    [aCoder encodeObject:self.isTopService forKey:@"isTopService"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.serviceId = [aDecoder decodeObjectForKey:@"serviceId"];
        self.serviceName = [aDecoder decodeObjectForKey:@"serviceName"];
        self.serveDescription = [aDecoder decodeObjectForKey:@"description"];
        self.logoUrl = [aDecoder decodeObjectForKey:@"logoUrl"];
        self.isTopService = [aDecoder decodeObjectForKey:@"isTopService"];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_serviceId);
    TT_RELEASE_SAFELY(_serviceName);
    TT_RELEASE_SAFELY(_serveDescription);
    TT_RELEASE_SAFELY(_logoUrl);
    TT_RELEASE_SAFELY(_isTopService);
}

@end
