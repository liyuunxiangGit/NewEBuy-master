//
//  StoreTotalInfoService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SuningStoreDetailInfoDTO.h"

@class StoreDetailInfoService;

@protocol StoreDetailInfoServiceDelegate <NSObject>

- (void)getStoreDetailInfo:(StoreDetailInfoService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//门店详情接口，获取门店活动、服务及门店详情
@interface StoreDetailInfoService : DataService
{
    
    HttpMessage *storeInfoHttpMsg;
    
}

@property (nonatomic, strong) SuningStoreDetailInfoDTO *storeInfoDTO;

@property (nonatomic, strong) NSMutableArray *storeCampaignListArr;

@property (nonatomic, strong) NSMutableArray *storeServiceListArr;

@property (nonatomic, weak) id<StoreDetailInfoServiceDelegate> serviceDelegate;

- (void)getStoreDetailInfoWithStoreId:(NSString *)storeId userId:(NSString *)userId;

@end
