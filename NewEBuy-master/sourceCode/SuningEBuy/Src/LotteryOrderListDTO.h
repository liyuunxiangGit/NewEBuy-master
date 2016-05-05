//
//  LotteryOrderListDTO.h
//  SuningLottery
//
//  Created by yangbo on 4/10/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BallSelectConstant.h"
#import "BallNumberDTO.h"

/*
 彩票订单类 定义彩票的类型 所有注数号码 倍投 追号等信息
 */
@interface LotteryOrderListDTO : NSObject
{
    LotteryType                 _type;                         //彩票类型
    
    int                         _multiple;                     //投注倍数
    
    int                         _periods;                      //追号期数
    
    BOOL                        _isStopBuyWhenWin;             //中奖后是否停止追号
    
    float                       _maxPay;                       //单笔订单最大购买金额
    
    NSMutableArray              *_lotteryBetArray;             //购买的彩票号码列表
}

@property (nonatomic)   LotteryType             type;
@property (nonatomic)   int                     multiple;
@property (nonatomic)   int                     periods;
@property (nonatomic)   BOOL                    isStopBuyWhenWin;
@property (nonatomic)   float                   maxPay;

- (id)initWithType:(LotteryType) type;

//计算注数
- (int)computeBets;

//判断金额是否超过单笔订单最大金额
- (BOOL)isPayMoneyOverFlow;

//判断能否添加一注新号码
- (BOOL)shouldAddNewNumberWithBet:(int)bet;

//添加一注新的号码
- (BOOL)addNewBallNumberDto:(BallNumberDTO *)dto;

//获取一注已选的号码
- (BallNumberDTO *)ballNumberDtoWithIndex:(int)index;

//替换某注号码
- (BOOL)replaceBallNumberDtoAtIndex:(int)index withDto:(BallNumberDTO *)ballNumberDto;

//获取号码列表个数
- (NSInteger)getCountOfNumbers;

//清除所有号码
- (void)removeAllNumbers;

//删除某组号码
- (BOOL)removeBallNumberDtoWithIndex:(int)index;

//支付订单codes
- (NSString *)codes;

- (NSMutableArray *)showStrArray;

//通过ccodes添加彩票号码
- (BOOL)addBetsWithCcodes:(NSString *)ccodes;

//订单金额
- (NSString *)totalMoney;
@end
