//
//  PFOrderBasicDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFOrderBasicDTO : NSObject

/*大订单号*/
@property (nonatomic, copy) NSString *ordersId;

/*用户id*/
@property (nonatomic, copy) NSString *usersId;

/*机票状态*/
@property (nonatomic, copy) NSString *status;

/*下单时间*/
@property (nonatomic, copy) NSString *creatTime;

/*总金额*/
@property (nonatomic, copy) NSString *totalAmount;

/*旅客数量*/
@property (nonatomic, copy) NSString *travNum;

/*起飞地点*/
@property (nonatomic, copy) NSString *startAirportName;

/*到达地点*/
@property (nonatomic, copy) NSString *arrivAirportName;

/*类型：单程，去程，回程*/
@property (nonatomic, copy) NSString *airlineType;

/*保险价格*/
@property (nonatomic, copy) NSString *insuranceTotalAmount;

/*机票价格*/
@property (nonatomic, copy) NSString *ticketTotalAmount;

- (void)encodeFromDictionary:(NSDictionary *)dic;


@end
