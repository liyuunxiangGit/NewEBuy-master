//
//  CancelOrderCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CancelOrderCommand.h"

@implementation CancelOrderCommand

@synthesize orderId = _orderId;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderId);
    SERVICE_RELEASE_SAFELY(service);
}

- (id)init
{
    self = [super init];
    if (self) {
        service = [[OrderDetailService alloc] init];
        service.delegate = self;
    }
    return self;
}

- (void)cancel
{
    service.delegate = nil;
    service = nil;
    
    [super cancel];
}

- (void)execute
{
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    

    [service beginSendCancelOrderHttpRequest:userId
                                     orderId:self.orderId];
}

- (void)orderCancelHttpRequestCompletedWith:(BOOL)isSucess
                                   errorMsg:(NSString *)errorMsg
{
    if (isSucess) {
        DLog(@"cancel order success!");
    }else{
        DLog(@"cancel order fail!");
    }
    
    [self done];
}

@end
