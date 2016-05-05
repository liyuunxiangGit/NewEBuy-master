//
//  BoundPhoneViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BoundPhoneViewController.h"
#import "SendCountFromDB.h"
#import "ValidationService.h"
#import "MYEfubaoViewController.h"
#import "ActiveEfubaoViewController.h"
#import "ActiveMyIntegerViewController.h"
#import "NewInviteFriendViewController.h"
#import "SNWebViewController.h"
#define FooterViewHeight 100
#define ButtonHeight     35

@interface BoundPhoneViewController()
{    
    BOOL                         isLogonByPhone_;
    
    NSString                    *phoneNum_;
    
    NSString                    *firstPhoneNum_;
    
    NSString                    *todayDate_;
    
    int                          sendCount_;
}


@property (nonatomic,strong) UILabel                     *checkCodeMessageLabel;

@property (nonatomic,strong) UILabel                     *buttonClickMessageLabel;

@property (nonatomic,strong) UIButton                    *sendMessageButton;

@property (nonatomic,strong) UILabel                     *efubaoAccount;

@property (nonatomic,strong) keyboardNumberPadReturnTextField                 *phoneNumTextField;

@property (nonatomic,strong) UITextField                 *checkCodeTextField;

@property (nonatomic, strong) BoundPhoneService          *boundService;

@property (nonatomic, strong) CheckCodeService           *checkCodeService; 


- (void)reloadView;
- (int)getSendCount:(NSString *)phoneNum;
- (void)reloadTheFooterWhenSendMessage;
- (void)reloadFooterToNormal;
- (void)reloadFooterTOutOfDate;
- (void)boundSuccess;
- (void)variableInit;

- (CGFloat)getLabelHeiht:(NSString *)messageString width:(CGFloat)width  font:(UIFont*)font;


@end

@implementation BoundPhoneViewController
@synthesize checkCodeMessageLabel = checkCodeMessageLabel_;
@synthesize buttonClickMessageLabel = buttonClickMessageLabel_;
@synthesize sendMessageButton = sendMessageButton_;
@synthesize efubaoAccount = efubaoAccount_;
@synthesize phoneNumTextField = phoneNumTextField_;
@synthesize checkCodeTextField = checkCodeTextField_;
@synthesize boundService = _boundService;
@synthesize checkCodeService = _checkCodeService;
@synthesize isEfubaoBound = _isEfubaoBound;
@synthesize isFromPayPage = _isFromPayPage;

#pragma mark - ViewLife Circle Methods
#pragma mark   View的生命周期方法

- (void)dealloc {
    TT_RELEASE_SAFELY(checkCodeMessageLabel_);
    TT_RELEASE_SAFELY(buttonClickMessageLabel_);
    TT_RELEASE_SAFELY(sendMessageButton_);
    TT_RELEASE_SAFELY(efubaoAccount_);
    TT_RELEASE_SAFELY(phoneNumTextField_);
    TT_RELEASE_SAFELY(checkCodeTextField_);
    _boundService.delegate = nil;
    TT_RELEASE_SAFELY(_boundService);
    _checkCodeService.delegate = nil;
    TT_RELEASE_SAFELY(_checkCodeService);
}
- (TPKeyboardAvoidingTableView *)tpTableView
{
	if(!_tpTableView)
    {
		
        _tpTableView = [TPKeyboardAvoidingTableView tableView];
        
		_tpTableView.delegate =self;
		
		_tpTableView.dataSource =self;
        
        _tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if ([_tpTableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        {
            if ([_tpTableView.dataSource isKindOfClass:[UIViewController class]])
            {
                UIViewController *v = (UIViewController *)_tpTableView.dataSource;
                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
                {
                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
                    for (UIGestureRecognizer *ges in _tpTableView.gestureRecognizers) {
                        [nav.panGes requireGestureRecognizerToFail:ges];
                    }
                }
            }
        }
	}
	return _tpTableView;
}

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"boundPhone");
        
        self.pageTitle = L(@"member_myEbuy_bindMobile");
        
        _isEfubaoBound = NO;
        
//        UIBarButtonItem *commitButton = [[UIBarButtonItem alloc]
//                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                         target:self
//                                         action:@selector(commitPhone:)];
//        [self.navigationItem setRightBarButtonItem:commitButton];
//        TT_RELEASE_SAFELY(commitButton);

       // self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"完成"];
        

        [self variableInit];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
    
}

