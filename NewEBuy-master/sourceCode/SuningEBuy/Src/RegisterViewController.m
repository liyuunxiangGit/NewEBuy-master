//
//  RegisterViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegistHandselCouponCommand.h"
#import "PasswordVerifyUtil.h"

@implementation RegisterViewController

@synthesize service = _service;
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize rePasswordTextField = _rePasswordTextField;
@synthesize registerDelegate = _registerDelegate;
@synthesize registerOkSelector = _registerOkSelector;

- (void)dealloc {
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_usernameTextField);
    TT_RELEASE_SAFELY(_passwordTextField);
    TT_RELEASE_SAFELY(_rePasswordTextField);
    
}

- (id)init{
	
    self = [super init];
	
    if (self) {
		
        self.title = L(@"User Register");
        
        self.pageTitle = L(@"member_loginAndRegister_register");
//        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]
//                                      initWithTitle:L(@"Cancel")
//                                      style:UIBarButtonItemStylePlain
//                                      target:self
//                                      action:@selector(cancel:)];
//		self.navigationItem.leftBarButtonItem = cancelBtn;
//        TT_RELEASE_SAFELY(cancelBtn);
        UIBarButtonItem *cancelButton = [UIBarButtonItem initWithImage:@"right_item_btn.png" withName:L(@"Cancel")];// wihtSel:nil];
        if (cancelButton.customView) {
            UIButton *btn = (UIButton *)cancelButton.customView;
            [btn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        }
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        
//        UIBarButtonItem *okButton = [[UIBarButtonItem alloc]
//                                     initWithTitle:L(@"Register")
//                                     style:UIBarButtonItemStylePlain
//                                     target:self
//                                     action:@selector(registerAction:)];
//		self.navigationItem.rightBarButtonItem = okButton;
//        TT_RELEASE_SAFELY(okButton);
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Register")];
    }
    return self;
}

- (void)righBarClick
{
    [self registerAction:nil];
}

#pragma mark -
#pragma mark view lifycycle

- (void)loadView
{
	
	[super loadView];
	
	UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 10;
	
	frame.size.height = 145;
	
	self.groupTableView.frame = frame;
    
    self.groupTableView.scrollEnabled = NO;
	
	[self.view addSubview:self.groupTableView];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.usernameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.usernameTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
    
    [self.rePasswordTextField resignFirstResponder];
}


#pragma mark -
#pragma mark service

- (UserRegisterService *)service
{
    if (!_service) {
        _service = [[UserRegisterService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)userRegisterCompletedWithResult:(BOOL)successfulRegist 
                              errorCode:(NSString *)errorCode
                               userInfo:(UserInfoDTO *)userInfo
{
    [self removeOverFlowActivityView];

    if (successfulRegist)
    {
        //注册送券
        [[UserCenter defaultCenter] sendCouponAfterRegistForUser:userInfo.userId];
        
        [self dismissModalViewControllerAnimated:NO];
        
        if (self.registerDelegate && [self.registerDelegate respondsToSelector:self.registerOkSelector])
        {
            SuppressPerformSelectorLeakWarning
            ([self.registerDelegate performSelector:self.registerOkSelector]);
        }
        
    }
    else
    {

		[self presentSheet:errorCode posY:30];
		
    }
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark -
#pragma mark action

- (void)cancel:(id)sender {
	
	[self dismissModalViewControllerAnimated:YES];
    
    
}



- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:candidate];
}
- (BOOL) validateMobileNo: (NSString *) mobileNo {
    NSString *mobileNoRegex = @"1[0-9]{10,10}"; 
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex]; 
	
    return [mobileNoTest evaluateWithObject:mobileNo];
}

- (BOOL) validateRegisterId:(NSString *)registerIdString{	
	BOOL ret = NO;
	if ([self validateMobileNo:registerIdString ]) {
		ret = YES;
	}else{
        
        ret = NO;
    }	
    //	if ([self validateEmail:registerIdString]) {		
    //		self.registertype = @"2";
    //		ret = YES;
    //	}
	return ret;
}



-(void)registerAction:(id)sender{		
	
    
	NSString *errMessage = nil;
	
	/*用户名*/
	NSString *username = self.usernameTextField.text;
	
    if (!username || [username isEmptyOrWhitespace]){
		
        [self.usernameTextField becomeFirstResponder];
        
		errMessage = kLoginStatusMessageRequireRegisterId;
		
		[self presentSheet:errMessage posY:30];
		
        return;
	}
    
	
	if (![self validateRegisterId:username]) {
		
		errMessage = kRegisterStatusMessagedRegisterIdError;
		
		DLog(@"errMessage=%@\n",errMessage);
		
		[self presentSheet:errMessage posY:30];
		
        return;
        
	}
	
	
	/*密码校验*/
    NSString *password = self.passwordTextField.text;
    NSString *psdErrorMsg = nil;
	if (![PasswordVerifyUtil verifyRegistePassword:password error:&psdErrorMsg])
    {
        [self presentSheet:psdErrorMsg posY:30];
        [self.passwordTextField becomeFirstResponder];
        return;
    }

	/*确认密码*/
	NSString *rePassword = self.rePasswordTextField.text;
	
    if (!rePassword || [rePassword isEmptyOrWhitespace]){
		
        [self.rePasswordTextField becomeFirstResponder];
        
		errMessage = kLoginStatusMessageRepeadPassword;
		
		[self presentSheet:errMessage posY:30];
		
        return;
		
	}
    else if(![rePassword isEqualToString:password])
    {
		errMessage = kLoginStatusMessageRepeadPasswordError;
		
		[self presentSheet:errMessage posY:30];
		
		return;
	}
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.rePasswordTextField resignFirstResponder];
    self.navigationItem.rightBarButtonItem.enabled = NO;
	
	[self displayOverFlowActivityView:kRegisterStatusMessageSendActiveHttp yOffset:-80.0f];
    
    [self.service beginRegisterUsername:username 
                               password:password
                           registerType:RegisterTypeMobile];
	
}

#pragma mark -
#pragma mark views

- (keyboardNumberPadReturnTextField *)usernameTextField {
	
	if (!_usernameTextField) {
		
		_usernameTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
		
		_usernameTextField.delegate = self;
        
        _usernameTextField.font = [UIFont boldSystemFontOfSize:14];
		
		_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
				
        _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                
        _usernameTextField.enablesReturnKeyAutomatically = YES;
        
        _usernameTextField.placeholder =L(@"input phoneNum");
		
	} 
	
	return _usernameTextField;	
}

- (UITextField *)passwordTextField{
	
	if(!_passwordTextField){
		
		_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
		
		_passwordTextField.delegate = self;
        
        _passwordTextField.font = [UIFont boldSystemFontOfSize:14];
		
		_passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
		
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _passwordTextField.returnKeyType = UIReturnKeyNext;
        
        _passwordTextField.enablesReturnKeyAutomatically = YES;
        
        _passwordTextField.placeholder =L(@"input User PassWord");
        
		_passwordTextField.secureTextEntry = YES;	
		
	}
	
	return _passwordTextField;
	
}


- (UITextField *)rePasswordTextField{
	
	if(!_rePasswordTextField){
		
		_rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
		
		_rePasswordTextField.delegate = self;
        
        _rePasswordTextField.font = [UIFont boldSystemFontOfSize:14];
		
		_rePasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_rePasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _rePasswordTextField.returnKeyType = UIReturnKeyGo;
		
        _rePasswordTextField.enablesReturnKeyAutomatically = YES;
        
		_rePasswordTextField.placeholder =L(@"reInput User PassWord");
        
		_rePasswordTextField.secureTextEntry = YES;	
		
	}
	
	return _rePasswordTextField;
	
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *ddFindKeyCellIdentifier = @"ddFindKeyCellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ddFindKeyCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ddFindKeyCellIdentifier];
    }
	else{
		
		for (UIView *subview in cell.contentView.subviews) {
		    [subview removeFromSuperview];
		}
	}
	
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	
	if (indexPath.section == 0) {
		
		if (indexPath.row == 0){
			
			cell.textLabel.text = L(@"UserPhone");
            
			[cell.contentView addSubview:self.usernameTextField];
			
		}	
		
		if (indexPath.row == 1){
			cell.textLabel.text = L(@"PassWord");
            
			[cell.contentView addSubview:self.passwordTextField];
			
        }
		
		if (indexPath.row == 2){
            
            cell.textLabel.text = L(@"rePassWord");
			
			[cell.contentView addSubview:self.rePasswordTextField];
		}
		
	} 
    return cell;
}

#pragma mark -
#pragma mark text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.usernameTextField)
    {
        // Move input focus to the password field.
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self.rePasswordTextField becomeFirstResponder];
    }
    else 
    {
        // Simulate clicking the Submit button.
        [self registerAction:nil];
    }
    
    return NO;
}

//王漫 修改手机注册
//手机号码长度不超过11位
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
    replacementString:(NSString *)string{
    

    if (textField  == self.usernameTextField)
    {
        if (textField.text.length >= 11 && range.location >=11)
        {
            return NO;
        }
        if (textField.text.length + string.length - range.length > 11) {
            
            return NO;
        }
    }
     return YES;
}
@end
