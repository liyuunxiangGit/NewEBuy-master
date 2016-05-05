//
//  HomeModuleDTO.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  楼层里包含的模块DTO

#import <Foundation/Foundation.h>

@interface HomeModuleDTO : NSObject


// 模块序号
@property (nonatomic, copy) NSString *orderNO;

//模块id
@property (nonatomic, copy) NSString *moduleid;

//模块名称
@property (nonatomic, copy) NSString *moduleName;

//背景色
@property (nonatomic, copy) NSString *bgColor;

//背景图片
@property (nonatomic, copy) NSString *bgImg;

//跳转类型 1:促销专题   2:商品集  3:连版专题  4:URL 5:页面集
@property (nonatomic, copy) NSString *targetType;

//跳转地址
@property (nonatomic, copy) NSString *targetURL;

- (void)parseFromDict:(NSDictionary *)dict;

@end
