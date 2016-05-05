//
//  SNRouterObject.h
//  SuningEBuy
//
//  Created by liukun on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRouterUnrecognizedTypeCode     @"Unrecognized"
#define kRouterUnknownHttpUrlTypeCode   @"UnknownHttpUrl"
#define kRouterLotteryPayTypeCode       @"DGFQ"
#define kRouterScanLoginRegistTypeCode  @"ScanToLoginOrRegist"
#define kRouterDoNothingTypeCode        @"DoNothing"

typedef NS_ENUM(NSInteger, SNRouteSource) {
    SNRouteSourceNone               = 0,    //标识不是路由过来的
    SNRouteSourceDM                 = 1,    //DM单
    SNRouteSourceRemoteNotification = 2,    //远程推送
    SNRouteSourceScan               = 3,    //扫码
    SNRouteSourceOpenUrl            = 4,    //从别的应用跳过来的
    SNRouteSourceQuGuangGuang       = 5,    //去逛逛来的
    SNRouteSourceSomeUrl            = 6,    //自定义的Url
    SNRouteSourceSomeCode           = 7,    //自定义的adTypeCode
};

/**
 *  页面路由的对象模型
 */
@interface SNRouterObject : NSObject

@property (nonatomic, copy) NSString *adTypeCode; //活动类型, 普通URL: "UnknownUrl"; 未能识别: "Unrecognized";
@property (nonatomic, copy) NSString *adId; //活动ID

@property (nonatomic, copy) NSString *originUrl; //url
@property (nonatomic, strong) NSDictionary *allParams; //所有的参数

@property (nonatomic, assign) SNRouteSource source;  //来源

@property (nonatomic, assign) BOOL isReady;     //是否准备完成，适用于需要提前接口检查的页面

@property (nonatomic, copy) void (^onCheckingBlock)(SNRouterObject *obj);   //接口检查开始
@property (nonatomic, copy) BOOL (^shouldRouteBlock)(SNRouterObject *obj);  //即将跳转页面前回调
@property (nonatomic, copy) void (^didRouteBlock)(SNRouterObject *obj);     //跳转完成后的方法

@property (nonatomic, copy) void (^doRouteBlock)(SNRouterObject *obj);  //跳转的方法，优先级最高
@property (nonatomic, strong) UIViewController *targetController; //解析出来的controller，为nil则跳转到nav的rootController
@property (nonatomic, assign) NSUInteger defaultTabIndex;         //默认跳转的页面Index,
@property (nonatomic, strong) UINavigationController *navController; //进入目标controller的导航控制器,默认是nil,如果设置了，就用此nav进行跳转
@property (nonatomic, copy) NSString *errorMsg; //错误

- (instancetype)initWithURLString:(NSString *)url source:(SNRouteSource)source;

- (instancetype)initWithAdTypeCode:(NSString *)typeCode
                              adId:(NSString *)adId
                            source:(SNRouteSource)source;

- (instancetype)initWithAdTypeCode:(NSString *)typeCode
                              adId:(NSString *)adId
                            chanId:(NSString *)chanId
                           qiangId:(NSString *)qiangId
                            source:(SNRouteSource)source;

- (void)setParam:(NSObject *)obj forKey:(NSString *)key;
- (void)addParams:(NSDictionary *)params;

- (BOOL)isErrorOrDoNothing;
@end
