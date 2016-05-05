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

typedef enum {
    RegisterTypeMobile = 1,     //手机号码
    RegisterTypeEmail  = 2      //电子邮箱
}RegisterType;                  //注册类型

@protocol UserRegisterServiceDelegate <NSObject>

@optional
- (void)userRegisterCompletedWithResult:(BOOL)successfulRegist 
                              errorCode:(NSString *)errorCode
                               userInfo:(UserInfoDTO *)userInfo;

@end

@interface UserRegisterService : DataService
{
    HttpMessage     *registerHttpMsg;
}

@property (nonatomic, weak) id<UserRegisterServiceDelegate> delegate;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) RegisterType registerType;
@property (nonatomic, strong) UserInfoDTO *userInfoDTO;


- (void)beginRegisterUsername:(NSString *)username 
					 password:(NSString *)password 
				 registerType:(RegisterType)registerType;

@end
