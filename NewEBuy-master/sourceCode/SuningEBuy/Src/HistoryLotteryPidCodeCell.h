//
//  HistoryLotteryPidCodeCell.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryCodeDto.h"

@interface HistoryLotteryPidCodeCell : SNUITableViewCell

@property (nonatomic, strong) UILabel *pidNumLabel;             // 开奖期数

@property (nonatomic, strong) UILabel *timeLabel;               // 开奖时间

@property (nonatomic, strong) UILabel *weekLabel;               // 星期

@property (nonatomic, strong) UIImageView *cutLineImageView;    // 分割线

- (void)setItem:(HistoryCodeDto *)dto lotteryID:(int)lotteryId; // 展示开奖号码
@end
