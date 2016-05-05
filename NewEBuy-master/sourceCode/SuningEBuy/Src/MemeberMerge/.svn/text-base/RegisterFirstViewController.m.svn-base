//
//  RegisterViewControler.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-10-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RegisterFirstViewController.h"
#import "UITableViewCell+BgView.h"
#import "AccountMergeSuccessViewController.h"
#import "PasswordVerifyUtil.h"
#import "DataValidate.h"
#import "SNGraphics.h"
#import "RegexKitLite.h"

@interface RegisterFirstViewController()
{
    BOOL            phoneNumChanged;
}

@end

@implementation RegisterFirstViewController

- (void)dealloc
{
    
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);
    SERVICE_RELEASE_SAFELY(_memberMergeService);
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = L(@"UCRegistration");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"UCRegister")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(goToMergerCount)];
        self.navigationItem.rightBarButtonItem = rightButton;

        phoneNumChanged = NO;
    }
    return self;
}

- (void)resignKeyBoard
{
    [self.phoneNumTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)sendCodeHttp
{
    NSString *phoneNumErr = nil;
    
    if (![DataValidate validatePhoneNum:self.phoneNumTextField.text error:&phoneNumErr]) {
        [self presentSheet:phoneNumErr posY:30];
        [self.phoneNumTextField becomeFirstResponder];
        return;
    }
    
    if (phoneNumChanged == [[self.phoneNumTextField.text trim] isEqualToString:[UserCenter defaultCenter].bindPhoneNum]) {
        [self changePhoneNumAction];
        return;
    }
    
    
    [self resignKeyBoard];
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.mergeNewAccountAto.actionType = @"sendVerifyCode";
    self.mergeNewAccountAto.registerId = self.phoneNumTextField.text;
    [self.memberMergeService beginMergeNewAccount:self.mergeNewAccountAto];
}

- (MergeNewAccountDTO *)mergeNewAccountAto
{
    if (!_mergeNewAccountAto) {
        _mergeNewAccountAto = [[MergeNewAccountDTO alloc] init];
        _mergeNewAccountAto.cardNum = self.cardNum;
        _mergeNewAccountAto.mbrcardPsw = self.cardPass;
    }
    return _mergeNewAccountAto;
}

- (Calculagraph *)calculagraph
{
    if (!_calculagraph)
    {
        _calculagraph = [[Calculagraph alloc] init];
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
    return _calculagraph;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        int seconds = [[change objectForKey:@"new"] intValue];
        NSString *time = [NSString stringWithFormat:@"%d",60 - seconds];
        if ([time isEqualToString:@"0"]) {
            [self.calculagraph stop];
            [self.getCodeBtn setTitle:L(@"Send_again") forState:UIControlStateNormal];
            self.getCodeBtn.enabled = YES;
        }else{
            self.getCodeBtn.enabled = NO;
            [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@ %@s",L(@"UCReObtain"),time] forState:UIControlStateNormal];
        }
    }
}


#pragma mark -
#pragma mark view lifycycle

- (void)loadView
{
    [super loadView];
	
	self.tpTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 44);
    self.tpTableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.tpTableView];
}


- (void)goToMergerCount
{
    if (![self validateAllData]) {
        return;
    }
    
    [self resignKeyBoard];
    
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.mergeNewAccountAto.validateCode = self.codeTextField.text;
    self.mergeNewAccountAto.registerId = self.phoneNumTextField.text;
    self.mergeNewAccountAto.registerPassword = self.passwordTextField.text;
    self.mergeNewAccountAto.actionType = @"";
    [self.memberMergeService beginMergeNewAccount:self.mergeNewAccountAto];
}

