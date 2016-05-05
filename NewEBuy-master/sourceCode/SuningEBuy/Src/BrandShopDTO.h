//
//  BrandShopDTO.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  品牌旗舰店dto

#import <Foundation/Foundation.h>

@interface BrandShopDTO : NSObject
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *brandImage;

@property (nonatomic, copy) NSString *descriptions;

@property (nonatomic, copy) NSString *url;  //跳转url

- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
