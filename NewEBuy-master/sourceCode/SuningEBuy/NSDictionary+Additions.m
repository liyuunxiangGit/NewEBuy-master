//
//  NSDictionary+Additions.m
//  SuningEBuy
//
//  Created by Joe on 14-6-28.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary(ValuePath)

- (NSInteger)intValue:(NSString*)path {
    return [self intValue:path default:0];
}

- (long)longValue:(NSString*)path
{
    return [self longValue:path default:0];
}

- (float)floatValue:(NSString*)path
{
    return [self floatValue:path default:0.0];
}

- (NSString*)strValue:(NSString*)path {
    return [self strValue:path default:nil];
}

- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj intValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj intValue];
    else
        return defValue;
}

- (long)longValue:(NSString*)path default:(long)defValue
{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj longValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj longLongValue];
    else
        return defValue;
}

- (float)floatValue:(NSString*)path default:(float)defValue
{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj floatValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj floatValue];
    else
        return defValue;
}

- (NSString*)strValue:(NSString*)path default:(NSString*)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj stringValue];
    else if ([obj isKindOfClass:[NSString class]])
        return (NSString*)obj;
    else
        return defValue;
}

-(NSArray *) arrayValue :(NSString *) path
{
    NSObject* obj = [self valueForKeyPath:path];
    if(obj && [obj isKindOfClass:[NSArray class]])
    {
        return (NSArray *)obj;
    }
    return nil;
}

@end
