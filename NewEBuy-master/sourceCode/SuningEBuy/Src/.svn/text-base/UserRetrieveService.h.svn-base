//
//  UserRetrieveService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      UserRetrieveService
 @abstract    找回密码的service， 实现了发送验证码请求和找回密码请求
 @author      刘坤
 @version     v1.0  12-8-22
 */

#import "DataService.h"

@protocol UserRetrieveServiceDelegate <NSObject>

@optional
- (void)accountValidateCompletedWithResult:(BOOL)isSuccess 
                                  errorMsg:(NSString *)errorMsg;

- (void)resetPasswordCompletedWithResult:(BOOL)isSuccess 
                                errorMsg:(NSString *)errorMsg;

@end

@interface UserRetrieveService : DataService
{
    HttpMessage     *accountValidateHttpMsg;
    HttpMessage     *resetPasswordHttpMsg;
}

@property (nonatomic, weak) id<UserRetrieveServiceDelegate> delegate;

//忘记密码
- (void)accountValidateWithLogonId:(NSString *)logonId
                      retrieveMode:(RetrieveMode)mode;

//重置密码
- (void)resetPasswordWithLogonId:(NSString *)logonId 
                      activeCode:(NSString *)activeCode 
                        password:(NSString *)password 
                  passwordVerify:(NSString *)passwordVerify;
@end
