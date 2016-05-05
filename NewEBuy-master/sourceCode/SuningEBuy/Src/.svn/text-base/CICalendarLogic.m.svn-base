//
//  CICalendarLogic.m
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CICalendarLogic.h"

@interface CICalendarLogic()

- (void)moveToMonthForDate:(NSDate *)date;
- (void)recalculateVisibleDays;
- (NSUInteger)numberOfDaysInPreviousPartialWeek;
- (NSUInteger)numberOfDaysInFollowingPartialWeek;

@property (nonatomic, retain) NSDate *fromDate;
@property (nonatomic, retain) NSDate *toDate;
@property (nonatomic, retain) NSArray *daysInSelectedMonth;
@property (nonatomic, retain) NSArray *daysInFinalWeekOfPreviousMonth;
@property (nonatomic, retain) NSArray *daysInFirstWeekOfFollowingMonth;

@end

/*********************************************************************/

@implementation CICalendarLogic

@synthesize baseDate, fromDate, toDate, daysInSelectedMonth, daysInFinalWeekOfPreviousMonth, daysInFirstWeekOfFollowingMonth;

+ (NSSet *)keyPathsForValuesAffectingSelectedMonthNameAndYear
{
    return [NSSet setWithObjects:@"baseDate", nil];
}

- (id)initForDate:(NSDate *)date
{
    if ((self = [super init])) {
        monthAndYearFormatter = [[NSDateFormatter alloc] init];
        [monthAndYearFormatter setDateFormat:@"LLLL yyyy"];
        [self moveToMonthForDate:date];
    }
    return self;
}

- (id)init
{
    return [self initForDate:[NSDate date]];
}

- (void)moveToMonthForDate:(NSDate *)date
{
    self.baseDate = [date cc_dateByMovingToFirstDayOfTheMonth];
    [self recalculateVisibleDays];
}

- (void)retreatToPreviousMonth
{
    [self moveToMonthForDate:[self.baseDate cc_dateByMovingToFirstDayOfThePreviousMonth]];
}

- (void)advanceToFollowingMonth
{
    [self moveToMonthForDate:[self.baseDate cc_dateByMovingToFirstDayOfTheFollowingMonth]];
}

- (NSString *)selectedMonthNameAndYear;
{
    return [monthAndYearFormatter stringFromDate:self.baseDate];
}

#pragma mark Low-level implementation details

- (NSUInteger)numberOfDaysInPreviousPartialWeek
{
    return [self.baseDate cc_weekday] - 1;
}

- (NSUInteger)numberOfDaysInFollowingPartialWeek
{
    NSDateComponents *c = [self.baseDate cc_componentsForMonthDayAndYear];
    c.day = [self.baseDate cc_numberOfDaysInMonth];
    NSDate *lastDayOfTheMonth = [[NSCalendar currentCalendar] dateFromComponents:c];
    return 7 - [lastDayOfTheMonth cc_weekday];
}

- (NSArray *)calculateDaysInFinalWeekOfPreviousMonth
{
    NSMutableArray *days = [NSMutableArray array];
    
    NSDate *beginningOfPreviousMonth = [self.baseDate cc_dateByMovingToFirstDayOfThePreviousMonth];
    int n = [beginningOfPreviousMonth cc_numberOfDaysInMonth];
    int numPartialDays = [self numberOfDaysInPreviousPartialWeek];
    NSDateComponents *c = [beginningOfPreviousMonth cc_componentsForMonthDayAndYear];
    for (int i = n - (numPartialDays - 1); i < n + 1; i++)
        [days addObject:[CIDate dateForDay:i month:c.month year:c.year]];
    
    return days;
}

- (NSArray *)calculateDaysInSelectedMonth
{
    NSMutableArray *days = [NSMutableArray array];
    
    NSUInteger numDays = [self.baseDate cc_numberOfDaysInMonth];
    NSDateComponents *c = [self.baseDate cc_componentsForMonthDayAndYear];
    for (int i = 1; i < numDays + 1; i++)
        [days addObject:[CIDate dateForDay:i month:c.month year:c.year]];
    
    return days;
}

- (NSArray *)calculateDaysInFirstWeekOfFollowingMonth
{
    NSMutableArray *days = [NSMutableArray array];
    
    NSDateComponents *c = [[self.baseDate cc_dateByMovingToFirstDayOfTheFollowingMonth] cc_componentsForMonthDayAndYear];
    NSUInteger numPartialDays = [self numberOfDaysInFollowingPartialWeek];
    
    for (int i = 1; i < numPartialDays + 1; i++)
        [days addObject:[CIDate dateForDay:i month:c.month year:c.year]];
    
    return days;
}

- (void)recalculateVisibleDays
{
    self.daysInSelectedMonth = [self calculateDaysInSelectedMonth];
    self.daysInFinalWeekOfPreviousMonth = [self calculateDaysInFinalWeekOfPreviousMonth];
    self.daysInFirstWeekOfFollowingMonth = [self calculateDaysInFirstWeekOfFollowingMonth];
    CIDate *from = [self.daysInFinalWeekOfPreviousMonth count] > 0 ? [self.daysInFinalWeekOfPreviousMonth safeObjectAtIndex:0] : [self.daysInSelectedMonth safeObjectAtIndex:0];
    CIDate *to = [self.daysInFirstWeekOfFollowingMonth count] > 0 ? [self.daysInFirstWeekOfFollowingMonth lastObject] : [self.daysInSelectedMonth lastObject];
    self.fromDate = [[from NSDate] cc_dateByMovingToBeginningOfDay];
    self.toDate = [[to NSDate] cc_dateByMovingToEndOfDay];
}


@end
