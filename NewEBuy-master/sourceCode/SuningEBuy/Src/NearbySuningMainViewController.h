//
//  NearbySuningMainViewController.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "AddressInfoPickerView.h"
#import "ToolBarButton.h"
#import "LocateCityCommand.h"

#import "SpaceFlowView.h"
#import "TopCampaignService.h"
#import "NearStoreService.h"

#import "DVVoiceModel.h"
#import "QYaoHttpService.h"
#import "VoiceSignDTO.h"
//#import "SuningStoreInfoService.h"
#import "VoiceCodeActivityService.h"

#import "BMKLocationService.h"
#import "BMKGeoCodeSearch.h"

@interface NearbySuningMainViewController : CommonViewController<AddressInfoPickerViewDelegate,ToolBarButtonDelegate,CommandDelegate,SpaceFlowViewDataSource,SpaceFlowViewDelegate,TopCampaignServiceDelegate,NearStoreServiceDelegate,UIGestureRecognizerDelegate,VoiceDelegate,QYaoHttpServiceDelegate,VoiceCodeActivityServiceDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,EGOImageViewDelegate>
{
    BOOL isFristLoad;//是否为第一次加载；
    BOOL isFirstLocate;
}
@property (nonatomic, strong) DVVoiceModel              *dvVoice;
@property (nonatomic, strong) QYaoHttpService           *signservice;   //签到，摇一摇跟摇一摇抽奖页面公用同一个接口
@property (nonatomic, strong) VoiceCodeActivityService  *listService;
@property (nonatomic,strong)  UIButton                  *backGroundBtn;
@property (nonatomic, strong) ToolBarButton             *defaultAddressButton;
//@property (nonatomic, strong) UIButton                  *voiceBtn;
@property (nonatomic, strong) AddressInfoPickerView     *addressPickerView;
@property (nonatomic, strong) NSString                  *cityNameStr;  //用于存储定位后的城市名称
@property (nonatomic, strong) NSString                  *cityId;       //用于存储定位后的城市ID
@property (nonatomic) CLLocationCoordinate2D            userLocation;
@property (nonatomic, strong) UIImageView               *placeArrowImage;
@property (nonatomic, strong) UIView                    *navigationView;
@property (nonatomic, strong) UIView                    *bottomView;
@property (nonatomic, strong) UIActivityIndicatorView   *locateView;
@property (nonatomic, strong) UILabel                   *storeName;
@property (nonatomic, strong) UILabel                   *locateInfo;
@property (nonatomic, strong) UILabel                   *storeInfo;
@property (nonatomic, strong) SpaceFlowView             *spaceFlowView;
@property (nonatomic, strong) NSArray                   *campaignList;
@property (nonatomic, strong) TopCampaignService        *topCampaignService;
@property (nonatomic, strong) NearStoreService          *nearStoreService;
@property (nonatomic, strong) SuningStoreDTO            *nearStoreDto;
@property (nonatomic, strong) UIView                    *storeView;
@property (nonatomic, strong) UIView                    *loadingView;
@property (nonatomic, strong) UIButton                  *gotoStoreDetailBtn;
@property (nonatomic, strong) BMKLocationService        *bmkLocationService;
@property (nonatomic, strong) BMKGeoCodeSearch          *bmkGeoCodeSearch;

-(void)sendChouJiangRequest;

@end
