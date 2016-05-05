//
//  AccessoryProductListCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataProductBasic.h"
#import "StrikeThroughLabel.h"

@protocol AccessoryProductCheckDelegate <NSObject>

- (BOOL)accessoryProductCheckStateShouldChange:(int)index;

@end

@interface AccessoryProductListCell : UITableViewCell
{
    BOOL  isChecked;
}

@property (nonatomic, strong) UIButton          *checkButton;
@property (nonatomic, strong) EGOImageView      *iconImageView;
@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UILabel           *priceLabel;
@property (nonatomic, strong) StrikeThroughLabel  *oldPriceLabel;
@property (nonatomic, strong) DataProductBasic  *item;

@property (nonatomic, weak) id<AccessoryProductCheckDelegate> delegate;

- (void)setCheckButtonIsChecked:(BOOL)checked;

+ (CGFloat)height;

@end
