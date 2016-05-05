//
//  SNDataCollection.h
//  SSA_IOS
//
//  Created by shasha on 13-7-24.
//  Copyright (c) 2013年 suning. All rights reserved.
//
//  Last modified by likai on 2014-08-29
//


typedef enum{
	kSetSit,
	kSetPrd,
} E_SeverKey;

typedef enum{
    K_BIZ = 1,  //与业务相关的数据
    K_INFO,     //用户自定义的信息
    K_ERROR     //运行抛出的异常
} E_CustomInfoType;


#import <Foundation/Foundation.h>

@interface SSAIOSSNDataCollection : NSObject

+ (SSAIOSSNDataCollection *)sharedInstance;

/*!
 @method
 @abstract      通用开启苏宁数据统计的方法
 @discussion    通用设置: 默认channel发布渠道为appstore，
 @param         appName: app名称
 @param     channelName: 发布渠道名称
 @return           void
 */


/**
 *  环境设定 sit测试环境:kSetSit
 *          prd生产环境:kSetPrd
 *          default自动设定为sit测试环境
 *
 *  @param severKey 所需要使用的环境
 */
+ (void)setSSAServer:(E_SeverKey)severKey;


/**
 *  自定义设备类型（for SuningEbuy）
 *  当需要自定义设备类型时才调用此方法，不调用则自动获取
 *
 *  @param deviceModeName 自定义设备类型的名称
 */
+ (void)selfSetDeviceMode:(NSString *)deviceModeName;


/**
 *  程序开始时调用(如果开启了自动城市定位)
 *
 *  @param appName     程序的名称
 *  @param channelName 应用程序下载渠道，nil则默认为AppStore
 */
+ (void)startWithAppkey:(NSString *)appName
                channel:(NSString *)channelName;


/**
 *  程序开始时调用(如果默认关闭了自动城市定位)
 *
 *  @param appName     程序的名称
 *  @param channelName 应用程序下载渠道，nil则默认为AppStore
 *  @param cityName    城市名称
 */
+ (void)startWithAppkey:(NSString *)appName
				channel:(NSString *)channelName
			   cityName:(NSString *)cityName;


/**
 *  采集用户登录信息(如果开启了自动城市定位)
 *  在用户登录时调用，或在一些自动登陆的程序运行开始时调用
 *
 *  @param appName     应用程序名称
 *  @param channelName 应用程序下载渠道，nil则默认为AppStore
 *  @param loginName   用户登录名
 */
+ (void)LoginNameCollection:(NSString *)appName
                    channel:(NSString *)channelName
                  loginName:(NSString *)loginName;

/**
 *  采集用户登录信息(关闭自动城市定位)
 *  在用户登录时调用，或在一些自动登陆的程序运行开始时调用
 *
 *  @param appName     应用程序名称
 *  @param channelName 应用程序下载渠道，nil则默认为AppStore
 *  @param loginName   用户登录名
 */
+ (void)LoginNameCollection:(NSString *)appName
                    channel:(NSString *)channelName
				   cityName:(NSString *)cityName
                  loginName:(NSString *)loginName;


/**
 *  采集用户应用使用信息
 *  应用程序开始使用时调用，与useInfoEndCollecting方法成对出现
 *
 *  @param appName 应用程序名称
 */
+ (void)useInfoStartCollecting:(NSString *)appName;


/**
 *  采集用户应用使用信息
 *  应用程序结束或进入后台时调用，与useInfoStartCollecting方法成对出现
 *
 *  @param appName 应用程序名称
 */
+ (void)useInfoEndCollecting:(NSString *)appName;


/**
 *  采集用户页面浏览信息(应用程序只有一个页面)，在页面进入的时候调用此方法
 */
+ (void)singlePageInCollection;


/**
 *  采集用户页面浏览信息(应用程序只有一个页面)，在页面关闭后调用此方法
 *
 *  @param pageTitle 页面标题
 */
