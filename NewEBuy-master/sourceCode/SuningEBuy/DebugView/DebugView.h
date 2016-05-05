//
//  DebugView.h
//
//  Created by Joe on 12-7-7.
//
//
//
// How to use:
//
// Before iOS6 or earlier ,keyboard is supported : "i" = in, "o"= out, "n" = next, "p" = pre ,"esc" = esc
// in iOS7 and later , shake the simluater to call them out.
//
// How to use in code:
// Replace all in main.m  (AppDelegate is the name of your application delegate)
//
// code
// #ifdef __i386__
// return UIApplicationMain(argc, argv, @"DebugViewApp", NSStringFromClass([AppDelegate class]));
// #else
// return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
// #endif
//
//

#import <UIKit/UIKit.h>
//make sure only work on simluator
#ifdef __i386__
@interface DebugViewApp : UIApplication
@end

@interface DebugView : UIView {
    UIView      *_topView;
    UIView      *_container;
    UIView      *_view;
	UILabel		*_label;
    
    struct {
        unsigned int help:1;
        unsigned int width:1;
        unsigned int cmdMode:1;
    } _switches;
    
    CGPoint     _offset;
	
	UniChar	_lastCode;
	int		_velocity;
	CGPoint _location;
	BOOL	_isMoved;
}

+ (DebugView*)sharedInstance;
- (BOOL)isStarted;
- (void)start:(UIView*)view;
- (void)stop;
- (void)inputChar:(UniChar)keyCode flag:(int)flag;
@end

#endif