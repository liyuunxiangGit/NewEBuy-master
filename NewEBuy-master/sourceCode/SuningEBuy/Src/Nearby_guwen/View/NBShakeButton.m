//
//  NBShakeButton.m
//  suningNearby
//
//  Created by suning on 14-8-7.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBShakeButton.h"

@interface NBShakeButton ()
@property (nonatomic,strong) UIButton *delButton;
@end

@implementation NBShakeButton

- (void)dealloc {
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.bInit = YES;
    
    }
    return self;
}

- (void)setBInit:(BOOL)bInit {
    _bInit = bInit;
    if (_bInit) {
        UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(on_longPress_responder)];
        [self addGestureRecognizer:ges];
        
        CGSize sz = self.frame.size;
        self.delButton = [[UIButton alloc] initWithFrame:CGRectMake(sz.width-20.0f,.0f,20.0f,20.0f)];
        _delButton.hidden = YES;
        [_delButton setImage:[UIImage imageNamed:@"nb_p_del"] forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(on_delButton_clicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_delButton];
    }
}

- (void)startShakeAnimation {
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
    shake.toValue = [NSNumber numberWithFloat:+M_PI/32];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = MAXFLOAT;
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

- (void)stopShakeAnimation {
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

- (void)on_longPress_responder {
    [self startShakeAnimation];
    _delButton.hidden = NO;
}

- (void)on_delButton_clicked {
    [self stopShakeAnimation];
    [self removeFromSuperview];
    
    if (nil != _removeBlock) {
        _removeBlock(self);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *th = touches.anyObject;
    if ([th.view isEqual:self]) {
        [self stopShakeAnimation];
        _delButton.hidden = YES;
    }
    
    [super touchesEnded:touches withEvent:event];
}

@end
