//
//  StoreServiceViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreServiceViewController.h"
#import "StoreTotalInfoViewController.h"

@implementation StoreServiceViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _storeServiceView.delegate = self;
        
        self.hidesBottomBarWhenPushed =YES;
        
    }
    return self;
}

- (void)dealloc
{
    _storeServiceView.delegate = nil;
    
    TT_RELEASE_SAFELY(_storeServeService);
    
    TT_RELEASE_SAFELY(_serviceDTO);
    
}

- (void)viewDidLoad
{
    
    self.storeServiceView.serviceDto = self.serviceDTO;
    
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!IsArrEmpty(self.storeServiceView.storeList))
    {
        
        [self.storeServiceView.groupTableView reloadData];
        
    }
}

- (void)loadView
{
    [super loadView];
    
    [self displayOverFlowActivityView];
    
    
    self.title = L(@"NearbySuning_StoreService");
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),L(@"NearbySuning_CityAndStoreService"),self.serviceDTO.serviceId];
    
}

- (void)refreshData
{
    
    [self.storeServeService getServiceStoreListWithServiceId:self.serviceDTO.serviceId
                                                      cityId:[Config currentConfig].nearByCityId
                                                   longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                    latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];        
    [self displayOverFlowActivityView];
    
}

#pragma mark-
#pragma mark  StoreServeServiceDelegate
- (void)getServiceStoreList:(StoreServeService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
 
    if (isSuccess)
    {
        self.storeServiceView.storeList = service.storeListArr;
        
        [self.storeServiceView.groupTableView reloadData];
        
    }
    else
    {
        if(errorMsg == nil || [errorMsg isEqualToString:@""])
        {
            
            [self presentSheet:L(@"NearbySuning_GetServiceStoreInfoFailed")];
            
        }
        else
        {
            
            [self presentSheet:errorMsg];
            
        }
    }
    
}


- (StoreServiceView *)storeServiceView
{
    if(_storeServiceView == nil)
    {
        _storeServiceView = [[StoreServiceView alloc]initWithOwner:self];
        
        _storeServiceView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _storeServiceView.delegate = self;
        
        [self.view addSubview:_storeServiceView];
        
    }
    return _storeServiceView;
    
}

- (StoreServeService *)storeServeService
{
    if (!_storeServeService)
    {
        _storeServeService = [[StoreServeService alloc]init];
        
        _storeServeService.serviceDelegate =self;
    }
    return _storeServeService;
}

#pragma -
#pragma mark StoreServiceViewDelegate

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto
{
    
    StoreTotalInfoViewController *vc = [[StoreTotalInfoViewController alloc]init];
    
    //vc.storeDetailDto.storeId = dto.storeId;
    
    vc.storeDto = dto;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
