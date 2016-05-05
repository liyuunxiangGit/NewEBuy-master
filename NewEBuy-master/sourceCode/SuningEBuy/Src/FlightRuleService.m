//
//  FlightRuleService.m
//  SuningEBuy
//
//  Created by admin on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FlightRuleService.h"
#import "FlightRoomInfoDTO.h"
#import "PlanTicketSwitch.h"

@implementation FlightRuleService
@synthesize delegate = _delegate;
@synthesize  isLoadingOK = _isLoadingOK;



- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(ruleMsg);
}

- (void)getGoFlightTicketRuletFinish:(BOOL)isSuccess ruleInfo:(NSString *)ruleInfo
{
    if (_delegate && [_delegate respondsToSelector:@selector(getPlanTicketRuleInfoCompletionWithRequest:errorMsg:ruleInfo:)])
    {
        [_delegate getPlanTicketRuleInfoCompletionWithRequest:isSuccess
                                                     errorMsg:self.errorMsg
                                                     ruleInfo:ruleInfo];
    }
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items)
    {
        self.errorMsg = L(@"load_failed");
        
        [self getGoFlightTicketRuletFinish:NO ruleInfo:nil];
    }
    else
    {
        if ([PlanTicketSwitch canUserNewServer]) {

            NSString *refund = [items objectForKey:@"refund"];
            [self getGoFlightTicketRuletFinish:YES ruleInfo:NotNilAndNull(refund)?refund:@""];
        }else{
            
            NSMutableString *refund = [NSMutableString string];
            
            NSString *changeDate = [items objectForKey:@"changeDate"];
            if (NotNilAndNull(changeDate)) {
                [refund appendFormat:@"%@%@\n",L(@"BTRescheduleRule"),changeDate];
            }
            
            NSString *upgrate = [items objectForKey:@"upgrate"];
            if (NotNilAndNull(upgrate)) {
                [refund appendFormat:@"%@%@\n",L(@"BTUpdataRule"), upgrate];
            }
            
            NSString *change = [items objectForKey:@"change"];
            if (NotNilAndNull(change)) {
                [refund appendFormat:@"%@%@\n", L(@"BTTransferRule"),change];
            }
            
            NSString *rule = [items objectForKey:@"refund"];
            if (NotNilAndNull(rule)) {
                [refund appendFormat:@"%@%@", L(@"BTRefundRule"),rule];
            }
            [self getGoFlightTicketRuletFinish:YES ruleInfo:refund];
            
        }
        
        
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getGoFlightTicketRuletFinish:NO ruleInfo:nil];
}

- (void)beginGetPlanTicketRuleInfoRequest:(FlightInfoDTO *)filghtInfo
{
    if (filghtInfo == nil || [filghtInfo.roomList count] == 0)
    {
        return;
    }
    
    FlightRoomInfoDTO *room = [filghtInfo.roomList objectAtIndex:0];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketRuleInfo];
        [postDataDic setObject:filghtInfo.company?filghtInfo.company:@"" forKey:@"company"];
        [postDataDic setObject:filghtInfo.fDate?filghtInfo.fDate:@"" forKey:@"fDate"];
        [postDataDic setObject:room.room?room.room:@"" forKey:@"room"];
        [postDataDic setObject:room.rule?room.rule:@"" forKey:@"rule"];
        [postDataDic setObject:room.supplyId?room.supplyId:@"" forKey:@"supplyId"];
        [postDataDic setObject:room.supplyPolicyId?room.supplyPolicyId:@"" forKey:@"supplyPolicyId"];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketRuleInfo];
        [postDataDic setObject:room.rule?room.rule:@"" forKey:@"rule"];
    }
    
    HTTPMSG_RELEASE_SAFELY(ruleMsg);
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        ruleMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_FlightTicketRule];
    }else{
        ruleMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:postDataDic
                                                cmdCode:CC_FlightTicketRule];
    }
    ruleMsg.timeout = kPlaneTicketTimeOut;
    
    TT_RELEASE_SAFELY(postDataDic);
    [self.httpMsgCtrl sendHttpMsg:ruleMsg];
}


@end
