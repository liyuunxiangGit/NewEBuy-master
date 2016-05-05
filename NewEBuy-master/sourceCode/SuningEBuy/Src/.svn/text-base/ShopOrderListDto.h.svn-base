//
//  ShopOrderListDto.h
//  SuningEBuy
//
//  Created by xmy on 24/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopOrderListDto : BaseHttpDTO

@property (nonatomic,retain) NSString *orderItemCount;//orderItemCount行项目数量
@property (nonatomic,retain) NSString *orderChannel;//订单渠道
@property (nonatomic,retain) NSString *sourceOrderId;//前端系统订单号
@property (nonatomic,retain) NSString *orderSaleAmount;//订单销售总额
@property (nonatomic,retain) NSString *orderDiscountAmount;//订单优惠总额
@property (nonatomic,retain) NSString *orderPayAmount;//订单应付总额
@property (nonatomic,retain) NSString *orderDttm;//下单时间
@property (nonatomic,retain) NSString *omsOrderId;//OMS订单号

@property (nonatomic,retain) NSMutableArray *orderItemList;//订单行列表


@end

@interface ShopOrderItemListDto : BaseHttpDTO

@property (nonatomic,retain) NSString *sourceOrderItemId;//前端系统订单行号
@property (nonatomic,retain) NSString *omsOrderItemId;//OMS订单行号
@property (nonatomic,retain) NSString *sapOrderId;//SAP单号
@property (nonatomic,retain) NSString *sapOrderType;//SAP订单类型
@property (nonatomic,retain) NSString *supplierCode;//供应商编码
@property (nonatomic,retain) NSString *commodityCode;//商品编码
@property (nonatomic,retain) NSString *commodityName;//商品名称
@property (nonatomic,retain) NSString *saleCount;//销售数量
@property (nonatomic,retain) NSString *unitPrice;//销售单价
@property (nonatomic,retain) NSString *saleAmount;//行项目销售额
@property (nonatomic,retain) NSString *payAmount;//行项目应付金额
@property (nonatomic,retain) NSString *payStatus;//payStatus
@property (nonatomic,retain) NSString *orderItemStatus;//订单行状态


@end