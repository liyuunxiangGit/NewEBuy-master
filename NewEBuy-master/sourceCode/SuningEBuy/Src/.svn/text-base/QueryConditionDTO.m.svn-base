//
//  QueryConditionDTO.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryConditionDTO.h"

@implementation QueryConditionDTO

@synthesize orgCity = _orgCity;
@synthesize desCity = _desCity;
@synthesize orgTime = _orgTime;
@synthesize returnTime = _returnTime;
@synthesize isRoundTicket = _isRoundTicket;

- (id)init {
    self = [super init];
    if (self) {
        
        _isRoundTicket = NO;
        
    }
    return self;
}


- (void)dealloc {
    TT_RELEASE_SAFELY(_orgCity);
    TT_RELEASE_SAFELY(_desCity);
    TT_RELEASE_SAFELY(_orgTime);
    TT_RELEASE_SAFELY(_returnTime);
}
@end
