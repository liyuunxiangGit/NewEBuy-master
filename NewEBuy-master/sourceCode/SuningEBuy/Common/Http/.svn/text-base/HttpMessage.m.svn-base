//
//  HttpMessage.m
//  SuningLottery
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "MsgConstant.h"
#import "HttpMessage.h"
#import "HttpMsgCtrl.h"

@implementation HttpMessage

@synthesize cmdCode = _cmdCode;
@synthesize timeout = _timeout;
@synthesize requestUrl = _requestUrl;
@synthesize postDataDic = _postDataDic;
@synthesize requestMethod = _requestMethod;
@synthesize delegate = _delegate;
@synthesize errorCode = _errorCode;
@synthesize responseString = _responseString;
@synthesize jasonItems = _jasonItems;
@synthesize canMultipleConcurrent = _canMultipleConcurrent;
@synthesize addedCookies = _addedCookies;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_requestUrl);
    TT_RELEASE_SAFELY(_postDataDic);
    _delegate = nil;
    TT_RELEASE_SAFELY(_errorCode);
    TT_RELEASE_SAFELY(_responseString);
    TT_RELEASE_SAFELY(_jasonItems);
    TT_RELEASE_SAFELY(_addedCookies);
    
}

- (NSMutableArray *)addedCookies
{
    if (!_addedCookies) {
        _addedCookies = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _addedCookies;
}

- (void)setUp
{
    self.timeout = HTTP_TIMEOUT;
    _requestMethod = RequestMethodPost; //默认post方法
    
    //添加在cookie里添加cityId字段; 8-24 liukun
    NSString *cityId =
    [Config currentConfig].defaultCity?[Config currentConfig].defaultCity:@"9173";
    NSDictionary *cookieProperty = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    suningCookieDomain, NSHTTPCookieDomain,
                                    suningCookieDomain, NSHTTPCookieOriginURL,
                                    @"/", NSHTTPCookiePath,
                                    @"cityId", NSHTTPCookieName,
                                    cityId, NSHTTPCookieValue, nil];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperty];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
//    [[self addedCookies] addObject:cookie];
    TT_RELEASE_SAFELY(cookieProperty);
    
    _additionValues = [NSMutableDictionary new];
}

- (id)init
{
    if (self = [super init])
    {
		[self setUp];
    }
    
    return self;
}

- (id)initWithDelegate:(id<HttpResponseDelegate>)delegate 
            requestUrl:(NSString *)url 
           postDataDic:(NSDictionary *)postDic 
               cmdCode:(E_CMDCODE)code 
{
    self = [super init];
    if (self) {
        [self setUp];
        self.delegate = delegate;
        self.requestUrl = url;
        self.postDataDic = postDic;
        self.cmdCode = code;
    }
    return self;
}

- (void)cancelDelegate
{
    _delegate = nil;
}

- (void)cancelDelegateAndCancel
{
    _delegate = nil;
    [[HttpMsgCtrl shareInstance] cancelHttpRequest:self];
}

@end
