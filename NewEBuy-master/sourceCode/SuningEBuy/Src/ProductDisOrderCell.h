//
//  ProductDisOrderCell.h
//  SuningEBuy
//
//  Created by caowei on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisProductDetailsDTO.h"

@interface ProductDisOrderCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *nickNameLabel;

@property (nonatomic,strong) UILabel *createTimeLabel;

@property (nonatomic,strong) DisProductDetailsDTO *dataSource;

@property (nonatomic, strong) UIImageView   *cellSeperater;

- (void)setItem:(DisProductDetailsDTO *)aItem;

+ (CGFloat)height:(DisProductDetailsDTO *)item;

@end
