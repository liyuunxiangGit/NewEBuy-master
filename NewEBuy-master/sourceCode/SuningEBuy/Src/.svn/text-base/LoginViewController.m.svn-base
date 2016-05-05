//
//  LoginViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LoginViewController.h"
#import "NewRegisterViewController.h"
//#import "RegisterViewController.h"
#import "RetrievePasswordViewController.h"
#import "AuthManagerNavViewController.h"
#import "AccountValidateViewController.h"
#import "AppDelegate.h"
#import "UserCenter.h"
#import "LoginCouponCommand.h"
#import "SNCache.h"
#import "FindpFirstViewController.h"
#import "AccountMergerViewController.h"
#import "UITableViewCell+BgView.h"
#import "DataValidate.h"
#import "SFHFKeychainUtils.h"
#import "MyEbuyViewController.h"
//#import "TabMoreController.h"
//#import "RegisterFirstViewController.h"
#import "SNSwitch.h"
#import "ProductDetailViewController.h"
#import "NearbySuningMainViewController.h"
@interface LoginViewController()
{
    NSArray *_dataSourceArray;
    BOOL isFromRegist;
}

@property (nonatomic, strong) UIView *registerBtnView;

- (void)userRegister:(id)sender;

- (void)forgetPwdAction:(id)sender;
@end

/*********************************************************************/

@implementation LoginViewController

@synthesize service = _service;

@synthesize nextNavigationController = _nextNavigationController;
@synthesize nextController = _nextController;

@synthesize loginDelegate = _loginDelegate;
@synthesize loginDidOkSelector = _loginDidOkSelector;
@synthesize loginDidCancelSelector = _loginDidCancelSelector;

@synthesize loginHistoryView = _loginHistoryView;
@synthesize vipLable = _vipLable;
@synthesize vipLable1 = _vipLable1;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_loginHistoryView);
    SERVICE_RELEASE_SAFELY(_service);
    SERVICE_RELEASE_SAFELY(_checkNeedVerifyCodeService);
    TT_RELEASE_SAFELY(_loginView);
    
    _loginView.owner = nil;
    _loginView.tpTableView.delegate = nil;
    _loginView.tpTableView.dataSource = nil;
    
    TT_RELEASE_SAFELY(_nextNavigationController);
    TT_RELEASE_SAFELY(_nextController);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)backForePage {
    [super backForePage];
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030108"]];
}

- (id)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = NO;
        self.title = L(@"User Login");
        self.pageTitle = L(@"member_loginAndRegister_login");
        self.bSupportPanUI = NO;
        isFromRegist = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshUserName:)
                                                     name:POPUP_MESSAGE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(registerOKAction)
                                                     name:REGISTE_OK_MESSAGE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(findPasswordSuccess)
                                                     name:Find_Password_Success object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(goToLoginAction)
                                                     name:MERGE_SUCCESS_ACTION object:nil];
        
    }
    return self;
}

- (void)registerOKAction
{
    self.externAccount = nil;
    
    isFromRegist = YES;
    NSString *password;
    NSString *passwd;
    
    _loginView.usernameTextField.text = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey
                                                                   andServiceName:kSNKeychainServiceNameSuffix
                                                                            error:nil];//[Config currentConfig].username;
    
    passwd = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginPasswdKey
                                        andServiceName:kSNKeychainServiceNameSuffix
                                                 error:nil];
    password = [PasswdUtil decryptString:passwd
                                  forKey:kLoginPasswdParamEncodeKey
                                    salt:kPBEDefaultSalt];
    
    _loginView.passwordTextField.text = password;//[Config currentConfig].password;
    
    [self submit:nil];
}

- (void)goToLoginAction
{
    self.externAccount = nil;
    
    NSString *password;
    NSString *passwd;
    
    _loginView.usernameTextField.text = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey
                                                                   andServiceName:kSNKeychainServiceNameSuffix
                                                                            error:nil];//[Config currentConfig].username;
    
    
    passwd = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginPasswdKey
                                        andServiceName:kSNKeychainServiceNameSuffix
                                                 error:nil];
    password = [PasswdUtil decryptString:passwd
                                  forKey:kLoginPasswdParamEncodeKey
                                    salt:kPBEDefaultSalt];
    _loginView.passwordTextField.text = password;//[Config currentConfig].password;
    
    [self submit:nil];
}

- (void)findPasswordSuccess
{
    [self presentSheet:L(@"UCResetPasswordSuccess")];
}


