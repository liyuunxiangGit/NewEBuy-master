//
//  AllCityServeService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityServeService.h"
#import "StoreServiceDTO.h"

@implementation AllCityServeService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_serviceListArr);
    
}

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(serviceListHttpMsg);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _serviceListArr = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}


- (void)getAllCityServiceListWithCityId:(NSString *)cityId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@.html",kEbuyWapHostURL,kACServiceList,cityId];
    
    HTTPMSG_RELEASE_SAFELY(serviceListHttpMsg);
    
    serviceListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_ServiceList];
    serviceListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:serviceListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ServiceList)
    {
        [_serviceDelegate getAllCityServiceList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    self.errorMsg =[item objectForKey:@"msg"];
    if (receiveMsg.cmdCode == CC_ServiceList){
        if ([[item objectForKey:@"code"] isEqualToString:@"1"]){
            NSMutableArray *list = [item objectForKey:@"data"];
            [self.serviceListArr removeAllObjects];
            for (int i =0; i<[list count]; i++){
                StoreServiceDTO *dto  =[[StoreServiceDTO alloc]init];
                [dto encodeFromDictionary:[list objectAtIndex:i]];
                [self.serviceListArr addObject:dto];
            }
            [_serviceDelegate getAllCityServiceList:self isSuccess:YES errorMsg:self.errorMsg];
        }else{
            [_serviceDelegate getAllCityServiceList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    
}

@end
