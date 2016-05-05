//
//  RegisterViewController.m
//  SuningEBuy
//
//  Created by jian zhang on 13-5-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewRegisterViewController.h"
#import "NextRegisterViewController.h"
#import "ValidationService.h"

@implementation NewRegisterViewController

@synthesize service = _service;
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize registerDelegate = _registerDelegate;
@synthesize registerDto = _registerDto;

- (void)dealloc {
    TT_RELEASE_SAFELY(_registerDto);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_usernameTextField);
    TT_RELEASE_SAFELY(_passwordTextField);
    
    [_codeTimer removeObserver:self forKeyPath:@"time"];
    
}

- (void)backForePage {
    [super backForePage];
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030201"]];
}

- (id)init{
	
    self = [super init];
	
    if (self) {
		
        self.isNeedBackItem = NO;
        
        self.title = L(@"UCFastRegistration");
        
        if (!_registerDto) {
            _registerDto = [[UserRegisterDTO alloc] init];
        }
        
        SNUIBarButtonItem *cancelButton = [SNUIBarButtonItem itemWithTitle:nil
                                                                     Style:SNNavItemStyleBack
                                                                    target:self
                                                                    action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTNextStep")];
        
        
    }
    return self;
}

- (void)righBarClick
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030205"]];
    
    [self registerAction:nil];
}

#pragma mark -
#pragma mark view lifycycle

