//
//  OSChatViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "OSChatService.h"
#import "OSMessageCell.h"

#ifdef kReleaseH
#define kOSGIDOrderCenter               @"162"
#define kOSGIDDeliveryInstall           @"57"
#define kOSGIDReturnGoods               @"58"
#define kOSGIDFeedBack                  @"59"
#else
#define kOSGIDOrderCenter               @"203"
#define kOSGIDDeliveryInstall           @"57"
#define kOSGIDReturnGoods               @"58"
#define kOSGIDFeedBack                  @"59"
#endif

/**
 @enum      OSChatType
 @abstract  客服类型
 */
typedef NS_ENUM(NSInteger, OSChatType) {
    OSChatTypeB2CShop,      //b2c售前
    OSChatTypeB2CShopA,     //b2c厂送商品售前
    OSChatTypeB2COrderDetail,       //b2c售后订单中心
    OSChatTypeB2CDeliveryInstall,   //b2c售后送货安装
    OSChatTypeB2CReturnGoods,       //b2c售后退货
    OSChatTypeB2CFeedBack,          //b2c售后投诉建议
    OSChatTypeCShop                 //C店(售前和售后)
};

/**
 @abstract  在线客服总控制类
 */
@interface OSChatViewController : CommonViewController <OSChatServiceDelegate, OSMessageCellDelegate>

@property (nonatomic, strong) OSChatService *service;

@property (nonatomic, assign) OSChatType chatType;
@property (nonatomic, strong) NSString *shopCode;
@property (nonatomic, strong) NSString *b2cGroupId;
@property (nonatomic, strong) NSString *gId;
@property (nonatomic, strong) NSString *groupMember;
@property (nonatomic, strong) NSString *classCode;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *orderNo;

@property (nonatomic, strong) NSString *vendorName; //厂送商品供应商名称, 或C店店名

@property (nonatomic, strong) OSChatDTO *chatDTO;

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
 @abstract      向对话中添加消息
 @param         message      消息数据modal
 @param         chat         对话数据模型
 @result        void
 */
- (void)addMsg:(OSMsgDTO *)message toChat:(OSChatDTO *)chat;

@end
