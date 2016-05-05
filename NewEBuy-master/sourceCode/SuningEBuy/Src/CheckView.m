//
//  CheckView.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CheckView.h"

@implementation CheckView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(UIButton *)checkBtn{
    
    
    if (!_checkBtn) {
        
        _checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                               self.frame.size.height-20,
                                                               self.frame.size.width,
                                                               20)];
        [_checkBtn addTarget:self
                      action:@selector(checkBtnAction)
            forControlEvents:UIControlEventTouchUpInside];
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateSelected];
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"gift_coupon_unchecked.png"] forState:UIControlStateNormal];
    }
    
    
    return _checkBtn;
}


-(void)checkBtnAction{
    
    self.checkBtn.selected = !self.checkBtn.isSelected;
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
