//
//  UserRegisterService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserRegisterService.h"
#import "UserCenter.h"
#import "ActivitySwitchService.h"
#import "SFHFKeychainUtils.h"

@interface UserRegisterService()

- (void)registerDidFinish:(BOOL)isSuccess userInfo:(UserInfoDTO *)userInfo;

- (void)parseRegisterData:(NSDictionary *)item;

@end

/*********************************************************************/

@implementation UserRegisterService

@synthesize delegate = _delegate;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize registerType = _registerType;
@synthesize userInfoDTO = _userInfoDTO;

- (void)dealloc {
    TT_RELEASE_SAFELY(_userName);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_userInfoDTO);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(registerHttpMsg);
}

- (void)beginRegisterUsername:(NSString *)username 
                     password:(NSString *)password 
                 registerType:(RegisterType)registerType
{
    self.userName = username;
    self.password = password;
    self.registerType = registerType;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
	[postDataDic setObject:_userName forKey:kRequestRegisterId];
	[postDataDic setObject:_password forKey:kRequestRegisterPassword];
	[postDataDic setObject:_password forKey:kReponseRegisterPasswordVerify];	
	[postDataDic setObject:[NSString stringWithFormat:@"%d", _registerType] forKey:kRequestRegisterType];	
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];		
		
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestRegisterHome];
	
    HTTPMSG_RELEASE_SAFELY(registerHttpMsg);
    
    registerHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_Register];
    registerHttpMsg.requestMethod =RequestMethodGet;
	TT_RELEASE_SAFELY(postDataDic);
    
    //清cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                        cookiesForURL:[NSURL URLWithString:url]];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    [self.httpMsgCtrl sendHttpMsg:registerHttpMsg];
}

#pragma mark -
#pragma mark http message delegate

- (void)registerDidFinish:(BOOL)isSuccess userInfo:(UserInfoDTO *)userInfo
{
    if (isSuccess)
    {
        
        NSString *userName = self.userName;
        NSString *password = self.password;//[NSString encryptUseDES:self.password key:kPasswordEncryptKey];
        
        NSString *passwd = [PasswdUtil encryptString:password
                                              forKey:kLoginPasswdParamEncodeKey
                                                salt:kPBEDefaultSalt];
        [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey
                             andPassword:userName
                          forServiceName:kSNKeychainServiceNameSuffix
                          updateExisting:YES
                                   error:nil];
        [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey
                             andPassword:passwd
                          forServiceName:kSNKeychainServiceNameSuffix
                          updateExisting:YES
                                   error:nil];
//        [Config currentConfig].username = userName;
//        [Config currentConfig].password = password;
        [UserCenter defaultCenter].userInfoDTO = userInfo;
        [[NSNotificationCenter defaultCenter] postNotificationName:REGISTE_OK_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_MESSAGE object:nil];
        
        //收集用户注册id
        NSString *registerName = userInfo.logonId;
        [[SuningMainClick sharedInstance] getUserRegisterNameAndSave:registerName];
        
        
        if (_delegate &&
            [_delegate respondsToSelector:@selector(userRegisterCompletedWithResult:errorCode:userInfo:)])
        {
            [_delegate userRegisterCompletedWithResult:YES errorCode:nil userInfo:userInfo];
        }
    }else{
        if (_delegate &&
            [_delegate respondsToSelector:@selector(userRegisterCompletedWithResult:errorCode:userInfo:)])
        {
            [_delegate userRegisterCompletedWithResult:NO errorCode:self.errorMsg userInfo:userInfo];
        }
    }
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self registerDidFinish:NO userInfo:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.jasonItems == nil) {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self registerDidFinish:NO userInfo:nil];
        return;
    }
    
    if ([receiveMsg.errorCode isEqualToString:@""]) {
        NSInteger userID = [[receiveMsg.jasonItems objectForKey:@"userId"] intValue];
        
        if(userID<=0){
            
            self.errorMsg = kRegisterStatusMessageRegisterPasswordError2;
            [self registerDidFinish:NO userInfo:nil];
        }else{
            [self parseRegisterData:receiveMsg.jasonItems];
        }
        
    }else{
        
        NSString *errorMessage = nil;
		NSString *errorCode = receiveMsg.errorCode;
		if ([errorCode isEqualToString:@"2200"])
        {
			
		    errorMessage = kRegisterStatusMessageRegisterPasswordError1;
            
		}
        else if([errorCode isEqualToString:@"2010"])
        {
			
		    errorMessage = kLoginStatusMessagePasswordError;
            
		}
        else if ([errorCode isEqualToString:@"2030"]||
				  [errorCode isEqualToString:@"2031"])
        {
			
			errorMessage =kRegisterStatusMessageRegisterPasswordError2;
            
            
		}
        else if([errorCode isEqualToString:@"9050"])
        {
			
		    errorMessage =kLoginStatusUserHaveLoginedError;
            
		}
        else if([errorCode isEqualToString:@"9010"])
        {
			
		    errorMessage =kLoginStatusPhoneValidateCodeError;
            
		}
        else if([errorCode isEqualToString:@"1001"])
        {
			
		    errorMessage =kLoginStatusPhoneNoHaveBeenUserdError;
            
		}
        else if([errorCode isEqualToString:@"1005"])
        {
			
		    errorMessage = kLoginStatusPhoneNoEmptyError;
            
		}
        
        else if ([errorCode isEqualToString:@"2001"])
        {
            errorMessage = L(@"LOGIN_RegisterFailTryLater");
        }
        else if ([errorCode eq:@"9023"])
        {
            errorMessage = L(@"LOGIN_RegisterEPayFail");
        }
        else if([errorCode isEqualToString:@"E4700479"])
        {
            errorMessage = L(@"LOGIN_RegisterPhoneNumberUsedGoStoreModify");
        }
        else
        {
			
			errorMessage = kRegisterStatusMessageRegisterPasswordError4;
            
		}
        self.errorMsg = errorMessage;
        
        [self registerDidFinish:NO userInfo:nil];
        
    }

}

- (void)parseRegisterData:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            UserInfoDTO *dto = [[UserInfoDTO alloc] init];
            
            [dto encodeFromDictionary:item];		
            
            self.userInfoDTO = 	dto;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self registerDidFinish:YES userInfo:self.userInfoDTO];
            });

        } 
    });
}


@end
