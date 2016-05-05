//
//  HistoryCodeDto.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryCodeDto : NSObject

@property (nonatomic, strong) NSString *pidNumber; // 开奖期数

@property (nonatomic, strong) NSString *pidTime;   // 开奖时间

@property (nonatomic, strong) NSString *pidCode;   // 开奖号码

@property (nonatomic, strong) NSString *pidSale;   // 全国销售金额

@property (nonatomic, strong) NSString *poolSale;  // 奖池累计销售金额

@property (nonatomic, strong) NSString *row;       // 行编号

@property (nonatomic, strong) NSString *week;      // 星期

- (void)decodeFromDictionary:(NSDictionary *)dic;

@end
