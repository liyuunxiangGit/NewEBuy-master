//
//  NearbySuningMainViewController.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearbySuningMainViewController.h"
#import "SNSwitch.h"
#import "PlayVoiceViewController.h"
#import "AllCitySuningViewController.h"
#import "AllCityCampaignViewController.h"
#import "AllCityServiceViewController.h"
#import "MySuningStoreViewController.h"
#import "StoreCampaignDTO.h"
#import "AddressInfoDAO.h"
#import "CampaignDetailInfoViewController.h"
#import "SNWebViewController.h"
#import "ActiveRuleViewController.h"
#import "QYaoYiYaoViewCtrler.h"
#import "VoiceSignViewController.h"
#import "LoginViewController.h"
#import "dvSoundDecoder.h"
#import "VoiceSignLoginViewController.h"
@interface NearbySuningMainViewController ()
{
    NSString  *activeid;
    UIButton *voiceBtn;
    NSTimer *myTimer;
    NSString  *activeTypeId;
    NSString *defaultCityName;
}
@end


@implementation NearbySuningMainViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        _cityNameStr = [[NSString alloc]init];
        _cityId = [[NSString alloc]init];
        self.campaignList = [[NSArray alloc]initWithObjects:nil];
        self.cityNameStr = [Config currentConfig].nearByCityName;
        self.cityId = [Config currentConfig].nearByCityId;
        defaultCityName = [Config currentConfig].nearByCityName;
        isFristLoad = YES;
        isFirstLocate = YES;
        self.hidesBottomBarWhenPushed =YES;
        self.hasNav = NO;
        self.bSupportPanUI = NO;
        [self setIOS7FullScreenLayout:YES];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_defaultAddressButton);
    TT_RELEASE_SAFELY(_addressPickerView);
    TT_RELEASE_SAFELY(_cityNameStr);
    TT_RELEASE_SAFELY(_navigationView);
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_locateView);
    TT_RELEASE_SAFELY(_storeName);
    TT_RELEASE_SAFELY(_spaceFlowView);
    TT_RELEASE_SAFELY(_locateInfo);
    TT_RELEASE_SAFELY(_storeInfo);
    TT_RELEASE_SAFELY(_storeView);
    TT_RELEASE_SAFELY(_loadingView);
    TT_RELEASE_SAFELY(_topCampaignService);
    TT_RELEASE_SAFELY(_nearStoreDto);
    TT_RELEASE_SAFELY(_nearStoreService);
    TT_RELEASE_SAFELY(_gotoStoreDetailBtn);
    TT_INVALIDATE_TIMER(myTimer);
    TT_RELEASE_SAFELY(_bmkLocationService);
    [self.bmkLocationService stopUserLocationService];

    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [CommandManage cancelCommandByClass:[LocateCityCommand class]];
}

- (void)loadView
{
    [super loadView];
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"NearbySuning_NearHome_HomePage"),[Config currentConfig].nearByCityId];
    [self refreshView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.storeView];
    [self.view addSubview:self.loadingView];
    [self.storeView setHidden:YES];
    
    if ([SNSwitch isNearbySuningVoiceSign]) {
        [self isLoadBackGroundBtn];
    }
    //[self refreshView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceSubmit) name:NEARBYSUNING object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (isFristLoad){
        [self refreshData];
    }
    if (![defaultCityName isEqualToString:[Config currentConfig].nearByCityName]) {
        defaultCityName = [Config currentConfig].nearByCityName;
        [self setDefaultAddressButtonTitle:[Config currentConfig].nearByCityName];
        [self refreshData];
    }
}

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    return bCanRecord;
}

-(void)applicationWillResignActive:(id)send{
    if ([SNSwitch isNearbySuningVoiceSign]) {
        [self.dvVoice sectimecall];
    }
    if ([self.defaultAddressButton becomeFirstResponder]) {
        [self.defaultAddressButton resignFirstResponder];
    }
}

