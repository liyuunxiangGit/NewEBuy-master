//
//  MobileBoundViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MobileBoundViewController.h"
#import "AccountMergerViewController.h"
#import "AccountListViewController.h"
#import "DataValidate.h"
#import "AccountMergeSuccessViewController.h"
#import "MyCardViewController.h"
#import "SNGraphics.h"
#import "UITableViewCell+BgView.h"


@interface MobileBoundViewController()
{
    AccountCheckCodeState      accountCheckCodeState;
    BOOL                       isLogined;
}

@end

@implementation MobileBoundViewController

@synthesize firstCellButton = _firstCellButton;
@synthesize phoneTextField = _phoneTextField;
@synthesize verificationTextField = _verificationTextField;

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_checkCodeService);
    SERVICE_RELEASE_SAFELY(_memberMergeService);
    SERVICE_RELEASE_SAFELY(_boundCodeService);
    SERVICE_RELEASE_SAFELY(_boundService);
    
    [_calculagraph stop];
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);

}



- (id)init{
	
    self = [super init];
	
    if (self) {
        if ([UserCenter defaultCenter].userInfoDTO == nil) {
            isLogined = NO;
            self.title = L(@"UCMobilePhoneVerification");
        }else{
            isLogined = YES;
            self.title = L(@"UCMobilePhoneBound");
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
     if (![DataValidate validatePhoneNum:self.phoneTextField.text error:&phoneErrorMsg]) {
         [self presentSheet:phoneErrorMsg posY:60];
         [self.phoneTextField becomeFirstResponder];
         return;
     }
    [self displayOverFlowActivityView:L(@"Loading...") yOffset: -60];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (isLogined) {
        if (self.isEmailBind) {
            accountCheckCodeState  = eEmailAccountBindCellSendCellCode;
            [self.checkCodeService beginGetEmailCheckCode:self.phoneTextField.text checkCodeState:eEmailAccountBindCellSendCellCode validateCode:@""];
        }else{
            [self.boundCodeService beginGetCheckCode:self.phoneTextField.text checkCodeState:ePhoneCheckCode];
        }
    }else{
        accountCheckCodeState = eMergeMbrCardSendCellphoneCode;
        [self.checkCodeService beginGetCheckCode:self.phoneTextField.text email:@"" checkCodeState:eMergeMbrCardSendCellphoneCode validateCode:@""];
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


- (UITextField *)phoneTextField {
	
	if (!_phoneTextField) {
		_phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 290, 40)];
		_phoneTextField.delegate = self;
        _phoneTextField.font = [UIFont boldSystemFontOfSize:14];
		_phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phoneTextField.enablesReturnKeyAutomatically = YES;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.textColor = [UIColor colorWithRGBHex:0x999081];
        if ([UserCenter defaultCenter].userInfoDTO != nil) {
            NSRange range = [[UserCenter defaultCenter].userInfoDTO.logonId rangeOfString:@"@"];
            if (range.location == NSNotFound) {
                _phoneTextField.text = [UserCenter defaultCenter].userInfoDTO.logonId;
                _phoneTextField.userInteractionEnabled = NO;
            }
        }else{
            _phoneTextField.text = self.bindMobileNum;
            _phoneTextField.userInteractionEnabled = NO;
        }
        _phoneTextField.placeholder =L(@"UCPleaseEnterCellphoneNumber");
	}
	return _phoneTextField;
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
        _verificationTextField.placeholder =L(@"UCPleaseEnterVerificationCodeFromMessage");
	}
	return _verificationTextField;
}

-(void)goToAccountMerger
{
    NSString *phoneErrorMsg;
    if (![DataValidate validatePhoneNum:self.phoneTextField.text error:&phoneErrorMsg]) {
        [self presentSheet:phoneErrorMsg posY:60];
        [self.phoneTextField becomeFirstResponder];
        return;
    }

    NSString *codeErrorMsg;
    if (![DataValidate validateCodeString:self.verificationTextField.text error:&codeErrorMsg]) {
        [self presentSheet:codeErrorMsg posY:60];
        [self.verificationTextField becomeFirstResponder];
        return;
    }
 
    [self displayOverFlowActivityView:L(@"Loading...") yOffset: -60];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (isLogined) {
        if (self.isEmailBind) {
            accountCheckCodeState = eEmailAccountBindCellVerifyCellCode;
            [self.checkCodeService beginGetEmailCheckCode:self.phoneTextField.text checkCodeState:eEmailAccountBindCellVerifyCellCode validateCode:self.verificationTextField.text];
        }else{
            [self.boundService beginBoundPhoneWhenLogonByPhone:self.phoneTextField.text CodeNum:self.verificationTextField.text];   
        }
    }else{
        accountCheckCodeState = eMergeMemberCardVerifyCellphoneCode;
        [self.checkCodeService beginGetCheckCode:self.phoneTextField.text email:@"" checkCodeState:eMergeMemberCardVerifyCellphoneCode validateCode:self.verificationTextField.text];
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

- (CheckCodeService *)boundCodeService
{
    if (!_boundCodeService) {
        _boundCodeService = [[CheckCodeService alloc] init];
        _boundCodeService.delegate = self;
        _boundCodeService.userCal = YES;
    }
    return _boundCodeService;
}

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        switch (accountCheckCodeState) {
            case eMergeMbrCardSendCellphoneCode:
            {
                [self.calculagraph start];
            }
                break;
            case eMergeMemberCardVerifyCellphoneCode:
            {
                if (self.isBindPhone) {
                    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:2];
                    CardNoListDTO *dto1 = [[CardNoListDTO alloc] init];
                    dto1.cardNo = [UserCenter defaultCenter].bindPhoneNum;
                    dto1.ecoType = L(@"UCMemberCardMobilePhoneNumber");
                    dto1.isSelected = YES;
                    [list addObject:dto1];
                    
                    CardNoListDTO *dto2 = [[CardNoListDTO alloc] init];
                    dto2.cardNo = self.phoneTextField.text;
                    dto2.ecoType = L(@"UCEBuyAccountMobilePhoneNumber");
                    [list addObject:dto2];
                    
                    AccountCertainViewController *certain = [[AccountCertainViewController alloc] init];
                    certain.accoutList = list;
                    [self.navigationController pushViewController:certain animated:YES];
                }else{
                    AccountMergeSuccessViewController *success = [[AccountMergeSuccessViewController alloc] init];
                    success.memberInfoDto = self.checkCodeService.memberInfoDto;
                    [self.navigationController pushViewController:success animated:YES];                    
                }
            }
                break;
            case eEmailAccountBindCellSendCellCode:
            {
                [self.calculagraph start];
            }
                break;
            case eEmailAccountBindCellVerifyCellCode:
            {
//                [UserCenter defaultCenter].userInfoDTO.logonId = self.phoneTextField.text;
                [UserCenter defaultCenter].userInfoDTO.phoneNo = self.phoneTextField.text;
                [UserCenter defaultCenter].userInfoDTO.isBindMobile = @"1";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINED_BOUND_PHONE" object:nil];
                for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                    if ([ctrl isKindOfClass:[MyCardViewController class]]) {
                        [self.navigationController popToViewController:ctrl animated:NO];
                    }
                }
            }
                break;
            default:
                break;
        }
    }else{
        if (accountCheckCodeState == eMergeMbrCardSendCellphoneCode || accountCheckCodeState == eEmailAccountBindCellSendCellCode) {
            self.verificationTextField.text = @"";
        }
        [self presentSheet:IsStrEmpty(errorDesc)?L(@"ASI_CONNECTION_FAILURE_ERROR"):errorDesc posY:60];
    }
}

