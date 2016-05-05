//
//  LotteryPayPlugin.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitLotteryDto.h"

//只支持wap收银台
@interface LotteryPayPlugin : NSObject

+ (void)startPayWithDto:(SubmitLotteryDto *)payDto
         fromController:(CommonViewController *)controller;
+ (void)cancelPay;

//上此订单支付成功，弹出去首页和去彩票订单
+ (void)lastOrderPayedOk;

+ (BOOL)open;

@end
