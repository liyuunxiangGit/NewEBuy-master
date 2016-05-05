//
//  CouponContectView.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponContectView.h"

@implementation CouponContectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        titileLabel.text = L(@"LOAddCertification");
        titileLabel.font = [UIFont systemFontOfSize:15];
        titileLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titileLabel];
        TT_RELEASE_SAFELY(titileLabel);
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
        lineView.backgroundColor = [UIColor uiviewBackGroundColor];
        [self addSubview:lineView];
        TT_RELEASE_SAFELY(lineView);
        
        [self addSubview:self.indicatorImageView];

        self.backgroundColor = [UIColor whiteColor];
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

- (void)dealloc {
    TT_RELEASE_SAFELY(_indicatorImageView);
}
- (UIImageView *)indicatorImageView {
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 16, 10, 8)];
        _indicatorImageView.image = [UIImage imageNamed:@"coupon_dismiss.png"];
        
    }
    return _indicatorImageView;
}

@end
