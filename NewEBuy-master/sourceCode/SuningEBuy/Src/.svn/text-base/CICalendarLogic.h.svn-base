//
//  CICalendarLogic.h
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIDate.h"

@interface CICalendarLogic : NSObject
{
    NSDate *baseDate;
    NSDate *fromDate;
    NSDate *toDate;
    NSArray *daysInSelectedMonth;
    NSArray *daysInFinalWeekOfPreviousMonth;
    NSArray *daysInFirstWeekOfFollowingMonth;
    NSDateFormatter *monthAndYearFormatter;
}

@property (nonatomic, retain) NSDate *baseDate;    // The first day of the currently selected month
@property (nonatomic, retain, readonly) NSDate *fromDate;  // The date corresponding to the tile in the upper-left corner of the currently selected month
@property (nonatomic, retain, readonly) NSDate *toDate;    // The date corresponding to the tile in the bottom-right corner of the currently selected month
@property (nonatomic, retain, readonly) NSArray *daysInSelectedMonth;             // array of KalDate
@property (nonatomic, retain, readonly) NSArray *daysInFinalWeekOfPreviousMonth;  // array of KalDate
@property (nonatomic, retain, readonly) NSArray *daysInFirstWeekOfFollowingMonth; // array of KalDate
@property (nonatomic, readonly) NSString *selectedMonthNameAndYear; // localized (e.g. "September 2010" for USA locale)

- (id)initForDate:(NSDate *)date; // designated initializer.

- (void)retreatToPreviousMonth;
- (void)advanceToFollowingMonth;
- (void)moveToMonthForDate:(NSDate *)date;

@end
