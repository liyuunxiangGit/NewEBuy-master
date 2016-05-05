//
//  RetrievePasswordViewController.m
//  SuningEBuy
//
//  Created by wangrui on 2/11/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "PasswordVerifyUtil.h"

@implementation RetrievePasswordViewController
#pragma mark -
#pragma mark Properties
@synthesize mode = _mode;
@synthesize userName = _userName;

@synthesize usernameLabel = _usernameLabel;
@synthesize passwordLabel = _passwordLabel;
@synthesize rePasswordLabel = _rePasswordLabel;
@synthesize authCodeLabel = _authCodeLabel;

@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize rePasswordTextField = _rePasswordTextField;
@synthesize authCodeTextField = _authCodeTextField;

@synthesize service = _service;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_userName);
    
    TT_RELEASE_SAFELY(_usernameLabel);
    TT_RELEASE_SAFELY(_passwordLabel);
    TT_RELEASE_SAFELY(_rePasswordLabel);
    TT_RELEASE_SAFELY(_authCodeLabel);
    
    TT_RELEASE_SAFELY(_usernameTextField);
    TT_RELEASE_SAFELY(_passwordTextField);
    TT_RELEASE_SAFELY(_rePasswordTextField);
    TT_RELEASE_SAFELY(_authCodeTextField);
    SERVICE_RELEASE_SAFELY(_service);
}


- (id)init
{
    if (self = [super init]) 
    {
        
        self.title = L(@"Reset password");
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back") style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
		
		self.navigationItem.leftBarButtonItem = leftItem;
        
        TT_RELEASE_SAFELY(leftItem);
        
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] 
                                      
                                      initWithTitle:L(@"Commit") style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];
		
		self.navigationItem.rightBarButtonItem = rightItem;
        
        
        TT_RELEASE_SAFELY(rightItem);
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    self.groupTableView.frame = frame;
    
    self.groupTableView.scrollEnabled = NO;
    
    [self.view addSubview:self.groupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.passwordTextField becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.passwordTextField resignFirstResponder];
    [self.rePasswordTextField resignFirstResponder];
    [self.authCodeTextField resignFirstResponder];
}

#pragma mark -
#pragma mark Send Http Request

- (UserRetrieveService *)service
{
    if (!_service) {
        _service = [[UserRetrieveService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)sendResetPasswordHttpRequest
{
    [self displayOverFlowActivityView:L(@"Sending...") yOffset:-80.0f];
    
    [self.service resetPasswordWithLogonId:self.usernameTextField.text
                                activeCode:self.authCodeTextField.text
                                  password:self.passwordTextField.text
                            passwordVerify:self.rePasswordTextField.text];
}

- (void)resetPasswordCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        [self dismissModalViewControllerAnimated:YES];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.userName,@"username",
                                  self.passwordTextField.text,@"password",nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:POPUP_MESSAGE object:userInfo];
    }
    else
    {
        [self.authCodeTextField becomeFirstResponder];
        
        [self presentCustomDlg:errorMsg];
    }
}

