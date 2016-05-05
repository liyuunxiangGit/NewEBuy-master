//
//  SpaceLeafView.h
//  SpaceFlow
//
//  Created by Kristopher on 14-8-5.
//  Copyright (c) 2014年 Kristopher. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpaceLeafViewDelegate;

@interface SpaceLeafView : UIView

@property (assign, nonatomic) id<SpaceLeafViewDelegate>   delegate;

@property (assign, nonatomic) NSUInteger   index;

@property (assign, nonatomic) CGFloat   radian;

@property (assign, nonatomic) CGFloat   leafRadian;

@property (assign, nonatomic) CGFloat  blurredRatio;

@property (retain, nonatomic) UIView   *subContentView;

- (void)refreshSubContentImage;

@end


@protocol SpaceLeafViewDelegate <NSObject>
@optional
- (void)didSelectedInSpaceLeafView:(SpaceLeafView *)spaceLeafView;
@end