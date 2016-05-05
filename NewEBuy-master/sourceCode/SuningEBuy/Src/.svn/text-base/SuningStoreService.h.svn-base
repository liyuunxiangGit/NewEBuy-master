//
//  SuningStoreService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class SuningStoreService;

@protocol  SuningStoreServiceDelegate <NSObject>

- (void)getAllCitySuningStoreList:(SuningStoreService *)service
                        isSuccess:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg;

@end

//获取门店列表接口
@interface SuningStoreService : DataService
{
    
    HttpMessage *storeListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *storeListArr;

@property (nonatomic, weak) id<SuningStoreServiceDelegate> serviceDelegate;

- (void)getAllCityStoreListWithCityId:(NSString *)cityId
                            longitude:(NSString *)longitude
                             latitude:(NSString *)latitude
                               userId:(NSString *)userId;

@end
