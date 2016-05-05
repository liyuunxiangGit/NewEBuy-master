//
//  AddressNewViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  Modifyed by liukun

#import "CommonViewController.h"
#import "AddressInfoPickerView.h"
#import "AddressChangeDelegate.h"
#import "UserAddressService.h"
#import "ToolBarTextField.h"

#import <AddressBook/AddressBook.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#define kLeftMargin         98.0
#define kTopMargin          8.0
#define kTextFieldWidth     188.0
#define kTextFieldHeight    30.0
#define kTextFieldFontSize  15.0

@interface AddressNewViewController : CommonViewController<UserAddressServiceDelegate, AddressInfoPickerViewDelegate, UITextFieldDelegate, ToolBarTextFieldDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    UserAddressService      *_service;
    
    @public
    id<AddressChangeDelegate> __weak _delegate;
    AddressInfoDTO            *_addressInfoDTO;
}

@property (nonatomic, readonly, strong) UserAddressService          *service;

@property (nonatomic, strong) AddressInfoDTO                        *addressInfoDTO;

@property (nonatomic, readonly, strong) AddressInfoPickerView       *addrPickerView;

@property (nonatomic, weak) id<AddressChangeDelegate>             delegate;

@property (nonatomic, assign) BOOL isFromEasilyBuy;

@property (nonatomic, readonly, strong) ToolBarTextField            *defaultAddressTextField;
@property (nonatomic, readonly, strong) UITextField                 *personTextField;
@property (nonatomic, readonly, strong) UITextField                 *phoneTextField;
@property (nonatomic, readonly, strong) UITextField                 *addressTextField;

@property (nonatomic, strong) UIButton  *checkBtn;
@property (nonatomic, strong) UILabel   *checkLbl;
@property (nonatomic, strong) UIView    *footerView;
@property (nonatomic, assign) BOOL      isCheckPrefer;

@property (nonatomic, strong) UIButton  *tongxunBtn;

//隐藏所有view的键盘
- (void)hideKeyboard;

//校验手机号
- (BOOL)validateMobileNo: (NSString *) mobileNo; 

//校验中文姓名
- (BOOL)validateChineseName: (NSString *) shouhuoren;


- (BOOL)validateAddressDetail:(NSString *)addressDetail error:(NSString **)error;

@end
