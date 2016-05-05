//
//  UserFeedBackDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserFeedBackDTO.h"

@implementation UserFeedBackDTO

@synthesize feedbackType = _feedbackType;
@synthesize feedbackContext = _feedbackContext;
@synthesize contactInfo = _contactInfo;
@synthesize terminal = _terminal;
@synthesize terminalOsVersion = _terminalOsVersion;
@synthesize appId =  _appId;
@synthesize terminalAppVersion = _terminalAppVersion;
@synthesize clientId = _clientId;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_feedbackType);
    TT_RELEASE_SAFELY(_feedbackContext);
    TT_RELEASE_SAFELY(_contactInfo);
    TT_RELEASE_SAFELY(_terminal);
    TT_RELEASE_SAFELY(_terminalOsVersion);
    TT_RELEASE_SAFELY(_appId);
    TT_RELEASE_SAFELY(_terminalAppVersion);
    TT_RELEASE_SAFELY(_clientId);
    
}

@end
