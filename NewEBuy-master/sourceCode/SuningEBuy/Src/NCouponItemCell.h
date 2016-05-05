//
//  NCouponItemCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftCouponDTO.h"

@class NCouponItemCell;
@protocol NCouponItemCellDelegate <NSObject>

@optional
- (BOOL)couponCell:(NCouponItemCell *)cell shouldChangeCouponSelectState:(GiftCouponDTO *)couponDTO;
- (void)couponCell:(NCouponItemCell *)cell didChangeCouponSelectState:(GiftCouponDTO *)couponDTO;

@end

@interface NCouponItemCell : SNUITableViewCell

@property (nonatomic, strong) GiftCouponDTO *item;
@property (nonatomic, assign) BOOL      ischeckbuttonshow;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *couponNameLabel;
@property (nonatomic, strong) UILabel *endDateLabel;

@property (nonatomic, assign) id<NCouponItemCellDelegate> delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ischeckbuttonshow:(BOOL)isshow;
-(void)resetframe;
+ (CGFloat)height;

@end
