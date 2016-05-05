//
//  DJGroupApplyDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupApplyDTO.h"

@implementation DJGroupApplyDTO

@synthesize storeId = _storeId;
@synthesize catalogId = _catalogId;
@synthesize groupId = _groupId;
@synthesize catentryId = _catentryId;
@synthesize amount = _amount;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_catalogId);
    TT_RELEASE_SAFELY(_groupId);
    TT_RELEASE_SAFELY(_catentryId);
    TT_RELEASE_SAFELY(_amount);
    
}

@end
