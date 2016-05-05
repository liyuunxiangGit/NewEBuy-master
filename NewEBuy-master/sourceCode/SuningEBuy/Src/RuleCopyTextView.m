//
//  RuleCopyTextView.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RuleCopyTextView.h"

@implementation RuleCopyTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    if (action == @selector(copy:)) {
        retValue = YES;
    }else if (action == @selector(select:)) {
        retValue = YES;
    }else{
        retValue = NO;
    }    
    return retValue;
}

/*
-(void)setText:(NSString *)text{
    if (_maxLines <= 0 || _maxLines == NSNotFound) {
        [super setText:text];
    }else{
        
    }
}
*/
@end
