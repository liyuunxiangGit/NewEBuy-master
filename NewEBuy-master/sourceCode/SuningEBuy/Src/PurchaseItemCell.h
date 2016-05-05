//
//  PurchaseItemCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-3-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanicPurchaseDTO.h"
#import "Calculagraph.h"
#import "PurchaseCardView.h"

@protocol PurchaseItemCellDelegate <NSObject>

- (void)joinPurchase:(id)dto;

@end

@interface PurchaseItemCell : UITableViewCell


@property (nonatomic, strong) PanicPurchaseDTO *item;

@property (nonatomic, strong) Calculagraph *cal;

@property (nonatomic, weak) id<PurchaseItemCellDelegate> delegate;



+ (CGFloat)height;

@end
