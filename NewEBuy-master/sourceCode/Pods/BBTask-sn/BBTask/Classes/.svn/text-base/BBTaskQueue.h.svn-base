//
//  BBTaskQueue.h
//  BBTask
//
//  Created by liukun on 14-3-12.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBTask.h"

/**
 *  托管Task的类，保证Task能够完全执行
 */
@interface BBTaskQueue : NSObject

@property (readonly, strong) NSOperationQueue *taskOperationQueue;

+ (instancetype)sharedQueue;

- (void)addTask:(BBTask *)task;
- (void)removeTask:(BBTask *)task;
- (BBTask *)containTask:(Class)taskName;
- (BBTask *)containTask:(Class)taskName observer:(id)observer;
- (NSSet *)tasksForObserver:(id)observer;

@end
