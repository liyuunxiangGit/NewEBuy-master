//
//  GBCityDTO.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GBCityDTO.h"

@implementation GBCityDTO

@synthesize cityId = _cityId;
@synthesize cityName = _cityName;
@synthesize cityPinYin = _cityPinYin;
@synthesize letter = _letter;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_cityId);
    TT_RELEASE_SAFELY(_cityName);
    TT_RELEASE_SAFELY(_cityPinYin);
    TT_RELEASE_SAFELY(_letter);
}


- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil)
    {
        return;
    }
    self.cityId = EncodeStringFromDic(dic, @"cityId");
    self.cityName = EncodeStringFromDic(dic, @"cityName");
    self.cityPinYin = EncodeStringFromDic(dic, @"pinyin");
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeObject:self.cityPinYin forKey:@"cityPinYin"];
    [aCoder encodeObject:self.letter forKey:@"letter"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.cityId = [aDecoder decodeObjectForKey:@"cityId"];
        self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
        self.cityPinYin = [aDecoder decodeObjectForKey:@"cityPinYin"];
        self.letter = [aDecoder decodeObjectForKey:@"letter"];
    }
    return self;
}

@end
