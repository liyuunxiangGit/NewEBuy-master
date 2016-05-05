//
//  SalePromotionCell.h
//  SuningEBuy
//
//  Created by GUO on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SalePromotionCellDelegate;

@interface SalePromotionCell : UITableViewCell<EGOImageButtonDelegate>

- (void)setViewsForModel:(NSString *)model;

@property (nonatomic, unsafe_unretained) id<SalePromotionCellDelegate>  delegate;

@end

@protocol SalePromotionCellDelegate <NSObject>

@optional
- (void)didSelectPromotionImage;
@end