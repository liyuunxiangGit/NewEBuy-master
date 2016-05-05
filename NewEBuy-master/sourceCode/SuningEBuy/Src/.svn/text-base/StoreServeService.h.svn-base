//
//  StoreServeService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class StoreServeService;

@protocol  StoreServeServiceDelegate <NSObject>

- (void)getServiceStoreList:(StoreServeService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//门店服务接口
@interface StoreServeService : DataService
{
    
    HttpMessage *storeListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *storeListArr;

@property (nonatomic, weak) id<StoreServeServiceDelegate> serviceDelegate;

- (void)getServiceStoreListWithServiceId:(NSString *)serviceId
                                  cityId:(NSString *)cityId
                               longitude:(NSString *)longitude
                                latitude:(NSString *)latitude;


@end
