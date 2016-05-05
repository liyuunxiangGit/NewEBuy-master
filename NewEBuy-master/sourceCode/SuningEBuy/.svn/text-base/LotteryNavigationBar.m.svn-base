//
//  LotteryNavigationBar.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-6-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LotteryNavigationBar.h"

@implementation LotteryNavigationBar

- (void)drawRect:(CGRect)rect
{
    if (!IOS5_OR_LATER)
    {
        UIImage *image = [UIImage imageWithColor:RGBCOLOR(200, 2, 20) size:CGSizeMake(320, 44)];
        
        
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews)
    {
        [view setExclusiveTouch:YES];
    }
}

@end
