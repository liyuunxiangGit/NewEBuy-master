//
//  PFOrderBasicDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PFOrderBasicDTO.h"
#import "PlanTicketSwitch.h"

@implementation PFOrderBasicDTO


@synthesize ordersId = _ordersId;
@synthesize usersId = _usersId;
@synthesize status = _status;
@synthesize creatTime = _creatTime;
@synthesize totalAmount = _totalAmount;
@synthesize travNum = _travNum;
@synthesize startAirportName = _startAirportName;
@synthesize arrivAirportName = _arrivAirportName;
@synthesize airlineType = _airlineType;
@synthesize insuranceTotalAmount = _insuranceTotalAmount;
@synthesize ticketTotalAmount = _ticketTotalAmount;

- (void)dealloc {
    TT_RELEASE_SAFELY(_ordersId);
    TT_RELEASE_SAFELY(_usersId);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_creatTime);
    TT_RELEASE_SAFELY(_totalAmount);
    TT_RELEASE_SAFELY(_travNum);
    TT_RELEASE_SAFELY(_startAirportName);
    TT_RELEASE_SAFELY(_arrivAirportName);
    TT_RELEASE_SAFELY(_airlineType);
    TT_RELEASE_SAFELY(_insuranceTotalAmount);
    TT_RELEASE_SAFELY(_ticketTotalAmount);
}


- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    NSNumber *__ordersId = [dic objectForKey:@"orders_id"];
    NSNumber *__usersId = [dic objectForKey:@"users_id"];
    NSString *__status = [dic objectForKey:@"status"];
    NSString *__creatTime = [dic objectForKey:@"createtime"];
    
    if ([PlanTicketSwitch canUserNewServer])
    {
        NSString *__totalAmount = [dic objectForKey:@"totalamount"];
        if (NotNilAndNull(__totalAmount))   self.totalAmount = __totalAmount;
    }
    else
    {
        NSDecimalNumber *__totalAmount = [dic objectForKey:@"totalamount"];
        if (NotNilAndNull(__totalAmount))   self.totalAmount = [__totalAmount stringValue];
    }
    
    NSNumber *__travNum = [dic objectForKey:@"travnum"];
    NSString *__startAirport = [dic objectForKey:@"startairportname"];
    NSString *__arrivAirport = [dic objectForKey:@"arriveairportname"];
    NSString *__airlineType = [dic objectForKey:@"airline_type"];
    NSString *__ticketTotalAmount = [dic objectForKey:@"ticketTotalAmount"];
    NSString *__insuranceTotalAmount = [dic objectForKey:@"insuranceTotalAmount"];
    
    if (NotNilAndNull(__ordersId))      self.ordersId = [__ordersId stringValue];
    if (NotNilAndNull(__usersId))       self.usersId = [__usersId stringValue];
    if (NotNilAndNull(__status))   self.status = __status;
    if (NotNilAndNull(__creatTime))   self.creatTime = __creatTime;
    if (NotNilAndNull(__travNum))   self.travNum = [__travNum stringValue];
    if (NotNilAndNull(__startAirport))   self.startAirportName = __startAirport;
    if (NotNilAndNull(__arrivAirport))   self.arrivAirportName = __arrivAirport;
    if (NotNilAndNull(__airlineType))   self.airlineType = __airlineType;
    if (NotNilAndNull(__insuranceTotalAmount)) self.insuranceTotalAmount = __insuranceTotalAmount;
    if (NotNilAndNull(__ticketTotalAmount)) self.ticketTotalAmount = __ticketTotalAmount;
}


@end
