//
//  NServiceTrackListCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogisticsQueryDTO.h"

#import "ProductUtil.h"
#import "NewOrderListDTO.h"

@interface NServiceTrackListCell : UITableViewCell<EGOImageViewDelegate>

@property (nonatomic, strong) UILabel         *ProductNameInfoLabel;
@property (nonatomic, strong) UILabel         *DiliveryModeLabel;
@property (nonatomic, strong) UILabel         *DiliveryModeInfoLabel;
@property (nonatomic, strong) UILabel         *AmountLabel;
@property (nonatomic, strong) UILabel         *AmountInfoLabel;
@property (nonatomic, strong) EGOImageView    *iconImageView;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

-(void)refreshCell:(ProductListDTO *)dto;

@end
