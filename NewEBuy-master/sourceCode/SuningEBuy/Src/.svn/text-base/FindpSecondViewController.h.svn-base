//
//  FindpSecondViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculagraph.h"
#import "FindPasswordDTO.h"
#import "FindPasswordService.h"
#import "SNUITableViewCell.h"

@interface FindpSecondViewController : CommonViewController<UITextFieldDelegate,FindPasswordServiceDelegate>

@property (nonatomic, strong) UILabel           *phoneNumLabel;
@property (nonatomic, strong) UIButton          *codeBtn;
@property (nonatomic, strong) UITextField       *codeTextField;
@property (nonatomic, strong) Calculagraph      *codeTimer;

@property (nonatomic, strong) NSString          *mobileNumString;
@property (nonatomic, strong) FindPasswordDTO   *findPasswordDto;
@property (nonatomic, strong) FindPasswordService *findPasswordService;

@end
