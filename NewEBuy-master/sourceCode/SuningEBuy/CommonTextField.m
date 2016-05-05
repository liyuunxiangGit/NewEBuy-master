//
//  CommonTextField.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField
@synthesize isDrawer;
- (void)setUpCommon
{
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    if (IOS5_OR_LATER) {
        self.spellCheckingType = UITextSpellCheckingTypeDefault;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUpCommon];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUpCommon];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return  CGRectInset(bounds, self.leftPadding, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rc = bounds;
    rc.origin.x = 5;
    rc.size.width -= 22;
    return rc;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    if (self.isDrawer)
    {
        [self.placeholderColor setFill];
        CGRect tmpRect = rect;
        
        if (IOS7_OR_LATER)
        {
            tmpRect.origin.y +=5;
            
        }
        [[self placeholder] drawInRect:tmpRect withFont:[UIFont systemFontOfSize:14]];
    }
    
}
@end
