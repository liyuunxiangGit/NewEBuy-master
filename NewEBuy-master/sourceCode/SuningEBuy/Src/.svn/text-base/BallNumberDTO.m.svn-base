//
//  BallNumberDTO.m
//  SuningLottery
//
//  Created by yangbo on 4/6/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "BallNumberDTO.h"
#import "LotteryDataModel.h"
#import "RegexKitLite.h"

@implementation BallNumberDTO
@synthesize type = _type;
@synthesize subType = _subType;
@synthesize ballCount = _ballCount;
@synthesize minBallNumber = _minBallNumber;
@synthesize minSelectBallCount = _minSelectBallCount;
@synthesize ballArray = _ballArray;

- (id)initWithType:(LotteryType)type subType:(LotterySelectionType)subType{
    if(self = [super init])
    {
        
        _type = type;
        
        _subType = subType;
        
        _ballArray = [[NSMutableArray alloc] init];
                
        [self computeOtherParameter];
    }
    return self;
}

//通过号码字符串 初始化
- (id)initWithCcodes:(NSString *)ccodes Type:(LotteryType)type
{
    if(self = [super init])
    {
        _type = type;
        
        _ballArray = [[NSMutableArray alloc] init];
        
        if([ccodes length] >= 3)
        {            
            if([ccodes isMatchedByRegex:@"\\w*:1:1$"] || [ccodes isMatchedByRegex:@"\\w*:23:1$"])
                _subType = zhiXuan;
            else if([ccodes isMatchedByRegex:@"\\w*:1:4$"])
                _subType = zhiXuanHeZhi;
            else if([ccodes isMatchedByRegex:@"\\w*:3:1$"] || [ccodes isMatchedByRegex:@"\\w*:3:3$"])
                _subType = zuLiu;
            else if([ccodes isMatchedByRegex:@"\\w*:3:4$"])
                _subType = zuLiuHeZhi;
            else if([ccodes isMatchedByRegex:@"\\w*:2:3$"])
                _subType = zuSan;
            else if([ccodes isMatchedByRegex:@"\\w*:2:4$"])
                _subType = zuSanHeZhi;
            
        }
        
        [self computeOtherParameter];
        
        NSString *ballsStr = [[ccodes componentsSeparatedByString:@":"] objectAtIndex:0];
        
        NSArray *ballArray = [ballsStr componentsSeparatedByString:@","];
        
        for(int i = 0; i < [ballArray count]; i++)
        {
            if(_subType == zhiXuan)
            {
                NSString *str = [ballArray objectAtIndex:i];
                
                for(int j = 0; j < [str length]; j++)
                {
                    [self addBallNumber:[[str substringWithRange:NSMakeRange(j, 1)] integerValue]+i*10];
                }
                
            }else{
                [self addBallNumber:[[ballArray objectAtIndex:i] integerValue]];
            }
        }
    }
    
    return self;
}

- (void)setType:(LotteryType)type
{
    _type = type;
    
    [self computeOtherParameter];
}

- (void)setSubType:(LotterySelectionType)subType
{
    _subType = subType;
    
    [self computeOtherParameter];
}

- (void)computeOtherParameter
{
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    _ballCount =  30;
                    _minBallNumber = 0;
                    _minSelectBallCount = 3;
                }
                    break;
                case zhiXuanHeZhi:
                {
                    _ballCount = 28;
                    _minBallNumber = 0;
                    _minSelectBallCount = 1;
                }
                    break;
                case zuSan:
                {
                    _ballCount = 10;
                    _minBallNumber = 0;
                    _minSelectBallCount = 2;
                }
                    break;
                case zuLiu:
                {
                    _ballCount = 10;
                    _minBallNumber = 0;
                    _minSelectBallCount = 3;
                }
                    break;
                default:
                    _ballCount = 10;
                    _minBallNumber = 0;
                    _minSelectBallCount = 1;
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            _ballCount = 50;
            _minBallNumber = 0;
            _minSelectBallCount = 5;
        }
        default:
            break;
    }
}

