//
//  VoiceSearchKeyboardView.m
//  SuningEBuy
//
//  Created by chupeng on 14-9-24.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceSearchKeyboardView.h"
#import "VoiceSearchViewController.h"
@implementation VoiceSearchKeyboardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        vLine.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vLine];
        [self addSubview:self.btnSpeaker];
    }
    return self;
}

- (void)dealloc
{
    _delegate = nil;
}

- (UIButton *)btnSpeaker
{
    if (!_btnSpeaker)
    {
        _btnSpeaker = [[UIButton alloc] init];
        _btnSpeaker.center = self.center;
        _btnSpeaker.bounds = CGRectMake(0, 2, 23, 36);
        [_btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone.png"] forState:UIControlStateNormal];
        [_btnSpeaker addTarget:self action:@selector(btnSpeakerTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnSpeaker;
}

- (void)btnSpeakerTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnSpeakerTapped)])
    {
        [self.delegate btnSpeakerTapped];
        
    }
}

@end
