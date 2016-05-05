//
//  GBPayTableviewCell.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"

@interface GBPayTableviewCell : SNUITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

- (void)setTitle:(NSString *)title detailStr:(NSString *)detail;
@end
