//
//  NProDetailShopExitCell.h
//  SuningEBuy
//
//  Created by xmy on 23/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

@interface NProDetailShopExitCell : UITableViewCell

@property (nonatomic,retain)UIImageView *backView;//背景图片

@property (nonatomic,retain)UIImageView *arrowImageV;

@property (nonatomic,retain)UILabel *shopNumInfoLbl;//卖家数

@property (nonatomic, strong) UIImageView   *seperateLineOne;
@property (nonatomic, strong) UIImageView   *seperateLineTwo;

- (void)setNProDetailShopExitCellInfo:(DataProductBasic*)dto;

+ (CGFloat)NProDetailShopExitCellHeight:(DataProductBasic *)dto;



@end
