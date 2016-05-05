//
//  NewDetailDeliveryInfoCell.h
//  SuningEBuy
//
//  Created by xmy on 31/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CalculateLblHeightCell.h"
#import "MemberOrderDetailsDTO.h"
#import "MemberOrderNamesDTO.h"

@interface NewDetailDeliveryInfoCell : CalculateLblHeightCell

@property (nonatomic,retain) UILabel *consigneeNameLbl;//收货人
@property (nonatomic,retain) UILabel *consigneeNameContextLbl;
@property (nonatomic,retain) UILabel *consigneeMobileLbl;

@property (nonatomic,retain) UILabel *addressLbl;//收货地址
@property (nonatomic,retain) UILabel *addressContextLbl;

@property (nonatomic,retain) UILabel *invoiceLbl;//发票
@property (nonatomic,retain) UILabel *invoiceContextLbl;

@property (nonatomic,retain) UILabel *verificationCodeLbl;//验证码
@property (nonatomic,retain) UILabel *verificationCodeContextLbl;


- (void)setDetailDeliveryInfo:(MemberOrderDetailsDTO*)dto WithNameDTO:(MemberOrderNamesDTO*)nameDTO;

+ (CGFloat)DetailDeliveryInfoCellHeight:(MemberOrderDetailsDTO*)dto withName:(MemberOrderNamesDTO*)nameDto
;

@end
