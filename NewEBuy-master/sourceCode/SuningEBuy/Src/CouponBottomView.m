//
//  CouponBottomView.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponBottomView.h"

@implementation CouponBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:.8];
        
        [self addSubview:self.payNumLabel];

    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_payNumLabel);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - getMethod
- (RTLabel *)payNumLabel{
    
    if (_payNumLabel == nil) {
        _payNumLabel = [[RTLabel alloc] initWithFrame:CGRectMake(10, 20, 300, 20)];
        _payNumLabel.font = [UIFont systemFontOfSize:12];
        _payNumLabel.backgroundColor = [UIColor clearColor];
        _payNumLabel.textColor = [UIColor whiteColor];
        
    }
    
    return _payNumLabel;
    
}

@end
