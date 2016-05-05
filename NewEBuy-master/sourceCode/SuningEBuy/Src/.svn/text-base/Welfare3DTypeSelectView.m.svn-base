//
//  Welfare3DTypeSelectView.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "Welfare3DTypeSelectView.h"
#import <QuartzCore/QuartzCore.h>
#define      defaultWidth         90
#define      defaultHeight        30
#define      selectedFontColor    [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0]
#define      unselectFontColor    [UIColor btnTitleNormalColor]

@interface Welfare3DTypeSelectView(){

    int          _selectType;
}

@end


@implementation Welfare3DTypeSelectView

@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;
@synthesize button5 = _button5;
@synthesize button6 = _button6;
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selectType = zhiXuan;
        
    }
    return self;
}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_button1);
    TT_RELEASE_SAFELY(_button2);
    TT_RELEASE_SAFELY(_button3);    
    TT_RELEASE_SAFELY(_button4);    
    TT_RELEASE_SAFELY(_button5);    
    TT_RELEASE_SAFELY(_button6);
    
}


- (UIButton *)button1{
    
    if (!_button1) {
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button1.tag = zhiXuan;
        
        [_button1 setTitle:L(@"Direct election") forState:UIControlStateNormal];
        
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_button1 setTitleColor:selectedFontColor forState:UIControlStateSelected];
                
        [_button1 setTitleColor:unselectFontColor forState:UIControlStateNormal];
        
        _button1.backgroundColor = [UIColor whiteColor];

        [_button1 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        
        _button1.selected = YES;
        
        [self addSubview:_button1];
    }
    
    return _button1;
}


