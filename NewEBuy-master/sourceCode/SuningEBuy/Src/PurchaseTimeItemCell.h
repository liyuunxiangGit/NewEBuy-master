//
//  PurchaseTimeItemCell.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"
#import "PanicPurchaseDTO.h"
#import "Calculagraph.h"

@interface PurchaseTimeItemCell : SNUITableViewCell

@property (nonatomic, strong) PanicPurchaseDTO *item;

@property (nonatomic, strong) Calculagraph *cal;


+ (CGFloat)height;

@end
