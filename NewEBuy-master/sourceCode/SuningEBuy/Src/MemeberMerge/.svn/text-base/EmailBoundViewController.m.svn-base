//
//  EmailBoundViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EmailBoundViewController.h"
#import "AccountMergerViewController.h"
#import "AccountListViewController.h"
#import "DataValidate.h"
#import "MobileBoundViewController.h"
#import "AccountCertainViewController.h"
#import "AccountMergeSuccessViewController.h"
#import "SNGraphics.h"
#import "UITableViewCell+BgView.h"

@interface EmailBoundViewController()
{
    AccountCheckCodeState      accountCheckCodeState;
}

@end

@implementation EmailBoundViewController

@synthesize firstCellButton = _firstCellButton;
@synthesize emailTextField = _emailTextField;
@synthesize verificationTextField = _verificationTextField;

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_checkCodeService);
    SERVICE_RELEASE_SAFELY(_memberMergeService);
    
    [_calculagraph stop];
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);

}



- (id)init{
	
    self = [super init];
	
    if (self) {
        if ([UserCenter defaultCenter].userInfoDTO == nil) {
            self.title = L(@"UCVerificationEmail");
        }else{
            self.title = L(@"UCEmailVerification");
        }
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"UCSubmit")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(goToAccountMerger)];
        self.navigationItem.rightBarButtonItem = rightButton;

    }
    return self;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (Calculagraph *)calculagraph
{
    if (!_calculagraph) {
        _calculagraph = [[Calculagraph alloc] init];
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
    return _calculagraph;
}


#pragma mark -
#pragma mark calculagraph delegate methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        NSInteger seconds = [[change objectForKey:@"new"] integerValue];
        
        if (60 - seconds == 0) {
            [self.calculagraph stop];
            [self.firstCellButton setTitle:L(@"Send_again") forState:UIControlStateNormal];
            self.firstCellButton.enabled = YES;
        }else{
            self.firstCellButton.enabled = NO;
            [self.firstCellButton setTitle:[NSString stringWithFormat:@"%@%ds",L(@"UCReObtain"),60 - seconds] forState:UIControlStateNormal];
        }
    }
}


#pragma mark -
#pragma mark view lifycycle

- (void)loadView
{
    [super loadView];
    
	self.groupTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.groupTableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.groupTableView];
    
}

-(void)sendCodeHttp
{
    NSString *phoneErrorMsg;
    if (![DataValidate validateEmail:self.emailTextField.text error:&phoneErrorMsg]) {
        [self presentSheet:phoneErrorMsg posY:60];
        [self.emailTextField becomeFirstResponder];
        return;
    }
    [self displayOverFlowActivityView:L(@"Loading...") yOffset: -60];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if ([UserCenter defaultCenter].isLogined) {
        accountCheckCodeState = eEmailAccountBindCellSendMailCode;
        [self.checkCodeService beginGetEmailCheckCode:@"" checkCodeState:eEmailAccountBindCellSendMailCode validateCode:@""];
    }else{
        accountCheckCodeState = eMailAccountValidateOwnerSendMailCode;
        [self.checkCodeService beginGetCheckCode:@"" email:self.emailTextField.text checkCodeState:eMailAccountValidateOwnerSendMailCode validateCode:@""];
    }
}


