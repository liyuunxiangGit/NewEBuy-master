//
//  AccountValidateViewController.h
//  SuningEBuy
//
//  Created by wangrui on 2/11/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonViewController.h"
#import "UserRetrieveService.h"

@interface AccountValidateViewController : CommonViewController <UITextFieldDelegate, UserRetrieveServiceDelegate>
{
    BOOL    isPopup;
}

@property (nonatomic, assign) RetrieveMode          mode;

@property (nonatomic, strong) UILabel               *mobileOrEmailLbl;

@property (nonatomic, strong) UITextField           *mobileOrEmailFld;

@property (nonatomic, strong) UserRetrieveService   *service;

- (BOOL)validateUsername:(NSString *)userName;

- (void)sendValidateUserHttpRequest;

@end
