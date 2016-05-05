//
//  NCouponRecommendCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NCouponRecommendCell.h"

@implementation NCouponRecommendCell

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

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.shadowColor = [UIColor whiteColor];
        _titleLabel.shadowOffset = CGSizeMake(0, 0);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(0, 0, 100, 100);
        [_textField setPlaceholder:L(@"PFEnterRecommendationMobilePhoneNumber")];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont systemFontOfSize:14.0];
        _textField.textColor = [UIColor blackColor];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)scanButton
{
    if (!_scanButton) {
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanButton.frame = CGRectMake(0, 0, 40, 40);
        [_scanButton setImage:[UIImage imageNamed:@"QR_code.png"]
                     forState:UIControlStateNormal];
        _scanButton.titleEdgeInsets = UIEdgeInsetsZero;
        _scanButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [self.contentView addSubview:_scanButton];
    }
    return _scanButton;
}

#pragma mark ----------------------------- text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark ----------------------------- layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@:",L(@"PFRecommendationNumber")];
    CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    self.titleLabel.frame = CGRectMake(20, 15, size.width, 20);
    self.textField.frame = CGRectMake(self.titleLabel.right+5, 10, 170, 30);
    self.accessoryView = self.scanButton;
}

+ (CGFloat)height
{
    return 50;
}

@end
