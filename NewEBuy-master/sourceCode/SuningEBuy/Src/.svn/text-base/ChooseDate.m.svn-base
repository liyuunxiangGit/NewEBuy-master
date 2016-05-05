//
//  ChooseDate.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ChooseDate.h"

@implementation ChooseDate

+ (NSDate*)dateFromString:(NSString*)dateStr withFormatString:(NSString *)formatString{
    
    if (IsNilOrNull(dateStr)) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:formatString];
    NSDate *date = [formatter dateFromString:dateStr];
    DLog(@"%@", dateStr);
    DLog(@"%@", [date description]);
    TT_RELEASE_SAFELY(formatter);
    return date;
    
}
//@"yyyy-M-d" = formatString
+ (NSString*)stringFromDate:(NSDate*)date withFormatString:(NSString *)formatString{
    
    if (IsNilOrNull(date)) {
        return nil;
    }
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString  *dateStr = [formatter stringFromDate:date];
    TT_RELEASE_SAFELY(formatter);
    return dateStr;
    
}

+ (NSDate *)getYesterdayDate:(NSDate *)today{
    
    if (IsNilOrNull(today)) {
        return nil;
    }
    
    NSDate *yesterday = [today dateByAddingTimeInterval:-24*3600];    
    
    DLog(@"tommorow is %@",[yesterday description]);
    
    return yesterday; 
    
}


+ (NSDate *)getDateOfFewDays:(NSInteger)dayCount{
    
    NSDate *today = [NSDate date];
    NSDate *fewsDayDate = [today dateByAddingTimeInterval:dayCount*24*3600];
    return fewsDayDate;
    
}


+ (NSDate *)getTomorowDate:(NSDate *)today{
    
    if (IsNilOrNull(today)) {
        return nil;
    }
    
    NSDate *tommorow = [today dateByAddingTimeInterval:24*3600];
    
    DLog(@"tommorow is %@",[tommorow description]);
    
    return tommorow;  
    
}


@end
