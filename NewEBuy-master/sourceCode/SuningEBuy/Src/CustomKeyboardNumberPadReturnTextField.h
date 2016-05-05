//
//  CustomKeyboardNumberPadReturnTextField.h
//  SuningEBuy
//
//  Created by chupeng on 14-5-30.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "keyboardNumberPadReturnTextField.h"

@interface CustomKeyboardNumberPadReturnTextField : keyboardNumberPadReturnTextField
- (void)initData;

@property (nonatomic, assign) CGRect  borderRect;

@property (nonatomic, assign) CGRect  textRect;

@property (nonatomic, assign) CGRect  placeholderRect;

@property (nonatomic, assign) CGRect  editingRect;

@property (nonatomic, assign) CGRect  clearButtonRect;

@property (nonatomic, assign) CGRect  leftViewRect;

@property (nonatomic, assign) CGRect  rightViewRect;



@end