- (void)righBarClick
{
    [self commitPhone:nil];
}


- (void)variableInit{
    
    UserCenter *defaultCenter = [UserCenter defaultCenter];
    
    if (defaultCenter.efubaoStatus==eLoginByPhoneUnBound) {
        
        isLogonByPhone_ = YES;
        
    }else{
        
        isLogonByPhone_ = NO;
        
    }
    
    firstPhoneNum_ = @"";
    
    NSString *todayDate = [NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"];
    
    todayDate_ = [todayDate copy];
    
    DLog(@"%@", todayDate_);
    
    //初始化service，监听定时器
    [self checkCodeService];
}


- (void)loadView
{    
    [super loadView];
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:self.hidesBottomBarWhenPushed];//self.view.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = self.view.frame.size.height - 92 ;
    
    self.tpTableView.frame = frame;
    
    self.tpTableView.delegate = self;
    
    self.tpTableView.dataSource = self;
    
    [self.view addSubview:self.tpTableView];
    
    phoneNum_ = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    [self reloadView];
    
    self.hasSuspendButton = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];

}


#pragma mark  -Button Action Methods
#pragma mark   事件的相应代码

- (void)commitPhone:(id)sender{
    
    NSError *error = nil;
    NSString *errorDesc = nil;
    
    //是否为电话号码
    error = [ValidationService phoneNumChecking:self.phoneNumTextField.text];
    
    if (error.code == kValidationSuccess) {
        
        //是否为数字或者字母
        error = [ValidationService NumOrCharacterChecking:self.checkCodeTextField.text];
        
        if ( error.code == kValidationSuccess) {
            //是否为6位的数字或者字母
            if (self.checkCodeTextField.text.length==6) {
                
                [self displayOverFlowActivityView];
                if  (isLogonByPhone_ == YES) {
                    
                    [self.boundService beginBoundPhoneWhenLogonByPhone:self.phoneNumTextField.text CodeNum:self.checkCodeTextField.text];
                    
                }else{
                    
                    [self.boundService beginBoundPhoneWhenLogonByEmail:self.phoneNumTextField.text CodeNum:self.checkCodeTextField.text];
                }
                
            }else{
                //"CodeNum_Not_6bit"="验证码位数不正确，请输入6位数字或字母验证码";
                
                errorDesc = L(@"CodeNum_Error_Length");
                
                [self presentSheet:errorDesc  posY:50];
                
                [self.checkCodeTextField  becomeFirstResponder];            
            }
            
        }else{
            
            //"CodeNum_Error_NotValide"="验证码不合法，请输入6位数字或字母验证码";
            
            errorDesc = L(@"CodeNum_Error_NotValide");
            
            [self presentSheet:errorDesc posY:50];
            
            [self.checkCodeTextField  becomeFirstResponder];
            
        }
        
    }else{
        
        //"PhoneNum_Error_Length"="请输入11位的手机号码";
        
        errorDesc = L(@"PhoneNum_Error_Length");
        
        [self presentSheet:errorDesc posY:50];
        
        [self.phoneNumTextField  becomeFirstResponder];
        
    }
    
    
}


- (void)sendMessage:(id)sender{
    
    DLog(@"send Message");
    
    [self.phoneNumTextField resignFirstResponder];
    
    NSError *error = nil;
    
    error = [ValidationService phoneNumChecking:self.phoneNumTextField.text];
    
    if (error.code == kValidationSuccess) {
        
        [self reloadTheFooterWhenSendMessage];
        
    }else{
        
        [self presentSheet:L(@"PhoneNum_Not_11bit") posY:50];
        [self.phoneNumTextField  becomeFirstResponder];
        
    }
    
}


#pragma mark - Delegate Methods
#pragma mark   代理的实现方法


- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        sendCount_ ++;
        
        SendCountFromDB *db_ = [[SendCountFromDB alloc] init];
        
        [db_ updateSendCountToDB:phoneNum_ date:todayDate_ count:sendCount_];
        
        TT_RELEASE_SAFELY(db_);
        
        self.sendMessageButton.enabled = YES;
        self.checkCodeMessageLabel.text = L(@"please_check_your_message");
        self.checkCodeMessageLabel.height = [self getLabelHeiht:self.checkCodeMessageLabel.text width:self.checkCodeMessageLabel.width font:self.checkCodeMessageLabel.font];
        
    }else{
        
        [self presentSheet:L(errorDesc) posY:50];
    }
    
}

//设置按钮的是否可点击
- (void)eppGetCodeRemainTimeToRetry:(NSInteger)seconds checkCodeState:(CheckCodeState)status
{
    if(seconds <= 0)
    {
        self.getCodeBtn.enabled = YES;
        [self reloadView];
    }
    else
    {
        self.getCodeBtn.enabled = NO;
        NSString *title = [NSString stringWithFormat:@"%d%@",seconds,L(@"MyEBuy_SecondsAndSendAgain")];
        [self.getCodeBtn setTitle:title
                                forState:UIControlStateDisabled];
    }
}


- (void)didBoundPhoneWhenLogonByEmailComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        [self boundSuccess];
        
    }else{
        
        [self presentSheet:L(errorDesc) posY:50];
        
    }
    
}


- (void)didBoundPhoneWhenLogonByPhoneComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        [self.checkCodeService stopCalculagraph];
        
        [self boundSuccess];
        
    }else{
        
        [self presentSheet:L(errorDesc) posY:50];
        
    }
}

- (void)boundSuccess{
    
    if  (isLogonByPhone_ == YES){
        [UserCenter defaultCenter].efubaoStatus = eLoginByPhoneUnActive; 
    }else{
        [UserCenter defaultCenter].efubaoStatus = eLoginByEmailUnActive; 
    }
    if (self.isFromPayPage)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payPageBoundPhoneOK" object:self userInfo:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeb" object:nil];

        if (self.isEfubaoBound == YES) {
            BBAlertView *alertView = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault Title:nil message:L(@"boungPhone_success") customView:nil delegate:self cancelButtonTitle:L(@"returnTo_myEuy") otherButtonTitles:L(@"goActive_Efubao")];
            
            [alertView show];
            
            [alertView setCancelBlock:^{
                                
                int i=0;
                for (UINavigationController *ctrl in [self.navigationController viewControllers]){
                    if ([ctrl isKindOfClass:[SNWebViewController class]]) {
                        [self.navigationController popToViewController:ctrl animated:YES];
                        i++;
                    }
                }
                for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                    if ([ctrl isKindOfClass:[NewInviteFriendViewController class]]) {
                        [self.navigationController popToViewController:ctrl animated:YES];
                        i++;
                    }
                }
                if (i==0) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } ];
            
            [alertView setConfirmBlock:^{
                
                ActiveEfubaoViewController *controller = [[ActiveEfubaoViewController alloc] init];
                
                [self.navigationController pushViewController:controller animated:YES];
                
                TT_RELEASE_SAFELY(controller);
            } ];
        }else{
            
            BBAlertView *alertView = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault Title:nil message:L(@"integral_boungPhone_success") customView:nil delegate:self cancelButtonTitle:L(@"returnTo_myEuy") otherButtonTitles:L(@"goActive_Efubao")];
            
            [alertView show];
            
            [alertView setCancelBlock:^{
                                
                int i=0;
                for (UINavigationController *ctrl in [self.navigationController viewControllers]){
                    if ([ctrl isKindOfClass:[SNWebViewController class]]) {
                        [self.navigationController popToViewController:ctrl animated:YES];
                        i++;
                    }
                }
                for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                    if ([ctrl isKindOfClass:[NewInviteFriendViewController class]]) {
                        [self.navigationController popToViewController:ctrl animated:YES];
                        i++;
                    }
                }
                if (i==0) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } ];
            
            [alertView setConfirmBlock:^{
                                
                ActiveMyIntegerViewController *controller = [[ActiveMyIntegerViewController alloc] initWithIntegral:[UserCenter defaultCenter].userDiscountInfoDTO.achievement];
                
                [self.navigationController pushViewController:controller animated:YES];
                
                TT_RELEASE_SAFELY(controller);
            } ];
            
        }
    }
}

