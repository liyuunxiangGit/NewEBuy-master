//
//  GBSearchFilterDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBSearchFilterDTO.h"

@implementation GBSearchFilterDTO

@synthesize fieldName = _fieldName;
@synthesize values = _values;
@synthesize sort = _sort;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_fieldName);
    TT_RELEASE_SAFELY(_values);
    TT_RELEASE_SAFELY(_sort);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.fieldName = EncodeStringFromDic(dic, @"fieldName");
    self.values = [EncodeArrayFromDic(dic, @"values") mutableCopy];
    self.sort = EncodeStringFromDic(dic, @"sort");
}

@end
