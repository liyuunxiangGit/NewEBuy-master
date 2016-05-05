//
//  DetailCollectService.m
//  SuningEBuy
//
//  Created by xmy on 19/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DetailCollectService.h"

@implementation DetailCollectService


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getCollectHttpMsg);
}

- (void)sendDetailCollectService:(DataProductBasic*)data
{
    self.OnlyGetCollect = NO;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    
    [postDic setObject:@"10052" forKey:@"storeId"];
    [postDic setObject:data.productId?data.productId:@"" forKey:@"productId"];
    [postDic setObject:data.shopCode?data.shopCode:@"" forKey:@"vendorCode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNMTCheckBookMarkView"];
    
    HTTPMSG_RELEASE_SAFELY(getCollectHttpMsg);
    getCollectHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDic
                                                            cmdCode:CC_CollectDetail];
    getCollectHttpMsg.requestMethod=RequestMethodGet;
    getCollectHttpMsg.canMultipleConcurrent = YES;
    [self.httpMsgCtrl sendHttpMsg:getCollectHttpMsg];
    
    
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_CollectDetail)
    {
        if (KPerformance)
        {
            PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"3";
            temp.interfaceId = @"301";
            temp.errorType = @"02";
            temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
            [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
        }
        [self getCollectFinish:NO WithStr:nil];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_CollectDetail)
    {
        NSDictionary *items = receiveMsg.jasonItems;
        
       NSString *flag = [items objectForKey:@"bookmarkFlag"];
        
        self.bookFlag = flag;
        
        [self getCollectFinish:YES WithStr:flag];
        
    }
    

}


#pragma mark -
#pragma mark final method

- (void)getCollectFinish:(BOOL)isSuccess WithStr:(NSString*)str
{
    if (_delegate && [_delegate respondsToSelector:@selector(getDetailCollectServiceInfo:WithStr:)]) {
        [_delegate getDetailCollectServiceInfo:isSuccess WithStr:str];
    }
}





@end
