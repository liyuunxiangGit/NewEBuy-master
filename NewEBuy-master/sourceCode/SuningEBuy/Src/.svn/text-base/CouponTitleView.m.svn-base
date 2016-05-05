//
//  CouponTitleView.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponTitleView.h"

@implementation CouponTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        titileLabel.text = L(@"LOPlanInfo");
        titileLabel.font = [UIFont systemFontOfSize:15];
        titileLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titileLabel];
        TT_RELEASE_SAFELY(titileLabel);
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 1)];
        lineView.backgroundColor = [UIColor uiviewBackGroundColor];
        [self addSubview:lineView];
        TT_RELEASE_SAFELY(lineView);
        

        [self addSubview:self.nameLabel];

        [self addSubview:self.indicatorImageView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_indicatorImageView);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (RTLabel *)nameLabel{
    
    if (_nameLabel == nil) {
        _nameLabel = [[RTLabel alloc] initWithFrame:CGRectMake(15, 35, 270, 20)];

        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
    }
    
    return _nameLabel;
    
}

- (UIImageView *)indicatorImageView {
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 23, 10, 8)];
        _indicatorImageView.image = [UIImage imageNamed:@"coupon_show.png"];
        
    }
    return _indicatorImageView;
}
@end
