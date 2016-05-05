//
//  ServiceDetailInfoDTO.m
//  SuningEMall
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceDetailInfoDTO.h"


@implementation ServiceDetailInfoDTO

@synthesize itemDate = _itemDate;
@synthesize itemText = _itemText;
@synthesize itemTime = _itemTime;

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.itemDate = EncodeStringFromDic(dic, KHttpRequestItemDate);
    self.itemText = EncodeStringFromDic(dic, KHttpRequestItemText);
    self.itemTime = EncodeStringFromDic(dic, KHttpRequestItemTime);
}

@end
