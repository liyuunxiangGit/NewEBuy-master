//
//  SNHttpClient.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "SNHttpClient.h"

@implementation SNHttpClient

- (void)dealloc
{
    dispatch_release(_parseQueue);
}

+ (void)loadForServerType:(SNHttpServer)serverType
{
    SNHttpBaseUrlInits(serverType);
}

+ (void)setLogIsON:(BOOL)isOn
{
    SNHttpClientLogSwith(isOn);
}

+ (SNHttpClient *)sharedClient
{
    static SNHttpClient *manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[SNHttpClient alloc] init];
        [manage registerHTTPOperationClass:[AFJSONRequestOperation class]];
        manage.allowsInvalidSSLCertificate = YES;
        manage.defaultSSLPinningMode = AFSSLPinningModeCertificate;
        manage->_parseQueue = dispatch_queue_create("com.suning.SNHttpClient.parseDataQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return manage;
}

+ (NSOperation *)sendRequest:(NSString *)url requestMethod:(NSString *)requestMethod parameters:(NSDictionary *)parameters shouldParseInBackground:(BOOL)parseInBackground success:(void (^)(id))success failure:(void (^)(NSUInteger, NSError *))failure
{
    return [self sendRequest:url requestMethod:requestMethod parameters:parameters addedCookies:nil shouldParseInBackground:parseInBackground success:success failure:failure];
}

+ (NSOperation *)sendRequest:(NSString *)url requestMethod:(NSString *)requestMethod parameters:(NSDictionary *)parameters addedCookies:(NSArray *)cookies shouldParseInBackground:(BOOL)parseInBackground success:(void (^)(id))success failure:(void (^)(NSUInteger, NSError *))failure
{
    DDLogVerbose(@"\n{%@ REQUEST BEGIN}: %@", requestMethod, [url urlByAppendingDictNoEncode:parameters]);
    
    NSMutableURLRequest *request = [[self sharedClient] requestWithMethod:requestMethod path:url parameters:parameters];
    
    if ([cookies count])
    {
        NSArray *originCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[request URL]];
        NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
        NSMutableArray *cookieHeaderCompoents = [NSMutableArray array];
        
        for (NSHTTPCookie *cook in originCookies)
        {
            [cookieDic setObject:cook forKey:[cook name]];
            [cookieHeaderCompoents addObject:[NSString stringWithFormat: @"%@=%@",[cook name],[cook value]]];
        }
        
        for (NSHTTPCookie *cook in cookies)
        {
            if (![cookieDic objectForKey:[cook name]])
            {
                [cookieHeaderCompoents addObject:[NSString stringWithFormat: @"%@=%@",[cook name],[cook value]]];
                [cookieDic setObject:cook forKey:[cook name]];
            }
        }
        
        NSString *cookieHeader = [cookieHeaderCompoents componentsJoinedByString:@"; "];
        [request setValue:cookieHeader forHTTPHeaderField:@"Cookie"];
    }

	AFHTTPRequestOperation *operation = [[self sharedClient] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //未被JSON解析，需要手动解析
        if ([responseObject isKindOfClass:[NSData class]])
        {
            NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            if (jsonData) {
                responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
            }
        }
        
        if ([NSJSONSerialization isValidJSONObject:responseObject])
        {
            if (0)
            {
                DDLogVerbose(@"\n{%@ REQUEST SUCCESS}: %@\n{REQUEST_HEADERS}: %@\n{RESPOSE_HEADERS}: %@\n{RESPONSE}: %@", requestMethod, [url urlByAppendingDictNoEncode:parameters], [[operation request] allHTTPHeaderFields], [[operation response] allHeaderFields], [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding]);
            }
            else
            {
                DDLogVerbose(@"\n{%@ REQUEST SUCCESS}: %@\n{RESPONSE}: %@", requestMethod, [url urlByAppendingDictNoEncode:parameters], [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding]);
            }
            success(responseObject);
        }
        else //JSON Error
        {
            DDLogVerbose(@"\n{%@ REQUEST FAILED}: %@\n{STATUS_CODE}: %ld\n{JSON_ERROR}: %@", requestMethod, [url urlByAppendingDictNoEncode:parameters], (long)operation.response.statusCode, operation.responseString);
            
            failure(operation.response.statusCode, kSNHttpInvalidJSONError);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSError *tError = nil;
        if ([[error domain] isEqualToString:NSCocoaErrorDomain] && [error code] == 3840)
        {
            //JSON Error
            tError = kSNHttpInvalidJSONError;
        }
        else if ([error code] == NSURLErrorCannotFindHost ||
                 [error code] == NSURLErrorCannotConnectToHost ||
                 [error code] == NSURLErrorNotConnectedToInternet)
        {
            tError = kSNNetworkUnreachableError;
        }
        else
        {
            tError = kSNServerBusyError;
        }
        
        DDLogVerbose(@"\n{%@ REQUEST FAILED}: %@\n{STATUS_CODE}: %ld\n{ERROR}: %@", requestMethod, [url urlByAppendingDictNoEncode:parameters], (long)operation.response.statusCode, error);
        
        failure(operation.response.statusCode, tError);
    }];
    
    operation.successCallbackQueue = [self sharedClient]->_parseQueue;
    [[self sharedClient] enqueueHTTPRequestOperation:operation];
    
    return operation;
}

@end
