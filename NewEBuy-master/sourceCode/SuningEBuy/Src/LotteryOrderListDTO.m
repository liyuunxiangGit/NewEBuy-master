//
//  LotteryOrderListDTO.m
//  SuningLottery
//
//  Created by yangbo on 4/10/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "LotteryOrderListDTO.h"

@implementation LotteryOrderListDTO
@synthesize type = _type;
@synthesize multiple = _multiple;
@synthesize periods = _periods;
@synthesize isStopBuyWhenWin = _isStopBuyWhenWin;
@synthesize maxPay = _maxPay;


- (id)initWithType:(LotteryType) type{
    if(self = [super init])
    {
        _type = type;
        
        _multiple = 1;
        
        _periods = 1;
        
        _maxPay = 2000;
        
        _isStopBuyWhenWin = YES;
        
        _lotteryBetArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (int)computeBets
{
    int bets = 0;
    for(BallNumberDTO *dto in _lotteryBetArray)
    {
        bets += [dto bets];
    }
    return bets;
}

- (BOOL)isPayMoneyOverFlow
{
    
    if([self computeBets] * _multiple * _periods * 2.0 > _maxPay)
    {
        return YES;
    }else{
        return NO;
    }

}

//判断能否添加一注新号码
- (BOOL)shouldAddNewNumberWithBet:(int)bet
{
    if(([self computeBets]+bet) * _multiple * _periods * 2.0 > _maxPay)
        return NO;
    
    return YES;
}

//添加一注新的号码
- (BOOL)addNewBallNumberDto:(BallNumberDTO *)dto
{
    if(nil == dto)
        return NO;
    
    [_lotteryBetArray insertObject:dto atIndex:0];
    
    return YES;
}

//获取一注已选的号码
- (BallNumberDTO *)ballNumberDtoWithIndex:(int)index
{
    if(index >= [_lotteryBetArray count])
        return nil;
    
    return [_lotteryBetArray objectAtIndex:index];
}

//替换某注号码
- (BOOL)replaceBallNumberDtoAtIndex:(int)index withDto:(BallNumberDTO *)ballNumberDto
{
    if(index < 0 || index >= [_lotteryBetArray count])
        return NO;
    else{
        [_lotteryBetArray replaceObjectAtIndex:index withObject:ballNumberDto];
        return YES;
    }
}

//获取号码列表个数
- (NSInteger)getCountOfNumbers
{
    return [_lotteryBetArray count];
}

//清除所有号码
- (void)removeAllNumbers
{
    [_lotteryBetArray removeAllObjects];
    
    _multiple = 1;
    _periods = 1;
}

//删除某组号码
- (BOOL)removeBallNumberDtoWithIndex:(int)index
{
    if(index >= [_lotteryBetArray count])
        return NO;
    
    [_lotteryBetArray removeObjectAtIndex:index];
    
    return YES;
}

//支付订单codes
- (NSString *)codes
{
    NSString *codes = @"";
    
    for(BallNumberDTO *dto in _lotteryBetArray)
    {
        codes = [codes stringByAppendingFormat:@"%@;",[dto codes]];
    }
    
    if([codes length] > 1)
    {
        return [codes substringToIndex:[codes length]-1];
    }else{
        return nil;
    }
}

- (NSMutableArray *)showStrArray
{
    NSMutableArray *showStrArray = [[NSMutableArray alloc] init];
    for(BallNumberDTO *dto in _lotteryBetArray)
    {
        NSString *tempStr = [dto numberShowString];
        
        NSString *redBallStr = [NSString stringWithFormat:@"<font color=red>%@</font>",tempStr];
        
        [showStrArray addObject:redBallStr];
    }
    return showStrArray;
}

- (BOOL)addBetsWithCcodes:(NSString *)ccodes
{
    NSArray *separeArray = [ccodes componentsSeparatedByString:@";"];
    
    for(NSString *str in separeArray)
    {
        BallNumberDTO *dto = [[BallNumberDTO alloc] initWithCcodes:str Type:_type];
        
        [_lotteryBetArray addObject:dto];
        
    }
    return YES;
}

- (NSString *)totalMoney
{
    return [NSString stringWithFormat:@"%d",[self computeBets] * _multiple * _periods * 2];
}

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_lotteryBetArray);
    
}

@end
