//
//  AllCityServiceViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityServiceViewController.h"
#import "StoreServiceViewController.h"
#import "StoreServiceDTO.h"

@implementation AllCityServiceViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _serviceListView.delegate = self;
        
        self.hidesBottomBarWhenPushed =YES;
        
        
    }
    return self;
}

- (void)dealloc
{
    _serviceListView.delegate = nil;
    
    TT_RELEASE_SAFELY(_serveService);
    
}

- (void)viewDidLoad
{
    
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!IsArrEmpty(self.serviceListView.topServiceList))
    {
        
        [self.serviceListView.groupTableView reloadData];
        
    }
}

- (void)loadView
{
    [super loadView];
    
    [self displayOverFlowActivityView];
    
    
    self.title = L(@"NearbySuning_SunshineService");
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",@"身边苏宁",self.title,[Config currentConfig].nearByCityId ];
    
}

- (void)refreshData
{
    
    [self.serveService getAllCityServiceListWithCityId:[Config currentConfig].nearByCityId];
    
    //[self.serveService getAllCityServiceListWithCityId:@"9017"];
    
    [self displayOverFlowActivityView];
    
}

#pragma mark-
#pragma mark  AllCityServeServiceDelegate
- (void)getAllCityServiceList:(AllCityServeService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
     [self removeOverFlowActivityView];
     
     if (isSuccess){
         [self.serviceListView.topServiceList removeAllObjects];
         [self.serviceListView.otherServiceList removeAllObjects];
         for (StoreServiceDTO *dto in service.serviceListArr){
             if ([dto.isTopService isEqualToString:@""]){
                 [self.serviceListView.otherServiceList addObject:dto];
             }else{
                 [self.serviceListView.topServiceList addObject:dto];
             }
         }
         NSMutableArray *tagTextArray = [[NSMutableArray alloc]initWithCapacity:10];
         [tagTextArray removeAllObjects];
         for (StoreServiceDTO *dto in self.serviceListView.otherServiceList){
             [tagTextArray addObject:dto.serviceName];
         }
         if(IsArrEmpty(service.serviceListArr)){
             [self.serviceListView.noDataView setHidden:NO];
         }else{
             [self.serviceListView.noDataView setHidden:YES];
         }
         self.serviceListView.tagList.textArray = tagTextArray;
         [self.serviceListView.groupTableView reloadData];
     
    }else{
        if(errorMsg == nil || [errorMsg isEqualToString:@""]){
            [self presentSheet:L(@"NearbySuning_GetStoreServiceInfoFailed")];
        }else{
            [self presentSheet:errorMsg];
        }
     }
}


- (AllCityServiceListView *)serviceListView
{
    if(_serviceListView == nil)
    {
        _serviceListView = [[AllCityServiceListView alloc]initWithOwner:self];
        
        _serviceListView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _serviceListView.delegate = self;
        
        [self.view addSubview:_serviceListView];
        
    }
    return _serviceListView;
    
}

- (AllCityServeService *)serveService
{
    if (!_serveService)
    {
        _serveService = [[AllCityServeService alloc]init];
        
        _serveService.serviceDelegate = self;
    }
    
    return _serveService;
}

#pragma -
#pragma mark AllCityServiceListViewDelegate

- (void)gotoStoreService:(StoreServiceDTO *)dto
{
    
    StoreServiceViewController *vc = [[StoreServiceViewController alloc]init];
    
    vc.serviceDTO = dto;
    
    vc.userLocation = self.userLocation;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showCityList
{
    [self refreshData];
}

@end
