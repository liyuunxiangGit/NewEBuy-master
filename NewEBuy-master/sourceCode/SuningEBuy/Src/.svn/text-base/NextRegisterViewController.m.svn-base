//
//  NextRegisterViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NextRegisterViewController.h"
#import "ValidationService.h"
#import "RegistHandselCouponCommand.h"
#import "SNSwitch.h"
#import "PasswordVerifyUtil.h"

@interface NextRegisterViewController ()

@end

@implementation NextRegisterViewController

@synthesize registerDto                         = _registerDto;
@synthesize registerService                     = _registerService;

- (void)dealloc
{
    
    SERVICE_RELEASE_SAFELY(_registerService);
    TT_RELEASE_SAFELY(_registerDto);
    
    
}

- (void)backForePage {
    [super backForePage];
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030203"]];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"UCSetPassword");
        self.pageTitle = L(@"member_loginAndRegister_register");
        
        if (!_registerDto) {
            _registerDto = [[UserRegisterDTO alloc] init];
        }
        
        //        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"注册并登录"
        //                                                                  style:UIBarButtonItemStylePlain
        //                                                                 target:self
        //                                                                 action:@selector(registerAction:)];
        //        self.navigationItem.rightBarButtonItem = right;
        //        [right release];
        //if (IOS7_OR_LATER)
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTFinish")];
        //        else
        //        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"注册并登录"];
        
        
    }
    return self;
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

- (void)righBarClick
{
    [self registerAction:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.checkBtn.selected = YES;
    //if (IOS7_OR_LATER)
    [self createLabele];
    
    [self.passwordTextField becomeFirstResponder];
    //    else
    //    {
    //        self.navigationItem.rightBarButtonItem = nil;
    //
    //
    //        [self contentLab];
    //    }
    
    //    [self.codeTimer start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

- (void)registerAction:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030304"]];
    
    if (!_checkBtn.selected)
    {
        [self presentSheet:L(@"UCSelectProtocolButton") posY:50];
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
    
    [self.passwordTextField resignFirstResponder];
    [self displayOverFlowActivityView];
    
    [self.registerService beginUserRegisterWithUsername:self.registerDto.registerId password:password];
    
    
}

- (void)loadView
{
    [super loadView];
    
    
    //    if (!IOS7_OR_LATER)
    //    {
    //        [self.footView addSubview:self.getCodeBtn];
    //        [self.footView addSubview:self.tipsLabel];
    //        [self.footView addSubview:self.registBtn];
    //    }
    
    
    [self.footView addSubview:self.checkBtn];
    //if (IOS7_OR_LATER)
    self.tpTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 44);
    
    self.tpTableView.scrollEnabled = NO;
    
    //    else
    //    self.tpTableView.frame = CGRectMake(0, 15, 320, self.view.bounds.size.height - 44);
    [self.view addSubview:self.tpTableView];
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

- (UITextField *)passwordTextField{
	
	if(!_passwordTextField){
		
        CGRect rect = CGRectMake(85, 5., self.tpTableView.width - 28-80., 34.);
        //if (IOS7_OR_LATER)
        rect = CGRectMake(27, 5., self.tpTableView.width - 28-80, 34.);
        
		_passwordTextField = [[UITextField alloc] initWithFrame:rect];
		
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


- (void)userRegisterCompletedWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:REGISTE_OK_MESSAGE object:nil];
        if (![SNSwitch isPassportLogin])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_MESSAGE object:nil];
        }
        [self dismissModalViewControllerAnimated:NO];
    }else
    {
        [self presentSheet:IsStrEmpty(errorMsg)?kHttpResponseJSONValueFailError:errorMsg];
    }
}

- (void)validateRegisterCompletedWithResult:(BOOL)successfulRegist errorCode:(NSString *)errorCode userInfo:(UserInfoDTO *)userInfo{
    [self removeOverFlowActivityView];
    if (successfulRegist) {
        [self dismissModalViewControllerAnimated:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:REGISTE_OK_MESSAGE object:nil];
        if (![SNSwitch isPassportLogin])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_MESSAGE object:nil];
        }
        
        [[UserCenter defaultCenter] sendCouponAfterRegistForUser:userInfo.userId];
        
    }else
    {
        [self presentSheet:IsStrEmpty(errorCode)?kHttpResponseJSONValueFailError:errorCode];
    }
}


#pragma mark init view


- (UserNewRegisterService *)registerService
{
    if (!_registerService) {
        _registerService = [[UserNewRegisterService alloc] init];
        _registerService.delegate = self;
    }
    return _registerService;
}

#pragma mark -
#pragma mark password change state
- (void)changePasswordShowState
{
    self.passwordTextField.secureTextEntry = !_passwdToggleView.isShowWords;
    [self.passwordTextField resignFirstResponder];
}

#pragma mark -
#pragma mark tableView delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //if (IOS7_OR_LATER)
    {
        UIView* v = [[UIView alloc] init];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(95, 20, 150, 15)];
        label.font = [UIFont systemFontOfSize:16.0];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[NSString stringWithFormat:@"%@:%@",L(@"account"),self.registerDto.registerId]];
        [v addSubview:label];
        return v;
    }
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 55;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 46;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (IOS7_OR_LATER)
    return 39;
    //    else
    //    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *registerIdentifier = @"registerIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:registerIdentifier];
    
    if(cell == nil){
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:registerIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //if (IOS7_OR_LATER)
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        //        else
        //        {
        //            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_background_image.png"]];
        //            image.frame = cell.frame;
        //            image.backgroundColor = [UIColor clearColor];
        //            cell.backgroundView = image;
        //
        //            cell.backgroundColor = [UIColor clearColor];
        //            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        //            cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        //        }
        
        
    }
    
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    _passwdToggleView = [[PasswordToggleView alloc] init];
    [_passwdToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];
    _passwdToggleView.left = self.passwordTextField.right+5;
    _passwdToggleView.top = 10;
    [cell.contentView addSubview:_passwdToggleView];
    [cell.contentView addSubview:self.passwordTextField];
    //if (IOS7_OR_LATER)
    //    [cell.contentView addSubview:self.getCodeBtn];
    //    else
    //    cell.textLabel.text = @"验证码";
    
    //    [cell.contentView addSubview:self.codeTextField];
    
    return cell;
}

#pragma mark -
#pragma mark textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.passwordTextField) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030302"]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if (textField == self.codeTextField) {
    //        //        if (self.codeTextField.text.length >= 4 && range.location >= 4)
    //        //        {
    //        //            return NO;
    //        //        }
    //    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    if (textField == self.codeTextField) {
    //        [self registerAction:nil];
    //    }
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
