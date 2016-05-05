//
//  CalendarViewController.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdCalendarView.h"


@protocol CalendarViewControllerDelegate;


@interface CalendarViewController : CommonViewController<CalendarViewDelegate>{

    UINavigationBar      *_navigationBar;
    
    TdCalendarView       *_calendarView;
    
    UIImageView          *_backgroundImageView;
    
    id<CalendarViewControllerDelegate> __weak calendarViewControllerDelegate;
    
    UIImageView          *_leftImageView;
    
    UIImageView          *_rightImageView;
    
    UIButton             *_leftBtn;
    
    UIButton             *_rightBtn;
    
    UILabel              *_dateLbl;

    UIView               *_headView;
    
    NSString             *_navigationItemTitle;
}

//@property (nonatomic,retain) UINavigationBar *navigationBar;

@property (nonatomic,strong) TdCalendarView  *calendarView;

@property (nonatomic,strong) UIImageView     *backgroundImageView;

@property (nonatomic, weak) id<CalendarViewControllerDelegate> calendarViewControllerDelegate;

@property (nonatomic,strong) UIImageView     *leftImageView;

@property (nonatomic,strong) UIImageView     *rightImageView;

@property (nonatomic,strong) UIButton        *leftBtn;

@property (nonatomic,strong) UIButton        *rightBtn;

@property (nonatomic,strong) UILabel         *dateLbl;

@property (nonatomic,strong) UIView          *headView;

@property (nonatomic,copy)   NSString        *navigationItemTitle;


-(void)pressReturn:(id)sender;
- (id)initWithNavigationItemTitle:(NSString *)title;
@end

@protocol CalendarViewControllerDelegate <NSObject>
@optional
- (void) selectDateChanged:(CFGregorianDate) selectDate andViewController:(id)controller;
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height;
- (void) beforeMonthChange:(TdCalendarView*) tdCalendarView willto:(CFGregorianDate) currentMonth;
@end
