//
//  CancelOrderCommand.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"
#import "OrderDetailService.h"

@interface CancelOrderCommand : Command <OrderDetailServiceDelegate>
{
    OrderDetailService  *service;
}

@property (nonatomic, copy) NSString *orderId;

@end
