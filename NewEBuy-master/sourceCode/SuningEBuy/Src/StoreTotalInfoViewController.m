//
//  StoreTotalInfoViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreTotalInfoViewController.h"
#import "SNWebViewController.h"
#import "CampaignDetailInfoViewController.h"
#import "StoreServiceViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "LoginViewController.h"

@implementation StoreTotalInfoViewController

- (id)init
{
    self = [super init];
    
    if (self){
        self.storeDto = [[SuningStoreDTO alloc] init];
        self.view.backgroundColor = [UIColor clearColor];
        self.view.userInteractionEnabled = YES;
        self.selectIndex = 0;
        self.hidesBottomBarWhenPushed =YES;
        isFristLoad = YES;
    }
    
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_serviceAndCampaignView);
    _serviceAndCampaignView.delegate = nil;
    TT_RELEASE_SAFELY(_storeDetailView);
    TT_RELEASE_SAFELY(_serveAndCamBtn);
    TT_RELEASE_SAFELY(_detailInfoBtn);
    TT_RELEASE_SAFELY(_collectBtn);
    TT_RELEASE_SAFELY(_shareBtn);
    TT_RELEASE_SAFELY(_storeDto);
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_storeName);
    TT_RELEASE_SAFELY(_storeDetailInfoService);    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *titleString = [[NSString alloc] init];
    if (self.storeDto.name.length > 12) {
        titleString = [self.storeDto.name substringWithRange:NSMakeRange(0, 12)];
    }else{
        titleString = self.storeDto.name;
    }
    if (titleString.length > 9){
        UILabel *_titleView = [[UILabel alloc] init];
        _titleView.textColor = [UIColor colorWithRGBHex:0x313131];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.font = [UIFont systemFontOfSize:19.0f-(titleString.length-9)*1.5];
        _titleView.textAlignment = NSTextAlignmentCenter;
        CGRect frame = _titleView.frame;
        _titleView.frame = CGRectMake(frame.origin.x, 5, frame.size.width, 34);
        self.navigationItem.titleView = _titleView;
        _titleView.text = titleString;
    }else{
        self.title = titleString;
    }
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),L(@"NearbySuning_StoreDetailInformation"),self.storeDto.storeId];
    
    if (isFristLoad)
    {
        
        [self refreshData];
        
    }
    
    if (!IsArrEmpty(self.serviceAndCampaignView.serviceList) || !IsArrEmpty(self.serviceAndCampaignView.campaignList))
    {
        
        [self.serviceAndCampaignView.groupTableView reloadData];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self refreshView];
    
    //[self.serviceAndCampaignView.groupTableView reloadData];
    
}

- (void)loadView
{
    
    [super loadView];
    
    [self displayOverFlowActivityView];

    
//    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),L(@"NearbySuning_StoreDetailInformation"),self.storeId];
    
    self.segView = [[UIImageView alloc]initWithFrame:CGRectMake(58, 15, 204, 28)];
    
    self.segView.image = [UIImage imageNamed:@"suning_tab_service.png"];
    
}

- (void)refreshView
{
    self.shareBtn.frame = CGRectMake(295, 7, 25, 25);
    self.collectBtn.frame = CGRectMake(270, 7, 23, 23);
//    [self.collectBtn setImage:[UIImage imageNamed:@"suning_button_Favorite_default.png"] forState:UIControlStateNormal];
    [self refreshCollectBtnView];
    
    [self.shareBtn setImage:[UIImage imageNamed:@"suning_button_share_default.png"] forState:UIControlStateNormal];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:self.collectBtn];
    NSArray *items = [[NSArray alloc]initWithObjects:item1, item2, nil];
    [self.navigationItem setRightBarButtonItems:items];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    view.backgroundColor = [UIColor uiviewBackGroundColor];
    [view addSubview:self.segView];
    [view addSubview:self.serveAndCamBtn];
    [view addSubview:self.detailInfoBtn];
    [self.view addSubview:view];    
}

- (void)refreshCollectBtnView
{
    if (![UserCenter defaultCenter].isLogined){
        [_collectBtn setImage:[UIImage imageNamed:@"suning_button_Favorite_default.png"] forState:UIControlStateNormal];
    }else{
        if ([self.storeDto.isFavo isEqualToString:@"1"]){
            [_collectBtn setImage:[UIImage imageNamed:@"suning_button_Favorite_selected.png"] forState:UIControlStateNormal];
        }else{
            [_collectBtn setImage:[UIImage imageNamed:@"suning_button_Favorite_default.png"] forState:UIControlStateNormal];
        }
    }
}

- (void)refreshData
{
    if (![UserCenter defaultCenter].isLogined){
        [self.storeDetailInfoService getStoreDetailInfoWithStoreId:self.storeDto.storeId userId:@""];
    }else{
        [self.storeDetailInfoService getStoreDetailInfoWithStoreId:self.storeDto.storeId userId:[UserCenter defaultCenter].userInfoDTO.userId];
    }
    [self displayOverFlowActivityView];
}

