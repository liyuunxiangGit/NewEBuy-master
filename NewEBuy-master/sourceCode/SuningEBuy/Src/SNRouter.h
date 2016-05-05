//
//  SNRouter.h
//  SuningEBuy
//
//  Created by liukun on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNRouterObject.h"
#import "UIViewController+SNRouter.h"

/**
 *  页面路由的控制器
 */
@interface SNRouter : NSObject

+ (instancetype)sharedInstance;

+ (void)cancelCurrentTask;

/**
 *  解析一个url类型的跳转
 *
 *  @param url              一个http的url，可以来源于二维码扫描或其他途径维护
 *  @param onCheckingBlock  接口检查即将开始
 *  @param shouldRouteBlock 即将跳转到指定的页面或场景的回调block
 *  @param didRouteBlock    跳转完毕后的回调block
 *  @param source           标示进入的来源，如推送、二维码扫描等，用于数据统计
 *
 */
+ (void)handleURL:(NSString *)url
       onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
      shouldRoute:(BOOL(^)(SNRouterObject *obj))shouldRouteBlock
         didRoute:(void(^)(SNRouterObject *obj))didRouteBlock
           source:(SNRouteSource)source;


+ (void)handleURL:(NSString *)url
       onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
      shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
         didRoute:(void (^)(SNRouterObject *))didRouteBlock
           source:(SNRouteSource)source
    navController:(UINavigationController *)navCon;

- (void)_handleURL:(NSString *)url
        onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
       shouldRoute:(BOOL (^)(SNRouterObject *))shouldRouteBlock
          didRoute:(void (^)(SNRouterObject *))didRouteBlock
            source:(SNRouteSource)source
     navController:(UINavigationController *)navCon;

/**
 *  解析一个url-scheme的跳转
 *
 *  @param openUrl          进入应用的原url
 *  @param onCheckingBlock  接口检查即将开始
 *  @param shouldRouteBlock 即将跳转到指定的页面或场景的回调block
 *  @param didRouteBlock    跳转完毕后的回调block
 *
 *  @return YES
 */
+ (BOOL)handleOpenUrl:(NSURL *)openUrl
           onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
          shouldRoute:(BOOL(^)(SNRouterObject *obj))shouldRouteBlock
             didRoute:(void(^)(SNRouterObject *obj))didRouteBlock;

/**
 *  解析并跳转一个自定义code类型的跳转
 *
 *  @param adTypeCode       活动类型   required
 *  @param adId             活动ID
 *  @param chanId           老规则中的抢购的频道ID
 *  @param qiangId          老规则中的抢购ID
 *  @param onCheckingBlock  接口检查即将开始
 *  @param shouldRouteBlock 即将跳转到指定的页面或场景的回调block
 *  @param didRouteBlock    跳转完毕后的回调block
 *  @param source           标示进入的来源，如推送、二维码扫描等，用于数据统计
 */
+ (void)handleAdTypeCode:(NSString *)adTypeCode
                    adId:(NSString *)adId
                  chanId:(NSString *)chanId
                 qiangId:(NSString *)qiangId
              onChecking:(void(^)(SNRouterObject *obj))onCheckingBlock
             shouldRoute:(BOOL(^)(SNRouterObject *obj))shouldRouteBlock
                didRoute:(void(^)(SNRouterObject *obj))didRouteBlock
                  source:(SNRouteSource)source;

/**
 *  用于更详细的定制跳转，如果你对该类实现逻辑了解
 *
 *  @param obj 封装好的用于跳转的页面路由的对象
 */
- (void)routingObject:(SNRouterObject *)obj;

@end