-(void)applicationDidBecomeActive{
    if ([SNSwitch isNearbySuningVoiceSign] && myTimer) {
        if (![self canRecord]) {
            BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:L(@"NearbySuning_NeedMicrophone") message:L(@"NearbySuning_SetYouMicrophone") delegate:self cancelButtonTitle:L(@"AlertKnow") otherButtonTitles:nil];
            [alertView show];
        }
        else{
            myTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(voiceBtnClick) userInfo:nil repeats:NO];
            [self.dvVoice initwithhomelisen:20];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IOS7_OR_LATER) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    _bmkGeoCodeSearch.delegate = self;
    _bmkLocationService.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil]; //监听是否重新进入程序.
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied && [[Config currentConfig].nearByUnLocate boolValue]){
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:L(@"NearbySuning_LocationNotOpen") message:L(@"NearbySuning_OpenLocationService") delegate:self cancelButtonTitle:L(@"AlertKnow") otherButtonTitles:nil];
        [alertView show];
        [Config currentConfig].nearByUnLocate = @NO;
    }
    
    if(isFirstLocate){
        //        [self displayOverFlowActivityView];
        //判断用户设备是否支持定位功能及用户是否允许应用访问用户位置
        if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
            [self presentSheet:L(@"NearbySuning_CannotGetYouPosition") posY:400];
            self.cityNameStr = [Config currentConfig].nearByCityName;
            self.cityId = [Config currentConfig].nearByCityId;
            self.storeInfo.text = L(@"NearbySuning_RecommendStore");
            //self.storeName.frame = CGRectMake(63, (50-20)/2, 220, 20);
            isFirstLocate = YES;
            //根据缓存城市ID获取附近门店
            [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
                                                         longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                          latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
            //[self refreshData];
        }else{
            //            LocateCityCommand *locateCmd = [LocateCityCommand command];
            //            locateCmd.timeOutDefault = 15.0f;
            //            locateCmd.delegate = self;
            //            [CommandManage excuteCommand:locateCmd observer:self];
            [self.bmkLocationService startUserLocationService];
            //[self.locateView startAnimating];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _bmkLocationService.delegate = nil;
    _bmkGeoCodeSearch.delegate = nil;
    [self.bmkLocationService stopUserLocationService];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if ([SNSwitch isNearbySuningVoiceSign]) {
        [self.dvVoice sectimecall];
    }
}

- (void)refreshView
{
    [self setDefaultAddressButtonTitle:self.cityNameStr];
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_bg.png"]];
    backView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:backView];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.bottomView];
    
    UIButton *allCitySuningBtn = [[UIButton alloc]init];
    if (isIPhone5){
        allCitySuningBtn.frame = CGRectMake(24, self.view.frame.size.height - 181, 52, 51);
    }else{
        allCitySuningBtn.frame = CGRectMake(24, self.view.frame.size.height - 151, 52, 51);
    }
    allCitySuningBtn.tag = 0;
    allCitySuningBtn.backgroundColor = [UIColor clearColor];
    [allCitySuningBtn setImage:[UIImage imageNamed:@"home_button_suning_default.png"] forState:UIControlStateNormal];
    [allCitySuningBtn setImage:[UIImage imageNamed:@"home_button_suning_pressed.png"] forState:UIControlStateHighlighted];
    [allCitySuningBtn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allCitySuningBtn];
    
    UIButton *storeCampaignBtn = [[UIButton alloc]init];
    if (isIPhone5){
        storeCampaignBtn.frame = CGRectMake(100, self.view.frame.size.height - 181, 52, 51);
    }else{
        storeCampaignBtn.frame = CGRectMake(100, self.view.frame.size.height - 151, 52, 51);
    }
    storeCampaignBtn.tag = 1;
    storeCampaignBtn.backgroundColor = [UIColor clearColor];
    [storeCampaignBtn setImage:[UIImage imageNamed:@"home_button_events_default.png"] forState:UIControlStateNormal];
    [storeCampaignBtn setImage:[UIImage imageNamed:@"home_button_events_pressed.png"] forState:UIControlStateHighlighted];
    [storeCampaignBtn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:storeCampaignBtn];
    
    UIButton *storeServiceBtn = [[UIButton alloc]init];
    if (isIPhone5){
        storeServiceBtn.frame = CGRectMake(176, self.view.frame.size.height - 181, 52, 51);
    }else{
        storeServiceBtn.frame = CGRectMake(176, self.view.frame.size.height - 151, 52, 51);
    }
    storeServiceBtn.tag = 2;
    storeServiceBtn.backgroundColor = [UIColor clearColor];
    [storeServiceBtn setImage:[UIImage imageNamed:@"home_button_service_default.png"] forState:UIControlStateNormal];
    [storeServiceBtn setImage:[UIImage imageNamed:@"home_button_service_pressed.png"] forState:UIControlStateHighlighted];
    [storeServiceBtn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:storeServiceBtn];
    
    UIButton *mySuningBtn = [[UIButton alloc]init];
    if (isIPhone5){
        mySuningBtn.frame = CGRectMake(252, self.view.frame.size.height - 181, 52, 51);
    }else{
        mySuningBtn.frame = CGRectMake(252, self.view.frame.size.height - 151, 52, 51);
    }
    mySuningBtn.tag = 3;
    mySuningBtn.backgroundColor = [UIColor clearColor];
    [mySuningBtn setImage:[UIImage imageNamed:@"home_button_isn_default.png"] forState:UIControlStateNormal];
    [mySuningBtn setImage:[UIImage imageNamed:@"home_button_isn_pressed.png"] forState:UIControlStateHighlighted];
    [mySuningBtn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mySuningBtn];
    
    UILabel *allCitySuningLbl = [[UILabel alloc]init];
    if (isIPhone5){
        allCitySuningLbl.frame = CGRectMake(24, self.view.frame.size.height - 120, 52, 14);
    }else{
        allCitySuningLbl.frame = CGRectMake(24, self.view.frame.size.height - 90, 52, 14);
    }
    allCitySuningLbl.text = L(@"NearbySuning_AroundCitySuning");
    allCitySuningLbl.backgroundColor = [UIColor clearColor];
    allCitySuningLbl.font = [UIFont boldSystemFontOfSize:13.0];
    allCitySuningLbl.textColor = [UIColor whiteColor];
    [self.view addSubview:allCitySuningLbl];
    
    UILabel *storeCampaignLbl = [[UILabel alloc]init];
    if (isIPhone5){
        storeCampaignLbl.frame = CGRectMake(100, self.view.frame.size.height - 120, 52, 14);
    }else{
        storeCampaignLbl.frame = CGRectMake(100, self.view.frame.size.height - 90, 52, 14);
    }
    storeCampaignLbl.text = L(@"NearbySuning_StoreActivity");
    storeCampaignLbl.backgroundColor = [UIColor clearColor];
    storeCampaignLbl.font = [UIFont boldSystemFontOfSize:13.0];
    storeCampaignLbl.textColor = [UIColor whiteColor];
    [self.view addSubview:storeCampaignLbl];
    
    UILabel *storeServiceLbl = [[UILabel alloc]init];
    if (isIPhone5){
        storeServiceLbl.frame = CGRectMake(176, self.view.frame.size.height - 120, 52, 14);
    }else{
        storeServiceLbl.frame = CGRectMake(176, self.view.frame.size.height - 90, 52, 14);
    }
    storeServiceLbl.text = L(@"NearbySuning_SunshineService");
    storeServiceLbl.backgroundColor = [UIColor clearColor];
    storeServiceLbl.font = [UIFont boldSystemFontOfSize:13.0];
    storeServiceLbl.textColor = [UIColor whiteColor];
    [self.view addSubview:storeServiceLbl];
    
    UILabel *mySuningLbl = [[UILabel alloc]init];
    if (isIPhone5){
        mySuningLbl.frame = CGRectMake(252, self.view.frame.size.height - 120, 52, 14);
    }else{
        mySuningLbl.frame = CGRectMake(252, self.view.frame.size.height - 90, 52, 14);
    }
    mySuningLbl.text = L(@"NearbySuning_MySuning");
    mySuningLbl.backgroundColor = [UIColor clearColor];
    mySuningLbl.font = [UIFont boldSystemFontOfSize:13.0];
    mySuningLbl.textColor = [UIColor whiteColor];
    [self.view addSubview:mySuningLbl];
}

