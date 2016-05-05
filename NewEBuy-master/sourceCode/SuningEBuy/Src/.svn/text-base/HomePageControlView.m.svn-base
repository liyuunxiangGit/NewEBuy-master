//
//  HomePageControlView.m
//  SuningEBuy
//
//  Created by  zhang jian on 14-2-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomePageControlView.h"

#define dotSepWidth     5

@interface  HomePageControlView()
{
    
}
- (void)updateDots;

@end


@implementation HomePageControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxPoint = 0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)addImageView{
    for (int i = 0; i < self.numberOfPages; i ++ ) {
        UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        [self addSubview:dot];
    }
}

-(void)setImageNormal:(UIImage *)imageNormal
{
    if (imageNormal_ != imageNormal)
    {
        imageNormal_ = imageNormal;
        [self updateDots];
    }
}

- (UIImage *)imageNormal
{
    if (!imageNormal_) {
        imageNormal_ = [[UIImage alloc] init];
    }
    return imageNormal_;
}

-(void)setImageSelected:(UIImage *)imageSelected
{
    if (imageSelected_ != imageSelected)
    {
        imageSelected_ = imageSelected;
        [self updateDots];
    }
}

- (UIImage *)imageSelected
{
    if (!imageSelected_) {
        imageSelected_ = [[UIImage alloc] init];
    }
    return imageSelected_;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    /*
     Notes：
     屏蔽了点击pageControl的点击事件。
     */
    [self updateDots];
    
}
-(void)setNumberOfPages:(NSInteger)numberOfPages
{
    if (_maxPoint != 0) {
        if (numberOfPages > _maxPoint) {
            _numberOfPages = _maxPoint;
        }else{
            _numberOfPages = numberOfPages;
        }
    }
    [self removeAllSubviews];
    [self addImageView];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    if (_maxPoint != 0) {
        
        if (currentPage > _maxPoint-1) {
            
            _currentPage = _maxPoint-1;
        }else{
            _currentPage = currentPage;
        }
    }
    
    [self updateDots];
    
}

- (void)updateDots
{
    if (imageSelected_ || imageNormal_) {
        
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
                    dot.frame = CGRectMake(320 - dotWidth, 0, dotWidth, self.bounds.size.height);
                }else{
                    dot.frame = CGRectMake(i * (dotWidth + dotSepWidth), 0, dotWidth, self.bounds.size.height);
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
        
    }
}


@end
