//
//  QueryTicketInfoService.m
//  SuningEBuy
//
//  Created by admin on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "QueryTicketInfoService.h"
#import "DataService.h"
#import "FlightListHttpDataSource.h"
#import "PlanTicketSwitch.h"
#import "PasswdUtil.h"

@interface QueryTicketInfoService()

-(void)didGetFlightListFinish:(BOOL)isSuccess;
-(void)getBackFlightListFinish:(BOOL)isSuccess;

- (void)parseBackFlight:(NSDictionary *)items;
- (void)parseGoPlanTicketInfo:(NSDictionary *)items;

@end

@implementation QueryTicketInfoService
@synthesize     delegate        = _delegate;
@synthesize     isResultNull    = _isResultNull;
@synthesize     isLoaded        = _isLoaded;
@synthesize     flightList      = _flightList;
@synthesize     displayList     = _displayList;
@synthesize     companyList     = _companyList;

@synthesize     isReturnLoaded  = _isReturnLoaded;
@synthesize     rFlightCompanyList = _rFlightCompanyList;
@synthesize     returnFlightList = _returnFlightList;
-(void)dealloc
{
    TT_RELEASE_SAFELY(_flightList);
    TT_RELEASE_SAFELY(_displayList);
    TT_RELEASE_SAFELY(_companyList);
    TT_RELEASE_SAFELY(_rFlightCompanyList);
    TT_RELEASE_SAFELY(_returnFlightList);
}


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(goMsg);
    HTTPMSG_RELEASE_SAFELY(backMsg);
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    switch (receiveMsg.cmdCode) {
        case CC_GoFlightInfoList:
        {
            if (!items)
            {
                self.errorMsg = L(@"load_failed");
                
                [self didGetFlightListFinish:NO];
                
                return;
            }
            else
            {
                NSDictionary *item = receiveMsg.jasonItems;
                
                NSString *statusCode = [item objectForKey:@"statusCode"];
                
                if ([statusCode isEqualToString:@"1"]) {
                    
                    [self parseGoPlanTicketInfo :item];
                    
                }else{
                    
                    NSString *errorDesc = [NSString stringWithFormat:@"flightList_%@",statusCode];
                    
                    self.errorMsg = errorDesc;
                    
                    self.displayList = nil;
                    
                    [self didGetFlightListFinish:NO];
                    
                }
            }
        }
            break;
        case CC_BackFlightInfoList:
        {
            if (!items)
            {
                self.errorMsg = L(@"load_failed");
                
                [self getBackFlightListFinish:NO];
                
                return;
            }
            else
            {
                NSDictionary *item = receiveMsg.jasonItems;
                
                NSString *statusCode = [item objectForKey:@"statusCode"];
                
                if ([statusCode isEqualToString:@"1"]) {
                    
                    [self parseBackFlight:item];
                    
                }else{
                    
                    NSString *errorDesc = [NSString stringWithFormat:@"flightList_%@",statusCode];
                    
                    self.errorMsg = errorDesc;
                    
                    self.returnFlightList = nil;
                    
                    [self getBackFlightListFinish:NO];
                    
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    DLog("requestLotteryHallFail == \n%@", receiveMsg.errorCode);
    
    switch (receiveMsg.cmdCode) {
        case CC_GoFlightInfoList:
        {
            [self didGetFlightListFinish:NO];
        }
            break;
        case CC_BackFlightInfoList:
        {
            [self getBackFlightListFinish:NO];
        }
        default:
            break;
    }
}

- (void)parseGoPlanTicketInfo:(NSDictionary *)items
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
            NSArray *arr = [FlightListHttpDataSource parseFlightList:items];
            
            if (!IsNilOrNull(arr)) {
                self.flightList = arr;
            }
            TT_RELEASE_SAFELY(arr);
            
        }
        
        self.displayList = self.flightList;
        
        @autoreleasepool {
            
            NSArray *companyArr = [FlightListHttpDataSource parseCompanyList:items];
            
            if (!IsNilOrNull(companyArr)) {
                
                self.companyList = companyArr;
                
            }
            
            TT_RELEASE_SAFELY(companyArr);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self didGetFlightListFinish:YES];
        });
        
    });
    
}

- (void)beginGetPlanTicketList:(NSString *)startCity
                    toStopCity:(NSString *)stopCity
                   atStartTime:(NSString *)startTime{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:startCity forKey:@"orgAirport"];
    [postDataDic setObject:stopCity forKey:@"desAirport"];
    [postDataDic setObject:startTime forKey:@"flyDate"];
    
    NSString *url = nil;
    
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketFlightInfo];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketFlightInfo];
    }
    HTTPMSG_RELEASE_SAFELY(goMsg);

    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        goMsg = [[HttpMessage alloc] initWithDelegate:self
                                           requestUrl:url
                                          postDataDic:dic
                                              cmdCode:CC_GoFlightInfoList];
    }else{
        goMsg = [[HttpMessage alloc] initWithDelegate:self
                                           requestUrl:url
                                          postDataDic:postDataDic
                                              cmdCode:CC_GoFlightInfoList];
    }
    goMsg.canMultipleConcurrent = YES;
    goMsg.timeout = kPlaneTicketTimeOut;
    [self.httpMsgCtrl sendHttpMsg:goMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

- (void)parseBackFlight:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
            NSArray *arr = [FlightListHttpDataSource parseFlightList:items];
            
            if (!IsNilOrNull(arr)) {
                
                self.returnFlightList = arr;
            }
            
            TT_RELEASE_SAFELY(arr);
            
        }
        
        @autoreleasepool {
            
            NSArray *companyArr = [FlightListHttpDataSource parseCompanyList:items];
            
            if (!IsNilOrNull(companyArr)) {
                
                self.rFlightCompanyList = companyArr;
            }
            
            TT_RELEASE_SAFELY(companyArr);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getBackFlightListFinish:YES];
        });
    });
}


- (void)beginGetReturnPlanTicketList:(NSString *)startCity
                          toStopCity:(NSString *)stopCity
                        atReturnTime:(NSString *)returnTime{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:startCity forKey:@"orgAirport"];
    
    [postDataDic setObject:stopCity forKey:@"desAirport"];
    
    [postDataDic setObject:returnTime forKey:@"flyDate"];
    
    NSString *url = nil;
    
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketFlightInfo];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketFlightInfo];
    }
    
    HTTPMSG_RELEASE_SAFELY(backMsg);

    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        backMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_BackFlightInfoList];
    }else{
        backMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:postDataDic
                                                cmdCode:CC_BackFlightInfoList];
    }
    backMsg.canMultipleConcurrent = YES;
    backMsg.timeout = kPlaneTicketTimeOut;
    [self.httpMsgCtrl sendHttpMsg:backMsg];
    TT_RELEASE_SAFELY(postDataDic);
    
}

-(void)didGetFlightListFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getGoFlightTicketService:Result:errorMsg:)])
    {
        [_delegate getGoFlightTicketService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

-(void)getBackFlightListFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getGoFlightTicketService:Result:errorMsg:)])
    {
        [_delegate getGoFlightTicketService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

@end
