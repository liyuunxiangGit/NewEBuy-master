//
//  OSGetStatusCommand.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "Command.h"
#import "OSChatViewController.h"
#import "OSChatService.h"
#import "DataProductBasic.h"

typedef NS_ENUM(NSInteger, OSShowStatus) {
    OSShowStatusNone,       //不展示
    OSShowStatusOnline,     //在线
    OSShowStatusOffline,    //不在线
    OSShowStatusLeaveMessage,   //离线留言
};

@interface OSGetStatusCommand : Command <OSChatServiceDelegate>
{
    OSChatService *_service;
}

@property (nonatomic, assign) OSChatType chatType;
@property (nonatomic, strong) NSString *shopCode;
@property (nonatomic, strong) NSString *b2cGroupId;
@property (nonatomic, strong) NSString *gId;
@property (nonatomic, strong) NSString *groupMember;
@property (nonatomic, strong) NSString *classCode;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *orderNo;

//response
@property (nonatomic, assign) SNShopType shopType;
@property (nonatomic, assign) int onlineStatus; // -1 未入住, 0 不在线, 1 在线, -2 未完成, -3 请求失败

/**
 @abstract      作为b2c售前客服类型的初始化方法
 @param         b2cGroupId  3级销售目录id
 @param         productName  商品名称 (非必须)
 @param         productCode  商品编码 (非必须)
 @result        instanceType
 */
- (id)initAsB2CShop:(NSString *)b2cGroupId
        productName:(NSString *)productName
        productCode:(NSString *)productCode; //b2c售前

/**
 @abstract      作为b2c厂送商品售前客服类型的初始化方法
 @param         b2cGroupId  3级销售目录id
 @param         groupMember 供应商编码
 @param         classCode   商品组
 @param         productName  商品名称 (非必须)
 @param         productCode  商品编码 (非必须)
 @result        instanceType
 */
- (id)initAsAShop:(NSString *)b2cGroupId
      GroupMember:(NSString *)groupMember
        ClassCode:(NSString *)classCode
      productName:(NSString *)productName
      productCode:(NSString *)productCode;

/**
 @abstract      作为b2c售后订单客服类型的初始化方法
 @param         orderNo  订单编号 (非必须)
 @result        instanceType
 */
- (id)initAsB2COrderDetailWithOrderNo:(NSString *)orderNo;

/**
 @abstract      作为b2c售后送货安装客服类型的初始化方法
 @param         orderNo  订单编号 (非必须)
 @result        instanceType
 */
- (id)initAsB2CDeliveryInstallWithOrderNo:(NSString *)orderNo;

/**
 @abstract      作为b2c售后退货客服类型的初始化方法
 @param         orderNo  订单编号 (非必须)
 @result        instanceType
 */
- (id)initAsB2CReturnOrderWithOrderNo:(NSString *)orderNo;

/**
 @abstract      作为b2c售后投诉建议客服类型的初始化方法
 @param         orderNo  订单编号 (非必须)
 @result        instanceType
 */
- (id)initASB2CFeedBackWithOrderNo:(NSString *)orderNo;

/**
 @abstract      作为b2c售后送货安装客服类型的初始化方法
 @param         shopCode     商家编码
 @param         productName  商品名称 (非必须)
 @param         productCode  商品编码 (非必须)
 @param         orderNo      订单编号 (非必须)
 @result        instanceType
 */
- (id)initAsCShop:(NSString *)shopCode
      ProductName:(NSString *)productName
      ProductCode:(NSString *)productCode
          OrderNo:(NSString *)orderNo;

/**
 @abstract      售前初始化统一方法
 @param         product  商品详情
 @result        instanceType
 */
- (id)initWithDataProduct:(DataProductBasic *)product;


#pragma mark ----------------------------- utils

/**
 @abstract      计算客服的展示状态
 @param         status      客服状态： -1 未入住, 0 不在线, 1 在线
 @param         shopType    客服店铺类型
 @result        isPreSale   是否是售前
 */
+ (OSShowStatus)getShowStatusFromStatus:(int)status
                               ShopType:(SNShopType)shopType
                              IsPreSale:(BOOL)isPreSale;

@end
