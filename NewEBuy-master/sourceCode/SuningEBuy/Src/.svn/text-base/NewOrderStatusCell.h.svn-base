//
//  NewOrderStatusCell.h
//  SuningEBuy
//
//  Created by xmy on 30/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CalculateLblHeightCell.h"
//#import "MemberOrderDetailsDTO.h"
#import "MemberOrderNamesDTO.h"
#import "MemberOrderDetailsDTO.h"

@class NewOrderStatusCell;

@protocol NewOrderStatusCellDelegate <NSObject>

- (void)snxpressQueryDelegate;

@end

@interface NewOrderStatusCell : CalculateLblHeightCell
{
    float cellHeight;

}

@property (nonatomic,assign) id<NewOrderStatusCellDelegate>delegate;

@property (nonatomic,retain) UILabel *orderStatusLbl;//订单状态
@property (nonatomic,retain) UILabel *orderStatusContextLbl;

@property (nonatomic,retain) UIButton *confirmBtn;//确认收货按钮
@property (nonatomic,retain) UIButton *snxpressQueryBtn;//物流查询按钮
@property (nonatomic,retain) UIButton *payBtn;//支付按钮
@property (nonatomic,retain) UIButton *cancelOrderBtn;//取消订单按钮


//detail
@property (nonatomic,retain) UIButton *pingJiaBtn;//评价按钮
@property (nonatomic,retain) UIButton *shaiDanBtn;//晒单按钮

@property (nonatomic,retain) UIImageView *lineView;

@property (nonatomic,retain) MemberOrderNamesDTO *listDetailDto;
@property (nonatomic,retain) MemberOrderDetailsDTO *detailDto;

//详情
- (void)setNewOrderStatusWithLine:(BOOL)isLine WithListSt:(NSString*)str WithDetailDto:(MemberOrderNamesDTO*)statusDto WithDto:(MemberOrderDetailsDTO*)detailDto;


+ (CGFloat)orderStatusNewCellHeight:(MemberOrderNamesDTO*)dto;



@end
