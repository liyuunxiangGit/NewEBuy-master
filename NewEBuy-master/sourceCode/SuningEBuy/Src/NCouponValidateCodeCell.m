//
//  NCouponValidateCodeCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NCouponValidateCodeCell.h"
#import "FormattersValidators.h"

@implementation NCouponValidateCodeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ----------------------------- subviews

- (UILabel *)bindPhoneLabel
{
    if (!_bindPhoneLabel)
    {
		_bindPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_bindPhoneLabel.backgroundColor = [UIColor clearColor];
        _bindPhoneLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _bindPhoneLabel.textColor = [UIColor light_Black_Color];
        _bindPhoneLabel.textAlignment = NSTextAlignmentLeft;
        _bindPhoneLabel.shadowColor = [UIColor whiteColor];
        _bindPhoneLabel.shadowOffset = CGSizeMake(0, 0);
        [self.contentView addSubview:_bindPhoneLabel];
    }
    return _bindPhoneLabel;
}

- (CommonTextField *)codeTextField
{
    if (!_codeTextField) {
        _codeTextField = [[CommonTextField alloc] init];
        _codeTextField.leftPadding = 7;
        _codeTextField.frame = CGRectMake(0, 0, 180, 30);
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.font = [UIFont systemFontOfSize:14.0];
        _codeTextField.textColor = [UIColor blackColor];
        _codeTextField.placeholder = L(@"PFEnterMobilePhoneCode");
        _codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.delegate = self;
        _codeTextField.keyboardType = UIKeyboardTypeDefault;
        _codeTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _codeTextField.layer.borderColor = [UIColor colorWithRGBHex:0xcacaca].CGColor;
        _codeTextField.layer.borderWidth = 0.5;
        _codeTextField.layer.cornerRadius = 1.0f;
        [self.contentView addSubview:_codeTextField];
    }
    return _codeTextField;
}

- (UIButton *)getCodeButton
{
    if (!_getCodeButton) {
        _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeButton.frame = CGRectMake(0, 0, 0, 0);
        _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _getCodeButton.backgroundColor = [UIColor clearColor];
        [_getCodeButton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        [_getCodeButton setTitle:L(@"BTObtain") forState:UIControlStateNormal];
        [_getCodeButton setBackgroundImage:[UIImage streImageNamed:@"order_WuLiu.png"]
                                  forState:UIControlStateNormal];
        [_getCodeButton setBackgroundImage:[UIImage streImageNamed:@"order_WuLiuClicked.png"]
                                  forState:UIControlEventTouchUpInside];
        [_getCodeButton setBackgroundImage:[UIImage streImageNamed:@"button_white_normal.png"] forState:UIControlStateDisabled];
        [_getCodeButton setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        _getCodeButton.titleEdgeInsets = UIEdgeInsetsZero;
        _getCodeButton.imageEdgeInsets = UIEdgeInsetsZero;
        [self.contentView addSubview:_getCodeButton];
    }
    return _getCodeButton;
}

#pragma mark ----------------------------- text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----------------------------- layout

- (void)setPhoneNum:(NSString *)phoneNum
{
    if (_phoneNum != phoneNum) {
        _phoneNum = phoneNum;
        
        if ([FormattersValidators isValidPhone:phoneNum])
        {
            phoneNum = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            self.bindPhoneLabel.text = [NSString stringWithFormat:@"%@:%@", L(@"PFBindingMobilePhoneNumber"),phoneNum];
            self.codeTextField.hidden = NO;
            self.getCodeButton.hidden = NO;
            
            self.bindPhoneLabel.frame = CGRectMake(20, 10, 260, 15);
            self.codeTextField.frame = CGRectMake(20, self.bindPhoneLabel.bottom+10, 190, 35);
            self.getCodeButton.frame = CGRectMake(self.codeTextField.right + 15, self.codeTextField.top, 80, 35);
        }
        else
        {
            self.bindPhoneLabel.text = L(@"PFGoToMyEBuyActivate");
            self.codeTextField.hidden = YES;
            self.getCodeButton.hidden = YES;
            
            self.bindPhoneLabel.frame = CGRectMake(20, 12, 260, 20);
            
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

+ (CGFloat)height:(NSString *)phoneNum
{
    if ([FormattersValidators isValidPhone:phoneNum])
    {
        return 80;
    }
    else
    {
        return 44;
    }
}

@end