#pragma mark -  Methods
#pragma mark    声明的方法实现

- (void)reloadView
{
    sendCount_ = [self getSendCount:phoneNum_];
    if (sendCount_ >= 3) {
        [self reloadFooterTOutOfDate];
    }else{
        [self reloadFooterToNormal];
    }    
}

- (void)reloadTheFooterWhenSendMessage{
    
    int count = [self getSendCount:self.phoneNumTextField.text];
    
    if (count >= 3) {
        
        [self reloadFooterTOutOfDate];
        return;
    }
    
    if ([self.checkCodeService available])
    {
        [self displayOverFlowActivityView];
        [self.checkCodeService beginGetCheckCode:self.phoneNumTextField.text checkCodeState:ePhoneCheckCode];
    }
}

- (void)reloadFooterTOutOfDate{
    //"SendCount_Out_Limited"="您今天的验证短信已经发满三次，每天累计最多发送三次验证短信";
    self.sendMessageButton.enabled = YES;
    [self.getCodeBtn setTitle:L(@"get_check_code") forState:UIControlStateDisabled];
    
    [self presentSheet:L(@"SendCount_Out_Limited")];
    self.checkCodeMessageLabel.text = L(@"SendCount_Out_Limited");
    self.checkCodeMessageLabel.height = [self getLabelHeiht:self.checkCodeMessageLabel.text width:self.checkCodeMessageLabel.width font:self.checkCodeMessageLabel.font];
}

- (void)reloadFooterToNormal{
    self.sendMessageButton.enabled = YES;
    self.checkCodeMessageLabel.text = L(@"please_click_get_checkCode");
    self.checkCodeMessageLabel.height = [self getLabelHeiht:self.checkCodeMessageLabel.text width:self.checkCodeMessageLabel.width font:self.checkCodeMessageLabel.font];    
}


- (CGFloat)getLabelHeiht:(NSString *)messageString width:(CGFloat)width  font:(UIFont*)font{
    
    if (messageString == nil || [messageString isEqualToString:@""]) {
        
        return 0.0;
        
    }else{
        
        CGSize size = CGSizeMake(width, 30000);
        
        CGSize labelSize = [messageString sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        return labelSize.height;
        
    }
    
}
//根据用户手机号码，获取本天已经发送的验证码的数量
- (int)getSendCount:(NSString *)phoneNum
{    
    SendCountFromDB *db_ = [[SendCountFromDB alloc] init];
    
    int count = 0;
    
    count =  [db_ getSendCountFromDB:todayDate_ withPhoneNum:phoneNum];
    
    if (count == -1) {
        //今天没有发送过验证短信。
        [db_  updateSendCountToDB:phoneNum date:todayDate_ count:0];
        
        TT_RELEASE_SAFELY(db_);
        
        return 0;
        
    }else{
        TT_RELEASE_SAFELY(db_);
        
        if (count == -2) {
            return 0;
        }
        //今天已经发送了count次验证短信。
        
        return count;
        
    }
    
    
}

#pragma mark - 
#pragma mark TextField Deleagte Methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (isLogonByPhone_ == NO && textField == self.phoneNumTextField && self.phoneNumTextField.text != nil && ![self.phoneNumTextField.text isEqualToString:@""]) {
        
        phoneNum_ = self.phoneNumTextField.text;
        
        sendCount_ = [self getSendCount:phoneNum_];
        
        if (!firstPhoneNum_&&![firstPhoneNum_ isEqualToString:phoneNum_]) {
            
            firstPhoneNum_ = phoneNum_;
            
            [self reloadView];
            
        }else{
            if (self.sendMessageButton.enabled == NO ) {
                return;
            }else{
                [self reloadView];
            }
        }
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
    
}


