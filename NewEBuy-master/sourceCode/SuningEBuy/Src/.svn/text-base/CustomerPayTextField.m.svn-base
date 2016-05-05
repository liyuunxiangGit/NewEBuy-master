//
//  CustomerPayTextField.m
//  SuningEBuy
//
//  Created by admin on 12-11-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CustomerPayTextField.h"

@implementation CustomerPayTextField
- (BOOL) canPerformAction:(SEL)action withSender:(id)sender
{
	if (action == @selector(paste:)||
        action == @selector(select:)||
		action == @selector(copy:))
        
	{
		return YES;
	}
    return NO;
}

- (void)paste:(id)sender
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    NSString *str  = board.string;
    if(str != nil)
    {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];        
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\u00A0" withString:@""];       
        str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];        
        DLog(@"str2:%@",str);
    }
    self.text  = str;
}

@end
