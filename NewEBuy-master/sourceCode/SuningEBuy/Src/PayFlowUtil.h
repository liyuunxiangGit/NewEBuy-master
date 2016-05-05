//
//  PayFlowUtil.h
//  SuningEBuy
//
//  Created by  on 12-10-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreInfoDto.h"
#import "ShopCartV2DTO.h"

@interface PayFlowUtil : NSObject

// 组装收货人地址
+ (NSString *)generateUserFullAddressInfo:(AddressInfoDTO *)addressInfo;

// 组装门店地址
+ (NSString *)generateStoreMentionInfo:(StoreInfoDto *)storeInfo;

// 组装门店区域信息
+ (NSString *)generateStoreAreaInfo:(StoreInfoDto *)storeInfo;

//校验是否是中文字符
+ (BOOL)validateIsOnlyContainChineseCharacter:(NSString *)mobileNo;

//校验字符串为2-6位中文
+ (BOOL)validateChineseChar2_6:(NSString *)str;

//检验手机号码
+ (BOOL)validateChinaMobileNo:(NSString *)mobileNo;

//检查购物车列表是否支持自提
+ (BOOL)checkCartListIsSupportStoreMention:(NSArray *)cartList 
                          unSupportProduct:(ShopCartV2DTO **)dto;

//检查是否包含非法字符，包含返回yes
+ (BOOL)checkHasInvalidChar:(NSString *)str;

//校验发票抬头, 需要输入1-32个非法字符
+ (BOOL)validateInvoice:(NSString *)invice error:(NSString **)errorMsg;
@end
