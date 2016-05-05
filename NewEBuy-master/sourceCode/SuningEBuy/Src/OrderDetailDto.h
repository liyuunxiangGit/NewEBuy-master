//
//  OrderDetailDto.h
//  SuningEBuy
//
//  Created by xmy on 5/5/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface OrderDetailDto : BaseHttpDTO
//head
@property (nonatomic,retain)    NSString    *orderId;//订单id
@property   (nonatomic,copy)    NSString    *oiStatus;//订单状态
@property   (nonatomic,copy)    NSString    *lastUpdate;//下单时间
@property   (nonatomic,copy)    NSString    *totalPrice;//商品金额
@property   (nonatomic,copy)    NSString    *totalDiscount;//优惠金额
@property   (nonatomic,copy)    NSString    *prepayAmount;//订单价格
@property   (nonatomic,copy)    NSString    *policyDesc;//支付方式描述
@property   (nonatomic,copy)    NSString    *comments;//合约机需求字段
@property   (nonatomic,copy)    NSString    *ormOrder;//支付类型id
@property   (nonatomic,copy)    NSString    *supplierCode;//供应商编码
@property   (nonatomic,copy)    NSString    *cShopName;//供应商名称
@property   (nonatomic,copy)    NSString    *totalShipPrice;//

@property (nonatomic) BOOL canTwiceBuy;//是否能够二次购
@property (nonatomic) BOOL canReturnOrder;//是否能够退货
@property (nonatomic) BOOL    merchantOrder;//是否可以取消订单，1可以
@property (nonatomic) BOOL    canConfirmAccept;//是否可以确认收货，false不可以


@end

@interface OrderDetailItemDto : BaseHttpDTO
//商品信息
@property (nonatomic,retain)    NSString    *orderId;//订单id
@property (nonatomic,retain)    NSString    *orderItemId;//商品行id
@property   (nonatomic,copy)    NSString    *productCode;//商品编码
@property   (nonatomic,copy)    NSString    *productId;//商品id
@property   (nonatomic,copy)    NSString    *productName;//商品名称
@property   (nonatomic,copy)    NSString    *quantityInIntValue;//商品数量
@property   (nonatomic,copy)    NSString    *totalProduct;//订单行价格
@property   (nonatomic, copy)   NSString    *isBundle;//是否小套餐,1是
@property   (nonatomic,copy)    NSString    *posOrderNumber;//pos单号
@property   (nonatomic,copy)    NSString    *verificationCode;//校验码
@property   (nonatomic,copy)    NSString    *currentShipModeType;//送货方式
@property   (nonatomic,copy)    NSString    *taxType;//发票类型
@property   (nonatomic,copy)    NSString    *itemPlacerName;//收货人
@property   (nonatomic,copy)    NSString    *itemMobilePhone;//收货人电话
@property   (nonatomic,copy)    NSString    *address;//收货/自提地址
@property   (nonatomic,copy)    NSString    *invoice;//发票抬头
@property   (nonatomic,copy)    NSString    *invoiceDescription;//发票内容
@property   (nonatomic,copy)    NSString    *exWarrantyFlag;//是否阳光报标识
@property   (nonatomic,copy)    NSString    *exWarrantyName;//阳光包名称
@property   (nonatomic,copy)    NSString    *exWarrantyQuantity;//阳光包数量
@property   (nonatomic,copy)    NSString    *exWarrantyPrice;//阳光包价格
@property   (nonatomic,copy)    NSString    *returnStatus;//退货状态
@property	(nonatomic,strong)	NSURL		*imageURL;
@property   (nonatomic,copy)    NSString    *supplierCode;//供应商编码
@property   (nonatomic,copy)    NSString    *cShopName;//供应商名称
@property   (nonatomic,copy)    NSString    *oiStatus;//订单状态


@property (nonatomic) BOOL canTwiceBuy;//是否能够二次购
@property (nonatomic) BOOL canReturnOrder;//是否能够退货


@end

@interface OrderDetailCListDto : BaseHttpDTO
//c店商品特有信息
@property   (nonatomic,copy)    NSString    *expressNo;//快递单号
@property   (nonatomic)    BOOL    isconfirmReceipt;//是否可确认收货,true：可确认收货
@property   (nonatomic,copy)    NSArray    *itemList;//c店订单

@end