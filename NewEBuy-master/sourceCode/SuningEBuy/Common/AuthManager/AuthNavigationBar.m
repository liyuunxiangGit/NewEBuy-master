//
//  AuthNavigationBar.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AuthNavigationBar.h"

@implementation AuthNavigationBar

- (void)drawRect:(CGRect)rect
{
    if (!IOS5_OR_LATER)
    {
        UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(320, 44)];
        
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
