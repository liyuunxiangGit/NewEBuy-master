//
//  GBEfubaoDTO.h
//  SuningEBuy
//
//  Created by xie wei on 13-6-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBEfubaoDTO : NSObject

@property (nonatomic, copy)  NSString   *orderId;            //订单号
@property (nonatomic, copy)  NSString   *userId;             //用户ID
@property (nonatomic, copy)  NSString   *memberId;           //会员编号ID
@property (nonatomic, copy)  NSString   *paymentType;        //支付方式
@property (nonatomic, copy)  NSString   *ifSuccess;          //是否支付成功
@property (nonatomic, copy)  NSString   *passwordErrorTimes; //支付密码错误次数 -1：系统异常 0：成功 1 ~ 3：密码失败次数

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
