//
//  BBVerticalAlignmentLabel.m
//  BBVerticalAlignmentLabel
//
//  Created by liukun on 14-2-14.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "BBVerticalAlignmentLabel.h"

@implementation BBVerticalAlignmentLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    if (self.verticalAlignment == BBVerticalAlignmentTop)
    {
        CGSize textSize = [self.text sizeWithFont:self.font
                                constrainedToSize:self.frame.size
                                    lineBreakMode:self.lineBreakMode];
        CGFloat maxHeight = self.font.lineHeight * numberOfLines;
        
        return CGRectMake(0, 0, textSize.width, MIN(textSize.height, maxHeight));
        
    }
    else if (self.verticalAlignment == BBVerticalAlignmentBottom)
    {
        CGSize textSize = [self.text sizeWithFont:self.font
                                constrainedToSize:self.frame.size
                                    lineBreakMode:self.lineBreakMode];
        CGFloat maxHeight = self.font.lineHeight * numberOfLines;
        CGFloat realHeight = MIN(textSize.height, maxHeight);
        
        return CGRectMake(0, self.frame.size.height-realHeight, textSize.width, realHeight);
    }
    else
    {
        return [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    }
}

- (void)drawTextInRect:(CGRect)rect
{
    CGRect r = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    
    [super drawTextInRect:r];
}

@end
