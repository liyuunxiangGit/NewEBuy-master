//
//  StoreCampaignDTO.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreCampaignDTO.h"

@implementation StoreCampaignDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (NotNilAndNull([dic objectForKey:@"activityId"])) {
        self.activityId = EncodeStringFromDic(dic, @"activityId");
    }
    if (NotNilAndNull([dic objectForKey:@"name"])) {
        self.name = EncodeStringFromDic(dic, @"name");
    }
    if (NotNilAndNull([dic objectForKey:@"activityStartTime"])) {
        self.activityStartTime = EncodeStringFromDic(dic, @"activityStartTime");
    }
    if (NotNilAndNull([dic objectForKey:@"activityEndTime"])) {
        self.activityEndTime = EncodeStringFromDic(dic, @"activityEndTime");
    }
    if (NotNilAndNull([dic objectForKey:@"logoPic"])) {
        self.logoPic = EncodeStringFromDic(dic, @"logoPic");
    }
    if (NotNilAndNull([dic objectForKey:@"detailPic"])) {
        self.detailPic = EncodeStringFromDic(dic, @"detailPic");
    }
    if (NotNilAndNull([dic objectForKey:@"description"])) {
        self.campDescription = EncodeStringFromDic(dic, @"description");
    }
    if (NotNilAndNull([dic objectForKey:@"activityUrl"])) {
        self.activityUrl = EncodeStringFromDic(dic, @"activityUrl");
    }
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.activityId forKey:@"activityId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.activityStartTime forKey:@"activityStartTime"];
    [aCoder encodeObject:self.activityEndTime forKey:@"activityEndTime"];
    [aCoder encodeObject:self.logoPic forKey:@"logoPic"];
    [aCoder encodeObject:self.detailPic forKey:@"detailPic"];
    [aCoder encodeObject:self.campDescription forKey:@"description"];
    [aCoder encodeObject:self.activityUrl forKey:@"activityUrl"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.activityId = [aDecoder decodeObjectForKey:@"activityId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.activityStartTime = [aDecoder decodeObjectForKey:@"activityStartTime"];
        self.activityEndTime = [aDecoder decodeObjectForKey:@"activityEndTime"];
        self.logoPic = [aDecoder decodeObjectForKey:@"logoPic"];
        self.detailPic = [aDecoder decodeObjectForKey:@"detailPic"];
        self.campDescription = [aDecoder decodeObjectForKey:@"description"];
        self.activityUrl = [aDecoder decodeObjectForKey:@"activityUrl"];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_activityId);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_activityStartTime);
    TT_RELEASE_SAFELY(_activityEndTime);
    TT_RELEASE_SAFELY(_logoPic);
    TT_RELEASE_SAFELY(_detailPic);
    TT_RELEASE_SAFELY(_campDescription);
    TT_RELEASE_SAFELY(_activityUrl);
}

@end
