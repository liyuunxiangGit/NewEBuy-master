//
//  LotterySelectBottomView.h
//  SuningEBuy
//
//  Created by shasha on 12-7-1.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BallSelectConstant.h"
#import "OHAttributedLabel.h"

@protocol LotterySelectBottomViewDelegate;

@interface LotterySelectBottomView : UIView<OHAttributedLabelDelegate>

@property(nonatomic,weak)id  <LotterySelectBottomViewDelegate>bottomDelegate;
@property(nonatomic,assign)LotteryType     ballType;


-(void)setResultChoice:(NSMutableArray *)blueArr redArr:(NSMutableArray *)redArr LottertType:(LotteryType)lotteryType multiNo:(int)mutiNo periods:(int)periods;

@end

@protocol LotterySelectBottomViewDelegate <NSObject>

- (void)submit:(NSString *)resultStr;

- (void)reChoose;

@end
