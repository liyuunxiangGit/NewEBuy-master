//
//  StoresRegistrationDTO.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "StoresRegistrationDTO.h"

@implementation StoresRegistrationDTO

@synthesize isCheckin = _isCheckin;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.isCheckin = EncodeStringFromDic(dic, @"isCheckin");
    self.errorCode = EncodeStringFromDic(dic, @"errorCode");
}

@end
