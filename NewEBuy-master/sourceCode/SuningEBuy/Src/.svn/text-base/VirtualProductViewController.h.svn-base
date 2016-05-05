//
//  VirtualProductViewController.h
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VirtualProductSegementView.h"

//手机充值
#import "MobileRechargeNewService.h"
#import "KBNumberPadReturnWithCustomRect.h"
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "SNDropDownMenuViewController.h"

//水电煤缴费
#import "PayServiceDTO.h"
#import "ToolBarTextField.h"
#import "keyboardNumberPadReturnTextField.h"
#import "SNReaderViewController.h"
#import "WaterElectricityGasService.h"
#import "WaterElectricityGasSegementView.h"

typedef enum{
    payWater = 0,
	payElectricity =1,
	payGas = 2
} PayServiceType;

@interface VirtualProductViewController : CommonViewController <VirtualProductSegementViewDelegate,KeyboardDoneTappedDelegate,UITextFieldDelegate,MobileRechargeNewServiceDelegate,ABPeoplePickerNavigationControllerDelegate,SNDropDownMenuDelegate,UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, ToolBarTextFieldDelegate, SNReaderDelegate, WaterElectricityGasServiceDelegate,WaterElectricityGasSegementViewDelegate>
{
    //w前缀代表水；e前缀代表电；g前缀代表煤
    
    PayServiceType                       _wPayType;
    PayServiceType                       _ePayType;
    PayServiceType                       _gPayType;
    
    ToolBarTextField                     *_wPayRegionTextField;
    ToolBarTextField                     *_ePayRegionTextField;
    ToolBarTextField                     *_gPayRegionTextField;
    
    ToolBarTextField                     *_wPayCompanyTextField;
    ToolBarTextField                     *_ePayCompanyTextField;
    ToolBarTextField                     *_gPayCompanyTextField;
    
    keyboardNumberPadReturnTextField     *_wPayAccountTextField;
    keyboardNumberPadReturnTextField     *_ePayAccountTextField;
    keyboardNumberPadReturnTextField     *_gPayAccountTextField;
    
    UIPickerView                         *_wRegionPickerView;
    UIPickerView                         *_eRegionPickerView;
    UIPickerView                         *_gRegionPickerView;
    
    UIPickerView                         *_wCompanyPickerView;
    UIPickerView                         *_eCompanyPickerView;
    UIPickerView                         *_gCompanyPickerView;
    
    WaterElectricityGasService           *_waterElecGasService;

    NSMutableArray                       *_wRegionList;
    NSMutableArray                       *_eRegionList;
    NSMutableArray                       *_gRegionList;
    
    NSMutableArray                       *_wCompanyList;
    NSMutableArray                       *_eCompanyList;
    NSMutableArray                       *_gCompanyList;
    
    PayServiceDTO                        *_wPayServiceDTO;
    PayServiceDTO                        *_ePayServiceDTO;
    PayServiceDTO                        *_gPayServiceDTO;
    
    BOOL                                 wIsManual;
    BOOL                                 eIsManual;
    BOOL                                 gIsManual;
    
    UILabel                              *_wCustomerNameLabel;
    UILabel                              *_eCustomerNameLabel;
    UILabel                              *_gCustomerNameLabel;
    
    UILabel                              *_wPayBalanceLabel;
    UILabel                              *_ePayBalanceLabel;
    UILabel                              *_gPayBalanceLabel;
    
    NSString                             *_wPayAccountNum;//记录已经请求过的付款账户，
    NSString                             *_ePayAccountNum;//记录已经请求过的付款账户，
    NSString                             *_gPayAccountNum;//记录已经请求过的付款账户，
    
    BOOL                                 wIsFirst;//记录用户是否是首次查询，非首次查询打开页面时回一次执行几个接口
    BOOL                                 eIsFirst;//记录用户是否是首次查询，非首次查询打开页面时回一次执行几个接口
    BOOL                                 gIsFirst;//记录用户是否是首次查询，非首次查询打开页面时回一次执行几个接口
    
