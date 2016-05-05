//
//  AccountListCell.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemeberMergeService.h"

@interface AccountListCell : SNUITableViewCell

@property (nonatomic, strong) UILabel                   *cardName;

@property (nonatomic, strong) CardNoListDTO             *item;

@end
