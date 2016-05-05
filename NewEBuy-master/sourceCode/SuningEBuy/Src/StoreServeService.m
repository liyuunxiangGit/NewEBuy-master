//
//  StoreServeService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreServeService.h"
#import "SuningStoreDTO.h"

@implementation StoreServeService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_storeListArr);
    
}

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _storeListArr = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}

- (void)getServiceStoreListWithServiceId:(NSString *)serviceId cityId:(NSString *)cityId longitude:(NSString *)longitude latitude:(NSString *)latitude
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(serviceId)?@"":serviceId forKey:@"serviceId"];
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    [dic setObject:IsStrEmpty(longitude)?@"":longitude forKey:@"longitude"];
    [dic setObject:IsStrEmpty(latitude)?@"":latitude forKey:@"latitude"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@_%@_%@.html",kEbuyWapHostURL,kACServiceStoreList,serviceId,cityId,latitude,longitude];
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    storeListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_ServeStoreList];
    storeListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:storeListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ServeStoreList)
    {
        [_serviceDelegate getServiceStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_ServeStoreList)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSMutableArray *list = [item objectForKey:@"data"];
            
            if (IsArrEmpty(list))
            {
                self.errorMsg =L(@"NearbySuning_NoStoreInThisService");
                
                [_serviceDelegate getServiceStoreList:self isSuccess:NO errorMsg:self.errorMsg];
            }
            else
            {
                [self.storeListArr removeAllObjects];
                
                for (int i =0; i<[list count]; i++)
                {
                    SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                    
                    [dto encodeFromDictionary:[list objectAtIndex:i]];
                    
                    [self.storeListArr addObject:dto];
                }
                
                [_serviceDelegate getServiceStoreList:self isSuccess:YES errorMsg:self.errorMsg];
            }
        }
        else
        {
            [_serviceDelegate getServiceStoreList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    
}

@end
