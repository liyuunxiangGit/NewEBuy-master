//
//  OrderDetailBtnCell.h
//  SuningEBuy
//
//  Created by xmy on 10/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"
#import "MemberOrderNamesDTO.h"

//生活团购订单取消
#define GB_ORDER_CANCEL_FAIL  @"GB_ORDER_CANCEL_FAIL"


@interface OrderDetailBtnCell : CellsDatasCell

@property(nonatomic)     BOOL        isAddNotifition;    //生活团购中使用

@property(nonatomic,strong)     UIButton        *cancelOrderBtn;    //取消订单按钮
@property(nonatomic,strong)     UIButton        *refundBtn;    //取消订单按钮
@property (nonatomic,retain) UIButton *returnGoodsBtn;//退货按钮

- (void)setDetailBtncellInfo:(MemberOrderNamesDTO *)headDto WithOrderStatus:(NSString*)statusStr;

+ (CGFloat)setDetailBtncellInfoHeight:(MemberOrderNamesDTO *)headDto;

//退货申请
- (void)setReturnBtncellInfo;

//生活团购订单申请
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto;
//生活团购退款
- (void)setGroupRefundCell:(ReFundInfoDto *)dto;


@end
