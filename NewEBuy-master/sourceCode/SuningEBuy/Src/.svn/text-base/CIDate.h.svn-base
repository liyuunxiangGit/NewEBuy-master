//
//  CIDate.h
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CIDate : NSObject
{
    struct {
        unsigned int month : 4;
        unsigned int day : 5;
        unsigned int year : 15;
    } a;
}

+ (CIDate *)dateForDay:(unsigned int)day month:(unsigned int)month year:(unsigned int)year;
+ (CIDate *)dateFromNSDate:(NSDate *)date;

- (id)initForDay:(unsigned int)day month:(unsigned int)month year:(unsigned int)year;
- (unsigned int)day;
- (unsigned int)month;
- (unsigned int)year;
- (NSDate *)NSDate;
- (NSComparisonResult)compare:(CIDate *)otherDate;

- (CIDate *)previousMonth;
- (CIDate *)followingMonth;
- (BOOL)isEqualToMonth:(CIDate *)monthDate;

- (CIDate *)yesterday;
- (CIDate *)tomorrow;

@end


@interface NSDate (KalAdditions)

// All of the following methods use [NSCalendar currentCalendar] to perform
// their calculations.

- (NSDate *)cc_dateByMovingToBeginningOfDay;
- (NSDate *)cc_dateByMovingToEndOfDay;
- (NSDate *)cc_dateByMovingToFirstDayOfTheMonth;
- (NSDate *)cc_dateByMovingToFirstDayOfThePreviousMonth;
- (NSDate *)cc_dateByMovingToFirstDayOfTheFollowingMonth;
- (NSDate *)cc_dateByMovingToYesterday;
- (NSDate *)cc_dateByMovingToTomorrow;
- (NSDateComponents *)cc_componentsForMonthDayAndYear;
- (NSUInteger)cc_weekday;
- (NSUInteger)cc_numberOfDaysInMonth;

@end
