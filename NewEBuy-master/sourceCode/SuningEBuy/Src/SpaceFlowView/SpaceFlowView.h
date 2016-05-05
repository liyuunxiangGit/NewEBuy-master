//
//  SpaceFlowView.h
//  SpaceFlow
//
//  Created by Kristopher on 14-8-4.
//  Copyright (c) 2014年 Kristopher. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpaceFlowViewDelegate;

@protocol SpaceFlowViewDataSource;


@interface SpaceFlowView : UIView

@property (assign, nonatomic) id<SpaceFlowViewDelegate>   delegate;

@property (assign, nonatomic) id<SpaceFlowViewDataSource>   dataSource;

//adjust three-dimensional space radius length, default value is view's width
@property (assign, nonatomic) CGFloat   radiusRatio;

- (void)reloadData;

- (void)reloadDataFinished;

+ (CGFloat)radiusRatioRecommendVauleWithCount:(NSUInteger)count viewWidth:(CGFloat)width widthRatio:(CGFloat)widthRatio;

@end


@protocol SpaceFlowViewDelegate <NSObject>
@optional
//only for simple clicked
- (void)spaceFlowView:(SpaceFlowView *)spaceFlowView didSelectedAtIndex:(NSUInteger)index;
@end

@protocol SpaceFlowViewDataSource <NSObject>
@required
//
- (NSUInteger)numberOfChildViewsInSpaceFlowView:(SpaceFlowView *)spaceFlowView;
//default is 0.6, value must between 0 and 1
- (CGFloat)spaceFlowView:(SpaceFlowView *)spaceFlowView widthRatioAtIndex:(NSUInteger)index;
//default is 0.8, value must between 0 and 1
- (CGFloat)spaceFlowView:(SpaceFlowView *)spaceFlowView heightRatioAtIndex:(NSUInteger)index;
//if child view cotains touch action, it must be accomplished by yourself. Frame was dicided by width and height ratio cross self size.
- (UIView *)spaceFlowView:(SpaceFlowView *)spaceFlowView childViewAtIndex:(NSUInteger)index withFrame:(CGRect)frame;
@optional

@end