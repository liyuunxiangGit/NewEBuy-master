//
//  CouponInfoCell.h
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"
#import "CouponModel.h"

@class CouponInfoCell;

@protocol  CouponInfoCellDelegate<NSObject>

@optional
- (void)couponButtonClicked:(CouponInfoCell *)cell withClickedButton:(UIButton *)button;

@end
@interface CouponInfoCell : SNUITableViewCell

@property (nonatomic , strong) UIButton *stateButton;
@property (nonatomic , strong) UILabel *moneyInfoLabel;
@property (nonatomic , strong) UILabel *timeInfoLabel;
@property (nonatomic , strong) UILabel *typeInfoLabel;
@property (nonatomic , strong) CouponModel *couponMeodel;
@property (nonatomic , assign) id<CouponInfoCellDelegate> delegate;

@end