- (void)loadView
{
	
	[super loadView];
    
    if (_isFromSacnerRegister) {
        [self setPageTitle:L(@"Member_ScanCodeToLoginAndRegister_RegisterPage")];
    }else {
        self.pageTitle = L(@"member_loginAndRegister_register");
    }
	
	UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = self.view.bounds.size.height - 44;
	
	self.tpTableView.frame = frame;
    
    self.tpTableView.scrollEnabled = NO;
    //>zhangliang
    [self.tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //<zhangliang
	[self.view addSubview:self.tpTableView];
    
    [self.footView addSubview:self.checkBtn];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.codeTextField.text = @"";
    self.checkBtn.selected = YES;
    [self createLabele];
    
    [self.usernameTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.usernameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.usernameTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
    
//    [self.codeTimer stop];
    
}


#pragma mark -
#pragma mark service

- (UserNewRegisterService *)service
{
    if (!_service) {
        _service = [[UserNewRegisterService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

//- (void)userRegisterCompletedWithResult:(BOOL)successfulRegist errorMsg:(NSString *)errorMsg
//{
//    [self removeOverFlowActivityView];
//
//    if (successfulRegist)
//    {
//        NextRegisterViewController *next = [[NextRegisterViewController alloc] init];
//        next.registerDto = self.registerDto;
//        [self.navigationController pushViewController:next animated:YES];
//    }
//    else
//    {
//        [self presentSheet:IsStrEmpty(errorMsg)?kHttpResponseJSONValueFailError:errorMsg posY:30];
//    }
//
//    self.navigationItem.rightBarButtonItem.enabled = YES;
//}

#pragma mark -
#pragma mark action

- (void)cancel:(id)sender {
    
    if (1 == _backTypeId) {
        [__gNavController0 dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
	return ret;
}



-(void)registerAction:(id)sender{
    
    NSString* str = L(@"please_firstInput_VerifyCode");
    
    if(IsStrEmpty(self.codeTextField.text))
    {
        [self presentSheet:str posY:50];
        [self.codeTextField becomeFirstResponder];
        return;
    }
    
    str = L(@"Please_input_correct_VerifyNum");
    int leftValue = 4;
    int rightValue = 10;
    if (self.codeTextField.text.length < leftValue || self.codeTextField.text.length > rightValue)
    {
        [self presentSheet:str posY:50];
        [self.codeTextField becomeFirstResponder];
        return;
    }
    
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:self.codeTextField.text]==NO) {
        [self presentSheet:L(@"Please_input_correct_VerifyNum")posY:50];
        [self.codeTextField becomeFirstResponder];
        return;
    }
    
    if (!_checkBtn.selected)
    {
        [self presentSheet:L(@"UCSelectProtocolButton") posY:50];
        return;
    }
    
    
    [self.usernameTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
	[self displayOverFlowActivityView:kRegisterStatusMessageSendActiveHttp yOffset:-80.0f];
    
    self.registerDto.registerId = self.usernameTextField.text;
    //    self.registerDto.registerPassword = self.passwordTextField.text;
    //    //if (IOS7_OR_LATER)
    //    self.registerDto.registerPasswordVerify = self.passwordTextField.text;
    ////    else
    ////    self.registerDto.registerPasswordVerify = self.rePasswordTextField.text;
    //
    ////    self.registerDto.vcodeimg2 = self.codeTextField.text;
    //    self.registerDto.actionType = @"sendVerifyCode";
    
    [self.service beginValidateRegisterUsername:self.usernameTextField.text AuthCode:self.codeTextField.text];
    
    
}

#pragma mark -
#pragma mark validate code

- (void)getVerifyCode:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030203"]];
    
    /*用户名*/
    NSString *errMessage = nil;
    NSString *username = self.usernameTextField.text;
    if (!username || [username isEmptyOrWhitespace]){
		
        [self.usernameTextField becomeFirstResponder];
        
		errMessage = kLoginStatusMessageRequireRegisterId;
		
		[self presentSheet:errMessage posY:30];
        [self.usernameTextField becomeFirstResponder];
		
        return;
	}
    
	
	if (![self validateRegisterId:username]) {
		
		errMessage = kRegisterStatusMessagedRegisterIdError;
		
		DLog(@"errMessage=%@\n",errMessage);
		
		[self presentSheet:errMessage posY:30];
        [self.usernameTextField becomeFirstResponder];
		
        return;
        
	}
    
    [self displayOverFlowActivityView];
    
    [self.service beginGetValidateCode:username];
}

- (void)getValidateCodeCompleteWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [self.codeTimer start];
        [self presentSheet:L(@"UCVerificationCodeHasBeenSent")];
    }
    else
    {
        [self presentSheet:errorMsg];
    }
}

- (void)validateRegisterCompletedWithResult:(BOOL)isSuccess errorCode:(NSString *)errorCode
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [self removeOverFlowActivityView];
    if (isSuccess) {
        NextRegisterViewController *next = [[NextRegisterViewController alloc] init];
        next.registerDto = self.registerDto;
        [self.navigationController pushViewController:next animated:YES];
    }
    else
    {
        [self presentSheet:errorCode];
    }
}

#pragma mark -
#pragma mark password change state
- (void)changePasswordShowState
{
    self.passwordTextField.secureTextEntry = !_passwdToggleView.isShowWords;
}

#pragma mark -
#pragma mark views

- (UILabel *)tipsLabel
{
    if (!_tipsLabel)
    {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 190, 40)];
        
        _tipsLabel.numberOfLines = 0;
        
        _tipsLabel.textColor = [UIColor grayColor];
        
        _tipsLabel.backgroundColor = [UIColor clearColor];
        
        _tipsLabel.text = L(@"UCVerificationCodeHasBeenSentToYourPhone");
        
        _tipsLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _tipsLabel;
}

- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = CGRectMake(200, 20, 120, 40);
        //if (IOS7_OR_LATER)
        rect = CGRectMake(200, -2, 120, 47);
        
        _getCodeBtn.frame = rect;
        
        _getCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        //if (IOS7_OR_LATER)
        [_getCodeBtn setTitleColor:[UIColor colorWithRGBHex:0xa7a7a7]forState:UIControlStateNormal];
        //        else
        //        [_getCodeBtn setTitleColor:[UIColor colorWithRGBHex:0x0b76b2]forState:UIControlStateNormal];
        
        
        [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
        _getCodeBtn.enabled = YES;
        NSString* str = L(@"UCGetVerificationCode");
        [_getCodeBtn setTitle:str forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundColor:[UIColor clearColor]];
        [_getCodeBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}


- (UITextField *)codeTextField{
	
	if(!_codeTextField){
        CGRect rect = CGRectMake(70, 5., 200, 34.);
		//if (IOS7_OR_LATER)
        rect = CGRectMake(27, 5., 160, 34.);
		_codeTextField = [[UITextField alloc] initWithFrame:rect];
		
		_codeTextField.delegate = self;
        
        _codeTextField.font = [UIFont boldSystemFontOfSize:14];
		
		_codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        // 注册 短信验证码 数字键盘
		_codeTextField.keyboardType = UIKeyboardTypeNumberPad;
		
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _codeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _codeTextField.returnKeyType = UIReturnKeyDone;
        
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _codeTextField.enablesReturnKeyAutomatically = YES;
        NSString* str = L(@"UCPleaseEnterVerificationCodeFromMessage");
        //if (IOS7_OR_LATER)
        str = L(@"UCPleaseInputVerificationCode");
        
        _codeTextField.placeholder = str;
        
	}
	
	return _codeTextField;
	
}


- (Calculagraph *)codeTimer
{
    if (!_codeTimer)
    {
        _codeTimer = [[Calculagraph alloc] init];
        
        [_codeTimer addObserver:self
                     forKeyPath:@"time"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    }
    return _codeTimer;
}

-(UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]init];
        float height = 200;
        //if (IOS7_OR_LATER)
        height = 46;
        _footView.frame = CGRectMake(0, 0, 200, height);
        _footView.backgroundColor = [UIColor clearColor];
    }
    return _footView;
}

-(UIButton *)checkBtn
{
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString* str = @"shopcart_checked.png";
        if (IOS7_OR_LATER)
            str = @"checkRegisterYes.png";
        
        [_checkBtn setImage:[UIImage streImageNamed:str]
                   forState:UIControlStateNormal];
        
        
        [_checkBtn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        CGRect rect = CGRectMake(0, 120, 40, 40);
        //if (IOS7_OR_LATER)
        rect = CGRectMake(0, 10, 40, 40);
        
        _checkBtn.frame = rect;
    }
    return _checkBtn ;
}


-(SNProtocolView *)protocolView
{
    if (!_protocolView) {
        
        _protocolView = [[SNProtocolView alloc] init];
        
        _protocolView.frame = [[UIScreen mainScreen] bounds];
        
        _protocolView.hidden = YES;
        
        [self.navigationController.view addSubview:_protocolView];
    }
    return _protocolView;
}

- (keyboardNumberPadReturnTextField *)usernameTextField {
	
	if (!_usernameTextField) {
        CGRect rect = CGRectMake(85, 5., self.tpTableView.width - 28-80., 34.);
		//if (IOS7_OR_LATER)
        rect = CGRectMake(27, 5., self.tpTableView.width - 28-25., 34.);
        
		_usernameTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:rect];
		
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


#pragma mark - 协议方法
-(void)clickMember:(id)sender
{
    self.protocolView.pTitle = L(@"UCSuningEBuyMemberRules");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:L(@"UCSuningEBuyMemberRules") ofType:@"txt"];
    
    NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.protocolView.pValue = shellTitleText;
    [self.protocolView showProtocol];
}

-(void)clickPrice:(id)sender
{
    self.protocolView.pTitle = L(@"UCEfubaoProtocol");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:L(@"UCEfubaoProtocol") ofType:@"txt"];
    
    NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.protocolView.pValue = shellTitleText;
    [self.protocolView showProtocol];
}

