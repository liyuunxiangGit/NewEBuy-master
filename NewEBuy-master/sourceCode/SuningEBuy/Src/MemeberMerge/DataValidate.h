//
//  DataValidate.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataValidate : NSObject

//手机校验
+ (BOOL)validatePhoneNum:(NSString *)phoneNum error:(NSString **)errorMsg;
//手机验证码校验
+ (BOOL)validateCodeString:(NSString *)codeString error:(NSString **)errorMsg;
//邮箱验证码校验
+ (BOOL)validateEmailCode:(NSString *)codeString error:(NSString **)errorMsg;
//登录密码校验
+ (BOOL)validatePassWord:(NSString *)codeString error:(NSString **)errorMsg;
//邮箱校验
+ (BOOL)validateEmail:(NSString *)codeString error:(NSString **)errorMsg;
//12数字登录名
+ (BOOL)validateCard:(NSString *)cardNum;
//纯数字
+ (BOOL)isNumText:(NSString *)str;
@end

