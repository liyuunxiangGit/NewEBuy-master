//
//  TCWBEngine.m
//  TCWeiBoSDK
//  Based on OAuth 2.0
//
//  Created by wang ying on 12-8-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWBEngine.h"
#import "TCWBRebroadcastMsgViewController.h"
#import "TCWBSFHFKeychainUtils.h"
#import "TCWBGlobalUtil.h"
#import "IPAddress.h"
#import "FileStreame.h"
#import "AuthorizeDelegate.h"
#import "TCWBRepeatViewController.h"

#define BUFFERSIZE    4000  
#define MAXADDRS    32  

#define TCURLSchemePrefix              @"TC_"

#define TCKeychainServiceNameSuffix    @"_WeiBoServiceName"
#define TCKeychainAccessToken          @"WeiBoAccessToken"
#define TCKeychainExpireTime           @"WeiBoExpireTime"
#define TCKeychainOpenId               @"WeiBoOpenId"
#define TCKeychainOpenKey              @"WeiBoOpenKey"
#define TCKeychainRefreshToken         @"WeiBoRefreshToken"
#define TCKeychainName                 @"WeiBoName"

@implementation DelegateObject

@synthesize delegate;

@end

static BOOL G_LOGOUT = NO;

@interface TCWBEngine (Private)

- (NSString *)urlSchemeString;

//存储到keychain
- (BOOL)saveAuthorizeDataToKeychain;
//keychain中读出
- (void)readAuthorizeDataFromKeychain;
//从keychain中删除
- (BOOL)deleteAuthorizeDataInKeychain;

- (void) managerRequestWithRequest:(TCWBRequest *)request
                          delegate:(id)delegate
                           success:(SEL)successCallback
                        andFailure:(SEL)failureCallback;
@end

@implementation TCWBEngine

@synthesize appKey;
@synthesize appSecret;
@synthesize accessToken;
@synthesize name;
@synthesize openId;
@synthesize openKey;
@synthesize refreshToken;
@synthesize expireTime;
@synthesize redirectURI;
@synthesize ip_iphone;
@synthesize publishContent;
@synthesize publishImage;
@synthesize isRefreshTokenSuccess;
@synthesize rootViewController;

#pragma mark - TCWBEngine Life Circle

- (id)initWithAppKey:(NSString *)theAppKey andSecret:(NSString *)theAppSecret andRedirectUrl:(NSString *)theRedirectUrl{
   
    if (self = [super init]){
        self.appKey = theAppKey;
        self.appSecret = theAppSecret;
        self.redirectURI = theRedirectUrl;
        
        httpRequests = [[NSMutableArray alloc] initWithCapacity:2];
        [self readAuthorizeDataFromKeychain];
        self.rootViewController = nil;
        self.isRefreshTokenSuccess = YES;
    }
    return self;
}

- (void)dealloc{
    
    [self cancelAllRequest];
}
 

#pragma mark - TCWBEngine Private Methods

- (void)cancelAllRequest {
	for (int i = 0; i < [httpRequests count]; i++) {
		NSDictionary *dicItem = [httpRequests objectAtIndex:i];
		TCWBRequest *requestItem = (TCWBRequest *)[dicItem objectForKey:@"Request"];
		if (!(requestItem.complete)) {
			[requestItem disconnect];
		}
	}
}

// 取消某个Delegate下所有请求
- (void)cancelSpecifiedDelegateAllRequest:(id)requestDelegate {
    for (int i = 0; i < [httpRequests count]; i++) {
		NSDictionary *dicItem = [httpRequests objectAtIndex:i];
        id del = ((DelegateObject *)[dicItem objectForKey:@"Delegate"]).delegate;
        if (requestDelegate == del) {
            TCWBRequest *requestItem = (TCWBRequest *)[dicItem objectForKey:@"Request"];
            if (!(requestItem.complete)) {
                [requestItem disconnect];
            }
        }
    } 
}

- (NSString *)urlSchemeString{
    return [NSString stringWithFormat:@"%@%@", TCURLSchemePrefix, appKey];
}

- (BOOL)saveAuthorizeDataToKeychain{
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:TCKeychainServiceNameSuffix];
	BOOL accessTokenSaveOK = [TCWBSFHFKeychainUtils storeUsername:TCKeychainAccessToken andPassword:accessToken forServiceName:serviceName updateExisting:YES error:nil];
    BOOL openIdSaveOK = [TCWBSFHFKeychainUtils storeUsername:TCKeychainOpenId andPassword:openId forServiceName:serviceName updateExisting:YES error:nil];
    BOOL openKeySaveOK = [TCWBSFHFKeychainUtils storeUsername:TCKeychainOpenKey andPassword:openKey forServiceName:serviceName updateExisting:YES error:nil];
	BOOL expireTimeSaveOK = [TCWBSFHFKeychainUtils storeUsername:TCKeychainExpireTime andPassword:[NSString stringWithFormat:@"%lf", expireTime] forServiceName:serviceName updateExisting:YES error:nil];
    BOOL refreshTokenSaveOK = [TCWBSFHFKeychainUtils storeUsername:TCKeychainRefreshToken andPassword:refreshToken forServiceName:serviceName updateExisting:YES error:nil];
    BOOL nameSaveOK = [TCWBSFHFKeychainUtils storeUsername:TCKeychainName andPassword:name forServiceName:serviceName updateExisting:YES error:nil];
    return accessTokenSaveOK && openIdSaveOK && openKeySaveOK && expireTimeSaveOK && refreshTokenSaveOK && nameSaveOK;
}

- (void)readAuthorizeDataFromKeychain{
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:TCKeychainServiceNameSuffix];
    self.openId = [TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainOpenId andServiceName:serviceName error:nil];
    self.openKey = [TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainOpenKey andServiceName:serviceName error:nil];
    self.accessToken = [TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainAccessToken andServiceName:serviceName error:nil];
    self.expireTime = [[TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainExpireTime andServiceName:serviceName error:nil] doubleValue];
    self.refreshToken = [TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainRefreshToken andServiceName:serviceName error:nil];
    self.name = [TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainName andServiceName:serviceName error:nil];
    if ([self.accessToken length] > 0) {
        isRefreshTokenSuccess = YES;
    }
}

