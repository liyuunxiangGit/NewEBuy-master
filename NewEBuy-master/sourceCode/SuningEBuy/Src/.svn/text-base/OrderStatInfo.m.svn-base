//
//  orderStatInfo.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderStatInfo.h"


@implementation OrderStatInfo

@synthesize payedNum    = _payedNum;

@synthesize waitingNum  = _waitingNum;

@synthesize canceledNum = _canceledNum;

@synthesize returnedNum = _returnedNum;

-(void)dealloc{
	
    TT_RELEASE_SAFELY(_returnedNum);
    
	TT_RELEASE_SAFELY(_payedNum);
	
	TT_RELEASE_SAFELY(_waitingNum);
	
	TT_RELEASE_SAFELY(_canceledNum);
	
	
}

@end
