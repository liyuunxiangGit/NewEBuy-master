//
//  BBTaskQueue.m
//  BBTask
//
//  Created by liukun on 14-3-12.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "BBTaskQueue.h"

@interface BBTaskQueue()

@property (strong) NSMutableSet  *taskSets;

@end

@implementation BBTaskQueue

+ (instancetype)sharedQueue
{
    static BBTaskQueue *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BBTaskQueue alloc] init];
    });
    return __instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskSets = [[NSMutableSet alloc] init];
        _taskOperationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)addTask:(BBTask *)task
{
    @synchronized(self)
    {
        NSParameterAssert([task isKindOfClass:[BBTask class]]);
        
        if (![self.taskSets containsObject:task])
        {
            [self.taskSets addObject:task];
        }
    }
}

- (void)removeTask:(BBTask *)task
{
    @synchronized(self)
    {
        NSParameterAssert([task isKindOfClass:[BBTask class]]);
        if ([self.taskSets containsObject:task])
        {
            [self.taskSets removeObject:task];
        }
    }
}

- (BBTask *)containTask:(Class)taskName
{
    @synchronized(self)
    {
        __block BBTask *task = nil;
        
        [self.taskSets enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            
            if ([obj isKindOfClass:taskName]) {
                task = obj;
                *stop = YES;
            }
        }];
        return task;
    }
}

- (BBTask *)containTask:(Class)taskName observer:(id)observer
{
    @synchronized(self)
    {
        __block BBTask *task = nil;
        [self.taskSets enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            
            if ([obj isKindOfClass:taskName] && [obj delegate] == observer) {
                task = obj;
                *stop = YES;
            }
        }];
        return task;
    }
}

- (NSSet *)tasksForObserver:(id)observer
{
    @synchronized(self)
    {
        NSMutableSet *taskSet = [[NSMutableSet alloc] init];
        
        [self.taskSets enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            
            if ([obj delegate] == observer) {
                [taskSet addObject:obj];
            }
        }];
        return [taskSet count] ? taskSet : nil;
    }
}

@end
