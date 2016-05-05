//
//  UpdateFavoStoreService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "UpdateFavoStoreService.h"
#import "SuningStoreDTO.h"

@implementation UpdateFavoStoreService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_failureStoreStatusList);
    
}

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(updateFavoStoreHttpMsg);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _failureStoreStatusList = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}

- (void)updateFavoStoreWithUserId:(NSString *)userId storeStatus:(NSString *)storeStatus
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(userId)?@"":userId forKey:@"userId"];
    [dic setObject:IsStrEmpty(storeStatus)?@"":storeStatus forKey:@"storeStatus"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kEbuyWapHostURL,kACUpdateFavoStore];
    
    HTTPMSG_RELEASE_SAFELY(updateFavoStoreHttpMsg);
    
    updateFavoStoreHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_UpdateFavoStore];
    updateFavoStoreHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:updateFavoStoreHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_UpdateFavoStore)
    {
        [_serviceDelegate updateFavoStore:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_UpdateFavoStore)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSMutableArray *list = [item objectForKey:@"data"];
            
            if (IsArrEmpty(list))
            {
                
                [_serviceDelegate updateFavoStore:self isSuccess:YES errorMsg:self.errorMsg];
                
            }
            else
            {
                [self.failureStoreStatusList removeAllObjects];
                
                for (int i =0; i<[list count]; i++)
                {
                    SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                    
                    [dto encodeFromDictionary:[list objectAtIndex:i]];
                    
                    [self.failureStoreStatusList addObject:dto];
                   
                }
                
                [_serviceDelegate updateFavoStore:self isSuccess:NO errorMsg:self.errorMsg];
            }
        }
        else
        {
            
            [_serviceDelegate updateFavoStore:self isSuccess:NO errorMsg:self.errorMsg];
            
        }
    }
    
}

@end
