//
//  AirlineInfoDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AirlineInfoDTO.h"

@implementation AirlineInfoDTO

@synthesize airlineType = _airlineType;
@synthesize airlineInfo = _airlineInfo;
@synthesize startTime = _startTime;
@synthesize startAirport = _startAirport;
@synthesize arriveAirport = _arriveAirport;
@synthesize arriveTime = _arriveTime;
@synthesize returnChangeId = _returnChangeId;
@synthesize startCityName = _startCityName;
@synthesize arriveCityName = _arriveCityName;
@synthesize airlineComName = _airlineComName;
@synthesize flightNo = _flightNo;
@synthesize airlineCode = _airlineCode;
@synthesize returnChangeId2 = _returnChangeId2;
@synthesize ticketRefund = _ticketRefund;
@synthesize ticketChangeDate = _ticketChangeDate;
@synthesize ticketChange = _ticketChange;
@synthesize ticketUpgrate = _ticketUpgrate;

- (void)dealloc {
    TT_RELEASE_SAFELY(_airlineType);
    TT_RELEASE_SAFELY(_airlineInfo);
    TT_RELEASE_SAFELY(_startTime);
    TT_RELEASE_SAFELY(_startCityName);
    TT_RELEASE_SAFELY(_startAirport);
    TT_RELEASE_SAFELY(_arriveTime);
    TT_RELEASE_SAFELY(_arriveCityName);
    TT_RELEASE_SAFELY(_arriveAirport);
    TT_RELEASE_SAFELY(_returnChangeId);
    TT_RELEASE_SAFELY(_airlineComName);
    TT_RELEASE_SAFELY(_flightNo);
    TT_RELEASE_SAFELY(_airlineCode);
    TT_RELEASE_SAFELY(_returnChangeId2);
    TT_RELEASE_SAFELY(_ticketRefund);
    TT_RELEASE_SAFELY(_ticketChangeDate);
    TT_RELEASE_SAFELY(_ticketChange);
    TT_RELEASE_SAFELY(_ticketUpgrate);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    NSString *__airlineType = [dic objectForKey:@"airline_type"];
    NSString *__airlineInfo = [dic objectForKey:@"airlineinfo"];
    NSString *__startTime = [dic objectForKey:@"starttime"];
    NSString *__startAirport = [dic objectForKey:@"startairport"];
    NSString *__startCityName = [dic objectForKey:@"startcityname"];
    NSString *__arriveTime = [dic objectForKey:@"arrivetime"];
    NSString *__arriveAirport = [dic objectForKey:@"arriveairport"];
    NSString *__arriveCityName = [dic objectForKey:@"arrivecityname"];
    NSString *__returnChangeId = [dic objectForKey:@"returnchange_id"];
    NSString *__airlineComName = [dic objectForKey:@"airlinecomname"];
    NSString *__flightNo = [dic objectForKey:@"flightno"];
    NSString *__airlineCode = [dic objectForKey:@"airlinecode"];
    NSDictionary *ruleInfo = [dic objectForKey:@"ruleInfo"];
    
    if (NotNilAndNull(__airlineType))   self.airlineType = __airlineType;
    if (NotNilAndNull(__airlineInfo))   self.airlineInfo = __airlineInfo;
    if (NotNilAndNull(__startTime))   self.startTime = __startTime;
    if (NotNilAndNull(__startAirport))   self.startAirport = __startAirport;
    if (NotNilAndNull(__startCityName))   self.startCityName = __startCityName;
    if (NotNilAndNull(__arriveTime))   self.arriveTime = __arriveTime;
    if (NotNilAndNull(__arriveAirport))   self.arriveAirport = __arriveAirport;
    if (NotNilAndNull(__arriveCityName))   self.arriveCityName = __arriveCityName;
    if (NotNilAndNull(__returnChangeId))   self.returnChangeId = __returnChangeId;
    if (NotNilAndNull(__airlineComName))   self.airlineComName = __airlineComName;
    if (NotNilAndNull(__flightNo))   self.flightNo = __flightNo;
    if (NotNilAndNull(__airlineCode))   self.airlineCode = __airlineCode;
    if (NotNilAndNull(ruleInfo) && [ruleInfo isKindOfClass:[NSDictionary class]])   
    {
        NSString *__changeId2 = [ruleInfo objectForKey:@"returnchangeId"];
        NSString *__ticketRefund = [ruleInfo objectForKey:@"ticketRefund"];
        NSString *__ticketChangeDate = [ruleInfo objectForKey:@"ticketChangeDate"];
        NSString *__ticketChange = [ruleInfo objectForKey:@"ticketChange"];
        NSString *__ticketUpgrate = [ruleInfo objectForKey:@"ticketUpgrate"];
        
        if (NotNilAndNull(__changeId2))   self.returnChangeId2 = __changeId2;
        if (NotNilAndNull(__ticketRefund))   self.ticketRefund = __ticketRefund;
        if (NotNilAndNull(__ticketChange))   self.ticketChange = __ticketChange;
        if (NotNilAndNull(__ticketChangeDate))   self.ticketChangeDate = __ticketChangeDate;
        if (NotNilAndNull(__ticketUpgrate))   self.ticketUpgrate = __ticketUpgrate;
    }
    
}

@end
