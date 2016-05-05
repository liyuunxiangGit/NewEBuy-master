//
//  AllCitySuningViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCitySuningViewController.h"
#import "NearbySuningPointAnnotation.h"
#import "LoginViewController.h"

static CGFloat  kTransitionDuration = 0.45f;

@implementation AllCitySuningViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        _annomationList = [[NSMutableArray alloc]init];
        _storeId = [[NSString alloc]init];
        //百度地图搜索， 确保选择某一个城市的苏宁门店是，将该城市放到地图的中心位置
        search_ = [[BMKPoiSearch alloc]init];
        search_.delegate = self;
        locationService = [[BMKLocationService alloc]init];
        locationService.delegate = self;
        self.hidesBottomBarWhenPushed =YES;
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)dealloc
{
    _bMKMapView.delegate = nil;
    TT_RELEASE_SAFELY(_bMKMapView);
    TT_RELEASE_SAFELY(_selectedAV);
    TT_RELEASE_SAFELY(_bubbleView);
    TT_RELEASE_SAFELY(_annomationList);
    search_.delegate = nil;
    TT_RELEASE_SAFELY(search_);
    TT_RELEASE_SAFELY(_listService);
    locationService.delegate = nil;
    TT_RELEASE_SAFELY(locationService);
    TT_RELEASE_SAFELY(_storeId);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.bubbleView.distanceLabel.hidden = NO;
    self.bMKMapView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _bMKMapView.delegate = self;
    search_.delegate = self;
    [self refreshData];
    if (isMapView) {
        [locationService startUserLocationService];
        self.bMKMapView.showsUserLocation = YES;
        [self.bMKMapView setCenterCoordinate:self.userLocation animated:YES];
    }
    if (!IsArrEmpty(self.allCityStoreList)){
        [self.storeListView.groupTableView reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    if (isMapView) {
        [locationService stopUserLocationService];
    }
    _bMKMapView.delegate = nil;
    search_.delegate = nil;
}

- (void)loadView
{
    [super loadView];
    
    [self displayOverFlowActivityView];
    
    
    self.mapBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 7, 16, 23);
        
    [_mapBtn setImage:[UIImage imageNamed:@"suning_button_map_default.png"] forState:UIControlStateNormal];
        
    //[_mapBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.mapBtn];
    
    [self.navigationItem setRightBarButtonItem:item];
    
    TT_RELEASE_SAFELY(item);
    
    self.title = L(@"NearbySuning_AroundCitySuning");
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",@"身边苏宁",self.title,[Config currentConfig].nearByCityId];
    
    centerTag = -1;
    
    isMapView = NO;
    
}

//请求城市苏宁门店信息
- (void)refreshData
{
    centerTag = -1;
    
    isSuccessSearchCity = NO;
    
    [self.bMKMapView removeAnnotations:self.annomationList];
    
    [self.annomationList removeAllObjects];
    
    if (![UserCenter defaultCenter].isLogined)
    {
        
        [self.listService getAllCityStoreListWithCityId:[Config currentConfig].nearByCityId
                                              longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                               latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]
                                                 userId:@""];
        
    }
    else
    {
        
        [self.listService getAllCityStoreListWithCityId:[Config currentConfig].nearByCityId
                                              longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                               latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]
                                                 userId:[UserCenter defaultCenter].userInfoDTO.userId];
        
    }
    
    BMKCitySearchOption *citySearchInfo = [[BMKCitySearchOption alloc]init];
    
    citySearchInfo.city = [Config currentConfig].nearByCityName;
    
    citySearchInfo.keyword = [Config currentConfig].nearByCityName;
    
    citySearchInfo.pageIndex = 0;
    
    [search_ poiSearchInCity:citySearchInfo];
    
    [self displayOverFlowActivityView];
    
}

