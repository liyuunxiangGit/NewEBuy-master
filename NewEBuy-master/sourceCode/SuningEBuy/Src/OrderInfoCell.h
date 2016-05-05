//
//  OrderInfoCell.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"


@interface OrderInfoCell : SNUITableViewCell
{
    
}

@property (nonatomic, strong)      OHAttributedLabel    *orderPrice;

@property (nonatomic, strong)      UIButton             *selectBtn;
@property (nonatomic, strong)      UIImageView          *selectImage;

@property (nonatomic, strong)      UIButton             *helpBtn;

@property (nonatomic, assign)     BOOL hasAddLine;
- (void)setDiscountAttrText:(NSString *)orderPrice;

- (void)initOrderPrice:(NSString *)orderPrice isSelect:(BOOL)isSelect;

@end
