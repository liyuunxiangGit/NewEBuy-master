//
//  NProOrderLastCell.h
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"
#import "NewOrderListDTO.h"
#import "ShopOrderListDto.h"

@interface NProOrderLastCell : CellsDatasCell

@property(nonatomic,strong) UILabel      *countLbl;//合计
@property(nonatomic,strong) UILabel      *priceLbl;//价格

//@property(nonatomic,strong)     UIImageView     *lineView;         //分割线2

@property(nonatomic,strong)     UIButton        *payBtn;            //支付按钮
@property(nonatomic,strong)     UIButton        *cancelOrderBtn;    //取消订单按钮
@property(nonatomic,strong)     UILabel         *orderStatusLbl;    //订单状态

@property(nonatomic,strong)     UIImageView     *lineView;         //分割线


//商品订单列表
- (void)setNProOrderLastCellInfo:(NewOrderListDTO*)listDto
                      productDto:(ProductListDTO *)productDto;

//门店订单列表
- (void)refreshShopOrderCellInfo:(ShopOrderListDto*)listDto
                      productDto:(ShopOrderItemListDto *)productDto;

//生活团购订单列表
- (void)setGroupOrderListCell:(GBOrderInfoDTO *)dto;
//生活团购商家信息
- (void)setGroupShopInfo:(GBShopDTO *)item WithRow:(int)row;
+ (CGFloat)setGroupShopInfoCellHeight:(GBShopDTO *)item WithRow:(int)row;



//退货申请
- (void)setReturnGoodsInfo:(NSString *)str ;

//退货中
- (void)setReturnGoodsQueryInfo:(ReturnGoodsQueryDTO *)queryDto ;
+ (CGFloat)setReturnGoodsQueryInfoHeight:(ReturnGoodsQueryDTO *)queryDto;

//选择快递
- (void)setReturnGoodsExpressInfo:(ReturnGoodsQueryDTO *)queryDto WithRow:(int)row;
+ (CGFloat)setExpressHeight:(ReturnGoodsQueryDTO *)queryDto WithRow:(int)row;

@end
