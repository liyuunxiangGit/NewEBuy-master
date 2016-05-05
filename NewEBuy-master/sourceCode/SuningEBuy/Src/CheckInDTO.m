//
//  CheckInDTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CheckInDTO.h"

@implementation CheckInDTO

- (NSArray *)arrayBySeparateStringChar:(NSString *)string
{
    if (string.length)
    {
        NSMutableArray *temArr = [NSMutableArray arrayWithCapacity:[string length]];
        
        const char *str = [string UTF8String];
        for (int i = 0; i < string.length; i++)
        {
            char c = str[i];
            NSString *s = [[NSString alloc] initWithBytes:&c
                                                   length:1
                                                 encoding:NSUTF8StringEncoding];
            [temArr addObject:s];
        }
        
        return temArr;
    }
    return nil;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    self.errCode   = EncodeStringFromDic(dic,@"errorCode");
    
    self.checkType = EncodeStringFromDic(dic, @"checkType");
    self.checkTitle = EncodeStringFromDic(dic, @"checkTitle");
    self.isCheck = EncodeStringFromDic(dic, @"isCheck");
    self.checkRuleDesc = EncodeStringFromDic(dic, @"checkRuleDesc");
    self.checkCount = EncodeStringFromDic(dic, @"checkCount");
    self.largessType = EncodeStringFromDic(dic, @"largessType");
    self.dayNum = EncodeStringFromDic(dic, @"dayNum");
    self.residueDay = EncodeStringFromDic(dic, @"residueDay");
    
    
    self.checkInfoList = EncodeArrayFromDic(dic, @"checkInfoList");
    
    if ([self.checkInfoList count] > 0)
    {
        NSDictionary *checkItem = [self.checkInfoList objectAtIndex:0];
        NSString *curMonth = EncodeStringFromDic(checkItem, @"curMonth");
        NSString *preMonth = EncodeStringFromDic(checkItem, @"preMonth");
                
        self.currMonthCheckList = [self arrayBySeparateStringChar:curMonth];
        self.preMonthCheckList = [self arrayBySeparateStringChar:preMonth];
    }
    
    self.prePointsList = EncodeArrayFromDic(dic, @"prePointsList");
    self.curPointsList = EncodeArrayFromDic(dic, @"curPointsList");
    self.nextPointsList = EncodeArrayFromDic(dic, @"nextPointsList");
    self.preCouponList = EncodeArrayFromDic(dic, @"preCouponList");
    self.curCouponList = EncodeArrayFromDic(dic, @"curCouponList");
    self.nextCouponList = EncodeArrayFromDic(dic, @"nextCouponList");
    
    self.currentDateStr = EncodeStringFromDic(dic, @"currentDate");
    self.activeStartDateStr = EncodeStringFromDic(dic, @"ActiveStartDate");

    if (self.currentDateStr.length == 8)
    {
        NSInteger y = [[_currentDateStr substringToIndex:4] integerValue];
        NSInteger m = [[_currentDateStr substringWithRange:NSMakeRange(4, 2)] integerValue];
        NSInteger d = [[_currentDateStr substringFromIndex:6] integerValue];
        self.currentDate = [[CIDate alloc] initForDay:d
                                                month:m
                                                 year:y];
    }
    else
    {
        self.currentDate = [CIDate dateFromNSDate:[NSDate date]];
    }
    
    if (self.activeStartDateStr.length == 8)
    {
        NSInteger y = [[_activeStartDateStr substringToIndex:4] integerValue];
        NSInteger m = [[_activeStartDateStr substringWithRange:NSMakeRange(4, 2)] integerValue];
        NSInteger d = [[_activeStartDateStr substringFromIndex:6] integerValue];
        self.activeStartDate = [[CIDate alloc] initForDay:d
                                                    month:m
                                                     year:y];
    }
}

- (NSString *)pointInDate:(CIDate *)date
{
    if ([date isEqualToMonth:self.currentDate]) //当前月
    {
        if ([self.curPointsList count] > 0)
        {
            NSDictionary *dic = (NSDictionary *)[self.curPointsList objectAtIndex:0];
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                //如果未登录
                BOOL isLogin = [UserCenter defaultCenter].isLogined;
                unsigned int daySubKey = isLogin?date.day:date.day-self.currentDate.day+1;
                NSString *key = [NSString stringWithFormat:@"day%d",daySubKey];
                NSString *value = [dic objectForKey:key];
                if (value.integerValue > 0)
                {
                    return value;
                }
                else
                {
                    return nil;
                }
            }
        }
    }
    else if ([date isEqualToMonth:self.currentDate.previousMonth]) //上月
    {
        if ([self.prePointsList count] > 0)
        {
            NSDictionary *dic = (NSDictionary *)[self.prePointsList objectAtIndex:0];
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                NSString *key = [NSString stringWithFormat:@"day%d", date.day];
                NSString *value = [dic objectForKey:key];
                if (value.integerValue > 0)
                {
                    return value;
                }
                else
                {
                    return nil;
                }
            }
        }
    }
    else if ([date isEqualToMonth:self.currentDate.followingMonth]) //下月
    {
        if ([self.nextPointsList count] > 0)
        {
            NSDictionary *dic = (NSDictionary *)[self.nextPointsList objectAtIndex:0];
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                NSString *key = [NSString stringWithFormat:@"day%d", date.day];
                NSString *value = [dic objectForKey:key];
                if (value.integerValue > 0)
                {
                    return value;
                }
                else
                {
                    return nil;
                }
            }
        }
    }
    
    return nil;

}

