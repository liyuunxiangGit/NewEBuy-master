//
//  starChooseBar.m
//  starChooseBar
//
//  Created by cjw on 14/10/28.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import "StarChooseBar.h"

@implementation StarChooseBar

- (void)setStarBarWithSize:(int)sizeInput Interval:(int)intervalInput Number:(float)numberInput isInteraction:(BOOL)isInteractionInput
{
    size = sizeInput;
    interval = intervalInput;
    [self addSubview:self.fifthStarIcon];
    [self addSubview:self.firstStarIcon];
    [self addSubview:self.secondStarIcon];
    [self addSubview:self.thirdStarIcon];
    [self addSubview:self.fourthStarIcon];
    _firstStarIcon.userInteractionEnabled = isInteractionInput;
    _secondStarIcon.userInteractionEnabled = isInteractionInput;
    _thirdStarIcon.userInteractionEnabled = isInteractionInput;
    _fourthStarIcon.userInteractionEnabled = isInteractionInput;
    _fifthStarIcon.userInteractionEnabled = isInteractionInput;
    [self showStarBar:numberInput];
}

//初始化的时候根据所接收的默认星星个数，展示点亮的星星
- (void)showStarBar:(float)numberInput
{
    starNumber = numberInput;
    if (starNumber == (int)(starNumber + 0.5)) {
        for (UIImageView *img in self.subviews)
        {
            if (img.tag <= starNumber)
            {
                img.highlighted = YES;
            }
            else
            {
                //由于星星除了默认不亮和高亮显示两种图片外，还有半颗亮起的图片。所以此处
                //将半颗亮起图片和默认不亮图片交替设为imageView的image，所以每次设置
                //imageView的highlighted为NO时，均要手动改变其image，使其显示两张
                //图片中的正确的那张
                img.image = [UIImage imageNamed:@"gray_star.png"];
                img.highlighted = NO;
            }
        }
    }
    else
    {
        for (UIImageView *img in self.subviews)
        {
            if (img.tag < (int)(starNumber + 0.5))
            {
                img.highlighted = YES;
            }
            else if (img.tag == (int)(starNumber + 0.5))
            {
                img.image = [UIImage imageNamed:@"half_star.png"];
                img.highlighted = NO;
            }
            else
            {
                img.image = [UIImage imageNamed:@"gray_star.png"];
                img.highlighted = NO;
            }
        }
    }
}

- (StarIcon *)firstStarIcon
{
    if (!_firstStarIcon) {
        _firstStarIcon = [[StarIcon alloc] initWithFrame:CGRectMake(0, 0, size, size)];
        _firstStarIcon.tag = 1;
        _firstStarIcon.delegate = self;
    }
    return _firstStarIcon;
}

- (StarIcon *)secondStarIcon
{
    if (!_secondStarIcon) {
        _secondStarIcon = [[StarIcon alloc] initWithFrame:CGRectMake((size + interval), 0, size, size)];
        _secondStarIcon.tag = 2;
        _secondStarIcon.delegate = self;
    }
    return _secondStarIcon;
}

- (StarIcon *)thirdStarIcon
{
    if (!_thirdStarIcon) {
        _thirdStarIcon = [[StarIcon alloc] initWithFrame:CGRectMake((size + interval)*2, 0, size, size)];
        _thirdStarIcon.tag = 3;
        _thirdStarIcon.delegate = self;
    }
    return _thirdStarIcon;
}

- (StarIcon *)fourthStarIcon
{
    if (!_fourthStarIcon) {
        _fourthStarIcon = [[StarIcon alloc] initWithFrame:CGRectMake((size + interval)*3, 0, size, size)];
        _fourthStarIcon.tag = 4;
        _fourthStarIcon.delegate = self;
    }
    return _fourthStarIcon;
}

- (StarIcon *)fifthStarIcon
{
    if (!_fifthStarIcon) {
        _fifthStarIcon = [[StarIcon alloc] initWithFrame:CGRectMake((size + interval)*4, 0, size, size)];
        _fifthStarIcon.tag = 5;
        _fifthStarIcon.delegate = self;
    }
    return _fifthStarIcon;
}

#pragma mark -
#pragma mark touch event

