//
//  StoreTotalInfoService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreDetailInfoService.h"
#import "StoreCampaignDTO.h"
#import "StoreServiceDTO.h"

@implementation StoreDetailInfoService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_storeInfoDTO);
    
    TT_RELEASE_SAFELY(_storeCampaignListArr);
    
    TT_RELEASE_SAFELY(_storeServiceListArr);
    
}

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(storeInfoHttpMsg);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _storeInfoDTO = [[SuningStoreDetailInfoDTO alloc]init];
        
        _storeCampaignListArr = [[NSMutableArray alloc]init];
        
        _storeServiceListArr = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}

//userId（非必填）：用户ID （ps：不填userId，用户收藏信息isFavo为空）
- (void)getStoreDetailInfoWithStoreId:(NSString *)storeId userId:(NSString *)userId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(storeId)?@"":storeId forKey:@"storeId"];
    [dic setObject:IsStrEmpty(userId)?@"":userId forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@.html",kEbuyWapHostURL,kACStoreDetailInfo,storeId,userId];
    
    HTTPMSG_RELEASE_SAFELY(storeInfoHttpMsg);
    
    storeInfoHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_StoreDetailInfo];
    storeInfoHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:storeInfoHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_StoreDetailInfo)
    {
        [_serviceDelegate getStoreDetailInfo:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_StoreDetailInfo)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSDictionary *storeData = [item objectForKey:@"data"];
            
            {
                NSDictionary *storeInfo = [storeData objectForKey:@"storeBaseInfo"];
                
                [self.storeInfoDTO encodeFromDictionary:storeInfo];
            }
            
            {
                NSMutableArray *campaignList = [storeData objectForKey:@"storeActiveList"];
                
                [self.storeCampaignListArr removeAllObjects];
                    
                for (int i =0; i<[campaignList count]; i++)
                {
                    StoreCampaignDTO *dto  =[[StoreCampaignDTO alloc]init];
                        
                    [dto encodeFromDictionary:[campaignList objectAtIndex:i]];
                        
                    [self.storeCampaignListArr addObject:dto];
                }
                
            }
            
            {
                
                NSMutableArray *serviceList = [storeData objectForKey:@"storeServiceList"];
                
                [self.storeServiceListArr removeAllObjects];
                    
                for (int i =0; i<[serviceList count]; i++)
                {
                    StoreServiceDTO *dto  =[[StoreServiceDTO alloc]init];
                        
                    [dto encodeFromDictionary:[serviceList objectAtIndex:i]];
                        
                    [self.storeServiceListArr addObject:dto];
                }
                
            }
            
            if (IsArrEmpty(self.storeCampaignListArr) && IsArrEmpty(self.storeServiceListArr) && ([self.storeInfoDTO.storeId isEqualToString:@""]))
            {
                
                [_serviceDelegate getStoreDetailInfo:self isSuccess:NO errorMsg:self.errorMsg];
                
            }
            else
            {
                
                [_serviceDelegate getStoreDetailInfo:self isSuccess:YES errorMsg:self.errorMsg];
                
            }
            
        }
        else
        {
            
            [_serviceDelegate getStoreDetailInfo:self isSuccess:NO errorMsg:self.errorMsg];
            
        }
    }
    
}

@end
