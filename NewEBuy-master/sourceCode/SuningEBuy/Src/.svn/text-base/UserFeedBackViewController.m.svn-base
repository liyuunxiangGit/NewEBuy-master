//
//  UserFeedBackViewController.m
//  SuningEBuy
//
//  Created by xie wei on 13-5-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserFeedBackViewController.h"
#import "UIPlaceHolderTextView.h"
#import "FormattersValidators.h"

//设配类型
#define kIPhone   @"iPhone"
#define kIPad     @"iPad"
#define kIPod     @"iPod"

/* 新注册账号  客服 */
#define kFromEmailAddress   @"suningios@126.com"

#define kToEmailAddress   @"suningios@cnsuning.com" // @"suningios@cnsuning.com";

#define kRelayHostAddress   @"smtp.126.com" // @"smtp.gmail.com"

#define kLoginParssword   @"suningEmall"


//#define kFromEmailAddress   @"suningios@cnsuning.com" //@"suningemall@gmail.com"
//
//#define kToEmailAddress   @"12070640@cnsuning.com" // @"suningios@cnsuning.com";
//
//#define kRelayHostAddress   @"ms9.cnsuning.com" // @"smtp.gmail.com"
//
//#define kLoginParssword   @"suningios"    //@"ebuy1234"

#define kTextColor RGBCOLOR(0, 0, 0)
#define kNormalFont [UIFont boldSystemFontOfSize:17.0]

@interface  UserFeedBackViewController ()
{
    NSString *feedbackType;
    
    NSInteger selectFeedBackType;
    
    NSInteger lastSelect;
    
    BOOL isSendSuccess;
    
    BOOL isPhone;
    BOOL isEmail;
    
