//
//  ReceiveInfoShopRemarkCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveInfoShopRemarkCell.h"
#import "RegexKitLite.h"

@implementation ReceiveInfoShopRemarkCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (UITextField *)remarkTextFld
{
    if (!_remarkTextFld) {
        _remarkTextFld = [[UITextField alloc] initWithFrame:CGRectMake(15, 7, 290, 30)];
        _remarkTextFld.placeholder = L(@"PFOptionalGiveMerchantsMessage");
        _remarkTextFld.frame = CGRectMake(15, 7, 290, 30);
        _remarkTextFld.delegate = self;
        //        _remarkTextFld.tag = [detailDto.supplierCode intValue];
        _remarkTextFld.keyboardType = UIKeyboardTypeDefault;
        _remarkTextFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _remarkTextFld.textAlignment = UITextAlignmentLeft;
        _remarkTextFld.autocorrectionType = UITextAutocorrectionTypeNo;
        _remarkTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        _remarkTextFld.font =[UIFont boldSystemFontOfSize:14.0f];
//        _remarkTextFld.layer.borderColor = [UIColor light_Gray_Color].CGColor;
//        _remarkTextFld.layer.borderWidth = 0.5f;
        _remarkTextFld.layer.cornerRadius = 0.9;
        [self.contentView addSubview:_remarkTextFld];
    }
    return _remarkTextFld;
}

- (void)setRemarkTextWithShopCode:(NSString *)supplierCode
{
    self.supplierCodeStr = supplierCode;
    self.remarkTextFld.frame = CGRectMake(15, 7, 290, 30);
    self.remarkTextFld.tag = [supplierCode intValue];
}

#pragma mark -
#pragma mark Text View Delegate Method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUInteger length1 = textField.text.length;
//    NSUInteger length2 = string.length;
    NSLog(@"+++++++++%@",string);
    if (textField.text.length > 85)
    {
        NSString *remarkStr = textField.text;
        remarkStr = [remarkStr substringToIndex:85];
        textField.text = remarkStr;
        if ([_delegate respondsToSelector:@selector(showLimitAlertView)]) {
            [_delegate showLimitAlertView];
        }
        return YES;
    }
    //限制非数字的字符
//    NSString *regex = @"[`~\\-_!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（） ——+|{}【】‘；：”“’。，、？]";
    NSString *regex = @"[<>＜＞]";
    if (string.length > 0 && [string rangeOfRegex:regex].location != NSNotFound)//![string isMatchedByRegex:@"^[0-9]*$"]
    {
        return NO;
    }
    
    if ([string isEqualToString:@"<"]||[string isEqualToString:@">"]||[string isEqualToString:@"＜"]||[string isEqualToString:@"＞"]||[string isEqualToString:@"《"]||[string isEqualToString:@"》"]) {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"<" withString:@""];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@">" withString:@""];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"＜" withString:@""];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"＞" withString:@""];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"《" withString:@""];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"》" withString:@""];
    
    if (textField.text.length > 85)
    {
        NSString *remarkStr = textField.text;
        remarkStr = [remarkStr substringToIndex:85];
        textField.text = remarkStr;
        [self.remarkTextFld becomeFirstResponder];
        if ([_delegate respondsToSelector:@selector(showLimitAlertView)]) {
            [_delegate showLimitAlertView];
        }
        return ;
    }
    
    if ([_delegate respondsToSelector:@selector(getRemarkWithText:supplierCode:)]) {
        [_delegate getRemarkWithText:textField.text supplierCode:self.supplierCodeStr];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.remarkTextFld resignFirstResponder];
    
    return YES;
    
}

@end
