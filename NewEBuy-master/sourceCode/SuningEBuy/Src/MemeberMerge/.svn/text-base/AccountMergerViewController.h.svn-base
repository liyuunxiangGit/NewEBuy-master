//
//  AccountMergerViewController.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-10-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "AccountCertainViewController.h"
#import "Calculagraph.h"
#import "MemeberMergeService.h"
#import "EppValidateCodeService.h"
#import "Calculagraph.h"
#import "AccountCheckCodeService.h"

@interface AccountMergerViewController : CommonViewController <UITextFieldDelegate,MemeberMergeServiceDelegate,AccountCheckCodeServiceDelegate>

@property (nonatomic, strong) UITextField           *verificationTextField;
@property (nonatomic, strong) UIButton              *firstCellButton;
@property (nonatomic, strong) UITextField           *phoneTextField;
@property (nonatomic, strong) UIView                *infoLable;

@property (nonatomic, strong) MemeberMergeService   *memberMergeService;
@property (nonatomic, strong) AccountCheckCodeService      *checkCodeService;
@property (nonatomic, strong) Calculagraph                  *calculagraph;

@end
