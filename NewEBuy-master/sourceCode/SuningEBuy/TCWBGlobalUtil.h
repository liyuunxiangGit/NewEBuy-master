//
//  TCWBGlobalUtil.h
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-16.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#ifndef TCWeiBoSDKDemo_TCWBGlobalUtil_h
#define TCWeiBoSDKDemo_TCWBGlobalUtil_h

#define WiressSDKDemoAppKey     @"801327664"
#define WiressSDKDemoAppSecret  @"cfb9002ac7caa0c41ed9668bc1357bb9"
#define REDIRECTURI             @"http://www.ying7wang7.com"

#define TCWBSDKAPIDomain        @"https://open.t.qq.com/api/"
#define kTCWBAuthorizeURL         @"https://open.t.qq.com/cgi-bin/oauth2/authorize/ios"
#define kTCWBAccessTokenURL       @"https://open.t.qq.com/cgi-bin/oauth2/access_token"
#define kWBLonAndLatURL         @"http://ugc.map.soso.com/rgeoc/"

#define OAUTH_CONSUMER_KEY      @"oauth_consumer_key"
#define TOKEN                   @"token"
#define ACCESS_TOKEN            @"access_token"
#define REFRESH_TOKEN           @"refresh_token"
#define EXPIRES_IN              @"expires_in"
#define OPENID                  @"openid"
#define CLIENTIP                @"clientip"
#define OAUTH_VERSION           @"oauth_version"
#define SCOPE                   @"scope"

#define CLIENT_ID               @"client_id"
#define GRANT_TYPE              @"grant_type"
#define RESPONSE_TYPE           @"response_type"
#define REDIRECT_URI            @"redirect_uri"

#define TCWBSDKErrorDomain       @"TCSDKErrorDomain"  //生成error对象时的自定义domain
#define TCWBSDKErrorCodeKey      @"TCSDKErrorCodeKey" //error对应的键值

#endif

typedef enum{
	TCWBErrorCodeInterface	 = 100,
	TCWBErrorCodeSDK         = 101,
}TCWBErrorCode;

typedef enum{
	TCWBSDKErrorCodeParseError       = 200,     //解析错误
	TCWBSDKErrorCodeRequestError     = 201,     //请求错误
	TCWBSDKErrorCodeAccessError      = 202,     //返回accesstoken错误
	TCWBSDKErrorCodeAuthorizeError	 = 203,     //认证错误
}TCWBSDKErrorCode;

