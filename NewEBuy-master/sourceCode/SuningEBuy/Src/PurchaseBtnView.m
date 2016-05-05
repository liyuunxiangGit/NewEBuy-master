//
//  PurchaseBtnView.m
//  SuningEBuy
//
//  Created by cui zl on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PurchaseBtnView.h"

@implementation PurchaseBtnView

@synthesize quickBuyBtn = _quickBuyBtn;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self addSubview:self.quickBuyBtn];
}

-(UIButton*)quickBuyBtn
{
    if(_quickBuyBtn == nil)
    {
        _quickBuyBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 8, 280, 44)];
        
        [_quickBuyBtn addTarget:self action:@selector(joinPurchase:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *image = [UIImage streImageNamed:@"join_YellowButton.png"];
        [_quickBuyBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        UIImage *disAbledImage = [UIImage streImageNamed:@"join_GrayButton.png"];
        [_quickBuyBtn setBackgroundImage:disAbledImage forState:UIControlStateDisabled];
        
        [_quickBuyBtn setTitle:L(@"Add QuickBuy") forState:UIControlStateNormal];
        [_quickBuyBtn setTitle:L(@"Add QuickBuy") forState:UIControlStateDisabled];
        
        [_quickBuyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    return _quickBuyBtn;
}

- (void)joinPurchase:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(joinPanicPurchase)]) {
        [_delegate joinPanicPurchase];
    }
}

@end
