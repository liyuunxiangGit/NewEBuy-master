//
//  ShopDetailDto.h
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@interface ShopDetailDto : BaseHttpDTO

@property (nonatomic,retain) NSString *orderDttm;//下单时间
@property (nonatomic,retain) NSString *invoiceType;//发票类型
@property (nonatomic,retain) NSString *invoiceTitle;//发票抬头
@property (nonatomic,retain) NSString *paymentCode;//支付方式编码
@property (nonatomic,retain) NSString *paymentDesc;//支付方式描述
@property (nonatomic,retain) NSString *receiveName;//收货人
@property (nonatomic,retain) NSString *receiveMobile;//收货人电话
@property (nonatomic,retain) NSString *receiveAddress;//收货/自提地址


@property (nonatomic,retain) NSString *orderSaleAmount;
@property (nonatomic,retain) NSString *orderChannel;
@property (nonatomic,retain) NSString *orderDiscountAmount;//
@property (nonatomic,retain) NSString *orderPayAmount;//
@property (nonatomic,retain) NSString *sourceOrderId;//

@property (nonatomic,retain) NSMutableArray *orderItemList;//订单行列表

@end

@interface ShopDetailItemDto : BaseHttpDTO

@property (nonatomic,retain) NSString *sourceOrderItemId;//前端系统订单行号
@property (nonatomic,retain) NSString *distChannel;//分销渠道
@property (nonatomic,retain) NSString *sapOrderId;//SAP单号
@property (nonatomic,retain) NSString *sapOrderType;//SAP订单类型
@property (nonatomic,retain) NSString *commodityCode;//商品编码
@property (nonatomic,retain) NSString *commodityName;//商品名称
@property (nonatomic,retain) NSString *saleCount;//销售数量
@property (nonatomic,retain) NSString *unitPrice;//销售单价
@property (nonatomic,retain) NSString *saleAmount;//行项目销售额
@property (nonatomic,retain) NSString *payAmount;//行项目应付金额
@property (nonatomic,retain) NSString *posOrderId;//pos单号
@property (nonatomic,retain) NSString *verifyCode;//verifyCode校验码
@property (nonatomic,retain) NSString *shipCondition;//装运条件
@property (nonatomic,retain) NSString *invoiceContent;//发票内容
@property (nonatomic,retain) NSString *orderItemClass;//订单行类别
@property (nonatomic,retain) NSString *orderItemStatus;//订单行状态

//判断送货方式
+ (NSString*)judgeShipContition:(NSString*)str;

@end