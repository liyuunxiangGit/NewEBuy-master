//
//  MobilePaymentView.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileRechargeNewService.h"
#import "KBNumberPadReturnWithCustomRect.h"
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "SNDropDownMenuViewController.h"
#import "MobilePayViewController.h"
#import "OHAttributedLabel.h"

@interface MobilePaymentView : UIView<KeyboardDoneTappedDelegate,UITextFieldDelegate,MobileRechargeNewServiceDelegate,ABPeoplePickerNavigationControllerDelegate,SNDropDownMenuDelegate,BBAlertViewDelegate>
{    
    BOOL  isPayAgain;
    
    BOOL  isFisrt;
    
    BOOL  isChangePhoneNum;                       //判断从何处进入layoutSubviews

    CommonViewController * __weak _contentController;
    
    
}
@property (nonatomic, weak) CommonViewController *contentController;
@property (nonatomic, strong) KBNumberPadReturnWithCustomRect	  *mobileNumberTextField;
@property (nonatomic, assign) BOOL  isActivity;

- (id)initWithContentController:(CommonViewController *)controller;

- (void)gotoPayHistory:(id)sender;

@end
