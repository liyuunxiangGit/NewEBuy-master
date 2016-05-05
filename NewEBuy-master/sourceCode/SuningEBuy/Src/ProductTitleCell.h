//
//  ProductTitleCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "MarqueeLabel.h"

@interface ProductTitleCell : UITableViewCell

@property (nonatomic, strong) DataProductBasic *productDetailDTO;

@property (nonatomic, strong) UILabel  *productNameLabel;

@property (nonatomic, strong) MarqueeLabel  *productDescLabel;


- (void)setItem:(DataProductBasic *)productDetail;

+ (CGFloat)height:(DataProductBasic *)productDetail;

@end
