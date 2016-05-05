//
//  TopADInfoDTO.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  页面顶部广告栏DTO

#import <Foundation/Foundation.h>

@interface TopADInfoDTO : NSObject


//contenttype：广告类型（1：文字   2：广告图  4:广告图+文字  3:无）
@property (nonatomic, copy) NSString *contentType;

//广告图片
@property (nonatomic, copy) NSString *adImg;

//模块跳转类型
@property (nonatomic, copy) NSString *targetType;

//模块跳转URL
@property (nonatomic, copy) NSString *targetURL;

//活动简介
@property (nonatomic, copy) NSString *activityInfo;


- (void)parseFromDict:(NSDictionary *)dict;
@end
