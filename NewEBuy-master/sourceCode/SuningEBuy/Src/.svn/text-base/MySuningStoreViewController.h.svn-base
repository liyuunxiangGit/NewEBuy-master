//
//  MySuningStoreViewController.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "MySuningStoreListView.h"
#import "MyFavouriteStoreService.h"
#import <CoreLocation/CoreLocation.h>
#import "UpdateFavoStoreService.h"

@interface MySuningStoreViewController : CommonViewController<MySuningStoreListViewDelegate, /*AllCityStoreListCellDelegate,*/MyFavouriteStoreServiceDelegate /*UpdateFavoStoreServiceDelegate*/>

@property (nonatomic, strong) MySuningStoreListView     *mySuningStoreView;
@property (nonatomic, strong) MyFavouriteStoreService   *myFavoStoreService;
@property (nonatomic, strong) UpdateFavoStoreService    *updateFavoStoreService;
@property (nonatomic, strong) NSMutableArray            *allCityStoreList;
@property (nonatomic) CLLocationCoordinate2D            userLocation;
@property (nonatomic, strong) NSString                  *storeId;

@end
