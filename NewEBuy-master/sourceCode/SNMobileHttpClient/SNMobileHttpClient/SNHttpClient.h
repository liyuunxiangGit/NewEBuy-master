//
//  SNHttpClient.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "SNHttpConfig.h"
#import "BBTask.h"

/** errors */
#define kSNNetworkUnreachableError      BBTaskError(1124, @"当前网络不佳，请稍后再试试")
#define kSNHttpInvalidJSONError         BBTaskError(1125, @"好像出错啦，稍后再试吧")
#define kSNServerBusyError              BBTaskError(1126, @"服务器在偷懒，请稍后再试试")
#define kSNDataTaskParamError           BBTaskError(1126, @"参数错误")

@interface SNHttpClient : AFHTTPClient
{
    dispatch_queue_t _parseQueue;
}

+ (void)loadForServerType:(SNHttpServer)serverType;
+ (void)setLogIsON:(BOOL)isOn;

+ (NSOperation *)sendRequest:(NSString *)url
               requestMethod:(NSString *)requestMethod
                  parameters:(NSDictionary *)parameters
     shouldParseInBackground:(BOOL)parseInBackground
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSUInteger statusCode, NSError *error))failure;

+ (NSOperation *)sendRequest:(NSString *)url
               requestMethod:(NSString *)requestMethod
                  parameters:(NSDictionary *)parameters
                addedCookies:(NSArray *)cookies
     shouldParseInBackground:(BOOL)parseInBackground
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSUInteger statusCode, NSError *error))failure;


@end
