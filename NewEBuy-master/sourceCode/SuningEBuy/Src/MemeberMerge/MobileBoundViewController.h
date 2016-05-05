//
//  MobileBoundViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "AccountCertainViewController.h"
#import "Calculagraph.h"
#import "MemeberMergeService.h"
#import "EppValidateCodeService.h"
#import "AccountCheckCodeService.h"
#import "CheckCodeService.h"
#import "BoundPhoneService.h"
#import "Calculagraph.h"

@interface MobileBoundViewController : CommonViewController <UITextFieldDelegate,MemeberMergeServiceDelegate,AccountCheckCodeServiceDelegate,CheckCodeServiceDelegate,BoundPhoneServiceDelegate>

@property (nonatomic, strong) UITextField           *verificationTextField;
@property (nonatomic, strong) UIButton              *firstCellButton;
@property (nonatomic, strong) UITextField           *phoneTextField;

@property (nonatomic, strong) NSString              *bindMobileNum;

@property (nonatomic, strong) MemeberMergeService          *memberMergeService;
@property (nonatomic, strong) AccountCheckCodeService      *checkCodeService;

@property (nonatomic, strong) BoundPhoneService          *boundService;
@property (nonatomic, strong) CheckCodeService           *boundCodeService;

@property (nonatomic, assign) BOOL                       isEmailBind;//登录情况下绑定   区分邮箱与手机绑定
@property (nonatomic, assign) BOOL                       isBindPhone;//邮箱账号有绑定手机  需要去手机号码选择页面

@property (nonatomic, strong) Calculagraph               *calculagraph;

@end
