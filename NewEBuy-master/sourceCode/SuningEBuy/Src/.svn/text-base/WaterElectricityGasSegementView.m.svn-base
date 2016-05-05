//
//  WaterElectricityGasSegementView.m
//  SuningEBuy
//
//  Created by xie wei on 13-5-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "WaterElectricityGasSegementView.h"

#define kPayTypeFrame CGRectMake(10, 10, 40, 35)
#define kRadioBtnFrame CGRectMake(50, 5, 32, 35)
#define kRadioLblFrame CGRectMake(90, 5, 40, 35)

#define kTag 100

@interface WaterElectricityGasSegementView ()

@end

@implementation WaterElectricityGasSegementView

@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedRaidoBtnIndex = -1;
        
        self.backgroundColor = RGBCOLOR(247, 247, 247);
        
        [self drawContent];
    }
    return self;
}

- (void)drawContent
{
    UILabel *payType = [[UILabel alloc] initWithFrame:kPayTypeFrame];
    payType.backgroundColor = [UIColor clearColor];
    payType.text = L(@"Pay type");
    
    NSArray *titleArray = @[L(@"Water fee"),L(@"Electricity fee"),L(@"VPFuelCost")];
    
    [self addSubview:payType];
    TT_RELEASE_SAFELY(payType);
    
    for (int i=0; i<3; i++) {
        CGRect radioFrame = kRadioBtnFrame;
        radioFrame.origin.x = kRadioBtnFrame.origin.x+i*80;
        
        CGRect radioLblFrame = kRadioLblFrame;
        radioLblFrame.origin.x = kRadioLblFrame.origin.x+i*80;
        
        UIButton *radioBtn = [[UIButton alloc] initWithFrame:radioFrame];
        radioBtn.backgroundColor = [UIColor clearColor];
        radioBtn.tag = kTag + i;
        [radioBtn setBackgroundImage:[UIImage imageNamed:@"shop_cart_unchecked.png"] forState:UIControlStateNormal];
        [radioBtn addTarget:self action:@selector(radioBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *radioLbl = [[UILabel alloc] initWithFrame:radioLblFrame];
        radioLbl.text = [titleArray objectAtIndex:i];
        radioLbl.backgroundColor = [UIColor clearColor];
        
        [self addSubview:radioBtn];
        [self addSubview:radioLbl];
        
        TT_RELEASE_SAFELY(radioBtn);
        TT_RELEASE_SAFELY(radioLbl);
   }
}

- (void)radioBtnPressed:(id)sender
{
    UIButton *radioBtn = (UIButton *)sender;
    
    if (self.selectedRaidoBtnIndex != -1) {
        for (UIView *view in self.subviews) {
            if (view.tag == self.selectedRaidoBtnIndex) {
                UIButton *btn = (UIButton *)view;
                [btn setBackgroundImage:[UIImage imageNamed:@"shop_cart_unchecked.png"] forState:UIControlStateNormal];
            }
        }
    }
    
    self.selectedRaidoBtnIndex = radioBtn.tag;
    
    [radioBtn setBackgroundImage:[UIImage imageNamed:@"shop_cart_checked.png"] forState:UIControlStateNormal];
    
    [self.delegate radioBtnPressed:sender];
}

@end
