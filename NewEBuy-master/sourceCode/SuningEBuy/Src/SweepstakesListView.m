//
//  SweepstakesListView.m
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "SweepstakesListView.h"

#import "SweepstakesViewController.h"

#define TRANSITION_ANIMATION_DURATION   0.4f

#define KitemOffset         70

#define KitemOffsetY         ((isIPhone5==NO)?70:80)


@implementation SweepstakesListView

@synthesize sweepstakesOne = _sweepstakesOne;

@synthesize sweepstakesTwo = _sweepstakesTwo;

@synthesize sweepstakesThree = _sweepstakesThree;

@synthesize sweepstakesFour = _sweepstakesFour;

@synthesize animateTimer = _animateTimer;

@synthesize owner = _owner;

@synthesize sweepDtoArr = _sweepDtoArr;

@synthesize zjInfo = _zjInfo;

@synthesize rootView = _rootView;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_sweepstakesOne);
    
    TT_RELEASE_SAFELY(_sweepstakesTwo);
    
    TT_RELEASE_SAFELY(_sweepstakesThree);
    
    TT_RELEASE_SAFELY(_sweepstakesFour);
    
    TT_INVALIDATE_TIMER(_animateTimer);
    
    TT_RELEASE_SAFELY(_sweepDtoArr);
    
    TT_RELEASE_SAFELY(_zjInfo);
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}


//刘坤： 获取随即场景 ,一等奖1%， 二等奖5%, 返回SNPrise
- (SNPrise)randomPrise
{
    static int kSpaces[100] = {
		5, 5, 5, 5, 5, 5, 5, 5, 5, 1,  // 0-9 一个一等奖
		5, 5, 5, 5, 5, 2, 2, 2, 2, 2,  // 10-19 5个二等奖
		5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  // 20-29
		5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  // 30-39
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3,  // 40-49
		4, 4, 4, 4, 4, 4, 4, 4, 4, 4,  // 50-59
		4, 4, 4, 4, 4, 4, 4, 4, 4, 4,  // 60-69
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3,  // 70-79
		4, 4, 4, 4, 4, 4, 4, 4, 4, 4,  // 80-89
		5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  // 90-99
	};
    
    return kSpaces[arc4random()%100];
}

- (UIImage *)imageOfPrise:(SNPrise)prise
{
    UIImage *image = nil;
    switch (prise) {
        case FirstPrise:
            image = [UIImage imageNamed:@"lottery_grade1.png"];
            break;
        case SecondPrise:
            image = [UIImage imageNamed:@"lottery_grade2.png"];
            break;
        case ThirdPrise:
            image = [UIImage imageNamed:@"lottery_grade3.png"];
            break;
        case FourthPrise:
            image = [UIImage imageNamed:@"lotterygrade4.png"];
            break;
        case JoinPrise:
            image = [UIImage imageNamed:@"lottery_grade0.png"];
        default:
            break;
    }
    return image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.multipleTouchEnabled =NO;
        
        
        loopIdex = 0;
    }
    return self;
}

-(void)setItemIsVisible:(BOOL)isVisible
{
    self.sweepstakesOne.isVisible = isVisible;
    
    self.sweepstakesTwo.isVisible = isVisible;
    
    self.sweepstakesThree.isVisible = isVisible;
    
    self.sweepstakesFour.isVisible = isVisible;
}

-(void)setItemIsTouchEnable:(BOOL)isEnble
{
    _sweepstakesOne.userInteractionEnabled = isEnble;
    
    _sweepstakesTwo.userInteractionEnabled = isEnble;
    
    _sweepstakesThree.userInteractionEnabled = isEnble;
    
    _sweepstakesFour.userInteractionEnabled = isEnble;
}

-(SweepstakesItemView *)sweepstakesOne
{
    if (!_sweepstakesOne) {
        
        _sweepstakesOne = [[SweepstakesItemView alloc] initWithFrame:CGRectMake((self.width-120)/2,10, 120, 120)];
        
        _sweepstakesOne.backgroundColor = [UIColor clearColor];
        
        _sweepstakesOne.userInteractionEnabled = NO;
        
        _sweepstakesOne.exDelegate = self;
        
        _sweepstakesOne.tag = 11;
        
        [self addSubview: _sweepstakesOne];
    }
    
    return _sweepstakesOne;
}