#pragma mark -
#pragma mark UINavigation Item Action
- (void)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)submitAction:(id)sender
{
    
    NSString *errMessage = nil;
	
    NSString *password = self.passwordTextField.text;
    NSString *psdErrorMsg = nil;
	if (![PasswordVerifyUtil verifyRegistePassword:password error:&psdErrorMsg])
    {
        [self presentSheet:psdErrorMsg posY:90];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    if (!self.rePasswordTextField.text || [self.rePasswordTextField.text isEmptyOrWhitespace])
    {
        
        self.rePasswordTextField.text = @"";
        
		errMessage = kLoginStatusMessageRepeadPassword;
        
        [self.rePasswordTextField becomeFirstResponder];
		
		[self presentSheet:errMessage posY:130];
		
        return;
	}
    else if(![self.rePasswordTextField.text isEqualToString:self.passwordTextField.text])
    {
		
		errMessage = kLoginStatusMessageRepeadPasswordError;
        
        [self.rePasswordTextField becomeFirstResponder];
		
		[self presentSheet:errMessage posY:130];
		
		return;
		
	}
    
    if (!self.authCodeTextField.text || [self.authCodeTextField.text isEmptyOrWhitespace])
    {
        
        self.authCodeTextField.text = @"";
        
		errMessage = kLoginStatusMessageRequirevalidateCode;
        
        [self.authCodeTextField becomeFirstResponder];
		
		[self presentSheet:errMessage posY:160];
		
        return;
	}
    
    
    [self sendResetPasswordHttpRequest];
}

#pragma mark -
#pragma mark UIControl View
- (UILabel*)usernameLabel
{
	
	if(!_usernameLabel)
    {
		
		_usernameLabel = [[UILabel alloc]init];
		
		_usernameLabel.frame = CGRectMake(5,5,70,34);
		
		_usernameLabel.numberOfLines = 0;
		
		_usernameLabel.font = [UIFont systemFontOfSize:14];
		
		_usernameLabel.lineBreakMode = UILineBreakModeWordWrap;
		
		_usernameLabel.textAlignment = UITextAlignmentRight;
        
        _usernameLabel.backgroundColor = [UIColor clearColor];
	}
	
	return _usernameLabel;
	
}


- (UILabel*)passwordLabel
{
	
	if(!_passwordLabel)
    {
		
		_passwordLabel = [[UILabel alloc]init];
		
		_passwordLabel.frame = CGRectMake(5,5,70,34);
		
		_passwordLabel.numberOfLines = 0;
		
		_passwordLabel.font = [UIFont systemFontOfSize:14];
		
		_passwordLabel.lineBreakMode = UILineBreakModeWordWrap;
		
		_passwordLabel.textAlignment = UITextAlignmentRight;
        
        _passwordLabel.backgroundColor = [UIColor clearColor];
	}
	
	return _passwordLabel;
	
}


- (UILabel*)rePasswordLabel
{
	
	if(!_rePasswordLabel)
    {
		
		_rePasswordLabel = [[UILabel alloc]init];
		
		_rePasswordLabel.frame = CGRectMake(5,5,70,34);
		
		_rePasswordLabel.numberOfLines = 0;
		
		_rePasswordLabel.font = [UIFont systemFontOfSize:14];
		
		_rePasswordLabel.lineBreakMode = UILineBreakModeWordWrap;
		
		_rePasswordLabel.textAlignment = UITextAlignmentRight;
        
        _rePasswordLabel.backgroundColor = [UIColor clearColor];
	}
	
	return _rePasswordLabel;
	
}

- (UILabel*)authCodeLabel
{
	
	if(!_authCodeLabel)
    {
		
		_authCodeLabel = [[UILabel alloc]init];
		
		_authCodeLabel.frame = CGRectMake(5,5,70,34);
		
		_authCodeLabel.numberOfLines = 0;
		
		_authCodeLabel.font = [UIFont systemFontOfSize:14];
		
		_authCodeLabel.lineBreakMode = UILineBreakModeWordWrap;
		
		_authCodeLabel.textAlignment = UITextAlignmentRight;
        
        _authCodeLabel.backgroundColor = [UIColor clearColor];
	}
	
	return _authCodeLabel;
	
}

- (UITextField *)usernameTextField 
{
	
	if (!_usernameTextField) 
    {
		
		_usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
        
        _usernameTextField.font = [UIFont boldSystemFontOfSize:14];
		
		_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
		_usernameTextField.enabled = NO;
	} 
	
	return _usernameTextField;	
}

- (UITextField*)passwordTextField
{
	
	if(!_passwordTextField)
    {
		
		_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
		
		_passwordTextField.delegate = self;
        
        _passwordTextField.font = [UIFont systemFontOfSize:14];
		
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


- (UITextField*)rePasswordTextField
{
	
	if(!_rePasswordTextField)
    {
		
		_rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
		
		_rePasswordTextField.delegate = self;
        
        _rePasswordTextField.font = [UIFont systemFontOfSize:14];
		
		_rePasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_rePasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _rePasswordTextField.returnKeyType = UIReturnKeyNext;
		
        _rePasswordTextField.enablesReturnKeyAutomatically = YES;
        
		_rePasswordTextField.placeholder =L(@"reInput User PassWord");
        
		_rePasswordTextField.secureTextEntry = YES;	
		
	}
	
	return _rePasswordTextField;
	
}

- (UITextField*)authCodeTextField
{
	
	if(!_authCodeTextField)
    {
		
		_authCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5., self.groupTableView.width - 28-80., 34.)];
		
		_authCodeTextField.delegate = self;
        
        _authCodeTextField.font = [UIFont systemFontOfSize:14];
		
		_authCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_authCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_authCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _authCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _authCodeTextField.returnKeyType = UIReturnKeyGo;
		
        _authCodeTextField.enablesReturnKeyAutomatically = YES;
        
		_authCodeTextField.placeholder = L(@"Please input auth code");
        
		
	}
	
	return _authCodeTextField;
	
}

#pragma mark -
#pragma mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.passwordTextField) 
    {
        [self.rePasswordTextField becomeFirstResponder];
    }
    else if (textField == self.rePasswordTextField)
    {
        [self.authCodeTextField becomeFirstResponder];
    }
    else
    {
        [self submitAction:nil];
    }
    
    return NO;
}

#pragma mark -
#pragma mark Validate Methods
- (BOOL)validatePassword:(NSString *)pwd
{
    return YES;
}

#pragma mark -
#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    
    return  4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	else
    {
		
		[cell.contentView removeAllSubviews];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) 
    {
        case 0:
        {            
            self.usernameLabel.text = L(@"UserName");
            self.usernameTextField.text = self.userName;
            
            [cell.contentView addSubview:self.usernameLabel];
            [cell.contentView addSubview:self.usernameTextField];
            
            break;
        }
        case 1:
        {
            self.passwordLabel.text = L(@"PassWord");
            
            [cell.contentView addSubview:self.passwordLabel];
            [cell.contentView addSubview:self.passwordTextField];
            
            break;
        }
        case 2:
        {
            self.rePasswordLabel.text = L(@"rePassWord");
            
            [cell.contentView addSubview:self.rePasswordLabel];
            [cell.contentView addSubview:self.rePasswordTextField];
            
            break;
        }
        case 3:
        {
            self.authCodeLabel.text = L(@"authCode");
            
            [cell.contentView addSubview:self.authCodeLabel];
            [cell.contentView addSubview:self.authCodeTextField];
            
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
