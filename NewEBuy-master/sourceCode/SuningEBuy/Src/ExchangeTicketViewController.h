//
//  ExchangeTicketViewController.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNPopoverController.h"
#import "SNPopoverCommonViewController.h"
#import "FlightRuleService.h"
@interface ExchangeTicketViewController : SNPopoverCommonViewController
<UITableViewDelegate, UITableViewDataSource,FlightRuleInfoDelegate>{
    
    BOOL                        isLoadingOK;
}

@property (nonatomic,strong) UIActivityIndicatorView *displayActivityIndicateView;

@property (nonatomic,strong) FlightRuleService *ticketRuleService;

@property (nonatomic, strong) FlightInfoDTO *flightInfo;

@property (nonatomic, strong) UITextView *textView;

- (void)sendTicketRuleListHttpReqeust;

@end
