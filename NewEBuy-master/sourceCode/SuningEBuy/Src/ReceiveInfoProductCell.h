//
//  ReceiveInfoProductCell.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartV2DTO.h"

@interface ReceiveInfoProductCell : SNUITableViewCell


@property (nonatomic, strong) UILabel       *productName;
@property (nonatomic, strong) EGOImageView  *productImageView;
@property (nonatomic, strong) UILabel       *productNum;
@property (nonatomic, strong) EGOImageView  *priceImageView;
@property (nonatomic, strong) UILabel       *priceLabel;

@property (nonatomic, strong) ShopCartV2DTO *shopCartDto;

- (void)setFee:(NSString *)fee withShopName:(NSString *)shopName;

@end