    BOOL isHadChang;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *pktableView;

@property (nonatomic, strong) SKPSMTPMessage *emilMessage;

@property (nonatomic, strong) UITextView    *inputInfoView;

@property (nonatomic, strong) UIPlaceHolderTextView  *phoneNumberView;

@property (nonatomic, strong) UIView        *feedbackTypeView;

@property (nonatomic, strong) UIView        *inputHeadView;

@property (nonatomic, strong) UIView        *phoneHeadView;

@property (nonatomic, strong) UILabel       *typeBtnText;

@property (nonatomic, strong) SNPopoverController *snPopoverController;

@property (nonatomic, strong) UserFeedBackService *userFeedBackService;

@property (nonatomic, strong) UIButton *emailBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *emailLbl;

@property (nonatomic, strong) UILabel *phoneLbl;

@end


@implementation UserFeedBackViewController

@synthesize emilMessage = _emilMessage;

@synthesize pktableView = _pktableView;

@synthesize inputInfoView = _inputInfoView;

@synthesize phoneNumberView = _phoneNumberView;

@synthesize feedbackTypeView = _feedbackTypeView;

@synthesize inputHeadView = _inputHeadView;

@synthesize phoneHeadView = _phoneHeadView;

@synthesize typeBtnText = _typeBtnText;

@synthesize snPopoverController = _snPopoverController;

@synthesize userFeedBackService = _userFeedBackService;

@synthesize emailBtn = _emailBtn;

@synthesize phoneBtn = _phoneBtn;

@synthesize emailLbl = _emailLbl;
@synthesize phoneLbl = _phoneLbl;

#pragma mark - 页面生命周期

- (void)dealloc{

    SERVICE_RELEASE_SAFELY(_emilMessage);
    
    TT_RELEASE_SAFELY(_pktableView);
    
    TT_RELEASE_SAFELY(_inputInfoView);
    
    TT_RELEASE_SAFELY(_phoneNumberView);
    
    TT_RELEASE_SAFELY(_feedbackTypeView);
    
    TT_RELEASE_SAFELY(_inputHeadView);
    
    TT_RELEASE_SAFELY(_phoneHeadView);
    
    TT_RELEASE_SAFELY(_typeBtnText);
    
    TT_RELEASE_SAFELY(_snPopoverController);
    
    TT_RELEASE_SAFELY(_userFeedBackService);
    
    TT_RELEASE_SAFELY(_emailBtn);
    
    TT_RELEASE_SAFELY(_phoneBtn);
    TT_RELEASE_SAFELY(_emailLbl);
    TT_RELEASE_SAFELY(_phoneLbl);
    
}

- (id)init{
	
    self = [super init];
	
    if (self) {
        self.title = L(@"User Feedback");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        selectFeedBackType = 0;
        
        lastSelect = 0;
        
        isEmail = YES;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
    
    if (IsStrEmpty([Config currentConfig].userContractType) || [[Config currentConfig].userContractType isEqualToString:@"email"]) {
        self.emailBtn.selected = YES;
        self.phoneBtn.selected = NO;
    }else if ([[Config currentConfig].userContractType isEqualToString:@"phone"]){
        self.emailBtn.selected = NO;
        self.phoneBtn.selected = YES;
    }
    
	CGRect frame = contentView.frame;
	frame.origin.x = 0;
	frame.origin.y = 0;
	frame.size.height = contentView.bounds.size.height - 96;
	self.pktableView.frame = frame;
    
    [self.view addSubview:self.pktableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.inputInfoView resignFirstResponder];
    
    [self.phoneNumberView resignFirstResponder];
}

#pragma mark - 事件处理方法

- (void)typeBtnSelect:(id)sender
{
    [self.inputInfoView resignFirstResponder];
    [self.phoneNumberView resignFirstResponder];
    
    FeedBackTypeChooseViewController *feedBackController = [[FeedBackTypeChooseViewController alloc] init:lastSelect];
    feedBackController.delegate = self;
    [self.snPopoverController presentWithContentViewController:feedBackController animated:YES];
}

- (void)submitBtnClick:(id)sender
{
    [self sendEmailEvent];
}

- (void)sendEmailEvent
{
    if ([self.inputInfoView.text.trim length] <= 0) {
        
        return [self presentCustomDlg:L(@"Contents can't be empty")];
    }
    
    if ([self.phoneNumberView.text length] <= 0) {
        if (self.emailBtn.selected == YES) {
            return [self presentCustomDlg:L(@"UserFeedBack_InputYourEmail")];
        }else {
            return [self presentCustomDlg:L(@"UserFeedBack_InputYourPhoneNum")];
        }
    }
    
    if (self.emailBtn.selected == YES) {
        if (![FormattersValidators isValidEmail:self.phoneNumberView.text]) {
            return [self presentCustomDlg:L(@"UserFeedBack_InputYourEmailCorrectly")];
        }
            
    }else {
        if (![FormattersValidators isValidPhone:self.phoneNumberView.text]) {
            return [self presentCustomDlg:L(@"UserFeedBack_InputYourPhoneNumCorrectly")];
        }
    }
    
    [self.inputInfoView resignFirstResponder];
    [self.phoneNumberView resignFirstResponder];
    
    UserFeedBackDTO *feedbackDto = [[UserFeedBackDTO alloc] init];
    feedbackDto.feedbackType = [NSString stringWithFormat:@"%d",lastSelect+1];
    feedbackDto.feedbackContext = self.inputInfoView.text;
    feedbackDto.contactInfo = self.phoneNumberView.text;
    if ([self checkDevice:kIPhone]) {
        feedbackDto.terminal = @"1";
    }else if ([self checkDevice:kIPad]) {
        feedbackDto.terminal = @"2";
    }else {
        feedbackDto.terminal = @"3";
    }
    feedbackDto.terminalOsVersion= [SystemInfo osVersion];
    feedbackDto.appId = @"1";
    feedbackDto.terminalAppVersion = [NSString stringWithFormat:@"%@ %@",L(@"eBuy"),[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    feedbackDto.clientId = [NSString stringWithFormat:@"%@",[UserCenter defaultCenter].userInfoDTO.logonId];
    
    [self displayOverFlowActivityView];
    [self.userFeedBackService beginSendFeedBackRequest:feedbackDto];
    TT_RELEASE_SAFELY(feedbackDto);
}

#pragma mark - SKPSMTPMessageDelegate

- (void)messageSent:(SKPSMTPMessage *)message
{
    [self removeOverFlowActivityView];
    
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    isSendSuccess = YES;
    
    return [self presentCustomDlg:L(@"Send success, thank for your feedback")];
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    [self removeOverFlowActivityView];
    
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    DLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
    
    isSendSuccess = NO;
    
    return [self presentCustomDlg:L(@"Send failed")];
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (isSendSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
        isSendSuccess = NO;
    }
}

#pragma mark - ChooseFeedBackTypeDelegate 

- (void)didChooseFeedBackType:(SNFeedBackType)feedBackType
{
    switch (feedBackType) {
        case SNFeedBackFunction:
        {
            self.typeBtnText.text = L(@"UserFeedBack_FuncOperationSug");
            lastSelect = 0;
            break;
        }
        case SNFeedBackPage:
        {
            self.typeBtnText.text = L(@"UserFeedBack_GUISug");
            lastSelect = 1;
            break;
        }
        case SNFeedBackNewFunction:
        {
            self.typeBtnText.text = L(@"UserFeedBack_YourNewNeeds");
            lastSelect = 2;
            break;
        }
        case SNFeedBackConsult:
        {
            self.typeBtnText.text = L(@"UserFeedBack_OrderConsult");
            lastSelect = 3;
            break;
        }
        case SNFeedBackLogisticsConsult:
        {
            self.typeBtnText.text = L(@"UserFeedBack_RepairConsult");
            lastSelect = 4;
            break;
        }
        case SNFeedBackChangeGoodConsult:
        {
            self.typeBtnText.text = L(@"UserFeedBack_ReturnAndChangeGoodsConsult");
            lastSelect = 5;
            break;
        }
        case SNFeedBackOther:
        {
            self.typeBtnText.text = L(@"Others");
            lastSelect = 6;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UITextView Delegate Methods

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.phoneNumberView) {
        DLog(@"%@",self.phoneNumberView.text);
        if ([self.phoneNumberView.text length] > 0) {
            if (isEmail) {
                [Config currentConfig].userContractMethod = self.phoneNumberView.text;
            }else {
                [Config currentConfig].userContractPhoneMethod = self.phoneNumberView.text;
            }
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (textView == self.phoneNumberView) {
        NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (isPhone) {
            if ([toBeString length] > 11) {
                textView.text = [toBeString substringToIndex:11];
                return NO;
            }
        }
    }
    
    return YES;
}

#pragma mark - Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return  116;
            break;
        }
            
        default:
            return 48;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: 
        {
            static NSString *investeReaseonCellIdentifier = @"CommentCellIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:investeReaseonCellIdentifier];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:investeReaseonCellIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_inputInfoView.superview == nil) {
                
                [cell.contentView addSubview: self.inputInfoView];
            }
            
            return cell;
            break;
        }
            
        case 1: 
        {
            static NSString *investeReaseonCellIdentifier = @"ContendCellIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:investeReaseonCellIdentifier];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:investeReaseonCellIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_phoneNumberView.superview == nil) {
                
                [cell.contentView addSubview:self.phoneNumberView];
            }
            else
            {
                [self.phoneNumberView removeFromSuperview];
                TT_RELEASE_SAFELY(_phoneNumberView);
                [cell.contentView addSubview:self.phoneNumberView];
                
            }
            
            return cell;
            break;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 71 + 15;
    }
    
    return 70; //44
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
            
        case 0:
            return self.inputHeadView;
            break;
            
        case 1:
            return self.phoneHeadView;
            break;
            
        default:
            break;
    }
    
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 111;
    }
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 44)];
        footView.backgroundColor = [UIColor clearColor];
        footView.userInteractionEnabled = YES;
        
        UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 26, 269, 31)];
        [submitBtn setBackgroundImage:[UIImage imageNamed:@"feedBack_submit.png"] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [footView addSubview:submitBtn];
        TT_RELEASE_SAFELY(submitBtn);
        
        return footView;
    }
    else
    {
        return nil;
    }
}

