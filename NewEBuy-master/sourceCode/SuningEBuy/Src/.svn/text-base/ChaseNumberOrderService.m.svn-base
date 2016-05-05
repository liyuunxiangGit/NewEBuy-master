//
//  ChaseNumberOrderService.m
//  SuningEBuy
//
//  Created by cui zl on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ChaseNumberOrderService.h"

@implementation ChaseNumberOrderService



- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderRequestErrorMsg);
    TT_RELEASE_SAFELY(_projid);
    
}

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(chaseNumberOrderHttpMsg);
}

-(void)submitChaseNumberOrderRequest:(NSDictionary *)orderDic
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketPayment];
    
    HTTPMSG_RELEASE_SAFELY(chaseNumberOrderHttpMsg);
    
    chaseNumberOrderHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:orderDic cmdCode:CC_ChaseNumberPayment];
    
    [self.httpMsgCtrl sendHttpMsg:chaseNumberOrderHttpMsg];

    TT_RELEASE_SAFELY(orderDic);
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    
    if (jsonObject)
    {
        NSString *errorCode = jsonObject[kHttpResponseCode];
        
        if ([errorCode isEqualToString:@"0"])
        {
            self.projid = [jsonObject[@"zhuihao"] objectForKey:@"@id"];
            
            self.orderRequestErrorMsg = nil;
        }
        else if ([errorCode isEqualToString:@"1"]) // 用户未登录
        {
            self.orderRequestErrorMsg = kHttpResponseUserNotLoggedIn;
        }
        else // 支付密码校验失败、追号信息检验失败、追号金额不正确、余额不足交易失败，其它原因交易失败
        {
            self.orderRequestErrorMsg = jsonObject[kHttpResponseDesc];
        }
    }

}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    
}

@end
