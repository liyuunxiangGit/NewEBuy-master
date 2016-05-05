//
//  ArrangeBallSelectView.h
//  SuningLottery
//
//  Created by yangbo on 4/3/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallNumberDTO.h"
#import "BallSelectConstant.h"

@protocol ArrangeBallSelectViewDelegate <NSObject>

//选择或取消选择某个号码
- (void)selectOrCancelSelectBall;

//判断是否超过订单最大金额
- (BOOL)isTotalPayOverflow;
@end

@interface ArrangeBallSelectView : UIView
{
    BallNumberDTO               *_ballNumberDTO;
    
    UIScrollView                *_scrollView;
    
    
    id <ArrangeBallSelectViewDelegate> __weak _delegate;
}

@property (nonatomic, weak) id <ArrangeBallSelectViewDelegate> delegate;

//初始化方法 确定彩票类型（排列三或排列五），投注方法
- (id) initWithFrame:(CGRect)rect ballNumberDto:(BallNumberDTO *)dto;

//根据投注号码刷新view
- (void)refreshViewWithBallDTO:(BallNumberDTO *)ballNumberDTO;

//获取选号结果
- (BallNumberDTO *)getSelectionBallNumber;

//清空所选号码
- (void)clearSelectedNumber;

//随即选择一组号码
- (void)randomSelectNumber;

//判断选择的号码 是否满足投注要求
- (BOOL)isSelectNumbersValid;
@end