#pragma - 属性方法

- (UIView *)feedbackTypeView
{
    if (_feedbackTypeView == nil)
    {
        _feedbackTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 15, 89, 26)];
        typeLabel.font = kNormalFont;
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textColor = kTextColor;
        typeLabel.text = [NSString stringWithFormat:@"%@:",L(@"UserFeedBack_FeedBackType")];
        [_feedbackTypeView addSubview:typeLabel];
        TT_RELEASE_SAFELY(typeLabel);
        
        UIButton *typeButton = [[UIButton alloc] initWithFrame:CGRectMake(107, 14, 171.5, 26.5)];
        [typeButton setBackgroundImage:[UIImage imageNamed:@"feedBack_Type.png"] forState:UIControlStateNormal];
        typeButton.backgroundColor = [UIColor clearColor];
        [typeButton addTarget:self action:@selector(typeBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        [typeButton addSubview:self.typeBtnText];
        
        [_feedbackTypeView addSubview:typeButton];
        TT_RELEASE_SAFELY(typeButton);
    }
    
    return _feedbackTypeView;
}

- (UILabel *)typeBtnText
{
    if (!_typeBtnText) {
        _typeBtnText = [[UILabel alloc] initWithFrame:CGRectMake(19, 6, 150, 16)];
        _typeBtnText.backgroundColor = [UIColor clearColor];
        _typeBtnText.textColor = RGBCOLOR(0, 103, 155);
        _typeBtnText.textColor = [UIColor darkBlueColor];
        _typeBtnText.shadowColor = [UIColor whiteColor];
        _typeBtnText.shadowOffset = CGSizeMake(1, 1);
        _typeBtnText.font = kNormalFont;
        _typeBtnText.text = L(@"UserFeedBack_FuncOperationSug");
    }
    return _typeBtnText;
}