- (void)refreshUserName:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification object];
    
    _loginView.usernameTextField.text = [userInfo objectForKey:@"username"];
    
    _loginView.passwordTextField.text = [userInfo objectForKey:@"password"];
    
}

- (void)registerOKHeadler
{
    //数据收集
    [[SuningMainClick sharedInstance] loginInApp];
    
    [self saveLoginIdList];
    
    LoginCouponCommand *manage =
    [[LoginCouponCommand alloc] initWithUserId:[UserCenter defaultCenter].userInfoDTO.userId];
    [CommandManage excuteCommand:manage completeBlock:nil];
    
    if(_nextController && _nextNavigationController)
    {
        [_nextNavigationController pushViewController:self.nextController animated:YES];
    }
    
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:self.loginDidOkSelector]) {
        SuppressPerformSelectorLeakWarning
        ([self.loginDelegate performSelector:self.loginDidOkSelector]);
    }
    
    if (_loginOkBlock) {
        _loginOkBlock();
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    _loginView = [[LoginView alloc] initWithOwner:self];
    [_loginView.loginHistoryBtn addTarget:self action:@selector(loginHistoryAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.loginButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerButton addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.view = _loginView;
    
    SNUIBarButtonItem *cancelButton = [SNUIBarButtonItem itemWithTitle:nil
                                                                 Style:SNNavItemStyleBack
                                                                target:self
                                                                action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;

//    SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:@"登录"
//                                                                 Style:SNNavItemStyleDone
//                                                                target:self
//                                                                action:@selector(submit:)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    //added by gyj 251去掉明文密文转换功能
//    [_loginView.passwdToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];
    
    [self reloadTableView];
}

- (void)changePasswordShowState
{
    _loginView.passwordTextField.secureTextEntry = !_loginView.passwdToggleView.isShowWords;
    if (!IOS7_OR_LATER) {
        [_loginView.passwordTextField resignFirstResponder];
    }
}

- (LoginHistoryView *)loginHistoryView
{
    if (!_loginHistoryView) {
        _loginHistoryView = [[LoginHistoryView alloc] init];//WithFrame:CGRectMake(153, 50, 160, 44*[[self getLoginIdList] count])];
        _loginHistoryView.frame = self.view.bounds;
        _loginHistoryView.delegate = self;
    }
    return _loginHistoryView;
}

-(UILabel *)vipLable
{
    if (!_vipLable) {
        _vipLable = [[UILabel alloc]init];
        _vipLable.frame = CGRectMake(20, 6, 150, 20);
        _vipLable.backgroundColor = [UIColor clearColor];
        _vipLable.text = L(@"UCStoreMemberFirstLogin");
        _vipLable.textColor = [UIColor colorWithRGBHex:0x313131];
        _vipLable.font = [UIFont systemFontOfSize:14.0f];
    }
    return _vipLable;
}

-(UILabel *)vipLable1
{
    if (!_vipLable1) {
        _vipLable1 = [[UILabel alloc]init];
        _vipLable1.frame = CGRectMake(20, 28, 250, 20);
        _vipLable1.backgroundColor = [UIColor clearColor];
        _vipLable1.text = L(@"UCHoldSuningOrLaoxMemberCard");
        _vipLable1.textColor = [UIColor colorWithRGBHex:0xc9c9c9];
        _vipLable1.font = [UIFont systemFontOfSize:13.0f];
    }
    return _vipLable1;
}

- (UIView *)registerBtnView
{
    if (!_registerBtnView) {
        _registerBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
//        OHAttributedLabel *label1 = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(25, 25, 70, 20)];
//        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"快速注册"];
//        [attStr setTextColor:RGBCOLOR(102, 102, 102)];
//        [attStr setTextIsUnderlined:YES];
//        [attStr setFont:[UIFont systemFontOfSize:16]];
//        label1.attributedText = attStr;
//        [label1 setUserInteractionEnabled:NO];
//        [label1 setBackgroundColor:[UIColor clearColor]];
//        [_registerBtnView addSubview:label1];
//        
//        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn1.backgroundColor = [UIColor clearColor];
//        btn1.frame = CGRectInset(label1.frame, 0, -10);
//        [btn1 addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
//        [_registerBtnView addSubview:btn1];
        
        OHAttributedLabel *label2 = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(225, 115, 75, 20)];
        NSMutableAttributedString *attStr1 = [[NSMutableAttributedString alloc] initWithString:L(@"Forget Password")];
        [attStr1 setTextColor:RGBCOLOR(102, 102, 102)];
        [attStr1 setTextIsUnderlined:YES];
        [attStr1 setFont:[UIFont systemFontOfSize:16]];
        [attStr1 setTextAlignment:kCTTextAlignmentRight lineBreakMode:kCTLineBreakByWordWrapping];
        label2.attributedText = attStr1;
        [label2 setUserInteractionEnabled:NO];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [_registerBtnView addSubview:label2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.backgroundColor = [UIColor clearColor];
        btn2.frame = CGRectInset(label2.frame, 0, -10);
        [btn2 addTarget:self action:@selector(goToFindPassword) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtnView addSubview:btn2];
        
        _loginView.loginButton.frame = CGRectMake(15, 15, 290, 35);
        [_loginView.loginButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        [_loginView.loginButton setBackgroundImage:[UIImage imageNamed:@"登陆-button.png"] forState:UIControlStateNormal];
        [_loginView.loginButton setBackgroundImage:[UIImage imageNamed:@"登陆-button-pressed.png"] forState:UIControlStateHighlighted];
        [_registerBtnView addSubview:_loginView.loginButton];
        
        _loginView.registerButton.frame = CGRectMake(15, 65, 290, 35);
        [_loginView.registerButton setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
        [_loginView.registerButton setBackgroundImage:[UIImage imageNamed:@"登陆-注册-button.png"] forState:UIControlStateNormal];
        [_loginView.registerButton setBackgroundImage:[UIImage imageNamed:@"登陆-注册-button-pressed.png"] forState:UIControlStateHighlighted];
        [_registerBtnView addSubview:_loginView.registerButton];
    }
    return _registerBtnView;
}

- (void)loginHistoryAction
{
    if (_loginView.loginHistoryBtn.selected) {
        self.loginHistoryView.hidden = YES;
        _loginView.tpTableView.scrollEnabled = YES;
    }else{
        [_loginView.usernameTextField resignFirstResponder];
        [_loginView.passwordTextField resignFirstResponder];
        if (self.loginHistoryView.superview == nil) {
            [_loginView addSubview:self.loginHistoryView];
            [self.loginHistoryView bringSubviewToFront:self.tableView];
        }
        _loginView.tpTableView.scrollEnabled = NO;
        [self.loginHistoryView refreshNum:[self getLoginIdList]];
        self.loginHistoryView.hidden = NO;
    }
    _loginView.loginHistoryBtn.selected = !_loginView.loginHistoryBtn.selected;
    
    if (_loginView.loginHistoryBtn.selected) {
        _loginView.loginHistoryImg.image = [UIImage imageNamed:@"login_history_up_btn.png"];
    }else{
        _loginView.loginHistoryImg.image = [UIImage imageNamed:@"login_history_down_btn.png"];
    }
}


- (void)didSelectLoginNum:(NSString *)loginNum
{
    if (!IsStrEmpty(loginNum)) {
        _loginView.usernameTextField.text = loginNum;
    }
    [self loginHistoryAction];
    _loginView.passwordTextField.text = nil;
}

//- (void)rightBarClickAction
//{
//    [self submit:nil];
//}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
    if (nil != _externAccount) {
        _loginView.usernameTextField.text = _externAccount;
        _loginView.passwordTextField.text = nil;
    }else {
        
        NSString *username = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];//[Config currentConfig].username;
        NSString *password;
        NSString *passwd;
        passwd = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginPasswdKey
                                            andServiceName:kSNKeychainServiceNameSuffix
                                                     error:nil];//[Config currentConfig].password;//[NSString decryptUseDES:[Config currentConfig].password key:kPasswordEncryptKey];
        
        password = [PasswdUtil decryptString:passwd
                                      forKey:kLoginPasswdParamEncodeKey
                                        salt:kPBEDefaultSalt];
        
        _loginView.usernameTextField.text = username;
        //_loginView.passwordTextField.text = @"";
        _loginView.passwordTextField.text = password;
        
        //        if (!NotNilAndNull(username))
        //        {
        //            [_loginView.passwordTextField becomeFirstResponder];
        //        }
        //        else
        //        {
        [_loginView.usernameTextField becomeFirstResponder];
        //        }
        
        NSString *failedLoginUsername = [[NSUserDefaults standardUserDefaults] stringForKey:@"needVerifyCode"];
        if ([failedLoginUsername isEqualToString:username])
        {
            /**
             *  添加非等于判断，提升用户体验
             *  @author liukun
             *  @date  2014/7/9
             *  @since 2.4.1
             
             */
            if (bNeedVerifyCode != YES) {
                bNeedVerifyCode = YES;
                [self refreshTable];
            }
        }
    }
}


#pragma mark -
#pragma mark action

- (void)submit:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030103"]];
    
    [Config currentConfig].savePassword = [NSNumber numberWithBool:YES];//记住密码
    
    NSString *username = _loginView.usernameTextField.text;
	
	NSString *errMessage = nil;
	
    if (!username || [username isEmptyOrWhitespace])
    {
        [_loginView.usernameTextField becomeFirstResponder];
		errMessage = kLoginStatusMessageRequireUserName;
		[self presentSheet:errMessage posY:30];
        return;
	}
    
    NSString *password = [_loginView.passwordTextField.text trim];
	
    if (!password || [password isEmptyOrWhitespace])
    {
        [_loginView.passwordTextField becomeFirstResponder];
        if ([DataValidate validateCard:username]) {
            errMessage = L(@"UCStoreMemberCardLogin");
        }else{
            errMessage = L(@"UCPleaseEnterEBuyAccountPassword");
        }
		[self presentSheet:errMessage posY:30];
        return;
	}
    
    if (password.length > 20 || password.length < 6)
    {
        [_loginView.passwordTextField becomeFirstResponder];
        if ([DataValidate validateCard:username]) {
            errMessage = L(@"UCStoreMemberCardLogin");
        }else{
            errMessage = L(@"UCPleaseEnter6-20EBuyAccountPassword");
        }
		[self presentSheet:errMessage posY:30];
        return;
    }
    
    
    [_loginView.usernameTextField resignFirstResponder];
    [_loginView.passwordTextField resignFirstResponder];
    
    
    if ([SNSwitch isPassportLogin])
    {
        if (!bNeedVerifyCode)
        {
            [self displayOverFlowActivityView:kLoginStatusMessageStartHttp yOffset:-80.0f];
            self.navigationItem.rightBarButtonItem.enabled = NO;
            [self.service beginLoginWithUsername:username password:password verifyCode:nil];
        }
        else
        {
            [_loginView.verifyCodeTextField resignFirstResponder];
            NSString *verifyCode = _loginView.verifyCodeTextField.text.trim;
            if (!verifyCode || [verifyCode isEmptyOrWhitespace])
            {
                errMessage = kLoginStatusMessageRequirevalidateCode;
                [self presentSheet:errMessage posY:30];
                return;
            }
            
            [self displayOverFlowActivityView:kLoginStatusMessageStartHttp yOffset:-80.0f];
            self.navigationItem.rightBarButtonItem.enabled = NO;
            
            [self.service beginLoginWithUsername:username password:password verifyCode:verifyCode];
        }
    }
    else
    {
        [self displayOverFlowActivityView:kLoginStatusMessageStartHttp yOffset:-80.0f];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self.service beginLoginWithUsername:username password:password];
    }
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (_loginDelegate && [_loginDelegate respondsToSelector:_loginDidCancelSelector]) {
        SuppressPerformSelectorLeakWarning
        ([_loginDelegate performSelector:_loginDidCancelSelector]);
    }
    
    if (_loginCancelBlock) {
        _loginCancelBlock();
    }
}

