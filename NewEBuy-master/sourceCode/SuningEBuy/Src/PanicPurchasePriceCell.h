//
//  PanicPurchasePriceCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-12-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductPriceCell.h"


@interface PanicPurchasePriceCell : ProductPriceCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic,strong)AddressInfoPickerView *addressPickerView;

@property (nonatomic,strong)UILabel               *panicPriceLbl;//抢购价Lbl

@property (nonatomic,strong)UILabel               *panicPriceTextLbl;

@property (nonatomic, strong)UILabel              *priceTextLbl;


- (void)setItem:(DataProductBasic *)productDetail panicPrice:(float )panicPrice;


@end