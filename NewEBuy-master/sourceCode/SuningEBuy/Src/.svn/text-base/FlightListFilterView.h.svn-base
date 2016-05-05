//
//  FlightListFilterView.h
//  SuningEBuy
//
//  Created by shasha on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SegementItem.h"

@protocol  FlightListFilterViewDelegate;

@interface FlightListFilterView : UIView

/*!
 筛选条件:价格，起飞时间，航空公司
 */
@property(nonatomic,strong) SegementItem    *leftItem;
@property(nonatomic,strong) SegementItem    *middleItem;
@property(nonatomic,strong) SegementItem    *rightItem;
@property(nonatomic,strong) UIImageView     *line1;
@property(nonatomic,strong) UIImageView     *line2;
@property(nonatomic,strong) UIImageView     *line3;
@property(nonatomic,strong) UIImageView     *line4;


@property (nonatomic, weak)id  <FlightListFilterViewDelegate>delegate;

//yes:价格从低到高  no：价格从高到低 【默认：yes】
@property (nonatomic, assign) BOOL               isPriceLowToHigh;

//yes：时间从早到晚  no：时间从晚到早  【默认 ：yes】
@property (nonatomic, assign) BOOL               isTimeEarlyToLate;

- (void)layoutFlightView;
@end

@protocol FlightListFilterViewDelegate <NSObject>

- (void)filterPrice;
- (void)filterTime;
- (void)filterCompany;

@end