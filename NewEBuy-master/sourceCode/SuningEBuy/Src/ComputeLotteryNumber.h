//
//  ComputeLotteryNumber.h
//  SuningEBuy
//
//  Created by david david on 12-6-29.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComputeLotteryNumber : NSObject


/*
 *  功能：根据彩票号码算出双色球购买注数
 *
 *  参数lottery形如 "01 02 12 14 23 11 | 12"
 */

+(CGFloat)computeLotterySSQNumber:(NSString *)lottery;

/*
 *  功能：根据彩票号码算出七乐彩购买注数
 *
 *  参数lottery形如 "01 02 03 04 05 06 07"
 */
+(CGFloat)computeSevenLeNumber:(NSString *)lottery;

+(CGFloat)computeLotterySevenLeNumber:(NSInteger)count;

/*
 *  功能：根据彩票号码算出大乐透购买注数
 *
 *  参数lottery形如 "02 12 14 23 11 | 12 13"
 */

+(CGFloat)computeLotteryDLTNumber:(NSString *)lottery;


/*
 *  功能：算红球或者篮球的排列
 *
 *
 */

+(CGFloat)arrangement:(int)bigNo andSmallNo:(int)smallNo;



/*
 *  功能：根据彩票号码算出购买注数
 *
 *  参数lottery形如 直选 "2 2|3 3|4 5" 其他"1 3 5"
 */

+(CGFloat)computeLotteryFC3DNumber:(NSString *)lottery ballType:(int)ballType;


/*
 *  功能：根据七星彩号码算出购买注数
 *
 *  参数lottery形如 直选 "2 3 | 1 3 | 4 5 | 1 | 1 | 1 | 1"
 */

+(CGFloat)computeLotterySevenStarsNumber:(NSString *) lottery;
@end
