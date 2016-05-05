//
//  ShopCartPushItem.m
//  SuningEBuy
//
//  Created by liukun on 14-7-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopCartPushItem.h"

@implementation ShopCartPushItem

+ (instancetype)queryItem
{
    ShopCartPushItem *item = [[ShopCartPushItem alloc] init];
    item.itemId = @"query";
    return item;
}

- (BOOL)isQueryItem
{
    return [self.itemId isEqualToString:@"query"];
}

+ (instancetype)cityItem:(NSString *)cityCode
{
    ShopCartPushItem *item = [[ShopCartPushItem alloc] init];
    item.itemId = @"cityCode";
    item.cityCode = cityCode;
    return item;
}

- (BOOL)isCityItem
{
    return [self.itemId isEqualToString:@"cityCode"] && self.cityCode.length;
}

@end
