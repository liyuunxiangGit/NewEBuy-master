//
//  YigouAccountViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemeberMergeService.h"
#import "PasswordToggleView.h"
#import "OHAttributedLabel.h"

@interface YigouAccountViewController : CommonViewController <UITextFieldDelegate,MemeberMergeServiceDelegate>
{
    
}
@property (nonatomic, strong) UIView                *nameView;
@property (nonatomic, strong) UILabel               *nameLable;
@property (nonatomic, strong) UIView                *registerView;
@property (nonatomic, strong) UITextField           *yiGouAcountTextField;
@property (nonatomic, strong) UITextField           *passwordTextField;


@property (nonatomic, strong) MemeberMergeService   *memberMergeService;
@property (nonatomic, strong) NSString              *suningAccount;

@property (nonatomic, strong) NSString              *cardNum;
@property (nonatomic, strong) NSString              *cardPass;

@property (nonatomic, strong) PasswordToggleView *passwdToggleView;


@end