-(SweepstakesItemView *)sweepstakesTwo
{
    if (!_sweepstakesTwo) {
        
        _sweepstakesTwo = [[SweepstakesItemView alloc] initWithFrame:CGRectMake((self.width-120)/2,10, 120, 120)];
        
        _sweepstakesTwo.backgroundColor = [UIColor clearColor];
        
        _sweepstakesTwo.tag = 12;
        
        _sweepstakesTwo.userInteractionEnabled = NO;
        
        _sweepstakesTwo.exDelegate = self;
        
        [self addSubview: _sweepstakesTwo];
    }
    
    return _sweepstakesTwo;
}

-(SweepstakesItemView *)sweepstakesThree
{
    if (!_sweepstakesThree) {
        
        _sweepstakesThree = [[SweepstakesItemView alloc] initWithFrame:CGRectMake((self.width-120)/2,10 ,120, 120)];
        
        _sweepstakesThree.backgroundColor = [UIColor clearColor];
        
        _sweepstakesThree.tag = 13;
        
        _sweepstakesThree.userInteractionEnabled = NO;
        
        _sweepstakesThree.exDelegate = self;
        
        [self addSubview: _sweepstakesThree];
    }
    
    return _sweepstakesThree;
}

-(SweepstakesItemView *)sweepstakesFour
{
    if (!_sweepstakesFour) {
        
        _sweepstakesFour = [[SweepstakesItemView alloc] initWithFrame:CGRectMake((self.width-120)/2,10, 120, 120)];
        
        _sweepstakesFour.backgroundColor = [UIColor clearColor];
        
        _sweepstakesFour.tag = 14;
        
        _sweepstakesFour.userInteractionEnabled = NO;
        
        _sweepstakesFour.exDelegate = self;
        
        [self addSubview: _sweepstakesFour];
    }
    
    return _sweepstakesFour;
}

-(void)setItemcenter
{
    self.sweepstakesOne.center = CGPointMake(self.size.width/2, self.size.height/2);
    
    self.sweepstakesTwo.center = CGPointMake(self.size.width/2, self.size.height/2);
    
    self.sweepstakesThree.center = CGPointMake(self.size.width/2, self.size.height/2);
    
    self.sweepstakesFour.center = CGPointMake(self.size.width/2, self.size.height/2);
}

-(void)startCenterMoveAnimate
{
    // [self setItemcenter];
    [self setItemIsTouchEnable:NO];
    self.sweepstakesOne.center = CGPointMake(self.size.width/2, self.size.height);
    
    
    [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.sweepstakesOne.center = CGPointMake(self.size.width/2-KitemOffset, self.size.height/2-KitemOffset);
                         
                         self.sweepstakesTwo.center = CGPointMake(self.size.width/2, self.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                         
                         [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              
                                              self.sweepstakesTwo.center = CGPointMake(self.size.width/2+KitemOffset, self.size.height/2-KitemOffset);
                                              
                                              self.sweepstakesThree.center = CGPointMake(self.size.width/2, self.size.height);
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              
                                              [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                                                               animations:^{
                                                                   self.sweepstakesThree.center = CGPointMake(self.size.width/2-KitemOffset, self.size.height/2+KitemOffsetY);
                                                                   
                                                                   self.sweepstakesFour.center = CGPointMake(self.size.width/2, self.size.height);
                                                                   
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                                                                                    animations:^{
                                                                                        
                                                                                        self.sweepstakesFour.center = CGPointMake(self.size.width/2+KitemOffset, self.size.height/2+KitemOffsetY);
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [self setItemIsTouchEnable:YES];
                                                                                        DLog(@"start animation ok");
                                                                                    }];
                                                               }];
                                              
                                          }];
                         
                         
                     }];
    
}

-(void)resetItem
{
    NSArray *itemList = self.subviews;
    for (UIView *stakesView in itemList) {
        
        if ([stakesView isKindOfClass:[SweepstakesItemView class]] ==YES) {
            
            SweepstakesItemView *remainView = (SweepstakesItemView *)stakesView;
            
            //remainView.isVisible = YES;
            
            [remainView flipFromFrontToBack];
            
        }
    }
    [self setItemIsTouchEnable:YES];
    loopIdex = 0;
}

