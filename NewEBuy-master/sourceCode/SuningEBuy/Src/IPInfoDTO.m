//
//  IPInfoDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "IPInfoDTO.h"

@implementation IPInfoDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.ipInfo = EncodeStringFromDic(dic, @"ip");
    self.portInfo = EncodeStringFromDic(dic, @"port");
}

@end