- (UIView *)inputHeadView
{
    if (_inputHeadView == nil)
    {
        _inputHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 50, 320, 30)];
        contentLabel.font = kNormalFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = kTextColor;
        contentLabel.text = L(@"FeedMarkInfo");
        
        [_inputHeadView addSubview:self.feedbackTypeView];
        [_inputHeadView addSubview:contentLabel];
        
        TT_RELEASE_SAFELY(contentLabel);
    }
    
    return _inputHeadView;
}

- (UIView *)phoneHeadView
{
    if (_phoneHeadView == nil)
    {
        _phoneHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, 320, 30)];
        
        contentLabel.font = kNormalFont;
        
        contentLabel.backgroundColor = [UIColor clearColor];
        
        contentLabel.textColor = kTextColor;
        
        contentLabel.text = [NSString stringWithFormat:@"%@:",L(@"Contact way")];
        
        [_phoneHeadView addSubview:contentLabel];
        
        TT_RELEASE_SAFELY(contentLabel);
        
        [_phoneHeadView addSubview:self.emailBtn];
        [_phoneHeadView addSubview:self.phoneBtn];
        [_phoneHeadView addSubview:self.emailLbl];
        [_phoneHeadView addSubview:self.phoneLbl];
    }
    return _phoneHeadView;
}

- (UITextView *)inputInfoView
{
    if (!_inputInfoView)
    {
        _inputInfoView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5,  280, 106)];
        
        _inputInfoView.backgroundColor = [UIColor clearColor];
        
        _inputInfoView.userInteractionEnabled = YES;
        
        UIFont *font = [UIFont systemFontOfSize:16.0];
        
        _inputInfoView.font = font;
        
        _inputInfoView.delegate = self;
        
        _inputInfoView.layer.masksToBounds = YES;
        
        _inputInfoView.keyboardType = UIKeyboardTypeDefault;
        
        _inputInfoView.returnKeyType = UIReturnKeyDone;
        
        _inputInfoView.textColor = [UIColor blackColor];
    }
    return _inputInfoView;
}

- (TPKeyboardAvoidingTableView *)pktableView
{
	if(!_pktableView){
		
		_pktableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStyleGrouped];
		
		[_pktableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_pktableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_pktableView.scrollEnabled = YES;
		
		_pktableView.userInteractionEnabled = YES;
		
		_pktableView.delegate = self;
		
		_pktableView.dataSource = self;
		
		_pktableView.backgroundColor = [UIColor clearColor];
        
        _pktableView.backgroundView = nil;
	}
	
	return _pktableView;
}

- (UIPlaceHolderTextView *)phoneNumberView
{
    if (_phoneNumberView == nil) {
        
        _phoneNumberView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(5, 0, 290, 44)];
        
        _phoneNumberView.delegate = self;
        
        if (!isHadChang) {
            if (![[Config currentConfig].userContractType isEqualToString:@"phone"]) {
                if ([[Config currentConfig].userContractMethod isEqualToString:@""]) {
                    _phoneNumberView.placeholder = L(@"UserFeedBack_InputYourEmail");
                }else {
                    _phoneNumberView.text = [Config currentConfig].userContractMethod;
                }
            }else {
                if ([[Config currentConfig].userContractPhoneMethod isEqualToString:@""]) {
                    _phoneNumberView.placeholder = L(@"UserFeedBack_InputYourPhoneNum");
                }else {
                    _phoneNumberView.text = [Config currentConfig].userContractPhoneMethod;
                }
            }
        }else {
            if (isEmail) {
                if ([[Config currentConfig].userContractMethod isEqualToString:@""]) {
                    _phoneNumberView.placeholder = L(@"UserFeedBack_InputYourEmail");
                }else {
                    _phoneNumberView.text = [Config currentConfig].userContractMethod;
                }
            }else {
                if ([[Config currentConfig].userContractPhoneMethod isEqualToString:@""]) {
                    _phoneNumberView.placeholder = L(@"UserFeedBack_InputYourPhoneNum");
                }else {
                    _phoneNumberView.text = [Config currentConfig].userContractPhoneMethod;
                }
            }
        }
        
        _phoneNumberView.font = [UIFont systemFontOfSize:16.0];
        
//        _phoneNumberView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _phoneNumberView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _phoneNumberView.backgroundColor = [UIColor clearColor];
        
        _phoneNumberView.returnKeyType = UIReturnKeyDone;
    }
    
    return _phoneNumberView;
}

