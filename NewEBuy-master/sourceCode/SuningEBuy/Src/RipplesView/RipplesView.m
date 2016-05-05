//
//  RipplesView.m
//  SpaceFlow
//
//  Created by Kristopher on 14-8-20.
//  Copyright (c) 2014年 Kristopher. All rights reserved.
//

#import "RipplesView.h"

@interface RipplesView(){
    CGFloat        _width,_height;
    NSTimer        *_timer;
    NSMutableArray *_radiusArray;
    NSMutableArray *_alphaArray;
    CGFloat         _gradient;
    BOOL            _isBegan;
}

@end

@implementation RipplesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _width = frame.size.width;
        _height = frame.size.height;
        _timer = nil;
        _radiusArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:0.0], nil];
        _alphaArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:1.0], nil];
        _red = 1.0;
        _green = 1.0;
        _blue = 1.0;
        _alpha = 1.0;
        _rippleCenter = CGPointMake(_width*0.5, _height*0.5);
        _innerRadius = 0.0;
        _outerRadius = (_rippleCenter.x>_rippleCenter.y)?_rippleCenter.x:_rippleCenter.y;
        _speed = 1.0;
        _rippleNumber = 1;
        _gradient = 1.0;
        _isBegan = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setRed:(CGFloat)red{
    if (red<0.0||red>1.0) {
        _red = 1.0;
    }else{
        _red = red;
    }
}

- (void)setGreen:(CGFloat)green{
    if (green<0.0||green>1.0) {
        _green = 1.0;
    }else{
        _green = green;
    }
}

- (void)setBlue:(CGFloat)blue{
    if (blue<0.0||blue>1.0) {
        _blue = 1.0;
    }else{
        _blue = blue;
    }
}

- (void)setAlpha:(CGFloat)alpha{
    if (alpha<0.0||alpha>1.0) {
        _alpha = 1.0;
    }else{
        _alpha = alpha;
    }
}


- (void)setRippleCenter:(CGPoint)rippleCenter{
    if (rippleCenter.x<=0.0||rippleCenter.x>=_width||rippleCenter.y<=0||rippleCenter.y>=_height) {
        _rippleCenter = CGPointMake(_width*0.5, _height*0.5);
    }else{
        _rippleCenter = rippleCenter;
    }
}

- (void)setInnerRadius:(CGFloat)innerRadius{
    if (innerRadius<0.0) {
        _innerRadius = 0.0;
    }else{
        _innerRadius = innerRadius;
    }
}

- (void)setOuterRadius:(CGFloat)outerRadius{
    CGFloat max = (_rippleCenter.x>_rippleCenter.y)?_rippleCenter.x:_rippleCenter.y;
    if (outerRadius<=0.0||outerRadius>max) {
        _outerRadius = max;
    }else{
        _outerRadius = outerRadius;
    }
}

- (void)setSpeed:(CGFloat)speed{
    if (speed<=0.0){
        _speed = 1.0;
    }else{
        _speed = speed;
    }
}

- (void)setRippleNumber:(NSUInteger)rippleNumber{
    if (rippleNumber<=1) {
        _rippleNumber = 1;
    }else{
        _rippleNumber = rippleNumber;
    }
    for (int i=0; i<_rippleNumber; i++) {
        _radiusArray[i] = [NSNumber numberWithFloat:0.0];
        _alphaArray[i] = [NSNumber numberWithFloat:1.0];
    }
}

- (BOOL)isAnimation{
    if (_timer) {
        return YES;
    }else{
        return NO;
    }
}


