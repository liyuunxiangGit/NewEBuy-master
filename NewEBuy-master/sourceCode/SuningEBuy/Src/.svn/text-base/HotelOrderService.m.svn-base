//
//  HoterOrderService.m
//  SuningEBuy
//
//  Created by admin on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HotelOrderService.h"
#import "HotelOrderDTO.h"
#import "HotelOrder.h"

@implementation HotelOrderService

@synthesize delegate = _delegate;


-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(orderMsg);
}

-(void)beginHotelOrderSumbit:(HotelOrderDTO*)orderDto
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostHotelOrderForHttp, KHTTPRequestHotelBookOrder];
    NSMutableDictionary *postDataDic = [orderDto decodeToDictionary];
    HTTPMSG_RELEASE_SAFELY(orderMsg);
    orderMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:url
                                         postDataDic:postDataDic
                                             cmdCode:CC_HotelOrderSubmit];
    [self.httpMsgCtrl sendHttpMsg:orderMsg];
}

- (void)getHotelOrderSubmitFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHotelOrderService:Result:errorMsg:)])
    {
        [_delegate getHotelOrderService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_HotelOrderSubmit:
        {
            [self getHotelOrderSubmitFinish:NO];
            break;
        }
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString *checkResult = [items objectForKey:@"checkResult"];

    if (!items)
    {
        self.errorMsg = L(@"BTSorryForSubmitOrder");
        [self getHotelOrderSubmitFinish:NO];
    }
    else if (checkResult && [checkResult isEqualToString:@""])
    {
        self.errorMsg = @"";
//        [self saveHoteOrder:items];
        [self getHotelOrderSubmitFinish:YES];
        
    }
    else
    {
        self.errorMsg = checkResult;
        [self getHotelOrderSubmitFinish:NO];
    }
}

- (void)saveHoteOrder:(NSDictionary *)items
{
    NSString *checkResult = [items objectForKey:@"checkResult"];
    
    if (checkResult == nil || [checkResult isEqualToString:@""]) {
        //获取订单号
        NSString *orderId = [items objectForKey:@"XfOrderNo"];
        
        DLog(@"orderNo:%@", orderId);
        
        if (orderId !=nil && ![orderId isEqualToString:@""]) {
            
            [[SuningMainClick sharedInstance] getOrderAndSave:orderId];
            
        }
        
    }
}



@end
