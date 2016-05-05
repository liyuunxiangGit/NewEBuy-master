//
//  AllCityCampaignListView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "AllCityCampaignListCell.h"

@protocol AllCityCampaignListViewDelegate <NSObject>

- (void)gotoCampaignView:(StoreCampaignDTO *)dto;

@end

@interface AllCityCampaignListView : CommonView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *campaignList;

@property (nonatomic, weak) id<AllCityCampaignListViewDelegate> delegate;

- (id)initWithOwner:(id)owner;

@end