-(UIButton *)firstCellButton
{
    if (!_firstCellButton) {
        _firstCellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstCellButton.frame = CGRectMake(self.verificationTextField.right, 0, 320 - self.verificationTextField.right, 40);
        [_firstCellButton setBackgroundImage:[UIImage streImageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
        [_firstCellButton setBackgroundImage:[UIImage streImageNamed:@"button_gray_normal.png"] forState:UIControlStateDisabled];
        [_firstCellButton setTitle:L(@"UCGetVerificationCode") forState:UIControlStateNormal];
        [_firstCellButton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        [_firstCellButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_firstCellButton addTarget:self action:@selector(sendCodeHttp) forControlEvents:UIControlEventTouchUpInside];
        _firstCellButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _firstCellButton ;
}

- (UITextField *)emailTextField {
	
	if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 290, 40)];
		_emailTextField.delegate = self;
        _emailTextField.font = [UIFont boldSystemFontOfSize:14];
		_emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _emailTextField.enablesReturnKeyAutomatically = YES;
        _emailTextField.enabled = NO;
        _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        if (IOS5_OR_LATER) {
            _emailTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        }
        _emailTextField.textColor = [UIColor colorWithRGBHex:0x999081];
        _emailTextField.placeholder =L(@"UCPleaseEnterYourEmailAccount");
        if(!IsStrEmpty(self.emailAccount)){
            _emailTextField.text = self.emailAccount;
            _emailTextField.enabled = NO;
        }
	}
	return _emailTextField;
}

- (UITextField *)verificationTextField{
	
	if(!_verificationTextField){
		_verificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
		_verificationTextField.delegate = self;
        _verificationTextField.font = [UIFont boldSystemFontOfSize:14];
		_verificationTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_verificationTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _verificationTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _verificationTextField.returnKeyType = UIReturnKeyNext;
        _verificationTextField.textColor = [UIColor colorWithRGBHex:0x999081];
        _verificationTextField.enablesReturnKeyAutomatically = YES;
        _verificationTextField.placeholder =L(@"UCPleaseEnterVerificationCodeFromEmail");
	}
	return _verificationTextField;
}

-(void)goToAccountMerger
{
    NSString *phoneErrorMsg;
    if (![DataValidate validateEmail:self.emailTextField.text error:&phoneErrorMsg]) {
        [self presentSheet:phoneErrorMsg posY:60];
        [self.emailTextField becomeFirstResponder];
        return;
    }
    NSString *codeErrorMsg;
    if (![DataValidate validateEmailCode:self.verificationTextField.text error:&codeErrorMsg]) {
        [self presentSheet:codeErrorMsg posY:60];
        [self.verificationTextField becomeFirstResponder];
        return;
    }
    
    [self displayOverFlowActivityView:L(@"Loading...") yOffset: -60];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if ([UserCenter defaultCenter].userInfoDTO != nil) {
        accountCheckCodeState = eEmailAccountBindCellVerifyMailCode;
        [self.checkCodeService beginGetEmailCheckCode:@"" checkCodeState:eEmailAccountBindCellVerifyMailCode validateCode:self.verificationTextField.text];
    }else{
        accountCheckCodeState = eMailAccountValidateOwnerVerifyMailCode;
        [self.checkCodeService beginGetCheckCode:@"" email:self.emailTextField.text checkCodeState:eMailAccountValidateOwnerVerifyMailCode validateCode:self.verificationTextField.text];
    }
}

#pragma mark 短信验证码回调
- (AccountCheckCodeService *)checkCodeService
{
    if (!_checkCodeService) {
        _checkCodeService = [[AccountCheckCodeService alloc] init];
        _checkCodeService.delegate = self;
        _checkCodeService.userCal = YES;
    }
    return _checkCodeService;
}

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        switch (accountCheckCodeState) {
            case eMailAccountValidateOwnerSendMailCode:
            {
                [self.calculagraph start];
            }
                break;
            case eMailAccountValidateOwnerVerifyMailCode:
            {
                AccountMergeSuccessViewController *find = [[AccountMergeSuccessViewController alloc] init];
                find.memberInfoDto = self.checkCodeService.memberInfoDto;
                [self.navigationController pushViewController:find animated:YES];
            }
                break;
            case eEmailAccountBindCellSendMailCode:
            {
                [self.calculagraph start];
            }
                break;
            case eEmailAccountBindCellVerifyMailCode:
            {
                MobileBoundViewController *merge = [[MobileBoundViewController alloc] init];
                merge.isEmailBind = YES;
                [self.navigationController pushViewController:merge animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        if (accountCheckCodeState == eMailAccountValidateOwnerSendMailCode || accountCheckCodeState == eEmailAccountBindCellSendMailCode) {
            self.verificationTextField.text = @"";
        }
        [self presentSheet:IsStrEmpty(errorDesc)?L(@"ASI_CONNECTION_FAILURE_ERROR"):errorDesc posY:60];    }
}

- (void)eppGetCodeRemainTimeToRetry:(NSInteger)seconds checkCodeState:(AccountCheckCodeState)status
{
    if(seconds <= 0)
    {
        [self.firstCellButton setTitle:L(@"Send_again") forState:UIControlStateNormal];
        self.firstCellButton.enabled = YES;
    }
    else
    {
        self.firstCellButton.enabled = NO;
        [self.firstCellButton setTitle:[NSString stringWithFormat:@"%ds",seconds] forState:UIControlStateNormal];
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

- (void)searchBindInfoHttpComplete:(MemeberMergeService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        AccountListViewController *list = [[AccountListViewController alloc] init];
        list.suningAccount = service.suningAccount;
        list.accoutList = service.cardNoList;
        [self.navigationController pushViewController:list animated:YES];
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg posY:60];    }
}


#pragma mark -
#pragma tableView delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	
   	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = [L(@"UCEBuyAccountEmailVerification") sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(291, MAXFLOAT)];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 30)];
        v.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, size.height + 5)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor dark_Gray_Color];
        lab.numberOfLines = 0;
        if ([UserCenter defaultCenter].userInfoDTO == nil) {
            lab.text = L(@"UCPleaseVerifyEBuyAccountEmail");
        }else{
            lab.text = L(@"UCVerifyEmailFirst");
        }
        [v addSubview:lab];
        return v;
    }
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *secondCellIdentifier = @"secondCellIdentifier";
    SNUITableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
    if (secondCell == nil) {
        secondCell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.textLabel.font =[UIFont systemFontOfSize:14.0];
        secondCell.textLabel.backgroundColor = [UIColor clearColor];
        secondCell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
    }else{
        [secondCell.contentView removeAllSubviews];
    }
    if (indexPath.section == 0) {
        [secondCell.contentView addSubview:self.emailTextField];
    }else{
        [secondCell.contentView addSubview:self.verificationTextField];
        [secondCell.contentView addSubview:self.firstCellButton];
    }
    return secondCell;
}


#pragma mark -
#pragma mark textfield delegate/datasource

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField) {
        [self sendCodeHttp];
    }else if (textField == self.verificationTextField){
        [self goToAccountMerger];
    }
    return YES;
}


@end
