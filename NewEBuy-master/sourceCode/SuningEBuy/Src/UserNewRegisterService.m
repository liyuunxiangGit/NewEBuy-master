//
//  UserRegisterService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserNewRegisterService.h"
#import "UserCenter.h"
#import "ActivitySwitchService.h"
#import "SNSwitch.h"
#import <BBRSACryptor.h>
#import "GTMBase64.h"
#import "SFHFKeychainUtils.h"

//参数加密盐
#define kRegisterParamEncodeSalt  @"sn201209"
//参数加密的key
#define kRegisterParamEncodeKey   @"SNMTUserRegister"


@interface UserNewRegisterService()

- (void)registerDidFinish:(BOOL)isSuccess userInfo:(UserInfoDTO *)userInfo;

- (void)parseRegisterData:(NSDictionary *)item;

- (void)userRegisterDidFinish:(BOOL)isSuccess;

@end

/*********************************************************************/

@implementation UserNewRegisterService

@synthesize delegate = _delegate;
@synthesize userName = _userName;
@synthesize password = _password;
//@synthesize registerType = _registerType;
@synthesize userInfoDTO = _userInfoDTO;

- (void)dealloc {
    TT_RELEASE_SAFELY(_userName);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_userInfoDTO);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(userRegisterMsg);
    HTTPMSG_RELEASE_SAFELY(validateRegisterHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getValidateHttpMsg);
}

- (void)beginGetValidateCode:(NSString *)mobileNum
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [postDataDic setObject:mobileNum forKey:@"mobilenum"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"mts-web/appbuy/register/verifyphoneunique.do"];
//    NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://wappre.cnsuning.com",@"appbuy/register/verifyphoneunique.do"];
    
//    //清cookie
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
//                        cookiesForURL:[NSURL URLWithString:url]];
//    for (NSHTTPCookie *cookie in cookies)
//    {
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//    }
    
    
    HTTPMSG_RELEASE_SAFELY(getValidateHttpMsg);
    
    getValidateHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_GetValidateCode];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:getValidateHttpMsg];
}

- (void)beginValidateRegisterUsername:(NSString *)mobileNum AuthCode:(NSString *)AuthCode
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [postDataDic setObject:mobileNum forKey:@"mobilenum"];
    [postDataDic setObject:AuthCode forKey:@"authcode"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"mts-web/appbuy/register/validateauthcode.do"];
//    NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://wappre.cnsuning.com",@"appbuy/register/validateauthcode.do"];
    
    HTTPMSG_RELEASE_SAFELY(validateRegisterHttpMsg);
    
    validateRegisterHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDataDic
                                                            cmdCode:CC_ValidateRegist];
    
    [self.httpMsgCtrl sendHttpMsg:validateRegisterHttpMsg];
}

- (void)beginUserRegisterWithUsername:(NSString *)mobileNum password:(NSString *)password
{
    self.userName = mobileNum;
    self.password = password;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [postDataDic setObject:mobileNum forKey:@"mobileNum"];
    [postDataDic setObject:@"208000201003" forKey:@"accountCreatedChannel"];
    
    
    BBRSACryptor *cryptor = [[BBRSACryptor alloc] init];
    [cryptor importRSAPublicKeyBase64:kRegisterRSAPublicKey];
    NSData *data = [cryptor encryptWithPublicKeyUsingPadding:RSA_PKCS1_PADDING
                                                   plainData:[password dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *passWord = [GTMBase64 stringByEncodingData:data];
    
    [postDataDic setObject:passWord forKey:@"password"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"mts-web/appbuy/register/doregister.do"];
//    NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://wappre.cnsuning.com",@"appbuy/register/doregister.do"];
    
    HTTPMSG_RELEASE_SAFELY(userRegisterMsg);
    
    userRegisterMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_UserRegister];
    
    [self.httpMsgCtrl sendHttpMsg:userRegisterMsg];
}

- (void)beginUserRegister:(UserRegisterDTO *)registerDto
{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:9];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    NSString *sendString = @"";
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kRegisterForHttps,@"SNMTUserRegister"];
    
    if ([registerDto.actionType isEqualToString:@"reSendVerifyCode"]) {
        sendString = [NSString stringWithFormat:@"actionType=%@",registerDto.actionType];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:8];
        [dic setObject:registerDto.registerId forKey:@"registerId"];
        
        //兼容&符号
        NSString *finalPassword = [registerDto.registerPassword stringByReplacingOccurrencesOfString:@"&" withString:@"<>"];
        NSString *finalPasswordVerify = [registerDto.registerPasswordVerify stringByReplacingOccurrencesOfString:@"&" withString:@"<>"];
        
        [dic setObject:finalPassword forKey:@"registerPassword"];
        [dic setObject:finalPasswordVerify forKey:@"registerPasswordVerify"];
        [dic setObject:@"" forKey:@"imgCode"];
        [dic setObject:@"iPhone" forKey:@"client"];
        [dic setObject:@"ebuy" forKey:@"appType"];
        [dic setObject:kDownloadChannel forKey:@"channel"];
        [dic setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
        [dic setObject:registerDto.actionType forKey:@"actionType"];
        
        sendString = [sendString queryStringNoEncodeFromDictionary:dic];
        
        //清cookie
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                            cookiesForURL:[NSURL URLWithString:url]];
        for (NSHTTPCookie *cookie in cookies)
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        if ([UserCenter defaultCenter].isLogined) {
            [UserCenter defaultCenter].userInfoDTO = nil;
            [UserCenter defaultCenter].userDiscountInfoDTO = nil;
        }
        
    }
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:kRegisterParamEncodeKey
                                               salt:kRegisterParamEncodeSalt];
    
    
    [postDataDic setObject:encodeStr forKey:@"encryptMT"];
    
    HTTPMSG_RELEASE_SAFELY(userRegisterMsg);
    
    userRegisterMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_UserRegister];
	TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:userRegisterMsg];
}




