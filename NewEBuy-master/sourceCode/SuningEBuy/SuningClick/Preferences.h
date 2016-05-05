//
//  Preferences.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-6.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject

+ (NSString *)systemTimeInfo;

//获取当前手机时间
+ (NSString *)currentSystemTime;

+ (NSString *)yearMonthDay;

//获取设备硬件名称
+ (NSString *)platform;

//获取设备当前内网使用ip
+ (NSString *)deviceIPAddressLocal;

//获取公网ip
+ (NSString *)deviceIPAddressPublic;


@end