-(void)createLabele
{
    UILabel* tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 40, 40)];
    [tempLabel setText:L(@"Agree")];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:15]];
    [self.footView addSubview:tempLabel];
    
    
    OHAttributedLabel *labelMember = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(72, 22, 120, 20)];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:L(@"UCSuningEBuyMemberRules")];
    [attStr setTextColor:[UIColor orange_Light_Color]];
    [attStr setTextIsUnderlined:YES];
    [attStr setFont:[UIFont systemFontOfSize:15]];
    labelMember.attributedText = attStr;
    [labelMember setUserInteractionEnabled:NO];
    [labelMember setBackgroundColor:[UIColor clearColor]];
    [self.footView addSubview:labelMember];
    
    UIButton *memberBt = [[UIButton alloc] initWithFrame:CGRectMake(72, 22, 120, 20)];
    [memberBt setBackgroundColor:[UIColor clearColor]];
    [memberBt addTarget:self action:@selector(clickMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:memberBt];
    
    UILabel* tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(192, 10, 15, 40)];
    [tmpLabel setText:L(@"Constant_And")];
    [tmpLabel setBackgroundColor:[UIColor clearColor]];
    [tmpLabel setFont:[UIFont systemFontOfSize:15]];
    [self.footView addSubview:tmpLabel];
    
    OHAttributedLabel *labelPrice = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(207, 22, 80, 20)];
    NSMutableAttributedString *attStrPrice = [[NSMutableAttributedString alloc] initWithString:L(@"UCEfubaoProtocol")];
    [attStrPrice setTextColor:[UIColor orange_Light_Color]];
    [attStrPrice setTextIsUnderlined:YES];
    [attStrPrice setFont:[UIFont systemFontOfSize:15]];
    labelPrice.attributedText = attStrPrice;
    [labelPrice setUserInteractionEnabled:NO];
    [labelPrice setBackgroundColor:[UIColor clearColor]];
    [self.footView addSubview:labelPrice];
    
    UIButton *PriceBt = [[UIButton alloc] initWithFrame:CGRectMake(207, 22, 80, 20)];
    [PriceBt setBackgroundColor:[UIColor clearColor]];
    [PriceBt addTarget:self action:@selector(clickPrice:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:PriceBt];
    
}

