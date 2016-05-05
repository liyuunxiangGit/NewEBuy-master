//
//  Welfare3DBallChooseView.h
//  SuningLottery
//
//  Created by jian  zhang on 12-9-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallSelectConstant.h"

@protocol Welfare3DBallChooseViewDelegate;

@interface Welfare3DBallChooseView : UIScrollView
{
    
}

@property (nonatomic, assign) int                        ballType;

@property (nonatomic, weak) id<Welfare3DBallChooseViewDelegate>    welfare3DDelegate;


- (void)reloadBallCount:(NSInteger)ballCount minNumber:(NSInteger)minNum BallType:(int)ballType;

- (void)randomChooseBall:(NSMutableArray*)selectedBallArr;


@end

@protocol Welfare3DBallChooseViewDelegate <NSObject>

@optional
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
