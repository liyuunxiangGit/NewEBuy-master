//
//  ExchangeTicketViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ExchangeTicketViewController.h"
#import "ExchangTicketCell.h"

#define UIFONT_CONTENT_SIZE  14.0



@implementation ExchangeTicketViewController

@synthesize displayActivityIndicateView = _displayActivityIndicateView;
@synthesize flightInfo = _flightInfo;
@synthesize ticketRuleService = _ticketRuleService;
@synthesize textView = _textView;

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"BTEndorseRule");
        
        isLoadingOK = NO;
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_displayActivityIndicateView);
    
    TT_RELEASE_SAFELY(_flightInfo);
    
    TT_RELEASE_SAFELY(_textView);
    
    SERVICE_RELEASE_SAFELY(_ticketRuleService);
    
}


- (void)loadView
{
    [super loadView];
        
    self.view.frame = CGRectMake(0, 0, 230, 250);    
    
    self.textView.frame = CGRectMake(0, 0, 230, 250);
    
    [self.view addSubview:self.textView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isLoadingOK)
    {
        [self sendTicketRuleListHttpReqeust];
    }
}



- (UIActivityIndicatorView *)displayActivityIndicateView
{
    if (_displayActivityIndicateView == nil) {
        _displayActivityIndicateView =
        [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_displayActivityIndicateView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [_displayActivityIndicateView setCenter:CGPointMake(115, 125)];
        [_displayActivityIndicateView startAnimating];
        _displayActivityIndicateView.hidesWhenStopped = YES;
        [self.view addSubview:_displayActivityIndicateView];
    }
    return _displayActivityIndicateView;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont boldSystemFontOfSize:16.0f];
        _textView.editable = NO;
    }
    return _textView;
}

- (FlightRuleService *)ticketRuleService
{
    if(nil == _ticketRuleService)
    {
        _ticketRuleService = [[FlightRuleService alloc] init];
        _ticketRuleService.delegate = self;
    }
    return _ticketRuleService;
}


#pragma mark -
#pragma mark - get data and service delegate


- (void)sendTicketRuleListHttpReqeust
{
    [self displayActivityIndicateView];
    
    [self.ticketRuleService beginGetPlanTicketRuleInfoRequest:self.flightInfo];
}

- (void)getPlanTicketRuleInfoCompletionWithRequest:(BOOL)isSuccess
                                          errorMsg:(NSString *)errorMsg
                                          ruleInfo:(NSString *)refundRuleInfo
{
    [[self displayActivityIndicateView] stopAnimating];
    [self setDisplayActivityIndicateView:nil];
    if (isSuccess) {
        if (IsStrEmpty(refundRuleInfo)) {
            refundRuleInfo = L(@"BTMakeEndorseAsNorm");
        }
        self.textView.text = refundRuleInfo;
        
    }else{
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:L(@"BTEndorseRuleGetError")
                                  delegate:nil
                                  cancelButtonTitle:L(@"Cancel")
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end
