//
//  CIDate.m
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CIDate.h"

@implementation CIDate

+ (CIDate *)dateForDay:(unsigned int)day month:(unsigned int)month year:(unsigned int)year
{
    return [[CIDate alloc] initForDay:day month:month year:year];
}

+ (CIDate *)dateFromNSDate:(NSDate *)date
{
    NSDateComponents *parts = [date cc_componentsForMonthDayAndYear];
    return [CIDate dateForDay:[parts day] month:[parts month] year:[parts year]];
}

- (id)initForDay:(unsigned int)day month:(unsigned int)month year:(unsigned int)year
{
    if ((self = [super init])) {
        a.day = day;
        a.month = month;
        a.year = year;
    }
    return self;
}

- (unsigned int)day { return a.day; }
- (unsigned int)month { return a.month; }
- (unsigned int)year { return a.year; }

- (NSDate *)NSDate
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = a.day;
    c.month = a.month;
    c.year = a.year;
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

- (NSComparisonResult)compare:(CIDate *)otherDate
{
    NSInteger selfComposite = a.year*10000 + a.month*100 + a.day;
    NSInteger otherComposite = [otherDate year]*10000 + [otherDate month]*100 + [otherDate day];
    
    if (selfComposite < otherComposite)
        return NSOrderedAscending;
    else if (selfComposite == otherComposite)
        return NSOrderedSame;
    else
        return NSOrderedDescending;
}

- (CIDate *)previousMonth
{
    NSDate *date = [self NSDate];
    NSDate *preDate = [date cc_dateByMovingToFirstDayOfThePreviousMonth];
    return [CIDate dateFromNSDate:preDate];
}

- (CIDate *)followingMonth
{
    NSDate *date = [self NSDate];
    NSDate *followDate = [date cc_dateByMovingToFirstDayOfTheFollowingMonth];
    return [CIDate dateFromNSDate:followDate];
}

- (CIDate *)yesterday
{
    NSDate *date = [self NSDate];
    NSDate *preDate = [date cc_dateByMovingToYesterday];
    return [CIDate dateFromNSDate:preDate];
}

- (CIDate *)tomorrow
{
    NSDate *date = [self NSDate];
    NSDate *preDate = [date cc_dateByMovingToTomorrow];
    return [CIDate dateFromNSDate:preDate];
}


- (BOOL)isEqualToMonth:(CIDate *)monthDate
{
    if (self.year == monthDate.year && self.month == monthDate.month)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark -
#pragma mark NSObject interface

- (BOOL)isEqual:(id)anObject
{
    if (![anObject isKindOfClass:[CIDate class]])
        return NO;
    
    CIDate *d = (CIDate*)anObject;
    return a.day == [d day] && a.month == [d month] && a.year == [d year];
}

- (NSUInteger)hash
{
    return a.day;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%u/%u/%u", a.month, a.day, a.year];
}


@end


@implementation NSDate (KalAdditions)

- (NSDate *)cc_dateByMovingToBeginningOfDay
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)cc_dateByMovingToEndOfDay
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)cc_dateByMovingToFirstDayOfTheMonth
{
    NSDate *d = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&d interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day the month based on %@", self);
    return d;
}

- (NSDate *)cc_dateByMovingToFirstDayOfThePreviousMonth
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = -1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] cc_dateByMovingToFirstDayOfTheMonth];
}

- (NSDate *)cc_dateByMovingToFirstDayOfTheFollowingMonth
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = 1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] cc_dateByMovingToFirstDayOfTheMonth];
}

- (NSDate *)cc_dateByMovingToYesterday
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (NSDate *)cc_dateByMovingToTomorrow
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (NSDateComponents *)cc_componentsForMonthDayAndYear
{
    return [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
}

- (NSUInteger)cc_weekday
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}

- (NSUInteger)cc_numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}

@end
