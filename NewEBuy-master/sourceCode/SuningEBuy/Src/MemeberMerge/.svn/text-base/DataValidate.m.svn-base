//
//  DataValidate.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataValidate.h"


@implementation DataValidate

+ (BOOL)validatePhoneNum:(NSString *)phoneNum error:(NSString **)errorMsg
{
    if (phoneNum == nil || phoneNum.length < 11) {
        *errorMsg = L(@"UCPleaseEnter11CellphoneNumber");
        return NO;
    }
    
    NSString *mobileNoRegex = @"1[0-9]{10,10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
    BOOL validateOK = [mobileNoTest evaluateWithObject:phoneNum];

    if (!validateOK) {
        *errorMsg = kRegisterStatusMessagedRegisterIdError;
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateCard:(NSString *)cardNum
{
    NSString *mobileNoRegex = @"[0-9]{12,12}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
    return [mobileNoTest evaluateWithObject:cardNum];
}


+ (BOOL)validateCodeString:(NSString *)codeString error:(NSString **)errorMsg
{
    if(IsStrEmpty(codeString))
    {
        *errorMsg = L(@"please_firstInput_VerifyCode");
        return NO;
    }
    
    if (codeString.length < 4 || codeString.length > 10) {
        *errorMsg = L(@"Please_input_correct_VerifyNum");
        return NO;
    }
    
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:codeString]==NO) {
        *errorMsg = L(@"Please_input_correct_VerifyNum");
        return NO;
    }
    
    return YES;
}


+ (BOOL)validateEmailCode:(NSString *)codeString error:(NSString **)errorMsg
{
    if(IsStrEmpty(codeString))
    {
        *errorMsg = L(@"UCPleaseEnterValidE-mailVerificationCode");
        return NO;
    }
    
    if (codeString.length < 4 || codeString.length > 10) {
        *errorMsg = L(@"UCPleaseEnterCorrectEmailVerificationCode");
        return NO;
    }
    
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:codeString]==NO) {
        *errorMsg = L(@"UCPleaseEnterCorrectEmailVerificationCode");
        return NO;
    }
    
    return YES;    
}


+ (BOOL)validatePassWord:(NSString *)codeString error:(NSString **)errorMsg
{
    if (IsStrEmpty(codeString)) {
        *errorMsg = kLoginStatusMessageRequirePassword;
        return NO;
    }
    
    if (codeString.length < 6 || codeString.length > 20) {
        *errorMsg = kLoginStatusMessageRequirePassword1;
        return NO;
    }    
    return YES;
}

+ (BOOL)validateEmail:(NSString *)codeString error:(NSString **)errorMsg
{
    if (IsStrEmpty(codeString)) {
        *errorMsg = L(@"UCPleaseEnterYourEmailAddress");
        return NO;
    }
    
    NSString *verifyCodeRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:codeString]==NO) {
        *errorMsg = L(@"UCPleaseEnterCorrectFormatEmailAddress");
        return NO;
    }

    return YES;
}


+ (BOOL)isNumText:(NSString *)str{
    NSString * regex = @"[0-9]{1,1000}";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
    
}

@end