#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
//    if (section == 2) {
//        
//        return FooterViewHeight;
//        
//    }
    return 20;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 2) {
//        //发送验证码的button以及提示信息的展示的View
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
//        
//        footerView.backgroundColor = [UIColor clearColor];
//        
//        self.sendMessageButton.frame = CGRectMake(10, 10, 300 , ButtonHeight);
//        
//        [footerView addSubview:self.sendMessageButton];
//    
//        
//        return footerView ;
//    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    footerView.backgroundColor = [UIColor clearColor];
    

    footerView.frame = CGRectMake(0, 0, 320 , 19);
    
    return footerView;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [[UITableViewCell alloc]init]; 
//    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
//    cell.textLabel.textColor = [UIColor light_Black_Color];
//    cell.backgroundColor = [UIColor cellBackViewColor];
    
    static NSString *cellIndentifier = @"orderIndentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (nil == cell)
    {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor cellBackViewColor];
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor light_Black_Color];
        
       // UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        //arrow.frame = CGRectMake(0, 0, 18/2, 29/2);
       // cell.accessoryView = arrow;
    }
    
    [cell.contentView removeAllSubviews];

    if (indexPath.section == 0) {
        
        if (self.isEfubaoBound) {
            cell.textLabel.text = L(@"MyEBuy_Account");
        }else{
            cell.textLabel.text = L(@"Integral_Account");
            
        }
        [cell.contentView addSubview:self.efubaoAccount];
    }
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_MobilePhoneNumber")];
        [cell.contentView addSubview:self.phoneNumTextField];
        
    }
    
    if (indexPath.section == 2) {
        
        //cell.textLabel.text = L(@"check_code");
        [cell.contentView addSubview:self.checkCodeTextField];
        
        [cell.contentView addSubview:self.getCodeBtn];
        
       // [cell.contentView addSubview:self.sendMessageButton];
        
    }
    
    if (indexPath.section == 3) {
        
        self.sendMessageButton.frame = CGRectMake(10, 0, 300 , ButtonHeight);
        
        cell.backgroundColor = [UIColor clearColor];
        if (!IOS7_OR_LATER) {

            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            
            v.backgroundColor = [UIColor uiviewBackGroundColor];
            
            [cell.contentView addSubview:v];
        }
        [cell.contentView addSubview:self.sendMessageButton];
        
    }
    
    return cell;
    
}

#pragma mark - TextField Delegate Methods
#pragma mark   TextField代理方法
- (void)doneTapped:(id)sender{
    
    [self.phoneNumTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self commitPhone:nil];
    return YES;
}

#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化防范

- (UILabel *)buttonClickMessageLabel
{    
    if (!buttonClickMessageLabel_) {
        
        buttonClickMessageLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
                
        buttonClickMessageLabel_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        
        buttonClickMessageLabel_.backgroundColor = [UIColor clearColor];
        
        buttonClickMessageLabel_.textColor = [UIColor darkRedColor];
        
        buttonClickMessageLabel_.textAlignment = UITextAlignmentLeft;
        
        buttonClickMessageLabel_.numberOfLines = 0;
        
        buttonClickMessageLabel_.adjustsFontSizeToFitWidth = YES;
        
    }
    return buttonClickMessageLabel_;   
    
    
}