#pragma mark -
#pragma mark service method

- (UserLoginService *)service
{
    if (!_service) {
        _service = [[UserLoginService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

// xzoscar 2014-07-22 add 回调 区分错误码和错误描述
// 登录 返回
- (void)userLoginCompletedWithResult:(BOOL)successfulLogin
                           errorCode:(NSString *)errorCode
                           errorDesc:(NSString *)errorDesc {
    
    [self removeOverFlowActivityView];
    
    if (successfulLogin) { // {{{ --- --- --- --- --- --- --- --- --- ---
        
        [self saveLoginIdList];
        
        if (YES == isFromRegist) {
            isFromRegist = NO;
            [[UserCenter defaultCenter] sendCouponAfterRegistForUser:[UserCenter defaultCenter].userInfoDTO.userId];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_MESSAGE object:nil userInfo:self.context];
        
        [self dismissViewControllerAnimated:YES completion:^{
            if (nil != _dismissViewControllerComplete) {
                _dismissViewControllerComplete();
            }

            if (self.callBackAfterDismissed && _loginOkBlock) {
                _loginOkBlock();
            }
        }];
        
        //
        if(_nextController && _nextNavigationController) {
            if (nil != self.externAccount
                && ![self.externAccount isEqualToString:[UserCenter defaultCenter].userInfoDTO.logonId]) {
                // 提示
                TabBarController *tabBarCtrler = APP_DELEGATE.tabBarViewController;
                UINavigationController *navCtrler = (UINavigationController *)tabBarCtrler.selectedViewController;
                CommonViewController *ctrler = (CommonViewController *)navCtrler.topViewController;
                [ctrler presentSheet:L(@"UCLoggedUserNotConsistent")];
                
            }else {
                [_nextNavigationController pushViewController:self.nextController animated:YES];
            }
        }
        if (_isMyEbuy&&[self.loginDelegate isKindOfClass:[MyEbuyViewController class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:EFUBAO_MESSAGE
                                                                object:nil];
        }
        if (_isConsultation&&[self.loginDelegate isKindOfClass:[ProductDetailViewController class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CONSULTATION
                                                                object:nil];
        }
        if (_isNearBySuning&&[self.loginDelegate isKindOfClass:[NearbySuningMainViewController class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NEARBYSUNING
                                                                object:nil];
        }
        
        //
        if (self.loginDelegate && [self.loginDelegate respondsToSelector:self.loginDidOkSelector]) {
            SuppressPerformSelectorLeakWarning
            ([self.loginDelegate performSelector:self.loginDidOkSelector]);
        }
        
        if (!self.callBackAfterDismissed && _loginOkBlock) {
            _loginOkBlock();
        }
        
        NSString *currUserId = [UserCenter defaultCenter].userInfoDTO.userId;
        NSString *lastUserId = [UserCenter defaultCenter].lastUserId;
        BOOL bUserChange = (nil != lastUserId) &&
        ((![currUserId isEqualToString:lastUserId]) || (![currUserId isEqualToString:_externAccount]));
        
        if (bUserChange) {
            for (UINavigationController *nav in [self.appDelegate.tabBarViewController viewControllers]) {
                [nav popToRootViewControllerAnimated:NO];
            }
            [UserCenter defaultCenter].lastUserId = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_USER_CHANGE_MESSAGE
                                                                object:nil];
        }
        
    } //  --- --- --- --- --- --- --- --- --- --- }}}
    else { // {{{ --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        
        // xzoscar 2014-07-27 11:00 add (线下会员融合 页面跳转)
        if (nil != errorCode) {
            if ([errorCode isEqualToString:@"CARD_PASSWORD_INITIAL"]) {
                // 线下账号 且是初始密码
                /* 调用接口查询 该线下会员账号 是否预留手机号码?ßßß
                 有手机号码，跳转至 手机验证 页面；无手机号码 提示“账号未完善手机，请去门店完善手机号”
                 */
                // todo
                
            }else if ([errorCode isEqualToString:@"CARD_PASSWORD_VERIFY_FAILED"]) {
                // 线下账号校验不通过，且非初始密码
                // 看是否有手机号码
                // todo
                
            }else if ([errorCode isEqualToString:@"CARD_PASSWORD_VERIFY_SUCCESS"]) {
                // 线下账号校验通过，且非初始密码，跳转至 “完善密码” 页面
            }
        }
        
        if ([SNSwitch isPassportLogin]) { // YES
            /**
             *  添加非等于判断，提升用户体验
             *  @author liukun
             *  @date  2014/7/9
             *  @since 2.4.1
             
             蔡礼龙提了bug，因此登录失败每次都刷 by chupeng 2014-10-20
             */
//            if (bNeedVerifyCode != _service.bNeedverifyCode) {
//                
//                
//                
//                
//            }
            bNeedVerifyCode = _service.bNeedverifyCode;
            [self refreshTable];
        }
        
        //服务器返回needVerifyCode=true错误时，不显示提示框 by chupeng 2014-4-21
        if ([errorCode isEqualToString:L(@"LOGIN_ERROR_needVerifyCode")]) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
            return;
        }
        
		[self presentSheet:errorDesc posY:30];
    } // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- }}}
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (CheckNeedVerifyCodeService *)checkNeedVerifyCodeService
{
    if (!_checkNeedVerifyCodeService)
    {
        _checkNeedVerifyCodeService = [[CheckNeedVerifyCodeService alloc] init];
        _checkNeedVerifyCodeService.delegate = self;
    }
    return _checkNeedVerifyCodeService;
}

- (void)CheckNeedVerifyCodeCompletedWithResult:(BOOL)needVerify
{
    /**
     *  添加非等于判断，提升用户体验
     *  @author liukun
     *  @date  2014/7/9
     *  @since 2.4.1
     */
    if (bNeedVerifyCode != needVerify) {
        bNeedVerifyCode = needVerify;
        
        [self refreshTable];
    }

}

- (void)refreshTable
{
    [self reloadTableView];

    if (bNeedVerifyCode)
        [_loginView refreshVerifycode:nil];
}

#pragma mark -
#pragma mark text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == _loginView.usernameTextField)
    {
        [_loginView.matchedAccView setText:nil];
        
        // Move input focus to the password field.
        [_loginView.passwordTextField becomeFirstResponder];
    }
    else
    {
        // Simulate clicking the Submit button.
        [self submit:nil];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _loginView.usernameTextField)
    {
        if ([SNSwitch isPassportLogin]) //passport登录，用户名输入完成后验证用户名，看是否需要验证码
        {
//            NSString *username = _loginView.usernameTextField.text;
//            
//            NSString *errMessage = nil;
//            
//            if (!username || [username isEmptyOrWhitespace])
//            {
//                //[_loginView.usernameTextField becomeFirstResponder];
//                errMessage = kLoginStatusMessageRequireUserName;
//                [self presentSheet:errMessage posY:30];
//                return;
//            }
            if (_loginView.usernameTextField.text.length > 0)
            {
                [self.checkNeedVerifyCodeService beginCheckNeedVerifyCode:_loginView.usernameTextField.text];
            }
            
        }
    }
}

#pragma mark ----------------------------- tableview reload

- (void)reloadTableView
{
    [self prepareTableViewDatasource];
    [_loginView.tpTableView reloadData];
}

- (void)prepareTableViewDatasource
{
    NSMutableArray *array = [NSMutableArray array];
    
    //用户名密码section
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        
        //用户名行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Username_Cell",
                                      kTableViewCellHeightKey : @40};
            [cellList addObject:cellDic];
        }
        
        //密码行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Password_Cell",
                                      kTableViewCellHeightKey : @40};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@15 forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionHeaderTypeKey];
        
        [array addObject:dic];
    }
    
    //验证码
    if (bNeedVerifyCode)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSMutableArray *cellList = [NSMutableArray array];
        
        //添加优惠券行
        NSDictionary *cellDic = @{
                                  kTableViewCellTypeKey: @"Verify_Cell",
                                  kTableViewCellHeightKey : @50.f};
        [cellList addObject:cellDic];
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@15 forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionHeaderTypeKey];
        
        [array addObject:dic];
    }
    
    //门店会员融合入口
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSMutableArray *cellList = [NSMutableArray array];
        
        //会员融合行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"AccountMerge_Cell",
                                      kTableViewCellHeightKey : @56.};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@160.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@"Register_View" forKey:kTableViewSectionHeaderTypeKey];
        
        [array addObject:dic];
    }
    
    _dataSourceArray = array;
}


