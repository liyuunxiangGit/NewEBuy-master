//
//  BoundPhoneViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserCenter.h"
#import "BoundPhoneService.h"
#import "CheckCodeService.h"
#import "keyboardNumberPadReturnTextField.h"


@interface BoundPhoneViewController : CommonViewController<UITextFieldDelegate,BoundPhoneServiceDelegate,CheckCodeServiceDelegate,KeyboardDoneTappedDelegate>
@property (nonatomic, assign) BOOL  isEfubaoBound;
@property (nonatomic, assign) BOOL  isFromPayPage;
@property (nonatomic,strong) UIButton *getCodeBtn;

@end
