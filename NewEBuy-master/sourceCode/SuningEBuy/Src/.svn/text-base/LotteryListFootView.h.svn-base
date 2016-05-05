//
//  LotteryListFootView.h
//  SuningLottery
//
//  Created by yangbo on 4/9/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"

#define LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT    70     //topView高度

#define LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT 40     //middleView高度

#define LOTTERY_LIST_FOOT_BOTTOMVIEW_HEIGHT 40     //bottomView高度

#define LOTTERY_LIST_FOOT_VIEW_WIDTH        [[UIScreen mainScreen] bounds].size.width       //视图宽度

#define LOTTERY_LIST_FOOT_VIEW_HEIGHT       (LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT+\
                                            LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT+\
                                            LOTTERY_LIST_FOOT_BOTTOMVIEW_HEIGHT)           //视图高度                               

@protocol LotteryListFootViewDelegate <NSObject>

//添加手选号码
- (void)addNewNumber;

//添加机选号码
- (void)addRandomNumber;

//追号
- (void)changeLotteryPeriods:(int)periods;

//倍投
- (void)changeLotteryMultiple:(int)multiple;

//清除所有号码
- (void)clearAllNumbers;

//去付款
- (void)gotoPayForLottery;

//是否中奖后停止追号
- (void)isStopBuyWhenWin:(BOOL)yesOrNo;

//判断输入的追号期数和倍投是否超过单笔订单最大投注金额
- (BOOL)isMoneyOverFlowWithMultiple:(int)multiple andPeriods:(int)periods;
@end

@interface LotteryListFootView : CommonView <UITextFieldDelegate>
{
    int         _multiple;              //投注倍数
    
    int         _periods;               //追号期数
        
    BOOL        _isPeriodStopWhenWin;   //是否中奖后停止追号
    
    id<LotteryListFootViewDelegate> __weak _delegate;
}

@property (nonatomic,readonly) int       multiple;
@property (nonatomic,readonly) int       periods;
@property (nonatomic, readonly) BOOL     isPeriodStopWhenWin;
@property (nonatomic, weak)  id<LotteryListFootViewDelegate> delegate;
//originY：原点Y坐标
- (id)initWithYOrigin:(float)originY;

//bet: 注数  multiple:投注倍数  periods:追号期数 yesOrNo:是否中奖后停止追号
- (void)updateWithMultiple:(int)multiple bets:(int)bet periods:(int)periods isBuyWhenWin:(BOOL)yesOrNo;

@end
