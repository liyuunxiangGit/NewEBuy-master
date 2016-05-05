//
//  NearbySpotViewController.h
//  SuningEBuy
//
//  Created by Kristopher on 14-11-3.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ToolBarButton.h"
#import "LocateCityCommand.h"
#import "NearbySpotStoreService.h"
#import "AddressInfoDAO.h"
#import "DataProductBasic.h"
#import "NearbySpotStoreListView.h"

@interface NearbySpotViewController : CommonViewController<CommandDelegate,NearbySpotStoreListViewDelegate,NearbySpotStoreCellDelegate>

@property (nonatomic,retain) NearbySpotStoreListView     *spotListView;

@property (nonatomic,retain) DataProductBasic     *productBase;

@property (nonatomic,retain) UIButton     *relocateBtn;

@end

