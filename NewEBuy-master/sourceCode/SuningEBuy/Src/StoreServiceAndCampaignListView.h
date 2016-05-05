//
//  StoreServiceAndCampaignListView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "StoreServiceDTO.h"
#import "StoreCampaignDTO.h"

@protocol StoreServiceAndCampaignListViewDelegate <NSObject>

- (void)gotoCampaignView:(StoreCampaignDTO *)dto;

- (void)goBackToStoreList;

@end

@interface StoreServiceAndCampaignListView : CommonView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *campaignList;
@property (nonatomic, strong) NSArray *serviceList;
@property (nonatomic, weak) id<StoreServiceAndCampaignListViewDelegate> delegate;
@property (nonatomic, strong) UIView  *noDataView;

- (id)initWithOwner:(id)owner;

@end