#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionHeaderHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    NSString *type = [sectionDic objectForKey:kTableViewSectionHeaderTypeKey];
    
    if ([type isEqualToString:@"Empty_View"])
    {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
    else if ([type isEqualToString:@"Register_View"])
    {
        return self.registerBtnView;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    if ([cellType isEqualToString:@"Username_Cell"])
    {
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *vIcon = [[UIImageView alloc] initWithFrame:CGRectMake(25, 13, 12.5, 13.5)];
            vIcon.tag = 101;
            [cell.contentView addSubview:vIcon];
            
            UIImage *imageUserIcon = [UIImage imageNamed:@"login_user_normal.png"];
            vIcon.image = imageUserIcon;
            
            //输入框
            [cell.contentView addSubview:_loginView.usernameTextField];
            
            //icon与输入框分隔线
            UIImageView *line = [[UIImageView alloc] init];
            line.frame = CGRectMake(52, 10, 0.5, 20);
            line.image = [UIImage imageNamed:@"segment_vertical_line.png"];
            [cell.contentView addSubview:line];
            
            UIImageView *segLine = [[UIImageView alloc] init];
            segLine.frame = CGRectMake(15, 39, 305, 1);
            segLine.image = [UIImage imageNamed:@"登陆-输入框分割线"];
            [cell.contentView addSubview:segLine];
            
            UIImageView *topLine = [[UIImageView alloc] init];
            topLine.frame = CGRectMake(0, 0, 320, 0.5);
            topLine.image = [UIImage imageNamed:@"登陆-输入框分割线"];
            [cell.contentView addSubview:topLine];

        }
        
        if (!IsArrEmpty([self getLoginIdList]))
        {
            [cell.contentView addSubview:_loginView.loginHistoryBtn];
        }
        else
        {
            [_loginView.loginHistoryBtn removeFromSuperview];
        }
        
        return cell;
    }
    else if ([cellType isEqualToString:@"Password_Cell"])
    {
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *vIcon = [[UIImageView alloc] initWithFrame:CGRectMake(25, 12.5, 13, 15)];
            vIcon.tag = 101;
            [cell.contentView addSubview:vIcon];
            
            //密码图标
            UIImage *imageUserIcon = [UIImage streImageNamed:@"login_password_icon.png"];
            vIcon.image = imageUserIcon;
            
            //输入框
            [cell.contentView addSubview:_loginView.passwordTextField];
            
            //added by gyj  251去掉明文密文转换功能
//            _loginView.passwdToggleView.left = _loginView.passwordTextField.right+5;
//            _loginView.passwdToggleView.top = 10;
//            [cell.contentView addSubview:_loginView.passwdToggleView];
            
            //icon与输入框分隔线
            UIImageView *line = [[UIImageView alloc] init];
            line.frame = CGRectMake(52, 10, 0.5, 20);
            line.image = [UIImage imageNamed:@"segment_vertical_line.png"];
            
            [cell.contentView addSubview:line];
            
            UIImageView *bottomLine = [[UIImageView alloc] init];
            bottomLine.frame = CGRectMake(0, 39.5, 320, 0.5);
            bottomLine.image = [UIImage imageNamed:@"登陆-输入框分割线"];
            [cell.contentView addSubview:bottomLine];
        }
        return cell;
    }
    else if ([cellType isEqualToString:@"Verify_Cell"])
    {
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (cell == nil)
        {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.contentView addSubview:_loginView.verifyCodeView];
        return cell;
    }
    else if ([cellType isEqualToString:@"AccountMerge_Cell"])
    {
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (cell == nil)
        {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            cell.accessoryView = imageView;
            
            UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"门店首次登录背景.png"]];
            cell.backgroundView = backView;
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
            cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        }
        [cell.contentView addSubview:self.vipLable];
        [cell.contentView addSubview:self.vipLable1];

        return cell;
    }
    
    return [SNUITableViewCell new];
}

