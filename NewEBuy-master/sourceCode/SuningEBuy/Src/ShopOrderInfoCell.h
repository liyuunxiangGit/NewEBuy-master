//
//  ShopOrderInfoCell.h
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopOrderListDto.h"

@interface ShopOrderInfoCell : UITableViewCell

@property(nonatomic,strong) UIImageView  *backView;
@property(nonatomic,strong) UILabel      *orderIdLbl;
@property(nonatomic,strong) UILabel      *updateTimeLbl;
@property(nonatomic,strong) UILabel      *totoaPriceLbl;
@property(nonatomic,strong) UILabel      *priceLbl;

@property (nonatomic,strong) ShopOrderListDto *item;

-(void)refreshShopOrderInfoCell:(ShopOrderListDto *)dto;

@end
