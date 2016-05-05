//
//  OSLeaveMessageViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "OSChatService.h"

/**
 @abstract  C店客服留言页面，在客服不在线的时候使用
 */
@interface OSLeaveMessageViewController : CommonViewController <OSChatServiceDelegate>

@property (nonatomic, strong) OSChatService *service;
@property (nonatomic, strong) NSString *shopCode;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *groupMember;
@property (nonatomic, strong) NSString *classCode;

/**
 @abstract      初始化方法
 @param         shopCode  C店编码
 @param         shopName  C店名称
 @param         productName  商品名称 (可选)
 @param         orderId      订单Id  (可选)
 */
- (id)initWithShopCode:(NSString *)shopCode
              ShopName:(NSString *)shopName
           ProductCode:(NSString *)productCode
           ProductName:(NSString *)productName
               OrderId:(NSString *)orderId;

/**
 @abstract      初始化方法
 @param         grouMember  供应商编码
 @param         classCode   商品组
 @param         productName  商品名称 (可选)
 @param         orderId      订单Id  (可选)
 */
- (id)initWithAGroupMember:(NSString *)grouMember
                vendorName:(NSString *)vendorName
                 classCode:(NSString *)classCode
               ProductCode:(NSString *)productCode
               ProductName:(NSString *)productName
                   OrderId:(NSString *)orderId;

@end
