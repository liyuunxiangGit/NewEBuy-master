//
//  MemberOrderCenterDTO.m
//  SuningEMall
//
//  Created by lcj lcj on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderCenterDTO.h"


@implementation MemberOrderCenterDTO
@synthesize	orderType=_orderType;
@synthesize	orderNum=_orderNum;

-(void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
	NSString *orderType	= [dic objectForKey:kResponseMemberOrderType];
	NSString *orderNum	= [dic objectForKey:kResponseMemberOrderNum];
	
	if (NotNilAndNull(orderType)) {
		self.orderType = orderType;
	}
	
	if (NotNilAndNull(orderNum)) {
		self.orderNum = orderNum;
	}
	
}

@end
