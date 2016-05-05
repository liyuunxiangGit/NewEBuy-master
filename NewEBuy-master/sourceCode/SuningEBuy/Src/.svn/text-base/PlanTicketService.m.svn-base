//
//  PlanTicketService.m
//  SuningEBuy
//
//  Created by admin on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PlanTicketService.h"
#import "PFOrderBasicDTO.h"
#import "PFOrderDetailDTO.h"
#import "PlanTicketSwitch.h"

@interface PlanTicketService()

- (void)cancelPlanOrderFinished:(BOOL)isSuccess;
- (void)getPlanTicketFinish:(BOOL)isSuccess;
- (void)getPlanTicketDetailFinish:(BOOL)isSuccess;

@end
@implementation PlanTicketService
@synthesize delegate = _delegate;
@synthesize isDataLoaded = _isDataLoaded;
@synthesize orderList = _orderList;
@synthesize totalCount = _totalCount;
@synthesize currentPage = _currentPage;
@synthesize isLastPage = _isLastPage;
@synthesize totalPage = _totalPage;

@synthesize orderDetailDTO = _orderDetailDTO;
@synthesize itemList = _itemList;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_orderList);
}

- (NSMutableArray *)orderList
{
    if (!_orderList) {
        _orderList = [[NSMutableArray alloc] init];
    }
    return _orderList;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(myPlaneTicketMsg);
    HTTPMSG_RELEASE_SAFELY(cancelPlaneTicketMsg)
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{    
   
    NSDictionary *items = receiveMsg.jasonItems;
        
    switch (receiveMsg.cmdCode) {
        case CC_FlightOrderList:
        {
            if (!items)
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                
                [self getPlanTicketFinish:NO];
                
                return;
            }
            else
            {
                [self performSelectorInBackground:@selector(parseOrderList:) withObject:items];
            }
        }
            break;
        case CC_FlightOrderDetail:
        {
            if (!items)
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                
                 [self getPlanTicketDetailFinish:NO];
                
                return;
            }
            else
            {
                [self performSelectorInBackground:@selector(parseOrderDetailInfo:) withObject:items];
            }
        }
            break; 
        case CC_FlightOrderCancel:{
            if (!items)
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                
                [self cancelPlanOrderFinished:NO];
                
                return;
            }
            else
            {
                NSString *isSuccess = [items objectForKey:@"isSucc"];
                if (!IsStrEmpty(isSuccess)&&[isSuccess isEqualToString:@"1"]) {
                    [self cancelPlanOrderFinished:YES];
                }else{
                    NSString *errorMsg = [items objectForKey:@"errorMsg"];
                    if (!IsStrEmpty(errorMsg)) {
                        self.errorMsg = errorMsg;
                    }else{
                        self.errorMsg = L(@"load_failed");
                    }
                    [self cancelPlanOrderFinished:NO];
                    return;
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
        
    switch (receiveMsg.cmdCode) {
        case CC_FlightOrderList:
        {
            [self getPlanTicketFinish:NO];        
        }
            break;  
        case CC_FlightOrderDetail:
        {
            [self getPlanTicketDetailFinish:NO];
        } 
            break;
        case CC_FlightOrderCancel:{
        
            [self cancelPlanOrderFinished:NO];
        }
        default:
            break;
    }
}



-(void)beginCancelPlanOderRequest:(PFOrderBasicDTO *)dto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.userId  forKey:@"userId"];
    
    [postDataDic setObject:dto.ordersId forKey:@"orderId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,kPlaneTicketCancelOrder];   
    
    HTTPMSG_RELEASE_SAFELY(cancelPlaneTicketMsg);
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        cancelPlaneTicketMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:dic
                                                             cmdCode:CC_FlightOrderCancel];
    }else{
        cancelPlaneTicketMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:postDataDic
                                                             cmdCode:CC_FlightOrderCancel];
    }
    
    cancelPlaneTicketMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:cancelPlaneTicketMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)cancelPlanOrderFinished:(BOOL)isSuccess{
    if ([self.delegate respondsToSelector:@selector(endCancelOrderComplete:Result:errorMsg:)]) {
        [self.delegate endCancelOrderComplete:self Result:isSuccess errorMsg:self.errorMsg];
    }
}


