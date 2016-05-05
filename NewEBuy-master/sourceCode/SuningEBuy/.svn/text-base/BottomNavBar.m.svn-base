//
//  BottomNavBar.m
//  SuningEBuy
//
//  Created by liukun on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BottomNavBar.h"

@implementation BottomNavBar

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 48);
        self.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
        
        UIImageView *line = [[UIImageView alloc] init];
        line.frame = CGRectMake(0, 0, 320, 0.5);
        line.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:line];
        
        [self addSubview:self.backButton];
        
        [self addSubview:self.ebuyBtn];
        self.ebuyBtn.hidden = YES;
    }
    return self;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 2, 44, 44);
        [_backButton setImage:[UIImage imageNamed:@"nav_back_normal.png"]
                     forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"nav_back_select.png"]
                     forState:UIControlStateHighlighted];
    }
    return _backButton;
}

- (UIButton *)ebuyBtn
{
    if (!_ebuyBtn) {
        _ebuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ebuyBtn.frame = CGRectMake(320-60, 2, 60, 44);
        [_ebuyBtn setImage:[UIImage imageNamed:@"yigou.png"] forState:UIControlStateNormal];
        [_ebuyBtn setImage:[UIImage imageNamed:@"yigouDown.png"] forState:UIControlStateHighlighted];
    }
    return _ebuyBtn;
}
@end
