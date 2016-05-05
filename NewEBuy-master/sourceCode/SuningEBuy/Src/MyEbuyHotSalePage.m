//
//  MyEbuyHotSalePage.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyEbuyHotSalePage.h"
#import "DataProductBasic.h"
#import "MyEbuyHotSaleImageView.h"

@interface MyEbuyHotSalePage()

@property (nonatomic, strong) NSArray *hotSaleList;
@property (nonatomic, assign) NSRange range;

@property (nonatomic, strong) MyEbuyHotSaleImageView *leftImageView;
@property (nonatomic, strong) MyEbuyHotSaleImageView *centerImageView;
@property (nonatomic, strong) MyEbuyHotSaleImageView *rightImageView;

- (void)loadImageViewAtIndex:(NSInteger)index;

- (void)removeImageViewAtIndex:(NSInteger)index;
@end

/*********************************************************************/

@implementation MyEbuyHotSalePage
@synthesize delegate = _delegate;

@synthesize hotSaleList = _hotSaleList;
@synthesize range = _range;
@synthesize leftImageView = _leftImageView;
@synthesize centerImageView = _centerImageView;
@synthesize rightImageView = _rightImageView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_hotSaleList);
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_centerImageView);
    TT_RELEASE_SAFELY(_rightImageView);
}

- (void)setItem:(NSArray *)itemList range:(NSRange)range
{
    if (itemList == nil) {
        return;
    }
    self.hotSaleList = itemList;
    self.range = range;
    
    for (int i = 0; i < 3; i++) {
        if (i + range.location >= [itemList count]) {
            [self removeImageViewAtIndex:i];
            continue;
        }
        [self loadImageViewAtIndex:i];
    }
}

- (void)removeImageViewAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self.leftImageView removeFromSuperview];
            self.leftImageView = nil;
            break;
        case 1:
            [self.centerImageView removeFromSuperview];
            self.centerImageView = nil;
            break;
        case 2:
            [self.rightImageView removeFromSuperview];
            self.rightImageView = nil;
            break;
        default:
            break;
    }
}

- (void)loadImageViewAtIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:
            [self.leftImageView setItem:[self.hotSaleList objectAtIndex:index+_range.location]];
            self.leftImageView.indexArray = index+_range.location;
            break;
        case 1:
            [self.centerImageView setItem:[self.hotSaleList objectAtIndex:index+_range.location]];
            self.centerImageView.indexArray = index+_range.location;
            break;
        case 2:
            [self.rightImageView setItem:[self.hotSaleList objectAtIndex:index+_range.location]];
            self.rightImageView.indexArray = index+_range.location;
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark views

- (MyEbuyHotSaleImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[MyEbuyHotSaleImageView alloc] init];
        _leftImageView.frame = CGRectMake(15, 10, 85, 140);
        _leftImageView.delegate = self.delegate;
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (MyEbuyHotSaleImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[MyEbuyHotSaleImageView alloc] init];
        _centerImageView.frame = CGRectMake(self.leftImageView.right + 17, 10, 85, 140);
        _centerImageView.delegate = self.delegate;
        [self addSubview:_centerImageView];
    }
    return _centerImageView;
}

- (MyEbuyHotSaleImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[MyEbuyHotSaleImageView alloc] init];
        _rightImageView.frame = CGRectMake(self.centerImageView.right + 17, 10, 85, 140);
        _rightImageView.delegate = self.delegate;
        [self addSubview:_rightImageView];
    }
    return _rightImageView;
}

@end
