//
//  BBTask.m
//  BBTask
//
//  Created by liukun on 14-3-12.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "BBTask.h"
#import "BBTaskQueue.h"

static NSString * const kBBTaskLockName = @"com.bluebox.BBTask.lock";

static inline BOOL BBTaskStateTransitionIsValid(BBTaskState fromState, BBTaskState toState) {
    switch (fromState) {
        case BBTaskStateReady:
            switch (toState) {
                case BBTaskStateExecuting:
                case BBTaskStateSuccess:
                case BBTaskStateFailed:
                case BBTaskStateCanceled:
                    return YES;
                default:
                    return NO;
            }
        case BBTaskStateExecuting:
            switch (toState) {
                case BBTaskStateSuccess:
                case BBTaskStateFailed:
                case BBTaskStateCanceled:
                    return YES;
                default:
                    return NO;
            }
        default:
            return NO;
    }
}

#pragma mark - private api

@interface BBTask()
{
    NSThread    *_thread;
}
/** Lock */
@property (nonatomic, strong) NSRecursiveLock *lock;
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundTaskId;
#endif

@end

#pragma mark - imp

@implementation BBTask

- (void)dealloc
{
    if (_callBackQueue) {
#if !OS_OBJECT_USE_OBJC
        dispatch_release(_callBackQueue);
#endif
        _callBackQueue = NULL;
    }
    
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
    if (_backgroundTaskId) {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskId];
        _backgroundTaskId = UIBackgroundTaskInvalid;
    }
#endif
    
    if ([self isExecuting]) {
        [self cancel];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = [[NSRecursiveLock alloc] init];
        self.lock.name = kBBTaskLockName;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes delegate:(id<BBTaskDelegate>)delegate
{
    self = [self init];
    if (self) {
        
        self.attributes = attributes;
        self.delegate = delegate;
    }
    return self;
}

- (void)start
{
    [self.lock lock];
    
    BOOL isReady = [self isReady];
    if (isReady)
    {
        self.state = BBTaskStateExecuting;
        
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([self shouldContinueWhenAppEntersBackground]) {
            __weak __typeof__ (self) wself = self;
            self.backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
                __strong __typeof (wself) sself = wself;
                
                if (sself) {
                    [sself cancel];
                    
                    [[UIApplication sharedApplication] endBackgroundTask:sself.backgroundTaskId];
                    sself.backgroundTaskId = UIBackgroundTaskInvalid;
                }
            }];
        }
#endif
    }
    
    [self.lock unlock];
    
    if (isReady && ![self isCancelled])
    {
        [self executeOperation];
    }
}

- (void)runloopContinueRunsIfInBackground
{
    if ([self isExecuting] && ![NSThread isMainThread])
    {
        _thread = [NSThread currentThread];
        
        //开启runLoop接收事件源
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_5_1) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, false);
        } else {
            CFRunLoopRun();
        }
    }
}

- (void)startAsynchronous
{
    [[BBTaskQueue sharedQueue].taskOperationQueue addOperation:self];
}

- (void)stopRunLoop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)markAsFinished
{
    [self.lock lock];
    
    if ([self isFinished] || [self isCancelled])
    {
        //do nothing
    }
    else
    {
        if (_thread) {
            [self performSelector:@selector(stopRunLoop) onThread:_thread withObject:nil waitUntilDone:NO];
        }
        self.state = BBTaskStateSuccess;
        
        dispatch_async(self.callBackQueue ?: dispatch_get_main_queue(), ^{
            
            if ([_delegate respondsToSelector:@selector(taskDidComplete:)])
            {
                [_delegate taskDidComplete:self];
            }
            
            if (_didCompleteBlock) {
                _didCompleteBlock(self);
            }
        });
    }
    
    [self.lock unlock];
}

- (void)failWithError:(NSError *)error
{
    [self.lock lock];
    if ([self isFinished] || [self isCancelled])
    {
        //do nothing
    }
    else
    {
        if (_thread) {
            [self performSelector:@selector(stopRunLoop) onThread:_thread withObject:nil waitUntilDone:NO];
        }
        self.error = error;
        self.state = BBTaskStateFailed;
        
        dispatch_async(self.callBackQueue ?: dispatch_get_main_queue(), ^{
            
            if ([_delegate respondsToSelector:@selector(taskDidComplete:)])
            {
                [_delegate taskDidComplete:self];
            }
            if (_didCompleteBlock) {
                _didCompleteBlock(self);
            }
        });
    }
    
    [self.lock unlock];
}

