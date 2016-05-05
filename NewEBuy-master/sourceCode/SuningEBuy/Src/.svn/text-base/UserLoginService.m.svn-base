//
//  UserService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserLoginService.h"
#import "UserCenter.h"
#import "PasswdUtil.h"
#import "LoginCouponCommand.h"
//#import "XMPPComponent.h"
//#import "ContactsManagement.h"
//#import "DBOperation.h"
//#import "XMPPComponent.h"
//#import "SessionModelManage.h"
//#import "Folder.h"
//#import "IMUserEnity.h"
//#import "SNSwitch.h"
//#import "MessageCallBackManage.h"
#import "SFHFKeychainUtils.h"
#import "SNSwitch.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "OpenUDID.h"
//参数加密盐
#define kLogonParamEncodeSalt  @"sn201209"
//参数加密的key
#define kLogonParamEncodeKey   @"SNMTLogon"

@interface UserLoginService()

- (void)loginDidFinish:(BOOL)isSuccess;
- (void)logoutDidFinish:(BOOL)isSuccess;

- (void)parseLoginItem:(NSDictionary *)item;

@end

/*********************************************************************/

@implementation UserLoginService

@synthesize delegate = _delegate;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize userInfoDTO = _userInfoDTO;

- (void)dealloc {
    TT_RELEASE_SAFELY(_userName);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_userInfoDTO);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(loginHttpMsg);
    HTTPMSG_RELEASE_SAFELY(logoutHttpMsg);
}

- (BOOL)isASCIIString:(NSString *)string
{
    NSUInteger length = [string length];
    NSUInteger byteLen = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (length == byteLen) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)isNewLoginAciton
{
    return NO;
//    return [SNSwitch isYunXinON];
}

- (void)beginLoginWithUsername:(NSString *)username
                      password:(NSString *)password
{
    self.userName = username;
    self.password = password;
    
    NSString *finalPassword = [password stringByReplacingOccurrencesOfString:@"&" withString:@"<>"];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setObject:finalPassword?finalPassword:@"" forKey:@"logonPassword"];
    [dic setObject:@"iPhone" forKey:@"client"];
    [dic setObject:@"ebuy" forKey:@"appType"];
    [dic setObject:kDownloadChannel forKey:@"channel"];
    [dic setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
    NSString *sendString = @"";
    sendString = [sendString queryStringNoEncodeFromDictionary:dic];
    DLog(@"xxxxxx %@",sendString);
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:kLogonParamEncodeKey
                                               salt:kLogonParamEncodeSalt];
    
    NSString *url = @"";
    if ([self isNewLoginAciton]) {
//        [postDataDic setObject:@"6001396504"forKey:@"userId"];
        NSString *encodeUsername =  [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     	[postDataDic setObject:!IsStrEmpty(username)?encodeUsername:@"" forKey:@"userId"];
        [postDataDic setObject:encodeStr forKey:@"password"];
        url = [NSString stringWithFormat:@"%@/%@",kHostSuningMobtsHttps, @"user/login.do"];
    }else{
        NSString *encodeUsername =  [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [postDataDic setObject:!IsStrEmpty(username)?encodeUsername:@"" forKey:@"logonId"];
        [postDataDic setObject:encodeStr forKey:@"data"];
        url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, @"SNMTLogon"];
    }
    
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    HTTPMSG_RELEASE_SAFELY(loginHttpMsg);
    
    loginHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:postDataDic
                                                 cmdCode:CC_Login];
    
    //清cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                        cookiesForURL:[NSURL URLWithString:url]];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    if ([UserCenter defaultCenter].isLogined) {
        [[UserCenter defaultCenter] clearUserInfo];
    }
    
	[self.httpMsgCtrl sendHttpMsg:loginHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

- (void)beginGetUserInfo
{
    
    NSDictionary *postDataDic = @{kHttpRequestHomeStoreKey: kHttpRequestHomeStoreValue};
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, @"SNiPhoneAppLogonCouponView"];
    HTTPMSG_RELEASE_SAFELY(loginHttpMsg);

    loginHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:postDataDic
                                                 cmdCode:CC_Login];
    
	[self.httpMsgCtrl sendHttpMsg:loginHttpMsg];
}

