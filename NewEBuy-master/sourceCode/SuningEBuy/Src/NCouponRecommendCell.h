//
//  NCouponRecommendCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTextField.h"

@interface NCouponRecommendCell : SNUITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *scanButton;

+ (CGFloat)height;

@end
