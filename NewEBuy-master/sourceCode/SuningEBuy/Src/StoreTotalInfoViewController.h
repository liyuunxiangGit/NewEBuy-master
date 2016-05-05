//
//  StoreTotalInfoViewController.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "StoreServiceAndCampaignListView.h"
#import "StoreDetailInfoView.h"
#import "SuningStoreDTO.h"
#import "SuningStoreDetailInfoDTO.h"
#import "SNShareKit.h"
#import "StoreDetailInfoService.h"
#import "UpdateFavoStoreService.h"

@interface StoreTotalInfoViewController : CommonViewController<StoreServiceAndCampaignListViewDelegate,ChooseShareWayViewDelegate,StoreDetailInfoServiceDelegate,UpdateFavoStoreServiceDelegate>
{
    
    BOOL isFristLoad;//是否为第一次加载；
    
}

@property (nonatomic, strong) StoreServiceAndCampaignListView *serviceAndCampaignView;

@property (nonatomic, strong) StoreDetailInfoView             *storeDetailView;

@property (nonatomic, strong) SuningStoreDTO                  *storeDto;

@property (nonatomic, strong) NSString                        *storeId;

@property (nonatomic, strong) NSString                        *storeName;

//@property (nonatomic, strong) SuningStoreDetailInfoDTO        *storeDetailDto;

@property (nonatomic, assign) NSInteger                       selectIndex;

@property (nonatomic, strong) UIButton                        *serveAndCamBtn;

@property (nonatomic, strong) UIButton                        *detailInfoBtn;

@property (nonatomic, strong) UIButton                        *collectBtn;

@property (nonatomic, strong) UIButton                        *shareBtn;

@property (nonatomic, strong) UIImageView                     *segView;

@property (nonatomic, strong) SNShareKit                      *shareKit;//分享控制器

@property (nonatomic, strong) ChooseShareWayView              *chooseShareWayView;//分享方式

@property (nonatomic, strong) StoreDetailInfoService          *storeDetailInfoService;

@property (nonatomic, strong) UpdateFavoStoreService          *updateFavoStoreService;


- (void)refreshButtons;

- (void)didSelectSegmentAtIndex:(NSInteger)index;

@end
