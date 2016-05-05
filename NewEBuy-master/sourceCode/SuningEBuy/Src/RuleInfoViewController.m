//
//  RuleInfoViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "RuleInfoViewController.h"
#import "PlanTicketSwitch.h"

@implementation RuleInfoViewController

@synthesize airlineInfo = _airlineInfo;
@synthesize textView = _textView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_airlineInfo);
    TT_RELEASE_SAFELY(_textView);
}

- (id)init {
    self = [super init];
    if (self) {
        self.titleLabel.text = L(@"BTEndorseRule");
        self.pageTitle = L(@"virtual_business_flightChangeRules");
    }
    return self;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont boldSystemFontOfSize:15.0];
        _textView.textColor = [UIColor darkTextColor];
        _textView.editable = NO;
    }
    return _textView;
}

- (void)loadView
{
    [super loadView];
    
    self.textView.frame = self.view.frame;    
    NSString *string = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        if (IsStrEmpty(self.airlineInfo.ticketRefund)) {
            string = L(@"BTMakeEndorseAsNorm");
        }else{
            string = self.airlineInfo.ticketRefund;
        }
    }else{
     string = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@\n\n%@\n%@\n",L(@"BTReturnedTicket"),self.airlineInfo.ticketRefund,L(@"BTTransfer"), self.airlineInfo.ticketChange, L(@"BTReschedule"),self.airlineInfo.ticketChangeDate];
    }
    self.textView.text = string;
    [self.view addSubview:self.textView];
}

@end
