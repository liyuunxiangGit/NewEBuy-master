//
//  FlightFilter.h
//  SuningEBuy
//
//  Created by shasha on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightFilter : NSObject
+ (NSArray *)PriceHighToLow:(NSArray *)FlightList;
+ (NSArray *)TimeEarliToLate:(NSArray *)FlightList;
/*!
 @abstract      按照航空公司Id对原返回的结果列表进行筛选
 @param         FlightList   原结果列表
                companyId    筛选条件（航空公司Id）
 @result        NSArray      返回符合筛选条件的列表。
                nil          返回空如果没有符合条件的选项。
 */
+ (NSArray *)companyFilter:(NSArray *)FlightList byCompany:(NSString *)companyId;

+ (BOOL)isRsEarlier:(NSString *)RsStartTime thanFl:(NSString *)FlStartTime;


+ (NSArray *)TimeEarliToLateByString:(NSArray *)FlightList;

@end
