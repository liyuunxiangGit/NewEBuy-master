//
//  ProductCustomCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupProductSimpleView.h"
#import "QuickBuyProductTimerView.h"
#import "Calculagraph.h"
#import "PurchaseConstant.h"

@interface PurchaseProductCustomCell : UITableViewCell


@property (nonatomic, assign) PurchaseType purchaseType;

@property (nonatomic, assign) PurchaseState purchaseState;

@property (nonatomic, strong) Calculagraph *calculagraph;

- (void)setItem:(id)dto;

+ (CGFloat)height:(PurchaseType)purchaseType;

@end