- (UILabel *)checkCodeMessageLabel
{
    
    if (!checkCodeMessageLabel_) {
        
        checkCodeMessageLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
        
        checkCodeMessageLabel_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        
        checkCodeMessageLabel_.text = L(@"please_click_get_checkCode");
        
        checkCodeMessageLabel_.textColor = [UIColor darkRedColor];
        
        checkCodeMessageLabel_.backgroundColor = [UIColor clearColor];
        
        checkCodeMessageLabel_.textAlignment = UITextAlignmentLeft;
        
        checkCodeMessageLabel_.numberOfLines = 0;
        
        checkCodeMessageLabel_.adjustsFontSizeToFitWidth = YES;
    }
    return checkCodeMessageLabel_;   
    
    
}
-(UIButton *)getCodeBtn{
    
    if (!_getCodeBtn) {
        
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _getCodeBtn.frame = CGRectMake(190, 0, 130, 44);
        
        [_getCodeBtn setTitle:L(@"get_check_code") forState:UIControlStateNormal];
        
        [_getCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        _getCodeBtn.backgroundColor = [UIColor colorWithRed:193.0/255 green:193.0/255 blue:193.0/255 alpha:1];
        
        _getCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        [_getCodeBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _getCodeBtn;
}
- (UIButton *)sendMessageButton{
    
    if (!sendMessageButton_) {
        
        sendMessageButton_ = [[UIButton alloc] initWithFrame:CGRectZero];
        
        [sendMessageButton_ addTarget:self action:@selector(righBarClick) forControlEvents:UIControlEventTouchUpInside];
        
//        [_activateButton setBackgroundImage:[UIImage streImageNamed:@"orange_button.png"] forState:UIControlStateNormal];
//        [_activateButton setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"] forState:UIControlStateNormal];
        
        [sendMessageButton_ setBackgroundImage:[UIImage imageNamed:@"orange_button.png"] forState:UIControlStateNormal];
        
        [sendMessageButton_ setTitle:L(@"MyEBuy_NextStep") forState:UIControlStateNormal];
        
        [sendMessageButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [sendMessageButton_ setBackgroundImage:[UIImage imageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
        

        sendMessageButton_.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        sendMessageButton_.titleLabel.textAlignment = UITextAlignmentCenter;
        
       // sendMessageButton_.backgroundColor = [UIColor clearColor];
        
    }
    
    return sendMessageButton_;
    
}

- (UILabel *)efubaoAccount{
    
    
    if (!efubaoAccount_) {
        
        efubaoAccount_ = [[UILabel alloc] initWithFrame:CGRectMake(80, 0,200, 44)];
        
        efubaoAccount_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        efubaoAccount_.textColor = [UIColor light_Black_Color];
        
        efubaoAccount_.backgroundColor = [UIColor clearColor];
        
        efubaoAccount_.textAlignment = UITextAlignmentLeft;
        
        efubaoAccount_.numberOfLines = 0;
        
        efubaoAccount_.adjustsFontSizeToFitWidth = YES;
        
        efubaoAccount_.text = [UserCenter defaultCenter].userInfoDTO.logonId;
    }
    return efubaoAccount_;   
    
    
}

- (keyboardNumberPadReturnTextField *)phoneNumTextField
{
    if (!phoneNumTextField_) {
        phoneNumTextField_ = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(80, 0,200, 44)];
        phoneNumTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneNumTextField_.delegate = self;
        phoneNumTextField_.borderStyle = UITextBorderStyleNone;
        phoneNumTextField_.textAlignment = UITextAlignmentLeft;
        phoneNumTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        if (isLogonByPhone_ == YES) {
            phoneNumTextField_.text = [UserCenter defaultCenter].userInfoDTO.logonId;
            phoneNumTextField_.textColor =[UIColor light_Black_Color] ;
            phoneNumTextField_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
            phoneNumTextField_.enabled = NO;
        }else{
            phoneNumTextField_.placeholder = L(@"please_input_phoneNum");
            phoneNumTextField_.enabled = YES;
            phoneNumTextField_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
            
        }
        phoneNumTextField_.keyboardType = UIKeyboardTypeNumberPad;
    }
    return phoneNumTextField_;
}

- (UITextField *)checkCodeTextField
{    
    if (!checkCodeTextField_) {
        checkCodeTextField_ = [[UITextField alloc] initWithFrame:CGRectMake(20, 0,150, 44)];
        checkCodeTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        checkCodeTextField_.delegate = self;
        checkCodeTextField_.borderStyle = UITextBorderStyleNone;
        checkCodeTextField_.textAlignment = UITextAlignmentLeft;
        checkCodeTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        checkCodeTextField_.keyboardType = UIKeyboardTypeASCIICapable;
        checkCodeTextField_.autocapitalizationType = UITextAutocapitalizationTypeNone;
        checkCodeTextField_.placeholder = L(@"please_input_checkCode");
        checkCodeTextField_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        checkCodeTextField_.returnKeyType = UIReturnKeyGo;
    }
    return checkCodeTextField_;
}

- (BoundPhoneService *)boundService
{    
    if (!_boundService) {
        
        _boundService = [[BoundPhoneService alloc] init];
        
        _boundService.delegate = self;
    }
    return _boundService;
}

- (CheckCodeService *)checkCodeService
{    
    if (!_checkCodeService) {
        
        _checkCodeService = [[CheckCodeService alloc] init];
        
        _checkCodeService.delegate = self;
        
        _checkCodeService.userCal = YES;
    }
    
    return _checkCodeService;
}
@end