- (int)bets{
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    int hundredCount = 0;   //百位号码个数
                    int tenCount = 0;       //十位号码个数
                    int bitCount = 0;       //个位号码个数
                    for(NSNumber *number in _ballArray)
                    {
                        int bRet = [number integerValue]/10;
                        if (bRet == 0) {
                            hundredCount++;
                        }else if(bRet == 1)
                        {
                            tenCount++;
                        }else if(bRet == 2)
                        {
                            bitCount++;
                        }
                    }
                    
                    return hundredCount * tenCount *bitCount;
                }
                    break;
                case zhiXuanHeZhi:
                {
                    int allArrangement = 0;
                    for (NSNumber *number in _ballArray) {
                        
                        int lotteryNum = [number integerValue] + _minBallNumber;
                        
                        for (int j = 0; j < 10; j ++) {
                            for (int m = 0; m < 10; m++) {
                                for (int n = 0; n < 10; n++) {
                                    if (j + m + n == lotteryNum) {
                                        allArrangement ++;
                                    }
                                }
                            }
                        }
                    }
                    
                    return allArrangement;
                }
                    break;
                case zuSan:
                {
                    if([_ballArray count] < 2)
                        return 0;
                    return [_ballArray count] * ([_ballArray count] -1);
                }
                    break;
                case zuLiu:
                {
                    if([_ballArray count] < 3)
                        return 0;
                    return ([_ballArray count] - 2) * ([_ballArray count] - 1) * [_ballArray count] / 6;
                }
                    break;
                    
                default:
                    return 0;
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            int tenthousandCount = 0;   //万位号码个数
            int thousandCount = 0;      //千位号码个数
            int hundredCount = 0;       //百位号码个数
            int tenCount = 0;           //十位号码个数
            int bitCount = 0;           //个位号码个数
            for(NSNumber *number in _ballArray)
            {
                int bRet = [number integerValue]/10;
                if (bRet == 0) {
                    tenthousandCount++;
                }else if(bRet == 1)
                {
                    thousandCount++;
                }else if(bRet == 2)
                {
                    hundredCount++;
                }else if(bRet == 3)
                {
                    tenCount++;
                }else if(bRet == 4)
                {
                    bitCount++;
                }
            }
            
            return tenthousandCount * thousandCount * hundredCount * tenCount *bitCount;
        }
            break;
        default:
            return 0;
            break;
    }
}