    BOOL                                 wIsGetAccountInfo;//记录是否获得过最终的账户信息，避免从下级页面返回时重复调用几个接口
    BOOL                                 eIsGetAccountInfo;//记录是否获得过最终的账户信息，避免从下级页面返回时重复调用几个接口
    BOOL                                 gIsGetAccountInfo;//记录是否获得过最终的账户信息，避免从下级页面返回时重复调用几个接口
    
    BOOL                                 wIsLoading;
    BOOL                                 eIsLoading;
    BOOL                                 gIsLoading;
}

@property (nonatomic, assign) PayServiceType  wPayType;
@property (nonatomic, assign) PayServiceType  ePayType;
@property (nonatomic, assign) PayServiceType  gPayType;

@property (nonatomic, strong) ToolBarTextField  *wPayRegionTextField;
@property (nonatomic, strong) ToolBarTextField  *ePayRegionTextField;
@property (nonatomic, strong) ToolBarTextField  *gPayRegionTextField;

@property (nonatomic, strong) ToolBarTextField  *wPayCompanyTextField;
@property (nonatomic, strong) ToolBarTextField  *ePayCompanyTextField;
@property (nonatomic, strong) ToolBarTextField  *gPayCompanyTextField;

@property (nonatomic, strong) keyboardNumberPadReturnTextField  *wPayAccountTextField;
@property (nonatomic, strong) keyboardNumberPadReturnTextField  *ePayAccountTextField;
@property (nonatomic, strong) keyboardNumberPadReturnTextField  *gPayAccountTextField;

@property (nonatomic, strong) UIPickerView  *wRegionPickerView;
@property (nonatomic, strong) UIPickerView  *eRegionPickerView;
@property (nonatomic, strong) UIPickerView  *gRegionPickerView;

@property (nonatomic, strong) UIPickerView  *wCompanyPickerView;
@property (nonatomic, strong) UIPickerView  *eCompanyPickerView;
@property (nonatomic, strong) UIPickerView  *gCompanyPickerView;

@property (nonatomic, strong) WaterElectricityGasService *waterElecGasService;

@property (nonatomic, strong) NSMutableArray  *wRegionList;
@property (nonatomic, strong) NSMutableArray  *eRegionList;
@property (nonatomic, strong) NSMutableArray  *gRegionList;

@property (nonatomic, strong) NSMutableArray  *wCompanyList;
@property (nonatomic, strong) NSMutableArray  *eCompanyList;
@property (nonatomic, strong) NSMutableArray  *gCompanyList;

@property (nonatomic, strong) PayServiceDTO  *wPayServiceDTO;
@property (nonatomic, strong) PayServiceDTO  *ePayServiceDTO;
@property (nonatomic, strong) PayServiceDTO  *gPayServiceDTO;

@property (nonatomic, strong) NSMutableArray  *wPayServiceList;
@property (nonatomic, strong) NSMutableArray  *ePayServiceList;
@property (nonatomic, strong) NSMutableArray  *gPayServiceList;

@property (nonatomic, strong) NSArray  *wPayServiceInfoList;
@property (nonatomic, strong) NSArray  *ePayServiceInfoList;
@property (nonatomic, strong) NSArray  *gPayServiceInfoList;

@property (nonatomic, strong) UILabel  *wCustomerNameLabel;
@property (nonatomic, strong) UILabel  *eCustomerNameLabel;
@property (nonatomic, strong) UILabel  *gCustomerNameLabel;

@property (nonatomic, strong) UILabel  *wPayBalanceLabel;
@property (nonatomic, strong) UILabel  *ePayBalanceLabel;
@property (nonatomic, strong) UILabel  *gPayBalanceLabel;

@property (nonatomic, strong) NSString *wPayAccountNum;
@property (nonatomic, strong) NSString *ePayAccountNum;
@property (nonatomic, strong) NSString *gPayAccountNum;

@property (nonatomic, strong) UITableView       *wGroupTableView;
@property (nonatomic, strong) UITableView       *eGroupTableView;
@property (nonatomic, strong) UITableView       *gGroupTableView;

@end
