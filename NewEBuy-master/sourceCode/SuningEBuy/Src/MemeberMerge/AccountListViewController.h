//
//  AccountListViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountListCell.h"
#import "MemeberMergeService.h"
#import "PasswordToggleView.h"

@interface AccountListViewController : CommonViewController<UITextFieldDelegate,MemeberMergeServiceDelegate>

@property (nonatomic, strong) NSMutableArray                *accoutList;
@property (nonatomic, strong) UILabel                       *cardPassLabel;
@property (nonatomic, strong) UITextField                   *cardPassTextField;
@property (nonatomic, strong) PasswordToggleView            *passwordToggleView;
@property (nonatomic, strong) UIImageView                   *markView;

@property (nonatomic, strong) MemeberMergeService           *memberMergeService;

@property (nonatomic, assign) BOOL                          isLogoned;
@property (nonatomic, strong) NSString                      *suningAccount;

@end
