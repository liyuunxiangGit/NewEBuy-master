//
//  BallNumberDTO.h
//  SuningLottery
//
//  Created by yangbo on 4/6/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BallSelectConstant.h"


/*
 一组号码类 有彩票类型 玩法 可选彩球个数 选择的彩球号码
 */
@interface BallNumberDTO : NSObject 
{
    LotteryType                 _type;
    
    LotterySelectionType        _subType;

    int                         _ballCount;             //可选的彩球个数
    
    int                         _minBallNumber;         //最小彩球号码
    
    int                         _minSelectBallCount;    //一注需要的最小彩球个数
    
    NSMutableArray              *_ballArray;            //选择的彩球
}

@property (nonatomic) LotteryType type;

@property (nonatomic) LotterySelectionType  subType;

@property (nonatomic) int ballCount;

@property (nonatomic) int minBallNumber;

@property (nonatomic) int minSelectBallCount;

@property (nonatomic, strong)  NSMutableArray *ballArray;


- (id)initWithType:(LotteryType)type subType:(LotterySelectionType)subType;

//通过号码字符串和彩票类型 初始化
- (id)initWithCcodes:(NSString *)ccodes Type:(LotteryType)type;

//深拷贝 返回的对象retaincount为1
- (id)deepCopy;

//获取投注注数
- (int)bets;

//获取号码显示字符串
- (NSString *)numberShowString;

//根据 _ballNumberDTO.type , _subType  和 彩球index获取彩球显示的号码
- (int) ballNumberWithIndex:(int)index;

//返回选球提示
- (NSString *)tipStringForAlert:(BOOL)yesOrNo;

//机选号码
- (void)randomSelectNumber;

//添加某个选球
- (BOOL)addBallNumber:(int)number;

//删除某个选球
- (BOOL)removeBallNumber:(int)number;

//清除所有选球
- (BOOL)clearAllBalls;

//获取彩票投注类型字符串
- (NSString *)lotterySelectionTypeString;

//支付订单codes
- (NSString *)codes;
@end
