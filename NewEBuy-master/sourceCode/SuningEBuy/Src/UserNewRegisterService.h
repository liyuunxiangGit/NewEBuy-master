//
//  UserRegisterService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header      UserRegisterService
 @abstract    注册的service， 实现了登录和注销
 @author      刘坤
 @version     v1.0  12-8-22
 */

#import "DataService.h"
#import "UserInfoDTO.h"
#import "UserRegisterDTO.h"

typedef enum {
    NewRegisterTypeMobile = 1,     //手机号码
    NewRegisterTypeEmail  = 2      //电子邮箱
}NewRegisterType;                  //注册类型

@protocol UserNewRegisterServiceDelegate <NSObject>

@optional
- (void)validateRegisterCompletedWithResult:(BOOL)successfulRegist
                                  errorCode:(NSString *)errorCode
                                   userInfo:(UserInfoDTO *)userInfo;

- (void)userRegisterCompletedWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg;

- (void)getValidateCodeCompleteWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg;

- (void)validateRegisterCompletedWithResult:(BOOL)isSuccess
                                  errorCode:(NSString *)errorCode;


@end

@interface UserNewRegisterService : DataService
{
    HttpMessage     *validateRegisterHttpMsg;
    HttpMessage     *userRegisterMsg;
    HttpMessage     *getValidateHttpMsg;
}

@property (nonatomic, weak) id<UserNewRegisterServiceDelegate> delegate;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
//@property (nonatomic, assign) RegisterType registerType;
@property (nonatomic, strong) UserInfoDTO *userInfoDTO;

- (void)beginGetValidateCode:(NSString *)mobileNum;

- (void)beginValidateRegisterUsername:(NSString *)mobileNum
                             AuthCode:(NSString *)AuthCode;

- (void)beginUserRegisterWithUsername:(NSString *)mobileNum
                             password:(NSString *)password;

- (void)beginUserRegister:(UserRegisterDTO *)registerDto;

- (void)beginValidateRegisterUsername:(NSString *)username
                             password:(NSString *)password
                                 code:(NSString *)code;

@end
