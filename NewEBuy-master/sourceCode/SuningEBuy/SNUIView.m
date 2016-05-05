//
//  SNUIView.m
//  SNFramework
//
//  Created by  liukun on 14-1-14.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "SNUIView.h"

@implementation SNUIView

+ (instancetype)view
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
