//
//  FlightRuleService.h
//  SuningEBuy
//
//  Created by admin on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfoDTO.h"
@class FlightRuleService;

@protocol FlightRuleInfoDelegate <NSObject>

@optional
- (void)getPlanTicketRuleInfoCompletionWithRequest:(BOOL)isSuccess
                                          errorMsg:(NSString *)errorMsg
                                          ruleInfo:(NSString *)refundRuleInfo;
@end

@interface FlightRuleService : DataService
{
    HttpMessage    *ruleMsg;
}

@property (nonatomic,assign) BOOL           isLoadingOK;
@property (nonatomic,weak) id<FlightRuleInfoDelegate> delegate;

- (void)beginGetPlanTicketRuleInfoRequest:(FlightInfoDTO *)filghtInfo;

@end