- (BOOL)deleteAuthorizeDataInKeychain{
    self.accessToken = nil;
    self.expireTime = 0;
    
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:TCKeychainServiceNameSuffix];
	BOOL accessTokenDeleteOK = [TCWBSFHFKeychainUtils deleteItemForUsername:TCKeychainAccessToken andServiceName:serviceName error:nil];
	BOOL expireTimeDeleteOK = [TCWBSFHFKeychainUtils deleteItemForUsername:TCKeychainExpireTime andServiceName:serviceName error:nil];
    BOOL refreshTokenDeleteOK = [TCWBSFHFKeychainUtils deleteItemForUsername:TCKeychainRefreshToken andServiceName:serviceName error:nil];
    BOOL nameDeleteOK = [TCWBSFHFKeychainUtils deleteItemForUsername:TCKeychainName andServiceName:serviceName error:nil];
    BOOL openIdDeleteOK = [TCWBSFHFKeychainUtils deleteItemForUsername:TCKeychainOpenId andServiceName:serviceName error:nil];
    BOOL openKeyDeleteOK = [TCWBSFHFKeychainUtils deleteItemForUsername:TCKeychainOpenKey andServiceName:serviceName error:nil];
    
    return accessTokenDeleteOK && expireTimeDeleteOK && refreshTokenDeleteOK && nameDeleteOK && openIdDeleteOK && openKeyDeleteOK;
}

#pragma mark -  getIP

- (NSString *)deviceIPAdress {  
    InitAddresses();  
    GetIPAddresses();  
    GetHWAddresses();
    return [NSString stringWithFormat:@"%s", ip_names[1]];  
}  

#pragma mark - private method

//处理request请求，存入数组
- (void) managerRequestWithRequest:(TCWBRequest *)request 
                          delegate:(id)delegates
                           success:(SEL)successCallback
                        andFailure:(SEL)failureCallback{
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithCapacity:3];
	for (int i = 0; i < [httpRequests count]; i++) {
		NSDictionary *dicItem = [httpRequests objectAtIndex:i];
		TCWBRequest *wBRequest = (TCWBRequest *)[dicItem objectForKey:@"Request"];
		if (YES == wBRequest.complete) {
			[tmpArray addObject:dicItem]; 
		}
	}
	[httpRequests removeObjectsInArray:tmpArray];
    
	NSMutableDictionary *dicItem = [[NSMutableDictionary alloc] initWithCapacity:3];
    if (request != nil) {
        [dicItem setObject:request forKey:@"Request"];
    }
    if (delegates != nil) {
        DelegateObject *del = [[DelegateObject alloc] init];
        del.delegate = delegates;
    	[dicItem setObject:del forKey:@"Delegate"];
    }
	if (successCallback != nil) {
		[dicItem setObject:NSStringFromSelector(successCallback) forKey:@"SuccessCallBack"];
	}
	if (failureCallback != nil) {
		[dicItem setObject:NSStringFromSelector(failureCallback)  forKey:@"FailureCallback"];
	}
	[httpRequests addObject:dicItem];
}

#pragma mark - public method

//创建字典存储返回信息
- (NSDictionary *)createDicforAccesstoken:(NSString *)returnString{
    NSMutableDictionary *accessDic = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *returnArray = [[NSArray alloc] initWithArray:[returnString componentsSeparatedByString:@"&"]];
    for (int i = 0; i < [returnArray count]; i++) {
        NSArray *array = [[returnArray objectAtIndex:i] componentsSeparatedByString:@"="];
        [accessDic setObject:[array objectAtIndex:1]forKey:[array objectAtIndex:0]];
    }
    return accessDic;
}

// 存储刷新accesstoken信息
- (void)saveAccessTokenInfo:(NSString *)code{
    NSDictionary *accessDic = [self createDicforAccesstoken:code];
    if ([accessDic objectForKey:@"errorCode"] == nil) {
        self.accessToken = [accessDic objectForKey:@"access_token"];
        self.expireTime = [[accessDic objectForKey:@"expires_in"] intValue]+[[NSDate date] timeIntervalSince1970];
        self.name = [accessDic objectForKey:@"name"];
        self.refreshToken = [accessDic objectForKey:@"refresh_token"];
        if ([accessDic objectForKey:@"openid"] != nil) {
            self.openId = [accessDic objectForKey:@"openid"];
        }
        if ([accessDic objectForKey:@"openkey"] != nil) {
            self.openKey = [accessDic objectForKey:@"openkey"];
        }
    }   
}

//请求刷新accessToken接口
- (NSString *)refreshAccessToken:(NSString *)appkey 
                grant_type:(NSString *)grantType
          andRefresh_token:(NSString *)refreshtoken {
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:appkey, CLIENT_ID,
                            grantType, GRANT_TYPE,
                            refreshtoken, REFRESH_TOKEN,nil];
    NSString *urlString = [TCWBRequest serializeURL:kTCWBAccessTokenURL params:params httpMethod:@"GET"];
    
    TCWBRequest *accessTokenRequest = [TCWBRequest requestWithURL:urlString];
    NSData *returnData = [accessTokenRequest connect:urlString];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    return  returnString;
}

