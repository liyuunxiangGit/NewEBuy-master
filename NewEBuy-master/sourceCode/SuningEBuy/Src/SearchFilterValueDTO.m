//
//  SearchFilterValueDTO.m
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchFilterValueDTO.h"

@implementation SearchFilterValueDTO

@synthesize value = _value;
@synthesize valueDesc = _valueDesc;
@synthesize checked = _checked;

- (void)dealloc {
    TT_RELEASE_SAFELY(_value);
    TT_RELEASE_SAFELY(_valueDesc);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    NSString *__value = [dic objectForKey:@"value"];
    NSString *__valueDesc = [dic objectForKey:@"valueDesc"];
    NSNumber *__checked = [dic objectForKey:@"checked"];
    
    if (NotNilAndNull(__value))   self.value = __value;
    if (NotNilAndNull(__valueDesc))   self.valueDesc = __valueDesc;
    if (NotNilAndNull(__checked))   self.checked = [__checked boolValue];
}

@end
