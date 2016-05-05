//
//  LotteryBallCountChooseView.h
//  SuningEBuy
//
//  Created by shasha on 12-6-29.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

@protocol LotteryBallCountChooseViewDelegate ;

@interface LotteryBallCountChooseView : UIView

@property(nonatomic,weak)id  <LotteryBallCountChooseViewDelegate>ballCountDelegate;

- (void)setMinCount:(NSInteger)minCount maxCount:(NSInteger)maxCount;

@end

@protocol LotteryBallCountChooseViewDelegate <NSObject>

- (void)chooseBallCount:(NSInteger)ballCount;

@end
