//
//  LotteryDataModel.h
//  SuningEBuy
//
//  Created by shasha on 12-6-28.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BallSelectConstant.h"

@interface LotteryDataModel : NSObject


void swap (int *pm, int *pn);

+ (void)sortFromLowToHigh:(NSMutableArray *)sourceArr;

+ (void)sortFromHighToLow:(NSMutableArray *)sourceArr;

+ (void)deleteFromArray:(NSMutableArray *)sourceArr deletedElement:(NSInteger)element;

+ (void)getRandomArray:(NSMutableArray *)sourceArr randomNumCount:(NSInteger)count maxCount:(NSInteger)maxCount;

//根据彩票类型获取彩票名字
+ (NSString *)lotteryNameWithType:(LotteryType)type;

//根据彩票类型获取彩票gid
+ (NSString *)lotterygidWithType:(LotteryType)type;

//根据彩票gid获取彩票类型
+ (LotteryType)lotterTypeWithgid:(NSString *)gid;
@end
