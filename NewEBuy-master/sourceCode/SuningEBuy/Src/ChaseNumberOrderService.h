//
//  ChaseNumberOrderService.h
//  SuningEBuy
//
//  Created by cui zl on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChaseNumberOrderService : DataService
{
     HttpMessage *chaseNumberOrderHttpMsg;
}

@property (nonatomic, copy) NSString *projid;   // 方案编号

@property (nonatomic, copy) NSString *orderRequestErrorMsg;


- (void)submitChaseNumberOrderRequest:(NSDictionary *)orderDic;

@end
