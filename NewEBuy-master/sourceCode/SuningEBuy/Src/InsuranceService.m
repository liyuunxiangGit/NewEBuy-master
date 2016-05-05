//
//  InsuranceService.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InsuranceService.h"
#import "PlanTicketSwitch.h"

@interface InsuranceService()

- (void)parseResultInsuranceList:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation InsuranceService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(queryInsuranceHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)beginGetInsuranceListRequest
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostPlaneTicketOctForHttp, kPlaneTicketQueryInsurance];
    
    HTTPMSG_RELEASE_SAFELY(queryInsuranceHttpMsg);
    
    queryInsuranceHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:nil
                                                          cmdCode:CC_QueryInsurance];
    queryInsuranceHttpMsg.timeout = kPlaneTicketTimeOut;
    [self.httpMsgCtrl sendHttpMsg:queryInsuranceHttpMsg];
}

#pragma mark -
#pragma mark final

- (void)getInsuranceListOk:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getInsuranceListCompletionWithResult:
                                                             errorMsg:
                                                             insuranceList:)]) {
        [_delegate getInsuranceListCompletionWithResult:isSuccess
                                               errorMsg:self.errorMsg
                                          insuranceList:list];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getInsuranceListOk:NO list:nil];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getInsuranceListOk:NO list:nil];
    }else{
        
        [self parseResultInsuranceList:items];
    }
}

#pragma mark -
#pragma mark parse data

- (void)parseResultInsuranceList:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
            NSArray *insurances = [items objectForKey:@"insurance"];
            
            NSMutableArray *retList = nil;
            
            if (NotNilAndNull(insurances) && [insurances count] > 0) {
                
                retList = [[NSMutableArray alloc] initWithCapacity:[insurances count]];
                
                for (NSDictionary *dic in insurances)
                {
                    InsuranceDTO *dto = [[InsuranceDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    if ([dto.sellNum intValue] >= 1) {
                        [retList addObject:dto];
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getInsuranceListOk:YES list:retList];
            });

        }
    });
}

@end
