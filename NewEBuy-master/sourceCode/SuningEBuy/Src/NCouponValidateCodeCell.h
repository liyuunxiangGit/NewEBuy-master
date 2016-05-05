//
//  NCouponValidateCodeCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTextField.h"

@interface NCouponValidateCodeCell : SNUITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UILabel           *bindPhoneLabel;
@property (nonatomic, strong) CommonTextField   *codeTextField;
@property (nonatomic, strong) UIButton          *getCodeButton;

@property (nonatomic, strong) NSString          *phoneNum;

+ (CGFloat)height:(NSString *)phoneNum;

@end
