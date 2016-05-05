//
//  LinkManInfoCell.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "LinkManInfoCell.h"
//#import "SuningEBuyAppDelegate.h"


#define fontSize   [UIFont boldSystemFontOfSize:15.0]
#define kTextFieldWidth  160

@implementation LinkManInfoCell

@synthesize username = _username;
@synthesize usernameTextField = _usernameTextField;
@synthesize phoneNum = _phoneNum;
@synthesize phoneNumTextField = _phoneNumTextField;
@synthesize delegate = _delegate;

@synthesize hasAddLine;
- (void)dealloc {
    
    TT_RELEASE_SAFELY(_usernameTextField);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_phoneNum);
    TT_RELEASE_SAFELY(_phoneNumTextField);
    
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor whiteColor];        
        
		self.autoresizesSubviews = YES;
        
    }
    
    return self;
}

- (UILabel *)username{
    
    if (!_username) {
        
        _username = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
        
        _username.backgroundColor = [UIColor clearColor];
        
        _username.font = fontSize;
        
        [self.contentView addSubview:_username];
    }
    
    return _username;
}


- (UITextField *)usernameTextField{
    
    if (!_usernameTextField) {
        
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _usernameTextField.placeholder = L(@"BTPleaseInputName");
        _usernameTextField.font=[UIFont systemFontOfSize:15.0];
        _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTextField.backgroundColor = [UIColor clearColor];
        _usernameTextField.delegate = self;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        _usernameTextField.borderStyle = UITextBorderStyleNone;
        _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _usernameTextField.textAlignment=NSTextAlignmentRight;
        _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTextField.keyboardType = UIKeyboardTypeDefault;
//        _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;   
        
     
        _usernameTextField.text = [[[UserCenter defaultCenter] userInfoDTO] userName]?[[[UserCenter defaultCenter] userInfoDTO] userName]:@"";
        [self.contentView addSubview:_usernameTextField];
    }
    
    return _usernameTextField;
}

- (UILabel *)phoneNum{
    
    if (!_phoneNum) {
        
        _phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(10, self.username.bottom + 5, 100, 30)];
        
        _phoneNum.backgroundColor = [UIColor clearColor];
        
        _phoneNum.font = fontSize;
        
        [self.contentView addSubview:_phoneNum];
    }
    
    return _phoneNum;
}


- (UITextField *)phoneNumTextField{
    
    if (!_phoneNumTextField) {
        
        _phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneNumTextField.placeholder = L(@"BTPleaseInputMobileNumber");
        _phoneNumTextField.font=[UIFont systemFontOfSize:15.0];
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.backgroundColor = [UIColor clearColor];
        _phoneNumTextField.delegate = self;
        _phoneNumTextField.returnKeyType = UIReturnKeyDone;
        _phoneNumTextField.borderStyle = UITextBorderStyleNone;
        _phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneNumTextField.textAlignment=NSTextAlignmentRight;
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
        
        _phoneNumTextField.text = [[[UserCenter defaultCenter] userInfoDTO] phoneNo]?[[[UserCenter defaultCenter] userInfoDTO] phoneNo]:@"";

        [self.contentView addSubview:_phoneNumTextField];
    }
    
    return _phoneNumTextField;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
 
    if (!hasAddLine) {
        UIImageView* topLineImage=[self newLineImageView];
        [self.contentView addSubview:topLineImage];
    }
    
    
    self.usernameTextField.frame = CGRectMake(120, 5, kTextFieldWidth, 30);
    self.phoneNumTextField.frame = CGRectMake(120, self.usernameTextField.bottom + 5, kTextFieldWidth, 30);
    
    if (!hasAddLine) {
        UIImageView* userNameLine=[self newLineImageView];
        userNameLine.top=self.usernameTextField.bottom+4.5;
        [self.contentView addSubview:userNameLine];
    }
    
    
    if (!hasAddLine) {
        UIImageView* phoneNumLine=[self newLineImageView];
        phoneNumLine.top=self.phoneNumTextField.bottom+4.5;
        [self.contentView addSubview:phoneNumLine];
    }
    self.hasAddLine=1;
    
    
    
}
-(UIImageView*)newLineImageView
{
    UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
    [lineImage setImage:img];
    
    return lineImage;
}
- (void)initLinkManInfo{
    
    self.username.text = L(@"name");
    self.phoneNum.text= L(@"MobilePhone");
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.usernameTextField) {
        
        if ([_delegate conformsToProtocol:@protocol(LinkManInfoCellDelegete)])
        {
            if ([_delegate respondsToSelector:@selector(sendLinkManName:)])
            {
                [self.delegate sendLinkManName:self.usernameTextField.text];
                
                [self.usernameTextField resignFirstResponder];
            }
        }
    }
    
    if (textField == self.phoneNumTextField) {
        
        if ([_delegate conformsToProtocol:@protocol(LinkManInfoCellDelegete)])
        {
            if ([_delegate respondsToSelector:@selector(sendLinkManPhoneNum:)])
            {
                [_delegate sendLinkManPhoneNum:self.phoneNumTextField.text];
                
                [self.phoneNumTextField resignFirstResponder];
            }
        }        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        
        [self.phoneNumTextField becomeFirstResponder];
    }
    
    return NO;
}



@end
