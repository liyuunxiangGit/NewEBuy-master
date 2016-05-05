//
//  NextRegisterViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "UserNewRegisterService.h"
#import "UserRegisterDTO.h"
#import "Calculagraph.h"
#import "JSTwitterCoreTextView.h"
#import "SNProtocolView.h"
#import "SNUITableViewCell.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "PasswordToggleView.h"

@interface NextRegisterViewController : CommonViewController<UITextFieldDelegate,UserNewRegisterServiceDelegate,JSCoreTextViewDelegate>
{
    BOOL isClick;
}

@property (nonatomic, strong) UserNewRegisterService       *registerService;
@property (nonatomic, strong) UserRegisterDTO           *registerDto;

@property (nonatomic, strong) UIView                    *footView;
@property (nonatomic, strong) UIButton                  *checkBtn;

@property (nonatomic, strong) JSTwitterCoreTextView *contentLab;
@property (nonatomic, strong) SNProtocolView *protocolView;

@property (nonatomic, strong) UITextField         *passwordTextField;
@property (nonatomic, strong) PasswordToggleView *passwdToggleView;

@end