#pragma mark-
#pragma mark  StoreDetailInfoServiceDelegate
- (void)getStoreDetailInfo:(StoreDetailInfoService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
 {
     [self removeOverFlowActivityView];
     
     if (isSuccess){
         self.storeDetailView.infoDTO = service.storeInfoDTO;
         self.storeDto.isFavo = service.storeInfoDTO.isFavo;
         self.serviceAndCampaignView.campaignList = service.storeCampaignListArr;
         self.serviceAndCampaignView.serviceList = service.storeServiceListArr;
         if (IsArrEmpty(service.storeCampaignListArr) && IsArrEmpty(service.storeServiceListArr)){
             [self.serviceAndCampaignView.noDataView setHidden:NO];
         }
         [self refreshCollectBtnView];
         [self.serviceAndCampaignView.groupTableView reloadData];
         [self.storeDetailView.groupTableView reloadData];
         isFristLoad = NO;         
     }else{
     
         if(errorMsg == nil || [errorMsg isEqualToString:@""]){
             [self presentSheet:L(@"NearbySuning_GetStoreInfoFailed")];
         }else{
             [self presentSheet:errorMsg];
         }
         isFristLoad = YES;
     }
}

- (StoreDetailInfoService *)storeDetailInfoService
{
    if (!_storeDetailInfoService)
    {
        _storeDetailInfoService = [[StoreDetailInfoService alloc]init];
        
        _storeDetailInfoService.serviceDelegate =self;
    }
    return _storeDetailInfoService;
}

- (UpdateFavoStoreService *)updateFavoStoreService
{
    
    if (!_updateFavoStoreService)
    {
        _updateFavoStoreService = [[UpdateFavoStoreService alloc]init];
        
        _updateFavoStoreService.serviceDelegate = self;
        
    }
    
    return _updateFavoStoreService;
}

- (StoreServiceAndCampaignListView *)serviceAndCampaignView
{
    if(_serviceAndCampaignView == nil)
    {
        _serviceAndCampaignView = [[StoreServiceAndCampaignListView alloc]initWithOwner:self];
        
        _serviceAndCampaignView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _serviceAndCampaignView.delegate = self;
        
        [self.view addSubview:_serviceAndCampaignView];
        
    }
    return _serviceAndCampaignView;
    
}

- (StoreDetailInfoView *)storeDetailView
{
    if(_storeDetailView == nil)
    {
        _storeDetailView = [[StoreDetailInfoView alloc]initWithOwner:self];
        
        _storeDetailView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
    }
    return _storeDetailView;
    
}


- (UIButton *)collectBtn
{
    if(_collectBtn == nil)
    {
        _collectBtn = [[UIButton alloc]init];
        
        _collectBtn.backgroundColor = [UIColor clearColor];
        
        [_collectBtn setAlpha:1.0];
        
        [_collectBtn setEnabled:YES];
        
        [_collectBtn addTarget:self action:@selector(collectStore:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _collectBtn;
}

- (UIButton *)shareBtn
{
    if(_shareBtn == nil)
    {
        _shareBtn = [[UIButton alloc]init];
        
        _shareBtn.backgroundColor = [UIColor clearColor];
        
        [_shareBtn addTarget:self action:@selector(shareStore) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _shareBtn;
}

//点击收藏按钮
- (void)collectStore:(UIButton *)sender
{
    //判断登录
    if (![UserCenter defaultCenter].isLogined){
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        loginViewController.loginDelegate = self;
        loginViewController.loginDidOkSelector = @selector(loginSuccess);
        loginViewController.loginDidCancelSelector = @selector(loginCancel);
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]initWithRootViewController:loginViewController];
        [self presentModalViewController:userNav animated:YES];
        return;
    }else{
        if ([self.storeDto.isFavo isEqualToString:@"1"]){
            [sender setAlpha:0.5];
            [sender setEnabled:NO];
            NSString *str = [[NSString alloc]initWithFormat:@"0,%@,0",self.storeDto.storeId];
            [self.updateFavoStoreService updateFavoStoreWithUserId:[UserCenter defaultCenter].userInfoDTO.userId storeStatus:str];
        }else{
            [sender setImage:[UIImage imageNamed:@"suning_button_Favorite_selected.png"] forState:UIControlStateNormal];
            [sender setAlpha:0.5];
            [sender setEnabled:NO];
            NSString *str = [[NSString alloc]initWithFormat:@"0,%@,1",self.storeDto.storeId];
            [self.updateFavoStoreService updateFavoStoreWithUserId:[UserCenter defaultCenter].userInfoDTO.userId storeStatus:str];
        }
    }    
}

- (void)loginSuccess
{
    
    [self refreshData];
    
}

- (void)loginCancel
{
    
    [self.storeDetailView.groupTableView reloadData];
    
}

#pragma mark-
#pragma mark  UpdateFavoStoreServiceDelegate
- (void)updateFavoStore:(UpdateFavoStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        
        if ([self.storeDto.isFavo isEqualToString:@"0"]) {
                    
            [self presentSheet:L(@"NearbySuning_Liked") posY:300];
            self.storeDto.isFavo = @"1";
        }
        else
        {
            [self presentSheet:L(@"NearbySuning_Canceled") posY:300];
            self.storeDto.isFavo = @"0";
        }
        
        [self refreshView];
    }
    else
    {
        if ([self.storeDto.isFavo isEqualToString:@"0"]) {
            
            [self presentSheet:L(@"NearbySuning_LikeFailed") posY:300];
            self.storeDto.isFavo = @"0";
        }
        else
        {
            [self presentSheet:L(@"NearbySuning_CancelFailed") posY:300];
            self.storeDto.isFavo = @"1";
        }
        
        [self refreshView];
        
    }
    
}

//点击分享
- (void)shareStore
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121404"], nil]];
    
    [self.shareKit shareWithContent:[self getShareMessage]];
    
    [self.chooseShareWayView showChooseShareWayView];
    
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    
    [self.shareKit didChooseShareWay:shareWay];
    
}

#pragma mark -
#pragma mark 分享数据的获取

//组合分享文本信息
- (NSString *)getShareMessage
{
    
//    int count = 7+[self.storeDto.name length]+10+10+5;
//    
//    DLog("%d", count);
    
    NSString *content = [NSString stringWithFormat:@"%@%@%@%@",
                             L(@"NearbySuning_IThink"),self.storeDto.name,L(@"NearbySuning_HengLaFeng"),
                             L(@"NearbySuning_ChuanSongMen")];
    return content;
    
}

- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView)
    {
        _chooseShareWayView = [[ChooseShareWayView alloc] init];
        
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}


- (SNShareKit *)shareKit
{
    if (!_shareKit)
    {
        
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
        
    }
    return _shareKit;
}




- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex != _selectIndex)
    {
        _selectIndex = selectIndex;
        
        [self refreshButtons];
    }
}

