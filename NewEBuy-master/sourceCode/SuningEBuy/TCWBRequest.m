//
//  TCWBRequest.m
//  WiressWeiBoSDK
//
//  Created by wang ying on 12-8-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWBRequest.h"
#import "TCWBGlobalUtil.h"
#import "NSObject+WBUtil.h"

#define kWBRequestTimeOutInterval   180.0
#define kWBRequestStringBoundary    @"293iosfksdfkiowjksdf31jsiuwq003s02dsaffafass3qw"

@interface TCWBRequest (Private)

+ (NSString *)stringFromDictionary:(NSDictionary *)dict;
+ (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString;
- (NSMutableData *)postBody;

- (void)handleResponseData:(NSData *)data;
- (id)parseJSONData:(NSData *)data error:(NSError **)error;

- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo;
- (void)failedWithError:(NSError *)error;
@end


@implementation TCWBRequest

@synthesize url;
@synthesize httpMethod;
@synthesize params;
@synthesize postDataType;
@synthesize httpHeaderFields;
@synthesize delegate;
@synthesize complete;

#pragma mark - WBRequest Life Circle

- (void)dealloc{
    
	responseData = nil;
    
    [connection cancel];
    connection = nil;
    
}

#pragma mark - WBRequest Private Methods

//生成url链接
+ (NSString *)stringFromDictionary:(NSDictionary *)dict{
    NSMutableArray *pairs = [NSMutableArray array];
	for (NSString *key in [dict keyEnumerator]){
		if (!([[dict valueForKey:key] isKindOfClass:[NSString class]])){
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]]];
		}
        else{
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [[dict objectForKey:key] URLEncodedString]]];
        }
	}
	
	return [pairs componentsJoinedByString:@"&"];
}

+ (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString{
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

//设置POST请求包
- (NSMutableData *)postBody{
    NSMutableData *body = [NSMutableData data];
//普通上传    
    if (postDataType == kTCWBRequestPostDataTypeNormal){
        [TCWBRequest appendUTF8Body:body dataString:[TCWBRequest stringFromDictionary:params]];
    }
//带图片上传    
    else if (postDataType == kTCWBRequestPostDataTypeMultipart){
        NSString *bodyPrefixString = [NSString stringWithFormat:@"--%@\r\n", kWBRequestStringBoundary];
		NSString *bodySuffixString = [NSString stringWithFormat:@"\r\n--%@--\r\n", kWBRequestStringBoundary];
        
        NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
        
        [TCWBRequest appendUTF8Body:body dataString:bodyPrefixString];
        
        for (id key in [params keyEnumerator]) {
			if (([[params valueForKey:key] isKindOfClass:[UIImage class]]) || ([[params valueForKey:key] isKindOfClass:[NSData class]])){
				[dataDictionary setObject:[params valueForKey:key] forKey:key];
				continue;
			}
			
			[TCWBRequest appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key, [params valueForKey:key]]];
			[TCWBRequest appendUTF8Body:body dataString:bodyPrefixString];
		}
		
		if ([dataDictionary count] > 0) {
			for (id key in dataDictionary) {
				NSObject *dataParam = [dataDictionary valueForKey:key];
				
				if ([dataParam isKindOfClass:[UIImage class]]) {
					NSData* imageData = UIImagePNGRepresentation((UIImage *)dataParam);
					[TCWBRequest appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n", key,dataParam]];
					[TCWBRequest appendUTF8Body:body dataString:@"Content-Type:\"image/jpeg\"\r\n\r\n"];
					[body appendData:imageData];

				} 
				else if ([dataParam isKindOfClass:[NSData class]]) {
                    [TCWBRequest appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n", key,dataParam]];
                    [TCWBRequest appendUTF8Body:body dataString:@"Content-Type:\"image/jpeg\"\r\n\r\n"];
					[body appendData:(NSData*)dataParam];
				}
				[TCWBRequest appendUTF8Body:body dataString:bodySuffixString];
			}
		}
    }
    
    return body;
}

- (void)handleResponseData:(NSData *)data{
    if ([delegate respondsToSelector:@selector(request:didReceiveRawData:)]){
        [delegate request:self didReceiveRawData:data];
    }
	
	NSError* error = nil;
	id result = [self parseJSONData:data error:&error];
	
	if (error) {
		[self failedWithError:error];
	} 
	else {
        if ([delegate respondsToSelector:@selector(request:didFinishLoadingWithResult:)]){
            [delegate request:self didFinishLoadingWithResult:(result == nil ? data : result)];
		}
	}
}

//数据返回解析
- (id)parseJSONData:(NSData *)data error:(NSError **)error{
	
	NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!dataString) {
        dataString = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    }
    
	id result = [NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding]
                                                options:0
                                                  error:NULL];
	
	if (!result){
        if (error != nil){
            *error = [self errorWithCode:TCWBErrorCodeSDK
                                userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", TCWBSDKErrorCodeParseError]
                                                                     forKey:TCWBSDKErrorCodeKey]];
        }
	}
        
	
    
	if ([result isKindOfClass:[NSDictionary class]]){
		if ([[result objectForKey:@"errorcode"] intValue] != 0){
			if (error != nil) {
				*error = [self errorWithCode:TCWBErrorCodeInterface userInfo:result];
			}
		}
	}
	
	return result;
}