- (UIButton *)emailBtn
{
    if (!_emailBtn) {        
        _emailBtn = [[UIButton alloc] initWithFrame:CGRectMake(21, 35, 17, 17)];
        _emailBtn.tag = 200;
        [_emailBtn setBackgroundImage:[UIImage imageNamed:@"feedBack_type_button.png"] forState:UIControlStateNormal];
        [_emailBtn setBackgroundImage:[UIImage imageNamed:@"feedBack_type_button_pressed.png"] forState:UIControlStateSelected];
        _emailBtn.backgroundColor = [UIColor clearColor];
        [_emailBtn addTarget:self action:@selector(contactTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emailBtn;
}

- (UILabel *)emailLbl
{
    if (!_emailLbl) {
        _emailLbl = [[UILabel alloc] initWithFrame:CGRectMake(26+17, 32, 80, 23)];
        _emailLbl.text = @"邮箱";
        _emailLbl.font = kNormalFont;
        _emailLbl.backgroundColor = [UIColor clearColor];
    }
    return _emailLbl;
}

- (UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 35, 17, 17)];
         _phoneBtn.tag = 300;
        [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"feedBack_type_button.png"] forState:UIControlStateNormal];
        [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"feedBack_type_button_pressed.png"] forState:UIControlStateSelected];
        _phoneBtn.backgroundColor = [UIColor clearColor];
        [_phoneBtn addTarget:self action:@selector(contactTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (UILabel *)phoneLbl
{
    if (!_phoneLbl) {
        _phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(155+17, 32, 80, 23)];
        _phoneLbl.text = @"手机号码";
        _phoneLbl.font = kNormalFont;
        _phoneLbl.backgroundColor = [UIColor clearColor];
    }
    return _phoneLbl;
}

- (void)contactTypeBtn:(id)sender
{
    isHadChang = YES;
    
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 200) {
        self.phoneNumberView.placeholder = L(@"UserFeedBack_InputYourEmail");
        isEmail = YES;
        isPhone = NO;
        self.emailBtn.selected = YES;
        self.phoneBtn.selected = NO;
        [self.pktableView reloadData];
    }
    else if (btn.tag == 300)
    {
        self.phoneNumberView.placeholder = L(@"UserFeedBack_InputYourPhoneNum");
        isPhone = YES;
        isEmail = NO;
        self.emailBtn.selected = NO;
        self.phoneBtn.selected = YES;
        [self.pktableView reloadData];
    }
}

#pragma mark - 配置发送信息

- (SKPSMTPMessage *)emilMessage
{
    if (!_emilMessage) {
        
        _emilMessage = [[SKPSMTPMessage alloc] init];
        
        _emilMessage.fromEmail = kFromEmailAddress;
        
        _emilMessage.toEmail = kToEmailAddress;
        
        _emilMessage.relayHost = kRelayHostAddress;
        
        _emilMessage.requiresAuth = YES;
        
        _emilMessage.login = kFromEmailAddress;
        
        _emilMessage.pass = kLoginParssword;
        _emilMessage.subject = @"";
        _emilMessage.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
        
        _emilMessage.delegate = self;
        
    }
    
    return _emilMessage;
}

- (SNPopoverController *)snPopoverController
{
    if (!_snPopoverController) {
        _snPopoverController = [[SNPopoverController alloc] init];
    }
    return _snPopoverController;
}

- (UserFeedBackService *)userFeedBackService{
    if (!_userFeedBackService) {
        _userFeedBackService = [[UserFeedBackService alloc] init];
        _userFeedBackService.delegate = self;
    }
    return _userFeedBackService;
}

- (void)didSendFeedBackRequestComplete:(UserFeedBackService *)service  Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        isSendSuccess = YES;
        
        if (isEmail == YES) {
            [Config currentConfig].userContractType = @"email";
        }else {
            [Config currentConfig].userContractType = @"phone";
        }
        
        return [self presentCustomDlg:L(@"Send success, thank for your feedback")];
    }else {
        isSendSuccess = NO;
        if (service.isNetWorkError) {
            return [self presentCustomDlg:L(@"ASI_CONNECTION_FAILURE_ERROR")];
        }
        return [self presentCustomDlg:L(@"Send failed")];
    }
}

#pragma mark - 设备类型

- (bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    DLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

@end