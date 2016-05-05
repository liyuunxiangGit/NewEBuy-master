//
//  TopCampaignService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class TopCampaignService;

@protocol  TopCampaignServiceDelegate <NSObject>

- (void)getTopCampaignList:(TopCampaignService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//身边苏宁首页显示活动service
@interface TopCampaignService : DataService
{
    
    HttpMessage *campaignListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *campaignListArr;

@property (nonatomic, weak) id<TopCampaignServiceDelegate> serviceDelegate;

- (void)getCampaignListWithCityId:(NSString *)cityId;

@end
