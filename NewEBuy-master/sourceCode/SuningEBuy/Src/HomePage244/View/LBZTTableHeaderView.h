//
//  LBZTTableHeaderView.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LianBanFloorDTO.h"

@interface LBZTTableHeaderView : UIView


@property (nonatomic, strong) EGOImageViewEx *bgImage;
@property (nonatomic, strong) UILabel        *titleLabel;

- (void)updateViewWithDTO:(LianBanFloorDTO *)dto;

@end
