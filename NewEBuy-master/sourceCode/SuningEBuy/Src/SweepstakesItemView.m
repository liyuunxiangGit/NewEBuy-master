//
//  SweepstakesItemView.m
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "SweepstakesItemView.h"

#define kFrontImage @"lottery_align.png"

#define kWinnOkBackImage  @"alert_message_bg.png"

#define kWinnNoBackImage  @"alert_message_bg.png"


@implementation SweepstakesItemView

@synthesize frontView = _frontView;

@synthesize backView = _backView;

@synthesize isVisible = _isVisible;

@synthesize exDelegate = exDelegate_;

@synthesize isWinning = _isWinning;


- (void)dealloc{
    
    TT_RELEASE_SAFELY(_frontView);
    TT_RELEASE_SAFELY(_backView);
    
    
    self.exDelegate = nil;
    
}

-(UIImageView *)frontView{
    
    if (_frontView == nil) {
        
        _frontView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        UIImage *image = [UIImage imageNamed:kFrontImage];
        _frontView.image = image;
        [self addSubview:_frontView];
    }
    return _frontView;
}

-(UIImageView *)backView{
    
    if (_backView == nil) {
        
        _backView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        UIImage *image = [UIImage imageNamed:kFrontImage];
        _backView.image = image;
        [self addSubview:_backView];
    }
    return _backView;
}

-(void)setIsWinning:(BOOL)isWinning
{
    _isWinning = isWinning;
    
    NSString *imageName = (isWinning==YES)?kWinnOkBackImage:kWinnNoBackImage;
    
    self.backView.image = [UIImage imageNamed:imageName];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.frontView.tag= 144;
        
        self.backView.tag = 145;
        
        _isWinning = NO;
    }
    return self;
}

- (void)flipViews {
    
	[UIView transitionFromView:(self.isVisible) ? self.frontView : self.backView
						toView:(self.isVisible) ? self.backView : self.frontView
					  duration:0.45
					   options:(self.isVisible ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft)
					completion:^(BOOL finished) {
						if (finished) {
							self.isVisible = !self.isVisible;
                            
       
						}
					}];
}

- (BOOL)flipFromBackToFront
{
    if (isAnimition || self.isVisible) {
        return NO;
    }
    isAnimition = YES;
    [UIView transitionFromView:self.backView
						toView:self.frontView
					  duration:0.45
					   options:UIViewAnimationOptionTransitionFlipFromLeft
					completion:^(BOOL finished) {
						isAnimition = NO;
                        self.isVisible = YES;
					}];
    return YES;
}

- (BOOL)flipFromFrontToBack
{
    if (isAnimition || !self.isVisible) {
        return NO;
    }
    isAnimition = YES;
    [UIView transitionFromView:self.frontView
						toView:self.backView
					  duration:0.45
					   options:UIViewAnimationOptionTransitionFlipFromRight
					completion:^(BOOL finished) {
						isAnimition = NO;
                        self.isVisible = NO;
					}];
    return YES;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	
	
	DLog(@"UIImageViewEx touchesBegan \n");
}
//捕获手指拖拽消息
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
}

//捕获手指拿开消息
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event{
	
	DLog(@"EGOImageViewEx touchesEnded \n");
    
    if ([GlobalDataCenter defaultCenter].isMultiTouch ==NO) {
        [GlobalDataCenter defaultCenter].isMultiTouch =YES;
        
    }else{
        return;
    }
    
    if (self.isVisible== NO) {
        
        if ([exDelegate_ conformsToProtocol:@protocol(SweepstakesItemDelegate)]) {
            if ([exDelegate_ respondsToSelector:@selector(sweepstakesItemDidOk:)]) {
                [exDelegate_ sweepstakesItemDidOk:self];
            }		
        }
        
        
       // [self flipViews];
    }
    
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
