//
//  StoreMentionViewController.h
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "AddressInfoService.h"
#import "StoreInfoService.h"
#import "ToolBarButton.h"
#import "ToolBarCell.h"

@protocol StoreMentionDelegate;


@interface StoreMentionViewController : CommonViewController
<ToolBarButtonDelegate, AddressInfoServiceDelegate, StoreInfoServiceDelegate, 
UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,ToolBarCellDelegate>
{
    BOOL    isDistrictListLoadOk;
}

@property (nonatomic, strong) StoreInfoDto  *storeInfoDto;        // 门店信息
@property (nonatomic, weak) id<StoreMentionDelegate> delegate;  // 门店delegate

//service
@property (nonatomic, strong) AddressInfoService *addressInfoService;
@property (nonatomic, strong) StoreInfoService *storeInfoService;

//数据源
@property (nonatomic, strong) NSArray       *districtArr;         // 地区列表
@property (nonatomic, strong) NSArray       *storeInfoArr;        // 门店列表


- (id)initWithStoreInfo:(StoreInfoDto *)dto;

@end


@protocol StoreMentionDelegate <NSObject>

@optional
// 更新结算页面的提货人信息
- (void)didSelectStoreInfo:(StoreInfoDto *)storeInfo;

@end
