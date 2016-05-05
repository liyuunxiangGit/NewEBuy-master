//
//  UserService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      UserLoginService
 @abstract    登录注销的service， 实现了登录和注销
 @author      刘坤
 @version     v1.0.002  12-8-29
 */

#import "DataService.h"
#import "UserInfoDTO.h"
#import "PasswdUtil.h"
#define kUserNameEncryptKey     @"sn_usr"
#define kPasswordEncryptKey     @"sn_psd"

@protocol UserLoginServiceDelegate <NSObject>

//登录完成回调
@optional
- (void)userLoginCompletedWithResult:(BOOL)successfulLogin
                           errorCode:(NSString *)errorCode;

// xzoscar 2014-07-22 add 回调 区分错误码和错误描述
- (void)userLoginCompletedWithResult:(BOOL)successfulLogin
                           errorCode:(NSString *)errorCode
                           errorDesc:(NSString *)errorDesc;

//注销完成回调

- (void)userLogoutCompletedWithResult:(BOOL)successfulLogout
                            errorCode:(NSString *)errorCode;

@end



@interface UserLoginService : DataService
{
    HttpMessage    *loginHttpMsg;
    HttpMessage    *logoutHttpMsg;
}

@property (nonatomic, weak) id<UserLoginServiceDelegate> delegate;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) UserInfoDTO *userInfoDTO;
@property (nonatomic, assign) BOOL    bNeedverifyCode;//passport方式下，是否需要图片验证码
//登录
- (void)beginLoginWithUsername:(NSString *)username
                      password:(NSString *)password;
- (void)beginLoginWithUsername:(NSString *)username
                      password:(NSString *)password verifyCode:(NSString *)verifycode;//用于passport方式验证码登陆

- (void)beginGetUserInfo;//在wap页面中登录,回调走userLoginCompletedWithResult
//注销
- (void)beginLogout;

- (void)beginPassportLogout;//passport注销
@end
