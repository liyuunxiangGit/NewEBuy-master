//
//  CICalendarGridView.h
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIDate.h"
#import "CheckInDTO.h"

@class CICalendarGridView;
@protocol CICalGridViewDelegate <NSObject>

- (void)gridView:(CICalendarGridView *)gridView didSelectWithDate:(CIDate *)date;

@end

@interface CICalendarGridView : UIView

@property (nonatomic, strong) CIDate *date;
@property (nonatomic, strong) CheckInDTO *dto;

@property (nonatomic, strong) UIButton *gridButton;
@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UILabel *integralLabel; //云钻
@property (nonatomic, strong) UIImageView *integralImageView; //云钻单位图片
@property (nonatomic, strong) UILabel *ticketLabel;   //券
@property (nonatomic, strong) UIImageView *ticketImageView; //券单位图片
@property (nonatomic, strong) UIImageView *noRegistView; //未签到图片

@property (nonatomic, weak) id<CICalGridViewDelegate> delegate;

@end
