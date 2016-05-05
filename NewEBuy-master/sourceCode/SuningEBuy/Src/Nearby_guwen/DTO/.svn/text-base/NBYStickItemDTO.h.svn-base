//
//  NBYStickItemDTO.h
//  SuningEBuy
//
//  Created by suning on 14-9-24.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBYStickItemDTO : NSObject

@property (nonatomic,strong) NSIndexPath    *idxPath;

@property (nonatomic,assign) NSUInteger  commentNum;
@property (nonatomic,assign) NSUInteger  dashangNum;

// 原始数据源
@property (nonatomic,strong) NSDictionary *item;

@end


@interface NBYStickGrpItemDTO : NSObject

// 分组
// 位置信息
@property (nonatomic,strong) NSArray    *point;         // stick 坐标点
@property (nonatomic,strong) NSArray    *userLocation;  // 用户 坐标点
@property (nonatomic,strong) NSString   *pointName;     // title
@property (nonatomic,strong) NSString   *distance;      // 距离 0.5
@property (nonatomic,strong) NSString   *prov;          // 省份
@property (nonatomic,strong) NSString   *city;          // 城市
@property (nonatomic,strong) NSString   *area;          // 区域

// 分组成员
@property (nonatomic,strong) NSMutableArray *stickItems;

- (NSDictionary *)postion;

@end