//基础接口
- (void)initRequestWithMethodName:(NSString *)methodName
                       httpMethod:(NSString *)httpMethod
                           params:(NSDictionary *)params
                     postDataType:(TCWBRequestPostDataType)postDataType
              andHttpHeaderFields:(NSDictionary *)httpHeaderFields
                         delegate:(id)requestDelegate
                        onSuccess:(SEL)successCallback
                        onFailure:(SEL)failureCallback{
    
    NSString *code = nil;
    temp_delegate = requestDelegate;
    onSuccessCallback = successCallback;
    onFailureCallback = failureCallback;

    if (refreshToken != nil) {
//      如果从未登录过或登出过
        if (G_LOGOUT) {
            [self readAuthorizeDataFromKeychain];
        }
        
        if ([self isAuthorizeExpired]) {  
            //      授权过期去刷授权 
            code = [self refreshAccessToken:WiressSDKDemoAppKey
                                 grant_type:REFRESH_TOKEN 
                           andRefresh_token:self.refreshToken];
            if (code != nil) {
                NSRange range = [code rangeOfString:@"errorCode="];
                if (range.location != NSNotFound) {
                    //          刷新accesstoken失败
                    isRefreshTokenSuccess = NO;
                    NSDictionary *dic = [self createDicforAccesstoken:code];
                    NSError *error = [NSError errorWithDomain:[dic objectForKey:@"domain"] code:[[dic objectForKey:@"errorCode"]intValue] userInfo:nil];
                    if([temp_delegate respondsToSelector:onFailureCallback]){
                        SuppressPerformSelectorLeakWarning
                        ([temp_delegate performSelector:onFailureCallback withObject:error]);
                    }
                    
                }
                else{
                    //          刷新accesstoken成功
                    isRefreshTokenSuccess = YES;
                    [self saveAccessTokenInfo:code];
                }
            }
            else{
//              如果code返回值为空  
                NSError *error = [NSError errorWithDomain:TCWBSDKErrorDomain code:TCWBSDKErrorCodeAccessError userInfo:nil];
                if([temp_delegate respondsToSelector:onFailureCallback])
                    SuppressPerformSelectorLeakWarning
                    ([temp_delegate performSelector:onFailureCallback withObject:error]);
            }
        }
        //  授权过期后，根据状态来判断是否请求数据
        if (self.isRefreshTokenSuccess) {
            NSString *url = [[NSString alloc]initWithFormat:@"%@%@?",TCWBSDKAPIDomain,methodName];
            if ([ip_iphone length] == 0) {
                self.ip_iphone = [NSString stringWithFormat:@"%@",[self deviceIPAdress]];
            }
            
            // 2012-09-17 增加appfrom参数
            NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:params];
            if (![[params allKeys] containsObject:@"appfrom"]) {
                [dicParams setObject:@"ios-sdk-2.0" forKey:@"appfrom"];
            }
            TCWBRequest *request = [TCWBRequest requestWithURL:url
                                                   AccessToken:accessToken 
                                                        appkey:WiressSDKDemoAppKey
                                                        openId:openId 
                                                      clientip:ip_iphone
                                                 oauth_version:@"2.a" 
                                                         scope:@"all"
                                                  postDataType:postDataType
                                                    httpMethod:httpMethod
                                                        params:dicParams
                                              httpHeaderFields:nil
                                                      delegate:self];
            [request connect];
            
            [self managerRequestWithRequest:request 
                                   delegate:requestDelegate
                                    success:successCallback 
                                 andFailure:failureCallback];
        }
    }
    else{
        NSError *error = [NSError errorWithDomain:TCWBSDKErrorDomain code:TCWBSDKErrorCodeRequestError userInfo:nil];
        if([temp_delegate respondsToSelector:onFailureCallback])
        {
            SuppressPerformSelectorLeakWarning
            ([temp_delegate performSelector:onFailureCallback withObject:error]);
        }
    }
  }

#pragma mark - 发表相关

//function: 发表一条微博
//http://wiki.open.t.qq.com/index.php/微博相关/发布一条微博数据
- (void)postTextTweetWithFormat:(NSString *)format 
                           content:(NSString *)content 
                          clientIP:(NSString *)clentip  
                         longitude:(NSString *)longitude 
                       andLatitude:(NSString *)latitude
                       parReserved:(NSDictionary *)parReserved
                          delegate:(id)requestDelegate 
                         onSuccess:(SEL)successCallback 
                         onFailure:(SEL)failuerCallback{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
    [dic setObject:format forKey:@"format"];
    if (content != nil) {
        [dic setObject:content forKey:@"content"];
    }
    if (clentip != nil) {
        [dic setObject:clentip forKey:@"clientip"];
    }
    if (longitude != nil) {
        [dic setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dic setObject:latitude forKey:@"latitude"];
    }
    NSArray *arrReservedKeys = [parReserved allKeys];
    for (NSString *keyItem in arrReservedKeys) {
        [dic setObject:[parReserved objectForKey:keyItem] forKey:keyItem];
    }
    [self initRequestWithMethodName:@"t/add"
                         httpMethod:@"POST" 
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNormal
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failuerCallback];
}

//发表一条带图片的微博
- (void)postPictureTweetWithFormat:(NSString *)format 
                              content:(NSString *)content 
                             clientIP:(NSString *)clentip  
                                  pic:(NSData *)picture
                       compatibleFlag:(NSString *)compatibleflag
                            longitude:(NSString *)longitude 
                          andLatitude:(NSString *)latitude
                          parReserved:(NSDictionary *)parReserved
                             delegate:(id)requestDelegate 
                            onSuccess:(SEL)successCallback 
                            onFailure:(SEL)failuerCallback{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
    [dic setObject:format forKey:@"format"];
    if (compatibleflag != nil) {
        [dic setObject:compatibleflag forKey:@"compatibleflag"];
    }
    if (content != nil) {
        [dic setObject:content forKey:@"content"];
    }
    if (clentip != nil) {
        [dic setObject:clentip forKey:@"clientip"];
    }
    if (picture != nil) {
        [dic setObject:picture forKey:@"pic"];
    }
    if (longitude != nil) {
        [dic setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dic setObject:latitude forKey:@"latitude"];
    }
    NSArray *arrReservedKeys = [parReserved allKeys];
    for (NSString *keyItem in arrReservedKeys) {
        [dic setObject:[parReserved objectForKey:keyItem] forKey:keyItem];
    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [self initRequestWithMethodName:@"t/add_pic"
                         httpMethod:@"POST" 
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeMultipart
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failuerCallback];
//    });
    
}
//
//- (void)sendWeiboWithParam:(NSDictionary *)dic {
//    [self initRequestWithMethodName:@"t/add_pic"
//                         httpMethod:@"POST" 
//                             params:dic
//                       postDataType:kWBRequestPostDataTypeMultipart
//                andHttpHeaderFields:nil
//                           delegate:self.rootViewController
//                          onSuccess:onSuccessCallback
//                          onFailure:onFailureCallback];
//}

//发表一条带url链接的图片微博
- (void)postPictureURLTweetWithFormat:(NSString *)format 
                                     content:(NSString *)content 
                                    clientIP:(NSString *)clentip  
                                      picURL:(NSString *)picurl
                              compatibleFlag:(NSString *)compatibleflag
                                   longitude:(NSString *)longitude 
                                 andLatitude:(NSString *)latitude
                                 parReserved:(NSDictionary *)parReserved
                                    delegate:(id)requestDelegate 
                                   onSuccess:(SEL)successCallback 
                                   onFailure:(SEL)failuerCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:6];
    [dic setObject:format forKey:@"format"];
    if (compatibleflag != nil) {
        [dic setObject:compatibleflag forKey:@"compatibleflag"];
    }
    if (content != nil) {
        [dic setObject:content forKey:@"content"];
    }
    if (clentip != nil) {
        [dic setObject:clentip forKey:@"clientip"];
    }
    if (picurl != nil) {
        [dic setObject:picurl forKey:@"pic_url"];
    }
    if (longitude != nil) {
        [dic setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dic setObject:latitude forKey:@"latitude"];
    }
    
    [self initRequestWithMethodName:@"t/add_pic_url"
                         httpMethod:@"POST" 
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNormal
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failuerCallback];
}

#pragma mark - 时间线相关