- (void)cancelTask
{
    //TO DO
}

- (void)executeOperation
{
    //TODO
}

- (void)cancel
{
    [self cancelTask];
    [self.lock lock];
    if ([self isCancelled] || [self isFinished])
    {
		//do nothing
	}
    else
    {
        if (_thread) {
            [self performSelector:@selector(stopRunLoop) onThread:_thread withObject:nil waitUntilDone:NO];
        }
        self.state = BBTaskStateCanceled;
        
        dispatch_async(self.callBackQueue ?: dispatch_get_main_queue(), ^{
            
            if ([_delegate respondsToSelector:@selector(taskDidCancel:)])
            {
                [_delegate taskDidCancel:self];
            }
            if (_didCancelBlock) {
                _didCancelBlock(self);
            }
        });
    }
    [self.lock unlock];
}

#pragma mark concurrency

- (void)setState:(BBTaskState)state
{
    if (!BBTaskStateTransitionIsValid(self.state, state))
    {
        return;
    }
    
    [self.lock lock];
    if (state == BBTaskStateCanceled)
    {
        [self willChangeValueForKey:@"isExecuting"];
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isCancelled"];
        _state = state;
        [[BBTaskQueue sharedQueue] removeTask:self];
        [super cancel];
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        [self didChangeValueForKey:@"isCancelled"];
    }
    else if (state == BBTaskStateExecuting)
    {
        [self willChangeValueForKey:@"isExecuting"];
        _state = state;
        //如果没有在queue中，就加入queue中，为了保证task在执行完成之前不会被销毁
        [[BBTaskQueue sharedQueue] addTask:self];
        [self didChangeValueForKey:@"isExecuting"];
    }
    else if (state == BBTaskStateSuccess || state == BBTaskStateFailed)
    {
        [self willChangeValueForKey:@"isExecuting"];
        [self willChangeValueForKey:@"isFinished"];
        _state = state;
        [[BBTaskQueue sharedQueue] removeTask:self];
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
    }
    else
    {
        _state = state;
    }
    [self.lock unlock];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isReady
{
    return self.state == BBTaskStateReady && [super isReady];
}

- (BOOL)isFinished
{
	return self.state == BBTaskStateSuccess || self.state == BBTaskStateFailed || self.state == BBTaskStateCanceled;
}

- (BOOL)isCancelled
{
    return self.state == BBTaskStateCanceled;
}

- (BOOL)isExecuting
{
	return self.state == BBTaskStateExecuting;
}

- (BOOL)isSuccessed
{
    return self.state == BBTaskStateSuccess;
}

- (BOOL)isExecutingOrSuccessed
{
    return ([self isExecuting] || [self isSuccessed]);
}

#pragma mark - callBackQueue

- (void)setCallBackQueue:(dispatch_queue_t)callBackQueue
{
    if (callBackQueue != _callBackQueue) {
        if (_callBackQueue) {
#if !OS_OBJECT_USE_OBJC
            dispatch_release(_callBackQueue);
#endif
            _callBackQueue = NULL;
        }
        
        if (callBackQueue) {
#if !OS_OBJECT_USE_OBJC
            dispatch_retain(callBackQueue);
#endif
            _callBackQueue = callBackQueue;
        }
    }
}

#pragma mark - class method

+ (void)safeReleaseTasksOfObserver:(id)observer
{
    NSSet *tasks = [[BBTaskQueue sharedQueue] tasksForObserver:observer];
    
    [tasks enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        BBTask *task = (BBTask *)obj;
        task.delegate = nil;
        [task cancel];
    }];
}

+ (void)asyncRunOperations:(NSArray *)operationArr
{
    NSOperationQueue *operationQueue = [BBTaskQueue sharedQueue].taskOperationQueue;
    [operationQueue setSuspended:YES];
    for (NSOperation *operation in operationArr)
    {
        NSParameterAssert([operation isKindOfClass:[NSOperation class]]);
        [operationQueue addOperation:operation];
    }
    [operationQueue setSuspended:NO];
}

@end
