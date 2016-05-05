//
//  LotterySelectTopView.h
//  SuningEBuy
//
//  Created by shasha on 12-6-29.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "OHAttributedLabel.h"
#import "LotteryHallDto.h"
@interface LotterySelectTopView : UIView


@property(nonatomic,strong)OHAttributedLabel *pastTimesLabel;
@property(nonatomic,strong)OHAttributedLabel *nowTimesLabel;
@property(nonatomic,strong)UIImageView   *seperateLine;
@property(nonatomic,strong)UIImageView  *backGroudImageView;


- (void)setLabelsInfo:(LotteryHallDto *)dto;

@end
