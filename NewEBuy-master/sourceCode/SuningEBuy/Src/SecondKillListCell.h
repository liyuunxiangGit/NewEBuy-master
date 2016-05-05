//
//  SecondKillListCell.h
//  SuningEBuy
//
//  Created by cui zl on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FXLabel.h"

#import "PanicPurchaseDTO.h"
#import "Calculagraph.h"
#import "OHAttributedLabel.h"

@interface SecondKillListCell : UITableViewCell<EGOImageViewExDelegate>

@property (nonatomic, strong)   UIImageView *backgroundImageView;

@property (nonatomic, strong)   FXLabel *stateTitleLabel;
@property (nonatomic, strong)   OHAttributedLabel *timeLabel;

@property (nonatomic, strong)   FXLabel  *productDescLabel;
@property (nonatomic, strong)   EGOImageViewEx *productImageView;

@property (nonatomic, strong)   UILabel  *leftQtyLbl;
@property (nonatomic, strong)   UILabel  *priceLbl;

@property (nonatomic, readonly) PurchaseState purchaseState;
@property (nonatomic, strong)   PanicPurchaseDTO  *panicPurchaseDTO;

@property (nonatomic, strong)   Calculagraph      *calculagraph;

@property (nonatomic, strong)   UIImageView       *bottomBgImgView;
@property (nonatomic, strong)   UIImageView       *priceBgImgView;


- (void)setItem:(PanicPurchaseDTO*)dto;
- (void)setTime:(double)seconds;


@end
