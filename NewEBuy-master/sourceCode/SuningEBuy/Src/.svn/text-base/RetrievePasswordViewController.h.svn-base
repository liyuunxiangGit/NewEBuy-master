//
//  RetrievePasswordViewController.h
//  SuningEBuy
//
//  Created by wangrui on 2/11/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "AccountValidateViewController.h"
#import "UserRetrieveService.h"

@interface RetrievePasswordViewController : CommonViewController <UITextFieldDelegate, UserRetrieveServiceDelegate>

@property (nonatomic, assign) RetrieveMode                  mode;

@property (nonatomic, copy)   NSString                      *userName;

@property (nonatomic, strong)  UILabel                      *usernameLabel;
@property (nonatomic, strong)  UILabel                      *passwordLabel;
@property (nonatomic, strong)  UILabel                      *rePasswordLabel;
@property (nonatomic, strong)  UILabel                      *authCodeLabel;

@property (nonatomic, strong)  UITextField                  *usernameTextField;
@property (nonatomic, strong)  UITextField                  *passwordTextField;
@property (nonatomic, strong)  UITextField                  *rePasswordTextField;
@property (nonatomic, strong)  UITextField                  *authCodeTextField;

@property (nonatomic, strong)  UserRetrieveService          *service;


- (BOOL)validatePassword:(NSString *)pwd;

- (void)sendResetPasswordHttpRequest;

@end
