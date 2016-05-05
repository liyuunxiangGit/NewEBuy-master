//
//  MySuningStoreViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "MySuningStoreViewController.h"
#import "StoreTotalInfoViewController.h"
//#import "StoreListDTO.h"
#import "LoginViewController.h"

@interface MySuningStoreViewController ()
{
    BOOL isFirstLoad;
}
@end

@implementation MySuningStoreViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _storeId = [[NSString alloc]init];
        
        _allCityStoreList = [[NSMutableArray alloc]initWithCapacity:20];
        
        isFirstLoad = YES;
        
        self.mySuningStoreView.delegate = self;
        
        self.hidesBottomBarWhenPushed =YES;
        
    }
    return self;
}

- (void)dealloc
{
    _mySuningStoreView.delegate = nil;
    
    TT_RELEASE_SAFELY(_myFavoStoreService);
    
    TT_RELEASE_SAFELY(_updateFavoStoreService);
    
    TT_RELEASE_SAFELY(_storeId);
    
    TT_RELEASE_SAFELY(_allCityStoreList);
    
}

- (void)loginSuccess
{
    
    [self refreshData];

}

- (void)loginCancel
{
    
    //[self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //检查是否登录，如果未登录则弹出登录界面
    if (![UserCenter defaultCenter].isLogined && !isFirstLoad)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (![UserCenter defaultCenter].isLogined && isFirstLoad)
    {
        isFirstLoad = NO;
        
        [self removeOverFlowActivityView];
        
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        loginViewController.loginDelegate = self;
        
        loginViewController.loginDidOkSelector = @selector(loginSuccess);
        
        loginViewController.loginDidCancelSelector = @selector(loginCancel);
        
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]initWithRootViewController:loginViewController];
        
        [self presentModalViewController:userNav animated:YES];
    }
    else
    {
        [self refreshData];
        
        if (!IsArrEmpty(self.mySuningStoreView.favouriteStoreList))
        {
            
            [self.mySuningStoreView.groupTableView reloadData];
            
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self.view addSubview:_mySuningStoreView];
    
}

- (void)loadView
{
    [super loadView];
    
    [self displayOverFlowActivityView];
    
    
    self.title = L(@"NearbySuning_MySuning");
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),self.title,L(@"home")];
    
}

- (void)refreshData
{
        
    [self.myFavoStoreService getMyFavouriteStoreListWithUserId:[UserCenter defaultCenter].userInfoDTO.userId
                                                        cityId:[Config currentConfig].nearByCityId
                                                     longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                      latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
    
    [self displayOverFlowActivityView];
        
}

#pragma mark-
#pragma mark  SuningStoreServiceDelegate
- (void)getMyFavouriteStoreList:(MyFavouriteStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess){
        self.mySuningStoreView.favouriteStoreList = service.favouriteStoreListArr;
        self.mySuningStoreView.goodStoreList = service.goodStoreListArr;
        self.mySuningStoreView.allStoreList = service.allStoreListArr;
        if (!(service.favouriteStoreListArr.count == 0)){
            for (SuningStoreDTO *dto in self.mySuningStoreView.favouriteStoreList){
                dto.isFavo = @"1";
            }
        }
        [self.view addSubview:_mySuningStoreView];
        [self.mySuningStoreView.groupTableView reloadData];
        if (IsArrEmpty(self.mySuningStoreView.favouriteStoreList) && IsArrEmpty(self.mySuningStoreView.goodStoreList) && IsArrEmpty(self.mySuningStoreView.allStoreList)){
            [self.mySuningStoreView.noDataView setHidden:NO];
        }else{
            [self.mySuningStoreView.noDataView setHidden:YES];
        }
    }else{
        if(errorMsg == nil || [errorMsg isEqualToString:@""]){
            [self presentSheet:L(@"NearbySuning_GetStoreInfoFailed")];
        }else{
            [self presentSheet:errorMsg];
        }
    }
}