//获取号码显示字符串
- (NSString *)numberShowString
{
    if([_ballArray count] == 0)
        return nil;
    
    NSString *showString = @"";
    
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    NSString *hundredStr = @"";
                    NSString *tenStr = @"";
                    NSString *bitStr = @"";
                    for(NSNumber *number in _ballArray)
                    {
                        if([number integerValue]/10 == 0)
                        {
                            hundredStr = [hundredStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                        }else if([number integerValue]/10 == 1)
                        {
                            tenStr = [tenStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                        }else if([number integerValue]/10 == 2)
                        {
                            bitStr = [bitStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                        }
                    }
                    
                    if([tenStr length] == 0 || [bitStr length] == 0 || [hundredStr length] == 0)
                        break;
                    if (IOS7_OR_LATER)
                    {
                        showString = [NSString stringWithFormat:@"%@   %@   %@",hundredStr,tenStr,bitStr];
                    }
                    else
                        showString = [NSString stringWithFormat:@"%@ | %@ | %@",hundredStr,tenStr,bitStr];
                }
                    break;
                case zhiXuanHeZhi:
                case zuSan:
                case zuLiu:
                {
                    [LotteryDataModel sortFromLowToHigh:_ballArray];
                    
                    for(NSNumber *number in _ballArray)
                    {
                        showString = [showString stringByAppendingFormat:@"%d ", [self ballNumberWithIndex:[number integerValue]]];
                    }
                    showString = [showString substringToIndex:[showString length] -1];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            NSString *tenthousandStr = @"";
            NSString *thousandStr = @"";
            NSString *hundredStr = @"";
            NSString *tenStr = @"";
            NSString *bitStr = @"";
            for(NSNumber *number in _ballArray)
            {
                if([number integerValue]/10 == 0)
                {
                    tenthousandStr = [tenthousandStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 1)
                {
                    thousandStr = [thousandStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 2)
                {
                    hundredStr = [hundredStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 3)
                {
                    tenStr = [tenStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 4)
                {
                    bitStr = [bitStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }
            }
            
            if([tenStr length] == 0 || [bitStr length] == 0 || [hundredStr length] == 0 ||
               [thousandStr length] == 0 || [thousandStr length] == 0)
                break;
            if (IOS7_OR_LATER)
            {
                showString = [NSString stringWithFormat:@"%@   %@   %@   %@   %@",tenthousandStr,thousandStr,hundredStr,tenStr,bitStr];
            }
            else
            {
                showString = [NSString stringWithFormat:@"%@ | %@ | %@ | %@ | %@",tenthousandStr,thousandStr,hundredStr,tenStr,bitStr];
            }
            
        }
            break;
        default:
            break;
    }
    return showString;
}

//根据 _type , _subType  和 彩球index获取彩球显示的号码
- (int) ballNumberWithIndex:(int)index
{
    
    index += _minBallNumber;
    
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    return index%10;
                }
                    break;
                case zhiXuanHeZhi:
                case zuSan:
                case zuLiu:
                    return index;
                default:
                    return -1;
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            return index%10;
        }
            break;
        default:
            return -1;
            break;
    }
}

//返回选球提示
- (NSString *)tipStringForAlert:(BOOL)yesOrNo
{
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                    return L(@"Each select at least one ball");
                    break;
                case zhiXuanHeZhi:
                {
                    return L(@"Please select at least one balls");
                }
                    break;
                case zuSan:
                    return L(@"Please select at least two balls");
                    break;
                case zuLiu:
                    return L(@"Please select at least three balls");
                    break;
                default:
                    return nil;
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            return L(@"Each select at least one ball");
        }
            break;
        default:
            return nil;
            break;
    }
}

//机选号码
- (void)randomSelectNumber
{
    [_ballArray removeAllObjects];
    
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    for (int i = 0;  i < _minSelectBallCount; i++) {
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        
                        [LotteryDataModel getRandomArray:array randomNumCount:10 maxCount:_ballCount/_minSelectBallCount];
                        
                        [_ballArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:0] intValue] + i *10]];
                        
                    }
                }
                    break;
                case zhiXuanHeZhi:
                case zuSan:
                case zuLiu:
                {
                    [LotteryDataModel getRandomArray:_ballArray randomNumCount:_minSelectBallCount maxCount:_ballCount+_minBallNumber];
                }
                    break;
                
                default:
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            for (int i = 0;  i < _minSelectBallCount; i++) {
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                [LotteryDataModel getRandomArray:array randomNumCount:10 maxCount:_ballCount/_minSelectBallCount];
                
                [_ballArray addObject:[NSNumber numberWithInt:[[array objectAtIndex:0] intValue] + i *10]];
                
            }
        }
        default:
            break;
    }
    
}

//添加某个选球
- (BOOL)addBallNumber:(int)number
{
    
    for(int i = 0; i < [_ballArray count]; i++)
    {
        NSNumber *ball = [_ballArray objectAtIndex:i];
        
        if([ball integerValue] < number)
            continue;
        
        if([ball integerValue] == number)
            return NO;
        
        if([ball integerValue] > number)
        {
            [_ballArray insertObject:[NSNumber numberWithInt:number] atIndex:i];
            return YES;
        }
    }
    
    [_ballArray addObject:[NSNumber numberWithInt:number]];

    return YES;
}

//删除某个选球
- (BOOL)removeBallNumber:(int)number
{
    for(NSNumber *ball in _ballArray)
    {
        if([ball integerValue] == number)
        {
            [_ballArray removeObject:ball];
            
            return YES;
        }
    }
        
    return NO;
}

//清除所有选球
- (BOOL)clearAllBalls
{
    [_ballArray removeAllObjects];
    
    return YES;
}

- (NSString *)lotterySelectionTypeString
{
    int bets = [self bets];
    NSString *typeString = nil;
    
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    if(bets == 1)
                        typeString = L(@"LOSingleDirectly");
                    else
                         typeString = L(@"LOPluralDirectly");
                    
                }
                    break;
                 case zhiXuanHeZhi:
                {
                    typeString = L(@"Direct value");
                }
                    break;
                case zuSan:
                {
                    if(bets == 1)
                         typeString = L(@"LOThreeSingle");
                    else
                         typeString = L(@"LOThreePlural");
                }
                    break;
                case zuLiu:
                {
                    if(bets == 1)
                         typeString = L(@"LOSixSingle");
                    else
                         typeString = L(@"LOSixPlural");
                }
                    break;
                default:
                    return nil;
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            if(bets == 1)
                typeString = L(@"LOSingle");
            else
                typeString = L(@"LOPlural");
        }
            break;
        default:
            return nil;
            break;
    }
    
    if(typeString != nil)
        return [typeString stringByAppendingFormat:@"  %d%@",bets,L(@"Note")];
    else
        return nil;
}

