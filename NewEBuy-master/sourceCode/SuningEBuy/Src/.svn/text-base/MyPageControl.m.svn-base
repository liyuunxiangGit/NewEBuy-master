//
//  MyPageControl.m
//  SuningEBuy
//
//  Created by shasha on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyPageControl.h"
#define  dotSepWidth    2
@interface MyPageControl()

- (void)updateDots;
@end

@implementation MyPageControl
@synthesize imageNormal = imageNormal_;
@synthesize imageSelected = imageSelected_;
@synthesize formPage = _formPage;
- (id)init {
    self = [super init];
    if (self) {
        
        _maxPoint = 0;
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(imageNormal_);
    TT_RELEASE_SAFELY(imageSelected_);
}

-(void)setImageNormal:(UIImage *)imageNormal{
    if (imageNormal_ != imageNormal) {
        
        TT_RELEASE_SAFELY(imageNormal_);
        imageNormal_ = imageNormal;
        
        [self updateDots];
    }
    
}

-(void)setImageSelected:(UIImage *)imageSelected{
    
    if (imageSelected_ != imageSelected) {
        TT_RELEASE_SAFELY(imageSelected_);
        imageSelected_ = imageSelected;
        [self updateDots];
    }
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    /*
     Notes：
     屏蔽了点击pageControl的点击事件。
     */
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
    
}
-(void)setNumberOfPages:(NSInteger)numberOfPages{
    
    
    if (_maxPoint != 0) {
        
        if (numberOfPages > _maxPoint) {
            
            numberOfPages = _maxPoint;
        }
    }
    
    [super setNumberOfPages:numberOfPages];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    if (_maxPoint != 0) {
        
        if (currentPage > _maxPoint-1) {
            
            currentPage = _maxPoint-1;
        }
    }
    
    [super setCurrentPage:currentPage];
    
    [self updateDots];
    
}


//通过获取dot的imageView而改变不同状态下的dot的图片。pageControl的subviews对应的就是一个个的dot的imageView。
-(void)updateDots{
    
    if (imageSelected_ || imageNormal_) {
        
        if (self.formPage == 9) {
            CGFloat totalDotSepWidth;
            CGFloat dotWidth;
            if (self.numberOfPages > 1) {
                totalDotSepWidth = dotSepWidth * (self.numberOfPages - 1);
                dotWidth = (320 - totalDotSepWidth) / self.numberOfPages;
            }
            for (int i = 0; i < [self.subviews count]; i++)
            {
                UIView* dotView = [self.subviews objectAtIndex:i];
                UIImageView* dot = nil;
                
                if ([dotView isKindOfClass:[UIImageView class]])
                {
                    dot = (UIImageView *)dotView;
                }
                else
                {
                    for (UIView* subview in dotView.subviews)
                    {
                        if ([subview isKindOfClass:[UIImageView class]])
                        {
                            dot = (UIImageView*)subview;
                            break;
                        }
                    }
                }
                if (dot == nil)
                {
                    dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
                    [dotView addSubview:dot];
                }
                
                if (self.numberOfPages <= 1) {
                    dot.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
                }else{
                    if (i == self.numberOfPages) {
                        dot.frame = CGRectMake((320 -(i - 1)* dotWidth), 0, dotWidth, self.bounds.size.height);
                    }else{
                        dot.frame = CGRectMake(i * dotWidth, 0, dotWidth, self.bounds.size.height);
                    }
                }
                
                if (i == self.currentPage)
                {
                    if(self.imageSelected)
                    {
                        dot.image = self.imageSelected;
                    }
                }
                else
                {
                    if (self.imageNormal)
                    {
                        dot.image = self.imageNormal;
                    }
                }
            }
            
            return;
        }
        for (int i = 0; i < [self.subviews count]; i++)
        {
            UIView* dotView = [self.subviews objectAtIndex:i];
            UIImageView* dot = nil;
            
            if ([dotView isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView *)dotView;
            }
            else
            {
                for (UIView* subview in dotView.subviews)
                {
                    if ([subview isKindOfClass:[UIImageView class]])
                    {
                        dot = (UIImageView*)subview;
                        break;
                    }
                }
            }
            
            //如果没有，创建一个，为了适应ios7sdk
            if (dot == nil)
            {
                dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
                [dotView addSubview:dot];
            }
            
            if (self.formPage == 9) {
                if (IOS7_OR_LATER) {
                    dot.frame = CGRectMake(-1, -0.5, 10, 10);
                }else{
                    dot.frame = CGRectMake(0 + 20*i, 0, 10, 10);
                }
            }
            
            if (i == self.currentPage)
            {
                if(self.imageSelected)
                    dot.image = self.imageSelected;
            }
            else
            {
                if (self.imageNormal)
                    dot.image = self.imageNormal;
            }
        }
        
        //        NSArray *arr = [self subviews];
        //        for (NSInteger i = 0; i < [arr count]; i++) {
        //            UIImageView *dotView = [arr objectAtIndex:i];
        //            if ([dotView isKindOfClass:[UIImageView class]])
        //            {
        //                if (self.formPage == 9) {
        //                    dotView.frame = CGRectMake(0 + 20*i, 0, 10, 10);
        //                }
        //                dotView.image = self.currentPage == i ? self.imageSelected : self.imageNormal;
        //                dotView.backgroundColor = [UIColor clearColor];
        //            }
        //        }
    }
    
}


@end
