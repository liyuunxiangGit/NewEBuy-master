//
//  JPInfoDTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-1-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "JPInfoDTO.h"

@implementation JPInfoDTO

@synthesize jpId = _jpId;
@synthesize jpPrice = _jpPrice;
@synthesize jpName = _jpName;
@synthesize jpDate = _jpDate;
@synthesize jpMessage = _jpMessage;

@synthesize priseLevel = _priseLevel;



- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.jpId = EncodeStringFromDic(dic, @"JPid");
    self.jpPrice = EncodeStringFromDic(dic, @"JPPrice");
    self.jpName = EncodeStringFromDic(dic, @"JPName");
    self.jpDate = EncodeStringFromDic(dic, @"JPDate");
    self.jpMessage = EncodeStringFromDic(dic, @"ZJMessage");

    self.priseLevel = [self.jpId intValue];
}

@end