+ (void)singlePageOutCollection:(NSString *)pageTitle;


/**
 *  采集用户页面浏览信息(应用程序有多个页面)，在页面进入的时候调用此方法
 *
 *  @param pageTitle 页面标题
 */
+ (void)multiPagesInCollection:(NSString *)pageTitle;


/**
 *  采集用户页面浏览信息(应用程序有多个页面)，在页面关闭后调用此方法
 *
 *  @param pageTitle 页面标题
 */
+ (void)multiPagesOutCollection:(NSString *)pageTitle;


/**
 *  采集用户的注册信息
 *  在用户注册成功后调用
 *
 *  @param name 用户注册的名称
 */
+ (void)RegisterNameCollection:(NSString *)name;


/**
 *  采集用户的订单信息
 *  当用户订单生效后调用
 *
 *  @param order 用户订单号
 */
+ (void)OrderNumCollection:(NSString *)order;


/**
 *  采集用户的搜索信息
 *  用户搜索完成后调用
 *
 *  @param keywork      用户搜索的关键字
 *  @param count        返回给用户的搜索结果
 *  @param styleName    搜索方式
 */
+ (void)SearchInfoCollection:(NSString *)keywork
                 resultCount:(NSInteger)count
                 searchStyle:(NSString *)styleName;


/**
 *  采集自定义事件信息
 *
 *  @param eventType    自定义事件的类型,如 type
 *  @param keyArray     自定义事件的key值数组，如[id,name]
 *  @param valueArray   自定义事件传value值数组，如[10001,likai],对应关系为id:10001;name:likai;
 */
+ (void)CustomEventCollection:(NSString *)eventType keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray;

/**
 *  采集升级前版本号
 */
+ (void)LastAppVersionIdCollection:(NSString *)versionId;

/**
 *  采集会员ID
 *  采集会员ID必须登录，所以请在登录成功调用LoginNameCollection方法之后调用此方法
 *
 */
+ (void)MemberIdCollect:(NSString *)memberId;


//////////////////////////////////////////////////////////////////////////////////////////
//以下接口为SA性能提供
/**
 *  关闭http监控，请在didFinishLaunchingWithOptions函数中调用
 */
+ (void)ShutDownHttpWatch;

/**
 *  性能数据信息
 *
 *  @param perfName             自定义名称  -不能为空
 *  @param simSignalStrength    sim卡信号强度
 *  @param invokeTime           消耗时间，单位毫秒 example:1000
 *  @param requestBodySize      请求内容字节数 单位字节 example:1000
 *  @param responseBodySize     响应内容字节数 单位字节 example:1000
 */
+ (void)Sa_Pf_PerfInfo_Upload:(NSString *)perfName simSignalStrength:(NSString *)simSignalStrength invokeTime:(NSString *)invokeTime requestBodySize:(NSString *)requestBodySize responseBodySize:(NSString *)responseBodySize;

/**
 *  自定义数据信息
 *
 *  @param valueType             数据类型，定义见E_CustomInfoType
 *  @param key                   键
 *  @param value                 值，为id弱类型,可以包括以下3类数据
                                 1、NSDictionary，键名自定义字符串，值只能放基础数据类型，包括NSString、NSNumber、NSDate3类
                                 Example:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"value1", @"key1",
                                    [NSNumber numberWithInt:1], @"key2",
                                    [NSNumber numberWithFloat:1.0f], @"key3",
                                    [NSNumber numberWithBool:YES], @"key4",
                                    [NSDate date], @"key5",
                                    nil];
                                 2、NSNumber
                                 Example:
                                    [NSNumber numberWithInt:1]
                                 3、NSString
                                 Example:
                                    @"value"
 */
+ (void)Sa_Pf_CustomInfo_Upload:(E_CustomInfoType)valueType key:(NSString *)key value:(id)value;
//////////////////////////////////////////////////////////////////////////////////////////
@end
