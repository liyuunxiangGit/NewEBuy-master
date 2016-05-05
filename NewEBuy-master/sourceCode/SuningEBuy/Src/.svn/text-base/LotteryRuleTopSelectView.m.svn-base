//
//  LotteryRuleTopSelectView.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-30.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "LotteryRuleTopSelectView.h"
#import <QuartzCore/QuartzCore.h>
@interface LotteryRuleTopSelectView () {
@private
    
}

@property (nonatomic, strong)  UIButton    *leftBtn;
@property (nonatomic, strong)  UIButton    *rightBtn;

@end

@implementation LotteryRuleTopSelectView

@synthesize delegate = _delegate;
@synthesize leftBtn = _leftBtn;
@synthesize rightBtn = _rightBtn;
@synthesize titleArr = _titleArr;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_rightBtn);
    TT_RELEASE_SAFELY(_leftBtn);
    TT_RELEASE_SAFELY(_titleArr);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        if (!_titleArr) {
            _titleArr = [[NSArray alloc] init];
        }
        
        [self addSubview:self.leftBtn];

        [self addSubview:self.rightBtn];
        
    }
    return self;
}

- (void)setButtonTitle;
{
    
    [self.leftBtn setTitle:[self.titleArr objectAtIndex:0] forState:UIControlStateNormal];
  
    [self.rightBtn setTitle:[self.titleArr objectAtIndex:1] forState:UIControlStateNormal];
}

- (UIButton *)leftBtn{
    
    if (!_leftBtn) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _leftBtn.frame = CGRectMake(0, 0, 152, 38);
        
        _leftBtn.tag = 930;
        
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        if (IOS7_OR_LATER)
        {
            [_leftBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
            
            [_leftBtn setTitleColor:[UIColor colorWithRGBHex:0x515151] forState:UIControlStateSelected];
            _leftBtn.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
            
            _leftBtn.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
            
            _leftBtn.layer.borderWidth = 1;
        }
        else
        {
            [_leftBtn setTitleColor:RGBCOLOR(107, 81, 78) forState:UIControlStateNormal];
            
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"rule_left_unselect.png"] forState:UIControlStateNormal];
            
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"rule_left_selected.png"] forState:UIControlStateSelected];
            _leftBtn.backgroundColor = [UIColor whiteColor];
            [_leftBtn setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [_leftBtn setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateSelected];
        }
        
        [_leftBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        
        _leftBtn.selected = YES;
        
        
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightBtn.frame = CGRectMake(152, 0, 150, 38);

        _rightBtn.tag = 931;
        
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        if (IOS7_OR_LATER)
        {
            [_rightBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
            
            [_rightBtn setTitleColor:[UIColor colorWithRGBHex:0x515151] forState:UIControlStateSelected];
            _rightBtn.backgroundColor = [UIColor colorWithRGBHex:0xfcfcfd];
            
            _rightBtn.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
            
            _rightBtn.layer.borderWidth = 1;
        }
        else
        {
            [_rightBtn setTitleColor:RGBCOLOR(107, 81, 78) forState:UIControlStateNormal];
            
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"rule_right_unselect.png"] forState:UIControlStateNormal];
            
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"rule_right_selected.png"] forState:UIControlStateSelected];
            _rightBtn.backgroundColor = [UIColor whiteColor];
            [_rightBtn setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateSelected];
        }
        
        [_rightBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
                
    }
    return _rightBtn;
}


- (void)selectType:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 930) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        _leftBtn.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        _rightBtn.backgroundColor = [UIColor colorWithRGBHex:0xfcfcfd];
    }
    else{
        _leftBtn.backgroundColor = [UIColor colorWithRGBHex:0xfcfcfd];
        _rightBtn.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
    }
    if ([self.delegate conformsToProtocol:@protocol(LotteryRuleTopSelectViewDelegate)]) {
        if ([self.delegate respondsToSelector:@selector(didSelectedOKWithIndex:)]) {
            [self.delegate didSelectedOKWithIndex:btn.tag - 930];
        }
    }
    
}

@end