//function: 主页时间线
- (void)getHomeTimelinewithFormat:(NSString *)format
                         pageFlag:(NSUInteger)flag 
                         pageTime:(NSString *)pageTime  
                           reqNum:(NSUInteger)reqnum 
                             type:(NSUInteger)type 
                   andContentType:(NSUInteger)contentType 
                      parReserved:(NSDictionary *)parReserved
                         delegate:(id)requestDelegate 
                        onSuccess:(SEL)successCallback 
                        onFailure:(SEL)failureCallback{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
    if (pageTime != nil) {
        [dic setObject:pageTime forKey:@"pagetime"];
    }
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:flag] forKey:@"pageflag"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [dic setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:contentType] forKey:@"contenttype"];
    
    [self initRequestWithMethodName:@"statuses/home_timeline"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

//用户时间线
- (void)getUserTimelineWithFormat:(NSString *)format
                         pageFlag:(NSUInteger)flag 
                         pageTime:(NSString *)pageTime  
                           reqNum:(NSUInteger)reqnum 
                           lastid:(NSString *)lastid
                          fopenID:(NSString *)fopenids
                             name:(NSString *)names
                             type:(NSUInteger)type 
                   andContentType:(NSUInteger)contentType 
                      parReserved:(NSDictionary *)parReserved
                         delegate:(id)requestDelegate 
                        onSuccess:(SEL)successCallback 
                        onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:8];
    if (pageTime != nil) {
        [dic setObject:pageTime forKey:@"pagetime"];
    }
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    if (lastid != nil) {
        [dic setObject:lastid forKey:@"lastid"];
    }
    if (fopenids != nil) {
        [dic setObject:fopenids forKey:@"fopenids"];
    }
    if (names != nil) {
        [dic setObject:names forKey:@"names"];
    }
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:flag] forKey:@"pageflag"];
    [dic setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:contentType] forKey:@"contentType"];
    if (fopenids != nil || names != nil) {
        [self initRequestWithMethodName:@"statuses/user_timeline" 
                             httpMethod:@"GET"
                                 params:dic
                           postDataType:kTCWBRequestPostDataTypeNone
                    andHttpHeaderFields:nil
                               delegate:requestDelegate
                              onSuccess:successCallback
                              onFailure:failureCallback];
    }
    
}

//获取话题时间线
- (void)gethtTimelineWithFormat:(NSString *)format
                         reqNum:(NSUInteger)reqnum 
                        tweetID:(NSString *)tweetid  
                           time:(NSString *)time 
                       pageFlag:(NSUInteger)pageflag
                           flag:(NSUInteger)flag
                         htText:(NSString *)httext
                           htID:(NSString *)htid
                           type:(NSUInteger)type 
                 andContentType:(NSUInteger)contentType 
                    parReserved:(NSDictionary *)parReserved
                       delegate:(id)requestDelegate 
                      onSuccess:(SEL)successCallback 
                      onFailure:(SEL)failureCallback{
 
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:10];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    if (tweetid != nil) {
        [dic setObject:tweetid forKey:@"tweetid"];
    }
    if (time != nil) {
        [dic setObject:time forKey:@"time"];
    }
    if (htid != nil) {
        [dic setObject:htid forKey:@"htid"];
    }
    if (httext != nil) {
//  htid和httext这两个参数不能同时填写，如果都填写只拉取htid指定的微博，如果要拉取指定话题的微博，请务必让htid为0
        [dic setObject:@"0" forKey:@"htid"];
        [dic setObject:httext forKey:@"httext"];
    }
   
    [dic setObject:[NSNumber numberWithInteger:pageflag] forKey:@"pageflag"];
    [dic setObject:[NSNumber numberWithInteger:flag] forKey:@"flag"];
    [dic setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:contentType] forKey:@"contentType"];
    if (htid != nil || httext != nil) {
        [self initRequestWithMethodName:@"statuses/ht_timeline_ext" 
                             httpMethod:@"GET"
                                 params:dic
                           postDataType:kTCWBRequestPostDataTypeNone
                    andHttpHeaderFields:nil
                               delegate:requestDelegate
                              onSuccess:successCallback
                              onFailure:failureCallback];

    }
}