/*  示例
 https://passportpre.cnsuning.com/ids/login?jsonViewType=true?uuid=abc123456789011&username=12121212147&password=yinle123&verifyCode=&loginTheme=b2c&service=https://memberpre.cnsuning.com/webapp/wcs/stores/auth?targetUrl=https://b2cpre.cnsuning.com/emall/SNiPhoneAppLogonCouponViewpp?storeId=10052
 
 */
- (void)beginLoginWithUsername:(NSString *)username
                      password:(NSString *)password verifyCode:(NSString *)verifycode
{
    self.userName = username;
    self.password = password;
    NSString *uuid = [OpenUDID value];
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [postDataDic setObject:@"true" forKey:@"jsonViewType"];
    [postDataDic setObject:uuid forKey:@"uuid"];
    [postDataDic setObject:username?username:@"" forKey:@"username"];
    [postDataDic setObject:self.password?self.password:@"" forKey:@"password"];
    [postDataDic setObject:verifycode?verifycode:@"" forKey:@"verifyCode"];
    [postDataDic setObject:@"b2c" forKey:@"loginTheme"];
    [postDataDic setObject:@"208000201003" forKey:@"loginChannel"];
    
//    NSString *strService = [NSString stringWithFormat:@"https://memberpre.cnsuning.com/webapp/wcs/stores/auth?targetUrl=https://b2cpre.cnsuning.com/emall/SNiPhoneAppLogonCouponViewpp?%@=%@",kHttpRequestHomeStoreKey, kHttpRequestHomeStoreValue];
    NSString *strService = [NSString stringWithFormat:@"%@?targetUrl=%@?%@=%@", kPassportLoginParamService, kPassportLoginParamTargetUrl, kHttpRequestHomeStoreKey, kHttpRequestHomeStoreValue];
    

    [postDataDic setObject:strService forKey:@"service"];
    
//    NSString *url = [NSString stringWithFormat:@"%@",@"https://passportpre.cnsuning.com/ids/login"];
    NSString *url = [NSString stringWithFormat:@"%@", kPassportLoginUrl];
    
    HTTPMSG_RELEASE_SAFELY(loginHttpMsg);
    
    loginHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:postDataDic
                                                 cmdCode:CC_Login];
    //清cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                        cookiesForURL:[NSURL URLWithString:url]];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    if ([UserCenter defaultCenter].isLogined) {
        [[UserCenter defaultCenter] clearUserInfo];
    }
    
	[self.httpMsgCtrl sendHttpMsg:loginHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);

}


- (void)beginLogout
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	NSString *url = @"";
    if ([self isNewLoginAciton]) {
        [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.custNum?[UserCenter defaultCenter].userInfoDTO.custNum:@"" forKey:@"custNum"];
        [postDataDic setObject:[UserCenter defaultCenter].token forKey:@"token"];
        url = [NSString stringWithFormat:@"%@/%@",kHostSuningMobtsHttps,@"user/logout.do"];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, kHttpRequestLogoutHome];
    }
	
    HTTPMSG_RELEASE_SAFELY(logoutHttpMsg);
    
    logoutHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                               requestUrl:url
                                              postDataDic:postDataDic
                                                  cmdCode:CC_Logout];
    logoutHttpMsg.requestMethod = RequestMethodGet;
	[self.httpMsgCtrl sendHttpMsg:logoutHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginPassportLogout
{
      NSString *url = [NSString stringWithFormat:@"%@?%@",kPassportLogout,@"jsonViewType=true"];
//    NSString *url = [NSString stringWithFormat:@"%@",kPassportLogout];
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
//    NSString *oldLogoutUrl = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, kHttpRequestLogoutHome];
//    [postDataDic setObject:oldLogoutUrl forKey:@"service"];
//    [postDataDic setObject:@"true" forKey:@"jsonViewType"];
//    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    HTTPMSG_RELEASE_SAFELY(logoutHttpMsg);
    
//    logoutHttpMsg = [[HttpMessage alloc] initWithDelegate:self
//                                               requestUrl:url
//                                              postDataDic:postDataDic
//                                                  cmdCode:CC_Logout];
    logoutHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                               requestUrl:url
                                              postDataDic:nil
                                                  cmdCode:CC_Logout];
	[self.httpMsgCtrl sendHttpMsg:logoutHttpMsg];
}

#pragma mark -
#pragma mark custom method

