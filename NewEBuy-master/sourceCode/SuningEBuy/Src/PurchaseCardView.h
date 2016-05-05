//
//  PurchaseCardView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseConstant.h"

#import "NJPageScrollViewCell.h"

@class GroupPurchaseDTO;
@class PanicPurchaseDTO;
@protocol PurchaseCardViewDelegate;

@interface PurchaseCardView : NJPageScrollViewCell <EGOImageViewExDelegate>
{
    @private
    PurchaseType    purchaseType_;
    
    PurchaseState   purchaseState_;
    
    
}

@property (nonatomic, strong) GroupPurchaseDTO *groupPurchaseDTO;

@property (nonatomic, strong) PanicPurchaseDTO *panicPurchaseDTO;

@property (nonatomic, weak) id<PurchaseCardViewDelegate> delegate;

@property (nonatomic, readonly) PurchaseType purchaseType;

@property (nonatomic, readonly) PurchaseState purchaseState;

@property (nonatomic, strong) UIView *contentView;
- (void)setItem:(id)dto;

- (void)setTime:(NSTimeInterval)seconds;

@end


@protocol PurchaseCardViewDelegate <NSObject>

- (void)joinPurchase:(id)dto;

- (void)touchTheImageView:(id)dto;

@end