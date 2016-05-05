//
//  AgentPurchaseOrderService.m
//  SuningEBuy
//
//  Created by cui zl on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AgentPurchaseOrderService.h"

@implementation AgentPurchaseOrderService


-(void)dealloc
{
    TT_RELEASE_SAFELY(_orderRequestErrorMsg);
    TT_RELEASE_SAFELY(_projid);
    HTTPMSG_RELEASE_SAFELY(agentPurchaseHttpMsg);
    
}

-(void)submitLotteryOrderRequest:(NSDictionary *)orderDic
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketPayment];
    
    HTTPMSG_RELEASE_SAFELY(agentPurchaseHttpMsg);
    
    agentPurchaseHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:orderDic cmdCode:CC_AgentPurchasePayment];
    
    [self.httpMsgCtrl sendHttpMsg:agentPurchaseHttpMsg];
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
//    [super requestFailed:receiveMsg];
    
    self.orderRequestErrorMsg = self.errorMsg;
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    
    if (jsonObject)
    {
        NSString *errorCode = jsonObject[kHttpResponseCode];
        
        if ([errorCode isEqualToString:@"0"])
        {
            self.projid = [jsonObject[@"result"] objectForKey:@"@projid"];
            self.balance = [[jsonObject[@"result"] objectForKey:@"@balance"] floatValue];
            
            self.orderRequestErrorMsg = nil;
        }
        else if ([errorCode isEqualToString:@"1"]) // 用户未登录
        {
            self.orderRequestErrorMsg = kHttpResponseUserNotLoggedIn;
        }
        else // 支付密码校验失败、彩票期次过期交易失败、余额不足交易失败，其它原因交易失败
        {
            self.orderRequestErrorMsg = jsonObject[kHttpResponseDesc];
        }
    }
}


@end
