//
//  BallButton.m
//  SuningLottery
//
//  Created by wangrui on 13-4-19.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "BallButton.h"
#import "UIView+Additions.h"
#import "LotterySelectBallView.h"

#define kHighlightedBallTag 4008365
#define kBallStartTag   100

@interface BallButton ()

@property (nonatomic, assign) LotteryBallType ballType;

@property (nonatomic, copy) NSString *ballNumber;

@property (nonatomic, weak) id  ballSelectDelegate;

@end

@implementation BallButton

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_ballNumber);
    
}

- (id)initWithType:(LotteryBallType)ballType ballNumber:(NSString *)ballNumber andDelegate:(id)delegate
{
    
    if (self = [super init])
    {
        _ballType = ballType;
        
        _ballNumber = [ballNumber copy];

        _ballSelectDelegate = delegate;
    }
    
    return self;
}

- (void)showHighlightedBallFromView:(BallButton *)baseView
{
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    [[window viewWithTag:kHighlightedBallTag] removeFromSuperview];
    
    CGRect divFrame = CGRectMake(baseView.centerX - 35, baseView.bottom - 104, 70, 105);
    
    HighlightedBallView *divImageView = [[HighlightedBallView alloc] initWithFrame:divFrame andNumber:baseView.ballNumber];
    divImageView.tag = kHighlightedBallTag;
    
    if (_ballType == eBlueBallType)
    {
        divImageView.image = [UIImage imageNamed:@"blueball-big.png"];
    }
    else
    {
        divImageView.image = [UIImage imageNamed:@"redball-big.png"];
    }
    
    CGRect frame = [baseView.superview convertRect:divImageView.frame toView:window];
    
    divImageView.frame = frame;
    
    [window addSubview:divImageView];
    
    [divImageView bringSubviewToFront:window];

    TT_RELEASE_SAFELY(divImageView);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    DLog(@"The ball number : %@", _ballNumber);
    
    [self showHighlightedBallFromView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.superview];
    
    if (!CGRectContainsPoint(self.frame, point))
    {
        
        UIWindow *window = [AppDelegate currentAppDelegate].window;
        
        [[window viewWithTag:kHighlightedBallTag] removeFromSuperview];
        
    }

    [[self.superview subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        if ([obj isKindOfClass:[BallButton class]])
        {
            BallButton *ballBtn = (BallButton *)obj;
            
            if (CGRectContainsPoint(ballBtn.frame, point))
            {
                [self showHighlightedBallFromView:ballBtn];
                
                *stop = YES;
            }

        }
        
    }];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UIWindow *window = [AppDelegate currentAppDelegate].window;

    [[window viewWithTag:kHighlightedBallTag] removeFromSuperview];
    
    UITouch *touch = [touches anyObject];

    CGPoint location = [touch locationInView:self.superview];
    
    if (!CGRectContainsPoint(self.frame, location))
    {
        [[self.superview subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj isKindOfClass:[BallButton class]])
            {
                BallButton *ballBtn = (BallButton *)obj;
                
                
                if (CGRectContainsPoint(ballBtn.frame, location))
                {
                    
                    if (!ballBtn.selected)
                    {
                            
                        if ([ballBtn.ballSelectDelegate respondsToSelector:@selector(ballSelect:ballType:)])
                        {
                            
                            BOOL isValide =  [ballBtn.ballSelectDelegate  ballSelect:ballBtn.tag-kBallStartTag + 1  ballType:ballBtn.ballType];
                            
                            if (isValide)
                            {
                                
                                ballBtn.selected = !ballBtn.selected;
                            }
                        }
                        
                    }
                    else
                    {
                            
                        if ([ballBtn.ballSelectDelegate respondsToSelector:@selector(ballUnselect:ballType:)])
                        {
                            
                            BOOL isValide = [ballBtn.ballSelectDelegate  ballUnselect:ballBtn.tag - kBallStartTag + 1 ballType:ballBtn.ballType];
                            
                            if (isValide)
                            {
                                
                                ballBtn.selected = !ballBtn.selected;
                                
                            }
                        }
                    }
                    
                    *stop = YES;
                }
                
            }
            
        }];
    }
    else
    {
        if (!self.selected)
        {
            
            if ([self.ballSelectDelegate respondsToSelector:@selector(ballSelect:ballType:)])
            {
                
                BOOL isValide =  [self.ballSelectDelegate  ballSelect:self.tag-kBallStartTag + 1  ballType:self.ballType];
                
                if (isValide)
                {
                    
                    self.selected = !self.selected;
                }
            }
            
        }
        else
        {
                
            if ([self.ballSelectDelegate respondsToSelector:@selector(ballUnselect:ballType:)])
            {
                
                BOOL isValide = [self.ballSelectDelegate  ballUnselect:self.tag - kBallStartTag + 1 ballType:self.ballType];
                
                if (isValide)
                {
                    
                    self.selected  = !self.selected;
                    
                }
            }
         
        }
    }
    
}

@end

@implementation HighlightedBallView

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_bigNumberLbl);
    TT_RELEASE_SAFELY(_smallNumberLbl);
    
}

- (id)initWithFrame:(CGRect)frame andNumber:(NSString *)ballNumber
{
    if (self = [super initWithFrame:frame])
    {
        
        self.bigNumberLbl.text = ballNumber;
        
        self.smallNumberLbl.text = ballNumber;
        
    }
    
    return self;
}

- (UILabel *)bigNumberLbl
{
    if (!_bigNumberLbl)
    {
        
        CGRect frame = CGRectMake(20, 20, 32, 25);
        
        _bigNumberLbl = [[UILabel alloc] initWithFrame:frame];
        
        _bigNumberLbl.backgroundColor = [UIColor clearColor];
        
        _bigNumberLbl.textAlignment = UITextAlignmentCenter;
        
        _bigNumberLbl.textColor = [UIColor whiteColor];
        
        _bigNumberLbl.font = [UIFont systemFontOfSize:28];
        
        [self addSubview:_bigNumberLbl];
    }
    
    return _bigNumberLbl;
}

- (UILabel *)smallNumberLbl
{
    if (!_smallNumberLbl)
    {
        
        CGRect frame = CGRectMake(26, 76, 18, 18);
        
        _smallNumberLbl = [[UILabel alloc] initWithFrame:frame];
        
        _smallNumberLbl.backgroundColor = [UIColor clearColor];
        
        _smallNumberLbl.textAlignment = UITextAlignmentCenter;
        
        _smallNumberLbl.textColor = [UIColor whiteColor];
        
        _smallNumberLbl.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:_smallNumberLbl];
    }
    
    return _smallNumberLbl;
}

@end
