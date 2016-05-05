//
//  NearbySuningShopListView.h
//  SuningEBuy
//
//  Created by Kristopher on 14-8-1.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "NearbySpotStoreCell.h"

@protocol NearbySpotStoreListViewDelegate <NSObject>

- (void)gotoShopCartWithPickupStoreInfo:(NearbySpotStoreDTO *)dto;

@end

@interface NearbySpotStoreListView : CommonView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray       *storeList;

@property (nonatomic, weak) id<NearbySpotStoreListViewDelegate> delegate;

- (id)initWithOwner:(id)owner;

@end
