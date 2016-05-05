//
//  ServiceTrackListCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogisticsQueryDTO.h"

#import "ProductUtil.h"

#import "NewOrderListDTO.h"


@interface ServiceTrackListCell : SNUITableViewCell<EGOImageViewDelegate>{
    
    
}

//@property (nonatomic, strong) OrderItemDTO *aItem;

@property (nonatomic, strong) UILabel         *ProductNameInfoLabel;

@property (nonatomic, strong) UILabel         *DiliveryModeLabel;
@property (nonatomic, strong) UILabel         *DiliveryModeInfoLabel;
@property (nonatomic, strong) UILabel         *AmountLabel;
@property (nonatomic, strong) UILabel         *AmountInfoLabel;
@property (nonatomic, strong) EGOImageView    *iconImageView;
@property (nonatomic, strong) UIImageView     *separateLine;

@property (nonatomic, strong) ProductListDTO *aItem;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

//- (void)setServiceQueryDto:(OrderItemDTO *)item;
- (void)setServiceQueryDto:(ProductListDTO *)item;


@end
