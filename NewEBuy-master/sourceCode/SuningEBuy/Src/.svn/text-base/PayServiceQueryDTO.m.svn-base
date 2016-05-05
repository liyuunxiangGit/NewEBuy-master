//
//  PayServiceQueryDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PayServiceQueryDTO.h"


@implementation PayServiceQueryDTO

@synthesize companyName = _companyName;
@synthesize orderId = _orderId;
@synthesize orderName = _orderName;
@synthesize orderNo = _orderNo;
@synthesize payAmount = _payAmount;
@synthesize payTime = _payTime;
@synthesize status = _status;
@synthesize statusName = _statusName;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_companyName);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderName);
    TT_RELEASE_SAFELY(_orderNo);
    TT_RELEASE_SAFELY(_payAmount);
    TT_RELEASE_SAFELY(_payTime);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_statusName);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if(NotNilAndNull([dic objectForKey:@"companyName"])){
        self.companyName=[dic objectForKey:@"companyName"];
    }
    if(NotNilAndNull([dic objectForKey:@"orderId"])){
        self.orderId=[dic objectForKey:@"orderId"];
    }
    if(NotNilAndNull([dic objectForKey:@"orderName"])){
        self.orderName=[dic objectForKey:@"orderName"];
    }
    if(NotNilAndNull([dic objectForKey:@"orderNo"])){
        self.orderNo=[dic objectForKey:@"orderNo"];
    }
    if(NotNilAndNull( [dic objectForKey:@"payAmount"])){
        self.payAmount= [dic objectForKey:@"payAmount"];
    }
    if(NotNilAndNull([dic objectForKey:@"payTime"])){
        self.payTime=[dic objectForKey:@"payTime"];
    }
    if(NotNilAndNull([dic objectForKey:@"status"])){
        self.status=[dic objectForKey:@"status"];
    }
    if(NotNilAndNull([dic objectForKey:@"statusName"])){
        self.statusName=[dic objectForKey:@"statusName"];
    }
    //    self.companyName = [dic objectForKey:@"companyName"];
    //
    //    self.orderId = [dic objectForKey:@"orderId"];
    //
    //    self.orderName = [dic objectForKey:@"orderName"];
    //
    //    self.orderNo = [dic objectForKey:@"orderNo"];
    //
    //    self.payAmount = [dic objectForKey:@"payAmount"];
    //
    //    self.payTime = [dic objectForKey:@"payTime"];
    //
    //    self.status = [dic objectForKey:@"status"];
    //
    //    self.statusName = [dic objectForKey:@"statusName"];
}

@end
