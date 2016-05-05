//
//  PurchaseBtnView.h
//  SuningEBuy
//
//  Created by cui zl on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PurchaseBtnViewDelegate;

@interface PurchaseBtnView : UIView

@property (nonatomic, strong) UIButton      *quickBuyBtn;

@property (nonatomic, weak) id<PurchaseBtnViewDelegate> delegate;

@end

@protocol PurchaseBtnViewDelegate <NSObject>

-(void)joinPanicPurchase;

@end