- (void)beginValidateRegisterUsername:(NSString *)username password:(NSString *)password code:(NSString *)code
{
    self.userName = username;
    self.password = password;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    NSString *sendString = [NSString stringWithFormat:@"cellPhoneOfValidateCode=%@",code];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:kRegisterParamEncodeKey
                                               salt:kRegisterParamEncodeSalt];
    
    
	[postDataDic setObject:encodeStr?encodeStr:@"" forKey:@"encryptMT"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kRegisterForHttps,@"SNMTUserRegister"];
	
    HTTPMSG_RELEASE_SAFELY(validateRegisterHttpMsg);
    
    validateRegisterHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDataDic
                                                            cmdCode:CC_Register];
	TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:validateRegisterHttpMsg];
}

#pragma mark -
#pragma mark http message delegate

- (void)registerDidFinish:(BOOL)isSuccess userInfo:(UserInfoDTO *)userInfo
{
    if (isSuccess)
    {
        
        NSString *userName = self.userName;
        NSString *password = [PasswdUtil encryptString:self.password
                                                forKey:kLoginPasswdParamEncodeKey
                                                  salt:kPBEDefaultSalt];;//[NSString encryptUseDES:self.password key:kPasswordEncryptKey];
        
        [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey andPassword:userName forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
        [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey andPassword:password forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
//        [Config currentConfig].username = userName;
//        [Config currentConfig].password = password;
        if (![SNSwitch isPassportLogin]) //passport登录需要再次登录一下
        {
            [UserCenter defaultCenter].userInfoDTO = userInfo;
        }
        
        //收集用户注册id
        NSString *registerName = userInfo.logonId;
        [[SuningMainClick sharedInstance] getUserRegisterNameAndSave:registerName];
        
        
        if (_delegate &&
            [_delegate respondsToSelector:@selector(validateRegisterCompletedWithResult:errorCode:userInfo:)])
        {
            [_delegate validateRegisterCompletedWithResult:YES errorCode:nil userInfo:userInfo];
        }
    }else{
        if (_delegate &&
            [_delegate respondsToSelector:@selector(validateRegisterCompletedWithResult:errorCode:userInfo:)])
        {
            [_delegate validateRegisterCompletedWithResult:NO errorCode:self.errorMsg userInfo:userInfo];
            
        }
    }
}

- (void)userRegisterDidFinish:(BOOL)isSuccess
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(userRegisterCompletedWithResult:errorMsg:)])
    {
        [_delegate userRegisterCompletedWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)getValidateCodeDidFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getValidateCodeCompleteWithResult:errorMsg:)]) {
        [_delegate getValidateCodeCompleteWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)validateRegistDidFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(validateRegisterCompletedWithResult:errorCode:)]) {
        [_delegate validateRegisterCompletedWithResult:isSuccess errorCode:self.errorMsg];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    //    if (receiveMsg.cmdCode == CC_Register) {
    //        [self registerDidFinish:NO userInfo:nil];
    //    }
    
    if (receiveMsg.cmdCode == CC_GetValidateCode)
    {
        [self getValidateCodeDidFinished:NO];
    }
    else if (receiveMsg.cmdCode == CC_ValidateRegist)
    {
        [self validateRegistDidFinished:NO];
    }
    else if (receiveMsg.cmdCode == CC_UserRegister){
        [self userRegisterDidFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //    if (receiveMsg.cmdCode == CC_Register) {
    //
    //        if (receiveMsg.jasonItems == nil) {
    //            self.errorMsg = kHttpResponseJSONValueFailError;
    //            [self userRegisterDidFinish:NO];
    //            return;
    //        }
    //
    //        if ([receiveMsg.errorCode isEqualToString:@""]) {
    //            NSInteger userID = [[receiveMsg.jasonItems objectForKey:@"userId"] intValue];
    //
    //            if(userID<=0){
    //
    //                self.errorMsg = kRegisterStatusMessageRegisterPasswordError2;
    //                [self registerDidFinish:NO userInfo:nil];
    //            }else{
    //                [self parseRegisterData:receiveMsg.jasonItems];
    //            }
    //        }else
    //        {
    //            self.errorMsg = [receiveMsg.jasonItems objectForKey:@"errorMessage"];
    //
    //            [self registerDidFinish:NO userInfo:nil];
    //
    //        }
    //    }
    if (receiveMsg.cmdCode == CC_GetValidateCode)
    {
        if (receiveMsg.jasonItems == nil) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getValidateCodeDidFinished:NO];
            return;
        }
        if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1001"]||[[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"SUCCESS"]) {
            [self getValidateCodeDidFinished:YES];
        }
        else
        {
            if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1104"]) {
                self.errorMsg = L(@"LOGIN_SMSAuthCodeSendFailRetryGet");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1106"]) {
                self.errorMsg = L(@"LOGIN_SMSAuthCodeSendFailRetryGet");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"00001"]) {
                self.errorMsg = L(@"LOGIN_SMSAuthCodeUpLimit3Times");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"00002"]) {
                self.errorMsg = L(@"LOGIN_GetAuthCodeTooOften60Later");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"00003"]) {
                self.errorMsg = L(@"LOGIN_GetAuthCodeTooOftenRetryLater");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"E4700A09"]) {
                self.errorMsg = L(@"LOGIN_PhoneNumberModeWrongReInput");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"E4700A44"]) {
                self.errorMsg = L(@"LOGIN_SensitiveWord");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"E4700B09"]) {
                self.errorMsg = L(@"LOGIN_UserNameFormatWrongReInput");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"E4700A08"]) {
                self.errorMsg = L(@"LOGIN_Format_MailBox");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"E4700012"]) {
                self.errorMsg = L(@"LOGIN_SystemBusyRetryLater");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"E4700000"]) {
                self.errorMsg = L(@"LOGIN_SystemBusyRetryLater");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"ISEXIT"]) {
                self.errorMsg = L(@"LOGIN_RegisterPhoneNumberUsed");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"FAIL"]) {
                self.errorMsg = L(@"LOGIN_GetAuthCodeFail");
            }
            else
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
            }
            
            [self getValidateCodeDidFinished:NO];
        }
    }
    else if (receiveMsg.cmdCode == CC_ValidateRegist)
    {
        if (receiveMsg.jasonItems == nil) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self validateRegistDidFinished:NO];
            return;
        }
        if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1002"]) {
            [self validateRegistDidFinished:YES];
        }
        else
        {
            if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1101"]) {
                self.errorMsg = L(@"LOGIN_CheckAuthCodeFail");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1103"]) {
                self.errorMsg = L(@"LOGIN_CheckAuthCodeUpToWrongTimes");
            }
            else if ([[receiveMsg.jasonItems objectForKey:@"returnCode"] isEqualToString:@"1107"]) {
                self.errorMsg = L(@"LOGIN_CheckAuthCodeFail");
            }
            
            [self validateRegistDidFinished:NO];
        }
    }
    else if (receiveMsg.cmdCode == CC_UserRegister){
        
        
        if (receiveMsg.jasonItems == nil) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self userRegisterDidFinish:NO];
            return;
        }
        if ([[receiveMsg.jasonItems objectForKey:@"returnStatus"] isEqualToString:@"COMPLETE"]) {
            
            NSString *userName = self.userName;
            NSString *password = [PasswdUtil encryptString:self.password
                                                    forKey:kLoginPasswdParamEncodeKey
                                                      salt:kPBEDefaultSalt];
            [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey andPassword:userName forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
            [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey andPassword:password forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
//            [Config currentConfig].username = userName;
//            [Config currentConfig].password = password;
            //收集用户注册id
            [[SuningMainClick sharedInstance] getUserRegisterNameAndSave:userName];
            [self userRegisterDidFinish:YES];
        }else{
            self.errorMsg = [receiveMsg.jasonItems objectForKey:@"returnMessage"];
            [self userRegisterDidFinish:NO];
        }
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
