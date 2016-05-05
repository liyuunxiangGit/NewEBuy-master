//
//  NearStoreService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearStoreService.h"

@implementation NearStoreService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_nearStore);
    
}

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(nearStoreHttpMsg);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _nearStore = [[SuningStoreDTO alloc]init];
        
    }
    
    return self;
}

- (void)getNearestSuningStoreWithCityId:(NSString *)cityId longitude:(NSString *)longitude latitude:(NSString *)latitude
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    [dic setObject:IsStrEmpty(longitude)?@"":longitude forKey:@"longitude"];
    [dic setObject:IsStrEmpty(latitude)?@"":latitude forKey:@"latitude"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@_%@.html",kEbuyWapHostURL,kACNearestStore,cityId,latitude,longitude];
    
    HTTPMSG_RELEASE_SAFELY(nearStoreHttpMsg);
    
    nearStoreHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_NearestStore];
    nearStoreHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:nearStoreHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_NearestStore)
    {
        [_serviceDelegate getNearestSuningStore:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_NearestStore)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSDictionary *store = [item objectForKey:@"data"];
            
            SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                    
            [dto encodeFromDictionary:store];
                    
            self.nearStore = dto;
            
            [_serviceDelegate getNearestSuningStore:self isSuccess:YES errorMsg:self.errorMsg];
        }
        else
        {
            [_serviceDelegate getNearestSuningStore:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    
}

@end
