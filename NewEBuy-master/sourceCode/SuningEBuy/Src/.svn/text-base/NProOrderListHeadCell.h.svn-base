//
//  NProOrderListHeadCell.h
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"

@class NProOrderListHeadCell;

@protocol NProOrderListHeadCellDelegate <NSObject>
@optional
- (void)delegate_NProOrderListHeadCell_operation:(int)operation view:(NProOrderListHeadCell *)view;
@end



@interface NProOrderListHeadCell : CellsDatasCell

@property(nonatomic,strong) UILabel      *orderIdLbl;//订单编号
@property(nonatomic,strong) UILabel      *orderIdContextLbl;//订单编号
@property(nonatomic,strong) UILabel      *updateTimeLbl;//下单时间
@property(nonatomic,strong) UILabel      *updateTimeTextLbl;//下单时间
@property(nonatomic,strong) UILabel      *countLbl;//总价格
@property(nonatomic,strong) UILabel      *priceLbl;//总价格内容
@property(nonatomic,strong)     UIButton        *payBtn;            //支付按钮
@property(nonatomic,strong)     UIButton        *cancelOrderBtn;    //取消订单按钮
@property(nonatomic,strong)     UILabel         *supplierLbl;       //供应商名称
@property(nonatomic,strong)     UILabel         *orderStatusLbl;    //订单状态
@property(nonatomic,strong)     UIButton         *payDetailBtn;    //详情支付按钮
@property (nonatomic, strong)   UIView           *copyView;

@property(nonatomic,strong)     UIButton *deleteButton; // 删除订单按钮

@property (nonatomic,strong) NewOrderListDTO *item;

@property (nonatomic,retain) UIImageView *upLineView;

@property (nonatomic,retain) UIImageView *lineView;

@property (nonatomic,weak) id<NProOrderListHeadCellDelegate> delegate;

//商品订单列表
- (void)setNProOrderListHeadCellInfo:(NewOrderListDTO*)listDto
                         WithIsCshop:(BOOL)isCshop productDto:(ProductListDTO *)productDTO;

//门店订单列表
-(void)refreshShopOrderInfoCell:(ShopOrderListDto *)dto;

//生活团购订单列表
- (void)setGroupOrderListCell:(GBOrderInfoDTO *)dto;


//退货申请
-(void)refreshReturnGoodsInfoCell:(ReturnGoodsPrepareDTO *)prepareDto;

//退货中
-(void)setReturnGoodsQueryInfoCell:(ReturnGoodsQueryDTO *)queryDto;


//C店订单物流查询NewOrderSnxpressViewController
- (void)setCshopExpressCell:(NewSnxpressDTO *)dto;

//非C店订单物流查询ServiceDetailViewController －－－门店订单物流查询
- (void)setZiYingExpressCell:(ServiceDetailDTO *)dto WithIsInStall:(BOOL)isInstall WithCode:(NSString*)verificationCode;
//商品订单详情
- (void)setNOrderDetailListHeadCellInfo:(MemberOrderNamesDTO*)listDto;

@end