- (keyboardNumberPadReturnTextField *)phoneNumTextField
{
    if (!_phoneNumTextField) {
		_phoneNumTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(15, 0, 290, 40)];
		_phoneNumTextField.delegate = self;
        _phoneNumTextField.doneButtonDelegate = self;
        _phoneNumTextField.font = [UIFont boldSystemFontOfSize:14];
		_phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phoneNumTextField.enablesReturnKeyAutomatically = YES;
        _phoneNumTextField.placeholder =L(@"input phoneNum");
        _phoneNumTextField.text = IsStrEmpty([UserCenter defaultCenter].bindPhoneNum)?@"":[UserCenter defaultCenter].bindPhoneNum;
		
    }
    return _phoneNumTextField;
}

- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.frame = CGRectMake(self.codeTextField.right, 0, 320 - self.codeTextField.right, 40);
        [_getCodeBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundImage:[UIImage streImageNamed:@"button_gray_normal.png"] forState:UIControlStateDisabled];
        [_getCodeBtn setTitle:L(@"UCGetVerificationCode") forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_getCodeBtn addTarget:self action:@selector(sendCodeHttp) forControlEvents:UIControlEventTouchUpInside];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _getCodeBtn;
}

- (UITextField *)codeTextField{
	if(!_codeTextField){
		_codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
		_codeTextField.delegate = self;
        _codeTextField.font = [UIFont boldSystemFontOfSize:14];
		_codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_codeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.enablesReturnKeyAutomatically = YES;
        _codeTextField.placeholder = L(@"UCPleaseInputVerificationCode");
	}
	return _codeTextField;
}


- (UITextField *)passwordTextField
{
	if(!_passwordTextField)
    {
		_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 240, 40)];
		_passwordTextField.delegate = self;
        _passwordTextField.font = [UIFont boldSystemFontOfSize:14];
		_passwordTextField.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
		_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTextField.returnKeyType = UIReturnKeyNext;
        _passwordTextField.enablesReturnKeyAutomatically = YES;
        _passwordTextField.placeholder =L(@"UCLettersNumbersOrSymbolsCombination");
		_passwordTextField.secureTextEntry = YES;
	}
	return _passwordTextField;
	
}

- (PasswordToggleView *)passwdToggleView
{
    if (!_passwdToggleView) {
        _passwdToggleView = [[PasswordToggleView alloc] init];
        [_passwdToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];
    }
    return _passwdToggleView;
}

- (void)changePasswordShowState
{
    self.passwordTextField.secureTextEntry = !self.passwdToggleView.isShowWords;
    if (!IOS7_OR_LATER)
    {
        [self.passwordTextField resignFirstResponder];
    }
}


#pragma mark 会员请求
- (MemeberMergeService *)memberMergeService
{
    if (!_memberMergeService) {
        _memberMergeService = [[MemeberMergeService alloc] init];
        _memberMergeService.delegate = self;
    }
    return _memberMergeService;
}

- (void)mergeNewAccountHttpComplete:(MemeberMergeService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        if ([self.mergeNewAccountAto.actionType isEqualToString:@"sendVerifyCode"]) {
            [self.calculagraph start];
            self.getCodeBtn.enabled = NO;
        }else{
            [UserCenter defaultCenter].suningUsername = self.phoneNumTextField.text;
            [UserCenter defaultCenter].suningPassword = self.passwordTextField.text;
            AccountMergeSuccessViewController *success = [[AccountMergeSuccessViewController alloc] init];
            success.memberInfoDto = service.memberInfoDto;
            [self.navigationController pushViewController:success animated:YES];
        }
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg posY:60];
    }
}



