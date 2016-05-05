
//  Calculagraph.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Calculagraph.h"

/////////////////////////////////////////////////////////////////

@interface Calculagraph()
{
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	UIBackgroundTaskIdentifier backgroundTask;
#endif
}

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation Calculagraph

@synthesize time = time_;

@synthesize timer = timer_;

@synthesize timeOut = timeOut_;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.time = 0.0f;
        self.repeatInterval = 1.0f;
    }
    return self;
}

- (void)dealloc
{
    [self stop];
    
}

#if TARGET_OS_IPHONE
+ (BOOL)isMultitaskingSupported
{
	BOOL multiTaskingSupported = NO;
	if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
		multiTaskingSupported = [(id)[UIDevice currentDevice] isMultitaskingSupported];
	}
	return multiTaskingSupported;
}
#endif

- (void)start
{
    [self stop];
    
    self.time = 0.0;
    
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    if ([Calculagraph isMultitaskingSupported] )
    {
        if (!backgroundTask || backgroundTask == UIBackgroundTaskInvalid)
        {
            backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
                // Synchronize the cleanup call on the main thread in case
                // the task actually finishes at around the same time.
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (backgroundTask != UIBackgroundTaskInvalid)
                    {
                        [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                        backgroundTask = UIBackgroundTaskInvalid;
                        [self stop];
                    }
                });
            }];
        }
    }
#endif
    
    NSTimer *timer;
    
    NSDate *date = [NSDate date];
    
    timer = [[NSTimer alloc] initWithFireDate:date interval:self.repeatInterval target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
    
    _validate = YES;
    
}

- (void)refreshTime
{
    self.time += self.repeatInterval;
    
    if (timeOut_ > 0 && self.time >= timeOut_)
    {
        [self stop];
    }
}

- (void)stop
{
    if (self.timer && [self.timer isValid])
    {
        [self.timer invalidate];
        
        self.timer = nil;
        
        _validate = NO;
        
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([Calculagraph isMultitaskingSupported])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (backgroundTask != UIBackgroundTaskInvalid) {
                    [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                    backgroundTask = UIBackgroundTaskInvalid;
                }
            });
        }
#endif
    }
}

- (CGFloat)seconds
{
    return self.time;
}

- (BOOL)isValidate
{
    return _validate;
}

@end



