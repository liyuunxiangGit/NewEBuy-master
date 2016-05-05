//
//  CalendarViewHeaderView.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 itotemstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITTCalendarViewHeaderViewDelegate;

@interface ITTCalendarViewHeaderView : UIView
{
    NSString        *_title;
    id<ITTCalendarViewHeaderViewDelegate> _delegate;
}

@property (nonatomic, retain) id<ITTCalendarViewHeaderViewDelegate> delegate;

@property (nonatomic, retain) IBOutlet UIButton *previousMonthButton;
@property (nonatomic, retain) IBOutlet UIButton *nextMonthButton;

@property (nonatomic, retain) NSString *title;

+ (ITTCalendarViewHeaderView*) viewFromNib;

@end

@protocol ITTCalendarViewHeaderViewDelegate <NSObject>
@optional
- (void)calendarViewHeaderViewNextMonth:(ITTCalendarViewHeaderView*)calendarHeaderView;
- (void)calendarViewHeaderViewPreviousMonth:(ITTCalendarViewHeaderView*)calendarHeaderView;
- (void)calendarViewHeaderViewDidCancel:(ITTCalendarViewHeaderView*)calendarHeaderView;
- (void)calendarViewHeaderViewDidSelection:(ITTCalendarViewHeaderView*)calendarHeaderView;
@end
