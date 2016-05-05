//
//  LianBanFloorDTO.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  连版专题楼层DTO

#import <Foundation/Foundation.h>

@interface LianBanFloorDTO : NSObject

//序号
@property (nonatomic, copy) NSString *orderNO;

//楼层头显示类型（0：文字+背景色;1:背景图片）
@property (nonatomic, copy) NSString *showStyle;

//楼层头显示文字
@property (nonatomic, copy) NSString *title;

//楼层头显示背景色
@property (nonatomic, copy) NSString *bgColor;

//背景图片
@property (nonatomic, copy) NSString *bgImg;

//商品列表
@property (nonatomic, strong) NSMutableArray *productArray;



- (void)parseFromDict:(NSDictionary *)dict;

@end
