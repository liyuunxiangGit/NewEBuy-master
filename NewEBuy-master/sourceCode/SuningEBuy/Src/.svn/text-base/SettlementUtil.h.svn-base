//
//  SettlementUtil.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface SettlementUtil : NSObject

+ (CGFloat)convertStringMoneyToFloat:(NSString *)moneyValue;

+ (NSString *)convertFloatMoneyToString:(CGFloat)moneyValue;

// 组装收货人地址
//+ (NSString *)generateUserFullAddressInfo:(AddressInfoDTO *)addressInfo;

// 组装门店地址
//+ (NSString *)generateStoreMentionInfo:(StoreInfoDto *)storeInfo;

// 组装应付金额, 应付金额 ＝ 实际价格 － 优惠 ＋ 运费
+ (NSString *)generatePaytableMoney:(CGFloat)productPrice favorable:(CGFloat)favMoney feight:(CGFloat)feiMoney;  

+ (void)hideTabBar:(UITabBarController *)tabBarController;

+ (void)showTabBar:(UITabBarController *)tabBarController;



@end
