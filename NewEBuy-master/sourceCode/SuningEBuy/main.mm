
//
//  main.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright Suning 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#ifdef __i386__
#import "DebugView.h"
#endif

int main(int argc, char *argv[])
{
    @autoreleasepool {
#ifdef __i386__
        return UIApplicationMain(argc, argv, @"DebugViewApp", NSStringFromClass([AppDelegate class]));
#else
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
#endif
    }
}