#pragma mark－ 登录 回调
// 登录 回调
- (void)loginDidFinish:(BOOL)isSuccess
{
    if (isSuccess)
    {
        //登录成功，清空需要验证码标示 chupeng 2014-5-21
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"needVerifyCode"];
        
        if ([SNSwitch isSuningBISDKOn]) {
            [SSAIOSSNDataCollection LoginNameCollection:kAppName channel:kDownloadChannelNum loginName:self.userInfoDTO.logonId];
            
            [SSAIOSSNDataCollection MemberIdCollect:self.userInfoDTO.memberCardNo];
            
        }
        NSString *userName = self.userName;
        NSString *password = self.password;//[NSString encryptUseDES:self.password key:kPasswordEncryptKey];
        
        NSString *passwd = [PasswdUtil encryptString:password
                                                forKey:kLoginPasswdParamEncodeKey
                                                  salt:kPBEDefaultSalt];

        [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey andPassword:userName forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
        [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey andPassword:passwd forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
//        [Config currentConfig].username = userName;
//        [Config currentConfig].password = password;
        
        
        [UserCenter defaultCenter].userInfoDTO = self.userInfoDTO;
        
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
        
        NSDictionary *cookieProperties = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        suningCookieDomain, NSHTTPCookieDomain,
                                        suningCookieDomain, NSHTTPCookieOriginURL,
                                        @"/", NSHTTPCookiePath,
                                        @"userId", NSHTTPCookieName,
                                        self.userInfoDTO.userId, NSHTTPCookieValue, nil];
        NSHTTPCookie *versionCodeCookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:versionCodeCookie];
        
        
        NSDictionary *cookieProperties2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          suningCookieDomain, NSHTTPCookieDomain,
                                          suningCookieDomain, NSHTTPCookieOriginURL,
                                          @"/", NSHTTPCookiePath,
                                          @"logonId", NSHTTPCookieName,
                                          self.userInfoDTO.logonId, NSHTTPCookieValue, nil];
        NSHTTPCookie *versionCodeCookie2 = [NSHTTPCookie cookieWithProperties:cookieProperties2];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:versionCodeCookie2];

        
        NSDictionary *cookieProperties3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                           suningCookieDomain, NSHTTPCookieDomain,
                                           suningCookieDomain, NSHTTPCookieOriginURL,
                                           @"/", NSHTTPCookiePath,
                                           @"memberId", NSHTTPCookieName,
                                           self.userInfoDTO.custNum, NSHTTPCookieValue, nil];
        NSHTTPCookie *versionCodeCookie3 = [NSHTTPCookie cookieWithProperties:cookieProperties3];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:versionCodeCookie3];

        
        if ([self isNewLoginAciton]) {
            
            [self saveUserData];
            [self firstGetMessage];
            //xmpp login
//            [self xmppLogin];
        }
        LoginCouponCommand *manage =
        [[LoginCouponCommand alloc] initWithUserId:self.userInfoDTO.userId];
        [CommandManage excuteCommand:manage completeBlock:nil];
        
        
        if (nil != _delegate) { // xzoscar 2014-07-22 11:45 modify
            if ([_delegate respondsToSelector:@selector(userLoginCompletedWithResult:errorCode:)]) {
                [_delegate userLoginCompletedWithResult:YES
                                              errorCode:self.errorMsg];
            }else if ([_delegate respondsToSelector:@selector(userLoginCompletedWithResult:errorCode:errorDesc:)]) {
                [_delegate userLoginCompletedWithResult:YES
                                              errorCode:self.errCode
                                              errorDesc:self.errorMsg];
            }
        }
    }
    else
    {
        if (nil != _delegate) { // xzoscar 2014-07-22 11:45 modify
            if ([_delegate respondsToSelector:@selector(userLoginCompletedWithResult:errorCode:)]) {
                [_delegate userLoginCompletedWithResult:NO
                                              errorCode:self.errorMsg];
            }else if ([_delegate respondsToSelector:@selector(userLoginCompletedWithResult:errorCode:errorDesc:)]) {
                [_delegate userLoginCompletedWithResult:NO
                                              errorCode:self.errCode
                                              errorDesc:self.errorMsg];
            }
        }
    }
}

