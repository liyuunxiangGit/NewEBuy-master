//
//  StarIcon.m
//  starChooseBar
//
//  Created by cjw on 14/11/6.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import "StarIcon.h"

@implementation StarIcon

- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:CGRectZero];//父视图初始化
    if (self)
    {
        self.frame = rect;
    }
    [self setImageView];
    return self;
}

- (void)setImageView
{
    self.image = [UIImage imageNamed:@"gray_star.png"];
    self.highlightedImage = [UIImage imageNamed:@"orange_star.png"];
    UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Clicked:)];
    singleTapOne.numberOfTapsRequired = 1; //tap次数
    UITapGestureRecognizer *singleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Clicked:)];
    singleTapTwo.numberOfTapsRequired = 2; //tap次数
    //[singleTapOne requireGestureRecognizerToFail:singleTapTwo];
    [self addGestureRecognizer:singleTapOne];
    [self addGestureRecognizer:singleTapTwo];
}

- (void)Clicked:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleSingleTap:)])
    {
        [self.delegate handleSingleTap:sender];
    }
}

@end
