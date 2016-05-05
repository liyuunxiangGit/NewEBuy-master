//
//  PurchasePruductListCell.h
//  SuningEBuy
//
//  Created by cui zl on 13-6-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FXLabel.h"

#import "PanicPurchaseDTO.h"
#import "Calculagraph.h"
#import "OHAttributedLabel.h"
#import "PurchasePictureView.h"

@interface PurchasePruductListCell : UITableViewCell<EGOImageViewExDelegate>

@property (nonatomic, strong)   UIImageView *backgroundImageView;

@property (nonatomic, strong)   FXLabel *stateTitleLabel;
//@property (nonatomic, retain)   OHAttributedLabel *timeLabel;

@property (nonatomic, strong)   FXLabel  *productDescLabel;
@property (nonatomic, strong)   EGOImageViewEx *productImageView;

@property (nonatomic, strong)   UILabel  *leftQtyLbl;
@property (nonatomic, strong)   UILabel  *priceLbl;

@property (nonatomic, readonly) PurchaseState purchaseState;
@property (nonatomic, strong)   PanicPurchaseDTO  *panicPurchaseDTO;

@property (nonatomic, strong)   Calculagraph      *calculagraph;

@property (nonatomic, strong)   UIImageView       *bottomBgImgView;
@property (nonatomic, strong)   UIImageView       *priceBgImgView;
@property (nonatomic,strong)    UIButton  *timeButtonOne;
@property (nonatomic,strong)    UIButton  *timeButtonTwo;
@property (nonatomic,strong)    UIButton  *timeButtonThree;
@property (nonatomic ,strong)   PurchasePictureView *purchasePicture;


- (void)setItem:(PanicPurchaseDTO*)dto;
- (void)setTime:(double)seconds;

@end
