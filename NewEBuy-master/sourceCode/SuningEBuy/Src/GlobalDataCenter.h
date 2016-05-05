//
//  GlobalDataCenter.h
//  SuningEBuy
//
//  Created by  liukun on 12-11-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      GlobalDataCenter.h
 @abstract    存放全局数据的静态类
 @author      刘坤
 @version     12-11-9  
 */

#import <Foundation/Foundation.h>


@interface GlobalDataCenter : NSObject
{
    NSDictionary *_activitySwitchMap;   //活动开关列表， 名称为key, 活动值为value
}

@property (nonatomic, strong) NSDictionary *activitySwitchMap;

@property (nonatomic, assign) BOOL  isMultiTouch;

//首页楼层数据的版本号
@property (nonatomic, copy)   NSString   *homeDataVersion;

//首页开关数据版本号
@property (nonatomic, copy)   NSString   *homeSwitchVersion;

@property (nonatomic, strong)   NSDictionary *floorID_TypeDict;

@property (nonatomic, strong)   NSDictionary *homeCellHeightDict;

//是否已经展示过首页快速注册浮层
@property (nonatomic, assign)   BOOL hasShownFloatingView;

+ (GlobalDataCenter *)defaultCenter;


@end
