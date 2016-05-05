//
//  CouponUserinfoView.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponUserinfoView.h"

@implementation CouponUserinfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        titileLabel.text = L(@"LOReceiverInfo");
        titileLabel.font = [UIFont systemFontOfSize:15];
        titileLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titileLabel];
        TT_RELEASE_SAFELY(titileLabel);

        UIImageView *infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 15, 15)];
        infoImageView.image = [UIImage imageNamed:@"coupon_info.png"];
        [self addSubview:infoImageView];
        TT_RELEASE_SAFELY(infoImageView);

        RTLabel *infoLabel = [[RTLabel alloc] initWithFrame:CGRectMake(25, 103, 280, 15)];
        infoLabel.font = [UIFont systemFontOfSize:12];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        infoLabel.text = L(@"LOIfChangeIDInfo");
        [self addSubview:infoLabel];
        TT_RELEASE_SAFELY(infoLabel);

        self.backgroundColor = [UIColor uiviewBackGroundColor];
        
        [self addSubview:self.userInfoLabel];

        }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_userInfoLabel);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (RTLabel *)userInfoLabel{
    
    if (_userInfoLabel == nil) {

        _userInfoLabel = [[RTLabel alloc] initWithFrame:CGRectMake(10, 35, 300, 65)];
        _userInfoLabel.backgroundColor = [UIColor clearColor];
        _userInfoLabel.font = [UIFont systemFontOfSize:12];
        _userInfoLabel.lineSpacing = 7;
        _userInfoLabel.text = L(@"LORealName");
        _userInfoLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        
    }
    
    return _userInfoLabel;
    
}

@end
