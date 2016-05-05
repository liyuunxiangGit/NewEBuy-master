//
//  OrdersNumberService.m
//  SuningEBuy
//
//  Created by YANG on 14-5-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrdersNumberService.h"

@implementation OrdersNumberService
@synthesize  ordersNumberMessage = _ordersNumberMessage;
- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    
    self.delegate = nil;
    
}


- (void)beginGetOrdersNumberInfo:(NSString *)storeId catalogId:(NSString *)catalogId
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if (IsStrEmpty(storeId)) {
        storeId = @"10052";
    }
    if (IsStrEmpty(catalogId)) {
        catalogId = @"10051";
    }
    NSString *flag = @"MB_C";//2.4.2代收货列表退回原样,为了区别2.4.1加了一个参数,参数内容随意写
    
    [dic setObject:storeId forKey:@"storeId"];
    [dic setObject:catalogId forKey:@"catalogId"];
    [dic setObject:flag forKey:@"flag"];

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,@"SNiPhoneAppGetTabCountView"];
//    NSString *url1 = @"https://b2cpre.cnsuning.com/webapp/wcs/stores/servlet/SNiPhoneAppGetTabCountView?storeId=10052&catalogId=10051";
    HTTPMSG_RELEASE_SAFELY(_ordersNumberMessage);
    
    _ordersNumberMessage = [[HttpMessage alloc] initWithDelegate:self
                                               requestUrl:url
                                              postDataDic:dic
                                                  cmdCode:CC_OrdersNumber];
    _ordersNumberMessage.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_ordersNumberMessage];
    
    TT_RELEASE_SAFELY(dic);

}

#pragma mark -
#pragma mark -- httpMessage delegate

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    
    if(receiveMsg.cmdCode == CC_OrdersNumber)
    {
        if (KPerformance)
        {
            PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"4";
            temp.interfaceId = @"403";
            temp.errorType = @"02";
            temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
            [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(getOrderNumberCompletedWithResult:errorMsg:)])
        {
            [self.delegate getOrderNumberCompletedWithResult:nil errorMsg:self.errorMsg];
        }
    }
    
}


-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if(receiveMsg.cmdCode == CC_OrdersNumber)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if (dic == nil)
        {
            self.errorMsg = @"kHttpResponseJSONValueFailError";
        }
        else
        {
            self.errorMsg = [dic objectForKey:@"errorMsg"];
            OrdersNumberDTO *dto = [[OrdersNumberDTO alloc] init];
            [dto encodeFromDictionary:dic];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOrderNumberCompletedWithResult:errorMsg:)])
            {
                            
                [self.delegate getOrderNumberCompletedWithResult:dto errorMsg:self.errorMsg];
            }
            
        }
    }
    
}


- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(_ordersNumberMessage);
    
    [super httpMsgRelease];
    
}


@end
