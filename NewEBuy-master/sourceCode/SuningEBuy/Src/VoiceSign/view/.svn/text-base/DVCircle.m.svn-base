//
//  DVCircle.m
//  SuningEBuy
//
//  Created by leo on 14-4-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DVCircle.h"

@implementation DVCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        isClick = NO;
        
        [self intiUIOfView];

    }
    return self;
}

-(void)intiUIOfView
{
    
        
    UIBezierPath *path=[UIBezierPath bezierPath];
    
//    CGRect rect=[UIScreen mainScreen].applicationFrame;
    
    [path addArcWithCenter:CGPointMake(163.2,105/2) radius:48.5 startAngle:-0.5*M_PI endAngle:1.5*M_PI clockwise:NO];
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor=[UIColor clearColor].CGColor;
    arcLayer.bounds= CGRectMake(0, 0, 60,40);
    arcLayer.lineWidth=4;
    arcLayer.frame=self.frame;
    UIButton *btnclick = [[UIButton alloc] initWithFrame:CGRectMake(113, 0, 103, 105)];
    [btnclick setBackgroundImage:[UIImage imageNamed:@"sound_button_shenbo_default"] forState:UIControlStateNormal];
    [btnclick addTarget:self action:@selector(touchesPoint) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btnclick];
    

    [self.layer addSublayer:arcLayer];


    //    [self.view addSubview:btn];
    //    [self drawLineAnimation:btn.layer];
    
    
}

-(void)touchesPoint
{
//    isClick = !isClick;
    
//    if(isClick == YES)
//    {
//        arcLayer.hidden = NO;
//        [self.layer addSublayer:arcLayer];
        [self listenbegin];

//    }
//    else
//    {
//        arcLayer.hidden = YES;
//        [self.layer removeAllAnimations];
//    }
    
}

-(void)listenbegin{
    if ([self.owner respondsToSelector:@selector(listenbegin)]) {
        [self.owner performSelector:@selector(listenbegin)];
    }

}
-(void)drawLineAnimation
{
   
    arcLayer.strokeColor=[UIColor colorWithRGBHex:0xee7100].CGColor;
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=20;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:1];
    bas.toValue=[NSNumber numberWithInteger:0];
    [arcLayer addAnimation:bas forKey:@"key"];
}

-(void)resetarclayer{
    arcLayer.strokeColor=[UIColor clearColor].CGColor;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
