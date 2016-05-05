//
//  CommonTextField.m
//  SNFramework
//
//  Created by  liukun on 13-12-27.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import "SNUITextField.h"

@implementation SNUITextField

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeDefault;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    if (bounds.size.width > self.leftPadding) {
        return CGRectInset(bounds, 5, 0);
    }else{
        return bounds;
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    if (bounds.size.width > self.leftPadding) {
        return  CGRectInset(bounds, 5, 0);
    }else{
        return bounds;
    }
}

//工厂方法

+ (instancetype)roundRectTextField
{
    SNUITextField *textField = [[SNUITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    return textField;
}

+ (instancetype)borderTextField
{
    SNUITextField *textField = [[SNUITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderColor = RGBCOLOR(227,224,216).CGColor;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 5.0f;
    return textField;
}

@end