- (void)saveUserData
{
    //IM 保存的个人信息
//    IMUserEnity *usereneity = [[IMUserEnity alloc] init];
//    usereneity.ID = self.userInfoDTO.custNum;
//    usereneity.nickName = [UserCenter defaultCenter].userInfoDTO.nickName;
//    usereneity.impinfoIP = [UserCenter defaultCenter].impInfo.ipInfo;
//    usereneity.impinfoPort = [UserCenter defaultCenter].impInfo.portInfo;
//    usereneity.cabinfoIP = [UserCenter defaultCenter].cabInfo.ipInfo;;
//    usereneity.cabinfoPort = [UserCenter defaultCenter].cabInfo.portInfo;
//    usereneity.ofsinfoIP = [UserCenter defaultCenter].ofsInfo.ipInfo;
//    usereneity.ofsinfoPort = [UserCenter defaultCenter].ofsInfo.portInfo;;
//    usereneity._token = [UserCenter defaultCenter].token;
//    
//    NSString *userType = [UserCenter defaultCenter].userType;
//    if (!IsStrEmpty(userType)) {
//        usereneity.accountType = [userType intValue];
//    }
//    
//    [[Common sharedManager] setM_IMUserEnity:usereneity];
    
}

- (void)firstGetMessage
{
    
}

- (void)xmppLogin
{
//    //创建文件
//    [[Folder folderObject] createAccountFolder:[[Common  sharedManager] getCurrentUser]];
//    //创建数据库
//    [[DBOperation shareDBObject] openDB:[[Common  sharedManager] getCurrentUser]];
    
//    [[MessageCallBackManage shareMessageCallBackManage] getLocalFriend];
//    
//    //初始化sessionmodelmanage单利
//    [SessionModelManage shareSessionModelManage];
//    //更新grouplist，add by 陶澄
//    [[SessionModelManage shareSessionModelManage] loginGetSession];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_XMPP_LOGIN_SUCCESS_INITVIEW object:nil];
//    //IM LOGIN XMPP
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_VIEW_DISMISSED object:nil];
//    //移除XMPP通知（防止重复监听）
//    NoticeRemove(self,NOTIFICATION_XMPP_LOGIN_SUCCESS)
//    //开始XMPP连接
//    [[XMPPComponent sharedManager] startConnect];
}

- (void)logoutDidFinish:(BOOL)isSuccess
{
//    [[XMPPComponent sharedManager] cleanConfiguration];
    
//    [Config currentConfig].password = nil;
    [SFHFKeychainUtils deleteItemForUsername:kSuningLoginPasswdKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    [[UserCenter defaultCenter] clearUserInfo];
//    [[DBOperation shareDBObject] closeDB];
//    [SessionModelManage shareSessionModelManage]._currentChatID = 0;
//    [SessionModelManage shareSessionModelManage]._sessionModelArray = nil;
//    [SessionModelManage shareSessionModelManage]._sessionModelArray = [NSMutableArray array];
    
    if (isSuccess) {
        if (![[Config currentConfig].savePassword boolValue]) {
            [SFHFKeychainUtils deleteItemForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
//            [Config currentConfig].username = nil;
        }
        if ([SNSwitch isSuningBISDKOn]) {
            [SSAIOSSNDataCollection LoginNameCollection:kAppName channel:kDownloadChannelNum loginName:@""];
        }
        DLog(@"Logout Ok!");
        if (_delegate && [_delegate respondsToSelector:@selector(userLogoutCompletedWithResult:errorCode:)]) {
            [_delegate userLogoutCompletedWithResult:YES errorCode:nil];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(userLogoutCompletedWithResult:errorCode:)]) {
            [_delegate userLogoutCompletedWithResult:NO errorCode:self.errorMsg];
        }
    }
}

#pragma mark -
#pragma mark httpMessage delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_Login) {
        [self loginDidFinish:NO];
    }else{
        [self logoutDidFinish:NO];
    }
}

