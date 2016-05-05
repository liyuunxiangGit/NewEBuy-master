//
//  ShipModeSelectView.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShipModeSelectView.h"

@interface ShipModeSelectView()

@property (nonatomic, strong) UIImageView   *kuangImgView;

@property (nonatomic, strong) UIButton      *backBtn;

@property (nonatomic, strong) UIButton      *suningSendBtn;

@property (nonatomic, strong) UIButton      *takeSelfBtn;

@property (nonatomic, strong) UIImageView   *selectImg;

@end

@implementation ShipModeSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIImageView *)kuangImgView
{
    if (!_kuangImgView) {
        _kuangImgView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 82, 104, 30)];
        _kuangImgView.image = [UIImage imageNamed:@"ShopCart_kuang.png"];
        _kuangImgView.clipsToBounds = YES;
        _kuangImgView.userInteractionEnabled = YES;
        [_kuangImgView addSubview:self.takeSelfBtn];
        [_kuangImgView addSubview:self.suningSendBtn];
        [_kuangImgView addSubview:self.selectImg];
        [self addSubview:_kuangImgView];
        
    }
    return _kuangImgView;
}

- (UIImageView *)selectImg
{
    if (!_selectImg) {
        _selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(82, 13, 9, 7)];
        _selectImg.image = [UIImage imageNamed:@"ShopCart_ShipMode_Select.png"];
    }
    return _selectImg;
}

- (UIButton *)suningSendBtn
{
    if (!_suningSendBtn) {
        _suningSendBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 3, 95, 24)];
        _suningSendBtn.backgroundColor = [UIColor clearColor];
        [_suningSendBtn setTitle:L(@"suning delivey") forState:UIControlStateNormal];
        [_suningSendBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        [_suningSendBtn setTitleEdgeInsets:UIEdgeInsetsMake(-5, -32, 0, 0)];
        [_suningSendBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBHex:0xcacaca] size:_suningSendBtn.size] forState:UIControlStateHighlighted];
        _suningSendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _suningSendBtn.tag = 1001;
        [_suningSendBtn addTarget:self action:@selector(shipMoseSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _suningSendBtn;
}

- (UIButton *)takeSelfBtn
{
    if (!_takeSelfBtn) {
        _takeSelfBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 30, 95, 24)];
        _takeSelfBtn.backgroundColor = [UIColor clearColor];
        [_takeSelfBtn setTitleEdgeInsets:UIEdgeInsetsMake(-5, -32, 0, 0)];
        [_takeSelfBtn setTitle:L(@"store mention") forState:UIControlStateNormal];
        [_takeSelfBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        [_takeSelfBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBHex:0xcacaca] size:_takeSelfBtn.size] forState:UIControlStateHighlighted];
        _takeSelfBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _takeSelfBtn.tag = 1002;
        [_takeSelfBtn addTarget:self action:@selector(shipMoseSelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _takeSelfBtn;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor clearColor];
        [_backBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}

- (void)showInSuperView:(UIView *)superView withShipMode:(ShipMode)shipMode
{
    [superView addSubview:self];
    
    self.frame = superView.bounds;
    
    self.backBtn.frame = self.frame;
    
    self.shipMode = shipMode;
    
    if (shipMode == ShipModeSuningSend) {
        self.suningSendBtn.frame = CGRectMake(5, 3, 95, 30);
        self.takeSelfBtn.frame = CGRectMake(5, 37, 95, 30);
    }
    else
    {
        self.suningSendBtn.frame = CGRectMake(5, 37, 95, 30);
        self.takeSelfBtn.frame = CGRectMake(5, 3, 95, 30);
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.kuangImgView.frame =CGRectMake(95, 82, 104, 70);
        self.selectImg.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
}
- (void)hide
{
    [UIView animateWithDuration:0.4 animations:^{
        self.kuangImgView.frame =CGRectMake(95, 82, 104, 30);
        self.selectImg.transform = CGAffineTransformMakeRotation(M_PI);
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
    
}

- (void)shipMoseSelect:(id)sender
{
    ShipMode mode;
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1001) {
        mode = ShipModeSuningSend;
    }else
    {
        mode = ShipModeSelfTake;
    }
    if (self.shipMode == mode) {
        [self hide];
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(shipModeSelectAction:)]) {
        [_delegate shipModeSelectAction:mode];
    }
    
    [self hide];
}
@end