- (void)showPassword:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    [btn setNeedsDisplay];
    
    _loginView.passwordTextField.enabled = NO;
    _loginView.passwordTextField.secureTextEntry = !btn.selected;
    _loginView.passwordTextField.enabled = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    if ([cellType isEqualToString:@"AccountMerge_Cell"])
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030107"]];
        
        [self goToAccountMerger];
    }
}

#pragma mark - Actions

- (void)goToFindPassword
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030106"]];
    
    FindpFirstViewController *find = [[FindpFirstViewController alloc] init];
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:find];
    TT_RELEASE_SAFELY(find);
    [self presentModalViewController:navController animated:YES];
    TT_RELEASE_SAFELY(navController);
}

- (void)userRegister:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030105"]];
    
    NewRegisterViewController *registViewController = [[NewRegisterViewController alloc] init];
    registViewController.registerDelegate = self;
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:registViewController];
	TT_RELEASE_SAFELY(registViewController);
    [self presentModalViewController:navController animated:YES];
    TT_RELEASE_SAFELY(navController);
}

// backWayId = 1 ，注册页面直接返回到首页
- (void)showRegisterViewController:(NSInteger)backWayId  {
    
    NewRegisterViewController *ctrler = [[NewRegisterViewController alloc] init];
    ctrler.backTypeId           = backWayId;
    ctrler.isFromSacnerRegister = YES;
    ctrler.registerDelegate     = self;
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
	TT_RELEASE_SAFELY(ctrler);
    [self presentModalViewController:navController animated:NO];
    TT_RELEASE_SAFELY(navController);
    
}