//-(void)rotationRemainView:(SweepstakesItemView *)itemView
//{
//    NSArray *itemList = self.subviews;
//    for (UIView *stakesView in itemList) {
//
//        if ([stakesView isKindOfClass:[SweepstakesItemView class]] ==YES) {
//
//            if (stakesView.tag != itemView.tag) {
//
//                SweepstakesItemView *remainView = (SweepstakesItemView *)stakesView;
//
//                [remainView flipViews];
//
//
//            }
//        }
//    }
//}

-(void)rotationBegin
{
    self.rootView.backBtn.enabled = NO;
    [self setItemIsTouchEnable:NO];
    SweepstakesItemView *remainView = (SweepstakesItemView *)[self viewWithTag:selectItemTag];
    
    if ([remainView isKindOfClass: [SweepstakesItemView class]]) {
        
        //[remainView flipViews];
        [remainView flipFromBackToFront];
    }
    
    //[self startTimer];
    
    [self performSelector:@selector(loopRotation) withObject:nil afterDelay:1.0f];
}

-(void)resetSweep
{
    [self resetItem];
}

-(void)loopRotation
{
    
    if (loopIdex >= [self.subviews count]) {
        
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:self.zjInfo.jpMessage
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Sweepstakes_HangAround")
                                              otherButtonTitles:L(@"Cancel")];
        
        [alert setCancelBlock:^{
            UIViewController *controller = (UIViewController *)self.owner;
            [controller.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [alert setConfirmBlock:^{
            
            [self performSelector:@selector(resetSweep) withObject:nil afterDelay:1.0f];
        }];
        
        [alert show];
        
        
        self.rootView.backBtn.enabled = YES;
        
        [self endTimer];
        
        return;
    }
    
    UIView *stakesView = [self.subviews objectAtIndex:loopIdex];
    
    if (stakesView !=nil) {
        
        if ([stakesView isKindOfClass:[SweepstakesItemView class]] ==YES) {
            
            if (stakesView.tag != selectItemTag) {
                
                SweepstakesItemView *remainView = (SweepstakesItemView *)stakesView;
                
                //[remainView flipViews];
                [remainView flipFromBackToFront];
            }
        }
    }
    
    loopIdex++;
    
    if (loopIdex < [self.subviews count] &&
        [[self.subviews objectAtIndex:loopIdex] tag] == selectItemTag) {
        loopIdex++;
    }
    
    [self performSelector:@selector(loopRotation) withObject:nil afterDelay:1.0f];

}

- (void)startTimer
{
    if (!_animateTimer || ![_animateTimer isValid])
    {
        
        self.animateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                             target:self
                                                           selector:@selector(loopRotation)
                                                           userInfo:nil
                                                            repeats:YES];
    }
}

- (void)endTimer
{
    [self setItemIsTouchEnable:YES];
    
    TT_INVALIDATE_TIMER(_animateTimer);
}

- (void)sweepstakesItemDidOk:(SweepstakesItemView *)itemView
{
    DLog(@"sweepstakesItemDidOk");
    
    
    SweepstakesViewController *rootNC = (SweepstakesViewController *)self.owner;
    
    if ([rootNC isKindOfClass: [SweepstakesViewController class]]) {
        
        if ([rootNC sendSweepActiveHttp]) {
            selectItemTag = itemView.tag;
            [self setItemIsTouchEnable:NO];
        }else{
            //do nothing
        }
        
    }
    
    selectItemTag = itemView.tag;
    
    //[self setItemIsVisible: YES];
    
    // [self performSelector:@selector(rotationRemainView:) withObject:itemView afterDelay:0.5];
    
    
}

-(void)setWinningView:(JPInfoDTO *)zjInfo
{
    self.zjInfo = zjInfo;
    
    NSArray *itemList = self.subviews;
    for (UIView *stakesView in itemList) {
        
        if ([stakesView isKindOfClass:[SweepstakesItemView class]] ==YES) {
            
            SweepstakesItemView *itemView = (SweepstakesItemView *)stakesView;
            
            if (itemView.tag == selectItemTag)
            {
                UIImage *image = [self imageOfPrise:zjInfo.priseLevel];
                itemView.frontView.image = image;
            }
            else
            {
                SNPrise randomPrise = [self randomPrise];
                UIImage *image = [self imageOfPrise:randomPrise];
                itemView.frontView.image = image;
            }
            
        }
    }
    
    [self rotationBegin];
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