//在地图上标注苏宁门店及用户位置的点
- (void)signPointOnMap
{
    for (int i= 0; i<self.allCityStoreList.count; i++) {
        SuningStoreDTO *dto = [self.allCityStoreList objectAtIndex:i];
        if(![dto.latitude isEqualToString:@""]) {
            NearbySuningPointAnnotation *annotation = [[NearbySuningPointAnnotation alloc]init];
            CLLocationCoordinate2D coor ;
            coor.longitude = [dto.longitude doubleValue];
            coor.latitude = [dto.latitude doubleValue];
            annotation.tag = i;
            annotation.title = dto.name;
            annotation.coordinate = coor;
            if(!IOS5_OR_LATER||!isSuccessSearchCity) {
                self.bMKMapView.centerCoordinate = coor;
            }
            [self.annomationList addObject:annotation];
            [self.bMKMapView addAnnotation:annotation];            
            TT_RELEASE_SAFELY(annotation);
        }
    }
}

#pragma mark-
#pragma mark  SuningStoreServiceDelegate
- (void)getAllCitySuningStoreList:(SuningStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess){
        self.allCityStoreList = [service.storeListArr sortedArrayUsingComparator:^NSComparisonResult(SuningStoreDTO *obj1, SuningStoreDTO *obj2) {
            if (!IsStrEmpty(obj1.distance) && !IsStrEmpty(obj2.distance)) {
                if ([obj1.distance floatValue] > [obj2.distance floatValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                if ([obj1.distance floatValue] < [obj2.distance floatValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        [self.storeListView.goodStoreList removeAllObjects];
        [self.storeListView.otherStoreList removeAllObjects];
        for (SuningStoreDTO *dto in service.storeListArr){
            if ([dto.isTopStore isEqualToString:@""]){
                [self.storeListView.otherStoreList addObject:dto];
            }else{
                [self.storeListView.goodStoreList addObject:dto];
            }
        }
        if(IsArrEmpty(self.allCityStoreList)){
            [self.storeListView.noDataView setHidden:NO];
        }else{
            [self.storeListView.noDataView setHidden:YES];
        }
        [self.storeListView.groupTableView reloadData];
        [self signPointOnMap];
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
//        [self.storeListView.groupTableView reloadData];
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
//        [self.storeListView.groupTableView reloadData];
//        
//    }
//    
//}

- (AllCityStoreListView *)storeListView
{
    if(_storeListView == nil)
    {
        _storeListView = [[AllCityStoreListView alloc]initWithOwner:self];
        
        _storeListView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _storeListView.delegate = self;
        
        [self.view addSubview:_storeListView];
        
    }
    return _storeListView;
    
}

- (BMKMapView*)bMKMapView
{
    if(_bMKMapView == nil)
    {
        _bMKMapView = [[BMKMapView alloc] init];
        
        _bMKMapView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
        
        _bMKMapView.backgroundColor = [UIColor clearColor];
        
        [_bMKMapView setMapType:BMKMapTypeStandard];
        
        _bMKMapView.showsUserLocation = YES;
        
        _bMKMapView.zoomLevel = 13;
        
        _bMKMapView.delegate = self;
        
    }
    
    return _bMKMapView;
}

- (UIButton*)mapBtn
{
    if(_mapBtn == nil)
    {
        _mapBtn = [[UIButton alloc]init];
        
        _mapBtn.backgroundColor = [UIColor clearColor];
        
        [_mapBtn addTarget:self action:@selector(changeMap) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _mapBtn;
}

- (NearbySuningBubbleView*)bubbleView
{
    if(_bubbleView == nil)
    {
        _bubbleView  = [[NearbySuningBubbleView alloc] init];
    }
    
    return _bubbleView;
}

- (SuningStoreService *)listService
{
    if (!_listService)
    {
        _listService = [[SuningStoreService alloc]init];
        
        _listService.serviceDelegate = self;
    }
    return _listService;
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

- (void)changeViewAnimation
{
    [UIView beginAnimations:@"preferenceSettingsAnimations" context:nil];
    
    [UIView setAnimationDuration:0.8];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
    
    [UIView commitAnimations];
}

//切换列表和地图视图
- (void)changeMap
{
    if(isMapView)
    {
        isMapView = NO;
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),self.title,[Config currentConfig].nearByCityId ];
        
        [self.bMKMapView removeFromSuperview];
        
        [locationService stopUserLocationService];
        
        self.bMKMapView.showsUserLocation = NO;
        
        [self.view addSubview:self.storeListView];
        
        [self.view sendSubviewToBack:self.storeListView];
        
        [self changeViewAnimation];
        
        [self.mapBtn setBackgroundColor:[UIColor clearColor]];
        
        [self.mapBtn setFrame:CGRectMake(290, 7, 16, 23)];
            
        [self.mapBtn setImage:[UIImage imageNamed:@"suning_button_map_default.png"] forState:UIControlStateNormal];
            
        //[self.mapBtn setImage:[UIImage imageNamed:@"active_sound.png"] forState:UIControlStateHighlighted];
        
    }
    else
    {
        isMapView = YES;
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"PageTitleNearbySuning"),L(@"NearbySuning_AllOverCitySuningMap"),[Config currentConfig].nearByCityId];
        
        [self.storeListView removeFromSuperview];
        
        [self.view addSubview:self.bMKMapView];
        
        [self.view sendSubviewToBack:self.bMKMapView];
        
        [self changeViewAnimation];
        
        [locationService startUserLocationService];
        
        self.bMKMapView.showsUserLocation = YES;
        
        [self.bMKMapView setCenterCoordinate:self.userLocation animated:YES];
        
        [self.mapBtn setBackgroundColor:[UIColor clearColor]];
        
        [self.mapBtn setFrame:CGRectMake(290, 7, 20, 19)];
        
        [self.mapBtn setImage:[UIImage imageNamed:@"suning_button_list_default.png"] forState:UIControlStateNormal];
        
    }
    
}

//更新自定义气泡的位置
- (void)changeBubblePosition
{
    if (self.selectedAV)
    {
//        [self showBubble:YES];
        [self.bubbleView showFromRect:self.selectedAV.frame];
        CGRect rect = self.selectedAV.frame;
        CGPoint center;
        center.x = rect.origin.x + rect.size.width/2 + 1;
        center.y = rect.origin.y - self.bubbleView.frame.size.height/2 + 2;
        self.bubbleView.center = center;
    }
}

#pragma mark -
#pragma mark BMKLocationServiceDelegate

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
	DLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    [_bMKMapView updateLocationData:userLocation];
//    DLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    [_bMKMapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    DLog(@"stop locate");
}

#pragma mark -
#pragma mark BMKPoiSearchDelegate

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMKErrorOk)
    {
        BMKPoiInfo *poi = [poiResult.poiInfoList objectAtIndex:0];
        
        self.bMKMapView.centerCoordinate = poi.pt;
        
        isSuccessSearchCity = YES;
        
    }
    
}

#pragma mark 区域改变
#pragma mark BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (isShowAnnomation&&centerTag != -1)
    {
        self.bubbleView.hidden = NO;
        [self changeBubblePosition];
        isShowAnnomation = NO;
    }
    else
    {
        centerTag = -1;
        
        self.selectedAV.selected = NO;
        
        [self.bMKMapView.delegate mapView:self.bMKMapView didDeselectAnnotationView:self.selectedAV];
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView*)[mapView viewForAnnotation:annotation];
    
    if (annotationView == nil)
    {
        NearbySuningPointAnnotation *ann = nil;
        if ([annotation isKindOfClass:[NearbySuningPointAnnotation class]]) {
            ann = annotation;
        }
        NSUInteger tag = ann.tag;
        NSString *AnnotationViewID = [NSString stringWithFormat:@"AnnotationView-%i", tag];
        
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*) annotationView).pinColor = BMKPinAnnotationColorRed;
        
        annotationView.canShowCallout = NO;//使用自定义bubble
        
		((BMKPinAnnotationView*)annotationView).animatesDrop = YES;// 设置该标注点动画显示
        
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        
        annotationView.annotation = annotation;
        
        if (tag == -1) {
            annotationView.image = [UIImage imageNamed:@"icon_center_point.png"];
            annotationView.enabled = NO;
        }
        else if (tag == 0 && self.userLocation.latitude) {
            
            annotationView.image = [UIImage imageNamed:@"pin_suning_nearest.png"];
            
        }else{
            
            annotationView.image = [UIImage imageNamed:@"pin_suning.png"];
        }
	}
	return annotationView ;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
        NSUInteger tag = [(NearbySuningPointAnnotation*)view.annotation tag];
        if (tag == -1) {
            return;
        }
        self.selectedAV = view;
        SuningStoreDTO *dto = [self.allCityStoreList objectAtIndex:tag];
        CGSize size = [dto.name sizeWithFont:[UIFont boldSystemFontOfSize:14.0]];
        if ([dto.distance isEqualToString:@"-1.0"]){
            self.bubbleView.frame = CGRectMake(0, 0, size.width + 40 > 140 ? (size.width + 40 < 300 ? size.width + 40 : 300): 140, 60);
        }else{
            self.bubbleView.frame = CGRectMake(0, 0, size.width + 90 > 190 ? (size.width + 90 < 300 ? size.width + 90 : 300): 190, 60);
        }
        [self.selectedAV.superview addSubview:self.bubbleView];
        self.bubbleView.layer.zPosition = 1;
        self.bubbleView.nearbySuningDto = dto;
        __weak AllCitySuningViewController *weakSelf = self;
        [self.bubbleView setGoToDetailBlock:^{
            StoreTotalInfoViewController *vc = [[StoreTotalInfoViewController alloc]init];
            //vc.storeDetailDto.storeId = dto.storeId;
            vc.storeDto = dto;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }];
        
        isShowAnnomation = YES;
        
        if(tag == centerTag)
        {
            isShowAnnomation = NO;
            
            self.bubbleView.hidden = NO;
            
            [self changeBubblePosition];
            
        }else{
            
            self.bubbleView.hidden = YES;
            
            centerTag = tag;
        }
        
    }
    else {
        self.selectedAV = nil;
    }
    
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
        [self showBubble:NO];
    }
}

