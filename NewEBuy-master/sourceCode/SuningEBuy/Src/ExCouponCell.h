//
//  ExCouponCell.h
//  SuningEBuy
//
//  Created by david david on 12-6-21.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExCouponDto.h"

@interface ExCouponCell : UITableViewCell

//@property(nonatomic,retain) UILabel *typeLbl;
@property(nonatomic,strong) UILabel *typeValueLbl;

@property(nonatomic,strong) UILabel *saleMoneyLbl;
@property(nonatomic,strong) UILabel *saleMoneyValueLbl;

@property(nonatomic,strong) UILabel *changeMoneyLbl;
@property(nonatomic,strong) UILabel *changeMoneyValueLbl;

@property(nonatomic,strong) UILabel *startTimeLbl;
@property(nonatomic,strong) UILabel *startTimeValueLbl;

@property(nonatomic,strong) UILabel *endTimeLbl;
@property(nonatomic,strong) UILabel *endTimeValueLbl;

@property(nonatomic,strong) UILabel *operateTimeLbl;
@property(nonatomic,strong) UILabel *operateTimeValueLbl;

@property(nonatomic,strong) UILabel *commonLbl;
@property(nonatomic,strong) UILabel *commonValueLbl;



-(void)setItem:(ExCouponDto *)dto;

+(CGFloat)height;

@end