- (void)startAnimation{
    if (_outerRadius<=_innerRadius) {
        return;
    }
    if ([_radiusArray count]!=[_alphaArray count]) {
        return;
    }
    _gradient = (_outerRadius-_innerRadius)/_rippleNumber;
    _isBegan = YES;
    for (int i=0; i<_rippleNumber; i++) {
        _radiusArray[i] = [NSNumber numberWithFloat:0.0];
        _alphaArray[i] = [NSNumber numberWithFloat:1.0];
    }
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/(_speed*60.0) target:self selector:@selector(redrawRipples) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)redrawRipples{
    for (int i=0; i<_rippleNumber; i++) {
        if ([_radiusArray[i] floatValue]>=(_outerRadius-_innerRadius)) {
            _radiusArray[i] = [NSNumber numberWithFloat:0.0];
            _isBegan = NO;
        }else{
            if (_isBegan) {
                if (i>0) {
                    CGFloat frontRadius = [_radiusArray[i-1] floatValue];
                    if (frontRadius>_gradient) {
                        _radiusArray[i] = [NSNumber numberWithFloat:([_radiusArray[i] floatValue]+0.5)];
                    }
                }else{
                    _radiusArray[i] = [NSNumber numberWithFloat:([_radiusArray[i] floatValue]+0.5)];
                }
            }else{
                _radiusArray[i] = [NSNumber numberWithFloat:([_radiusArray[i] floatValue]+0.5)];
            }
        }
        
        _alphaArray[i] = [NSNumber numberWithFloat:0.7*(_outerRadius-_innerRadius-[_radiusArray[i] floatValue])/(_outerRadius-_innerRadius)];
    }
    [self setNeedsDisplay];
}

- (void)stopAnimation{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    for (int i=0; i<_rippleNumber; i++) {
        _radiusArray[i] = [NSNumber numberWithFloat:0.0];
        _alphaArray[i] = [NSNumber numberWithFloat:1.0];
    }
    [self setNeedsDisplay];
}

static NSInteger customSortAscend(id obj1, id obj2,void* context){
    if ([obj1 floatValue] > [obj2 floatValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if ([obj1 floatValue] < [obj2 floatValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
}

static NSInteger customSortDescend(id obj1, id obj2,void* context){
    if ([obj1 floatValue] < [obj2 floatValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if ([obj1 floatValue] > [obj2 floatValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSArray *radiusArraySorted = [_radiusArray sortedArrayUsingFunction:customSortAscend context:nil];
    NSArray *alphaArraySorted = [_alphaArray sortedArrayUsingFunction:customSortDescend context:nil];
    
    if (_innerRadius>0.0) {
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0].CGColor);
        CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius, 0, 2*M_PI, 0);
        CGContextFillPath(ctx);
        for (int i=0; i<_rippleNumber; i++) {
            if ([radiusArraySorted[i] floatValue]==0.0) {
                continue;
            }
            CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:_red green:_green blue:_blue alpha:_alpha*[alphaArraySorted[i] floatValue]].CGColor);
            if (i==0) {
                CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius, 0, 2*M_PI, 0);
                CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius+[radiusArraySorted[i] floatValue], 0, 2*M_PI, 0);
                CGContextEOFillPath(ctx);
            }else{
                if ([radiusArraySorted[i-1] floatValue]==0.0) {
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius, 0, 2*M_PI, 0);
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius+[radiusArraySorted[i] floatValue], 0, 2*M_PI, 0);
                    CGContextEOFillPath(ctx);
                }else{
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius+[radiusArraySorted[i-1] floatValue], 0, 2*M_PI, 0);
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, _innerRadius+[radiusArraySorted[i] floatValue], 0, 2*M_PI, 0);
                    CGContextEOFillPath(ctx);
                }
            }
        }
    }else{
        for (int i=0; i<_rippleNumber; i++) {
            if ([radiusArraySorted[i] floatValue]==0.0) {
                continue;
            }
            CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:_red green:_green blue:_blue alpha:_alpha*[alphaArraySorted[i] floatValue]].CGColor);
            if (i==0) {
                CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, [radiusArraySorted[i] floatValue], 0, 2*M_PI, 0);
                CGContextFillPath(ctx);
            }else{
                if ([radiusArraySorted[i-1] floatValue]==0.0) {
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, [radiusArraySorted[i] floatValue], 0, 2*M_PI, 0);
                    CGContextFillPath(ctx);
                }else{
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, [radiusArraySorted[i-1] floatValue], 0, 2*M_PI, 0);
                    CGContextAddArc(ctx, _rippleCenter.x, _rippleCenter.y, [radiusArraySorted[i] floatValue], 0, 2*M_PI, 0);
                    CGContextEOFillPath(ctx);
                }
            }
        }
    }
}

@end
