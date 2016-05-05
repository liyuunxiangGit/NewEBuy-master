//
//  UpSegmentView.m
//  SuningEBuy
//
//  Created by xingxianping on 13-8-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UpSegmentView.h"

#define kLeftButtonHighlightImage       @"search_fouce_left.png"
#define kRightButtonHighlightImage      @"search_fouce_right.png"

#define kButtonNormalImage  @"search_normal_new.png"

@implementation UpSegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.backgroundImage];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.desLabel];
        
        self.index=0;
        [self refreshButtons];
    }
    return self;
}

- (UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kButtonNormalImage]];
        _backgroundImage.frame= CGRectMake(0, 0, 320, 32);
    }
    return _backgroundImage;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.leftButton.bottom+15, 150, 30)];
        
        _desLabel.textAlignment = UITextAlignmentLeft;
        
        _desLabel.font = [UIFont systemFontOfSize:16];
        
        _desLabel.textColor = [UIColor blackColor];
        
        _desLabel.text = L(@"detail coupon");
        
        [_desLabel setAdjustsFontSizeToFitWidth:NO];
        
        [_desLabel setNumberOfLines:0];
        
        _desLabel.backgroundColor = [UIColor clearColor];
        
        _desLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    }
    return _desLabel;
}
-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 160, 32);
        [_leftButton setBackgroundImage:[UIImage imageNamed:kLeftButtonHighlightImage] forState:UIControlStateSelected];
        [_leftButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_leftButton setTitleColor:RGBCOLOR(39, 39, 39) forState:UIControlStateSelected];
        [_leftButton setTitleColor:RGBCOLOR(165, 156, 134) forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.backgroundColor=[UIColor clearColor];
        _leftButton.tag = 0;
        [_leftButton setTitle:L(@"coupon") forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(160, 0, 160, 32);
        [_rightButton setBackgroundImage:[UIImage imageNamed:kRightButtonHighlightImage] forState:UIControlStateSelected];
        [_rightButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_rightButton setTitleColor:RGBCOLOR(39, 39, 39) forState:UIControlStateSelected];
        [_rightButton setTitleColor:RGBCOLOR(165, 156, 134) forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.backgroundColor=[UIColor clearColor];
        _rightButton.tag = 1;
        [_rightButton setTitle:L(@"intergal change coupon") forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _rightButton;
}

- (void)buttonTapped:(id)sender
{
    UIButton *btn= (UIButton *)sender;
    NSInteger tag=btn.tag;
    if (self.index == tag) {
        return ;
    }
    self.index=tag;
    if ([self.delegate respondsToSelector:@selector(buttonClickedAtIndex:)]) {
        [self.delegate buttonClickedAtIndex:self.index];
    }
}

- (void)refreshButtons
{
    if (self.index == 0) {
        [self.leftButton setSelected:YES];
        [self.rightButton setSelected:NO];
        self.desLabel.text = L(@"detail coupon");
    }else{
        [self.leftButton setSelected:NO];
        [self.rightButton setSelected:YES];
        self.desLabel.text = L(@"intergal change coupon detail");
    }
}
@end
