//
//  FlightListFilterView.m
//  SuningEBuy
//
//  Created by shasha on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FlightListFilterView.h"

#define upSelectedImage    @"orange_up_arrow.png"
#define upNormalImage      @"gray_up_arrow.png"
#define downSelectedImage  @"orange_down_arrow.png"
#define downNormalImage    @"gray_down_arrow.png"

@implementation FlightListFilterView

@synthesize delegate = _delegate;
@synthesize isPriceLowToHigh;
@synthesize isTimeEarlyToLate;

- (void)dealloc {
    _delegate = nil;
}


- (id)init {
    self = [super init];
    if (self) {
        isPriceLowToHigh = YES;
        isTimeEarlyToLate = NO;
    }
    return self;
}

- (void)layoutFlightView{
    
    [self.leftItem setSelected:NO arrowType:ItemArrowUp];
    [self.middleItem setSelected:NO arrowType:ItemArrowNone];
    [self.rightItem setSelected:NO arrowType:ItemArrowUp];
    
    UIImage *image = [UIImage newImageFromResource:@"segment_vertical_line.png"];
    self.line1.image = image;
    self.line2.image = image;

    UIImage *image1 = [UIImage newImageFromResource:@"segment_gray_line.png"];
    self.line3.image = image1;

    UIImage *image2 = [UIImage newImageFromResource:@"segment_orange_line.png"];
    self.line4.image = image2;

}

-(SegementItem *)leftItem{
    
    if (!_leftItem) {
        _leftItem = [[SegementItem alloc]init];
        _leftItem.frame = CGRectMake(0, 0, 109, 35);
        [_leftItem setTitle:L(@"voteTime_MyVoteList") forState:UIControlStateNormal];
        [_leftItem addTarget:self action:@selector(filterTime:) forControlEvents:UIControlEventTouchUpInside];
        _leftItem.upIconName = upNormalImage;
        _leftItem.upSelectedName = upSelectedImage;
        _leftItem.downIconName = downNormalImage;
        _leftItem.downSelectedName = downSelectedImage;
        [self addSubview:_leftItem];
    }
    return _leftItem;
}

-(SegementItem *)middleItem{
    
    if (!_middleItem) {
        _middleItem = [[SegementItem alloc]init];
        _middleItem.frame = CGRectMake(110, 0, 109, 35);
        [_middleItem setTitle:L(@"BTAirlineCompany") forState:UIControlStateNormal];
        [_middleItem addTarget:self action:@selector(filterCompany:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_middleItem];
    }
    return _middleItem;
}

-(SegementItem *)rightItem{
    
    if (!_rightItem) {
        _rightItem = [[SegementItem alloc]init];
        _rightItem.frame = CGRectMake(220, 0, 109, 35);
        [_rightItem setTitle:L(@"price") forState:UIControlStateNormal];
        [_rightItem addTarget:self action:@selector(filterPrice:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem.upIconName = upNormalImage;
        _rightItem.upSelectedName = upSelectedImage;
        _rightItem.downIconName = downNormalImage;
        _rightItem.downSelectedName = downSelectedImage;
        [self addSubview:_rightItem];
    }
    return _rightItem;
}

-(UIImageView *)line1{
    
    if (!_line1) {
        _line1 = [[UIImageView alloc]init];
        _line1.frame = CGRectMake(109, 8, 1, 19);
        [self addSubview:_line1];
    }
    return _line1;
}

-(UIImageView *)line2{
    
    if (!_line2) {
        _line2 = [[UIImageView alloc]init];
        _line2.frame = CGRectMake(219, 8, 1, 19);
        [self addSubview:_line2];
    }
    return _line2;
}

-(UIImageView *)line3{
    
    if (!_line3) {
        _line3 = [[UIImageView alloc]init];
        _line3.frame = CGRectMake(0, 34, 320, 1);
        [self addSubview:_line3];
    }
    return _line3;
}

-(UIImageView *)line4{
    
    if (!_line4) {
        _line4 = [[UIImageView alloc]init];
        [self addSubview:_line4];
    }
    return _line4;
}

#pragma mark -
#pragma mark 价格排序
- (void)filterPrice:(id)sender{
    
    isPriceLowToHigh = !isPriceLowToHigh;
    
    if ([self.delegate respondsToSelector:@selector(filterPrice)]) {
        
        [self.delegate filterPrice];
    }
    
    if (isPriceLowToHigh) {
        [self.rightItem setSelected:YES arrowType:ItemArrowUp];
    }else{
        [self.rightItem setSelected:YES arrowType:ItemArrowDown];
    }
    
    self.line4.frame = CGRectMake(220, 32, 109, 3);
    
    [self.leftItem setSelected:NO];
    [self.middleItem setSelected:NO];
}

#pragma mark -
#pragma mark 公司选择
- (void)filterCompany:(id)sender{
    
    if ([self.delegate respondsToSelector:@selector(filterCompany)]) {
        
        [self.delegate filterCompany];
    }
    
    [self.middleItem setSelected:YES arrowType:ItemArrowNone];
    self.line4.frame = CGRectMake(110, 32, 109, 3);
    
    [self.leftItem setSelected:NO];
    [self.rightItem setSelected:NO];
}


#pragma mark -
#pragma mark 时间排序
- (void)filterTime:(id)sender{
    
    isTimeEarlyToLate = !isTimeEarlyToLate;
    
    if ([self.delegate respondsToSelector:@selector(filterTime)]) {
        
        [self.delegate filterTime];
    }
    
    if (isTimeEarlyToLate) {
        
        [self.leftItem setSelected:YES arrowType:ItemArrowUp];
    }else{
        [self.leftItem setSelected:YES arrowType:ItemArrowDown];
    }
    
    self.line4.frame = CGRectMake(0, 32, 109, 3);
    
    [self.middleItem setSelected:NO];
    [self.rightItem setSelected:NO];
    
}

@end