//账户合并
-(void)goToAccountMerger
{
    AccountMergerViewController *find = [[AccountMergerViewController alloc] init];
    [self.navigationController pushViewController:find animated:YES];
}

- (void)forgetPwdAction:(id)sender
{
    
    [_loginView.usernameTextField resignFirstResponder];
    
    [_loginView.passwordTextField resignFirstResponder];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:L(@"Cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:L(@"Retrieve password by mobile"),L(@"Retrieve password by email"), nil];
    [actionSheet showInView:self.view];
    
    TT_RELEASE_SAFELY(actionSheet);
    
}

#pragma mark -
#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            AccountValidateViewController *accountValidateViewController = [[AccountValidateViewController alloc] init];
            
            accountValidateViewController.mode = MobileMode;
            
            AuthManagerNavViewController *accountValidateNav = [[AuthManagerNavViewController alloc]
                                                                initWithRootViewController:accountValidateViewController];
            
            TT_RELEASE_SAFELY(accountValidateViewController);
            
            [self presentModalViewController:accountValidateNav animated:YES];
            
            TT_RELEASE_SAFELY(accountValidateNav);
            break;
        }
        case 1:
        {
            AccountValidateViewController *accountValidateViewController = [[AccountValidateViewController alloc] init];
            
            accountValidateViewController.mode = EmailMode;
            
            AuthManagerNavViewController *accountValidateNav = [[AuthManagerNavViewController alloc]
                                                                initWithRootViewController:accountValidateViewController];
            
            TT_RELEASE_SAFELY(accountValidateViewController);
            
            [self presentModalViewController:accountValidateNav animated:YES];
            
            TT_RELEASE_SAFELY(accountValidateNav);
            break;
        }
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 2)
    {
        [_loginView.usernameTextField becomeFirstResponder];
    }
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField == _loginView.usernameTextField) {
        [_loginView.matchedAccView setText:nil];
    }
    return YES;
}