-(void)sendPlanOrderrRequest:(NSString *)orderStatus CurrentPage:(NSString *)currentPage
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];

    [postDataDic setObject:IsStrEmpty([UserCenter defaultCenter].userInfoDTO.userId)?@"":[UserCenter defaultCenter].userInfoDTO.userId  forKey:@"userId"];
    
    [postDataDic setObject:orderStatus forKey:@"orderStatus"];
    
    [postDataDic setObject:currentPage forKey:@"currentPage"];
    
    [postDataDic setObject:@"1" forKey:@"dateLimits"];
    
    NSString *url = nil;
    
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketOrderList];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketOrderList];
    }
    HTTPMSG_RELEASE_SAFELY(myPlaneTicketMsg);
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        myPlaneTicketMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_FlightOrderList];
    }else{
        myPlaneTicketMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_FlightOrderList];
    }
    
    myPlaneTicketMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:myPlaneTicketMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)parseOrderList:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSDictionary *orders = [items objectForKey:@"orders"];
            NSArray *datas = nil;
            datas = [orders objectForKey:@"datas"];
            self.isDataLoaded = YES;
            if (datas) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in datas)
                {
                    PFOrderBasicDTO *dto = [[PFOrderBasicDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    [array addObject:dto];
                }
                 self.orderList = array;          
                
            }else{
                [self getPlanTicketFinish:NO];
                return;
            }
            self.totalCount = [self.orderList count];
            
            self.totalPage = [[orders objectForKey:@"pageCount"] intValue];
            //NSInteger totalPageCount = totalDataCount%10 == 0 ? totalDataCount/10 : totalDataCount/10+1;
            
            self.currentPage = [[orders objectForKey:@"pageNumber"] intValue];
            
            if (self.currentPage < self.totalPage)
            {
                self.isLastPage = NO;
                
                self.currentPage++;
            }
            else
            {
                self.isLastPage = YES;
            }
    //        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
            dispatch_async(dispatch_get_main_queue(), ^{           
                    [self getPlanTicketFinish:YES]; 
            });
        }
           
    });
}

- (void)getPlanTicketFinish:(BOOL)isSuccess 
{        
        if (_delegate && [_delegate respondsToSelector:@selector(getPlanTicketService:Result:errorMsg:)]) {
            [_delegate getPlanTicketService:self Result:isSuccess errorMsg:self.errorMsg];
        } 
}

//dispatch_async(dispatch_get_main_queue(), ^{
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(getPlanTicketService:Result:errorMsg:)]) {
//        [_delegate getPlanTicketService:self Result:isSuccess errorMsg:self.errorMsg];
//    }
//});

-(void)sendPlanOrderDetailRequest:(NSMutableDictionary *)postDataDic
{    
    NSString *url = nil;
    
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketOrderInfo];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketOrderInfo];
    }
    HTTPMSG_RELEASE_SAFELY(myPlaneTicketMsg);
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        myPlaneTicketMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_FlightOrderDetail];
    }else{
           
        myPlaneTicketMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_FlightOrderDetail];
    }
    myPlaneTicketMsg.timeout = kPlaneTicketTimeOut;
    [self.httpMsgCtrl sendHttpMsg:myPlaneTicketMsg];
    
}


- (void)parseOrderDetailInfo:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            PFOrderDetailDTO *dto = [[PFOrderDetailDTO alloc] init];
            [dto encodeFromDictionary:items];
            self.orderDetailDTO = dto;
//            self.itemList = [self.orderDetailDTO cellTypeInfoArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getPlanTicketDetailFinish:YES]; 
            });
        }
    });
}
                   
- (void)getPlanTicketDetailFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getPlanTicketDetailService:Result:errorMsg:)]) {
        [_delegate getPlanTicketDetailService:self Result:isSuccess errorMsg:self.errorMsg];
    } 
}
     



@end
