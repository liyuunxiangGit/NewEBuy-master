//
//  NearbySuningShopListView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-1.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "AllCityStoreListCell.h"
#import "ToolBarButton.h"
#import "AddressInfoPickerView.h"

@protocol AllCityStoreListViewDelegate <NSObject>

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto;
- (void)showCityList;

@end

@interface AllCityStoreListView : CommonView<UITableViewDataSource,UITableViewDelegate,AddressInfoPickerViewDelegate,ToolBarButtonDelegate>

@property (nonatomic, strong) NSMutableArray            *goodStoreList;
@property (nonatomic, strong) NSMutableArray            *otherStoreList;
@property (nonatomic, weak) id<AllCityStoreListViewDelegate> delegate;
@property (nonatomic, strong) UIView                    *noDataView;
@property (nonatomic, strong) ToolBarButton             *selectCityButton;
@property (nonatomic, strong) AddressInfoPickerView     *cityPickerView;

- (id)initWithOwner:(id)owner;

@end
