//
//  OrderDetailBottomCell.h
//  SuningEBuy
//
//  Created by xmy on 10/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProOrderLastCell.h"
#import "MemberOrderNamesDTO.h"
#import "MemberOrderDetailsDTO.h"

#import "OHAttributedLabel.h"


@interface OrderDetailBottomCell : NProOrderLastCell

@property (nonatomic, strong) UIButton  *bottomPayBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *yiGouBtn;

@property (nonatomic, strong)OHAttributedLabel *bottomLbl;

//订单列表
- (void)setListBottomCellInfo;

//门店订单详情
- (void)setShopBottomCellInfo:(ShopDetailItemDto*)dto;

//生活团购订单详情
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto;

//退货中列表
- (void)setReturnGoodsBottomCellInfo;


//订单详情
- (void)setBottomCellInfo:(MemberOrderNamesDTO*)dto
               productDto:(MemberOrderDetailsDTO *)productDto
             WithYiGouBtn:(UIButton*)btn;

@end
