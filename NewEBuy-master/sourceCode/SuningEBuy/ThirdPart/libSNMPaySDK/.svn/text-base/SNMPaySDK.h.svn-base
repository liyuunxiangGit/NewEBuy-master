//
//  SNMPaySDK.h
//  SNMPaySDK
//
//  Created by wangrui on 14-5-15.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SPOrderType) {
    
    SPOrderTypePayment, // 支付订单，大多数订单类型都为支付订单
    
    SPOrderTypeRecharge // 充值订单,
    
};

typedef NS_ENUM(NSInteger, SPUserType) {
    
    SPUserTypeEPP, // 易付宝会员
    
    SPUserTypeSNEG // 易购会员,
    
};

typedef NS_ENUM(NSInteger, SPRemoteAPIEnv) {
    
    SPRemoteAPIEnvSit, // sit环境
    
    SPRemoteAPIEnvPre, // pre环境
    
    SPRemoteAPIEnvPrd  // 生产环境,也是默认环境
    
};

@class SNMPayRequest;
@protocol SNMPaySDKDelegate;

@interface SNMPaySDK : NSObject

/**
 设置SNMPaySDK的用户类型
 
 默认为易付宝会员，目前支持易付宝和易购会员。非易付宝会员调用SDK时，会使用信任登录。
 @param userType 用户类型
 */
+ (void)setSDKUserType:(SPUserType)userType;

/**
 设置SNMPaySDK的调试模式
 
 当开启调试模式时，SNMPaySDK会在控制台输出详细的日志信息，开发者可以据此调试自己的程序。默认为 NO
 @param enabled 开启或关闭SNMPaySDK的调试模式
 */
+ (void)enableDebugMode:(BOOL)enabled;

/**
 设置SNMPaySDK的调试环境
 
 默认为生产(prd)环境，体系内应其它用在接入调试时，可分别切换到sit或pre环境
 @param envType 调试环境
 */
+ (void)setSDKRemoteAPIEnv:(SPRemoteAPIEnv)envType; // 默认为生产环境，主要用于体系内应用的调试

/**
 提交业务订单,Native接口
 
 订单类型分为支付订单和充值订单，目前只有易付宝充值属于充值订单，其它都为支付订单
 @param request 请求对象，包括订单信息orderString,以及订单类型orderType。
 @param delegate 代理对象，该对象必须直接或间接派生于UIViewController
 */
+ (void)submitOrderRequest:(SNMPayRequest *)request delegate:(id<SNMPaySDKDelegate>)delegate;

/**
 提交业务订单 JS接口
 
 订单类型分为支付订单和充值订单，目前只有易付宝充值属于充值订单，其它都为支付订单
 @param webView 接入SDK的H5页面。
 */
+ (void)attachSDKToWebView:(UIWebView *)webView delegate:(id<SNMPaySDKDelegate>)delegate;

@end

@interface SNMPayRequest : NSObject

@property (nonatomic, assign) SPOrderType orderType; // 订单类型

@property (nonatomic, strong) NSString *orderString; // 订单信息

@end

@protocol SNMPaySDKDelegate <NSObject>

@optional

/**
 加载收银台失败
 */
- (void)didFailLoadSDKWithError:(NSString *)errorMsg;

/**
 完成支付
 */
- (void)didFinishSDKPayment;

/**
 取消支付
 */
- (void)didCanceSDKPayment;

/**
 Passport会话超时
 
 会话超时，需要重新登录
 */
- (void)didPassportTimeOut;

@end

