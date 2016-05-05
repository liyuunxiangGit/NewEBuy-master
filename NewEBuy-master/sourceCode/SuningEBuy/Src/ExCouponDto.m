//
//  ;
//  SuningEBuy
//
//  Created by david david on 12-6-21.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ExCouponDto.h"

@implementation ExCouponDto

@synthesize billType = _billType;
@synthesize billNo = _billNo;
@synthesize sellMoney = _sellMoney;
@synthesize batchMoney = _batchMoney;
@synthesize beginDate = _beginDate;
@synthesize endDate = _endDate;
@synthesize processTime = _processTime;



-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
    if(NotNilAndNull([dic objectForKey:@"billType"])){
        self.billType= [dic objectForKey:@"billType"];
    }
    if(NotNilAndNull([dic objectForKey:@"billNo"])){
        self.billNo = [dic objectForKey:@"billNo"];
    }
    if(NotNilAndNull([dic objectForKey:@"sellMoney"])){
        self.sellMoney= [dic objectForKey:@"sellMoney"];
    }
    if(NotNilAndNull([dic objectForKey:@"batchMoney"])){
        self.batchMoney= [dic objectForKey:@"batchMoney"];
    }
    if(NotNilAndNull([dic objectForKey:@"beginDate"])){
        self.beginDate= [dic objectForKey:@"beginDate"];
    }
    if(NotNilAndNull([dic objectForKey:@"endDate"])){
        self.endDate= [dic objectForKey:@"endDate"];
    }
    if(NotNilAndNull([dic objectForKey:@"processTime"])){
        self.processTime= [dic objectForKey:@"processTime"];
    }

    
}



@end
