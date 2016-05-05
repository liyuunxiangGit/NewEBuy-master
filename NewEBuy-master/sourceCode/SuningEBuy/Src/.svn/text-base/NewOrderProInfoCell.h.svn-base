//
//  NewOrderProInfoCell.h
//  SuningEBuy
//
//  Created by xmy on 30/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"

#import "MemberOrderDetailsDTO.h"
#import "MemberOrderNamesDTO.h"

#import "ShopDetailDto.h"

@interface NewOrderProInfoCell : CellsDatasCell

@property (nonatomic,retain) EGOImageView *productImageV;//商品图片
@property (nonatomic,retain) UILabel *productNameLbl;//商品名

@property (nonatomic,retain) UILabel *jiaoYanMaLbl;//商家

@property (nonatomic,retain) UILabel *shopContextLbl;//商家
@property (nonatomic,retain) UILabel *productPriceContextLbl;//商品价格

@property (nonatomic,retain) UILabel *productNumLbl;//商品数量
@property (nonatomic,retain) UILabel *productNumContextLbl;

@property (nonatomic,retain) UIImageView *lineView;

@property (nonatomic,retain) NSString *supplierStr;

@property (nonatomic,retain) UIButton *confirmBtn;//确认收货按钮
@property (nonatomic,retain) UIButton *snxpressQueryBtn;//物流查询按钮
@property (nonatomic,retain) UIButton *payBtn;//支付按钮
@property (nonatomic,retain) UIButton *cancelOrderBtn;//取消订单按钮
@property (nonatomic,retain) UIButton *returnGoodsBtn;//退货按钮

//detail
@property (nonatomic,retain) UIButton *pingJiaBtn;//评价按钮
@property (nonatomic,retain) UIButton *shaiDanBtn;//晒单按钮

@property (nonatomic,retain) UIImageView *lineTwoView;

@property (nonatomic,retain) MemberOrderNamesDTO *listDetailDto;
@property (nonatomic,retain) MemberOrderDetailsDTO *detailDto;
@property(nonatomic,strong) UIImageView     *accessView;        //小箭头

@property(nonatomic) int     row;  

@property(nonatomic,strong)     UIImageView     *lineView2;         //分割线2

@property(nonatomic,strong)     UIImageView     *lineView3;         //分割线1
@property (nonatomic, strong)   NSString        *logisticsShowReference;
@property (nonatomic, strong)   UIButton        *bothBtn;//评价晒单
//商品订单详情界面设置
- (void)setDetailNewOrderProInfo:(MemberOrderDetailsDTO*)dto
                     WithHeadDto:(MemberOrderNamesDTO *)headDto
                    WithCodeBOOL:(BOOL)isCode
                         WithRow:(int)row
                      WithFinish:(BOOL)finishAcceptOK
                    WithDelivery:(BOOL)delivertOK
                        WithIsYangGuangBao:(BOOL)isYGB
          logisticsShowReference:(NSString *)logisticsShowReference;



+ (CGFloat)orderProInfoNewCellHeight:(MemberOrderNamesDTO*)dto Withrow:(int)row;

//门店订单
- (void)setShopDetailProInfoCellInfo:(ShopDetailDto *)dto
                         WithHeadDto:(ShopDetailItemDto *)itemDto
                        WithPosition:(NSInteger)cellRow;

//门店订单详情
//- (void)setShopDetailHeadCellInfo:(ShopDetailDto*)dto
//                      WithItemDto:(ShopDetailItemDto*)itemDto
//              WithSectionPosition:(int)section
//                 WithCellPosition:(int)row;

//生活团购订单详情
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto;
+ (CGFloat)setGroupOrderDetailCellHeight:(GBOrderInfoDTO *)dto;

- (void)cShopOrderLine:(MemberOrderDetailsDTO *)dto isCShopList:(BOOL)cShopList;

//合约机
- (void)setSimCardInfo:(MemberOrderDetailsDTO *)detailDto
           WithHeadDto:(MemberOrderNamesDTO *)headDto;
@end