#pragma mark show bubble animation
- (void)bounce4AnimationStopped{
    
    [UIView animateWithDuration:kTransitionDuration/6 animations:^{
        
        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0,1.0);
        
    }completion:^(BOOL finish){
        
    }];
    
}

- (void)bounce3AnimationStopped{
    
    [UIView animateWithDuration:kTransitionDuration/6 animations:^{
        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
    }completion:^(BOOL finish){
        
        [self bounce4AnimationStopped];
    }];
    
}

- (void)bounce2AnimationStopped{
    
    [UIView animateWithDuration:kTransitionDuration/6 animations:^{
        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
    }completion:^(BOOL finish){
        
        [self bounce3AnimationStopped];
    }];
    
}

- (void)bounce1AnimationStopped{
    
    [UIView animateWithDuration:kTransitionDuration/6 animations:^{
        self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    }completion:^(BOOL finish){
        
        [self bounce2AnimationStopped];
    }];
    
}

- (void)showBubble:(BOOL)show {
    if (show) {
        
        [self.bubbleView showFromRect:self.selectedAV.frame];
        
        [UIView animateWithDuration:kTransitionDuration/3 animations:^{
            self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            self.bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        }completion:^(BOOL finish){
            [self bounce1AnimationStopped];
        }];
        
    }
    else {
        
        [UIView animateWithDuration:kTransitionDuration/3 animations:^{
            [self.bubbleView removeFromSuperview];
        }completion:^(BOOL finish){
            
        }];
    }
}

#pragma -
#pragma mark AllCityStoreListViewDelegate

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto
{
    StoreTotalInfoViewController *vc = [[StoreTotalInfoViewController alloc]init];    
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
//    
//}

- (void)loginSuccess
{
    
    [self refreshData];
}

- (void)loginCancel
{
    
    [self.storeListView.groupTableView reloadData];
    
}

@end
