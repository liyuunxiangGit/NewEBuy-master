//
//  CaculateTimer.m
//  SuningEBuy
//
//  Created by shasha on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CaculateTimer.h"

@implementation CaculateTimer

//@synthesize timer = timer_;

- (id)init
{
    self = [super init];
    
    if (self)
    {

    }
        
    return self;
        
}



- (void)timerBegin{
    
    [self timerEnd];
    
    pastTime_ = 0.0;
    
    timer_ =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshPastTime:) userInfo:nil repeats:YES];
    
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    
    [currentRunLoop addTimer:timer_ forMode: NSRunLoopCommonModes];
        
    
}

- (void)timerEnd{    

    if (timer_ &&[timer_ isValid]) {
        
        [timer_  invalidate];
        
        timer_ = nil;
    }
    
}

- (void)refreshPastTime:(NSTimer *)timer{

    pastTime_ = pastTime_ + 1;
    

    NSNumber *number =  [NSNumber numberWithLong:pastTime_];

    NSNotification* notification = [NSNotification notificationWithName:@"getPastTime"object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:number,@"pastTime",nil]];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
   
    

} 


@end
