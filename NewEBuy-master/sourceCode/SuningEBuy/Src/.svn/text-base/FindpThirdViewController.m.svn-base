//
//  FindpThirdViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FindpThirdViewController.h"
#import "PasswordVerifyUtil.h"
#import "SFHFKeychainUtils.h"
#import "PasswdUtil.h"

@interface FindpThirdViewController ()

@end

@implementation FindpThirdViewController

@synthesize findPasswordDto                 = _findPasswordDto;
@synthesize findPasswrodService             = _findPasswrodService;

@synthesize passwordTextField               = _passwordTextField;
@synthesize rePasswordTextField             = _rePasswordTextField;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_findPasswordDto);
    SERVICE_RELEASE_SAFELY(_findPasswrodService);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"find_password");
        if (!_findPasswordDto) {
            _findPasswordDto = [[FindPasswordDTO alloc] init];
        }
        self.pageTitle = L(@"Member_LoginAndRegister_ResetPassword3");
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTFinish")];//L(@"CommitBtn")
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.groupTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 44);
    [self.groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.groupTableView];    
}


- (UITextField *)passwordTextField
{
	
    if(!_passwordTextField)
    {
        CGRect rect = CGRectMake(90, 7, 320 - 28-85, 30);
		//if (IOS7_OR_LATER)
        rect = CGRectMake(30, 8, 220, 30);
		_passwordTextField = [[UITextField alloc] initWithFrame:rect];
		
		_passwordTextField.delegate = self;
		
        _passwordTextField.font = [UIFont systemFontOfSize:14.0];
        
		_passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _passwordTextField.returnKeyType = UIReturnKeyNext;
        
        _passwordTextField.enablesReturnKeyAutomatically = YES;
		
		_passwordTextField.placeholder = L(@"input User PassWord");
		
		_passwordTextField.secureTextEntry = YES;
		
	}
	
	return _passwordTextField;
	
}

- (UITextField *)rePasswordTextField
{
	
    if(!_rePasswordTextField)
    {
		
		_rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 7, 320 - 28-85, 30)];
		
		_rePasswordTextField.delegate = self;
		
        _rePasswordTextField.font = [UIFont systemFontOfSize:14.0];
        
		_rePasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_rePasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _rePasswordTextField.returnKeyType = UIReturnKeyGo;
        
        _rePasswordTextField.enablesReturnKeyAutomatically = YES;
		
		_rePasswordTextField.placeholder = L(@"please_enter_your_password_again");
		
		_rePasswordTextField.secureTextEntry = YES;
		
	}
	
	return _rePasswordTextField;
	
}

- (FindPasswordService *)findPasswrodService
{
    if (!_findPasswrodService) {
        _findPasswrodService = [[FindPasswordService alloc] init];
        _findPasswrodService.delegate = self;
    }
    return _findPasswrodService;
}

- (void)changePasswordShowState
{
    
   
    self.passwordTextField.secureTextEntry = !(self.passwdToggleView.isShowWords);
    if ([self.passwordTextField isFirstResponder])
    {
        [self.passwordTextField resignFirstResponder];
    }
//    [self.passwordTextField becomeFirstResponder];
//    if (!IOS7_OR_LATER) {
//        [self.passwordTextField resignFirstResponder];
//    }
}

#pragma mark -
#pragma mark tableView delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
//if (IOS7_OR_LATER)
    return 1;
//else
//    return 2;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (!IOS7_OR_LATER)
    //    return 10;
    //    else
    return 18;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *findpFirstIdentifier = @"findpFirstIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:findpFirstIdentifier];
    
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:findpFirstIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
//        if (!_passwdToggleView)
//        {
//            _passwdToggleView = [[PasswordToggleView alloc] init];
//            [_passwdToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];
//        }
        //cell.backgroundColor = [UIColor clearColor];

    }
    
    if (indexPath.section == 0)
    {

        
        [cell.contentView addSubview:self.passwordTextField];
        [cell.contentView addSubview:self.passwdToggleView];
        _passwdToggleView.left = self.passwordTextField.right+5;
        _passwdToggleView.top = 12;
        _passwdToggleView.hidden = NO;

        
    }else if (indexPath.section == 1){
        cell.textLabel.text = L(@"confirm_password");
        [cell.contentView addSubview:self.rePasswordTextField];
    }
    
    return cell;
}


- (BOOL)validateAllInfo
{
    /*密码校验*/
    NSString *password = self.passwordTextField.text;
    NSString *psdErrorMsg = nil;
	if (![PasswordVerifyUtil verifyRegistePassword:password error:&psdErrorMsg])
    {
        [self presentSheet:psdErrorMsg posY:30];
        [self.passwordTextField becomeFirstResponder];
        return NO;
    }
    
//
//    if (!IOS7_OR_LATER)
//    {
//        NSString *rePassword = self.rePasswordTextField.text;
//        
//        if (!rePassword || [rePassword isEmptyOrWhitespace]){
//            
//            [self.rePasswordTextField becomeFirstResponder];
//            
//            [self presentSheet:kLoginStatusMessageRepeadPassword posY:30];
//            
//            return NO;
//            
//        }
//        else if(![rePassword isEqualToString:password])
//        {		
//            [self presentSheet:kLoginStatusMessageRepeadPasswordError posY:30];
//            
//            return NO;
//        }
//    }
    return YES;
}

- (void)righBarClick

{
    if (![self validateAllInfo]) {
        return;
    }
    
    [self.passwordTextField resignFirstResponder];
    [self.rePasswordTextField resignFirstResponder];
    
    self.findPasswordDto.password = self.passwordTextField.text;
    self.findPasswordDto.stepIndex = 4;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView];
    [self.findPasswrodService beginFindPasswordHttpRequest:self.findPasswordDto];
}

- (void)findPasswordHttpComplete:(FindPasswordService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        NSString *password = [PasswdUtil encryptString:self.passwordTextField.text
                                                forKey:kLoginPasswdParamEncodeKey
                                                  salt:kPBEDefaultSalt];
        
        [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey andPassword:self.mobileNumString forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
        [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey andPassword:password forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
//        [Config currentConfig].username = self.mobileNumString;
//        [Config currentConfig].password = self.passwordTextField.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:Find_Password_Success object:nil];
        [self dismissModalViewControllerAnimated:YES];
    }else{
        [self presentSheet:service.errorMsg];
    }
}


#pragma mark -
#pragma mark textfield detegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // deprecated by liukun 不好的用户体验
//    if (textField == self.passwordTextField) {
//        if (textField.text.length >= 20 && range.location >= 20)
//        {
//            return NO;
//        }
//    }else if (textField == self.rePasswordTextField){
//        if (textField.text.length >= 20 && range.location >= 20)
//        {
//            return NO;
//        }   
//    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.passwordTextField) {
        [self.rePasswordTextField becomeFirstResponder];
        return YES;
    }else if (textField == self.rePasswordTextField){
        [self righBarClick];
        return YES;
    }
    return YES;
}

- (PasswordToggleView *)passwdToggleView
{
    if (!_passwdToggleView) {
        _passwdToggleView = [[PasswordToggleView alloc] init];
        _passwdToggleView.hidden = YES;
        [_passwdToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged]; 
    }
    return _passwdToggleView;
}
@end
