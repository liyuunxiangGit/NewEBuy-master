//
//  RegisterViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "UserRegisterService.h"
#import "keyboardNumberPadReturnTextField.h"

@interface RegisterViewController : CommonViewController
<UserRegisterServiceDelegate, UITextFieldDelegate>


@property (nonatomic, strong) UserRegisterService *service;
@property (nonatomic, strong) keyboardNumberPadReturnTextField         *usernameTextField;
@property (nonatomic, strong) UITextField         *passwordTextField;
@property (nonatomic, strong) UITextField         *rePasswordTextField;
@property (nonatomic, weak) id                  registerDelegate;
@property (nonatomic, assign) SEL                 registerOkSelector;

@end
