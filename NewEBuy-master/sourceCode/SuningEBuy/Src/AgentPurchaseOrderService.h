//
//  AgentPurchaseOrderService.h
//  SuningEBuy
//
//  Created by cui zl on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentPurchaseOrderService : DataService
{
    HttpMessage   *agentPurchaseHttpMsg;
}

@property (nonatomic, copy) NSString *projid;   // 方案编号
@property (nonatomic, assign) float balance;    // 用户余额

@property (nonatomic, copy) NSString *orderRequestErrorMsg;


- (void)submitLotteryOrderRequest:(NSDictionary *)orderDic;


@end
