//
//  AllCityCampaignViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityCampaignViewController.h"
#import "CampaignDetailInfoViewController.h"
#import "SNWebViewController.h"

@implementation AllCityCampaignViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _campaignListView.delegate = self;
       
        self.hidesBottomBarWhenPushed =YES;
        
        
    }
    return self;
}

- (void)dealloc
{
    _campaignListView.delegate = nil;
    
    TT_RELEASE_SAFELY(_campaignService);
    
}

-(void)viewDidLoad
{
    
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!IsArrEmpty(self.campaignListView.campaignList))
    {
        
        [self.campaignListView.groupTableView reloadData];
        
    }
}

- (void)loadView
{
    [super loadView];
    
    [self displayOverFlowActivityView];
    
    
    self.title = L(@"NearbySuning_StoreActivity");
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),self.title,[Config currentConfig].nearByCityId];
    
}

- (void)refreshData
{
    
    [self.campaignService getAllCityCampaignListWithCityId:[Config currentConfig].nearByCityId];
    
    [self displayOverFlowActivityView];
    
}

#pragma mark-
#pragma mark  AllCityCampaignServiceDelegate
- (void)getAllCityCampaignList:(AllCityCampaignService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    
    [self removeOverFlowActivityView];
     
    if (isSuccess)
    {
        self.campaignListView.campaignList = service.campaignListArr;
        
        [self.campaignListView.groupTableView reloadData];
        
    }
    else
    {
        
        if(errorMsg == nil || [errorMsg isEqualToString:@""])
        {
            
            [self presentSheet:L(@"NearbySuning_GetStoreActivityInfoFailed")];
            
        }
        else
        {
            
            [self presentSheet:errorMsg];
            
        }
        
    }
    
}

- (AllCityCampaignListView *)campaignListView
{
    if(_campaignListView == nil)
    {
        _campaignListView = [[AllCityCampaignListView alloc]initWithOwner:self];
        
        _campaignListView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _campaignListView.delegate = self;
        
        [self.view addSubview:_campaignListView];
        
    }
    return _campaignListView;
    
}

- (AllCityCampaignService *)campaignService
{
    if (!_campaignService)
    {
 
        _campaignService = [[AllCityCampaignService alloc]init];
        
        _campaignService.serviceDelegate =self;
    }
    
    return _campaignService;
}

#pragma -
#pragma mark AllCityCampaignListViewDelegate

- (void)gotoCampaignView:(StoreCampaignDTO *)dto
{
    if (![dto.activityUrl isEqualToString:@""])
    {
        NSString *activityUrl = dto.activityUrl;
        
        if (activityUrl.length)
        {
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": activityUrl}];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else
    {
        CampaignDetailInfoViewController *vc = [[CampaignDetailInfoViewController alloc]init];
        
        vc.campaignDTO = dto; 
        
        vc.userLocation = self.userLocation;
        
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    
}

@end
