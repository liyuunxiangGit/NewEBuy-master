//
//  RipplesView.h
//  SpaceFlow
//
//  Created by Kristopher on 14-8-20.
//  Copyright (c) 2014年 Kristopher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RipplesView : UIView

@property (assign, nonatomic) CGFloat  red;

@property (assign, nonatomic) CGFloat  green;

@property (assign, nonatomic) CGFloat  blue;

@property (assign, nonatomic) CGFloat  alpha;

@property (assign, nonatomic) CGPoint  rippleCenter;

@property (assign, nonatomic) CGFloat  innerRadius;

@property (assign, nonatomic) CGFloat  outerRadius;

@property (assign, nonatomic) CGFloat  speed;//default value is 1.0

@property (assign, nonatomic) NSUInteger  rippleNumber;//1

@property (assign,readonly,nonatomic) BOOL isAnimation;

- (void)startAnimation;

- (void)stopAnimation;

@end
