//
//  SearchTextField.h
//  SuningEBuy
//
//  Created by chupeng on 13-12-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTextField : UITextField
- (void)initData;

@property (nonatomic, assign) CGRect  borderRect;

@property (nonatomic, assign) CGRect  textRect;

@property (nonatomic, assign) CGRect  placeholderRect;

@property (nonatomic, assign) CGRect  editingRect;

@property (nonatomic, assign) CGRect  clearButtonRect;

@property (nonatomic, assign) CGRect  leftViewRect;

@property (nonatomic, assign) CGRect  rightViewRect;



@end