- (void)gethtRecentUsedWithFormat:(NSString *)format 
                           reqNum:(NSUInteger)reqnum 
                             page:(NSUInteger)page 
                      andSortType:(NSUInteger)sorttype
                      parReserved:(NSDictionary *)parReserved
                         delegate:(id)requestDelegate
                        onSuccess:(SEL)successCallback
                        onFailure:(SEL)failureCallback{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [dic setObject:[NSNumber numberWithInteger:sorttype] forKey:@"sorttype"];
    [self initRequestWithMethodName:@"ht/recent_used"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

- (void)getTransTweetWithFormat:(NSString *)format 
                           flag:(NSUInteger)flag 
                         rootID:(NSString *)rootid 
                       pageFlag:(NSUInteger)pageflag 
                       pageTime:(NSString *)pagetime 
                         reqNum:(NSUInteger)reqnum 
                   andTweetID:(NSString *)twitterid
                    parReserved:(NSDictionary *)parReserved
                       delegate:(id)requestDelegate 
                      onSuccess:(SEL)successCallback 
                      onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:7];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:flag] forKey:@"flag"];
    [dic setObject:[NSNumber numberWithInteger:pageflag] forKey:@"pageflag"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    if (rootid != nil) {
        [dic setObject:rootid forKey:@"rootid"];
    }
    if (pagetime != nil) {
        [dic setObject:pagetime forKey:@"pagetime"];
    }
    if (twitterid != nil) {
        [dic setObject:twitterid forKey:@"twitterid"];
    }
    [self initRequestWithMethodName:@"t/re_list"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

- (void)gethtFavListWithFormat:(NSString *)format 
                         reqNum:(NSUInteger)reqnum  
                       pageFlag:(NSUInteger)pageflag 
                       pageTime:(NSString*)pagetime 
                      andLastID:(NSString *)lastid
                    parReserved:(NSDictionary *)parReserved
                       delegate:(id)requestDelegate 
                      onSuccess:(SEL)successCallback 
                      onFailure:(SEL)failureCallback{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [dic setObject:[NSNumber numberWithInteger:pageflag] forKey:@"pageflag"];
    if (pagetime != nil) {
        [dic setObject:pagetime forKey:@"pagetime"];
    }
    if (lastid != nil) {
        [dic setObject:lastid forKey:@"lastid"];
    }
    [self initRequestWithMethodName:@"fav/list_ht" 
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}
#pragma mark - 用户相关

- (void)getUserInfoWithFormat:(NSString *)format
                  parReserved:(NSDictionary *)parReserved
                     delegate:(id)requestDelegate 
                    onSuccess:(SEL)successCallback 
                    onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [dic setObject:format forKey:@"format"];
    [self initRequestWithMethodName:@"user/info" 
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

- (void)getOtherUserInfoWithFormat:(NSString *)format
                              name:(NSString *)username 
                           andOpenID:(NSString *)fopenid 
                       parReserved:(NSDictionary *)parReserved
                          delegate:(id)requestDelegate
                         onSuccess:(SEL)successCallback
                         onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dic setObject:format forKey:@"format"];
    if (username != nil) {
        [dic setObject:username forKey:@"name"];
    }
    if (fopenid != nil) {
        [dic setObject:fopenid forKey:@"fopenid"];
    }
    if (username != nil || fopenid != nil) {
        [self initRequestWithMethodName:@"user/other_info"
                             httpMethod:@"GET"
                                 params:dic
                           postDataType:kTCWBRequestPostDataTypeNone
                    andHttpHeaderFields:nil
                               delegate:requestDelegate
                              onSuccess:successCallback
                              onFailure:failureCallback];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"用户名和fopenid至少选填一个" 
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)getInfosWithFormat:(NSString *)format 
                     names:(NSString *)names
                  fopenids:(NSString *)fopenids
               parReserved:(NSDictionary *)parReserved
                  delegate:(id)requestDelegate
                 onSuccess:(SEL)successCallback
                 onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dic setObject:format forKey:@"format"];
    if (names != nil) {
        [dic setObject:names forKey:@"names"];
    }
    if (fopenids != nil) {
        [dic setObject:fopenids forKey:@"fopenids"];
    }
    [self initRequestWithMethodName:@"user/infos"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

#pragma mark - 关系链相关
- (void)getFriendIdolListWithFormat:(NSString *)format  
                             reqNum:(NSUInteger)reqnum  
                         startIndex:(NSUInteger)startindex 
                            andInstall:(NSUInteger)install 
                        parReserved:(NSDictionary *)parReserved
                           delegate:(id)requestDelegate                  
                          onSuccess:(SEL)successCallback
                          onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:4];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [dic setObject:[NSNumber numberWithInteger:startindex] forKey:@"startindex"];
    [dic setObject:[NSNumber numberWithInteger:install] forKey:@"install"];
    [self initRequestWithMethodName:@"friends/idollist"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
    
}

- (void)getFriendFansListWithFormat:(NSString *)format
                             reqNum:(NSUInteger)reqnum
                         startIndex:(NSUInteger)startindex
                               mode:(NSUInteger)mode
                            install:(NSUInteger)install
                             andSex:(NSUInteger)sex
                        parReserved:(NSDictionary *)parReserved
                           delegate:(id)requestDelegate 
                          onSuccess:(SEL)successCallback
                          onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [dic setObject:[NSNumber numberWithInteger:startindex] forKey:@"startindex"];
    [dic setObject:[NSNumber numberWithInteger:mode] forKey:@"mode"];
    [dic setObject:[NSNumber numberWithInteger:install] forKey:@"install"];
    [dic setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
    [self initRequestWithMethodName:@"friends/fanslist"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

- (void)getFriendMutualListWithFormat:(NSString *)format
                                 name:(NSString *)username
                              fopenID:(NSString *)fopenid
                               reqNum:(NSUInteger)reqnum
                           startIndex:(NSUInteger)startindex
                              andInstall:(NSUInteger)install
                          parReserved:(NSDictionary *)parReserved
                             delegate:(id)requestDelegate 
                            onSuccess:(SEL)successCallback
                            onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:6];
    [dic setObject:format forKey:@"format"];
    if (name != nil) {
        [dic setObject:username forKey:@"name"];
    }
    if (fopenid != nil) {
        [dic setObject:fopenid forKey:@"fopenid"];
    }
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [dic setObject:[NSNumber numberWithInteger:startindex] forKey:@"startindex"];
    [dic setObject:[NSNumber numberWithInteger:install] forKey:@"install"];
    if (fopenid != nil || name != nil) {
        [self initRequestWithMethodName:@"friends/mutual_list"
                             httpMethod:@"GET"
                                 params:dic
                           postDataType:kTCWBRequestPostDataTypeNone
                    andHttpHeaderFields:nil
                               delegate:requestDelegate
                              onSuccess:successCallback
                              onFailure:failureCallback];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"用户名和fopenid至少选填一个" 
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

//获取最近联系人
- (void)getFriendIntimateListWithFormat:(NSString *)format
                             andReqNum:(NSUInteger)reqnum
                        parReserved:(NSDictionary *)parReserved
                           delegate:(id)requestDelegate 
                          onSuccess:(SEL)successCallback
                          onFailure:(SEL)failureCallback{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:2];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:reqnum] forKey:@"reqnum"];
    [self initRequestWithMethodName:@"friends/get_intimate_friends"
                         httpMethod:@"GET"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNone
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

//获取互听好友列表
- (void)checkFriendWithFormat:(NSString *)format
                           names:(NSString *)names 
                        fopenIDs:(NSString *)fopenids 
                         andFlag:(NSUInteger)flag
                     parReserved:(NSDictionary *)parReserved
                        delegate:(id)requestDelegate 
                       onSuccess:(SEL)successCallback
                       onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:4];
    [dic setObject:format forKey:@"format"];
    [dic setObject:[NSNumber numberWithInteger:flag] forKey:@"flag"];
    if (names != nil) {
        [dic setObject:names forKey:@"names"];
    }
    if (fopenids != nil) {
        [dic setObject:fopenids forKey:@"fopenids"];
    }
    if (names != nil || fopenids != nil) {
        [self initRequestWithMethodName:@"friends/check"
                             httpMethod:@"GET"
                                 params:dic
                           postDataType:kTCWBRequestPostDataTypeNone
                    andHttpHeaderFields:nil
                               delegate:requestDelegate
                              onSuccess:successCallback
                              onFailure:failureCallback];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"names和fopenids至少选填一个" 
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)addFriendsWithFormat:(NSString *)format
                       names:(NSString *)names
                  andOpenIDs:(NSString *)fopenids
                 parReserved:(NSDictionary *)parReserved
                    delegate:(id)requestDelegate
                   onSuccess:(SEL)successCallback 
                   onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:4];
    [dic setObject:format forKey:@"format"];
    if (names != nil) {
        [dic setObject:names forKey:@"name"];
    }
    if (fopenids != nil) {
        [dic setObject:fopenids forKey:@"fopenids"];
    }
    if (names != nil || fopenids != nil) {
        [self initRequestWithMethodName:@"friends/add"
                             httpMethod:@"POST"
                                 params:dic
                           postDataType:kTCWBRequestPostDataTypeNormal
                    andHttpHeaderFields:nil
                               delegate:requestDelegate
                              onSuccess:successCallback
                              onFailure:failureCallback];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"names和fopenids至少选填一个" 
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - lbs

- (void)getAroundNewsWithFormat:(NSString *)format
                   longitude:(NSString *)longitude
                    latitude:(NSString *)latitude
                    pageInfo:(NSString *)pageinfo
                    andPageSize:(NSUInteger)pagesize 
                 parReserved:(NSDictionary *)parReserved
                    delegate:(id)requestDelegate
                   onSuccess:(SEL)successCallback 
                   onFailure:(SEL)failureCallback{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
    [dic setObject:format forKey:@"format"];
    if (longitude != nil) {
        [dic setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dic setObject:latitude forKey:@"latitude"];
    }
    [dic setObject:pageinfo forKey:@"pageinfo"];
    [dic setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [self initRequestWithMethodName:@"lbs/get_around_new"
                         httpMethod:@"POST"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNormal
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

- (void)getAroundPeopleWithFormat:(NSString *)format 
                     longitude:(NSString *)longitude
                      latitude:(NSString *)latitude 
                      pageInfo:(NSString *)pageinfo 
                      pageSize:(NSUInteger)pagesize
                        andGender:(NSUInteger)gender
                   parReserved:(NSDictionary *)parReserved
                      delegate:(id)requestDelegate
                     onSuccess:(SEL)successCallback 
                     onFailure:(SEL)failureCallback{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:6];
    [dic setObject:format forKey:@"format"];
    if (longitude != nil){
        [dic setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dic setObject:latitude forKey:@"latitude"];
    }
    [dic setObject:pageinfo forKey:@"pageinfo"];
    [dic setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [dic setObject:[NSNumber numberWithInteger:gender] forKey:@"gender"];
    [self initRequestWithMethodName:@"lbs/get_around_people"
                         httpMethod:@"POST"
                             params:dic
                       postDataType:kTCWBRequestPostDataTypeNormal
                andHttpHeaderFields:nil
                           delegate:requestDelegate
                          onSuccess:successCallback
                          onFailure:failureCallback];
}

- (void)getMapRegocWithLlnglat:(NSString *)lnglat 
                       andReqSrc:(NSString *)reqsrc
                  parReserved:(NSDictionary *)parReserved
                     delegate:(id)requestDelegate
                    onSuccess:(SEL)successCallback 
                    onFailure:(SEL)failureCallback{
    temp_delegate = requestDelegate;
    onSuccessCallback = successCallback;
    onFailureCallback = failureCallback;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:2];
    if (lnglat != nil) {
        [dic setObject:lnglat forKey:@"lnglat"];
    }
    if(reqsrc != nil){
        [dic setObject:reqsrc forKey:@"reqsrc"];
    }
    TCWBRequest *request = [TCWBRequest requestWithURL:kWBLonAndLatURL 
                                            httpMethod:@"GET"
                                                params:dic
                                          postDataType:kTCWBRequestPostDataTypeNone
                                      httpHeaderFields:nil
                                              delegate:self];
    [request connect];
    [self managerRequestWithRequest:request
                           delegate:requestDelegate
                            success:successCallback 
                         andFailure:failureCallback];
}

#pragma mark - TCWBEngine Public Methods

//判断授权是否过期
//比如 你换token的时间是 A， 返回的过期时间是expire_in，当前时间是B
//A+expire_in < B 就是过期了
//A+expire_in > B就是没有过期
- (BOOL)isAuthorizeExpired{
    if ([[NSDate date] timeIntervalSince1970] > expireTime){
        [self deleteAuthorizeDataInKeychain];
        return YES;
    }
    return NO;
}

- (BOOL)isLoggedIn
{
    return name && accessToken && refreshToken;
}

//登录
- (void)logInWithDelegate:(id) requestDelegate  
                onSuccess:(SEL)successCallback 
                onFailure:(SEL)failureCallback{

    temp_delegate = requestDelegate;
    onSuccessCallback = successCallback;
    onFailureCallback = failureCallback;

    if ([redirectURI length] <= 0) {
        self.redirectURI = REDIRECTURI;
    }
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:appKey,CLIENT_ID,
                            TOKEN, RESPONSE_TYPE,
                            redirectURI,REDIRECT_URI,
                            @"ios",@"appfrom",
                            [NSNumber numberWithInt:1],@"htmlVersion",
                            nil];
    NSString *urlString = [TCWBRequest serializeURL:kTCWBAuthorizeURL
                                             params:params
                                         httpMethod:@"GET"];
    
    TCWBAuthorizeViewController *authViewController = [[TCWBAuthorizeViewController alloc] init];
    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:authViewController];
    authViewController.requestURLString = urlString;
    [authViewController setDelegate:self];    
    [rootViewController presentModalViewController:nav animated:YES]; 
}

//使用已有授权信息登录
- (void)logInWithAccessToken:(NSString *)theAccessToken 
                 expiredTime:(NSString *)theExpiredTime  
                      openID:(NSString *)theOpenid
             andRefreshToken:(NSString *)theRefreshToken 
                    delegate:(id)delegate 
                   onSuccess:(SEL)successCallback 
                   onFailure:(SEL)failureCallback{
    temp_delegate = delegate;
    onSuccessCallback = successCallback;
    onFailureCallback = failureCallback;
    self.accessToken = theAccessToken;
    self.expireTime = [theExpiredTime intValue]+ [[NSDate date] timeIntervalSince1970];
    self.openId = theOpenid;
    self.refreshToken = theRefreshToken;
    [self saveAuthorizeDataToKeychain];
    if (![self isAuthorizeExpired]) {
        if ([temp_delegate respondsToSelector:onSuccessCallback]) {
            SuppressPerformSelectorLeakWarning
            ([temp_delegate performSelector:onSuccessCallback withObject:nil]);
        }
    }
    else{    
        if ([temp_delegate respondsToSelector:onFailureCallback]) {
            SuppressPerformSelectorLeakWarning
            ([temp_delegate performSelector:onFailureCallback withObject:nil]);
        }
    }
}

//登出
- (BOOL)logOut{
    // 2012-9-7 4：38pm 郭松  删除用户缓存
    NSString *strPath = [FileStreame getUserDirectory:name];
    [FileStreame deleteDirectory:strPath];
    
    G_LOGOUT = [self deleteAuthorizeDataInKeychain];
    return G_LOGOUT;
}


#pragma mark - TCWBAuthorizeDelegate Methods

//授权成功回调
- (void)authorize:(TCWBAuthorizeViewController *)authorize didSucceedWithAccessToken:(NSString *)code{
    G_LOGOUT = NO;
    [self saveAccessTokenInfo:code];
    BOOL saveKeychainOK = [self saveAuthorizeDataToKeychain];
    if (!saveKeychainOK) {
        BOOL deleteKeychainOK = [self deleteAuthorizeDataInKeychain];
        if (deleteKeychainOK) {
            [self saveAuthorizeDataToKeychain];
        }
    }
    if ([temp_delegate respondsToSelector:onSuccessCallback]) {
        SuppressPerformSelectorLeakWarning
        ([temp_delegate performSelector:onSuccessCallback withObject:nil]);
    }
}

//授权失败回调
- (void)authorize:(TCWBAuthorizeViewController *)authorize didFailuredWithError:(NSError *)error{
    G_LOGOUT = NO;
    if ([temp_delegate respondsToSelector:onFailureCallback]) {
        SuppressPerformSelectorLeakWarning
        ([temp_delegate performSelector:onFailureCallback withObject:error]);
    }
}

#pragma mark - TCWBRequestDelegate Methods

- (void)request:(TCWBRequest *)req didFinishLoadingWithResult:(id)result{
    id delegates = nil;
    SEL successCallback = nil;
	for (int i = 0; i < [httpRequests count]; i++) {
		NSDictionary *dicItem = [httpRequests objectAtIndex:i];
		TCWBRequest *requestItem = (TCWBRequest *)[dicItem objectForKey:@"Request"];
		if (req == requestItem) {
			delegates = ((DelegateObject *)[dicItem objectForKey:@"Delegate"]).delegate;
			successCallback = NSSelectorFromString([dicItem objectForKey:@"SuccessCallBack"]);
            break;
		}
    }    
    if ([delegates respondsToSelector:successCallback]) {
        SuppressPerformSelectorLeakWarning
        ([delegates performSelector:successCallback withObject:result]);
    }
}

- (void)request:(TCWBRequest *)req didFailWithError:(NSError *)error{
    // 2012-09-11 By Yi Minwen: 失败处理增加判断
    id delegate = nil;
//    SEL failureCallback = nil;
	for (int i = 0; i < [httpRequests count]; i++) {
		NSDictionary *dicItem = [httpRequests objectAtIndex:i];
		TCWBRequest *requestItem = (TCWBRequest *)[dicItem objectForKey:@"Request"];
		if (req == requestItem) {
			delegate = ((DelegateObject *)[dicItem objectForKey:@"Delegate"]).delegate;
//			failureCallback = NSSelectorFromString([dicItem objectForKey:@"FailureCallback"]);
            break;
		}
    }
    if ([delegate respondsToSelector:onFailureCallback]) {
        SuppressPerformSelectorLeakWarning
        ([delegate performSelector:onFailureCallback withObject:error]);
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  转发一条微博
- (void)rebroadWBWithFamat:(NSString *)famat 
                   content:(NSString *)content 
                  conlitip:(NSString *)clientip
                 longitude:(NSString *)longitude 
               andLatitude:(NSString *)latitude
                      reid:(NSNumber *)number 
              postDataType:(TCWBRequestPostDataType)postDataType
                  delegate:(id)requestDelegate
                 onSuccess:(SEL)successCallback
                 onFailure:(SEL)failureCallback {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:famat forKey:@"format"];
    if (content != nil) {
        [dict setObject:content forKey:@"content"];
    }
    if (clientip != nil) {
        [dict setObject:clientip forKey:@"clientip"];
    }
    if (number != nil) {
        [dict setObject:number forKey:@"reid"];
    }
    if (longitude != nil) {
        [dict setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dict setObject:latitude forKey:@"latitude"];
    }
    
    [self initRequestWithMethodName:@"t/re_add" 
                         httpMethod:@"POST" 
                             params:dict 
                       postDataType:postDataType 
                andHttpHeaderFields:nil 
                           delegate:requestDelegate 
                          onSuccess:successCallback 
                          onFailure:failureCallback];
}

- (void)repeatMsgWithFormat:(NSString *)format 
                    content:(NSString *)content 
                   clientip:(NSString *)clientip 
                  longitude:(NSString *)longitude 
                   latitude:(NSString *)latitude 
                     picURL:(NSURL *)picURL 
                   videoURL:(NSURL *)videoURL 
                   musicURL:(NSURL *)musicURL 
                 musicTitle:(NSString *)musicTitle 
                musicAuthor:(NSString *)musicAuthor 
                   syncflag:(NSNumber *)syncflag 
             compatibleflag:(NSNumber *)compatibleflag 
               parReserved:(NSDictionary *)parReserved 
                   delegate:(id)requestDelegate 
                  onSuccess:(SEL)successCallback 
                  onFailure:(SEL)failureCallback {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:format forKey:@"format"];
    if (content != nil) {
        [dict setObject:content forKey:@"content"];
    }
    if (clientip != nil) {
        [dict setObject:clientip forKey:@"clientip"];
    }
    if (longitude != nil) {
        [dict setObject:longitude forKey:@"longitude"];
    }
    if (latitude != nil) {
        [dict setObject:latitude forKey:@"latitude"];
    }
    if (picURL != nil) {
        [dict setObject:picURL forKey:@"pic_url"];
    }
    if (videoURL != nil) {
        [dict setObject:videoURL forKey:@"video_url"];
    }
    if (musicURL != nil) {
        [dict setObject:musicURL forKey:@"music_url"];
    }
    if (musicAuthor != nil) {
        [dict setObject:musicAuthor forKey:@"music_author"];
    }
    if (musicTitle != nil) {
        [dict setObject:musicTitle forKey:@"music_title"];
    }
    if (syncflag != nil) {
        [dict setObject:syncflag forKey:@"syncflag"];
    }
    if (compatibleflag != nil) {
        [dict setObject:compatibleflag forKey:@"compatibleflag"];
    }
    NSArray *arrReservedKeys = [parReserved allKeys];
    for (NSString *keyItem in arrReservedKeys) {
        [dict setObject:[parReserved objectForKey:keyItem] forKey:keyItem];
    }

    [self initRequestWithMethodName:@"t/add_multi" 
                         httpMethod:@"POST" 
                             params:dict 
                       postDataType:kTCWBRequestPostDataTypeNormal
                andHttpHeaderFields:nil 
                           delegate:requestDelegate 
                          onSuccess:successCallback 
                          onFailure:failureCallback];
}




// 生成转播组件
#ifdef USE_UI_TWEET 


// 生成发表组件
- (void)UIBroadCastMsgWithContent:(NSString *)content 
                         andImage:(UIImage *)image 
                      parReserved:(NSDictionary *)reserved 
                         delegate:(id)requestDelegate
                      onPostStart:(SEL)postStartCallback
                    onPostSuccess:(SEL)successCallback
                    onPostFailure:(SEL)failureCallback{
    
    onSuccessCallback = successCallback;
    onFailureCallback = failureCallback;
    if (![self isLoggedIn]) {
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:appKey,CLIENT_ID,
                                TOKEN, RESPONSE_TYPE,
                                redirectURI,REDIRECT_URI,
                                @"ios",@"appfrom",
                                [NSNumber numberWithInt:1],@"htmlVersion",
                                nil];
        NSString *urlString = [TCWBRequest serializeURL:kTCWBAuthorizeURL
                                                 params:params
                                             httpMethod:@"GET"];
        
        TCWBAuthorizeViewController *authViewController = [[TCWBAuthorizeViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authViewController];
        authViewController.requestURLString = urlString;
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        AuthorizeDelegate *authDelegate = [[AuthorizeDelegate alloc] initWithRunLoop:currentRunLoop];
        [authViewController setDelegate:authDelegate];    
        [rootViewController presentModalViewController:nav animated:YES]; 
        CFRunLoopRun();
        if (authDelegate.returnCode != nil) {
            [self saveAccessTokenInfo:authDelegate.returnCode];
            BOOL saveKeychainOK = [self saveAuthorizeDataToKeychain];
            if (!saveKeychainOK) {
                BOOL deleteKeychainOK = [self deleteAuthorizeDataInKeychain];
                if (deleteKeychainOK) {
                    [self saveAuthorizeDataToKeychain];
                }
            }
        }
    }
    if ([self isLoggedIn]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
        DelegateObject *del = [[DelegateObject alloc] init];
        del.delegate = requestDelegate;
    	[dic setObject:del forKey:@"requestDelegate"];
        [dic setObject:NSStringFromSelector(postStartCallback) forKey:@"postStartCallback"];
        [dic setObject:NSStringFromSelector(successCallback) forKey:@"successCallback"];
        [dic setObject:NSStringFromSelector(failureCallback) forKey:@"failureCallback"];
        if (content) {
            [dic setObject:content forKey:@"content"];
        }
        if (image) {
            [dic setObject:image forKey:@"image"];
        }
        if (reserved) {
            [dic setObject:reserved forKey:@"reserved"];
        }
        TCWBRebroadcastMsgViewController *tCWBRebroadcastMsgViewController = [[TCWBRebroadcastMsgViewController alloc] initWithEngine:self parameter:dic];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tCWBRebroadcastMsgViewController];
        [self.rootViewController presentModalViewController:nvc animated:YES];
    }
}

- (void)UICreatRebroadWithContent:(NSString *)content 
                      imageRefURL:(NSString *)imageRefURL 
                 videoImageRefURL:(NSString *)videoImageRefURL 
                      parReserved:(NSDictionary *)reserved 
                         delegate:(id)requestDelegate 
                      onPostStart:(SEL)postStartCallback 
                        onSuccess:(SEL)successCallBack 
                        onFailure:(SEL)onFailureCallBack {
    onSuccessCallback = successCallBack;
    onFailureCallback = onFailureCallBack;
    if (![self isLoggedIn]) {
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:appKey,CLIENT_ID,
                                TOKEN, RESPONSE_TYPE,
                                redirectURI,REDIRECT_URI,
                                @"ios",@"appfrom",
                                [NSNumber numberWithInt:1],@"htmlVersion",
                                nil];
        NSString *urlString = [TCWBRequest serializeURL:kTCWBAuthorizeURL
                                                 params:params
                                             httpMethod:@"GET"];
        
        TCWBAuthorizeViewController *authViewController = [[TCWBAuthorizeViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authViewController];
        authViewController.requestURLString = urlString;
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        AuthorizeDelegate *authDelegate = [[AuthorizeDelegate alloc] initWithRunLoop:currentRunLoop];
        [authViewController setDelegate:authDelegate];    
        [rootViewController presentModalViewController:nav animated:YES]; 
        CFRunLoopRun();
        if (authDelegate.returnCode != nil) {
            [self saveAccessTokenInfo:authDelegate.returnCode];
            BOOL saveKeychainOK = [self saveAuthorizeDataToKeychain];
            if (!saveKeychainOK) {
                BOOL deleteKeychainOK = [self deleteAuthorizeDataInKeychain];
                if (deleteKeychainOK) {
                    [self saveAuthorizeDataToKeychain];
                }
            }
        }
    }
    if ([self isLoggedIn]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        DelegateObject *del = [[DelegateObject alloc] init];
        del.delegate = requestDelegate;
    	[dic setObject:del forKey:@"requestDelegate"];
        [dic setObject:NSStringFromSelector(postStartCallback) forKey:@"postStartCallback"];
        [dic setObject:NSStringFromSelector(successCallBack) forKey:@"successCallback"];
        [dic setObject:NSStringFromSelector(onFailureCallBack) forKey:@"failureCallback"];
        if (content) {
            [dic setObject:content forKey:@"content"];
        }
        if (imageRefURL) {
            [dic setObject:imageRefURL forKey:@"imageRefURL"];
        }
        if (videoImageRefURL) {
            [dic setObject:videoImageRefURL forKey:@"videoImageRefURL"];
        }
        if (reserved) {
            [dic setObject:reserved forKey:@"reserved"];
        }
        TCWBRepeatViewController *tCWBRebroadcastMsgViewController = [[TCWBRepeatViewController alloc] initWithEngine:self parameter:dic];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tCWBRebroadcastMsgViewController];
        [self.rootViewController presentModalViewController:nvc animated:YES];
        
    }
}

// 获取视频缩略图
- (void)getViedoMsgWith:(NSString *)farmat 
               videoURL:(NSURL *)videoURL 
               delegate:(id)requestDelegate 
              onSuccess:(SEL)successCallback 
              onFailure:(SEL)failureCallback {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:farmat forKey:@"format"];
    if (videoURL != nil) {
        [dict setObject:videoURL forKey:@"video_url"];
    }

    [self initRequestWithMethodName:@"t/getvideoinfo" 
                         httpMethod:@"POST" 
                             params:dict 
                       postDataType:kTCWBRequestPostDataTypeNormal
                andHttpHeaderFields:nil 
                           delegate:requestDelegate 
                          onSuccess:successCallback 
                          onFailure:failureCallback];
}

#endif

@end