- (UIButton *)button2{
    
    if (!_button2) {
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button2.tag = zuSan;
        
        [_button2 setTitle:L(@"Groups of three") forState:UIControlStateNormal];
     
        [_button2 setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        
        [_button2 setBackgroundImage:[UIImage imageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_button2 setTitleColor:selectedFontColor forState:UIControlStateSelected];
        
        [_button2 setTitleColor:unselectFontColor forState:UIControlStateNormal];
        
        _button2.backgroundColor = [UIColor whiteColor];
        
        [_button2 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button2];
    }
    
    return _button2;
}


- (UIButton *)button3{
    
    if (!_button3) {
        
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button3.tag = zuLiu;
        
        [_button3 setTitle:L(@"Groups of six") forState:UIControlStateNormal];
        
        [_button3 setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        
        [_button3 setBackgroundImage:[UIImage imageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        [_button3 setTitleColor:selectedFontColor forState:UIControlStateSelected];
        
        [_button3 setTitleColor:unselectFontColor forState:UIControlStateNormal];
        
        _button3.backgroundColor = [UIColor whiteColor];
        
        [_button3 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button3];
    }
    
    return _button3;
}


- (UIButton *)button4{
    
    if (!_button4) {
        
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button4.tag = zhiXuanHeZhi;
        
        [_button4 setTitle:L(@"Direct value") forState:UIControlStateNormal];
        
        [_button4 setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        
        [_button4 setBackgroundImage:[UIImage imageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_button4 setTitleColor:selectedFontColor forState:UIControlStateSelected];
        
        [_button4 setTitleColor:unselectFontColor forState:UIControlStateNormal];
        
        _button4.backgroundColor = [UIColor whiteColor];
        
        [_button4 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button4];
    }
    
    return _button4;
}




- (UIButton *)button5{
    
    if (!_button5) {
        
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button5.tag = zuSanHeZhi;
        
        [_button5 setTitle:L(@"Groups of three and values") forState:UIControlStateNormal];
        
        [_button5 setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        
        [_button5 setBackgroundImage:[UIImage imageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_button5 setTitleColor:selectedFontColor forState:UIControlStateSelected];
        
        [_button5 setTitleColor:unselectFontColor forState:UIControlStateNormal];
        
        //_button5.backgroundColor = [UIColor whiteColor];

        [_button5 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button5];
    }
    
    return _button5;
}



- (UIButton *)button6{
    
    if (!_button6) {
        
        _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button6.tag = zuLiuHeZhi;
        
        [_button6 setTitle:L(@"Group six and values") forState:UIControlStateNormal];        
        
        [_button6 setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        
        [_button6 setBackgroundImage:[UIImage imageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_button6 setTitleColor:selectedFontColor forState:UIControlStateSelected];
        
        [_button6 setTitleColor:unselectFontColor forState:UIControlStateNormal];
        
        //_button6.backgroundColor = [UIColor whiteColor];
        
        [_button6 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
        [self addSubview:_button6];
    }
    
    return _button6;
}


- (void)layoutSubviews{

    self.button1.frame = CGRectMake(25, 0, defaultWidth, defaultHeight);

    self.button2.frame = CGRectMake(self.button1.right - 1, 0, defaultWidth, defaultHeight);
    
    self.button3.frame = CGRectMake(self.button2.right - 1, 0, defaultWidth, defaultHeight );
    
    self.button4.frame = CGRectMake(self.button1.left, 0 + defaultHeight , defaultWidth, defaultHeight);
    
    self.button5.frame = CGRectMake(self.button1.right -1 , 0 + defaultHeight , defaultWidth, defaultHeight);
    
    self.button6.frame = CGRectMake(self.button2.right - 1, 0 + defaultHeight , defaultWidth, defaultHeight);
    
    self.button1.layer.borderColor = RGBCOLOR(244, 244, 244).CGColor;
    self.button1.layer.borderWidth = 1;
    self.button2.layer.borderColor = RGBCOLOR(244, 244, 244).CGColor;
    self.button2.layer.borderWidth = 1;
    self.button3.layer.borderColor = RGBCOLOR(244, 244, 244).CGColor;
    self.button3.layer.borderWidth = 1;
    self.button4.layer.borderColor = RGBCOLOR(244, 244, 244).CGColor;
    self.button4.layer.borderWidth = 1;
    self.button5.layer.borderColor = RGBCOLOR(244, 244, 244).CGColor;
    self.button5.layer.borderWidth = 1;
    self.button6.layer.borderColor = RGBCOLOR(244, 244, 244).CGColor;
    self.button6.layer.borderWidth = 1;
    
    [super layoutSubviews];
    
}

- (void)selectType:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if (_selectType == btn.tag) {
    
        return;
    }
    
    _selectType = btn.tag;
    
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;
    
    switch (_selectType) {
        case zhiXuan:
            self.button1.selected = YES;
            break;
        case zuSan:
            self.button2.selected = YES;
            break;
        case zuLiu:
            self.button3.selected = YES;
            break;
        case zhiXuanHeZhi:
            self.button4.selected = YES;
            break;
        case zuSanHeZhi:
            self.button5.selected = YES;
            break;
        case zuLiuHeZhi:
            self.button6.selected = YES;
            break;            
        default:
            break;
    }

    
    
    if ([_delegate conformsToProtocol:@protocol(Welfare3DTypeSelectViewDelegate)]) {
        
        if ([_delegate respondsToSelector:@selector(didSelectWelfare3DTypeOK:)]) {
            
            [_delegate didSelectWelfare3DTypeOK:btn.tag];
        }
    }
}

- (void)changeBallType:(int)indexType{
    
    _selectType = indexType;
    
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;
    
    switch (indexType) {
        case zhiXuan:
            self.button1.selected = YES;
            break;
        case zuSan:
            self.button2.selected = YES;
            break;
        case zuLiu:
            self.button3.selected = YES;
            break;
        case zhiXuanHeZhi:
            self.button4.selected = YES;
            break;
        case zuSanHeZhi:
            self.button5.selected = YES;
            break;
        case zuLiuHeZhi:
            self.button6.selected = YES;
            break;            
        default:
            break;
    }
}


@end
