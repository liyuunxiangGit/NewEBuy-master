//
//  CICalendarView.h
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInDTO.h"
#import "CICalendarGridView.h"
#import "CIDate.h"
#import "CheckInDTO.h"

@class CICalendarLogic;
@protocol CICalendarViewDelegate;


#define kCICalendarWidth        294
#define kCICalendarHeight       348

#define kCICalHeaderHeight      30

#define kCICalGridWidth         42
#define kCICalGridHeight        52

@interface CICalendarView : UIView <CICalGridViewDelegate>
{
    CICalendarLogic *logic;
    CheckInDTO      *dataSource;
}

- (id)initWithDelegate:(id<CICalendarViewDelegate>)delegate
            dataSource:(CheckInDTO *)dto;

@property (nonatomic, weak) id<CICalendarViewDelegate> delegate;
@property (nonatomic, strong) CIDate *currentMonth;
@property (nonatomic, strong) UIView *gridContentView;
@property (nonatomic, copy) SNBasicBlock gridContentHeightChangeBlock;

- (void)reloadWithDatasource:(CheckInDTO *)dto;

@end

#pragma mark -

@protocol CICalendarViewDelegate <NSObject>

- (void)didSelectGridView:(CICalendarGridView *)gridView forDate:(CIDate *)date;

@end
