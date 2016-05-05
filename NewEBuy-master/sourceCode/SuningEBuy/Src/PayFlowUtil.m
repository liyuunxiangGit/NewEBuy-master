//
//  PayFlowUtil.m
//  SuningEBuy
//
//  Created by  on 12-10-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PayFlowUtil.h"
#import "RegexKitLite.h"
#import "NSString+Additions.h"
#import "ShopCartShopDTO.h"
#import "AddressInfoDAO.h"

@implementation PayFlowUtil

#pragma mark -
#pragma mark 组装收货人地址
+ (NSString *)generateUserFullAddressInfo:(AddressInfoDTO *)addressInfo
{
    NSString *userFullInfo = nil;
    
    NSString *userAddress = @"";
    
    NSString *provName = addressInfo.provinceContent;
    
    NSString *cityName = addressInfo.cityContent;
    
    NSString *areaName = addressInfo.districtContent;
    
    NSString *townName = addressInfo.townContent;
        
    if (provName)
    {
        userAddress = [userAddress stringByAppendingString:provName];
    }
    
    if (cityName) 
    {
        userAddress = [userAddress stringByAppendingString:cityName];        
    }
    
    if (areaName)
    {
        userAddress = [userAddress stringByAppendingString:areaName];
    }
    
    if (townName)
    {
        userAddress = [userAddress stringByAppendingString:townName];
    }
    
    if (addressInfo.addressContent)
    {
        userAddress = [userAddress stringByAppendingString:addressInfo.addressContent];
    }
    //去掉null
    userFullInfo = [userAddress stringByReplacingOccurrencesOfString:@"null" withString:@""];
        
    return userFullInfo;
}

#pragma mark -
#pragma mark 组装门店自提地址
+ (NSString *)generateStoreMentionInfo:(StoreInfoDto *)storeInfo
{
    NSString *userFullInfo = nil;
    
    NSString *storeName = @"";
    
    if (storeInfo.storeName)
    {
        storeName = [storeName stringByAppendingString:storeInfo.storeName];   
    }
    
    NSString *userAddress = @"";
    
    if (storeInfo.storeAddress) 
    {
        userAddress = [userAddress stringByAppendingString:storeInfo.storeAddress];
    }
    if (IsStrEmpty(storeName)) {
        userFullInfo = @"";
    }else{
        userFullInfo = [NSString stringWithFormat:@"%@\n%@",storeName,userAddress];
    }
    return userFullInfo;
}

+ (NSString *)generateStoreAreaInfo:(StoreInfoDto *)storeInfo
{
    NSString *userFullInfo = @"";
        
    if (storeInfo.provinceName)
    {
        userFullInfo = [userFullInfo stringByAppendingString:storeInfo.provinceName];   
    }else{
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
        dto = [dao getProvinceAndCityInfoByCityCode:storeInfo.cityId];
        userFullInfo = IsStrEmpty(dto.provinceContent)?@"":dto.provinceContent;
    }
        
    if (storeInfo.cityName)
    {
        userFullInfo = [userFullInfo stringByAppendingString:storeInfo.cityName];   
    }
        
    if (storeInfo.districtName)
    {
        userFullInfo = [userFullInfo stringByAppendingString:storeInfo.districtName];   
    }
    
    return userFullInfo;
}

#pragma mark -
#pragma mark 检验是否只含有中文字符

+ (BOOL)validateIsOnlyContainChineseCharacter:(NSString *)mobileNo {
    
    int length = [mobileNo length];
    for (int i=0; i<length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [mobileNo substringWithRange:range];
        const char    *cString = [subString UTF8String];
        if (strlen(cString) != 3)
        {
            return  NO;
        }
    }
    
    return  YES;
    
}

#pragma mark -
#pragma mark 检验2-6位中文字符

+ (BOOL)validateChineseChar2_6:(NSString *)str
{
    if (!str || [str isEmptyOrWhitespace]) 
    {
        return NO;
    }
    
    NSString *invoiceRegex = @"[\\u4e00-\\u9fa5]{2,6}";
    NSPredicate *invoiceTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", invoiceRegex];
    return [invoiceTest evaluateWithObject:str];  
}

#pragma mark -
#pragma mark 校验手机号码

+ (BOOL)validateChinaMobileNo:(NSString *)mobileNo
{
    if (!mobileNo || [mobileNo isEmptyOrWhitespace]) 
    {
        return NO;
    }
    NSString *mobileNoRegex = @"1\\d{10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex]; 
    return [mobileNoTest evaluateWithObject:mobileNo];
}

#pragma mark -
#pragma mark 检查是否支持自提，并返回异常商品dto

+ (BOOL)checkCartListIsSupportStoreMention:(NSArray *)cartList 
                          unSupportProduct:(ShopCartV2DTO **)dto
{

    for (ShopCartShopDTO *shopDto in cartList) {
        NSArray *array = [shopDto itemList];
        if (!IsArrEmpty(array)) {
            for (ShopCartV2DTO *product in array) {
                if (product.isChecked && !product.canTake)
                {
                    *dto = product;
                    return NO;
                }
            }
        }
    }
    return YES;
}

#pragma mark -
#pragma mark 校验发票抬头，需要1-32个字符，且不能包含以下非法字符

+ (BOOL)checkHasInvalidChar:(NSString *)str
{
    NSString *regex = @"[·~`!@#$%^&{}\\\\<>\\+\\[\\]　•〔〕『』«»【】〗〖›‹」「﹝﹞]";

    if ([str isMatchedByRegex:regex]) {
        return YES;
    }
    return NO;
}

+ (BOOL)validateInvoice:(NSString *)invice error:(NSString **)errorMsg
{
    NSString *trimInvoice = [invice trim];
    if ([trimInvoice isEmptyOrWhitespace]) {
        *errorMsg = L(@"PFInvoiceHeaderCannotBeEmpty");
        return NO;
    }
    
    //校验非法字符
    if ([self checkHasInvalidChar:trimInvoice])
    {
        *errorMsg = L(@"PFInvoiceHeaderNotIncludeIllegalCharacter");
        return NO;
    }
    
    if ([trimInvoice length] < 2 || [trimInvoice length] > 32) {
        *errorMsg = L(@"PFInvoiceHeaderShouldHave2-32Words");
        return NO;
    }
    return YES;
}

@end
