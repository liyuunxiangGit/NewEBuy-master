//
//  BoardingPersonUtil.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BoardingPersonUtil.h"
#import "RegexKitLite.h"

@implementation BoardingPersonUtil


+ (BOOL)validateBoardingName:(NSString *)name error:(NSString **)errorMsg
{
    if ([name.trim length] == 0) {
        *errorMsg = L(@"BTPassengeCanNotBeEmpty");
        return NO;
    }
    
    //验证非法字符
    NSString *regex1 = @"^[\\u4e00-\\u9fa5a-zA-Z\\/\\s]*$";
    if (![name isMatchedByRegex:regex1]) {
        *errorMsg = L(@"BTNameContainIllegalCharacter");
        return NO;
    }
    
    //是否有空白字符
    NSString *regex2 = @"(\\s)";
    if ([name rangeOfRegex:regex2].location != NSNotFound) {
        *errorMsg = L(@"BTNameContainBlankCharacter");
        return NO;
    }
    
    //当为纯中文时，不能超过2-10位
    NSString *regex3 = @"^[\\u4e00-\\u9fa5]*$";
    if ([name isMatchedByRegex:regex3]) {
        if (name.length < 2 || name.length > 10) {
            *errorMsg = L(@"BTPleaseInputNameCorrect");
            return NO;
        }
    }
    
    //中文后面有拼音的
    NSString *regex4 = @"^(([\\u4E00-\\u9FA5\\uF900-\\uFA2D])*([a-zA-Z])+([\\u4E00-\\u9FA5\\uF900-\\uFA2D])+)$";
    if ([name isMatchedByRegex:regex4]) {
        *errorMsg = L(@"BTCanNotInputSyllableBehindCharacter");
        return NO;
    }
    
    //英文名称
    NSString *regex5 = @"^([a-zA-Z]*\\/*)$";
    if ([name isMatchedByRegex:regex5]) {
        NSString *regex6 = @"^([a-zA-Z]{1,20}\\/{1}[a-zA-Z]{1,20})$";
        if (![name isMatchedByRegex:regex6]) {
            *errorMsg = L(@"BTUseAndFollowOrder");
            return NO;
        }
    }
    
    //总格式验证
    NSString *regExp1 = @"^([\\u4E00-\\u9FA5\\uF900-\\uFA2D]){2,10}$";  //全汉字
    NSString *regExp2 = @"^([\\u4E00-\\u9FA5\\uF900-\\uFA2D])+([a-zA-Z])*$"; //汉字加拼音
    NSString *regExp3 = @"^([a-zA-Z])+([\\/]){1}([a-zA-Z])+$";   //字母+/+字母
    if (!([name isMatchedByRegex:regExp1] ||
        [name isMatchedByRegex:regExp2] ||
        [name isMatchedByRegex:regExp3]))
    {
        *errorMsg = L(@"BTFollowOrderToInputName");
        return NO;
    }
    return YES;
}

+ (BOOL)validateIdCode:(NSString *)code error:(NSString **)errorMsg
{
    if ([code.trim length] == 0) {
        *errorMsg = L(@"BTIdentityCardNumberCanNotBeEmpty");
        return NO;
    }
    
    //校验长度
    if (!(code.length == 15 || code.length == 18))
    {
        *errorMsg = L(@"BTIdentityCardLongError");
        return NO;
    }
    
    //校验生日
    NSUInteger size = code.length ;
    NSInteger birthYear = 0;    //生日年份
    BOOL isBirthdayRight = NO;
    if(size == 15){
        birthYear = [[code substringWithRange:NSMakeRange(6, 2)] integerValue]+1900;
        if(birthYear % 400 == 0 ||
           (birthYear % 100 != 0 && birthYear % 4 == 0))
        {
            NSString *regex1 = @"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2] [0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$";// 测试出生日期的合法性
            if ([code isMatchedByRegex:regex1])
            {
                isBirthdayRight = YES;
            }
        }else{
            NSString *regex1 = @"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]| [1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$";// 测试出生日期的合法性
            if ([code isMatchedByRegex:regex1])
            {
                isBirthdayRight = YES;
            }
        }
    }
    else if (size == 18)
    {
        birthYear = [[code substringWithRange:NSMakeRange(6, 4)] integerValue];
        if(birthYear % 400 == 0 ||
           (birthYear % 100 != 0 && birthYear % 4 == 0))
        {
            NSString *ereg = @"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$";// 闰年出生日期的合法性正则表达式
            if ([code isMatchedByRegex:ereg])
            {
                isBirthdayRight = YES;
            }
        }else{
            NSString *ereg = @"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$";// 平年出生日期的合法性正则表达式
            if ([code isMatchedByRegex:ereg]) {
                isBirthdayRight = YES;
            }
        }
    }
    if (!isBirthdayRight) {
        *errorMsg = L(@"BTIDContainIllegalCharacterOrError");
        return NO;
    }
    
    //校验区域
    NSDictionary *areaArr = [NSDictionary dictionaryWithObjectsAndKeys:
                      L(@"BTBeijing"), @"11", L(@"BTTianjin"), @"12", L(@"Hebei"), @"13", L(@"Shanxi"), @"14", L(@"Neimenggu"), @"15",
                      L(@"Liaoning"), @"21", L(@"Jilin"), @"22", L(@"Heilongjiang"), @"23", L(@"Shanghai"), @"31", L(@"Jiangsu"), @"32",
                      L(@"Zhejiang"), @"33", L(@"Anhui"), @"34", L(@"Fujian"), @"35", L(@"Jiangxi"), @"36", L(@"Shandong"), @"37",
                      L(@"Henan"), @"41", L(@"Hubei"), @"42", L(@"Hunan"), @"43", L(@"Guangdong"), @"44", L(@"Guangxi"), @"45",
                      L(@"Hainan"), @"46", L(@"Chongqing"), @"50", L(@"Sichuan"), @"51", L(@"Guizhou"), @"52", L(@"Yunnan"), @"53",
                      L(@"Xizang"), @"54", L(@"Shanxi"), @"61", L(@"Gansu"), @"62", L(@"Qinghai"), @"63", L(@"Ningxia"), @"64",
                      L(@"Xinjiang"), @"65", L(@"Taiwan"), @"71", L(@"HK"), @"81", L(@"Macao"), @"82", L(@"Overseas"), @"91",
                      nil];
    NSString *area = [code substringWithRange:NSMakeRange(0, 2)];
    if (![areaArr objectForKey:area]) {
        *errorMsg = L(@"BTIDAreaIllegal");
        return NO;
    }
    
    return YES;
}

@end
