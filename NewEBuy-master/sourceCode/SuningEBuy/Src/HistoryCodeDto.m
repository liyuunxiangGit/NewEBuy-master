//
//  HistoryCodeDto.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "HistoryCodeDto.h"

@implementation HistoryCodeDto

- (void)dealloc
{
    TT_RELEASE_SAFELY(_pidNumber);

    TT_RELEASE_SAFELY(_pidTime);

    TT_RELEASE_SAFELY(_pidCode);

    TT_RELEASE_SAFELY(_pidSale);

    TT_RELEASE_SAFELY(_poolSale)

    TT_RELEASE_SAFELY(_row);

    TT_RELEASE_SAFELY(_week);

}

- (void)decodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil)
    {
        return;
    }

    self.pidNumber = [dic objectForKey:@"@cp"] == nil ? @"" :[dic objectForKey:@"@cp"];

    self.pidTime = [dic objectForKey:@"@tm"] == nil ? @"" :[dic objectForKey:@"@tm"];

    // 只取年月日
    if ([self.pidTime length] > 10)
    {
        self.pidTime = [self.pidTime substringToIndex:10];
    }

    // 根据时间计算星期
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];

    [inputFormatter setDateFormat:@"yyyy-MM-dd "];

    NSDate *formatterDate = [inputFormatter dateFromString:self.pidTime];

    TT_RELEASE_SAFELY(inputFormatter);

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

    [outputFormatter setDateFormat:@"EEEE"];

    self.week = [outputFormatter stringFromDate:formatterDate];

    TT_RELEASE_SAFELY(outputFormatter);

    self.pidCode = [dic objectForKey:@"@cc"] == nil ? @"" :[dic objectForKey:@"@cc"];

    self.pidSale = [dic objectForKey:@"@cs"] == nil ? @"" :[dic objectForKey:@"@cs"];

    self.poolSale = [dic objectForKey:@"@cm"] == nil ? @"" :[dic objectForKey:@"@cm"];

    self.row = [dic objectForKey:@"@rm"] == nil ? @"" :[dic objectForKey:@"@rm"];
}

@end
