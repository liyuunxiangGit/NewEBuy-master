//
//  NBSAppAgent.h
//  newWap
//
//  Created by yang kai on 13-7-26.
//  Copyright (c) 2013年 yang kai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>
#import <UIKit/UIApplication.h>






@interface NBSAppAgent : NSObject<NSURLConnectionDataDelegate>
{
    //NSString* appid;
    //id<UIApplicationDelegate>delegate_app_orig;
    
    //
    BOOL isNeedLocationService;
    double hitRate;
}
+(void)startWithAppID:(NSString*)appId;
+(void)startWithAppID:(NSString*)appId rateOfLaunch:(double) rate;
+(void)startWithAppID:(NSString*)appId location:(BOOL)locationAllowed;
+(void)startWithAppID:(NSString*)appId location:(BOOL)locationAllowed rateOfLaunch:(double) rate;
+(void) setCrashCollectFlg:(BOOL) isCollectCrashInfo;

@end
