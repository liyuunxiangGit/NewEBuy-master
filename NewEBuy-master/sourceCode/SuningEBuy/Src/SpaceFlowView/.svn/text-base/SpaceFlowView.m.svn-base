//
//  SpaceFlowView.m
//  SpaceFlow
//
//  Created by Kristopher on 14-8-4.
//  Copyright (c) 2014年 Kristopher. All rights reserved.
//

#import "SpaceFlowView.h"
#import "SpaceLeafView.h"

#define WidthRatioDefault   0.6
#define HeightRatioDefault  0.8


typedef struct {
    CGFloat x;
    CGFloat y;
    CGFloat z;
}Point3D;

typedef enum {
    ScrollToNone  = 0,
    ScrollToLeft  = 1,
    ScrollToRight = 2,
}ScrollDirection;

@interface SpaceFlowView()<UIGestureRecognizerDelegate,SpaceLeafViewDelegate>
{
    CGFloat                 _width;
    CGFloat                 _height;
    UIPanGestureRecognizer *_panGesture;
    UITapGestureRecognizer *_tapGesture;
    NSUInteger              _totalNumber;//
    NSUInteger              _currentIndex;//
    NSMutableArray         *_widthRatioArray;//
    NSMutableArray         *_heightRatioArray;//
    NSMutableArray         *_leafViewsArray;
    Point3D                 _circleCenter;
    CGFloat                 _circleRadius;
    CGFloat                 _leafRadian;
    CGFloat                 _velog;
    ScrollDirection         _scrollTo;
    BOOL                    _isScrolling;
    BOOL                    _isSingleStep;
    BOOL                    _canScroll;
    NSTimer                 *_timer;
    CGFloat                 _lastRadian;
}

@end

@implementation SpaceFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _delegate = nil;
        _dataSource = nil;
        _radiusRatio = 1.0;
        _width = frame.size.width;
        _height = frame.size.height;
        _panGesture = nil;
        _totalNumber = 0;
        _currentIndex = 0;
        _widthRatioArray = [[NSMutableArray alloc] initWithCapacity:0];
        _heightRatioArray = [[NSMutableArray alloc] initWithCapacity:0];
        _leafViewsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _circleCenter.x = _circleCenter.y = 0.0;
        _circleCenter.z = -_width;
        _circleRadius = _width;
        _leafRadian = 0.0;
        _velog = 1.0;
        _scrollTo = ScrollToNone;
        _isScrolling = NO;
        _isSingleStep = NO;
        _canScroll = YES;
        _timer = nil;
        _lastRadian = -1.0;
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        _panGesture.delegate = self;
        [self addGestureRecognizer:_panGesture];
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        _tapGesture.delegate = self;
        [self addGestureRecognizer:_tapGesture];
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setRadiusRatio:(CGFloat)radiusRatio{
    if (radiusRatio>0.0) {
        _radiusRatio = radiusRatio;
    }else{
        _radiusRatio = 1.0;
    }
    _circleCenter.z = -_width*_radiusRatio;
    _circleRadius = _width*_radiusRatio;
}


- (void)didSelectedInSpaceLeafView:(SpaceLeafView *)spaceLeafView{
    if (_delegate&&[_delegate respondsToSelector:@selector(spaceFlowView:didSelectedAtIndex:)]) {
        [_delegate spaceFlowView:self didSelectedAtIndex:spaceLeafView.index];
    }
}

- (UIView *)leafViewForNullWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.5;
    return view;
}