#pragma mark -
#pragma mark tableview delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (phoneNumChanged) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *secondCellIdentifier = @"secondCellIdentifier";
    SNUITableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
    if (secondCell == nil) {
        secondCell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
        secondCell.textLabel.backgroundColor = [UIColor clearColor];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.textLabel.font =[UIFont systemFontOfSize:14.0];
        secondCell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
    }else{
        [secondCell.contentView removeAllSubviews];
    }
    if (phoneNumChanged) {
        if (indexPath.section == 0){
            [secondCell.contentView addSubview:self.phoneNumTextField];
        }
        else if (indexPath.section == 1)
        {
            [secondCell.contentView addSubview:self.codeTextField];
            [secondCell.contentView addSubview:self.getCodeBtn];
        }else{
            self.passwdToggleView.left = self.passwordTextField.right+5;
            self.passwdToggleView.top = 10;
            [secondCell.contentView addSubview:self.passwdToggleView];
            [secondCell.contentView addSubview:self.passwordTextField];
        }
    }else{
        if (indexPath.section == 0){
            [secondCell.contentView addSubview:self.phoneNumTextField];
        }
        else if (indexPath.section == 1)
        {
            self.passwdToggleView.left = self.passwordTextField.right+5;
            self.passwdToggleView.top = 10;
            [secondCell.contentView addSubview:self.passwdToggleView];
            [secondCell.contentView addSubview:self.passwordTextField];
        }
    }
    return secondCell;
}

#pragma mark -
#pragma mark textfield delegate/datasource
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumTextField) {
        [self.phoneNumTextField resignFirstResponder];
        [self changePhoneNumAction];
    }else if (textField == self.codeTextField){
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField){
        [self.passwordTextField resignFirstResponder];
        [self goToMergerCount];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == self.phoneNumTextField) {
        [self changePhoneNumAction];
    }
    return YES;
}


- (BOOL)canBecomeFirstResponder
{
    [super canBecomeFirstResponder];
    if ([self.phoneNumTextField isFirstResponder]) {
        [self changePhoneNumAction];
        [self.phoneNumTextField resignFirstResponder];
    }
    return NO;
}

- (void)changePhoneNumAction
{
    if ([[self.phoneNumTextField.text trim] isEqualToString:[UserCenter defaultCenter].bindPhoneNum]) {
        phoneNumChanged = NO;
    }else{
        phoneNumChanged = YES;
    }
    [self.tpTableView reloadData];
}

- (void)doneTapped:(id)sender
{
    [self changePhoneNumAction];
}

//手机号码长度不超过11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField  == self.phoneNumTextField)
    {
        if (textField.text.length >= 11 && range.location >=11)
        {
            return NO;
        }
    }
    else if (textField == self.passwordTextField)//|| textField == self.rePasswordTextField)
    {
        if ([string length] != [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding])
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)validateAllData
{
    if (phoneNumChanged == [[self.phoneNumTextField.text trim] isEqualToString:[UserCenter defaultCenter].bindPhoneNum]) {
        [self changePhoneNumAction];
        return NO;
    }
    
    NSString *phoneNumErr = nil;
    if (![DataValidate validatePhoneNum:self.phoneNumTextField.text error:&phoneNumErr]) {
        [self presentSheet:phoneNumErr posY:30];
        [self.phoneNumTextField becomeFirstResponder];
        return NO;
    }
    if (phoneNumChanged) {
        NSString *codeErr = nil;
        if (![DataValidate validateCodeString:self.codeTextField.text error:&codeErr]) {
            [self presentSheet:codeErr posY:30];
            [self.codeTextField becomeFirstResponder];
            return NO;
        }
    }
    /*密码校验*/
    NSString *password = self.passwordTextField.text;
    NSString *psdErrorMsg = nil;
	if (![PasswordVerifyUtil verifyRegistePassword:password error:&psdErrorMsg])
    {
        [self presentSheet:psdErrorMsg posY:30];
        [self.passwordTextField becomeFirstResponder];
        return NO;
    }
//	/*确认密码*/
//	NSString *rePassword = self.rePasswordTextField.text;
//    if (!rePassword || [rePassword isEmptyOrWhitespace]){
//        [self.rePasswordTextField becomeFirstResponder];
//		[self presentSheet:kLoginStatusMessageRepeadPassword posY:30];
//        return NO;
//	}
//    else if(![rePassword isEqualToString:password])
//    {
//		[self presentSheet:kLoginStatusMessageRepeadPasswordError posY:30];
//		return NO;
//	}
    return YES;
}



@end
