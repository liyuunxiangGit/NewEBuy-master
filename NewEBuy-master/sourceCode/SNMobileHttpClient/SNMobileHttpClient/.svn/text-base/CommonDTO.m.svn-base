//
//  CommonDTO.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-6.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "CommonDTO.h"
#import <objc/runtime.h>

NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic))
{
    NSArray *tempList = EncodeArrayFromDic(dic, key);
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto) {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}

/*********************************************************************/


@implementation CommonDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]])  return;
}

+ (id)dtoFromDic:(NSDictionary *)dic
{
    id dto = [[self alloc] init];
    [dto encodeFromDictionary:dic];
    return dto;
}

- (NSString *)description
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keyArray = [NSMutableArray array];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc]
                                  initWithCString:property_getName(property)
                                  encoding:NSUTF8StringEncoding];
        [keyArray addObject:propertyName];
    }
    
    NSDictionary *infoDic = [self dictionaryWithValuesForKeys:keyArray];
    return [infoDic description];
}

@end