-(JSTwitterCoreTextView *)contentLab{
    
    if (!_contentLab) {
        NSString *font = @"Helvetica";
        CGFloat size = 15.0;
        CGFloat paddingTop = 5.0;
        CGFloat paddingLeft = 0.0;
        _contentLab = [[JSTwitterCoreTextView alloc] init];
        _contentLab.textColor = RGBCOLOR(51, 51, 51);
        NSString* str = L(@"UCIHaveReadSuningEBuyMemberRules");
        
        //if (IOS7_OR_LATER)
        str = L(@"UCAgreeWithSuningEBuyMemberRules");
        
        float height = [JSTwitterCoreTextView measureFrameHeightForText:str
                                                               fontName:font
                                                               fontSize:size
                                                     constrainedToWidth:280
                                                             paddingTop:paddingTop
                                                            paddingLeft:paddingLeft];
        CGRect rect = CGRectMake(40, 120, 280, height);
        //if (IOS7_OR_LATER)
        rect = CGRectMake(40, 10, 280, height);
        
        _contentLab.frame = rect;
        
        [_contentLab setDelegate:self];
        [_contentLab setFontName:font];
        [_contentLab setFontSize:size];
        
        [_contentLab setLinkColor:RGBCOLOR(25, 122, 211)];//RGBCOLOR(255, 102, 0)
        //if (IOS7_OR_LATER)
        [_contentLab setLinkColor:[UIColor orange_Light_Color]];
        
        [_contentLab setHighlightColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
        [_contentLab setBackgroundColor:[UIColor clearColor]];
        [_contentLab setPaddingTop:paddingTop];
        [_contentLab setPaddingLeft:paddingLeft];
        
        [_contentLab setText:str];////
        [self.footView addSubview:_contentLab];
    }
    
    return _contentLab;
    
}

-(void)clickButton
{
    
    if (isClick == YES) {
        
        NSString* str = @"shopcart_checked.png";
        //if (IOS7_OR_LATER)
        str = @"checkRegisterYes.png";
        
        self.checkBtn.selected = YES;
        [self.checkBtn setImage:[UIImage streImageNamed:str]
                       forState:UIControlStateNormal];
        isClick = NO;
    }else{
        self.checkBtn.selected = NO;
        NSString* str = @"shopcart_uncheck.png";
        if (IOS7_OR_LATER)
            str = @"checkRegisterNo.png";
        
        [self.checkBtn setImage:[UIImage streImageNamed:str]
                       forState:UIControlStateNormal];
        isClick =YES;
        [self presentSheet:L(@"UCPleaseReadProtocol")];
    }
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
            [self.codeTimer stop];
            //if (IOS7_OR_LATER)
            {
                [_getCodeBtn setTitleColor:[UIColor orange_Light_Color]forState:UIControlStateNormal];
                [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
            }
            
            [self.getCodeBtn setTitle:L(@"Send_again") forState:UIControlStateNormal];
            self.getCodeBtn.enabled = YES;
        }else{
            //if (IOS7_OR_LATER)
            {
                [_getCodeBtn setTitleColor:[UIColor colorWithRGBHex:0xa7a7a7]forState:UIControlStateNormal];
                [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateNormal];
            }
            
            [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"UCSendAgain"),time] forState:UIControlStateNormal];
            
            
        }
    }
}
#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 16;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return self.footView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 46;
    }
    return 0;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *ddFindKeyCellIdentifier = @"ddFindKeyCellIdentifier";
    
    SNUITableViewCell *cell = (SNUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ddFindKeyCellIdentifier];
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ddFindKeyCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                
                //                cell.backgroundView.backgroundColor = [UIColor whiteColor];
                //                _passwdToggleView = [[PasswordToggleView alloc] init];
                //                [_passwdToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];
                
            }
        }
        
    }
	
	if (indexPath.section == 0)
    {
		if (indexPath.row == 0)
        {
            //            if (!IOS7_OR_LATER)
            //			cell.textLabel.text = @"手机号码";
            
			[cell.contentView addSubview:self.usernameTextField];
		}
	}else if (indexPath.section == 1)
    {
        //        _passwdToggleView.left = self.passwordTextField.right+5;
        //        _passwdToggleView.top = 10;
        //        [cell.contentView addSubview:_passwdToggleView];
        //        [cell.contentView addSubview:self.passwordTextField];
        [cell.contentView addSubview:self.getCodeBtn];
        //    else
        //    cell.textLabel.text = @"验证码";
        
        [cell.contentView addSubview:self.codeTextField];
        
    }
    return cell;
}

