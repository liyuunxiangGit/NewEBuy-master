//
//  MYEbuyCoumonDTO.m
//  SuningEBuy
//
//  Created by DP on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MYEbuyCoumonDTO.h"

@implementation MYEbuyCoumonDTO

@synthesize serialNumber = _serialNumber;
@synthesize name = _name;
@synthesize endTime = _endTime;
@synthesize strparValue = _strparValue;
@synthesize remainingAmount = _remainingAmount;

-(void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.bExpend = YES;
    if(NotNilAndNull([dic objectForKey:@"serialNumber"])){
        self.serialNumber= [dic objectForKey:@"serialNumber"];
    }
    if(NotNilAndNull([dic objectForKey:@"name"])){
        self.name= [dic objectForKey:@"name"];
    }
    if(NotNilAndNull([dic objectForKey:@"endDate"] )){
        self.endTime= [dic objectForKey:@"endDate"];
    }
    if(NotNilAndNull([dic objectForKey:@"startDate"] )){
        self.startTime= [dic objectForKey:@"startDate"];
    }
	if(NotNilAndNull([dic objectForKey:@"strParValue"])){
        self.strparValue= [dic objectForKey:@"strParValue"];
    }
    if(NotNilAndNull([dic objectForKey:@"remainingamount"])){
        self.remainingAmount = [NSString stringWithFormat:@"%0.2f",[[dic objectForKey:@"remainingamount"]doubleValue]];
    }
    if(NotNilAndNull([dic objectForKey:@"ticketCategory"] )){
        self.ticketCategory= [dic objectForKey:@"ticketCategory"];
    }
    
    if(NotNilAndNull([dic objectForKey:@"useRule"] )){
        self.useRule= [dic objectForKey:@"useRule"];
    }
    
    if(NotNilAndNull([dic objectForKey:@"couponTemplateDesc"] )){
        self.couponTemplateDesc = [dic objectForKey:@"couponTemplateDesc"];
    }
    
//	self.serialNumber                   = [dic objectForKey:@"serialNumber"];
//	self.name                           = [dic objectForKey:@"name"];
//	self.endTime                        = [dic objectForKey:@"endDate"];
//	self.strparValue                    = [dic objectForKey:@"strParValue"];
//	self.remainingAmount                = [NSString stringWithFormat:@"%0.2f",[[dic objectForKey:@"remainingamount"]doubleValue]];
    
}




@end
