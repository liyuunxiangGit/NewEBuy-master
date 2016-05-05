//
//  LotteryMotionControl.m
//  SuningEBuy
//
//  Created by liukun on 14-6-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "LotteryMotionControl.h"
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>

//摇一摇精度
#define SHAKE_LIMIT 1.5         //响应最小加速度
#define COLLECT_FREQUENCY  15   //采集频率
#define TIME_INTERVAL 0.8      //响应最小间隔

@interface LotteryMotionControl()
{
    NSTimeInterval  _lastTimeStamp;
}

/** manage */
@property (nonatomic, strong) CMMotionManager *motionManager;

@end


@implementation LotteryMotionControl

- (void)setEventHandler:(void (^)(void))handler
{
    _eventHandler = [handler copy];
}

- (void)dealloc
{
    _eventHandler = nil;
    [self.motionManager stopAccelerometerUpdates];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _motionManager = [[CMMotionManager alloc] init];
        [_motionManager setAccelerometerUpdateInterval:1.0 / COLLECT_FREQUENCY];
    }
    return self;
}

- (void)start
{
    @weakify(self);
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        
        @strongify(self);
        CMAcceleration acceleration = accelerometerData.acceleration;
        
        if (acceleration.x > SHAKE_LIMIT || acceleration.x < -SHAKE_LIMIT
            || acceleration.y > SHAKE_LIMIT || acceleration.y < -SHAKE_LIMIT
            || acceleration.z > SHAKE_LIMIT || acceleration.z < -SHAKE_LIMIT)
        {
            NSTimeInterval nowTimeStamp = [NSDate timeIntervalSinceReferenceDate];
            if (nowTimeStamp - self->_lastTimeStamp > TIME_INTERVAL)
            {
                self->_lastTimeStamp = nowTimeStamp;
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                if (self->_eventHandler) {
                    self->_eventHandler();
                }
            }
        }
    }];
}

- (void)stop
{
    [self.motionManager stopAccelerometerUpdates];
}

@end
