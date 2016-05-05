//
//  SuningStoreService.h
//  SuningEBuy
//
//  Created by Kristopher on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "DataProductBasic.h"

@class NearbySpotStoreService;

@protocol  NearbySpotStoreServiceDelegate <NSObject>

- (void)getNearbySpotStoreList:(NSMutableArray *)storeList
                        isSuccess:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg;

@end

//获取门店列表接口
@interface NearbySpotStoreService : DataService
{
    
    HttpMessage *storeListHttpMsg;
    
}

@property (nonatomic, weak) id<NearbySpotStoreServiceDelegate> serviceDelegate;

- (void)getNearbySpotStoreListWithCityCode:(NSString *)cityCode
                            longitude:(double)longitude
                             latitude:(double)latitude
                          productBase:(DataProductBasic *)productBase;

@end
