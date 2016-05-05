//
//  AccountMergerViewController.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-10-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccountMergerViewController.h"
#import "AccountListViewController.h"
#import "DataValidate.h"
#import "MobileBoundViewController.h"
#import "SNGraphics.h"
#import "UITableViewCell+BgView.h"

@interface AccountMergerViewController()
{
    AccountCheckCodeState      accountCheckCodeState;
}

@end

@implementation AccountMergerViewController

@synthesize firstCellButton = _firstCellButton;
@synthesize phoneTextField = _phoneTextField;
@synthesize verificationTextField = _verificationTextField;
@synthesize infoLable = _infoLable;

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
        self.title = L(@"UCStoreCellphoneVerification");
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

//初始化定时器
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

//发送请求
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

    accountCheckCodeState = eValidateMemberCardContactCellphoneSendCellphoneCode;
    [self.checkCodeService beginGetCheckCode:self.phoneTextField.text email:@"" checkCodeState:eValidateMemberCardContactCellphoneSendCellphoneCode validateCode:@""];

}

#pragma mark -
#pragma mark init view
-(UIView *)infoLable
{
    if (!_infoLable) {
        _infoLable = [[UIView alloc]init];
        _infoLable.frame = CGRectMake(0, 0, 320, 60);
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 15, 290, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12.f];
        label.textColor = [UIColor dark_Gray_Color];
        label.numberOfLines = 0;
        label.text = L(@"UCThroughStoreCellphoneVerification");
        [_infoLable addSubview:label];
    }
    return _infoLable;
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
        _phoneTextField.placeholder =L(@"UCProvideCellphoneNumber");
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
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
        _verificationTextField.returnKeyType = UIReturnKeyDone;
        _verificationTextField.enablesReturnKeyAutomatically = YES;
        _verificationTextField.placeholder =L(@"UCPleaseEnterVerificationCode");
	}
	return _verificationTextField;
}

//合并事件
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
    [self.memberMergeService beginSearchBindInfoHttpRequestCellphone:self.phoneTextField.text withCode:self.verificationTextField.text];
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
            case eValidateMemberCardContactCellphoneSendCellphoneCode:
            {
                [self.calculagraph start];
            }
                break;
            case eMailAccountValidateOwnerSendMailCode:
                
                break;
            case eMailAccountValidateOwnerVerifyMailCode:
            {
                MobileBoundViewController *mobile = [[MobileBoundViewController alloc] init];
                [self.navigationController pushViewController:mobile animated:YES];
            }
                break;
            case eMergeMbrCardSendCellphoneCode:
            {
                
            }
                break;
            case eMergeMemberCardVerifyCellphoneCode:
            {
                
            }
                break;
            default:
                break;
        }
    }else{
        self.verificationTextField.text = @"";
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
        if (IsArrEmpty(service.cardNoList)) {
            [self presentSheet:L(@"UCNoAssociationMemberCardAccount") posY:60];
        }else{
            [UserCenter defaultCenter].bindPhoneNum = self.phoneTextField.text;
            AccountListViewController *list = [[AccountListViewController alloc] init];
            list.suningAccount = service.suningAccount;
            list.accoutList = service.cardNoList;
            [self.navigationController pushViewController:list animated:YES];            
        }
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg posY:60];
    }
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
        return 60;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.infoLable;
    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *secondCellIdentifier = @"secondCellIdentifier";
    SNUITableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
    if (secondCell == nil) {
        secondCell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
//        secondCell.backgroundColor = [UIColor clearColor];
//        [secondCell setCoolBgViewWithCellPosition:CellPositionSingle];
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

@end
