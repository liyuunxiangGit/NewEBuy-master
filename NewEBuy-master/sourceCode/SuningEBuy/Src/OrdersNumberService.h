//
//  OrdersNumberService.h
//  SuningEBuy
//
//  Created by YANG on 14-5-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "OrdersNumberDTO.h"

@protocol OrdersNumberServiceDelegate;

@interface OrdersNumberService : DataService
{
    HttpMessage *ordersNumberMessage;
}
@property (nonatomic ,strong) HttpMessage *ordersNumberMessage;
@property (nonatomic, assign) id<OrdersNumberServiceDelegate>delegate;
- (void)beginGetOrdersNumberInfo:(NSString *)storeId catalogId:(NSString *)catalogId;

@end

@protocol OrdersNumberServiceDelegate <NSObject>

- (void)getOrderNumberCompletedWithResult:(OrdersNumberDTO *)dto
                              errorMsg:(NSString *)errorMsg;

@end
