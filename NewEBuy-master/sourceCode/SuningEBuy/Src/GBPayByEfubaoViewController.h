//
//  GBPayByEfubaoViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "keyboardNumberPadReturnTextField.h"
#import "GBPayService.h"
#import "GBSubmitDTO.h"
#import "EfubaoAccountService.h"

@interface GBPayByEfubaoViewController : CommonViewController<UITextFieldDelegate,GBPayServiceDelegate,EfubaoAccountServiceDelegate>

@property (nonatomic, strong) GBPayService                                  *gbPayService;
@property (nonatomic, strong) GBSubmitDTO                                   *submitDto;
@property (nonatomic, strong) EfubaoAccountService                          *efubaoAccountService;

@end
