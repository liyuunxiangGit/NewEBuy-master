//
//  ValidationService.m
//  SuningEBuy
//
//  Created by shasha on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ValidationService.h"

@implementation ValidationService

+ (BOOL)checkBoardPersonName:(NSString *)name
{
    if ([name length] >= 2 && [name length] <= 10)
    {
        NSString *regex = [NSString stringWithFormat:@"[\\u4e00-\\u9fa5a-zA-Z/]{2,10}"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if ([predicate evaluateWithObject:name])
        {
            return YES;
        }
        
        return NO;
    }
    return NO;
}


+ (NSError *)chineseChecking:(NSString *)chinese Frome:(NSInteger)minBit To:(NSInteger)maxBit{
    
    if (!chinese  || [chinese isEmptyOrWhitespace]) 
    {
         return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Null", kValidationErrorDesc_Key);  
    }
    
    NSString *ChineseRegex = [NSString stringWithFormat:@"[\\u4e00-\\u9fa5]{%d,%d}",minBit,maxBit] ;
    NSPredicate *ChineseTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ChineseRegex];
    
   if ([ChineseTest evaluateWithObject:chinese] == NO) {
       
       return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key);
       
    }
    
    return  ErrorWithSuccessInfo(kValidationSuccess);

}


+ (NSError *)NumOrCharacterChecking:(NSString *)checkedString {
    
    //非空检查
    if ( IsNilOrNull(checkedString)||[checkedString isEmptyOrWhitespace]) {
        
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Null", kValidationErrorDesc_Key);     
    }
    
    //字母与数字的集合检查
     NSString *codeRegex = @"[A-Za-z0-9]+"; 
    
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    if ([codeTest evaluateWithObject:checkedString] == NO) {
                
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key); 
        
    }
    
    return  ErrorWithSuccessInfo(kValidationSuccess);

}


+ (NSError *)phoneNumChecking:(NSString *)checkedString{
   //非空检查 
    if (IsNilOrNull(checkedString)) {
        
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Null", kValidationErrorDesc_Key);
  
        
    }else if ([checkedString length] != 11){
    //位数为11位，并且首位为1的合法性检查
         return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Length", kValidationErrorDesc_Key); 

    }else if ([checkedString characterAtIndex:0] != '1')
    {
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key);
    }
    return  ErrorWithSuccessInfo(kValidationSuccess);

}


+ (NSError *)NumAndCharacterChecking:(NSString *)checkingString  minBit:(NSInteger)minBit maxBit:(NSInteger)maxBit
{
    /*
     "Password_Not_Null"="密码不能为空，请输入6-20位数字和字母的合集";
     "PassWord_Not_valide"="密码不合法，请输入6-20位数字和字母的合集";
     "Length_Wrong"="密码不合法，请输入6-20位数字和字母的合集";
     */
    if (!checkingString || [checkingString isEmptyOrWhitespace]) 
    {
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Null", kValidationErrorDesc_Key);
        
    }
    
    NSString *passWordRegex = [NSString stringWithFormat:@"(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{%d,%d}$",minBit,maxBit]  ;
    
    NSPredicate *passWordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    //是否为数字和字母的合集的验证
    if ([passWordTest evaluateWithObject:checkingString]==NO) {
       
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key);
        }
    
    //位数的验证 
    
    if ([checkingString length]<minBit||[checkingString length]>maxBit) {
        
       return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key); 
    }
    
    return  ErrorWithSuccessInfo(kValidationSuccess);    
}


//验证身份证是否是18位，且最后一位是数字或者X
//@"Error_NotValide":身份证格式不正确
//@"Error_Length":身份证位数不正确
+ (NSError *)valideIdentifyCard:(NSString *)identifyString
{
    if (IsNilOrNull(identifyString)|| [identifyString isEmptyOrWhitespace]) 
    {
        return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Null", kValidationErrorDesc_Key);  
    }
    
    if ([identifyString length]!=18) {
        if ([identifyString length]==15) {
            
            //字母与数字的集合检查
            NSString *codeRegex = @"[0-9]+"; 
            
            NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
            
            if ([codeTest evaluateWithObject:identifyString] == NO) {
                
                 return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key); 
                
            }

            return  ErrorWithSuccessInfo(kValidationSuccess);
            
        }else{
            
             return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_Length", kValidationErrorDesc_Key); 
        }
        
    }else{
        
        NSString *identifyRegex = @"\\d{17}(X|x)|\\d{18}";
        
        NSPredicate *identifyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", identifyRegex];
        
        if ([identifyTest evaluateWithObject:identifyString]==NO) {
            
             return ErrorWithErrorCodeAndDesc(kValidationFail, @"Error_NotValide", kValidationErrorDesc_Key); 
        }
    }
        
    
    return  ErrorWithSuccessInfo(kValidationSuccess);
     
}

@end
