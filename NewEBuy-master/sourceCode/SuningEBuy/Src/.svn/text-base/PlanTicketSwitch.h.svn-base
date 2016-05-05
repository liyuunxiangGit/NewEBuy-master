//
//  PlanTicketSwitch.h
//  SuningEBuy
//
//  Created by  liukun on 12-11-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef kReleaseH
#   define kPlaneTicketTimeOut    30.0f
#else
#   define kPlaneTicketTimeOut    60.0f
#endif

//参数加密盐
#define kPlaneTicketParamEncodeSalt  @"sn201209"
//参数加密的key
#define kPlaneTicketParamEncodeKey   @"SNMobileJiPiao"

@interface PlanTicketSwitch : NSObject


+ (BOOL)canUserNewServer;


+ (void)jumpToQueryPlaneView:(UINavigationController *)controller;


//添加新开关，是否使用加密
+ (BOOL)isEncodeParam;

@end