//支付订单codes
- (NSString *)codes
{
    NSString *code = @"";
    
    switch (_type) {
        case ArrangeThree:
        {
            switch (_subType) {
                case zhiXuan:
                {
                    NSString *hundredStr = @"";
                    NSString *tenStr = @"";
                    NSString *bitStr = @"";
                    for(NSNumber *number in _ballArray)
                    {
                        if([number integerValue]/10 == 0)
                        {
                            hundredStr = [hundredStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                        }else if([number integerValue]/10 == 1)
                        {
                            tenStr = [tenStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                        }else if([number integerValue]/10 == 2)
                        {
                            bitStr = [bitStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                        }
                    }
                    
                    if([tenStr length] == 0 || [bitStr length] == 0 || [hundredStr length] == 0)
                        break;
                    
                    code = [NSString stringWithFormat:@"%@,%@,%@:1:1",hundredStr,tenStr,[bitStr substringToIndex:[bitStr length]]];
                }
                    break;
                case zhiXuanHeZhi:
                {
                    for(NSNumber *number in _ballArray)
                    {
                        code = [code stringByAppendingFormat:@"%d,", [self ballNumberWithIndex:[number integerValue]]];
                    }
                    code = [[code substringToIndex:[code length] -1] stringByAppendingString:@":1:4"];
                }
                    break;
                case zuSan:
                {
                    for(NSNumber *number in _ballArray)
                    {
                        code = [code stringByAppendingFormat:@"%d,", [self ballNumberWithIndex:[number integerValue]]];
                    }
                    code = [[code substringToIndex:[code length] -1] stringByAppendingString:@":2:3"];
                }
                    break;
                case zuLiu:
                {
                    for(NSNumber *number in _ballArray)
                    {
                        code = [code stringByAppendingFormat:@"%d,", [self ballNumberWithIndex:[number integerValue]]];
                    }
                    if([self bets] == 1)
                    {
                        code = [[code substringToIndex:[code length] -1] stringByAppendingString:@":3:1"];
                    }else{
                        code = [[code substringToIndex:[code length] -1] stringByAppendingString:@":3:3"];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case ArrangeFive:
        {
            NSString *tenthousandStr = @"";
            NSString *thousandStr = @"";
            NSString *hundredStr = @"";
            NSString *tenStr = @"";
            NSString *bitStr = @"";
            for(NSNumber *number in _ballArray)
            {
                if([number integerValue]/10 == 0)
                {
                    tenthousandStr = [tenthousandStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 1)
                {
                    thousandStr = [thousandStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 2)
                {
                    hundredStr = [hundredStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 3)
                {
                    tenStr = [tenStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }else if([number integerValue]/10 == 4)
                {
                    bitStr = [bitStr stringByAppendingFormat:@"%d",[self ballNumberWithIndex:[number integerValue]]];
                }
            }
            
            if([tenStr length] == 0 || [bitStr length] == 0 || [hundredStr length] == 0 ||
               [thousandStr length] == 0 || [thousandStr length] == 0)
                break;
            
            code = [NSString stringWithFormat:@"%@,%@,%@,%@,%@:23:1",tenthousandStr,thousandStr,hundredStr,tenStr,bitStr];
            
        }
            break;
        default:
            break;
    }
    
    return code;
}

- (id)deepCopy
{
    BallNumberDTO *copy = [[BallNumberDTO alloc] init];
    
    copy.type = _type;
    
    copy.subType = _subType;

    copy.ballCount = _ballCount;
    
    copy.minBallNumber = _minBallNumber;
    
    copy.minSelectBallCount = _minSelectBallCount;
    
    copy.ballArray = [NSMutableArray arrayWithArray:_ballArray];
    
    return copy;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_ballArray);
    
}

@end