- (void)refreshBasic{
    if (_dataSource) {
        _currentIndex = 0;
        if ([_dataSource respondsToSelector:@selector(numberOfChildViewsInSpaceFlowView:)]) {
            _totalNumber = [_dataSource numberOfChildViewsInSpaceFlowView:self];
        }
        [_widthRatioArray removeAllObjects];
        [_heightRatioArray removeAllObjects];
        for (int m=0; m<[_leafViewsArray count]; m++) {
            SpaceLeafView *slv = [_leafViewsArray objectAtIndex:m];
            slv.subContentView = nil;
            [slv removeFromSuperview];
        }
        [_leafViewsArray removeAllObjects];
        
        for (int i=0; i<_totalNumber; i++) {
            if ([_dataSource respondsToSelector:@selector(spaceFlowView:widthRatioAtIndex:)]) {
                CGFloat widthRatio = [_dataSource spaceFlowView:self widthRatioAtIndex:i];
                if (widthRatio>0.0&&widthRatio<=1.0) {
                    [_widthRatioArray addObject:[NSNumber numberWithFloat:widthRatio]];
                }else{
                    [_widthRatioArray addObject:[NSNumber numberWithFloat:WidthRatioDefault]];
                }
            }
            if ([_dataSource respondsToSelector:@selector(spaceFlowView:heightRatioAtIndex:)]) {
                CGFloat heightRatio = [_dataSource spaceFlowView:self heightRatioAtIndex:i];
                if (heightRatio>0.0&&heightRatio<=1.0) {
                    [_heightRatioArray addObject:[NSNumber numberWithFloat:heightRatio]];
                }else{
                    [_heightRatioArray addObject:[NSNumber numberWithFloat:HeightRatioDefault]];
                }
            }
            if ([_dataSource respondsToSelector:@selector(spaceFlowView:childViewAtIndex:withFrame:)]) {
                CGFloat widthRatio,heightRatio;
                if ([_widthRatioArray count]>i) {
                    widthRatio = [[_widthRatioArray objectAtIndex:i] floatValue];
                }else if ([_widthRatioArray count]>0) {
                    widthRatio = [[_widthRatioArray lastObject] floatValue];
                }else{
                    widthRatio = WidthRatioDefault;
                }
                if ([_heightRatioArray count]>i) {
                    heightRatio = [[_heightRatioArray objectAtIndex:i] floatValue];
                }else if ([_heightRatioArray count]>0) {
                    heightRatio = [[_heightRatioArray lastObject] floatValue];
                }else{
                    heightRatio = HeightRatioDefault;
                }
                CGRect frame = CGRectMake(0, 0, _width*widthRatio, _height*heightRatio);
                UIView *leafSubView = [_dataSource spaceFlowView:self childViewAtIndex:i withFrame:frame];
                SpaceLeafView *slv = [[SpaceLeafView alloc] initWithFrame:frame];
                if (leafSubView) {
                    slv.subContentView = leafSubView;
                    [_leafViewsArray addObject:slv];
                }else{
                    slv.subContentView = [self leafViewForNullWithFrame:frame];
                    [_leafViewsArray addObject:slv];
                }
            }
        }
        
        if ([_widthRatioArray count]==0) {
            [_widthRatioArray addObject:[NSNumber numberWithFloat:WidthRatioDefault]];
        }
        if ([_heightRatioArray count]==0) {
            [_heightRatioArray addObject:[NSNumber numberWithFloat:HeightRatioDefault]];
        }
        if ([_leafViewsArray count]==0) {
            CGRect frame = CGRectMake(0, 0, _width*WidthRatioDefault, _height*HeightRatioDefault);
            SpaceLeafView *slv = [[SpaceLeafView alloc] initWithFrame:frame];
            slv.subContentView = [self leafViewForNullWithFrame:frame];
            [_leafViewsArray addObject:slv];
        }
        if (_totalNumber==0) {
            _totalNumber = 1;
        }
    }
    
    if (_totalNumber>[_leafViewsArray count]) {
        _totalNumber = [_leafViewsArray count];
    }
    
    _leafRadian = 2*M_PI/_totalNumber;
    
    _velog = _circleRadius/((_totalNumber+2)*2);
    
}


- (CGFloat)x_r:(CGFloat)radian{
    return sinf(radian)*_circleRadius;
}

- (CGFloat)z_r:(CGFloat)radian{
    return _circleCenter.z + cosf(radian)*_circleRadius;
}

- (CATransform3D)transform3DWithX:(CGFloat)x andZ:(CGFloat)z{
    CGFloat scale = 1 - 0.25*fabsf(z)/_circleRadius;
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DTranslate(trans, x, 0, z);
    trans = CATransform3DScale(trans, scale, scale, 1.0);
    return trans;
}

- (CATransform3D)transform3DWithRadian:(CGFloat)radian{
    CGFloat x = [self x_r:radian];
    CGFloat z = [self z_r:radian];
    return [self transform3DWithX:x andZ:z];
    
}


- (void)reloadData{
    [self refreshBasic];
    for (int i=0; i<_totalNumber; i++) {
        SpaceLeafView *slv = [_leafViewsArray objectAtIndex:i];
        slv.delegate = self;
        slv.index = i;
        slv.radian = _leafRadian*i;
        slv.leafRadian = _lastRadian;
        [self addSubview:slv];
        slv.center = CGPointMake(_width*0.5, _height*0.5);
        slv.layer.transform = [self transform3DWithRadian:slv.radian];
        slv.blurredRatio = slv.layer.transform.m11;
    }
    _canScroll = YES;
}

- (void)reloadDataFinished{
    if (_totalNumber == [_leafViewsArray count]&&_totalNumber>0) {
        for (int i=0; i<_totalNumber; i++) {
            SpaceLeafView *slv = [_leafViewsArray objectAtIndex:i];
            [slv refreshSubContentImage];
        }
    }
}


- (void)startAnimation{
    if (_totalNumber<=1) {
        return;
    }
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(scrollLeavesStep) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}


- (void)stopAnimation{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _scrollTo = ScrollToNone;
        _isScrolling = NO;
        [self prepareToStopScrollLeaves];
    }
}


- (void)scrollLeavesStep{
    for (int i=0; i<_totalNumber; i++) {
        SpaceLeafView *slv = [_leafViewsArray objectAtIndex:i];
        if (_scrollTo==ScrollToRight) {
            slv.radian += _velog/_circleRadius;
        }else if (_scrollTo==ScrollToLeft) {
            slv.radian += -_velog/_circleRadius;
        }else{
            return;
        }
        slv.layer.transform = [self transform3DWithRadian:slv.radian];
        slv.blurredRatio = slv.layer.transform.m11;
    }
    [self checkEndScrollLeaves];
}

