//
//  NBCCSharedData.h
//  SuningEBuy
//
//  Created by suning on 14-9-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NBCCSharedData : NSObject

// 打赏 积分 仅加载一次
@property (nonatomic,strong) NSArray *rewardsConfig;

// 用户 当前 经纬度 坐标，默认(32.044038,118.792141)
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

// 地址详细信息
@property (nonatomic,strong) NSDictionary *addressDictionary;

@property (nonatomic,strong) NSArray      *lastLocationPoiArr;


+ (NBCCSharedData *)shared;

+ (BOOL)isAppLogined;

+ (NSString *)userId;

//“pos”://位置数据
//“{
//    “userLocation”:[118.111,32.222] //用户经纬度
//    “point”:[118.111,32.222]，//发布内容选择的位置纬度
//    “pointName”， //发布内容选择的位置名称
//    "prov":"省份",//非必填
//    "city":"城市",//非必填
//    "area":"区县",//非必填
//    “distance”,10000//距离
//}”
+ (NSDictionary *)postion;


+ (NSDictionary *)fixedPostion;

//u
//{
//    "id": "aa232",
//    "nick": "枪枪成2",
//    "sex": "1",
//    "faceUrl": "http://www.suning.com/avatar/100301.jpg
//}
+ (NSDictionary *)userInfo;

@end