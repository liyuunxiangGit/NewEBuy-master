//
//  StrikeThroughLabel.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "StrikeThroughLabel.h"

@implementation StrikeThroughLabel
@synthesize isWithStrikeThrough = isWithStrikeThrough_;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.isWithStrikeThrough = YES;
        
        if (!line)
        {
            line = [[CALayer alloc] init];
            line.frame = CGRectZero;
            [self.layer addSublayer:line];
        }
    }
    return self;
}

- (void)dealloc
{
//    TT_RELEASE_SAFELY(line_);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    line.backgroundColor = self.textColor.CGColor;
    
    CGSize wordSize = [self.text sizeWithFont:self.font
                            constrainedToSize:self.size
                                lineBreakMode:self.lineBreakMode];
    
    if (isWithStrikeThrough_) {
        if (self.textAlignment == NSTextAlignmentLeft)
        {
            line.frame = CGRectMake(0, (self.size.height + 2) / 2, wordSize.width, 1);
        }
        else if (self.textAlignment == NSTextAlignmentCenter)
        {
            line.frame = CGRectMake((self.width-wordSize.width)/2, (self.size.height + 2) / 2, wordSize.width, 1);
        }
        else if (self.textAlignment == NSTextAlignmentRight)
        {
            line.frame = CGRectMake(self.width-wordSize.width, (self.size.height + 2) / 2, wordSize.width, 1);
        }

    }
    
}

//
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    if (isWithStrikeThrough_) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        //设置颜色
//        UIColor *textColor = self.textColor;
//        CGContextSetStrokeColorWithColor(context, textColor.CGColor);
//        
//        //设置线宽
//        CGContextSetLineWidth(context, 1);
//        CGContextSetLineCap(context, kCGLineCapRound);
//        
//        //画线
//        
//        CGSize wordSize = [self.text sizeWithFont:self.font
//                                constrainedToSize:self.size
//                                    lineBreakMode:self.lineBreakMode];
//        
//        if (self.textAlignment == NSTextAlignmentLeft)
//        {
//            CGContextMoveToPoint(context, 0, self.size.height/2);
//            CGContextAddLineToPoint(context, wordSize.width, self.size.height/2);
//        }
//        else if (self.textAlignment == NSTextAlignmentCenter)
//        {
//            CGContextMoveToPoint(context, (self.width-wordSize.width)/2, self.size.height/2);
//            CGContextAddLineToPoint(context, (self.width+wordSize.width)/2, self.size.height/2);
//        }
//        else if (self.textAlignment == NSTextAlignmentRight)
//        {
//            CGContextMoveToPoint(context, self.width-wordSize.width, self.size.height/2);
//            CGContextAddLineToPoint(context, self.width, self.size.height/2);
//        }
//        
//        CGContextStrokePath(context);
//    }
//    
//}

@end
