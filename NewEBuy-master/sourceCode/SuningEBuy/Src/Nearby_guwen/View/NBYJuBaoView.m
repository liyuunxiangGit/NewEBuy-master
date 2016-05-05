//
//  NBYJuBaoView.m
//  SuningEBuy
//
//  Created by XZoscar on 14-10-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYJuBaoView.h"

@implementation NBYJuBaoView

+ (NBYJuBaoView *)view {
    return ([[NSBundle mainBundle] loadNibNamed:@"NBYJuBaoView"
                                          owner:nil options:nil][0]);
}

- (IBAction)on_juBaoButton_clicked:(id)sender {
    if (nil != _jubaoBlock) {
        _jubaoBlock();
    }
    
    [self removeFromSuperview];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *t = touches.anyObject;
    if (t.view == self) {
        [self removeFromSuperview];
    }
}

- (IBAction)on_closeButton_clicked:(id)sender {
    [self removeFromSuperview];
}

@end
