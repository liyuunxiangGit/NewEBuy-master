//
//  CSProductDetailHeadCell.h
//  SuningEBuy
//
//  Created by xmy on 19/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "DataProductBasic.h"

@interface CSProductDetailHeadCell : UIView

//xmy 2013-10-16
@property (nonatomic,retain)UILabel *deliveryLbl;//运费

@property (nonatomic,retain)UILabel *deliveryFeeLbl;

//@property (nonatomic,retain)StrikeThroughLabel *yangLab;//¥
//@property (nonatomic,retain)StrikeThroughLabel *yangActivityLab;//¥

@property (nonatomic,retain)UILabel *cSellerPointLbl;//

@property (nonatomic,retain)StrikeThroughLabel *downPriceCSLbl;//直降价
@property (nonatomic,retain)UILabel *downCSLbl;//直降价

@property (nonatomic,retain)UILabel *eGoCSLbl;//易购价
@property (nonatomic,retain)StrikeThroughLabel *eGoCSPriceLbl;//易购价


@property (nonatomic,retain)DataProductBasic *dataDto;

- (void)setCSHeadCell:(DataProductBasic*)dto;


@end
