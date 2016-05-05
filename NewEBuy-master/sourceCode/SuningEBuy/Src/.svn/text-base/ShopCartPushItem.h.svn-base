//
//  ShopCartPushItem.h
//  SuningEBuy
//
//  Created by liukun on 14-7-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartPushItem : NSObject

@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *special;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *deleteFlag;
@property (nonatomic, copy) NSString *cityCode;

+ (instancetype)queryItem;
- (BOOL)isQueryItem;

+ (instancetype)cityItem:(NSString *)cityCode;
- (BOOL)isCityItem;

@end
