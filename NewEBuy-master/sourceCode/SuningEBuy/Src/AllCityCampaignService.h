//
//  AllCityCampaignService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class AllCityCampaignService;

@protocol  AllCityCampaignServiceDelegate <NSObject>

- (void)getAllCityCampaignList:(AllCityCampaignService *)service
                    isSuccess:(BOOL)isSuccess
                     errorMsg:(NSString *)errorMsg;

@end

//门店活动列表接口
@interface AllCityCampaignService : DataService
{
    
    HttpMessage *campaignListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *campaignListArr;

@property (nonatomic, weak) id<AllCityCampaignServiceDelegate> serviceDelegate;

- (void)getAllCityCampaignListWithCityId:(NSString *)cityId;

@end
