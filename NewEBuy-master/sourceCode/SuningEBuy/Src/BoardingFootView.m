//
//  BoardingFootView.m
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BoardingFootView.h"

@implementation BoardingFootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.submitBtn.frame = CGRectMake(20, 30, 280, 36);
        self.tipLbl.frame = CGRectMake(20, 80, 240, 40);
        self.helpBtn.frame = CGRectMake(260, 80, 35, 35);

    }
    return self;
}

#pragma mark -
#pragma mark UIView

-(UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        [_submitBtn setTitle:L(@"Ok") forState:UIControlStateNormal];
    
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed:@"submit_button_normal.png"];
        [_submitBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        UIImage *image1 = [UIImage imageNamed:@"submit_button_touched.png"];
        [_submitBtn setBackgroundImage:image1 forState:UIControlStateHighlighted];
        
        [self addSubview:_submitBtn];
    }
    
    return _submitBtn;
}

-(UILabel *)tipLbl{
    
    if (_tipLbl == nil) {
        _tipLbl = [[UILabel alloc]init];
        _tipLbl.font = [UIFont systemFontOfSize:14.0];
        _tipLbl.backgroundColor = [UIColor clearColor];
        _tipLbl.numberOfLines = 0;
        _tipLbl.text = L(@"BTPleaseCheckPassengeName");
        _tipLbl.textColor = [UIColor darkGrayColor];
        [self addSubview:_tipLbl];
        
    }
    return _tipLbl;
}

-(UIButton *)helpBtn{
    
    if (_helpBtn == nil) {
        
        _helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_helpBtn setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
        
        [_helpBtn setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateHighlighted];
        
        [self addSubview:_helpBtn];
    }
    return _helpBtn;
}

@end
