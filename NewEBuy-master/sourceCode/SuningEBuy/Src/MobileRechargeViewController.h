//
//  MobileRechargeViewController.h
//  SuningEBuy
//
//  Create by shasha on 12-9-25
//  Copyright (c) 2012年 Suning. All rights reserved.


#import <UIKit/UIKit.h>
#import "MobileRechargeNewService.h"
#import "KBNumberPadReturnWithCustomRect.h"
#import <AddressBook/AddressBook.h> 
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "SNDropDownMenuViewController.h"

@interface MobileRechargeViewController : CommonViewController<KeyboardDoneTappedDelegate,UITextFieldDelegate,MobileRechargeNewServiceDelegate,ABPeoplePickerNavigationControllerDelegate,SNDropDownMenuDelegate>

@end
