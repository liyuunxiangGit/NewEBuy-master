//
//  AuthorizeDelegate.h
//  TCWeiBoSDKDemo
//
//  Created by Yi Minwen on 9/14/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCWBAuthorizeViewController.h"

@interface AuthorizeDelegate : NSObject<TCWBAuthorizeViewControllerDelegate>
{
	CFRunLoopRef    currentLoop;
	NSString        *returnCode;            // 正常授权返回授权码
    NSError         *err;                   // 假如授权失败，错误描述信息
}
@property(nonatomic, copy)NSString          *returnCode;
@property(nonatomic, strong)NSError         *err; 

-(id)initWithRunLoop:(CFRunLoopRef)runLoop;
@end

