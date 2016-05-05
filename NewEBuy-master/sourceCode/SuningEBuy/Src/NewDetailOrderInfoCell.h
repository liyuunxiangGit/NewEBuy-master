//
//  NewDetailOrderInfoCell.h
//  SuningEBuy
//
//  Created by xmy on 1/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CalculateLblHeightCell.h"
#import "MemberOrderDetailsDTO.h"
#import "MemberOrderNamesDTO.h"

@interface NewDetailOrderInfoCell : CalculateLblHeightCell

@property (nonatomic,retain) UILabel *orderIdLbl;//订单编号
@property (nonatomic,retain) UILabel *orderIdContextLbl;

@property (nonatomic,retain) UILabel *payLbl;//支付总额
@property (nonatomic,retain) UILabel *payContextLbl;

@property (nonatomic,retain) UILabel *timeLbl;//下单时间
@property (nonatomic,retain) UILabel *timeContextLbl;

@property (nonatomic,retain) UILabel *payWayLbl;//支付方式
@property (nonatomic,retain) UILabel *payWayContextLbl;

@property (nonatomic,retain) UILabel *orderStatusLbl;//订单状态
@property (nonatomic,retain) UILabel *orderStatusContextLbl;

@property (nonatomic,retain) UILabel *invoiceStyleLbl;//发票类型
@property (nonatomic,retain) UILabel *invoiceStyleContextLbl;


@property (nonatomic,retain) UIImageView *lineView;


@property (nonatomic,retain) UILabel *consigneeNameLbl;//收货人
@property (nonatomic,retain) UILabel *consigneeNameContextLbl;
@property (nonatomic,retain) UILabel *consigneeMobileLbl;

@property (nonatomic,retain) UILabel *addressLbl;//收货地址
@property (nonatomic,retain) UILabel *addressContextLbl;

@property (nonatomic,retain) UILabel *invoiceLbl;//发票
@property (nonatomic,retain) UILabel *invoiceContextLbl;

@property (nonatomic,retain) UILabel *verificationCodeLbl;//验证码
@property (nonatomic,retain) UILabel *verificationCodeContextLbl;



- (void)setNewDetailOrderInfoCell:(MemberOrderDetailsDTO*)dto WithDto:(MemberOrderNamesDTO*)displayDto WithListStatus:(NSString*)statusStr;

+ (CGFloat)DetailOrderInfoNewCellHeight:(MemberOrderDetailsDTO *)dto;



@end
