//
//  SubmitLotteryDto.m
//  SuningEBuy
//
//  Created by david on 12-6-30.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "SubmitLotteryDto.h"

@implementation SubmitLotteryDto

@synthesize gid = _gid;
@synthesize productName = _productName;
@synthesize productTimes = _productTimes;
@synthesize saleType = _saleType;
@synthesize productMoney = _productMoney;
@synthesize buyCodes = _buyCodes;
@synthesize multiNo = _multiNo;
@synthesize endTime = _endTime;
@synthesize periods = _periods;
@synthesize stopWhenWin;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_gid);
    
    TT_RELEASE_SAFELY(_productName);
    
    TT_RELEASE_SAFELY(_productTimes);
    
    TT_RELEASE_SAFELY(_saleType);
    
    TT_RELEASE_SAFELY(_productMoney);
    
    TT_RELEASE_SAFELY(_buyCodes);
    
    TT_RELEASE_SAFELY(_multiNo);
    
    TT_RELEASE_SAFELY(_endTime);
    
    TT_RELEASE_SAFELY(_periods);
    
}


@end
