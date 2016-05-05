//
//  YigouAccountViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "YigouAccountViewController.h"
#import "AccountCertainViewController.h"
#import "DataValidate.h"
#import "RegisterFirstViewController.h"
#import "AccountMergeSuccessViewController.h"
#import "AccountMergerViewController.h"
#import "EmailBoundViewController.h"
#import "MobileBoundViewController.h"
#import "UITableViewCell+BgView.h"
#import "NSAttributedString+Attributes.h"
#import "SFHFKeychainUtils.h"

@interface YigouAccountViewController ()

@end

@implementation YigouAccountViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_memberMergeService);
}


- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = L(@"UCAccountMerge");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"UCMerge")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(goToMergerCount)];
        self.navigationItem.rightBarButtonItem = rightButton;

    }
    return self;
}

- (void)loadView
{
    [super loadView];
	self.groupTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.groupTableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.groupTableView];
    
}

-(UIView *)registerView
{
    if (!_registerView) {
        _registerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        OHAttributedLabel *label1 = [[OHAttributedLabel alloc] initWithFrame:CGRectMake((320 - 70)/2, 20, 70, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:L(@"UCFastRegistration")];
        [attStr setTextColor:RGBCOLOR(102, 102, 102)];
        [attStr setTextIsUnderlined:YES];
        [attStr setFont:[UIFont systemFontOfSize:16]];
        label1.attributedText = attStr;
        [label1 setUserInteractionEnabled:NO];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [_registerView addSubview:label1];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = [UIColor clearColor];
        btn1.frame = CGRectInset(label1.frame, 0, -10);
        [btn1 addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
        [_registerView addSubview:btn1];

    }
    
    return _registerView;
}

- (void)goToRegister
{
    RegisterFirstViewController *first = [[RegisterFirstViewController alloc] init];
    first.cardNum = self.cardNum;
    first.cardPass = self.cardPass;
    first.suningAccount = self.suningAccount;
    [self.navigationController pushViewController:first animated:YES];
}

- (UITextField *)yiGouAcountTextField
{
	if(!_yiGouAcountTextField)
    {
		_yiGouAcountTextField = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 320 - 28 - 70- 38 + 20, 30)];
		_yiGouAcountTextField.delegate = self;
        _yiGouAcountTextField.font = [UIFont boldSystemFontOfSize:14];
		_yiGouAcountTextField.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
		_yiGouAcountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_yiGouAcountTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _yiGouAcountTextField.returnKeyType = UIReturnKeyNext;
        _yiGouAcountTextField.enablesReturnKeyAutomatically = YES;
        _yiGouAcountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        if (IOS5_OR_LATER) {
            _yiGouAcountTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        }
        _yiGouAcountTextField.placeholder =L(@"UCPleaseEnterYourEBuyAccount");
        _yiGouAcountTextField.text = IsStrEmpty(self.suningAccount)?@"":self.suningAccount;
	}
	return _yiGouAcountTextField;
	
}

- (UITextField *)passwordTextField
{
	if(!_passwordTextField)
    {
		_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 320 - 28-70 + 10 - 37, 30)];
		_passwordTextField.delegate = self;
        _passwordTextField.font = [UIFont boldSystemFontOfSize:14];
		_passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.returnKeyType = UIReturnKeyNext;
        _passwordTextField.enablesReturnKeyAutomatically = YES;
        _passwordTextField.placeholder =L(@"UCPleaseEnterYourEBuyAccountPassword");
		_passwordTextField.secureTextEntry = YES;
		
	}
	return _passwordTextField;
}

- (UIView *)nameView
{
    if (!_nameView) {
        _nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        _nameView.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 300, 25)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont boldSystemFontOfSize:15.0];
        lab.textColor = [UIColor colorWithRGBHex:0x444444];
        lab.numberOfLines = 0;
        lab.text = L(@"UCNeedMergeEBuyAccount");
        [_nameView addSubview:lab];
        
    }
    return _nameView;
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

