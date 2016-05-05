//
//  OrderCenterService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "OrderCenterService.h"

#import "orderHttpDataSource.h"

#import "InnerAdHTTPDataSource.h"

@implementation OrderCenterService

@synthesize delegate = _delegate;

@synthesize orderStatInfo = _orderStatInfo;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
        
    TT_RELEASE_SAFELY(_orderStatInfo);
        
}


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_orderHttpMsg);
    [super httpMsgRelease];
}


- (void)beginSendOrderHttpRequest{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberOrderCenterAmount ];
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue 
                    forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue 
                    forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDataDic setObject:(userId == nil ? @"" : userId)  
                    forKey:kHttpResponseUserId];
    
    [postDataDic setObject:kHttpRequestMemberSelectTimeValue 
                    forKey:kHttpRequestMemberSelectTime];    
    
    HTTPMSG_RELEASE_SAFELY(_orderHttpMsg);
    
    
    _orderHttpMsg =  [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_OrderCenter];
    
    _orderHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_orderHttpMsg];
    
    
    TT_RELEASE_SAFELY(postDataDic);
    
}


- (void)sendOrderHttpRequestOk:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if ([receiveMsg.errorCode isEqualToString:@"1"])
    {
        self.orderStatInfo = [orderHttpDataSource parseOrderInfo:items];
        
        if (self.delegate && [_delegate respondsToSelector:@selector(orderCenterHttpRequestCompletedWithResult: isSucccess:errorCode:)])
        {
            [_delegate orderCenterHttpRequestCompletedWithResult:_orderStatInfo
                                                      isSucccess:YES
                                                       errorCode:receiveMsg.errorCode];
            
        }
    }
    else
    {
        if (self.delegate && [_delegate respondsToSelector:@selector(orderCenterHttpRequestCompletedWithResult: isSucccess:errorCode:)])
        {
            [_delegate orderCenterHttpRequestCompletedWithResult:_orderStatInfo
                                                      isSucccess:YES
                                                       errorCode:L(@"GetOrderDataFail")];
            
        }
    }
    
    

    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_OrderCenter) {
        
        if (self.delegate &&[_delegate respondsToSelector:@selector(orderCenterHttpRequestCompletedWithResult: isSucccess:errorCode:)]) {
            
            [_delegate orderCenterHttpRequestCompletedWithResult:nil isSucccess:NO errorCode:self.errorMsg];
        }
    }
}
    
- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
        
    if (receiveMsg.cmdCode == CC_OrderCenter) {
        
        [self sendOrderHttpRequestOk:receiveMsg];
        
    }

}
@end
