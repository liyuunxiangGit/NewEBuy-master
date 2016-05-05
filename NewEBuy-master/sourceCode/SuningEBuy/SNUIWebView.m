//
//  SNUIWebView.m
//  SNFramework
//
//  Created by  liukun on 14-1-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "SNUIWebView.h"

@implementation SNUIWebView

- (void)fixViewPort
{
    //适应客户端页面
    NSString* js =
    @"var meta = document.createElement('meta'); "
    "meta.setAttribute( 'name', 'viewport' ); "
    "meta.setAttribute( 'content', 'width = device-width' ); "
    "document.getElementsByTagName('head')[0].appendChild(meta)";
    
    [self stringByEvaluatingJavaScriptFromString: js];
}

- (void)cleanBackground
{
    self.backgroundColor = [UIColor clearColor];
    for (UIView *view in [[[self subviews] safeObjectAtIndex:0] subviews])
    {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
}
@end
