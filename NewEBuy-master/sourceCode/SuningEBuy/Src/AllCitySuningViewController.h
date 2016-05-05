//
//  AllCitySuningViewController.h
//  SuningEBuy
//
//  Created by JackyWu on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "BMapKit.h"
#import "NearbySuningBubbleView.h"
#import "LocateCityCommand.h"
#import "SuningStoreDTO.h"
#import "AllCityStoreListView.h"
#import "StoreTotalInfoViewController.h"
#import "SuningStoreService.h"
#import "UpdateFavoStoreService.h"
//#import "SuningStoreInfoService.h"

@interface AllCitySuningViewController : CommonViewController<BMKMapViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate,AllCityStoreListViewDelegate,/*AllCityStoreListCellDelegate,*/SuningStoreServiceDelegate/*,UpdateFavoStoreServiceDelegate*/>
{
    NSInteger centerTag;//标记地图中心标注点的tag；
    BOOL isMapView;//判断显示的视图是否为地图视图
    BOOL isShowAnnomation;//判断是否显示标注点信息
    BOOL isSuccessSearchCity;
    BMKPoiSearch  *search_;
    BMKLocationService *locationService;
}

@property (nonatomic, strong) BMKMapView                *bMKMapView;
@property (nonatomic, strong) BMKAnnotationView         *selectedAV;
@property (nonatomic, strong) NearbySuningBubbleView    *bubbleView;
@property (nonatomic, strong) AllCityStoreListView      *storeListView;
@property (nonatomic, strong) UIButton                  *mapBtn;
@property (nonatomic, strong) NSArray                   *allCityStoreList;
@property (nonatomic, strong) NSMutableArray            *annomationList;
@property (nonatomic) BMKMapPoint                       userPoint;
@property (nonatomic) CLLocationCoordinate2D            userLocation;
//@property (nonatomic, strong) NSString                  *cityId;
@property (nonatomic, strong) SuningStoreService        *listService;
//@property (nonatomic, strong) UpdateFavoStoreService    *updateFavoStoreService;
@property (nonatomic, strong) NSString                  *storeId;

@end
