//
//  SalePromotionCell.h
//  SuningEBuy
//
//  Created by GUO on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuanTiDTO.h"
#import "HomeModuleDTO.h"

@protocol SalePromotionCellDelegate;

@interface SalePromotionCell : UITableViewCell<EGOImageButtonDelegate>

- (void)setViewsWith:(ZhuanTiDTO *)dto;

@property (nonatomic, assign) id<SalePromotionCellDelegate>  delegate;

@end

@protocol SalePromotionCellDelegate <NSObject>

@optional
- (void)goToTargetPageWithHMDTO:(HomeModuleDTO *)dto;
- (void)goToTargetPageWithTopAD:(TopADInfoDTO *)dto;
@end