//密码校验
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _loginView.usernameTextField) {
        
        NSMutableString *tmpStr = [NSMutableString stringWithString:textField.text];
        if (range.length > 0) {
            // delete
            [tmpStr replaceCharactersInRange:range withString:string];
        }else {
            // add
            [tmpStr insertString:string atIndex:range.location];
        }
        // 展示 匹配的 常用邮箱
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([a-z0-9_\\.-]+)@[a-z0-9_\\.-]{0,}$"];
        if ([predicate evaluateWithObject:tmpStr]) {
            if (_loginView.matchedAccView.hidden) {
                _loginView.matchedAccView.hidden = NO;
            }
            [_loginView.matchedAccView setText:tmpStr];
        }else {
            [_loginView.matchedAccView setText:nil];
        }

        
        //NSLog(@"loc:%d,len:%d",range.location,range.length);
        
       
    }
    if (textField == _loginView.passwordTextField) {
        if (textField.text.length + string.length - range.length > 25)
        {
            return NO;
        }
        if (textField.text.length >= 20 && range.location >= 20)
        {
            return NO;
        }
        if ([string length] != [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding])
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _loginView.usernameTextField) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030101"]];
        
    }else if (textField == _loginView.passwordTextField){
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030102"]];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _loginView.usernameTextField) {
        [_loginView.matchedAccView setText:nil];
        
        if (_loginView.loginHistoryBtn.selected) {
            
        }
    }
    return YES;
}


