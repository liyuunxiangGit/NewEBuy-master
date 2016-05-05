//
//  OrderDetailView.h
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailService.h"
#import "LotteryOrderDetailService.h"
//订单明细视图 显示订单编号 商品名称 投注时间 投注金额 订单状态 中奖金额信息

@protocol OrderDetailViewDelegate <NSObject>

- (void)cancelButtonClicked;

@end
@interface OrderDetailView : UIView
{
    NSMutableAttributedString *_string;
}
@property (nonatomic, unsafe_unretained) id  <OrderDetailViewDelegate>delegate;
@property(nonatomic,retain)UIButton     *cancleCoupon;
- (id)initWithOrderDetail:(TradeOrderDetailDto *)detailDto followList:(NSMutableArray *)followList withListDTO:(id)listDTO;

@end