//生成错误信息
- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo{
    return [NSError errorWithDomain:TCWBSDKErrorDomain code:code userInfo:userInfo];
}

//错误回调
- (void)failedWithError:(NSError *)error {
	if ([delegate respondsToSelector:@selector(request:didFailWithError:)]) {
		[delegate request:self didFailWithError:error];
	}

}


#pragma mark - WBRequest Public Methods

//根据请求url，相应方式和参数生成request对象
+ (TCWBRequest *)requestWithURL:(NSString *)url 
                   httpMethod:(NSString *)httpMethod 
                       params:(NSDictionary *)params
                 postDataType:(TCWBRequestPostDataType)postDataType
             httpHeaderFields:(NSDictionary *)httpHeaderFields
                     delegate:(id<TCWBRequestDelegate>)delegate{
    TCWBRequest *request = [[TCWBRequest alloc] init];
    
    request.url = url;
    request.httpMethod = httpMethod;
    request.params = params;
    request.postDataType = postDataType;
    request.httpHeaderFields = httpHeaderFields;
    request.delegate = delegate;
    
    return request;
}

+ (TCWBRequest *)requestWithURL:(NSString *)url {
    TCWBRequest *request = [[TCWBRequest alloc] init];
    request.url = url;
    
    return request;
}

+ (TCWBRequest *)requestWithURL:(NSString *)url
                    AccessToken:(NSString *)accessToken 
                         appkey:(NSString *)appkey 
                         openId:(NSString *)openId 
                       clientip:(NSString *)clientip 
                  oauth_version:(NSString *)oauth_version 
                          scope:(NSString *)scope
                   postDataType:(TCWBRequestPostDataType)postDataType
                     httpMethod:(NSString *)httpMethod 
                         params:(NSDictionary *)params
               httpHeaderFields:(NSDictionary *)httpHeaderFields
                       delegate:(id<TCWBRequestDelegate>)requestDelegate{   	    
    NSMutableDictionary *mutableParams = [[NSMutableDictionary alloc]initWithCapacity:6];
    [mutableParams setObject:accessToken forKey:ACCESS_TOKEN];
    [mutableParams setObject:appkey forKey:OAUTH_CONSUMER_KEY];
    [mutableParams setObject:openId forKey:OPENID];
    [mutableParams setObject:clientip forKey:CLIENTIP];
    [mutableParams setObject:oauth_version forKey:OAUTH_VERSION];
    [mutableParams setObject:scope forKey:SCOPE];
    NSString *commentUrl = [TCWBRequest stringFromDictionary:mutableParams];
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",url,commentUrl];

    return [TCWBRequest requestWithURL:baseUrl
                          httpMethod:httpMethod
                              params:params
                          postDataType:postDataType
                    httpHeaderFields:httpHeaderFields
                            delegate:requestDelegate];
}

//生成url请求链接
+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod{
    if (![httpMethod isEqualToString:@"GET"]){
        return baseURL;
    }
    NSURL *parsedURL = [NSURL URLWithString:baseURL];
	NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
	NSString *query = [TCWBRequest stringFromDictionary:params];
	
	return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

- (void)connect{
    NSString *urlString = [TCWBRequest serializeURL:url params:params httpMethod:httpMethod];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
														   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
													   timeoutInterval:kWBRequestTimeOutInterval];
    
    [request setHTTPMethod:httpMethod];
    
    if ([httpMethod isEqualToString:@"POST"]){
        if (postDataType == kTCWBRequestPostDataTypeMultipart){
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kWBRequestStringBoundary];
            [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        }
        
        [request setHTTPBody:[self postBody]];
    }
    
    for (NSString *key in [httpHeaderFields keyEnumerator]){
        [request setValue:[httpHeaderFields objectForKey:key] forHTTPHeaderField:key];
    }    

    // 打印字符串
    DLog(@"URL String:%@", urlString);
    // 仅供测试用
    [[NSNotificationCenter defaultCenter] postNotificationName:@"URLPost" object:urlString];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (NSData *)connect:(NSString *)urlString{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
												   timeoutInterval:kWBRequestTimeOutInterval];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request 
                                               returningResponse:nil error:nil]; 
    return returnData;
}

- (void)disconnect{
	responseData = nil;
    
    [connection cancel];
    connection = nil;
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	responseData = [[NSMutableData alloc] init];
	
	if ([delegate respondsToSelector:@selector(request:didReceiveResponse:)]){
		[delegate request:self didReceiveResponse:response];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    self.complete = NO;
	[responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
    self.complete = YES;
	[self handleResponseData:responseData];
    
	responseData = nil;
    
    [connection cancel];
	connection = nil;
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error{
    self.complete = YES;
	[self failedWithError:error];
	
	responseData = nil;
    
    [connection cancel];
	connection = nil;
}

@end
