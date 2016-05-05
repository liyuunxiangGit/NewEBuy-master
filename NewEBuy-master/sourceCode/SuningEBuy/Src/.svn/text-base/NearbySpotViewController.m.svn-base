//
//  NearbySpotViewController.m
//  SuningEBuy
//
//  Created by Kristopher on 14-11-3.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearbySpotViewController.h"
#import "NearbySpotStoreService.h"

@interface NearbySpotViewController ()<NearbySpotStoreServiceDelegate>
{
    CLLocationCoordinate2D    _userLocation;
    NSString   *_cityID;
    NearbySpotStoreService *_storeService;
}
@end


@implementation NearbySpotViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        
        _userLocation = (CLLocationCoordinate2D){-1.0,-1.0};
        
        _productBase = nil;
        
        _cityID = nil;
        
        _storeService = [[NearbySpotStoreService alloc] init];
        
        _storeService.serviceDelegate = self;
        
        self.bSupportPanUI = NO;
        
        [self setIOS7FullScreenLayout:NO];
        
        
    }
    return self;
}

- (void)dealloc
{
    [CommandManage cancelCommandByClass:[LocateCityCommand class]];
}

- (void)loadView
{
    [super loadView];
    
    self.pageTitle = L(@"Product_NearbyNowGoodsHome");
    
    self.title = @"附近现货";
    
    [self refreshView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.relocateBtn.hidden = NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self startLocating];
}


- (void)startLocating{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:L(@"NearbySuning_LocationNotOpen") message:L(@"NearbySuning_OpenLocationService") delegate:self cancelButtonTitle:L(@"AlertKnow") otherButtonTitles:nil];
        [alertView show];
    }
    //判断用户设备是否支持定位功能及用户是否允许应用访问用户位置
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        [self presentSheet:L(@"NearbySuning_CannotGetYouPosition") posY:400];
        _cityID = [Config currentConfig].defaultCity;
        _userLocation = (CLLocationCoordinate2D){0.0,0.0};
        [self refreshData];
    }else{
        LocateCityCommand *locateCmd = [LocateCityCommand command];
        locateCmd.timeOutDefault = 10.0f;
        locateCmd.delegate = self;
        [CommandManage excuteCommand:locateCmd observer:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.relocateBtn.hidden = YES;
    
    [_relocateBtn removeFromSuperview];
    
    _relocateBtn = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
}

- (void)refreshView
{
    
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    
    backView.frame = [UIScreen mainScreen].bounds;
    
    [self.view addSubview:backView];
    
}

- (void)gotoBack
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)refreshData
{
    if (!_productBase) {
        return;
    }
    if (!_cityID) {
        _cityID = [Config currentConfig].defaultCity;
    }
    [_storeService getNearbySpotStoreListWithCityCode:_cityID
                                            longitude:_userLocation.longitude
                                             latitude:_userLocation.latitude
                                          productBase:_productBase];
    
    [self displayOverFlowActivityView];
    
}


- (void)relocate:(id)sender{
    [self startLocating];
}


- (NearbySpotStoreListView*)spotListView{
    if (!_spotListView) {
        _spotListView = [[NearbySpotStoreListView alloc] initWithOwner:self];
        _spotListView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        _spotListView.delegate = self;
        [self.view addSubview:_spotListView];
    }
    return _spotListView;
}


- (UIButton*)relocateBtn{
    if (!_relocateBtn) {
        _relocateBtn = [[UIButton alloc] init];
        self.relocateBtn.frame = CGRectMake(210, 13, 14, 16);
        [_relocateBtn setImage:[UIImage imageNamed:@"fujinmendian-shuaxin.png"] forState:UIControlStateNormal];
        [_relocateBtn addTarget:self action:@selector(relocate:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:_relocateBtn];
    }
    return _relocateBtn;
}



#pragma mark -
#pragma mark GetLocationCommand

- (void)commandDidFinish:(id<Command>)cmd
{
    LocateCityCommand *locateCmd = (LocateCityCommand *)cmd;

    if (locateCmd.responseStatus == LocateCitySuccess)
    {
        _userLocation = locateCmd.coordinate;

        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];

        AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoLikeCityName:locateCmd.cityName];

        _cityID = addressInfo.city;

    }
    else
    {

        [self presentSheet:L(@"NearbySuning_CannotGetYouPosition") posY:400];

        _cityID = [Config currentConfig].defaultCity;
        
        _userLocation = (CLLocationCoordinate2D){-1.0,-1.0};

    }
    
    [self refreshData];

}

#pragma mark -
#pragma mark NearbySpotStoreService

- (void)getNearbySpotStoreList:(NSMutableArray *)storeList isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        self.spotListView.storeList = storeList;
    }else{
        [self presentSheet:errorMsg];
        self.spotListView.storeList = nil;
    }
    
}

#pragma mark -
#pragma mark NearbySpotStoreListDelegate

- (void)gotoShopCartWithPickupStoreInfo:(NearbySpotStoreDTO *)dto{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121801"], nil]];
}

@end
