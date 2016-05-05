//
//  SegmentedView.m
//  SuningEBuy
//
//  Created by xingxianping on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SegmentedView.h"

#define kLeftButtonNormalImage @"button_white_normal.png"
#define kLeftButtonHighlightImage @"button_white_disable.png"
#define kMiddleButtonNormalImage @"button_white_normal.png"
#define kMiddleButtonHighlightImage @"button_white_disable.png"
#define kRightButtonNormalImage @"button_white_normal.png"
#define kRightButtonHighlightImage @"button_white_disable.png"

@implementation SegmentedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectNum=10;
        [self addSubview:self.leftBtn];
        [self addSubview:self.middleBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame=CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height);
        [_leftBtn setBackgroundImage:[UIImage imageNamed:kLeftButtonHighlightImage] forState:UIControlStateSelected];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:kLeftButtonNormalImage] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_leftBtn setTitle:L(@"coupon unUse") forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBtn.tag=10;
        
        [_leftBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _leftBtn.selected = YES;
    }
    return _leftBtn;
}

- (UIButton *)middleBtn
{
    if (!_middleBtn) {
        _middleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.frame=CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, self.frame.size.height);
        [_middleBtn setBackgroundImage:[UIImage imageNamed:kMiddleButtonHighlightImage] forState:UIControlStateSelected];
        [_middleBtn setBackgroundImage:[UIImage imageNamed:kMiddleButtonNormalImage] forState:UIControlStateNormal];
        _middleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_middleBtn setTitle:L(@"coupon used") forState:UIControlStateNormal];
        [_middleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _middleBtn.tag=11;
        
       // [_middleBtn setBackgroundColor:<#(UIColor *)#>];
        
        [_middleBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=CGRectMake(2*self.frame.size.width/3, 0, self.frame.size.width/3, self.frame.size.height);
        [_rightBtn setBackgroundImage:[UIImage imageNamed:kRightButtonHighlightImage] forState:UIControlStateSelected];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:kRightButtonNormalImage] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_rightBtn setTitle:L(@"coupon outOfUse") forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBtn.tag=12;
        
        [_rightBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(void)selectLeftBtn{
    
    self.selectNum = self.leftBtn.tag;
    
    NSInteger i = 3;
    
    self.leftBtn.selected=YES;
    self.middleBtn.selected=NO;
    self.rightBtn.selected=NO;
    
    if ([self.delegate respondsToSelector:@selector(requestWithSegmentBtnClicked:)]) {
        [self.delegate requestWithSegmentBtnClicked:i];
    }
}
- (void)buttonClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger index=btn.tag;
    if (self.selectNum == index) {
        return;
    }
    NSInteger i;
    if (index==10) {
        i=3;
        _leftBtn.selected=YES;
        _middleBtn.selected=NO;
        _rightBtn.selected=NO;
    }
    else if (index==11)
    {
        i=4;
        _leftBtn.selected=NO;
        _middleBtn.selected=YES;
        _rightBtn.selected=NO;
    }
    else{
        _leftBtn.selected=NO;
        _middleBtn.selected=NO;
        _rightBtn.selected=YES;
        i=5;
    }
    self.selectNum = btn.tag;
    
    if ([self.delegate respondsToSelector:@selector(requestWithSegmentBtnClicked:)]) {
        [self.delegate requestWithSegmentBtnClicked:i];
    }
}

@end
