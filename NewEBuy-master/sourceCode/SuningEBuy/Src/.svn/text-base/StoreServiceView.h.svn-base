//
//  StoreServiceView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "SuningStoreDTO.h"
#import "StoreServiceDTO.h"

@protocol StoreServiceViewDelegate <NSObject>

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto;

@end

@interface StoreServiceView : CommonView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) StoreServiceDTO *serviceDto;

@property (nonatomic, strong) NSArray         *storeList;

@property (nonatomic, weak) id<StoreServiceViewDelegate> delegate;

- (id)initWithOwner:(id)owner;

@end
