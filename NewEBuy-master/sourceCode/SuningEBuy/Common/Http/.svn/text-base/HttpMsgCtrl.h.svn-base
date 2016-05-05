//
//  HttpMsgCtrl.h
//  SuningLottery
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//
/*!
 @header      HttpMsgCtrl
 @abstract    网络连接池
 @author      王瑞初期， 刘坤修改
 @version     v1.0.005  12-9-6
 @discussion
 1、 12-8-24  发送请求前在cookie里面添加cityId字段。
 2、 12-8-28  请求到头时判断登录session是否失效，失效就标记为未登录, 并发送全局通知
 3、 12-9-4   调整超时时间 需要除去1.5
 4、 12-9-6   添加了get方法请求， 添加了重写cookie的操作
 */

#import "HttpMessage.h"
#import <Foundation/Foundation.h>
#import "Command.h"
#import "CommandManage.h"
@class ASINetworkQueue;

@protocol  HttpMsgCtrlDelegate <NSObject>
//- (void)requestDidStart:(ASIHTTPRequest *)request;
//- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)requestDidFinished:(NSString *)logString;
- (void)requestDidFailed:(NSString *)logString;
@end

@interface HttpMsgCtrl : NSObject <CommandDelegate>
{
@private
	NSLock              *_lock;
	ASINetworkQueue     *_networkQueue;
    
}

@property (nonatomic, unsafe_unretained) id<HttpMsgCtrlDelegate> delegate;
@property (nonatomic, retain) NSLock *lock;
@property (nonatomic, retain) ASINetworkQueue *networkQueue;

// 获取实例方法
+ (HttpMsgCtrl*)shareInstance;

/*!
 @abstract      发送一个请求
 @discussion    封装好了请求的参数信息的sendMsg，传递给该方法即可异步发送请求
 @param         sendMsg  封装好了请求的参数信息、和标识的对象
 */
- (void)sendHttpMsg:(HttpMessage *)sendMsg;


/*!
 @abstract      取消一个请求
 @discussion    封装好了请求的参数信息的sendMsg，传递给该方法即可异步发送请求
 @param         msg  封装好了请求的参数信息、和标识的对象
 */
- (void)cancelHttpRequest:(HttpMessage *)msg;


- (BOOL)isRunningHttpMessage:(HttpMessage *)msg dependOperations:(NSArray **)operations;

@end