- (void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoDetail:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag)
    {
        case 0:
        {
            AllCitySuningViewController *vc = [[AllCitySuningViewController alloc]init];
            vc.userLocation = self.userLocation;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 1:
        {
            if ([_campaignList count] == 0){
                [self presentSheet:L(@"NearbySuning_ActivityWaiting")];
            }else{
                AllCityCampaignViewController *vc = [[AllCityCampaignViewController alloc]init];
                vc.userLocation = self.userLocation;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
            
        case 2:
        {
            AllCityServiceViewController *vc = [[AllCityServiceViewController alloc]init];
            vc.userLocation = self.userLocation;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 3:
        {
            MySuningStoreViewController *vc = [[MySuningStoreViewController alloc]init];
            vc.userLocation = self.userLocation;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (UIView *)navigationView
{
    if (!_navigationView){
        if (IOS7_OR_LATER){
            _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
        }else{
            _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 70)];
        }
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 26, 46, 40)];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn setImage:[UIImage imageNamed:@"home_button_back_default.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"home_button_back_pressed.png"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:backBtn];
        
        if ([SNSwitch isNearbySuningVoiceSign]) {
            voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 48-5, 33-10, 33+20, 24+20)];
            voiceBtn.backgroundColor = [UIColor clearColor];
            [voiceBtn setImage:[UIImage imageNamed:@"home_button_sound_pressed.png"] forState:UIControlStateNormal];
            [voiceBtn setImage:[UIImage imageNamed:@"home_button_sound_pressed.png"] forState:UIControlStateHighlighted];
            [voiceBtn setImage:[UIImage imageNamed:@"home_button_sound_pressed.png"] forState:UIControlStateDisabled];
            [voiceBtn addTarget:self action:@selector(changeToVoiceView) forControlEvents:UIControlEventTouchUpInside];
            voiceBtn.enabled = YES;
            myTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(voiceBtnClick) userInfo:nil repeats:NO];
            [_navigationView addSubview:voiceBtn];
        }
        [_navigationView addSubview:self.defaultAddressButton];
        [_navigationView addSubview:self.placeArrowImage];
    }
    return _navigationView;
}

-(void)voiceBtnClick{
    [voiceBtn setImage:[UIImage imageNamed:@"home_button_sound_default.png"] forState:UIControlStateNormal];
    if (myTimer) {
        TT_INVALIDATE_TIMER(myTimer);
        [self.dvVoice sectimecall];
    }
}

//切换声波视图
- (void)changeToVoiceView
{
    [self voiceBtnClick];
    PlayVoiceViewController *vc = [[PlayVoiceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIActivityIndicatorView *)locateView
{
    if (!_locateView){
        _locateView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _locateView.frame = CGRectMake(32, (50-21)/2, 21, 21);
        [_locateView startAnimating];
    }
    return _locateView;
}

- (UILabel *)storeName
{
    if (!_storeName){
        _storeName = [[UILabel alloc]initWithFrame:CGRectMake(140, (50-20)/2, 160, 20)];
        _storeName.backgroundColor = [UIColor clearColor];
        _storeName.font = [UIFont boldSystemFontOfSize:15.0];
        _storeName.textColor = [UIColor orangeColor];
    }
    return _storeName;
}

- (UILabel *)locateInfo
{
    if (!_locateInfo){
        _locateInfo = [[UILabel alloc]initWithFrame:CGRectMake(63, (50-20)/2, 200, 20)];
        _locateInfo.backgroundColor = [UIColor clearColor];
        _locateInfo.font = [UIFont boldSystemFontOfSize:15.0];
        _locateInfo.text = L(@"LocatingNow");
        _locateInfo.textColor = [UIColor whiteColor];
    }
    return _locateInfo;
}

- (UIView *)bottomView
{
    if (!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
        _bottomView.backgroundColor = [UIColor blackColor];
        [_bottomView setAlpha:0.5];
    }
    return _bottomView;
}

- (SpaceFlowView *)spaceFlowView
{
    if (!_spaceFlowView){
        if (IOS7_OR_LATER && isIPhone5){
            _spaceFlowView = [[SpaceFlowView alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 265)];
        }else if (!IOS7_OR_LATER && isIPhone5){
            _spaceFlowView = [[SpaceFlowView alloc] initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, 265)];
        }else if (IOS7_OR_LATER && !isIPhone5){
            _spaceFlowView = [[SpaceFlowView alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 237)];
        }else{
            _spaceFlowView = [[SpaceFlowView alloc] initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, 237)];
        }
        _spaceFlowView.dataSource = self;
        _spaceFlowView.delegate = self;
        [_spaceFlowView reloadData];
    }
    return _spaceFlowView;
}

