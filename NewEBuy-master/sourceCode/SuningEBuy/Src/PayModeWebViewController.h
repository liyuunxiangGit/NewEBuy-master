//
//  PayModeWebViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-4-16.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWWebViewController.h"
#import "CommonViewController.h"
#import "SettlementUtil.h"
#import "OrderDetailService.h"

@interface PayModeWebViewController : PWWebViewController
<BBAlertViewDelegate, OrderDetailServiceDelegate> 
{
    NSString                *orderId_;
    BOOL                    isFromPaymentModeViewController_;
}

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign)  BOOL   isFromPaymentModeViewController;

@property (nonatomic, strong) OrderDetailService *orderService;

//- (void)sendCancelOrderHttpRequest;


@end
