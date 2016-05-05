//
//  BackBarView.m
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BackBarView.h"

@implementation BackBarView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)refreshBar:(NSString *)leftItem
       middleItem:(NSString *)middleItem
        rightItem:(NSString *)rightItem{
    
//    self.backBtn.frame = CGRectMake(15, 12, 12, 20);

    self.oneLbl.frame = CGRectMake(15, 7, 50, 30);
    
    self.twoLbl.frame = CGRectMake(_oneLbl.right, 7, 150, 30);

    self.oneLbl.text = leftItem;
    
    self.twoLbl.text = middleItem;
    
    self.submitBtn.frame = CGRectMake(230, 7, 80, 30);

    [self.submitBtn setTitle:rightItem forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark UIView

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage newImageFromResource:@"nav_back_normal.png"];
        [_backBtn setBackgroundImage:image forState:UIControlStateNormal];
        UIImage *image1 = [UIImage newImageFromResource:@"nav_back_selected.png"];
        [_backBtn setBackgroundImage:image1 forState:UIControlStateHighlighted];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}


-(UILabel *)oneLbl{
    
    if (!_oneLbl) {
        _oneLbl = [[UILabel alloc]init];
        _oneLbl.backgroundColor = [UIColor clearColor];
        _oneLbl.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_oneLbl];
    }
    return _oneLbl;
}

-(UILabel *)twoLbl{
    
    if (!_twoLbl) {
        _twoLbl = [[UILabel alloc]init];
        _twoLbl.backgroundColor = [UIColor clearColor];
        _twoLbl.font = [UIFont boldSystemFontOfSize:15];
        _twoLbl.textColor = [UIColor orange_Red_Color];
        [self addSubview:_twoLbl];
    }
    return _twoLbl;
}

-(UIButton *)submitBtn{
    
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:L(@"commitPay") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_submitBtn setBackgroundImage:stretchableButtonImageNormal
                              forState:UIControlStateNormal];
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_submitBtn setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_submitBtn];
    }
    return _submitBtn;
}


@end