- (ToolBarButton *)defaultAddressButton
{
    if (!_defaultAddressButton){
        _defaultAddressButton = [[ToolBarButton alloc] init];
        _defaultAddressButton.delegate = self;
//        _defaultAddressButton.frame = CGRectMake(self.view.frame.size.width/3, 30, 100, 30);
        [_defaultAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _defaultAddressButton.backgroundColor = [UIColor clearColor];
        _defaultAddressButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _defaultAddressButton.inputView = self.addressPickerView;
//        [_defaultAddressButton addSubview:self.placeArrowImage];
    }
    return _defaultAddressButton;
}

- (UIButton *)gotoStoreDetailBtn
{
    if (!_gotoStoreDetailBtn){
        _gotoStoreDetailBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        _gotoStoreDetailBtn.backgroundColor = [UIColor clearColor];
        [_gotoStoreDetailBtn addTarget:self action:@selector(gotoStoreDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoStoreDetailBtn;
}

- (UIImageView *)placeArrowImage
{
    if (!_placeArrowImage){
        _placeArrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_button_drop_default.png"]];
        _placeArrowImage.backgroundColor = [UIColor clearColor];
    }
    return _placeArrowImage;
}

- (UIView *)storeView
{
    if (!_storeView){
        _storeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
        
        UIImageView *storeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_icon_dianpu.png"]];
        storeImg.frame = CGRectMake(32, (50-24)/2, 24, 24);
        storeImg.backgroundColor = [UIColor clearColor];
        [_storeView addSubview:storeImg];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_icon_jiantou.png"]];
        arrowImage.frame = CGRectMake(299, (50-12)/2, 7, 12);
        arrowImage.backgroundColor = [UIColor clearColor];
        
        [_storeView addSubview:arrowImage];
        [_storeView addSubview:self.storeInfo];
        [_storeView addSubview:self.storeName];
        [_storeView addSubview:self.gotoStoreDetailBtn];
    }
    return _storeView;
}

- (UILabel *)storeInfo
{
    if (!_storeInfo){
        _storeInfo = [[UILabel alloc]initWithFrame:CGRectMake(63, (50-20)/2, 100, 20)];
        _storeInfo.backgroundColor = [UIColor clearColor];
        _storeInfo.font = [UIFont boldSystemFontOfSize:15.0];
        _storeInfo.text = L(@"NearbySuning_NearGoodStore");
        _storeInfo.textColor = [UIColor whiteColor];
    }
    return _storeInfo;
}


- (void)gotoStoreDetail:(UIButton *)sender
{
    if (self.nearStoreDto) {
        StoreTotalInfoViewController *vc = [[StoreTotalInfoViewController alloc]init];
        vc.storeDto = self.nearStoreDto;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)loadingView
{
    
    if (!_loadingView){
        _loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
        [_loadingView addSubview:self.locateView];
        [_loadingView addSubview:self.locateInfo];
    }
    return _loadingView;
}

- (void)isLoadBackGroundBtn{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"isfirstloadnearbysuning"];
    if (!name) {
        [self.appDelegate.window addSubview:self.backGroundBtn];
        [defaults setObject:@"0" forKey:@"isfirstloadnearbysuning"];
    }
    else{
        [self voiceClick];
    }
}

- (UIButton *)backGroundBtn
{
    
    if (!_backGroundBtn) {
        _backGroundBtn = [[UIButton alloc] init];
        CGRect frame;
        frame = self.view.bounds;
        frame.size.height += 64;
        _backGroundBtn.frame = frame;
        _backGroundBtn.backgroundColor = [UIColor blackColor];
        _backGroundBtn.alpha = 0.7;
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(320-158, 64, 158, 121)];
        img1.image = [UIImage imageNamed:@"home_pop_sound.png"];
        [_backGroundBtn addSubview:img1];
        [_backGroundBtn addTarget:self action:@selector(backGroundBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backGroundBtn;
}

- (void)setDefaultAddressButtonTitle:(NSString *)title
{
    NSString *titleString = [[NSString alloc] init];
    
    if (title.length > 10){
        titleString = [title substringWithRange:NSMakeRange(0, 10)];
    }else{
        titleString = title;
    }
    CGSize size = [titleString sizeWithFont:[UIFont systemFontOfSize:20.0] constrainedToSize:CGSizeMake(INT_MAX, 30)];
    self.defaultAddressButton.frame = CGRectMake((self.view.frame.size.width-size.width)/2, 30, size.width, 30);
    [self.defaultAddressButton setTitle:[NSString stringWithFormat:@"%@",titleString] forState:UIControlStateNormal];
    float x = (self.view.frame.size.width-size.width)/2 + size.width;
    self.placeArrowImage.frame = CGRectMake(x+10, 42, 8, 6);
}

- (AddressInfoPickerView *)addressPickerView
{
    if (!_addressPickerView){
        AddressInfoDTO *address = [[AddressInfoDTO alloc] init];
        address.province = [Config currentConfig].defaultProvince;
        address.city = [Config currentConfig].defaultCity;
        _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.addressDelegate = self;
    }
    return _addressPickerView;
}

- (TopCampaignService *)topCampaignService
{
    if(_topCampaignService == nil){
        _topCampaignService = [[TopCampaignService alloc]init];
        _topCampaignService.serviceDelegate = self;
    }
    return _topCampaignService;
}

- (NearStoreService *)nearStoreService
{
    
    if(_nearStoreService == nil)
        //    if([SNSwitch isNearbySuningVoiceSign])
    {
        _nearStoreService = [[NearStoreService alloc]init];
        _nearStoreService.serviceDelegate = self;
    }
    return _nearStoreService;
}

- (BMKLocationService *)bmkLocationService
{
    if (_bmkLocationService == nil) {
        _bmkLocationService = [[BMKLocationService alloc] init];
        _bmkLocationService.delegate = self;
    }
    return _bmkLocationService;
}

- (BMKGeoCodeSearch *)bmkGeoCodeSearch
{
    if (!_bmkGeoCodeSearch) {
        _bmkGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _bmkGeoCodeSearch.delegate = self;
    }
    return _bmkGeoCodeSearch;
}

- (void)refreshData
{
    //请求身边首页活动
    [self.topCampaignService getCampaignListWithCityId:[Config currentConfig].nearByCityId];
    [self displayOverFlowActivityView:L(@"NearbySuning_GoodActivityWaiting")];
}

#pragma mark-
#pragma mark  TopCampaignServiceDelegate
- (void)getTopCampaignList:(TopCampaignService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess){
        self.campaignList = service.campaignListArr;
        if (isIPhone5){
            self.spaceFlowView.radiusRatio = [SpaceFlowView radiusRatioRecommendVauleWithCount:self.campaignList.count<3?3:self.campaignList.count viewWidth:self.view.frame.size.width widthRatio:250.0/self.view.frame.size.width];
        }else{
            self.spaceFlowView.radiusRatio = [SpaceFlowView radiusRatioRecommendVauleWithCount:self.campaignList.count<3?3:self.campaignList.count viewWidth:self.view.frame.size.width widthRatio:223.0/self.view.frame.size.width];
        }
        [self.view addSubview:self.spaceFlowView];
        [self.spaceFlowView setHidden:NO];
        [self.spaceFlowView reloadData];
        isFristLoad = NO;
    }else{
        [self presentSheet:L(@"NearbySuning_NetworkNotStable")];
        [self.spaceFlowView setHidden:YES];
        isFristLoad = YES;
    }
}

#pragma mark-
#pragma mark  NearStoreServiceDelegate
- (void)getNearestSuningStore:(NearStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess){
        if (!service.nearStore.name){
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips")
                                                            message:L(@"NearbySuning_GoToNearCity")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"Cancel")
                                                  otherButtonTitles:L(@"NearbySuning_GoToLook")];
            [alert setConfirmBlock:^{
                NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_NowLocateTo"),self.cityNameStr];
                self.locateInfo.text = str;
                [self.locateView stopAnimating];
                [self.defaultAddressButton becomeFirstResponder];
            }];
            [alert setCancelBlock:^{
                NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_NowLocateTo"),self.cityNameStr];
                self.locateInfo.text = str;
                [self.locateView stopAnimating];
            }];
            [alert show];
        }else{
            [self.loadingView setHidden:YES];
            [self.storeView setHidden:NO];
            self.nearStoreDto = service.nearStore;
            self.storeName.text = self.nearStoreDto.name;
        }
        isFirstLocate = NO;
    }else{
        [self presentSheet:L(@"NearbySuning_GetNearStoreFailed")];
        NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_NowLocateTo"),self.cityNameStr];
        self.locateInfo.text = str;
        [self.locateView stopAnimating];
    }
}

- (DVVoiceModel *)dvVoice{
    if (!_dvVoice) {
        _dvVoice = [[DVVoiceModel alloc] init];
        _dvVoice.delegate =self;
    }
    return _dvVoice;
}

- (void)backGroundBtnClick{
    [UIView animateWithDuration:0.3 animations:^(void){
        self.backGroundBtn.hidden = YES;
    } completion:^(BOOL finished){
        [self.backGroundBtn removeFromSuperview];
    }];
    [self voiceClick];
}

- (void)voiceClick{
    //    if ([UserCenter defaultCenter].isLogined) {
    //        [self.dvVoice initwithhomelisen:20];
    //    }
    //    else{
    //        [self login];
    //    }
    [self.dvVoice initwithhomelisen:20];
}

- (QYaoHttpService *)signservice{
    if (!_signservice) {
        _signservice = [[QYaoHttpService alloc] init];
        _signservice.httpDelegate =self;
    }
    return _signservice;
}

- (VoiceCodeActivityService *)listService
{
    if (!_listService) {
        _listService = [[VoiceCodeActivityService alloc]init];
        _listService.voiceActivityDelegate =self;
    }
    return _listService;
}

- (void)loginViewload{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.loginDelegate = self;
    loginVC.isNearBySuning = YES;
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
    [self presentModalViewController:navController animated:YES];
}

- (void)voiceSubmit{
    [self VoiceGetted:activeid];
}

-(void)needLogin:(NSString *)activetypeid activeid:(NSString *)activeId{
    activeTypeId = [activetypeid copy];
    activeid = activeId;
    
    if([UserCenter defaultCenter].isLogined){
        [self.signservice reqActiveChouJiang:activeTypeId];
    }
    else{
        
        VoiceSignLoginViewController *voicesignlogin = [[VoiceSignLoginViewController alloc] init];
        voicesignlogin.ower = self;
        [self.navigationController pushViewController:voicesignlogin animated:YES];
    }
}

-(void)sendChouJiangRequest{
    [self.signservice reqActiveChouJiang:activeTypeId];
}


- (void)VoiceGetted:(NSString *)voicetype{
    activeid = voicetype;
    //    [self displayOverFlowActivityView:@"正在寻找神秘声音..." yOffset: -60];
    //242新增跳转四级页面
    if ([SNSwitch isNearbySuningVoiceSignStore]) {
        [self.listService getVoiceCodeActivity:voicetype];
    }else{
        //根据声波编码寻找到活动类型
        // xzoscar 2014/10/15
        switch ([voicetype intValue]) {
            case 19:
                [self needLogin:@"e82f605984b14b9bb9065d7f74ec087d" activeid:@"e82f605984b14b9bb9065d7f74ec087d"];   // 2
                break;
            case 20:
                [self needLogin:@"2732a12900944936bbe4ada852f75fd1" activeid:@"2732a12900944936bbe4ada852f75fd1"];  // 3
                break;
            case 21:
                [self.signservice reqActiveQuery:@"f48b1f962b9848f6972818f05e165196"];
                activeid=@"f48b1f962b9848f6972818f05e165196";//5
                break;
            default:
                [self.signservice reqActiveQuery:@"fbe68e32eed34c5aa8d3a24f57168252"];
                activeid=@"fbe68e32eed34c5aa8d3a24f57168252";// 4
                break;
        }

    }
    //    [self.circleview resetarclayer];
}

- (void)getVoiceCodeActivity:(VoiceActiveDTO *)dto{
    //    [self removeOverFlowActivityView];
    if (!dto.isActity) {
        //        [self  presentSheet:@"活动已结束"];
        return;
    }
    if (!dto.errmsg && dto.actityType) {
        ActiveRuleViewController* webview;
        switch ([dto.actityType intValue]) {
            case 1:       //声波签到
                [self needLogin:dto.activeTypeID activeid:dto.activeTypeID];
                activeid=dto.activeTypeID;
                break;
            case 2:      //摇奖
                [self.signservice reqActiveQuery:dto.activeTypeID];
                activeid=dto.activeTypeID;
                break;
            case 3:{     //四级页面跳转
                [SNRouter handleAdTypeCode:dto.adTypeID adId:dto.adID chanId:nil qiangId:nil
                                onChecking:^(SNRouterObject *obj) {
                                    [self displayOverFlowActivityView];
                                } shouldRoute:^BOOL(SNRouterObject *obj) {
                                    [self removeOverFlowActivityView];
                                    if (obj.errorMsg) {
                                        [self presentSheet:obj.errorMsg];
                                        return NO;
                                    }else{
                                        obj.navController = self.navigationController;
                                        return YES;
                                    }
                                } didRoute:^(SNRouterObject *obj) {
                                    
                                } source:SNRouteSourceSomeCode];
                
                break;
            }
            case 4:
                webview = [[ActiveRuleViewController alloc] init:dto.wapUrl];
                webview.title =@"";
                [self.navigationController pushViewController:webview animated:YES];
                break;
            default:
                break;
        }
    }
    else{
        //        [self  presentSheet:dto.errmsg];
    }
}

- (void)delegate_yaoYiYaoHttpServeResult:(id)object {
    //    [self removeOverFlowActivityView];
    QHttpObject *obj = object;
    if (nil == obj.errMsg) {
        if (obj.cmd == CC_YaoYiYaoActiveQuery) {
            QYaoQueryDTO *bean = (QYaoQueryDTO *)obj;
            // 云钻摇易摇
            QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:1];
            ctrler.activeQueryBean = bean;
            ctrler.activeTypeId = activeid;
            ctrler.ctrlerType   = kQYaoViewCtrlerShengBo;
            [self.navigationController pushViewController:ctrler animated:YES];
            
        }else if (obj.cmd == CC_YaoYiYaoActiveShakeJiang){
            QYaoChouJiangDTO *bean = (QYaoChouJiangDTO *)obj;
            VoiceSignViewController *voicesign = [[VoiceSignViewController alloc] initWithdto:[self presevoicedto:bean]];
            [self.navigationController pushViewController:voicesign animated:YES];
        }
    }
    else{
        //        [self  presentSheet:@"没有寻找到神秘声音"];
    }
}

-(VoiceSignDTO *)presevoicedto:(QYaoChouJiangDTO *)bean{
    VoiceSignDTO *signdto = [[VoiceSignDTO alloc] init];
    signdto.cloudnum = bean.prizeValue;
    signdto.rewardstring = bean.mrakedwords;
    signdto.duihuancode = bean.serialNumber;
    signdto.bannerurl = bean.prizeAdUrl;
    signdto.imgurl =bean.prizePicUrl;
    signdto.shareContent = L(@"NearbySuning_ShareContent");//bean.shareContent;
    signdto.title = bean.activename;
    signdto.prizeTypeName = bean.prizeName;
    if ([bean.resultCode isEqualToString:@"e03"] ||
        [bean.resultCode isEqualToString:@"e04"] ||
        [bean.resultCode isEqualToString:@"e10"]) {         // 已经签到
        signdto.rewardtype = HaveSigned;
        signdto.rewardstring = L(@"NearbySuning_Rewardstring0");
        return signdto;
        
    }else if([bean.resultCode isEqualToString:@""] || IsStrEmpty(bean.resultCode)){
        if ([bean.prizeType integerValue]==1) {
            signdto.rewardtype = SignIntegration;
            signdto.rewardstring = L(@"NearbySuning_Rewardstring1");
            return signdto;
        }else if ([bean.prizeType integerValue]==3) {
            signdto.rewardtype = CloudReward;
            signdto.rewardstring = L(@"NearbySuning_Rewardstring2");
        }
        if (nil != bean.isEntityPrize && [bean.isEntityPrize isEqualToString:@"1"]){
            signdto.rewardtype = PhysicalReward;
            signdto.rewardstring = L(@"NearbySuning_Rewardstring3");
        }
        //        }
        return signdto;
    }else{// 未中奖
        signdto.rewardtype = NoReward;
        signdto.rewardstring = L(@"NearbySuning_Rewardstring0");
        return signdto;
    }
    return signdto;
}

//#pragma mark -
//#pragma mark GetLocationCommand
//
//- (void)commandDidFinish:(id<Command>)cmd
//{
//    LocateCityCommand *locateCmd = (LocateCityCommand *)cmd;
//
//    if (locateCmd.responseStatus == LocateCitySuccess)
//    {
//        //self.userPoint = BMKMapPointForCoordinate(locateCmd.coordinate);
//        self.userLocation = locateCmd.coordinate;
//
//        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
//
//        AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoLikeCityName:locateCmd.cityName];
//
//        NSString *city = locateCmd.cityName;
//
//        NSString *cityId = addressInfo.city;
//
//        if ([city isEqualToString:self.cityNameStr] || IsStrEmpty(city))
//        {
//            city = [Config currentConfig].nearByCityName;
//
//            cityId = [Config currentConfig].nearByCityId;
//
//            self.cityId = cityId;
//
//            self.cityNameStr = city;
//
//            [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
//                                                         longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
//                                                          latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
//             [self displayOverFlowActivityView];
//        }
//        else
//        {
//            NSString *str = [[NSString alloc]initWithFormat:@"%@%@%@",@"您本次定位城市为",city,@",是否切换?"];
//
//            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@"提示"
//                                                            message:str
//                                                           delegate:self
//                                                  cancelButtonTitle:@"否"
//                                                  otherButtonTitles:@"是"];
//            [alert setConfirmBlock:^{
//
//                self.cityNameStr = city;
//
//                self.cityId = cityId;
//
//                [Config currentConfig].nearByCityName = self.cityNameStr;
//
//                [Config currentConfig].nearByCityId = self.cityId;
//
//                [self setDefaultAddressButtonTitle:self.cityNameStr];
//
//
//                [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
//                                                             longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
//                                                              latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
//
//                [self refreshData];
//
//                [self displayOverFlowActivityView];
//
//                    }];
//
//            [alert setCancelBlock:^{
//
//                self.cityNameStr = city;
//
//                [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
//                                                             longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
//                                                              latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
//
////                [self refreshData];
//
//                [self displayOverFlowActivityView];
//
//            }];
//
//            [alert show];
//
//        }
//
////        [Config currentConfig].nearByCityName = city;
////
////        [Config currentConfig].nearByCityId = cityId;
//
//        isFirstLocate = NO;
//
//    }
//    else
//    {
//
//        [self presentSheet:@"无法获取您当前位置!" posY:300];
//
//        self.cityNameStr = [Config currentConfig].nearByCityName;
//
//        self.cityId = [Config currentConfig].nearByCityId;
//
//        self.storeInfo.text = @"";
//
//        self.storeName.frame = CGRectMake(63, (50-20)/2, 220, 20);
//
//        isFirstLocate = YES;
//
//        [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
//                                                     longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
//                                                      latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
//
//        //[self refreshData];
//
//    }
//
//}

#pragma mark -
#pragma mark tool bar cell delegate

- (void)doneButtonClicked:(id)sender
{
    AddressInfoDTO *selectInfo = self.addressPickerView.selectAddressInfo;
    if (selectInfo.province == nil || selectInfo.city == nil){
        return;
    }
    [Config currentConfig].nearByCityName = self.addressPickerView.selectAddressInfo.cityContent;
    [Config currentConfig].nearByCityId = selectInfo.city;
    defaultCityName = [Config currentConfig].nearByCityName;
    [self setDefaultAddressButtonTitle:[Config currentConfig].nearByCityName];
    [self refreshData];
}

#pragma mark -
#pragma mark SpaceFlowViewDataSource

- (NSUInteger)numberOfChildViewsInSpaceFlowView:(SpaceFlowView *)spaceFlowView
{
    if ([_campaignList count] == 0){
        return  1;
    }else if ([_campaignList count] < 3){
        return 3;
    }else{
        return [_campaignList count];
    }
}

- (CGFloat)spaceFlowView:(SpaceFlowView *)spaceFlowView widthRatioAtIndex:(NSUInteger)index
{
    if (isIPhone5){
        return 250/self.view.frame.size.width;
    }else{
        return 223/self.view.frame.size.width;
    }
    return 0;
}

- (CGFloat)spaceFlowView:(SpaceFlowView *)spaceFlowView heightRatioAtIndex:(NSUInteger)index
{
    return 1.0;
}

- (UIView *)spaceFlowView:(SpaceFlowView *)spaceFlowView childViewAtIndex:(NSUInteger)index withFrame:(CGRect)frame
{
    if ([_campaignList count] == 1){
        if (index == 0){
            return [self setSpaceFlowChildView:YES isEmpty:NO atIndex:index withFrame:frame];
        }else{
            return [self setSpaceFlowChildView:YES isEmpty:YES atIndex:index withFrame:frame];
        }
    }else if ([_campaignList count] == 2){
        if (index == 2){
            return [self setSpaceFlowChildView:YES isEmpty:YES atIndex:index withFrame:frame];
        }else{
            return [self setSpaceFlowChildView:YES isEmpty:NO atIndex:index withFrame:frame];
        }
    }else if ([_campaignList count] == 0){
        return [self setSpaceFlowChildView:NO isEmpty:YES atIndex:index withFrame:frame];
    }else{
        return [self setSpaceFlowChildView:YES isEmpty:NO atIndex:index withFrame:frame];
    }
    return nil;
}

- (UIView *)setSpaceFlowChildView:(BOOL)isHaveCamp isEmpty:(BOOL)isEmpty atIndex:(NSUInteger)index withFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    if (isHaveCamp) {
        if (!isEmpty) {
            view.backgroundColor = [UIColor clearColor];
            StoreCampaignDTO *dto = [_campaignList safeObjectAtIndex:index];
            UIImageView *bottomImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height*300/530, frame.size.width, frame.size.height*230/530)];
            bottomImgView.image = [UIImage imageNamed:@"home_banner_bg.png"];
            [view addSubview:bottomImgView];
            
            SNUIImageView *topImgView = [[SNUIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height*300/530)];
            topImgView.delegate = self;
            topImgView.userInteractionEnabled = NO;
            topImgView.imageURL = [NSURL URLWithString:NotNilAndNull(dto.detailPic)?dto.detailPic:nil];
            [view addSubview:topImgView];
            
            UILabel *campaignTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, frame.size.height*300/530 + 10, frame.size.width*227/250, 18)];
            campaignTitle.text = NotNilAndNull(dto.name)?dto.name:nil;
            campaignTitle.numberOfLines = 1;
            if (isIPhone5){
                campaignTitle.font = [UIFont boldSystemFontOfSize:15.0];
            }else{
                campaignTitle.font = [UIFont boldSystemFontOfSize:13.0];
            }
            campaignTitle.textAlignment = NSTextAlignmentLeft;
            campaignTitle.backgroundColor = [UIColor clearColor];
            [view addSubview:campaignTitle];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, frame.size.height*300/530 + 28, frame.size.width*227/250, (frame.size.height*230/530)*75/115)];
            label.text = NotNilAndNull(dto.campDescription)?dto.campDescription:nil;
            label.numberOfLines = 4;
            if (isIPhone5){
                label.font = [UIFont boldSystemFontOfSize:14.0];
            }else{
                label.font = [UIFont boldSystemFontOfSize:12.0];
            }
            label.textAlignment = NSTextAlignmentLeft;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRGBHex:0x707070];
            [view addSubview:label];
            
            //            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-frame.size.width*121/250)/2, frame.size.height-frame.size.height*50/265, frame.size.width*121/250, frame.size.height*36/265)];
            //            btn.backgroundColor = [UIColor clearColor];
            //            [btn setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_default.png"] forState:UIControlStateNormal];
            //            [btn setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_pressed.png"] forState:UIControlStateHighlighted];
            //            btn.tag = index;
            //            [btn setTitle:@"马上参加" forState:UIControlStateNormal];
            //            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //            if (isIPhone5)
            //            {
            //                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            //            }
            //            else
            //            {
            //                btn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
            //            }
            //            [btn addTarget:self action:@selector(gotoCampaign:) forControlEvents:UIControlEventTouchUpInside];
            //            [view addSubview:btn];
        }else{
            view.backgroundColor = [UIColor colorWithRGBHex:0xdddddd];
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*15/250, frame.size.height*20/265, frame.size.width*219/250, frame.size.height*150/265)];
            imgView.image = [UIImage imageNamed:@"home_pop_wxx.png"];
            [view addSubview:imgView];
            
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*30/250, frame.size.height*195/265, frame.size.width*190/250, 40)];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.text = L(@"NearbySuning_MoreActivity");
            lbl.numberOfLines = 2;
            if (isIPhone5){
                lbl.font = [UIFont boldSystemFontOfSize:15.0];
            }else{
                lbl.font = [UIFont boldSystemFontOfSize:14.0];
            }
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = [UIColor colorWithRGBHex:0x909090];
            [view addSubview:lbl];
        }
    }else{
        view.backgroundColor = [UIColor colorWithRGBHex:0xdddddd];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*15/250, frame.size.height*20/265, frame.size.width*219/250, frame.size.height*150/265)];
        imgView.image = [UIImage imageNamed:@"home_pop_wxx.png"];
        [view addSubview:imgView];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height*195/265, frame.size.width, 15)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = L(@"NearbySuning_ActivityWaiting");
        if (isIPhone5){
            lbl.font = [UIFont boldSystemFontOfSize:14.0];
        }else{
            lbl.font = [UIFont boldSystemFontOfSize:12.0];
        }
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor colorWithRGBHex:0x707070];
        [view addSubview:lbl];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*58/250, frame.size.height*219/265, frame.size.width*143/250 + 10, 20)];
        label.backgroundColor = [UIColor clearColor];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:L(@"NearbySuning_SeeNearStores")]];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        label.attributedText = content;
        if (isIPhone5){
            label.font = [UIFont boldSystemFontOfSize:14.0];
        }else{
            label.font = [UIFont boldSystemFontOfSize:12.0];
        }
        label.textColor = [UIColor orangeColor];
        label.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tapGr.delegate = self;
        tapGr.cancelsTouchesInView = NO;
        [label addGestureRecognizer:tapGr];
        [view addSubview:label];
    }
    return view;
}

