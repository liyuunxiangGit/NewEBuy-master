//
//  SuningStoreService.m
//  SuningEBuy
//
//  Created by Kristopher on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearbySpotStoreService.h"
#import "NearbySpotStoreDTO.h"

@interface NearbySpotStoreService(){
    NSMutableArray *_storeListArray;
}

@end

@implementation NearbySpotStoreService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_storeListArray);
    
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
        
        _storeListArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    
    return self;
}

//
- (void)getNearbySpotStoreListWithCityCode:(NSString *)cityCode longitude:(double)longitude latitude:(double)latitude productBase:(DataProductBasic *)productBase
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    NSString *longitudeString,*latitudeString;
    if (longitude<0.0) {
        longitudeString = @"";
    }else{
        longitudeString = [NSString stringWithFormat:@"%f",longitude];
    }
    if (latitude<0.0) {
        latitudeString = @"";
    }else{
        latitudeString = [NSString stringWithFormat:@"%f",latitude];
    }

    NSString *url = [NSString stringWithFormat:@"%@/%@?partnumber=%@&cityId=%@&oprType=%@&price=%@&storeId=%@&longitude=%@&latitude=%@",
                     kHostSuningMts,
    /*@"http://10.24.64.211:8080/mts-web",*/
                     kNearbySpotStore,
                     productBase.productCode?productBase.productCode:@"",
    /*@"108556597",*/
                     cityCode?cityCode:@"",
                     @"1",
                     productBase.suningPrice?productBase.suningPrice:@"",
    /*@"9000.0",*/
                     @"10052",
                     longitudeString,
    /*@"118.779439",*/
                     latitudeString
    /*@"32.074555"*/
                     ];
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    storeListHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:dic
                                                    cmdCode:CC_NearbySpotStore];
    
    storeListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:storeListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_NearbySpotStore)
    {
        [_serviceDelegate getNearbySpotStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_NearbySpotStore)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSMutableArray *list = [item objectForKey:@"data"];
            
            if (IsArrEmpty(list))
            {
                self.errorMsg = L(@"Product_NoShopCanBuySelfNearby");
                
                [_serviceDelegate getNearbySpotStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
            }
            else
            {
                [_storeListArray removeAllObjects];
                
                for (int i =0; i<[list count]; i++)
                {
                    NearbySpotStoreDTO *dto  =[[NearbySpotStoreDTO alloc]init];
                    
                    [dto encodeFromDictionary:[list objectAtIndex:i]];
                    
                    [_storeListArray addObject:dto];
                }
                
                [_serviceDelegate getNearbySpotStoreList:_storeListArray isSuccess:YES errorMsg:self.errorMsg];
            }
        }
        else
        {
            [_serviceDelegate getNearbySpotStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
        }
    }

}

@end
