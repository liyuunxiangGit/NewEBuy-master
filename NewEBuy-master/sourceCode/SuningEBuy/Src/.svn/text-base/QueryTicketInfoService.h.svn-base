//
//  QueryTicketInfoService.h
//  SuningEBuy
//
//  Created by admin on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataService;
@class FlightInfoDelegate;
@class QueryTicketInfoService;
@protocol FlightInfoDelegate <NSObject>
-(void)getGoFlightTicketService:(QueryTicketInfoService *)service 
                     Result:(BOOL)isSuccess
                   errorMsg:(NSString *)errorMsg;
-(void)getBackFlightTicketService:(QueryTicketInfoService *)service 
                         Result:(BOOL)isSuccess
                       errorMsg:(NSString *)errorMsg;
@end


@interface QueryTicketInfoService : DataService
{
    HttpMessage *goMsg;
    HttpMessage *backMsg;
}

@property (nonatomic,weak)     id          delegate;
@property (nonatomic,assign)     BOOL        isResultNull;
@property (nonatomic,assign)     BOOL        isLoaded;
@property (nonatomic,strong)     NSArray     *flightList;
@property (nonatomic,strong)     NSArray     *displayList;
@property (nonatomic,strong)     NSArray     *companyList;

@property (nonatomic,assign)     BOOL        isReturnLoaded;
@property (nonatomic,strong)     NSArray     *rFlightCompanyList;
@property (nonatomic,strong)     NSArray     *returnFlightList;

- (void)beginGetPlanTicketList:(NSString *)startCity 
                    toStopCity:(NSString *)stopCity 
                    atStartTime:(NSString *)startTime;

- (void)beginGetReturnPlanTicketList:(NSString *)startCity 
                        toStopCity:(NSString *)stopCity 
                       atReturnTime:(NSString *)returnTime;

@end
