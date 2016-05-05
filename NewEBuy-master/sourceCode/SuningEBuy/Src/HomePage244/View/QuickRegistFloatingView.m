//
//  QuickRegistFloatingView.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-11-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "QuickRegistFloatingView.h"

@implementation QuickRegistFloatingView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self) {
        self.owner = owner;
        
        self.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:self.leftDescButton];
        
        //快速注册按钮
        UIButton *quickRegistButton = [UIButton buttonWithType:UIButtonTypeCustom];
        quickRegistButton.frame = CGRectMake(kScreenWidth-50-80, 10, 80, 30);
        [quickRegistButton setBackgroundColor:[UIColor light_Gray_Color]];
        [quickRegistButton setTitle:@"快速注册" forState:UIControlStateNormal];
        quickRegistButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [quickRegistButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [quickRegistButton addTarget:self.owner action:@selector(quickRegistButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:quickRegistButton];
        
        //关闭按钮
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(kScreenWidth-50, 10, 50, 30);
        [closeButton setBackgroundColor:[UIColor whiteColor]];
        [closeButton setTitle:@"X" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];

    }
    return self;
}

- (UIButton *)leftDescButton {
    if (!_leftDescButton) {
        _leftDescButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftDescButton.frame = CGRectMake(0, 10, kScreenWidth-50-80, 25);
        [_leftDescButton setBackgroundColor:[UIColor clearColor]];
        [_leftDescButton setTitle:@"新人注册立享10元新人礼券!" forState:UIControlStateNormal];
        _leftDescButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftDescButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_leftDescButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_leftDescButton addTarget:self.owner action:@selector(leftDescButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftDescButton;
}




#pragma mark - ButtonMethod
- (void)closeButtonClick {
    //点击埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120018"], nil]];
    
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