- (void)viewTapped:(UITapGestureRecognizer *)sender
{
    AllCitySuningViewController *vc = [[AllCitySuningViewController alloc]init];
    vc.userLocation = self.userLocation;
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)gotoCampaign:(UIButton *)sender
//{
//    StoreCampaignDTO *dto = [[StoreCampaignDTO alloc]init];
//
//    dto = [_campaignList objectAtIndex:sender.tag];
//
//    if (![dto.activityUrl isEqualToString:@""])
//    {
//        NSString *activityUrl = dto.activityUrl;
//
//        if (activityUrl.length)
//        {
//            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": activityUrl}];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//    }
//    else
//    {
//        CampaignDetailInfoViewController *vc = [[CampaignDetailInfoViewController alloc]init];
//
//        vc.campaignDTO = dto;
//
//        vc.userLocation = self.userLocation;
//
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//
//}

#pragma mark -
#pragma mark SpaceFlowViewDelegate
- (void)spaceFlowView:(SpaceFlowView *)spaceFlowView didSelectedAtIndex:(NSUInteger)index
{
    StoreCampaignDTO *dto = [_campaignList safeObjectAtIndex:index];
    if (dto) {
        if (![dto.activityUrl isEqualToString:@""]){
            NSString *activityUrl = dto.activityUrl;
            if (activityUrl.length){
                SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": activityUrl}];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            CampaignDetailInfoViewController *vc = [[CampaignDetailInfoViewController alloc]init];
            vc.campaignDTO = dto;
            vc.userLocation = self.userLocation;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark -
#pragma mark BMKLocationServiceDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    self.userLocation = userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [self.bmkGeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag){
        DLog(@"反geo检索发送成功");
    }else{
        DLog(@"反geo检索发送失败");
    }
    [self.bmkLocationService stopUserLocationService];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self presentSheet:L(@"NearbySuning_CannotGetYouPosition") posY:300];
    self.storeInfo.text = L(@"NearbySuning_RecommendStore");
    isFirstLocate = YES;
    //定位失败，根据缓存城市ID获取附近门店
    [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
                                                 longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                  latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
//    [self.bmkLocationService stopUserLocationService];
}

#pragma mark -
#pragma mark BMKGeoCodeSearchDelegate

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
    AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoLikeCityName:result.addressDetail.city];
    NSString *city = result.addressDetail.city;
    NSString *cityId = addressInfo.city;
    if ([city isEqualToString:self.cityNameStr] || IsStrEmpty(city)){
        city = self.cityNameStr;
        cityId = self.cityId;
        [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
                                                     longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                      latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
        //[self displayOverFlowActivityView];
    }else{
        NSString *str = [[NSString alloc]initWithFormat:@"%@%@%@",L(@"NearbySuning_ThisLocateCity"),city,L(@"NearbySuning_WillSwitch")];
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips")
                                                        message:str
                                                       delegate:self
                                              cancelButtonTitle:L(@"NearbySuning_No")
                                              otherButtonTitles:L(@"NearbySuning_Yes")];
        [alert setConfirmBlock:^{
            self.cityNameStr = city;
            self.cityId = cityId;
            defaultCityName = city;
            [Config currentConfig].nearByCityName = self.cityNameStr;
            [Config currentConfig].nearByCityId = self.cityId;
            [self setDefaultAddressButtonTitle:self.cityNameStr];
            [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
                                                         longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                          latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
            [self refreshData];
            //[self displayOverFlowActivityView];
        }];
        [alert setCancelBlock:^{
            self.cityNameStr = city;
            self.cityId = cityId;
            [self.nearStoreService getNearestSuningStoreWithCityId:self.cityId
                                                         longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                          latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
            
            //[self displayOverFlowActivityView];
        }];
        [alert show];
    }
    isFirstLocate = NO;
}

#pragma mark -
#pragma mark EGOImageViewDelegate
- (void)imageViewLoadedImage:(EGOImageView*)imageView
{
    if (imageView.image&&imageView.image != imageView.placeholderImage) {
        [self.spaceFlowView reloadDataFinished];
    }
}

@end
