//
//  LotteryMotionControl.h
//  SuningEBuy
//
//  Created by liukun on 14-6-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryMotionControl : NSObject
{
    void (^_eventHandler) (void);
}

- (void)setEventHandler:(void(^)(void))handler;
- (void)start;
- (void)stop;

@end
