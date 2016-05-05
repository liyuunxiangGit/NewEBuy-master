//
//  LotteryItemCell.h
//  SuningEBuy
//
//  Created by david david on 12-6-27.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryHallDto.h"
#import "OHAttributedLabel.h"

@interface LotteryItemCell : SNUITableViewCell

@property(nonatomic, strong) UIImageView       *backgroundImageView; // 背景图片
@property(nonatomic, strong) UIImageView       *lotteryImageView;    // 彩种logo
@property(nonatomic, strong) UILabel           *lotteryNameLbl;      // 彩种名称
@property(nonatomic, strong) UILabel           *poolkeyLbl;          // 奖池滚存
@property(nonatomic, strong) UILabel           *poolValueLbl;        // 奖池滚存的值
@property(nonatomic, strong) OHAttributedLabel *timesLbl;            // 期数
@property(nonatomic, strong) UILabel           *timeLbl;             // 截至时间
@property(nonatomic, strong) UIImageView       *backgroundtopImageView;
@property(nonatomic, strong) UIImageView       *shadowbackgroundImageView;
@property(nonatomic, strong) UILabel           *lotteryRewardLbl;

@property(nonatomic, strong) LotteryHallDto *hallDto;

- (void)setItem:(LotteryHallDto *)dto;

- (BOOL)isNullOrEmpty:(NSString *)string;

- (NSString *)addCommaToPoolValue:(NSString *)string;

@end
