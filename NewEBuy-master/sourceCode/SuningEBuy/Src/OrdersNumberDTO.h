//
//  OrdersNumberDTO.h
//  SuningEBuy
//
//  Created by YANG on 14-5-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface OrdersNumberDTO : BaseHttpDTO
@property (nonatomic, copy) NSString *isSuccess; //成功或失败
@property (nonatomic, copy) NSString *waitPayCounts;//待付款数量
@property (nonatomic, copy) NSString *waitDeliveryCounts;//待收货数量;
@property (nonatomic, copy) NSString *ordersInReturnCounts;//退货中的数量;
@end
