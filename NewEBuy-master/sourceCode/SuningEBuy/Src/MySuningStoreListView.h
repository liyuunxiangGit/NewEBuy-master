//
//  MySuningStoreListView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "AllCityStoreListCell.h"
#import "ToolBarButton.h"
#import "AddressInfoPickerView.h"

@protocol MySuningStoreListViewDelegate <NSObject>

- (void)gotoDetailSuningStore:(SuningStoreDTO *)dto;
- (void)showCityList;

@end

@interface MySuningStoreListView : CommonView<UITableViewDataSource, UITableViewDelegate,AddressInfoPickerViewDelegate,ToolBarButtonDelegate>

@property (nonatomic, strong) NSArray                   *favouriteStoreList;
@property (nonatomic, strong) NSArray                   *goodStoreList;
@property (nonatomic, strong) NSArray                   *allStoreList;
@property (nonatomic, weak) id<MySuningStoreListViewDelegate> delegate;
@property (nonatomic, strong) UIView                    *noDataView;
@property (nonatomic, strong) ToolBarButton             *selectCityButton;
@property (nonatomic, strong) AddressInfoPickerView     *cityPickerView;

- (id)initWithOwner:(id)owner;

@end
