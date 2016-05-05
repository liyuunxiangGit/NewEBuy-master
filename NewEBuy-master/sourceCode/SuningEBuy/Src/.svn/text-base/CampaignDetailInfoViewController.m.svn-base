//
//  CampaignDetailInfoViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CampaignDetailInfoViewController.h"
#import "StoreTotalInfoViewController.h"

@implementation CampaignDetailInfoViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _campaignDetailInfoView.delegate = self;
        
        self.hidesBottomBarWhenPushed =YES;
        
    }
    return self;
}

- (void)dealloc
{
    _campaignDetailInfoView.delegate = nil;
    
    TT_RELEASE_SAFELY(_campaignDetailInfoService);
    
    TT_RELEASE_SAFELY(_campaignDTO);
    
}

- (void)viewDidLoad
{
    
    //self.campaignDetailInfoView.campaignDto = self.campaignDTO;
    
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!IsArrEmpty(self.campaignDetailInfoView.storeList))
    {
        
        [self.campaignDetailInfoView.groupTableView reloadData];
        
    }
}

- (void)loadView
{
    [super loadView];
    
    [self displayOverFlowActivityView];
    
    
    self.title = @"活动详情";
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),L(@"NearbySuning_StoreActivity"),self.campaignDTO.activityId];
    
}

- (void)refreshData
{
    self.campaignDetailInfoView.campaignDto = self.campaignDTO;
    
    [self.campaignDetailInfoService getCampaignStoreListWithActivityId:self.campaignDTO.activityId
                                                                cityId:[Config currentConfig].nearByCityId
                                                             longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                              latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
    
    [self displayOverFlowActivityView];
    
}

#pragma mark-
#pragma mark  CampaignDetailInfoServiceDelegate
- (void)getCampaignStoreList:(CampaignDetailInfoService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
     [self removeOverFlowActivityView];
     
     if (isSuccess)
     {
         
         self.campaignDetailInfoView.storeList = service.storeListArr;
         
         [self.campaignDetailInfoView.groupTableView reloadData];
         
     }
     else
     {
         if(errorMsg == nil || [errorMsg isEqualToString:@""])
         {
             
             [self presentSheet:L(@"NearbySuning_GetActivityStoreInfoFailed")];
             
         }
         else
         {
             
             //[self presentSheet:errorMsg];
             
         }
         
     }
 
}


- (CampaignDetailInfoView *)campaignDetailInfoView
{
    if(_campaignDetailInfoView == nil)
    {
        _campaignDetailInfoView = [[CampaignDetailInfoView alloc]initWithOwner:self];
        
        _campaignDetailInfoView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _campaignDetailInfoView.delegate = self;
        
        [self.view addSubview:_campaignDetailInfoView];
        
    }
    return _campaignDetailInfoView;
    
}

- (CampaignDetailInfoService *)campaignDetailInfoService
{
    if (!_campaignDetailInfoService)
    {
        _campaignDetailInfoService = [[CampaignDetailInfoService alloc]init];
        
        _campaignDetailInfoService.serviceDelegate =self;
    }
    return _campaignDetailInfoService;
}

#pragma -
#pragma mark CampaignDetailInfoViewDelegate

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto
{
    
    StoreTotalInfoViewController *vc = [[StoreTotalInfoViewController alloc]init];
    
    //vc.storeDetailDto.storeId = dto.storeId;
    
    vc.storeDto = dto;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
