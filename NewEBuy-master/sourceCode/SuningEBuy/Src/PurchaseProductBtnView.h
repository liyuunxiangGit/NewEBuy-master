//
//  SecondKillBtnView.h
//  SuningEBuy
//
//  Created by cui zl on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PurchaseBtnDelegate <NSObject>

-(void)joinPurchase:(NSInteger)index;

@end

@interface PurchaseProductBtnView : UIView

@property (nonatomic, strong) UIButton      *wantPurchaseBtn;
@property (nonatomic, weak) id<PurchaseBtnDelegate> delegate;

-(void)updateBtnState:(NSInteger)index;

@end
