//
//  InsendTimePickerView.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InsendTimePickerView.h"

@interface InsendTimePickerView()

@property (nonatomic, strong) NSArray                           *dateArray;
@property (nonatomic, strong) NSArray                           *timeArray;
@property (nonatomic, strong) NSString                          *dateWeekStr;

@end

@implementation InsendTimePickerView

- (id)initWithBaseDto:(MergeDataOptionDTO *)dateDto
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsSelectionIndicator = YES;
        
    }
    return self;
}

- (void)setDateOptionDto:(MergeDataOptionDTO *)dateOptionDto
{
    if (_dateOptionDto != dateOptionDto) {
        _dateOptionDto = dateOptionDto;
        
        self.dateArray = _dateOptionDto.dateVoList;
        DateVoDTO *dateDto = (DateVoDTO *)[self.dateArray objectAtIndex:0];
        self.dateWeekStr = [NSString stringWithFormat:@"%@ %@",dateDto.delWeek,dateDto.delDate];
        self.dateStr = dateDto.delDate;
        self.timeArray = dateDto.delTimeList;
        
        NSString *timeStr = [self.timeArray objectAtIndex:0];
        self.timeStr = timeStr;
        self.selectDateStr = [NSString stringWithFormat:@"%@ %@",self.dateWeekStr,timeStr];
        
        [self reloadComponent:0];
    }
}

#pragma mark -
#pragma mark picker view data source and delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    __block NSInteger rows = 0;
    switch (component) {
        case 0:
        {
            rows = [self.dateArray count];
            break;
        }
        case 1:
        {
            rows = [self.timeArray count];
            break;
        }
        default:
            break;
    }
    
    //ios6崩溃兼容，崩溃信息：
    //*** Assertion failure in -[UITableViewRowData rectForRow:inSection:],
    // /SourceCache/UIKit/UIKit-2372/UITableViewRowData.m:1630
    // http://stackoverflow.com/questions/12672318/assertion-failure-on-picker-view
    if (IOS6_OR_LATER) {
        return rows <= 0 ? 1 : rows;
    }
    
    return rows;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return 130.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    __block NSString *titleName = nil;
    
    switch (component) {
        case 0:
        {
            if ([_dateArray count] > row) {
                DateVoDTO *dateDto = (DateVoDTO *)[self.dateArray objectAtIndex:row];
                titleName = dateDto.dateStr;
            }
            break;
        }
        case 1:
        {
            if ([_timeArray count] > row) {
                titleName = [self.timeArray objectAtIndex:row];
            }
            break;
        }
        default:
            break;
    }
    UILabel *retval = (UILabel *)view;
    
    if (!retval)
    {
        CGRect frame = CGRectMake(0, 0, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height);
        
        retval = [[UILabel alloc] initWithFrame:frame];
        retval.adjustsFontSizeToFitWidth = YES;
        retval.backgroundColor = [UIColor clearColor];
        retval.textAlignment = UITextAlignmentCenter;
        retval.font = [UIFont boldSystemFontOfSize:20.0];
        
    }
    retval.text = titleName;
    return retval;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row < 0) {
        return;
    }
    
    switch (component)
    {
        case 0:
        {
            DateVoDTO *dateDto = (DateVoDTO *)[self.dateArray objectAtIndex:row];
            self.dateWeekStr = [NSString stringWithFormat:@"%@ %@",dateDto.delWeek,dateDto.delDate];;
            self.dateStr = dateDto.delDate;
            self.timeArray = dateDto.delTimeList;
            
            NSString *timeStr = [self.timeArray objectAtIndex:0];
            self.timeStr = timeStr;
            self.selectDateStr = [NSString stringWithFormat:@"%@ %@",self.dateWeekStr,timeStr];
            
            [self reloadComponent:1];
            break;
        }
        case 1:
        {
            NSString *timeStr = [self.timeArray objectAtIndex:row];
            self.timeStr = timeStr;
            self.selectDateStr = [NSString stringWithFormat:@"%@ %@",self.dateWeekStr,timeStr];
            break;
        }
        default:
            break;
    }
}

@end
