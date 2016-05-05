//
//  AchievementExchangeDTO.m
//  SuningEBuy
//
//  Created by lanfeng on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AchievementExchangeDTO.h"


@implementation AchievementExchangeDTO

@synthesize billNo = _billNo;
@synthesize processTime = _processTime;
@synthesize commodityName = _commodityName;
@synthesize billType = _billType;
@synthesize batchPoint = _batchPoint;

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
	self.billNo            = [dic objectForKey:@"cmmdtyCode"];
    
	self.processTime       = [dic objectForKey:@"eventTS"];
    
    if (IsStrEmpty([dic objectForKey:@"orderTypeDesc"]))
    {
        self.commodityName = [dic objectForKey:@"cmmdtyName"];
    }else{
        
        self.commodityName = [dic objectForKey:@"orderTypeDesc"];
    }
    
    self.batchPoint        = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"newBatchAmt"]floatValue]];
    
}





@end
