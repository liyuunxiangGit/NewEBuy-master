//
//  SNCityFirstLetterDTO.m
//  SuningEBuy
//
//  Created by snping on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNCityFirstLetterDTO.h"

#define kCityCodeKey        @"cityCode"
#define kCityNameKey        @"cityName"
#define kCityFullPinyinKey  @"cityFullPinyin"
#define kCityShortPinyin    @"cityShortPinyin"
#define kCityFirstLetter    @"cityFirstLetter"

@implementation SNCityFirstLetterDTO

- (void)parseFromDict:(NSDictionary *)dic {
    if (IsNilOrNull(dic)||![dic isKindOfClass:[NSDictionary class]]||dic.count==0) {
        return;
    }
    
    self.cityCode        = EncodeStringFromDic(dic, kCityCodeKey);
    self.cityName        = EncodeStringFromDic(dic, kCityNameKey);
    self.cityFullPinyin  = EncodeStringFromDic(dic, kCityFullPinyinKey);
    self.cityShortPinyin = EncodeStringFromDic(dic, kCityShortPinyin);
    self.cityFirstLetter = EncodeStringFromDic(dic, kCityFirstLetter);
    
}


@end
