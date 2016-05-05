//
//  LotteryPayRequestService.m
//  SuningEBuy
//
//  Created by cui zl on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LotteryPayRequestService.h"

@implementation LotteryPayRequestService

@synthesize delegate = _delegate;

@synthesize items = _items;

@synthesize unLoginErrorCode;


-(void)dealloc
{
    TT_RELEASE_SAFELY(_items);
    
    TT_RELEASE_SAFELY(_lotteryPayErrorMsg);
    
    TT_RELEASE_SAFELY(unLoginErrorCode);
    
}
-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(lotteryPayHttpMsg);
    HTTPMSG_RELEASE_SAFELY(balanceCheckHttpMsg);
}

-(void)beginLotteryPay:(NSDictionary *)postDic
{
    
    NSString *url;
    
    if (![postDic objectForKey:@"zflag"] || [[postDic objectForKey:@"zflag"] isEqualToString:@""])
    {
        if ([[postDic objectForKey:@"payMethod"] isEqualToString:@"0"])
        {
            url =  [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketPayment];//代购订单易付宝支付提交接口
            
        }
        
        else
        {
            url =  [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryUnionPayment];//代购订单银联支付提交接口
            
            
        }
    }
    else
    {
        if ([[postDic objectForKey:@"payMethod"] isEqualToString:@"0"])
        {
            
            url =[NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketSerialNumberPayment];//追号订单易付宝支付提交接口
        }
        else
        {
            url =[NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotterySerialNumberUnionPayment];//追号订单银联支付提交接口
        }
    }
    
    HTTPMSG_RELEASE_SAFELY(lotteryPayHttpMsg);
    
    lotteryPayHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:postDic
                                                     cmdCode:CC_lotteryPay];
    
    [self.httpMsgCtrl sendHttpMsg:lotteryPayHttpMsg];
    

}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if(receiveMsg.cmdCode == CC_lotteryPay)
    {
        
        self.items = receiveMsg.jasonItems;
        //取session失效值
        NSDictionary *xml = [self.items objectForKey:@"xml"];
        
        self.unLoginErrorCode = [xml objectForKey:@"@errorCode"];
        
        self.lotteryPayErrorMsg = nil;
        
        if(_delegate  && [_delegate respondsToSelector:@selector(getLotteryPayCompletionWithResult:Service:)])
        {
            [_delegate getLotteryPayCompletionWithResult:YES Service:self];
        }
    }
}


-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_lotteryPay)
    {
          self.lotteryPayErrorMsg = self.errorMsg;
        
          if(_delegate  && [_delegate respondsToSelector:@selector(getLotteryPayCompletionWithResult:Service:)])
          {
              [_delegate getLotteryPayCompletionWithResult:NO Service:self];
          }
    }
}

@end
