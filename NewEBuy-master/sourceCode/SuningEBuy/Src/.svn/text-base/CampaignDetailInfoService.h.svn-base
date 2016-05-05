//
//  CampaignDetailInfoService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class CampaignDetailInfoService;

@protocol  CampaignDetailInfoServiceDelegate <NSObject>

- (void)getCampaignStoreList:(CampaignDetailInfoService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//活动详情接口
@interface CampaignDetailInfoService : DataService
{
    
    HttpMessage *storeListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *storeListArr;

@property (nonatomic, weak) id<CampaignDetailInfoServiceDelegate> serviceDelegate;

- (void)getCampaignStoreListWithActivityId:(NSString *)activityId
                                    cityId:(NSString *)cityId
                                 longitude:(NSString *)longitude
                                  latitude:(NSString *)latitude;


@end
