//
//  AddressInfoListViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  Modifyed by liukun

#import "CommonViewController.h"
#import "UserAddressService.h"
#import "AddressChangeDelegate.h"
#import "AddressNewViewController.h"
#import "AddressEditViewController.h"
#import "AddressItemCell.h"

#import "PayFlowService.h"
@class ReceiveInfoViewController;

@interface AddressInfoListViewController : CommonViewController<UserAddressServiceDelegate, AddressChangeDelegate,UIGestureRecognizerDelegate,AddressItemCellDelegate,PayFlowServiceDelegate>
{
    UserAddressService  *_service;
    NSMutableArray      *_addressList;
    
    BOOL                isAddressListLoaded;
    
    int                 currentRow;
    int                 willDeleteRow;
}
@property (nonatomic, strong) UISwipeGestureRecognizer  *swipeRight;
@property (nonatomic, weak) ReceiveInfoViewController *obj;
@property (nonatomic, strong) PayFlowService *payFlowService;
@property (nonatomic, strong) UserAddressService *service;
@property (nonatomic, weak) id<AddressChangeDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *addressList;
@property (nonatomic, strong) AddressInfoDTO *selectAddressDTO;
@property (nonatomic,strong) AddressInfoDTO *deleteAddressDTO;
@property (nonatomic, assign) BOOL           isFromAddressInfo;

@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic, assign) BOOL  isFromEasilyBuy;

@property (nonatomic)AddressCellType cellType;

@property (nonatomic)BOOL isEditing;       //此状态 从购物车进才有

- (id)initWith:(ReceiveInfoViewController *)object;
@end