- (void)goToMergerCount
{
    if (!self.yiGouAcountTextField.text || [self.yiGouAcountTextField.text isEmptyOrWhitespace])
    {
        [self.yiGouAcountTextField becomeFirstResponder];
        [self presentSheet:kLoginStatusMessageRequireUserName posY:30];
        return;
    }
    
    NSString *passErrorMsg;
    if (![DataValidate validatePassWord:self.passwordTextField.text error:&passErrorMsg]) {
        [self presentSheet:passErrorMsg];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    [self.yiGouAcountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.memberMergeService beginMbrCardBindAccountLoginId:self.yiGouAcountTextField.text logonPassword:self.passwordTextField.text cardNum:self.cardNum cardPsw:self.cardPass];
}


- (void)mbrCardBindAccountHttpComplete:(MemeberMergeService *)service isMergeSuccess:(BOOL)isMergeSuccess isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        [UserCenter defaultCenter].suningUsername = self.yiGouAcountTextField.text;
        [UserCenter defaultCenter].suningPassword = self.passwordTextField.text;
        if (isMergeSuccess) {
            AccountMergeSuccessViewController *success = [[AccountMergeSuccessViewController alloc] init];
            
            NSString *passwd = [PasswdUtil encryptString:[UserCenter defaultCenter].suningPassword
                                                  forKey:kLoginPasswdParamEncodeKey
                                                    salt:kPBEDefaultSalt];
            
            [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey
                                 andPassword:[UserCenter defaultCenter].suningUsername
                              forServiceName:kSNKeychainServiceNameSuffix
                              updateExisting:YES
                                       error:nil];
            [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey
                                 andPassword:passwd
                              forServiceName:kSNKeychainServiceNameSuffix
                              updateExisting:YES
                                       error:nil];
//            [Config currentConfig].username = [UserCenter defaultCenter].suningUsername;
//            [Config currentConfig].password = [UserCenter defaultCenter].suningPassword;
            success.memberInfoDto = service.memberInfoDto;
            [self.navigationController pushViewController:success animated:YES];
        }else{
            if ([service.accountType isEqualToString:@"0"]) {
                MobileBoundViewController *mobile = [[MobileBoundViewController alloc] init];
                mobile.bindMobileNum = service.suningAccount;
                [self.navigationController pushViewController:mobile animated:YES];
            }else if ([service.accountType isEqualToString:@"1"]){
                if ([service.accountBindCellPhone isEqualToString:@""]) {
                    EmailBoundViewController *email = [[EmailBoundViewController alloc] init];
                    email.emailAccount = self.yiGouAcountTextField.text;
                    email.suningAccount = self.suningAccount;
                    email.cardNum = self.cardNum;
                    [self.navigationController pushViewController:email animated:YES];
                }else{
                    MobileBoundViewController *mobile = [[MobileBoundViewController alloc] init];
                    mobile.bindMobileNum = service.accountBindCellPhone;
                    mobile.isBindPhone = YES;
                    [self.navigationController pushViewController:mobile animated:YES];
                }
            }else{
                
            }
        }
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg];
    }
}


#pragma mark -
#pragma mark table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.nameView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
   	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   return self.registerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 )
    {
        static NSString *firstCellIdentifier = @"firstCellIdentifier";
        SNUITableViewCell* firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
        if (firstCell == nil) {
            firstCell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellIdentifier];
            firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
            firstCell.textLabel.font =[UIFont boldSystemFontOfSize:14.0];
            firstCell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        

            UIImageView *vIcon = [[UIImageView alloc] initWithFrame:CGRectMake(25, 11, 14, 17)];
            vIcon.tag = 101;
            [firstCell.contentView addSubview:vIcon];
            
            UIImage *imageUserIcon = [UIImage imageNamed:@"login_user_normal.png"];
            vIcon.image = imageUserIcon;
            
            //icon与输入框分隔线
            UIView *vVerticalSepline = [[UIView alloc] initWithFrame:CGRectMake(52, 5, 1, 30)];
            vVerticalSepline.backgroundColor = RGBCOLOR(197, 197, 197);
            [firstCell.contentView addSubview:vVerticalSepline];
        }
        [firstCell addSubview:self.yiGouAcountTextField];
        return firstCell;
    }
    else
    {
        static NSString *firstCellIdentifier = @"firstCellIdentifier";
        SNUITableViewCell* firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
        if (firstCell == nil) {
            firstCell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellIdentifier];
            firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
            firstCell.textLabel.font =[UIFont boldSystemFontOfSize:14.0];
            firstCell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
            

            UIImageView *vIcon = [[UIImageView alloc] initWithFrame:CGRectMake(25, 11, 14, 17)];
            vIcon.tag = 101;
            [firstCell.contentView addSubview:vIcon];
            
            //密码图标
            UIImage *imageUserIcon = [UIImage streImageNamed:@"login_password_icon.png"];
            vIcon.image = imageUserIcon;
            
            self.passwdToggleView.left = self.passwordTextField.right+5;
            self.passwdToggleView.top = 10;
            [firstCell.contentView addSubview:self.passwdToggleView];
            
            //icon与输入框分隔线
            UIView *vVerticalSepline = [[UIView alloc] initWithFrame:CGRectMake(52, 5, 1, 30)];
            vVerticalSepline.backgroundColor = RGBCOLOR(197, 197, 197);
            [firstCell.contentView addSubview:vVerticalSepline];
        }
        [firstCell addSubview:self.passwordTextField];
    
        return firstCell;
    }
    
    return [SNUITableViewCell new];
}


#pragma mark -
#pragma mark textfield delegate/datasource
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.yiGouAcountTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else{
        [self goToMergerCount];
    }
    return YES;
}


@end
