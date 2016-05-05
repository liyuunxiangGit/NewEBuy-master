//
//  BBTask.h
//  BBTask
//
//  Created by liukun on 14-3-12.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBTask;
@class BBTaskQueue;

#undef BBTaskCancel
#define BBTaskCancel(_task) ({ if ([(_task) isExecuting]) { [(_task) cancel]; } })

/**
 *  BBTask 的状态枚举
 */
typedef NS_ENUM(signed short, BBTaskState) {
    /**
     *  准备完成的状态
     */
    BBTaskStateReady,
    /**
     *  task正在运行中
     */
    BBTaskStateExecuting,
    /**
     *  task执行成功
     */
    BBTaskStateSuccess,
    /**
     *  task执行失败
     */
    BBTaskStateFailed,
    /**
     *  task被取消了
     */
    BBTaskStateCanceled
};

#pragma mark - BBTaskDelegate

/**
 *  回调代理需要服从的的protocol
 */
@protocol BBTaskDelegate <NSObject>

/**
 *  执行完成的回调方法，状态变为success或failed都会执行该方法，在主线程中或callBackQueue中执行
 *
 *  @param task 任务对象本身
 */
- (void)taskDidComplete:(BBTask *)task;

@optional

/**
 *  任务被取消时的回调通知，在主线程中或callBackQueue中执行
 *
 *  @param task 任务对象本身
 */
- (void)taskDidCancel:(BBTask *)task;

@end

#pragma mark - BBTaskBlock

typedef void (^BBTaskBlock)(BBTask *_tsk);

#pragma mark - BBTask interface

/**
 *  BBTask类, 在executeOperation方法中实现任务即可，自动管理runLoop和operation的状态.
 */
@interface BBTask : NSOperation

/**
 *  初始化方法
 *
 *  @param attributes 存入attributes属性的对象
 *  @param delegate   存入delegate属性的对象
 *
 *  @return BBTask的实例
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes delegate:(id<BBTaskDelegate>)delegate;

/**
 *  可以保存一些参数
 */
@property (nonatomic, strong)   NSDictionary *attributes;

/**
 *  BBTaskDelegate中的方法执行的队列，当为nil时，使用main_queue执行回调函数
 */
@property (nonatomic, assign)   dispatch_queue_t callBackQueue;

@property (nonatomic, weak)   id<BBTaskDelegate> delegate;
@property (nonatomic, copy)     BBTaskBlock didCompleteBlock;
@property (nonatomic, copy)     BBTaskBlock didCancelBlock;

/**
 *  是否在应用进入后台后继续运行， 默认是NO
 */
@property (nonatomic, assign) BOOL shouldContinueWhenAppEntersBackground;

/**
 *  标识当前的状态
 */
@property (readonly) BBTaskState state;
@property (readonly) BOOL        isSuccessed;
@property (readonly) BOOL        isExecutingOrSuccessed;
@property (nonatomic, strong)    NSError    *error;

/**
 *  在当前线程中开始执行
 */
- (void)start;

/**
 *  在队列NSOperation中开始执行
 */
- (void)startAsynchronous;

/**
 *  子类实现调用，通知任务已经完成，并且成功
 */
- (void)markAsFinished;

/**
 *  子类调用， 通知任务完成，且失败
 *
 *  @param error 失败的错误信息
 */
- (void)failWithError:(NSError *)error;

/**
 *  子类实现，在任务被取消之前执行一些事情
 */
- (void)cancelTask;

/**
 *  子类实现，入口方法，任务的具体逻辑实现
 */
- (void)executeOperation;

#pragma mark - utils

/**
 *  当在executeOperation中启动了NSTimer，或者NSConnection等事件源，可在executeOperation方法最后
 *  调用该方法来启动runloop进行监听事件源。
 */
- (void)runloopContinueRunsIfInBackground;

#pragma mark - Class methods

/**
 *  取消observer监听的所有任务
 *
 *  @param observer 监听者，即代理
 */
+ (void)safeReleaseTasksOfObserver:(id)observer;

/**
 *  将多个任务同时加入队列中执行
 *
 *  @param operationArr 多个任务组成的数组
 */
+ (void)asyncRunOperations:(NSArray *)operationArr;

@end