- (UIButton *)serveAndCamBtn
{
    if (!_serveAndCamBtn)
    {
        _serveAndCamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _serveAndCamBtn.frame = CGRectMake(58, 15, 102, 28);
        
        [_serveAndCamBtn addTarget:self
                            action:@selector(buttonTapped:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        _serveAndCamBtn.tag = 0;
        
        [_serveAndCamBtn setTitle:L(@"NearbySuning_ServiceAndActivity") forState:UIControlStateNormal];
        
        [_serveAndCamBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _serveAndCamBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
    }
    
    return _serveAndCamBtn;
}

- (UIButton *)detailInfoBtn
{
    if (!_detailInfoBtn)
    {
        _detailInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _detailInfoBtn.frame = CGRectMake(160, 15, 102, 28);
        
        [_detailInfoBtn addTarget:self
                           action:@selector(buttonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        _detailInfoBtn.tag = 1;
        
        [_detailInfoBtn setTitle:L(@"NearbySuning_StoreInfo") forState:UIControlStateNormal];
        
        [_detailInfoBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        
        _detailInfoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
    }
    return _detailInfoBtn;
}

- (void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSInteger index = button.tag;
    
    if (self.selectIndex == index)
    {
        return;
    }
    self.selectIndex = index;
    
    [self refreshButtons];
    
    [self didSelectSegmentAtIndex:index];
    
}

- (void)refreshButtons
{
    if (_selectIndex == 0)
    {
        
        [self.serveAndCamBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.detailInfoBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        
        self.segView.image = [UIImage imageNamed:@"suning_tab_service.png"];
        
    }else if (_selectIndex == 1)
    {
        [self.serveAndCamBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        
        [self.detailInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.segView.image = [UIImage imageNamed:@"suning_tab_xinxi.png"];
        
    }
}

- (void)didSelectSegmentAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self.storeDetailView removeFromSuperview];
        
        [self.view addSubview:self.serviceAndCampaignView];
        
        [self.view sendSubviewToBack:self.serviceAndCampaignView];
        
    }
    else if (index == 1)
    {
        [self.serviceAndCampaignView removeFromSuperview];
        
        [self.view addSubview:self.storeDetailView];
        
        [self.view sendSubviewToBack:self.storeDetailView];
        
    }
    
}

#pragma -
#pragma mark StoreServiceAndCampaignListViewDelegate

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
        
        vc.campaignDetailInfoView.campaignDto = dto;
        
        vc.campaignDetailInfoView.campaignStore = @" ";
        
        vc.campaignDTO = dto;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }

}

- (void)goBackToStoreList
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
