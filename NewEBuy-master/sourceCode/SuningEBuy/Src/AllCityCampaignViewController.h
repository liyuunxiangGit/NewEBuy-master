//
//  AllCityCampaignViewController.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "AllCityCampaignListView.h"
#import "AllCityCampaignService.h"
#import <CoreLocation/CoreLocation.h>

@interface AllCityCampaignViewController : CommonViewController<AllCityCampaignListViewDelegate,AllCityCampaignServiceDelegate>

@property (nonatomic, strong) AllCityCampaignListView *campaignListView;

@property (nonatomic, strong) AllCityCampaignService  *campaignService;

//@property (nonatomic, strong) NSString                *cityId;

@property (nonatomic) CLLocationCoordinate2D          userLocation;

@end
