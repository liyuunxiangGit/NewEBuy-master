//
//  ReturnGoodsTiaoXingMa.m
//  SuningEBuy
//
//  Created by xmy on 19/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnGoodsTiaoXingMa.h"

@implementation ReturnGoodsTiaoXingMa

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"MyEBuy_OrderId");
        self.hasSuspendButton = YES;

//        [self useBottomNavBar];
//        self.bottomNavBar.backButton.hidden = YES;
//        [self.bottomNavBar addSubview:self.yiGouBtn];

    }
    return self;
}
- (UIButton*)yiGouBtn
{
    if(!_yiGouBtn)
    {
        _yiGouBtn = [[UIButton alloc] init];
        
        _yiGouBtn.backgroundColor = [UIColor clearColor];
        
        _yiGouBtn.frame = CGRectMake(self.view.size.width-57, 8, 57, 35);
        
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigou.png"] forState:UIControlStateNormal];
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigouDown.png"] forState:UIControlStateHighlighted];
        
        [_yiGouBtn addTarget:self action:@selector(yiGouBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomNavBar addSubview:_yiGouBtn];
        
    }
    
    return _yiGouBtn;
}

- (void)yiGouBtnAction
{
    [self orderYiGouBtnShowRightSideView];
}


@end