#pragma mark -
#pragma mark text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.usernameTextField) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030202"]];
    }else if (textField == self.passwordTextField) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030204"]];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.usernameTextField)
    {
        // Move input focus to the password field.
        [self.usernameTextField resignFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self.passwordTextField resignFirstResponder];
    }
    else{
        // Simulate clicking the Submit button.
        [self registerAction:nil];
    }
    
    return NO;
}

//手机号码长度不超过11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
    else if (textField == self.passwordTextField)
    {
        if ([string length] != [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding])
        {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - JSCoreTextViewDelegate
-(void)chooseTouchText:(NSString*)str
{
    
    if ([str isEqualToString:L(@"UCSuningEBuyMemberRules2")]) {
        
        self.protocolView.pTitle = L(@"UCSuningEBuyMemberRules");
        
        NSString *path = [[NSBundle mainBundle] pathForResource:L(@"UCSuningEBuyMemberRules") ofType:@"txt"];
        
        NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.protocolView.pValue = shellTitleText;
        
    }
    else if ([str isEqualToString:L(@"UCEfubaoProtocol2")]) {
        
        self.protocolView.pTitle = L(@"UCEfubaoProtocol");
        
        NSString *path = [[NSBundle mainBundle] pathForResource:L(@"UCEfubaoProtocol") ofType:@"txt"];
        
        NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.protocolView.pValue = shellTitleText;
        
    }
    else if ([str isEqualToString:L(@"UCSuningAdvertisingAllianceOnlineProtocol2")]) {
        
        self.protocolView.pTitle = L(@"UCSuningAdvertisingAllianceOnlineProtocol");
        
        NSString *path = [[NSBundle mainBundle] pathForResource:L(@"UCSuningAdvertisingAllianceOnlineProtocol") ofType:@"txt"];
        
        NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.protocolView.pValue = shellTitleText;
        
        
        
    }
    [self.protocolView showProtocol];
    
    
}


@end
