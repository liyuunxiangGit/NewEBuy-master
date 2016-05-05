//
//  StoreDetailInfoViewController.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "SuningStoreInfoService.h"
#import "StoreListDTO.h"
#import "StoreDetailInfoDTO.h"

#import "NearbySuningStoreDetailCell.h"
#import "StoreHeadImageView.h"
#import "StoreServiceScrollview.h"


@interface StoreDetailInfoViewController : CommonViewController
<SuningStoreInfoServiceDelegate,serviceButtonClickedDelegate>
{
    int   _index;
    
    BOOL isFristLoad;//是否为第一次加载；

}
@property (nonatomic, strong) SuningStoreInfoService *service;
@property (nonatomic, strong) StoreDetailInfoDTO     *infoDTO;
@property (nonatomic, strong) StoreServiceDTO        *storeServiceDTO;
@property (nonatomic, strong) StoreListDTO       *listDto;

@property (nonatomic, strong) NSMutableArray *floorArr;
@property (nonatomic, strong) NSMutableArray *serviceArr;

@property (nonatomic, strong) UIWebView      *callWeb;
@property (nonatomic, strong) StoreHeadImageView  *headView;

@property (nonatomic, strong) StoreServiceScrollView *serviceView;

@end