- (BoundPhoneService *)boundService
{
    if (!_boundService) {
        _boundService = [[BoundPhoneService alloc] init];
        _boundService.delegate = self;
    }
    return _boundService;
}

- (void)didBoundPhoneWhenLogonByPhoneComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        [self.boundCodeService stopCalculagraph];
        [UserCenter defaultCenter].userInfoDTO.isBindMobile = @"1";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINED_BOUND_PHONE" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self presentSheet:IsStrEmpty(errorDesc)?L(@"ASI_CONNECTION_FAILURE_ERROR"):errorDesc posY:60];
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
        CGSize size = [L(@"UCMobilePhoneNumberVerification") sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(290, MAXFLOAT)];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 30)];
        v.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, size.height + 5)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor dark_Gray_Color];
        lab.numberOfLines = 0;
        if ([UserCenter defaultCenter].userInfoDTO == nil) {
            lab.text = L(@"UCPleaseVerifyEBuyMobilePhoneNumberFirst");
        }else{
            lab.text = L(@"UCMobilePhoneNumberVerification");
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
        secondCell.textLabel.backgroundColor = [UIColor clearColor];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.textLabel.font =[UIFont systemFontOfSize:14.0];
        secondCell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
    }else{
        [secondCell.contentView removeAllSubviews];
    }
    if (indexPath.section == 0) {
        [secondCell.contentView addSubview:self.phoneTextField];
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
    if (textField == self.phoneTextField) {
        [self sendCodeHttp];
    }else if (textField == self.verificationTextField){
        [self goToAccountMerger];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField  == self.phoneTextField)
    {
        if (textField.text.length >= 11 && range.location >=11)
        {
            return NO;
        }
        if (textField.text.length + string.length - range.length > 11)
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Method not implemented in protocol

- (void)didBoundPhoneWhenLogonByEmailComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc {}

@end
