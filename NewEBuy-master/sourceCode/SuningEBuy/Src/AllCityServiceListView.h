//
//  AllCityServiceListView.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"
#import "DWTagList.h"
#import "StoreServiceDTO.h"
#import "ToolBarButton.h"
#import "AddressInfoPickerView.h"

@protocol AllCityServiceListViewDelegate <NSObject>

- (void)gotoStoreService:(StoreServiceDTO *)dto;
- (void)showCityList;

@end

@interface AllCityServiceListView : CommonView<UITableViewDelegate, UITableViewDataSource, DWTagListDelegate,AddressInfoPickerViewDelegate,ToolBarButtonDelegate>

@property (nonatomic, strong) NSMutableArray            *topServiceList;
@property (nonatomic, strong) NSMutableArray            *otherServiceList;
@property (nonatomic, strong) DWTagList                 *tagList;
@property (nonatomic, weak) id<AllCityServiceListViewDelegate> delegate;
@property (nonatomic, strong) UIView                    *noDataView;
@property (nonatomic, strong) ToolBarButton             *selectCityButton;
@property (nonatomic, strong) AddressInfoPickerView     *cityPickerView;

- (id)initWithOwner:(id)owner;

@end
