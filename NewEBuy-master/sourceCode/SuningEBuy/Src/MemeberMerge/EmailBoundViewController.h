//
//  EmailBoundViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "AccountCertainViewController.h"
#import "Calculagraph.h"
#import "MemeberMergeService.h"
#import "EppValidateCodeService.h"
#import "AccountCheckCodeService.h"
#import "Calculagraph.h"

@interface EmailBoundViewController : CommonViewController <UITextFieldDelegate,MemeberMergeServiceDelegate,AccountCheckCodeServiceDelegate>

@property (nonatomic, strong) UITextField           *verificationTextField;
@property (nonatomic, strong) UIButton              *firstCellButton;
@property (nonatomic, strong) UITextField           *emailTextField;

@property (nonatomic, strong) NSString              *suningAccount;
@property (nonatomic, strong) NSString              *cardNum;
@property (nonatomic, strong) NSString              *emailAccount;

@property (nonatomic, strong) MemeberMergeService   *memberMergeService;
@property (nonatomic, strong) AccountCheckCodeService      *checkCodeService;

@property (nonatomic, strong) Calculagraph          *calculagraph;


@end
