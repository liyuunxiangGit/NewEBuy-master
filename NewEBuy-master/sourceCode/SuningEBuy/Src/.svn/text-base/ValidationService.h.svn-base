//
//  ValidationService.h
//  SuningEBuy
//
//  Created by shasha on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
	
/*!
 
 @header   ValidationService
 @abstract 字符串的各种验证信息（中文字符，特殊字符，位数，字母等等）
 @author   莎莎 
 @version  4.3  2012/08/27 Creation (此文档的版本信息)
 
 */

#define ErrorWithSuccessInfo(errorCode) [NSError errorWithDomain:kValidationErrorDomain code:errorCode userInfo:nil];

#define ErrorWithErrorCodeAndDesc(errorCode,errorDesc,errorDescKey)  [NSError errorWithDomain:kValidationErrorDomain code:errorCode userInfo:[NSDictionary dictionaryWithObject:errorDesc forKey:errorDescKey]];



#define kValidationSuccess     1
#define kValidationFail        0

#define kValidationErrorDomain @"ValideError"

#define kValidationErrorDesc_Key   @"ErrorDesc"

#define kValidationErrorDesc_Error_Null       @"Error_Null"
#define kValidationErrorDesc_Error_NotValide  @"Error_NotValide"
#define kValidationErrorDesc_Error_Length     @"Error_Length"


#import <Foundation/Foundation.h>

/*!
 @abstract     字符串的验证
 @discussion   返回值NSError。通过errorCode判定成功还是失败，ErrorDesc：描述错误原因。
 */
@interface ValidationService : NSObject


+ (BOOL)checkBoardPersonName:(NSString *)name;

/*!
 @abstract   判断是否是｛minBit，maxBit｝位数的中文字符
 @discussion
 @param chinese 传入的需要校验的中文字符串
 @param minBit 最少minBit位
 @param maxBit 最多maxBit位
 @result NSError  包含错误码errorCode、错误描述userinfo
 */
+ (NSError *)chineseChecking:(NSString *)chinese Frome:(NSInteger)minBit To:(NSInteger)maxBit;


/*!
 @method
 @abstract 验证是否 包含 数字 或者 字母 
 @discussion 
 @param checkedString 待验证的字符串
 @result NSError  包含错误码errorCode、错误描述userinfo
  */
+ (NSError *)NumOrCharacterChecking:(NSString *)checkedString;


/*!
 @method
 @abstract 验证是否是数字和字母的组合
 @discussion 
 @param checkedString 待验证的字符串
 @param minBit  最少minBit个字符
 @param maxBit  最多maxBit个字符
 @result NSError  包含错误码errorCode、错误描述userinfo 
 */

+ (NSError *)NumAndCharacterChecking:(NSString *)checkingString  minBit:(NSInteger)minBit maxBit:(NSInteger)maxBit;

/*!
 @method
 @abstract    手机号码的合法性检查
 @discussion  检查包括：1.号码为11位
                      2.首数字为1
 @param       checkedString 待验证的字符串
 @result NSError  包含错误码errorCode、错误描述userinfo
 
 */
+ (NSError *)phoneNumChecking:(NSString *)checkedString;


/*!
 @method
 @abstract 验证身份证号码的合法性
 @discussion 验证规则：（1）18位或者是15位
                     （2）18位的话最后一位为X或者是数字。其他都是数字
 @param identifyString  身份证号码
 @result NSError  包含错误码errorCode、错误描述userinfo
 */

+ (NSError *)valideIdentifyCard:(NSString *)identifyString;

@end
