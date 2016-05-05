//
//  AuthorizeDelegate.m
//  TCWeiBoSDKDemo
//
//  Created by Yi Minwen on 9/14/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import "AuthorizeDelegate.h"

@implementation AuthorizeDelegate
@synthesize returnCode, err;

-(id)initWithRunLoop:(CFRunLoopRef)runLoop {
	if (self = [super init]) {
		currentLoop = runLoop;
	}
	return self;
}

#pragma mark protocol TCWBAuthorizeViewControllerDelegate <NSObject>
//授权成功回调
- (void)authorize:(TCWBAuthorizeViewController *)authorize didSucceedWithAccessToken:(NSString *)code {
    self.returnCode = code;
    CFRunLoopStop(currentLoop);
}

//授权失败回调
- (void)authorize:(TCWBAuthorizeViewController *)authorize didFailuredWithError:(NSError *)error {
    self.err = error;
    CFRunLoopStop(currentLoop);
}
@end
