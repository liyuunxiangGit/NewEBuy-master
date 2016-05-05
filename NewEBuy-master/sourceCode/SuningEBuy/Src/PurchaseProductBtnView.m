//
//  SecondKillBtnView.m
//  SuningEBuy
//
//  Created by cui zl on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PurchaseProductBtnView.h"
#import "SNGraphics.h"

@implementation PurchaseProductBtnView

@synthesize wantPurchaseBtn = _wantPurchaseBtn;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_wantPurchaseBtn);
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.wantPurchaseBtn.frame = CGRectMake(20, 10, 280, 40);
    
}



-(UIButton *)wantPurchaseBtn{
    
    if(_wantPurchaseBtn == nil){
        
        _wantPurchaseBtn = [[UIButton alloc]init];
        
        _wantPurchaseBtn.tag = 1;
        
        [_wantPurchaseBtn setBackgroundImage:[UIImage streImageNamed:@"join_YellowButton.png"] forState:UIControlStateNormal];
        
        [_wantPurchaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_wantPurchaseBtn setTitle:L(@"Add QuickBuy") forState:UIControlStateNormal];
        
        [_wantPurchaseBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_wantPurchaseBtn];
        
    }
    return _wantPurchaseBtn;
}

-(void)clickBtn:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if([_delegate respondsToSelector:@selector(joinPurchase:)]){
            
        [_delegate joinPurchase:btn.tag];
    }

}

-(void)updateBtnState:(NSInteger)index
{
    if(index == 2)
    {
        [self.wantPurchaseBtn setBackgroundImage:[UIImage imageNamed:@"GB_order_cancel.png"] forState:UIControlStateNormal];
        self.wantPurchaseBtn.enabled = NO;
        
    }else{
        [self.wantPurchaseBtn setBackgroundImage:[UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
        self.wantPurchaseBtn.enabled = YES;
    }

    
}


@end
