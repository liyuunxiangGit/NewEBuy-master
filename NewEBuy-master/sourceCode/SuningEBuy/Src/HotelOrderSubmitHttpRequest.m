//
//  HotelOrderSubmitHttpRequest.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-4.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelOrderSubmitHttpRequest.h"
#import "HotelOrder.h"

@implementation HotelOrderSubmitHttpRequest

@synthesize delegate = _delegate;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)dealloc {
    
    HTTP_RELEASE_SAFELY(hotelOrderASIHTTPRequest);
    
}

- (void)hotelOrderSubmitHttpRequest:(NSMutableDictionary *)postDataDic{
    
    HTTP_RELEASE_SAFELY(hotelOrderASIHTTPRequest);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostHotelOrderForHttp, KHTTPRequestHotelBookOrder];

//    NSString *url = @"http://10.21.145.120:8080/hotel-pay-web/hotelTerminal/fnd/hotelBookOrder.htm";
    
    hotelOrderASIHTTPRequest = [Http sendHttpRequest:@"send http request"
                                                  URL:url
                                           UrlParaDic:postDataDic
                                             Delegate:self
                                       SucessCallback:@selector(requestOK:)
                                         FailCallback:@selector(requestFail:)];
    
    
	if(!hotelOrderASIHTTPRequest){
        
		return;
	}
}

- (void)requestOK:(ASIFormDataRequest *)request{
    
    NSString *responseString = [request responseString];
    
    DLog(@"request string is %@", request.responseString);
    
    NSDictionary *item = [responseString JSONValue2];
        
    NSString *checkResult = [item objectForKey:@"checkResult"];

    [self httpRequestResult:YES errorCode:@"" errorDesc:checkResult];
    
    [self nextSectePayWay:item];
}

-(void)nextSectePayWay:(NSDictionary *)items
{
    NSString *checkResult = [items objectForKey:@"checkResult"];
    
    if (checkResult == nil || [checkResult isEqualToString:@""]) {
        //获取订单号
        NSString *orderId = [items objectForKey:@"XfOrderNo"];
        
        DLog(@"orderNo:%@", orderId);
        
        if (orderId !=nil && ![orderId isEqualToString:@""]) {
            
            SuningMainClick *orderInfo=[SuningMainClick sharedInstance];
            
            [orderInfo getOrderAndSave:orderId];
            
        }

    }
}


- (void)requestFail:(ASIFormDataRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSDictionary *item = [responseString JSONValue2];
    
    NSString *checkResult = [item objectForKey:@"checkResult"];
        
    [self httpRequestResult:NO errorCode:@"" errorDesc:checkResult];
    
//    AlertMessageView *alert = [[AlertMessageView alloc] init];
//    [alert alertMessage:L(@"Sorry loading failed")];

}


- (void)httpRequestResult:(BOOL)successResult errorCode:(NSString *)errorCode errorDesc:(NSString *)errorDesc{
    
    if ([_delegate conformsToProtocol:@protocol(HotelOrderSubmitHttpRequestDelegate) ]) {
        
        if ([_delegate respondsToSelector:@selector(httpRequestCompleted:errorCode:errorDesc:)]) {
            
            [_delegate httpRequestCompleted:successResult errorCode:errorCode errorDesc:errorDesc];
        }
    }
}





@end
