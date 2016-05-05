//
//  GBSubmitBackDTO.h
//  SuningEBuy
//
//  Created by xie wei on 13-6-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBSubmitBackDTO : NSObject

@property (nonatomic, copy)  NSString   *ifSuccess;     //订单是否提交成功 0：成功
@property (nonatomic, copy)  NSString   *orderId;       //订单编号
@property (nonatomic, copy)  NSString   *orderPrice;    //订单金额

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