//#pragma mark-
//#pragma mark  UpdateFavoStoreServiceDelegate
//- (void)updateFavoStore:(UpdateFavoStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
//{
//    [self removeOverFlowActivityView];
//    
//    [self.allCityStoreList removeAllObjects];
//    
//    [self.allCityStoreList addObjectsFromArray:self.mySuningStoreView.favouriteStoreList];
//    
//    [self.allCityStoreList addObjectsFromArray:self.mySuningStoreView.goodStoreList];
//    
//    [self.allCityStoreList addObjectsFromArray:self.mySuningStoreView.allStoreList];
//
//    if (isSuccess)
//    {
//        
//        for (SuningStoreDTO *dto in self.allCityStoreList)
//        {
//            if ([dto.storeId isEqualToString:self.storeId])
//            {
//                if ([dto.isFavo isEqualToString:@"0"]) {
//                    
//                    [self presentSheet:L(@"NearbySuning_Liked") posY:300];
//                    dto.isFavo = @"1";
//                }
//                else
//                {
//                    [self presentSheet:L(@"NearbySuning_Canceled") posY:300];
//                    dto.isFavo = @"0";
//                }
//                
//            }
//            
//        }
//        
//        [self.mySuningStoreView.groupTableView reloadData];
//    }
//    else
//    {
//        SuningStoreDTO *failDto = [[SuningStoreDTO alloc]init];
//        
//        failDto = [service.failureStoreStatusList objectAtIndex:0];
//        
//        for (SuningStoreDTO *dto in self.allCityStoreList)
//        {
//            if ([dto.storeId isEqualToString:failDto.storeId])
//            {
//                if ([dto.isFavo isEqualToString:@"0"]) {
//                    
//                    [self presentSheet:L(@"NearbySuning_LikeFailed") posY:300];
//                    dto.isFavo = @"0";
//                }
//                else
//                {
//                    [self presentSheet:L(@"NearbySuning_CancelFailed") posY:300];
//                    dto.isFavo = @"1";
//                }
//                
//            }
//            
//        }
//        
//        [self.mySuningStoreView.groupTableView reloadData];
//        
//    }
//
//}


- (MySuningStoreListView *)mySuningStoreView
{
    if(_mySuningStoreView == nil)
    {
        _mySuningStoreView = [[MySuningStoreListView alloc]initWithOwner:self];
        
        _mySuningStoreView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
        
        _mySuningStoreView.delegate = self;
        
        //[self.view addSubview:_mySuningStoreView];
        
    }
    return _mySuningStoreView;
    
}

- (MyFavouriteStoreService *)myFavoStoreService
{
    if (!_myFavoStoreService)
    {
        _myFavoStoreService = [[MyFavouriteStoreService alloc]init];
        
        _myFavoStoreService.serviceDelegate = self;
    }
    return _myFavoStoreService;
}

//- (UpdateFavoStoreService *)updateFavoStoreService
//{
//    
//    if (!_updateFavoStoreService)
//    {
//        _updateFavoStoreService = [[UpdateFavoStoreService alloc]init];
//        
//        _updateFavoStoreService.serviceDelegate = self;
//        
//    }
//    
//    return _updateFavoStoreService;
//}

#pragma -
#pragma mark MySuningStoreListViewDelegate

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto
{
    
    StoreTotalInfoViewController *vc = [[StoreTotalInfoViewController alloc]init];
    
    //vc.storeDetailDto.storeId = dto.storeId;
    
    vc.storeDto = dto;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showCityList
{
    [self refreshData];
}

//#pragma -
//#pragma mark AllCityStoreListCellDelegate
//
//- (void)changeCollectOrNot:(UIButton *)btn
//{
//    //检查是否登录，如果未登录则弹出登录界面
//    if (![UserCenter defaultCenter].isLogined)
//    {
//        LoginViewController *loginViewController = [[LoginViewController alloc] init];
//        
//        loginViewController.loginDelegate = self;
//        
//        loginViewController.loginDidOkSelector = @selector(loginSuccess);
//        
//        loginViewController.loginDidCancelSelector = @selector(loginCancel);
//        
//        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]initWithRootViewController:loginViewController];
//        
//        [self presentModalViewController:userNav animated:YES];
//        
//        return;
//        
//    }
//    else
//    {
//        
//        if (btn.tag == 1)
//        {
//            
//            [btn setAlpha:0.5];
//            
//            [btn setEnabled:NO];
//            
//            self.storeId = btn.titleLabel.text;
//            
//            NSString *str = [NSString stringWithFormat:@"0,%@,0",btn.titleLabel.text];
//            
//            [self.updateFavoStoreService updateFavoStoreWithUserId:[UserCenter defaultCenter].userInfoDTO.userId storeStatus:str];
//            
//        }
//        else
//        {
//            [btn setBackgroundImage:[UIImage imageNamed:@"suning_button_shoucan_selected.png"] forState:UIControlStateNormal];
//            
//            [btn setAlpha:0.5];
//            
//            [btn setEnabled:NO];
//            
//            self.storeId = btn.titleLabel.text;
//            
//            NSString *str = [NSString stringWithFormat:@"0,%@,1",btn.titleLabel.text];
//            
//            [self.updateFavoStoreService updateFavoStoreWithUserId:[UserCenter defaultCenter].userInfoDTO.userId storeStatus:str];
//            
//        }
//        
//    }
//}

@end
