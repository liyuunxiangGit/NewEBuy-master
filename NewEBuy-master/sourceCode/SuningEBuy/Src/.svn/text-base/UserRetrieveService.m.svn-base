//
//  UserRetrieveService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserRetrieveService.h"

@interface UserRetrieveService()
{
    RetrieveMode _mode;
}

- (void)accountValidateDidFinish:(BOOL)isSuccess;

- (void)resetPasswordDidFinish:(BOOL)isSuccess;

@end

/*********************************************************************/

@implementation UserRetrieveService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(accountValidateHttpMsg);
    HTTPMSG_RELEASE_SAFELY(resetPasswordHttpMsg);
}

- (void)accountValidateWithLogonId:(NSString *)logonId 
                      retrieveMode:(RetrieveMode)mode
{
    
    _mode = mode;
    NSDictionary *postDataDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                 logonId,kRequestLoginUserId,
                                 [NSString stringWithFormat:@"%d", mode],kRequestMobileFlag,
                                 nil];
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestForgetPassword];
    
    HTTPMSG_RELEASE_SAFELY(accountValidateHttpMsg);
    
    accountValidateHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_AccountValidate];
    
    [self.httpMsgCtrl sendHttpMsg:accountValidateHttpMsg];
}

- (void)resetPasswordWithLogonId:(NSString *)logonId 
                      activeCode:(NSString *)activeCode 
                        password:(NSString *)password 
                  passwordVerify:(NSString *)passwordVerify
{
    //兼容&符号
    NSString *finalPassword = [password stringByReplacingOccurrencesOfString:@"&" withString:@"<>"];
    NSString *finalPasswordVerify = [passwordVerify stringByReplacingOccurrencesOfString:@"&" withString:@"<>"];
    
    NSDictionary *postDataDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                 logonId,kRequestLoginUserId,
                                 finalPassword,kRequestFirstLoginPassword,
                                 finalPasswordVerify,kRequestFirstLoginPasswordVerify,
                                 activeCode,kRequestFirstLoginActiveCode,
                                 nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestResetPassword];
    
    HTTPMSG_RELEASE_SAFELY(resetPasswordHttpMsg);
	
    resetPasswordHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_ResetPassword];
    
    [self.httpMsgCtrl sendHttpMsg:resetPasswordHttpMsg];

}

#pragma mark -
#pragma mark did finish request

- (void)accountValidateDidFinish:(BOOL)isSuccess
{
    if (isSuccess)
    {
        if (_delegate && [_delegate respondsToSelector:
                          @selector(accountValidateCompletedWithResult:errorMsg:)])
        {
            [_delegate accountValidateCompletedWithResult:YES errorMsg:nil];
        }
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:
                          @selector(accountValidateCompletedWithResult:errorMsg:)])
        {
            [_delegate accountValidateCompletedWithResult:NO errorMsg:self.errorMsg];
        }
    }
}

- (void)resetPasswordDidFinish:(BOOL)isSuccess
{
    if (isSuccess) {
        if (_delegate && [_delegate respondsToSelector:@selector(resetPasswordCompletedWithResult:errorMsg:)]) {
            [_delegate resetPasswordCompletedWithResult:YES errorMsg:nil];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(resetPasswordCompletedWithResult:errorMsg:)]) {
            [_delegate resetPasswordCompletedWithResult:NO errorMsg:self.errorMsg];
        }
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_AccountValidate) {
        [self accountValidateDidFinish:NO];
    }else{
        [self resetPasswordDidFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_AccountValidate) {
        
        if (receiveMsg.jasonItems == nil) 
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self accountValidateDidFinish:NO];
        }else
        {
            NSString *isSuccess = [receiveMsg.jasonItems objectForKey:@"isSuccess"];

            if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"1"])
            {
                [self accountValidateDidFinish:YES];
            }else
            {
//                NSString *errorCode = [receiveMsg.jasonItems objectForKey:kResponseHomeTopErrorCode];
//                
//                NSString *errorMsg = [receiveMsg.jasonItems objectForKey:@"errorDesc"];
//                
//                DLog(@"Request user fail, the response error is %@",errorMsg);
//                
//                if ([errorCode isEqualToString:@"532710"] || [errorCode isEqualToString:@"1008"]) 
//                {
//                    errorMsg = L(@"Mobile has not been regestered");
//                }
//                else if ([errorCode isEqualToString:@"53304"])
//                {
//                    errorMsg = L(@"Submit more than three times");
//                }
//                else if ([errorCode isEqualToString:@"53271"])
//                {
//                    errorMsg = L(@"The email is not exist");
//                }
//                else if([errorCode isEqualToString:@""]){
//                
//                    errorMsg = [receiveMsg.jasonItems objectForKey:@"errorDesc"];
//                }
////                else if([errorCode isEqualToString:@"1003"])
////                {
////                    errorMsg = @"验证码错误";
////                }
//                else if([errorCode isEqualToString:@"3"])
//                {
//                    errorMsg = @"您当日累计获取验证码已达到3次，请您次日再试！";
//                }
//                else
//                {
//                    errorMsg = L(@"Server response error");
//                }
                NSString *errorDesc = [receiveMsg.jasonItems objectForKey:@"errorDesc"];
                self.errorMsg = NotNilAndNull(errorDesc)?errorDesc:L(@"LOGIN_GetAuthCodeFail");
                
                [self accountValidateDidFinish:NO];
            }
        }
        
    }else{
        if (receiveMsg.jasonItems == nil) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self resetPasswordDidFinish:NO];
        }else{
            NSString *isSuccess = [receiveMsg.jasonItems objectForKey:@"isSuccess"];
            
            if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"1"]) {
                [self resetPasswordDidFinish:YES];
            }else{
                NSString *errorCode = [receiveMsg.jasonItems objectForKey:kResponseHomeTopErrorCode];
                
                NSString *errorMsg = [receiveMsg.jasonItems objectForKey:@"errorDesc"];
                
                DLog(@"Request password fail, the response error is %@",errorMsg);
                
                if ([errorCode isEqualToString:@"53274"] || [errorCode isEqualToString:@"1003"]) 
                {
                    errorMsg = L(@"The validate code is error");
                }
                else if (!errorCode || [errorCode isEmptyOrWhitespace]) {
                    errorMsg = L(@"Set password failed,please set again!");
                }
                
                self.errorMsg = errorMsg;
                
                [self resetPasswordDidFinish:NO];
            }
        }
    }
}

@end
