//
//  SevenLeSelectBallView.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryBallCountChooseView.h"
#import "BallButton.h"

@protocol SevenLeSelectBallViewDelegate;


@interface SevenLeSelectBallView : UIScrollView<LotteryBallCountChooseViewDelegate>

@property(nonatomic,weak)id  <SevenLeSelectBallViewDelegate>ballSelectDelegate;

- (id)initWithBallCount:(NSInteger)ballCount minNumber:(NSInteger)minNum maxNumber:(NSInteger)maxNum;

- (void)randomChooseBall:(NSMutableArray*)selectedBallArr;

+ (CGFloat)height:(NSInteger)ballCount;

- (void)setSelectedCountText:(NSInteger)selectedCount;

- (void)setBall;

- (void)removeView;

@end

@protocol SevenLeSelectBallViewDelegate <NSObject>

/*
 Notes：
 增加选中的球的下标
 */
- (BOOL)ballSelect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType ;
/*
 Notes：
 删除选中的球的下标
 */
- (BOOL)ballUnselect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType ;

/*
 
 Notes：
 随机选择球
 
 */
- (BOOL)randomBallSelect:(NSInteger)randomCount;

/*
 
 Notes：
 选择随机球的个数
 
 */
- (BOOL)ballCountSelect:(NSInteger)ballCount;



@end