#pragma mark - 登录 接收数据完成－－－

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_Login) {
        
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self loginDidFinish:NO];
            return;
        }
        if ([self isNewLoginAciton]) {
            NSString *success = [item objectForKey:@"successFlg"];
            NSDictionary *b2cinfo = [item objectForKey:@"b2cinfo"];
            if ([success isEqualToString:@"1"])
            {
                NSString *userId = [b2cinfo objectForKey:@"userId"];
                if ([userId intValue] <= 0)
                {
                    self.errorMsg = kLoginStatusMessagePasswordError;
                    [self loginDidFinish:NO];
                }else
                {
                    [UserCenter defaultCenter].token = [item objectForKey:@"token"];
                    [UserCenter defaultCenter].userType = [item objectForKey:@"userType"];
                    

                    
                    NSDictionary *cabinfo = [item objectForKey:@"cabinfo"];
                    IPInfoDTO *cabDto = [[IPInfoDTO alloc] init];
                    [cabDto encodeFromDictionary:cabinfo];
                    [UserCenter defaultCenter].cabInfo  = cabDto;
                    
                    NSDictionary *impinfo = [item objectForKey:@"impinfo"];
                    IPInfoDTO *impDto = [[IPInfoDTO alloc] init];
                    [impDto encodeFromDictionary:impinfo];
                    [UserCenter defaultCenter].impInfo  = impDto;
                    
                    NSDictionary *ofsinfo = [item objectForKey:@"ofsinfo"];
                    IPInfoDTO *ofsDto = [[IPInfoDTO alloc] init];
                    [ofsDto encodeFromDictionary:ofsinfo];
                    [UserCenter defaultCenter].ofsInfo  = ofsDto;
                    
                    [self parseLoginItem:b2cinfo];
                }
                
            }else
            {
                NSString *errorMessage = [b2cinfo objectForKey:@"errorMessage"];
                if (IsStrEmpty(errorMessage)) {
                    errorMessage = [item objectForKey:@"errorMsg"];
                }
                self.errorMsg = IsStrEmpty(errorMessage)?L(@"LOGIN_ERROR_DEFAULT"):errorMessage;
                [self loginDidFinish:NO];
            }
        }
        else{
            if ([receiveMsg.errorCode isEqualToString:@""])
            {
                NSString *userId = [receiveMsg.jasonItems objectForKey:@"userId"];
                if ([userId intValue] <= 0)
                {
                    self.errorMsg = kLoginStatusMessagePasswordError;
                    [self loginDidFinish:NO];
                }else
                {
                    [self parseLoginItem:receiveMsg.jasonItems];
                }
            }
            else
            {
                if ([SNSwitch isPassportLogin]) { // {{{
                    
                    if (NotNilAndNull([receiveMsg.jasonItems objectForKey:@"needVerifyCode"])) {
                        NSNumber *bNeed = (NSNumber *)[receiveMsg.jasonItems objectForKey:@"needVerifyCode"];
                        if ([bNeed boolValue]) {
                            self.bNeedverifyCode = YES;
                        } else {
                            self.bNeedverifyCode = NO;
                        }
                    }
                    
                    NSNumber *remainTimes;
                    if (NotNilAndNull([receiveMsg.jasonItems objectForKey:@"remainTimes"])) {
                         remainTimes = (NSNumber *)[receiveMsg.jasonItems objectForKey:@"remainTimes"];
                    }

                    [self parseErrorCode:receiveMsg.errorCode andRemainTimes:remainTimes];
                    
                    [self loginDidFinish:NO];
                }
                else
                {
                    NSString *errorMessage = [receiveMsg.jasonItems objectForKey:@"errorMessage"];
                    self.errorMsg = IsStrEmpty(errorMessage)?L(@"LOGIN_ERROR_DEFAULT"):errorMessage;
                    [self loginDidFinish:NO];
                }
            }// }}}
        }
        
    }
    else
    {
        if ([self isNewLoginAciton])
        {
            if ([[item objectForKey:@"successFlg"] isEqualToString:@"1"]) {
                [self logoutDidFinish:YES];
            }else{
                [self logoutDidFinish:NO];
            }
        }else{
            [self logoutDidFinish:YES];
        }
    }
}

- (void)parseLoginItem:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            UserInfoDTO *dto = [[UserInfoDTO alloc] init];
            
            [dto encodeFromDictionary:item];
            
            self.userInfoDTO = dto;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loginDidFinish:YES];
            });
            
        } 
    });
    
}

