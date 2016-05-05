//
//  MemberOrderNames.h
//  SuningEMall
//
//  Created by lcj lcj on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface MemberOrderNamesDTO : BaseHttpDTO{
	NSString		*_orderId;
	NSString		*_prepayAmount;
	NSString		*_lastUpdate;
	NSString		*_oiStatus;
    
	NSString        *_policyDesc;
    NSString        *_merchantOrder;
    NSString        *_ordOrder;
}

@property	(nonatomic,copy) NSString	*orderId;
@property	(nonatomic,copy) NSString	*prepayAmount;
@property	(nonatomic,copy) NSString	*lastUpdate;
@property	(nonatomic,copy) NSString	*oiStatus;
@property	(nonatomic) BOOL	canMerchantOrder;//是否可以取消订单


@property (nonatomic, copy) NSString  *policyDesc;
@property (nonatomic, copy) NSString *merchantOrder;
@property (nonatomic, copy) NSString *canTwiceBuy;
@property (nonatomic, copy) NSString *canReturnOrder;
@property (nonatomic, copy) NSString *ormOrder;
@property (nonatomic, strong) NSString *orderRemark;//留言

//xmy
//list 接口
//@property (nonatomic,retain) NSString *orderId;//订单id
//@property (nonatomic,retain) NSString *prepayAmount;//订单价格
@property (nonatomic,retain) NSString *totalShipPrice;//订单C店总运费
@property (nonatomic,retain) NSString *totalShipCharge;//订单自营总运费

//@property (nonatomic,retain) NSString *lastUpdate;//下单时间
//@property (nonatomic,retain) NSString *oiStatus;//订单状态
@property (nonatomic) BOOL canConfirmAccept;//是否支持确认收货
@property (nonatomic) BOOL canCheckLogistics;//是否支持查看物流
//@property (nonatomic) BOOL canTwiceBuy;//是否能够二次购 1：是 0：否

//detail 接口
//@property   (nonatomic,copy)    NSString    *orderId;//订单id
//@property   (nonatomic,copy)    NSString    *oiStatus;//订单状态
//@property   (nonatomic,copy)    NSString    *lastUpdate;//下单时间
@property   (nonatomic,copy)    NSString    *totalPrice;//商品金额
@property   (nonatomic,copy)    NSString    *totalDiscount;//优惠金额
//@property   (nonatomic,copy)    NSString    *prepayAmount;//订单价格
//@property   (nonatomic,copy)    NSString    *policyDesc;//支付方式描述
@property   (nonatomic)    BOOL    merchantOrderNew;//是否可以取消订单
@property   (nonatomic,copy)    NSString    *comments;//合约机需求字段
//@property   (nonatomic,copy)    NSString    *ormOrder;//支付类型id
@property   (nonatomic)         BOOL        canTwiceBuyNew;//是否能够二次购
//@property   (nonatomic)         BOOL        canReturnOrder;//是否能够退货
@property   (nonatomic,copy)    NSString    *supplierCode;//供应商编码
@property   (nonatomic,copy)    NSString    *cShopName;//供应商名称
//@property   (nonatomic)         BOOL        canConfirmAccept;//是否支持确认收货
//@property   (nonatomic,copy)    NSString    *totalShipPrice;//运费



- (BOOL)canCancelOrder;
- (BOOL)canSecondPay;
- (BOOL)isCanCancelOrder;
- (BOOL)isCanTwiceBuy;
@end


//供应商列表信息
@interface NewOrderSupplierListDTO : BaseHttpDTO

@property (nonatomic,retain) NSString *supplierCode;//供应商编码
@property (nonatomic,retain) NSString *cShopName;//供应商名称


@end

//订单行列表信息
@interface NewOrderItemListDTO : BaseHttpDTO

@property (nonatomic,retain) NSString *orderItemId;//订单行id
@property (nonatomic,retain) NSString *productCode;//商品编码
@property (nonatomic,retain) NSString *productId;//商品id
@property (nonatomic,retain) NSString *productName;//商品名称
@property (nonatomic,retain) NSString *quantity;//商品数量
@property (nonatomic,retain) NSString *itemPrice;//商品价格

@end