- (NSString *)couponInDate:(CIDate *)date
{
    if ([date isEqualToMonth:self.currentDate]) //当前月
    {
        if ([self.curCouponList count] > 0)
        {
            NSDictionary *dic = (NSDictionary *)[self.curCouponList objectAtIndex:0];
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                //如果未登录
                BOOL isLogin = [UserCenter defaultCenter].isLogined;
                unsigned int daySubKey = isLogin?date.day:date.day-self.currentDate.day+1;
                NSString *key = [NSString stringWithFormat:@"day%d", daySubKey];
                NSString *value = [dic objectForKey:key];
                if (value.integerValue > 0)
                {
                    return value;
                }
                else
                {
                    return nil;
                }
            }
        }
    }
    else if ([date isEqualToMonth:self.currentDate.previousMonth]) //上月
    {
        if ([self.preCouponList count] > 0)
        {
            NSDictionary *dic = (NSDictionary *)[self.preCouponList objectAtIndex:0];
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                NSString *key = [NSString stringWithFormat:@"day%d", date.day];
                NSString *value = [dic objectForKey:key];
                if (value.integerValue > 0)
                {
                    return value;
                }
                else
                {
                    return nil;
                }
            }
        }
    }
    else if ([date isEqualToMonth:self.currentDate.followingMonth]) //下月
    {
        if ([self.nextCouponList count] > 0)
        {
            NSDictionary *dic = (NSDictionary *)[self.nextCouponList objectAtIndex:0];
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                NSString *key = [NSString stringWithFormat:@"day%d", date.day];
                NSString *value = [dic objectForKey:key];
                if (value.integerValue > 0)
                {
                    return value;
                }
                else
                {
                    return nil;
                }
            }
        }
    }
    
    return nil;
}

- (CICheckState)checkStateInDate:(CIDate *)date
{
    //是否登录
    BOOL isLogin = [UserCenter defaultCenter].isLogined;

    if ([date isEqualToMonth:self.currentDate])
    {
        //当前月
        int index = date.day - 1;
        if ([self.currMonthCheckList count] > index)
        {
            NSString *token = [self.currMonthCheckList objectAtIndex:index];
            if ([token isEqualToString:@"0"])
            {
                //未登录展示空白
                return isLogin?CICheckStateUnCheck:CICheckStateOnBlank;
            }
            else if ([token isEqualToString:@"1"])
            {
                return CICheckStateNormalCheck;
            }
            else
            {
                return CICheckStateActivityCheck;
            }
        }
        else if (date.day == self.currentDate.day)
        {
            //当天
            if ([UserCenter defaultCenter].isLogined)
            {
                if ([self.isCheck isEqualToString:@"0"])
                {
                    return CICheckStateTodayUncheck;
                }
                else
                {
                    if ([self.checkType isEqualToString:@"00001"])
                    {
                        return CICheckStateNormalCheck;
                    }
                    else
                    {
                        return CICheckStateActivityCheck;
                    }
                }
            }
            else
            {
                return CICheckStateTodayUncheck;
            }
        }
        else if (date.day < self.currentDate.day)
        {
            //未登录展示空白
            return isLogin?CICheckStateUnCheck:CICheckStateOnBlank;
        }
        else
        {
            //剩余天数
            return CICheckStateOnCheck;
        }
    }
    else if ([date isEqualToMonth:self.currentDate.previousMonth])
    {
        //上月
        int index = date.day - 1;
        if ([self.preMonthCheckList count] > index)
        {
            NSString *token = [self.preMonthCheckList objectAtIndex:index];
            if ([token isEqualToString:@"0"])
            {
                //未登录展示空白
                return isLogin?CICheckStateUnCheck:CICheckStateOnBlank;
            }
            else if ([token isEqualToString:@"1"])
            {
                return CICheckStateNormalCheck;
            }
            else
            {
                return CICheckStateActivityCheck;
            }
        }
        else
        {
            //未登录展示空白
            return isLogin?CICheckStateUnCheck:CICheckStateOnBlank;
        }
    }
    else if ([date isEqualToMonth:self.currentDate.followingMonth])
    {
        //下月
        return CICheckStateOnCheck;
    }
    else
    {
        //超出的月
        return CICheckStateOnBlank;
    }
}

- (BOOL)setStateCheckedToToday
{
    self.isCheck = @"1";
    return YES;
}

@end
