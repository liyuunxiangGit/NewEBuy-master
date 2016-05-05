//
//  SuningStoreService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SuningStoreService.h"
#import "SuningStoreDTO.h"

@implementation SuningStoreService

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

//userId（非必填）：用户ID （ps：不填userId，用户收藏信息isFavo为空）
- (void)getAllCityStoreListWithCityId:(NSString *)cityId longitude:(NSString *)longitude latitude:(NSString *)latitude userId:(NSString *)userId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    [dic setObject:IsStrEmpty(longitude)?@"":longitude forKey:@"longitude"];
    [dic setObject:IsStrEmpty(latitude)?@"":latitude forKey:@"latitude"];
    [dic setObject:IsStrEmpty(userId)?@"":userId forKey:@"userId"];

    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@_%@_%@.html",kEbuyWapHostURL,kACStoreList,cityId,latitude,longitude,userId];
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    storeListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_StoreList];
    storeListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:storeListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_StoreList)
    {
        [_serviceDelegate getAllCitySuningStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    self.errorMsg =[item objectForKey:@"msg"];
    if (receiveMsg.cmdCode == CC_StoreList){
        if ([[item objectForKey:@"code"] isEqualToString:@"1"]){
            NSMutableArray *list = [item objectForKey:@"data"];
            [self.storeListArr removeAllObjects];
            for (int i =0; i<[list count]; i++){
                SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                [dto encodeFromDictionary:[list objectAtIndex:i]];
                [self.storeListArr addObject:dto];
            }
            [_serviceDelegate getAllCitySuningStoreList:self isSuccess:YES errorMsg:self.errorMsg];
        }else{
            [_serviceDelegate getAllCitySuningStoreList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
}

@end
