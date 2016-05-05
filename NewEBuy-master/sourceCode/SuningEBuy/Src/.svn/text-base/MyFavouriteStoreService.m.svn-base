//
//  MyFavouriteStoreService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "MyFavouriteStoreService.h"
#import "SuningStoreDTO.h"

@implementation MyFavouriteStoreService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_favouriteStoreListArr);
    
    TT_RELEASE_SAFELY(_goodStoreListArr);
    
    TT_RELEASE_SAFELY(_allStoreListArr);
    
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
        
        _favouriteStoreListArr = [[NSMutableArray alloc]init];
        
        _goodStoreListArr = [[NSMutableArray alloc]init];
        
        _allStoreListArr = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (void)getMyFavouriteStoreListWithUserId:(NSString *)userId cityId:(NSString *)cityId longitude:(NSString *)longitude latitude:(NSString *)latitude
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(userId)?@"":userId forKey:@"userId"];
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    [dic setObject:IsStrEmpty(longitude)?@"":longitude forKey:@"longitude"];
    [dic setObject:IsStrEmpty(latitude)?@"":latitude forKey:@"latitude"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@_%@_%@.html",kEbuyWapHostURL,kACMyFavoStore,userId,cityId,latitude,longitude];
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    storeListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_MyFavoStore];
    storeListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:storeListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_MyFavoStore)
    {
        [_serviceDelegate getMyFavouriteStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_MyFavoStore)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSDictionary *storeInfo = [item objectForKey:@"data"];
            
            {
                NSMutableArray *favouriteStoreList = [storeInfo objectForKey:@"favouriteStoreList"];
                
                [self.favouriteStoreListArr removeAllObjects];
                
                for (int i =0; i<[favouriteStoreList count]; i++)
                {
                    SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                    
                    [dto encodeFromDictionary:[favouriteStoreList objectAtIndex:i]];
                    
                    [self.favouriteStoreListArr addObject:dto];
                }
                
            }
            
            {
                NSMutableArray *goodStoreList = [storeInfo objectForKey:@"topStoreList"];
                
                [self.goodStoreListArr removeAllObjects];
                
                for (int i =0; i<[goodStoreList count]; i++)
                {
                    SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                    
                    [dto encodeFromDictionary:[goodStoreList objectAtIndex:i]];
                    
                    [self.goodStoreListArr addObject:dto];
                }
                
            }
            
            {
                
                NSMutableArray *allStoreList = [storeInfo objectForKey:@"allStoreList"];
                
                [self.allStoreListArr removeAllObjects];
                
                for (int i =0; i<[allStoreList count]; i++)
                {
                    SuningStoreDTO *dto  =[[SuningStoreDTO alloc]init];
                    
                    [dto encodeFromDictionary:[allStoreList objectAtIndex:i]];
                    
                    [self.allStoreListArr addObject:dto];
                }
                
            }
                
            [_serviceDelegate getMyFavouriteStoreList:self isSuccess:YES errorMsg:self.errorMsg];
                
        }
        else
        {
            [_serviceDelegate getMyFavouriteStoreList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    
}

@end
