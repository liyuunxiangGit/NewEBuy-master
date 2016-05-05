//
//  CampaignDetailInfoView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "SuningStoreDTO.h"
#import "StoreCampaignDTO.h"

@protocol CampaignDetailInfoViewDelegate <NSObject>

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto;

@end

@interface CampaignDetailInfoView : CommonView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) StoreCampaignDTO *campaignDto;

@property (nonatomic, strong) NSString         *campaignStore;

@property (nonatomic, strong) NSArray         *storeList;

@property (nonatomic, weak) id<CampaignDetailInfoViewDelegate> delegate;

- (id)initWithOwner:(id)owner;

@end
