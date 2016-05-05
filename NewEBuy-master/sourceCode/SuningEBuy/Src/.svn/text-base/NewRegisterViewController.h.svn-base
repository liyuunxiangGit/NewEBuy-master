//
//  NewRegisterViewController.h
//  SuningEBuy
//
//  Created by jian zhang on 13-5-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "UserNewRegisterService.h"
#import "keyboardNumberPadReturnTextField.h"

#import "UserRegisterDTO.h"
#import "PasswordToggleView.h"
#import "SNUITableViewCell.h"

#import "Calculagraph.h"
#import "JSTwitterCoreTextView.h"
#import "SNProtocolView.h"


@interface NewRegisterViewController : CommonViewController
<UserNewRegisterServiceDelegate, UITextFieldDelegate,JSCoreTextViewDelegate>
{
    BOOL isClick;
}

@property (nonatomic, strong) UserNewRegisterService *service;
@property (nonatomic, strong) keyboardNumberPadReturnTextField         *usernameTextField;


@property (nonatomic, strong) UITextField           *codeTextField;
@property (nonatomic, strong) UILabel               *tipsLabel;
@property (nonatomic, strong) UIButton              *getCodeBtn;
@property (nonatomic, strong) UIView                *footView;
@property (nonatomic, strong) UIButton              *checkBtn;
@property (nonatomic, strong) Calculagraph          *codeTimer;
@property (nonatomic, strong) JSTwitterCoreTextView *contentLab;
@property (nonatomic, strong) SNProtocolView        *protocolView;

@property (nonatomic, weak) id                  registerDelegate;
@property (nonatomic, strong) UserRegisterDTO     *registerDto;


@property (nonatomic, strong) UITextField         *passwordTextField;
@property (nonatomic, strong) PasswordToggleView *passwdToggleView;

// backTypeId = 1 直接返回到首页
@property (nonatomic,assign) NSUInteger         backTypeId;

// 从扫码注册过来 用于埋点统计
@property (nonatomic,assign) BOOL isFromSacnerRegister;

@end
