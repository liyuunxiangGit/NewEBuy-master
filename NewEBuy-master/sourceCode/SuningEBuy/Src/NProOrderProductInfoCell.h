//
//  NProOrderProductInfoCell.h
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"
#import "NewOrderListDTO.h"
#import "ShopOrderListDto.h"
#import "ReturnGoodsListDTO.h"
#import "MemberOrderDetailsDTO.h"
#import "ServiceDetailDTO.h"
#define KScelet

@interface NProOrderProductInfoCell : CellsDatasCell

@property(nonatomic,strong)     UIImageView     *backView;          //背景图片
@property(nonatomic,strong)     EGOImageButton  *iconImageView;     //商品图片
@property(nonatomic,strong)     UILabel         *productNameLbl;    //商品名称
@property(nonatomic,strong)     UILabel         *supplierLbl;       //供应商名称

@property(nonatomic,strong)     EGOImageView    *priceImageV;     //商品图片

@property(nonatomic,strong)     UILabel         *priceLbl;          //价格
@property(nonatomic,strong)     UILabel         *productNumLbl;     //商品数量
//@property(nonatomic,strong)     UIImageView     *accessView;        //小箭头
@property(nonatomic,strong)     UILabel         *orderStatusLbl;    //订单状态
@property(nonatomic,strong)     UIButton        *snxpressQueryBtn;  //物流查询按钮
@property(nonatomic,strong)     UIButton        *payBtn;            //支付按钮
@property(nonatomic,strong)     UIButton        *cancelOrderBtn;    //取消订单按钮
@property(nonatomic,strong)     UIImageView     *lineView;         //分割线2

@property(nonatomic,strong)     UIImageView     *lineView1;         //分割线1
@property(nonatomic,strong)     UIButton     *checkBtn;         //商品详情申请退货列表勾选按钮
@property(nonatomic,strong)     NSMutableArray     *checkBtnArr;         //商品详情申请退货列表勾选按钮

@property(nonatomic)     int row;

@property(nonatomic,strong)    UIButton   *confirmAcceptBtn;  //确认收货按钮
@property (nonatomic, strong) UILabel *deliveryDetail;
@property (nonatomic, strong) UILabel *arrivalTime;
@property(nonatomic,strong)     UIImageView     *lineView2;         //分割线3
@property (nonatomic, strong)  UILabel          *singlePrice; //单价

@property (nonatomic, strong) UIButton          *pingjiaBtn;// 评价按钮
@property (nonatomic, strong) UIButton          *shaidanBtn;//晒单按钮
@property (nonatomic, strong) UIButton          *bothBtn;//评价晒单按钮
@property (nonatomic, strong) UILabel           *remindLabel;//温馨提示
@property (nonatomic, assign) BOOL              isNumber;//隐藏数量-245
//商品订单列表
-(void)setNProOrderProductInfoCell:(ProductListDTO *)productDto
                          orderDto:(NewOrderListDTO *)orderDto
                          cellType:(CellViewType)cellType                            withRow:(int)row;
//门店订单列表
-(void)refreshCell:(ShopOrderItemListDto *)productDto
          orderDto:(ShopOrderListDto *)orderDto
          cellType:(CellViewType)cellType;

//生活团购订单列表
- (void)setGroupOrderListCell:(GBOrderInfoDTO *)dto;
+ (CGFloat)setGroupOrderListCellHeight:(GBOrderInfoDTO *)dto;


//商品详情申请退货列表
-(void)setOrderReturnGoodsCellInfo:(MemberOrderDetailsDTO *)prepareDto WithBtnSelect:(BOOL)isSelect;

//退货
-(void)setReturnGoodsCellInfo:(ReturnGoodsPrepareDTO *)prepareDto;
-(void)setCShopReturnGoodsCellInfo:(ReturnGoodsPrepareDTO *)prepareDto;

//退货中
-(void)setReturnGoodsQueryCellInfo:(ReturnGoodsQueryDTO *)prepareDto;

//C店订单物流查询NewOrderSnxpressViewController
- (void)setCshopExpressCell:(NewSnxpressDTO *)dto WithRow:(int)row;
+ (CGFloat)setCshopExpressCell:(NewSnxpressDTO *)dto  WithRow:(int)row;

//- (void)cShopOrderLine:(MemberOrderDetailsDTO *)dto isCShopList:(BOOL)cShopList;
- (void)setExpressCell:(ProductListDTO *)dto  WithRow:(int)row;
- (void)setNewExpressCell:(ProductListDTO *)dto  WithRow:(int)row newOrderListDTO:(ServiceDetailDTO *)serviceDetailDto;


//无理由退货
-(void)setNOReasonReturnGoodsCellInfo:(ReturnGoodsPrepareDTO *)prepareDto;

@end
