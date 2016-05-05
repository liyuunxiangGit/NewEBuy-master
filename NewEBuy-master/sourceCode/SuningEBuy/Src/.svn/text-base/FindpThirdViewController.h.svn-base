//
//  FindpThirdViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindPasswordDTO.h"
#import "FindPasswordService.h"
#import "PasswordToggleView.h"
#import "SNUITableViewCell.h"

@interface FindpThirdViewController : CommonViewController<FindPasswordServiceDelegate,UITextFieldDelegate>

@property (nonatomic, strong) FindPasswordDTO           *findPasswordDto;
@property (nonatomic, strong) FindPasswordService       *findPasswrodService;

@property (nonatomic, strong) NSString                  *mobileNumString;
@property (nonatomic, strong) UITextField               *passwordTextField;
@property (nonatomic, strong) UITextField               *rePasswordTextField;
@property (nonatomic, strong) PasswordToggleView        *passwdToggleView;
@end
