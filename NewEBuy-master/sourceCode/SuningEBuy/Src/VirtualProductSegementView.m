//
//  VirtualProductSegementView.m
//  SuningEBuy
//
//  Created by xie wei on 13-5-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "VirtualProductSegementView.h"

#define kMobileRechargeFrame CGRectMake(0, 0, 160, 35)
#define kWaterElectricityGasFrame CGRectMake(160, 0, 160, 35)

@interface VirtualProductSegementView ()

@property(nonatomic,strong) UIButton *mobileRecharge;
@property(nonatomic,strong) UIButton *waterElectricityGas;

@end

@implementation VirtualProductSegementView

@synthesize mobileRecharge = _mobileRecharge;
@synthesize waterElectricityGas = _waterElectricityGas;

@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_mobileRecharge);
    TT_RELEASE_SAFELY(_waterElectricityGas);
    
}

- (UIButton *)mobileRecharge
{
    if (!_mobileRecharge) {
        _mobileRecharge = [[UIButton alloc] initWithFrame:kMobileRechargeFrame];
        _mobileRecharge.backgroundColor = [UIColor redColor];
        [_mobileRecharge setTitle:L(@"Mobile Pay") forState:UIControlStateNormal];
        [_mobileRecharge addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        _mobileRecharge.tag = sortMobileRecharge;
    }
    return _mobileRecharge;
}

- (UIButton *)waterElectricityGas
{
    if (!_waterElectricityGas) {
        _waterElectricityGas = [[UIButton alloc] initWithFrame:kWaterElectricityGasFrame];
        _waterElectricityGas.backgroundColor = [UIColor blueColor];
        [_waterElectricityGas setTitle:L(@"WaterElectricGas Payment") forState:UIControlStateNormal];
        [_waterElectricityGas addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        _waterElectricityGas.tag = sortWaterElectricityGas;
    }
    return _waterElectricityGas;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mobileRecharge];
        [self addSubview:self.waterElectricityGas];
    }
    return self;
}

- (void)btnPress:(id)sender
{
    UIButton *sortBtn = (UIButton *)sender;
    
    if (sortBtn.tag == sortMobileRecharge) {
        [self.mobileRecharge setBackgroundColor:[UIColor redColor]];
        [self.waterElectricityGas setBackgroundColor:[UIColor blueColor]];
        
        [self.delegate sortBtnPressed:sortMobileRecharge];
    }
    else
    {
        [self.mobileRecharge setBackgroundColor:[UIColor blueColor]];
        [self.waterElectricityGas setBackgroundColor:[UIColor redColor]];
        
        [self.delegate sortBtnPressed:sortWaterElectricityGas];
    }
}

@end