- (void)parseErrorCode:(NSString *)errorcode andRemainTimes:(NSNumber *)remainTimes
{
    
    /*
    // 线下会员融合，新增字段处理
    // xzoscar 2014-07-21 11:20:00 modify
    // 新增 errorCode(E4700N07,E4700N11,E4700464,E4700000,E4700487)
    // Desc: 把错误码 通过回调 带出
    */
    
    self.errCode = errorcode; // xzoscar 2014-07-22 add （线下会员融合需要 根据错误码 跳转下个页面）
    
    if ([errorcode isEqualToString:@"E4700N07"]) {
        [self setErrorMsg:L(@"UCMobilePhoneNumberHaveMultipleMembership")];
    }else if ([errorcode isEqualToString:@"E4700N11"]) {
        [self setErrorMsg:L(@"UCGroupMemberMobilePhoneCannotLogin")];
    }else if ([errorcode isEqualToString:@"E4700487"]) {
        [self setErrorMsg:L(@"UCNonPersonalMemberCardCannotBoundEBuy")];
    }else if ([errorcode isEqualToString:@"E4700A40"]) {
        self.errorMsg = L(@"LOGIN_ERROR_E4700A40");
    }else if ([errorcode isEqualToString:@"E4700440"]) {
        self.errorMsg = L(@"LOGIN_ERROR_E4700440");
    }else if ([errorcode isEqualToString:@"E4700451"]) {
        self.errorMsg = L(@"LOGIN_ERROR_E4700451");
    }else if ([errorcode isEqualToString:@"E4700464"]) {
        //self.errorMsg = L(@"LOGIN_ERROR_E4700464");
        [self setErrorMsg:L(@"UCAbnormalData")];
    }
    else if ([errorcode isEqualToString:@"E4700A37"]) {
        self.errorMsg = L(@"LOGIN_ERROR_E4700A37");
        
    }
    else if ([errorcode isEqualToString:@"E4700480"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_E4700480");
    }
    else if ([errorcode isEqualToString:@"E4700000"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_E4700000");
    }
    else if ([errorcode isEqualToString:@"E4700013"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_E4700013");
    }
    else if ([errorcode isEqualToString:@"E4700450"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_E4700450");
    }
    else if ([errorcode isEqualToString:@"E4700443"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_E4700443");
    }
    else if ([errorcode isEqualToString:@"serviceNotAvailable"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_serviceNotAvailable");
    }
    else if ([errorcode isEqualToString:@"badPassword.msg1"]
             || [errorcode isEqualToString:@"E4700456"])// ???
    {
        if (nil != remainTimes) {
            int iRemain = [remainTimes intValue];
            if (iRemain <= 3)
            {
                self.errorMsg = [NSString stringWithFormat:L(@"LOGIN_ERROR_badPassword.msg2"), [remainTimes intValue]];
            }else {
                 self.errorMsg = L(@"LOGIN_ERROR_badPassword.msg1");
            }
        }
        else {
            self.errorMsg = L(@"LOGIN_ERROR_badPassword.msg1");
        }
    }
    else if ([errorcode isEqualToString:@"badPassword.msg2"])
    {
        int iRemain = [remainTimes intValue];
        if (iRemain <= 3)
        {
            self.errorMsg = [NSString stringWithFormat:L(@"LOGIN_ERROR_badPassword.msg2"), [remainTimes intValue]];
        }
        else
        {
            self.errorMsg = L(@"LOGIN_ERROR_badPassword.msg1");
        }
    }
    else if ([errorcode isEqualToString:@"badVerifyCode"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_badVerifyCode");
    }
    else if ([errorcode isEqualToString:@"lockedByManual"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_lockedByManual");
    }
    else if ([errorcode isEqualToString:@"lockedBySystem"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_lockedBySystem");
    }
    else if ([errorcode isEqualToString:@"needVerifyCode"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_needVerifyCode");
        
        //需要验证码错误，记录状态，跳手动登录直接展示验证码框 by chupeng
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"needVerifyCode"];
    }
    else if ([errorcode isEqualToString:@"unsupportedCredentials"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_unsupportedCredentials");
    }
    else if ([errorcode isEqualToString:@"uncategorized"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_uncategorized");
    }
    else if ([errorcode isEqualToString:@"badPwdOfNotBindingMemberCard.msg1"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_badPwdOfNotBindingMemberCard.msg1");
    }
    else if ([errorcode isEqualToString:@"badPwdOfNotBindingMemberCard.msg2"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_badPwdOfNotBindingMemberCard.msg2");
    }
    else if ([errorcode isEqualToString:@"notOnlineMember"])
    {
        self.errorMsg = L(@"LOGIN_ERROR_notOnlineMember");
    }
    else
    {
        self.errorMsg = L(@"LOGIN_ERROR_DEFAULT");
    }
}

@end
