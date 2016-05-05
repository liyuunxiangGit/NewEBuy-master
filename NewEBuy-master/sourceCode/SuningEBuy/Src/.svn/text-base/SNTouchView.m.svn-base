//
//  SNTouchView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNTouchView.h"

@implementation SNTouchView

@synthesize receiver;


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
 	if ([self pointInside:point withEvent:event]) {
   		return self.receiver;
        DLog(@"touched %@ receiver %@", self, [self receiver]);
	}
	return nil;
}


@end

