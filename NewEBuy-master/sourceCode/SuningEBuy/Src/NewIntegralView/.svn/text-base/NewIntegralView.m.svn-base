//
//  NewIntegralView.m
//  SuningEBuy
//
//  Created by Wxj on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewIntegralView.h"

@interface NewIntegralView ()

@property (nonatomic,strong) CustomSegment              *segmentBtn;

@property (nonatomic,strong) UILabel                    *totalIntegralDescLabel;

@end

@implementation NewIntegralView

- (id)initWithFrame:(CGRect)frame andOwner:(id)owner
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.owner = owner;
        
        [self addSubview:self.segmentBtn];
        
        [self addSubview:self.headerview];
    }
    return self;
}

- (CustomSegment *)segmentBtn
{
    if (!_segmentBtn)
    {
        _segmentBtn = [[CustomSegment alloc] init];
        
        [_segmentBtn setItems:[NSArray arrayWithObjects:L(@"MyEBuy_Get"),L(@"MyEBuy_Expenditure"), nil]];
        
        _segmentBtn.delegate = self.owner;
        
    }
    return _segmentBtn;
}

-(UIView*)headerview
{
    if (!_headerview)
    {
        _headerview = [[UIView alloc]initWithFrame:CGRectMake(0, _segmentBtn.bottom, 320, 65)];
        
        _headerview.backgroundColor = [UIColor whiteColor];
        
        [_headerview addSubview:self.totalIntegralDescLabel];
        
        [_headerview addSubview:self.totalIntegralLabel];
        
        [_headerview addSubview:self.getIntegralBtn];
    }
    return _headerview;
}

-(UILabel*)totalIntegralDescLabel
{
    if (!_totalIntegralDescLabel)
    {
        _totalIntegralDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 105, _headerview.height)];
        
        _totalIntegralDescLabel.backgroundColor = [UIColor clearColor];
        
        _totalIntegralDescLabel.textColor = [UIColor light_Black_Color];
        
        _totalIntegralDescLabel.font = [UIFont systemFontOfSize:14.0];
        
        _totalIntegralDescLabel.text = [NSString stringWithFormat:@"%@：",L(@"MyEBuy_CurrentIntegralBalance")];
    }
    return _totalIntegralDescLabel;
}

-(UILabel*)totalIntegralLabel
{
    if (!_totalIntegralLabel)
    {
        _totalIntegralLabel = [[UILabel alloc]initWithFrame:CGRectMake(_totalIntegralDescLabel.right, 0, 110, _headerview.height)];
        
        _totalIntegralLabel.backgroundColor = [UIColor clearColor];
        
        _totalIntegralLabel.textColor = [UIColor orange_Light_Color];
        
        _totalIntegralLabel.font = [UIFont systemFontOfSize:16.0];
        
        _totalIntegralLabel.text = @"--";
    }
    return _totalIntegralLabel;
}

-(UIButton*)getIntegralBtn
{
    if (!_getIntegralBtn)
    {
        _getIntegralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_getIntegralBtn setTitle:L(@"MyEBuy_GoToEarnIntegral") forState:UIControlStateNormal];
        
        [_getIntegralBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_getIntegralBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        
        [_getIntegralBtn setBackgroundImage:[UIImage imageNamed:@"getIntegralBtn"] forState:UIControlStateNormal];
        
        [_getIntegralBtn setBackgroundImage:[UIImage imageNamed:@"getIntegralBtn_selected"] forState:UIControlStateHighlighted];
        
        [_getIntegralBtn addTarget:self.owner action:@selector(integralAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _getIntegralBtn.frame = CGRectMake(_totalIntegralLabel.right,15, 75, 35);
    }
    return _getIntegralBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