- (void)saveLoginIdList
{
    /**
     *  修改隐藏的崩溃问题，并简化写法
     *  @author liukun
     *  @since 2.4.1
     */
    //edited by gjf 如果用邮箱注册然后绑定手机，用手机号登陆 logonid为邮箱账号
//    NSString *username = self.user.logonId;
    NSString *username = _loginView.usernameTextField.text;

    if (username.length)
    {
        NSArray *loginList = [self getLoginIdList];
        NSMutableArray *array = [loginList mutableCopy];
        [loginList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj isEqualToString:username]) {
                [array removeObject:obj];
            }
        }];
        
        [array insertObject:username atIndex:0];
        
        if ([array count] > 5) {
            [array removeLastObject];
        }
        
        [Config currentConfig].loginHistoryList = array;
    }
}

- (NSArray *)getLoginIdList
{
    NSArray *list = [Config currentConfig].loginHistoryList;
    if (list.count == 0) {
        [_loginView.loginHistoryBtn removeFromSuperview];
    }
    return list;
    //    NSData *jsonData = [[SNFileCache defaultCache] dataForKey:@"sn.login.list"];
    //
    //    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //
    //    if (IsStrEmpty(jsonStr)) {
    //        return nil;
    //    }else{
    //        return [jsonStr componentsSeparatedByString:@","];
    //    }
}

/*
 // Function : setExternAccount
 // Description : TV扫码带入用户账号
 // Date : 2014-04-03 11:00:00
 // Author : XZoscar
*/

- (void)setExternAccount:(NSString *)externAccount {
    if (externAccount != _externAccount) {
        _externAccount = externAccount;
    }
    
    if (nil != _externAccount) {
        _loginView.usernameTextField.text = _externAccount;
        _loginView.passwordTextField.text = nil;
    }
}

@end