- (void)prepareToStopScrollLeaves{
    SpaceLeafView *slv = nil;
    if ([_leafViewsArray count]>0) {
        slv = [_leafViewsArray objectAtIndex:0];
    }else{
        return;
    }
    CGFloat radianOffset = slv.radian - (int)(slv.radian/_leafRadian)*_leafRadian;
    CGFloat finalRadian;
    if (radianOffset<=(_leafRadian/2)) {
        finalRadian = -radianOffset;
    }else{
        finalRadian = _leafRadian - radianOffset;
    }
    if (finalRadian>0.0) {
        _scrollTo = ScrollToRight;
    }else if (finalRadian<0.0) {
        _scrollTo = ScrollToLeft;
    }else{
        return;
    }
    [self startAnimation];
}

- (void)stopAllLeaves:(SpaceLeafView *)slv{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _scrollTo = ScrollToNone;
    }
    if (_isSingleStep) {
        _isSingleStep = NO;
    }
    if (_isScrolling) {
        _isScrolling = NO;
    }
    CGFloat radianOffset = slv.radian - (int)(slv.radian/_leafRadian)*_leafRadian;
    CGFloat finalRadian;
    if (radianOffset<=(_leafRadian/2)) {
        finalRadian = -radianOffset;
    }else{
        finalRadian = _leafRadian - radianOffset;
    }
    for (int i=0; i<_totalNumber; i++) {
        SpaceLeafView *slv = [_leafViewsArray objectAtIndex:i];
        slv.radian += finalRadian;
        slv.layer.transform = [self transform3DWithRadian:slv.radian];
        slv.blurredRatio = slv.layer.transform.m11;
    }
}

- (void)checkEndScrollLeaves{
    SpaceLeafView *slv = nil;
    if ([_leafViewsArray count]>0) {
        slv = [_leafViewsArray objectAtIndex:0];
    }else{
        return;
    }
    CGFloat offset = 0.0;
    if (!_isSingleStep) {
        offset = slv.radian - (int)(slv.radian/_leafRadian)*_leafRadian;
        offset = (_leafRadian-offset)<offset?(_leafRadian-offset):offset;
        if (offset<2*_velog/_circleRadius) {
            [self stopAllLeaves:slv];
        }
    }else{
        offset = fabsf(slv.radian-_lastRadian);
        if (offset>(_leafRadian*(1-2*_velog/_circleRadius))&&offset<(_leafRadian*(1+2*_velog/_circleRadius))) {
            [self stopAllLeaves:slv];
        }else if ((2*M_PI-offset)>(_leafRadian*(1-2*_velog/_circleRadius))&&(2*M_PI-offset)<(_leafRadian*(1+2*_velog/_circleRadius))) {
            [self stopAllLeaves:slv];
        }
    }
    
}



- (void)panHandle:(UIPanGestureRecognizer *)pan{
    if (_totalNumber<=1) {
        return;
    }
    CGPoint point = [pan translationInView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
            _canScroll = YES;
            break;
        case UIGestureRecognizerStateCancelled:
//            [self performSelector:@selector(stopAnimation) withObject:self afterDelay:(0.1+1.0/_totalNumber)];
            break;
        default:
            if (_canScroll) {
                _canScroll = NO;
            }else{
                return;
            }
            if (point.x>0.0) {
                _scrollTo = ScrollToRight;
            }else if (point.x<0.0) {
                _scrollTo = ScrollToLeft;
            }else{
                break;
            }
            if (_isScrolling) {
                return;
            }
            /*--------*/
            SpaceLeafView *slv = nil;
            if ([_leafViewsArray count]>0) {
                slv = [_leafViewsArray objectAtIndex:0];
            }else{
                return;
            }
            if (_isSingleStep) {
                return;
            }
            _lastRadian = slv.radian;
            _isSingleStep = YES;
            /*----------*/
            _isScrolling = YES;
            [self startAnimation];
            break;
    }
}


- (void)tapHandle:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    if (point.x>_width*3/4) {
        _scrollTo = ScrollToLeft;
    }else if (point.x<_width/4){
        _scrollTo = ScrollToRight;
    }else{
        return;
    }
    SpaceLeafView *slv = nil;
    if ([_leafViewsArray count]>0) {
        slv = [_leafViewsArray objectAtIndex:0];
    }else{
        return;
    }
    if (_isSingleStep) {
        return;
    }
    _lastRadian = slv.radian;
    _isScrolling = NO;
    _isSingleStep = YES;
    [self startAnimation];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


+ (CGFloat)radiusRatioRecommendVauleWithCount:(NSUInteger)count viewWidth:(CGFloat)width widthRatio:(CGFloat)widthRatio{
    if (widthRatio<=0.0||widthRatio>=1.0) {
        return 1.0;
    }
    if (count<=0) {
        return 1.0;
    }
    CGFloat radian,x1,result,l1;
    radian = 2*M_PI/count;
    x1 = width*(1-widthRatio)*0.5;
    l1 = width*widthRatio;
    result = (l1*(2-(1-cosf(radian))*0.25)+x1)/(2*sinf(radian));
    if (result<=0.0) {
        return 1.0;
    }
    return result/width;
}


@end
