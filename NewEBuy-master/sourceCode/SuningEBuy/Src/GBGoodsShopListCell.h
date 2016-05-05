//
//  GBGoodsShopListCell.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBShopsListDTO.h"

@interface GBGoodsShopListCell : UITableViewCell

@property (nonatomic, copy) NSString    *tuanType;

@property (nonatomic, strong) GBShopsListDTO            *gbShopsListDTO;

@property (nonatomic, strong) UIButton                  *callBtn;

+ (CGFloat)height:(GBShopsListDTO *)dto withTuanType:(NSString *)tuanType;

@end
