//
//  LotterySelectBallView.h
//  SuningEBuy
//
//  Created by shasha on 12-6-28.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//
#import "LotteryBallCountChooseView.h"
#import "BallSelectConstant.h"

#define kBallStartTag     100

@protocol LotterySelectBallViewDelegate;


@interface LotterySelectBallView : UIView<LotteryBallCountChooseViewDelegate >

@property(nonatomic,assign)LotteryBallType  ballType;
@property(nonatomic,weak)id  <LotterySelectBallViewDelegate>ballSelectDelegate;

- (id)initWithBallCount:(NSInteger)ballCount minNumber:(NSInteger)minNum maxNumber:(NSInteger)maxNum;

- (void)randomChooseBall:(NSMutableArray*)selectedBallArr;

+ (CGFloat)height:(NSInteger)ballCount;

- (void)setSelectedCountText:(NSInteger)selectedCount;

- (void)removeView;

@end

@protocol LotterySelectBallViewDelegate <NSObject>

/*
 Notes：
 增加选中的球的下标
 */
- (BOOL)ballSelect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType;
/*
 Notes：
 删除选中的球的下标
 */
- (BOOL)ballUnselect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType;

/*
 
 Notes：
 随机选择球
 
 */
- (BOOL)randomBallSelect:(LotteryBallType)ballType randomCount:(NSInteger)randomCount;

/*
 
 Notes：
 选择随机球的个数
 
 */
- (BOOL)ballCountSelect:(LotteryBallType)ballType ballNumCount:(NSInteger)ballCount;



@end