//设置星星控件有滑动手势，即手指滑动可以改变星星亮暗
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x <= (_firstStarIcon.frame.origin.x + size/2))
    {
        _firstStarIcon.highlighted = NO;
        _secondStarIcon.highlighted = NO;
        _thirdStarIcon.highlighted = NO;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _firstStarIcon.image = [UIImage imageNamed:@"half_star.png"];
        _secondStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _thirdStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fourthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 0.5;
    }
    else if ((_firstStarIcon.frame.origin.x + size/2) < point.x && point.x <= (_firstStarIcon.frame.origin.x + size))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = NO;
        _thirdStarIcon.highlighted = NO;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _secondStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _thirdStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fourthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 1.0;
    }
    else if (_secondStarIcon.frame.origin.x < point.x && point.x <= (_secondStarIcon.frame.origin.x + size/2))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = NO;
        _thirdStarIcon.highlighted = NO;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _secondStarIcon.image = [UIImage imageNamed:@"half_star.png"];
        _thirdStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fourthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 1.5;
    }
    else if ((_secondStarIcon.frame.origin.x + size/2) < point.x && point.x <= (_secondStarIcon.frame.origin.x + size))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = NO;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _thirdStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fourthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 2.0;
    }
    else if (_thirdStarIcon.frame.origin.x < point.x && point.x <= (_thirdStarIcon.frame.origin.x + size/2))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = NO;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _thirdStarIcon.image = [UIImage imageNamed:@"half_star.png"];
        _fourthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 2.5;
    }
    else if ((_thirdStarIcon.frame.origin.x + size/2) < point.x && point.x <= (_thirdStarIcon.frame.origin.x + size))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = YES;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _fourthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 3.0;
    }
    else if (_fourthStarIcon.frame.origin.x < point.x && point.x <= (_fourthStarIcon.frame.origin.x + size/2))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = YES;
        _fourthStarIcon.highlighted = NO;
        _fifthStarIcon.highlighted = NO;
        _fourthStarIcon.image = [UIImage imageNamed:@"half_star.png"];
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 3.5;
    }
    else if ((_fourthStarIcon.frame.origin.x + size/2) < point.x && point.x <= (_fourthStarIcon.frame.origin.x + size))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = YES;
        _fourthStarIcon.highlighted = YES;
        _fifthStarIcon.highlighted = NO;
        _fifthStarIcon.image = [UIImage imageNamed:@"gray_star.png"];
        starNumber = 4.0;
    }
    else if (_fifthStarIcon.frame.origin.x < point.x && point.x <= (_fifthStarIcon.frame.origin.x + size/2))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = YES;
        _fourthStarIcon.highlighted = YES;
        _fifthStarIcon.highlighted = NO;
        _fifthStarIcon.image = [UIImage imageNamed:@"half_star.png"];
        starNumber = 4.5;
    }
    else if ((_fifthStarIcon.frame.origin.x + size/2) < point.x && point.x <= (_fifthStarIcon.frame.origin.x + size))
    {
        _firstStarIcon.highlighted = YES;
        _secondStarIcon.highlighted = YES;
        _thirdStarIcon.highlighted = YES;
        _fourthStarIcon.highlighted = YES;
        _fifthStarIcon.highlighted = YES;
        starNumber = 5.0;
    }
}

#pragma mark -
#pragma mark StarIconDelegate

//代理方法，星星点击手势，分为单击和双击两种。单击显示整颗星星点亮，双击显示半颗星星点亮。
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1)
    {
        starNumber = (float)sender.view.tag;
        for (UIImageView *img in self.subviews)
        {
            if (img.tag <= sender.view.tag)
            {
                img.highlighted = YES;
            }
            else
            {
                img.image = [UIImage imageNamed:@"gray_star.png"];
                img.highlighted = NO;
            }
        }
    }
    else if (sender.numberOfTapsRequired == 2)
    {
        starNumber = (float)sender.view.tag - 0.5;
        for (UIImageView *img in self.subviews)
        {
            if (img.tag < sender.view.tag)
            {
                img.highlighted = YES;
            }
            else if (img.tag == sender.view.tag)
            {
                img.image = [UIImage imageNamed:@"half_star.png"];
                img.highlighted = NO;
            }
            else
            {
                img.image = [UIImage imageNamed:@"gray_star.png"];
                img.highlighted = NO;
            }
        }
    }
}

@end
