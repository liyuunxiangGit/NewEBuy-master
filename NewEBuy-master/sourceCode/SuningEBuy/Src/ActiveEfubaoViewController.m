//
//  ActiveEfubaoViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ActiveEfubaoViewController.h"
#import "UserCenter.h"
#import "ValidationService.h"
#import "PasswordToggleView.h"
#import "NewInviteFriendViewController.h"
#import "ProOrderListViewController.h"
#import "SNWebViewController.h"
#import "OrderDetailViewController.h"
@interface ActiveEfubaoViewController(){
    
    //完善易付宝资料。
    NSMutableArray              *efubaoInfoArray_;
    //易付宝的激活信息是否已经存储在了config文件中
    BOOL                        isEfubaoInfoConfiged_;
    //数据源：安全问题的数据源。用于存储安全问题的描述。
    NSArray                     *securityQueArray_;
    //数据源：证件类型的数据源。 
    NSArray                     *identifyTypeArray_;
    //安全问题栏是否已经展开
    BOOL                        isQAOpened_;
    //证书类型选项栏是否已经展开
    BOOL                        isIdenTOpened_;
    
    BOOL                        isWillBack_;
    
    BOOL                        isGetIdCode_;
    //是否是手机号码登录
    BOOL                        isLogonByPhone_;
    //安全问题
    NSString                    *securityString_;
    //证书类型
    NSString                    *identifyString_;
    
    //错误提示信息
    NSString                    *alertString_;
    
}

@property (nonatomic,strong) UILabel                     *securityLabel;

@property (nonatomic,strong) UILabel                     *identifyLabel;

@property(nonatomic,strong) UITextField    *nameTextField;

@property(nonatomic,strong) UITextField    *passWordTextField;

@property(nonatomic,strong) UITextField    *reEnterTextField;

@property(nonatomic,strong) UITextField    *securityTextField;

@property(nonatomic,strong) UITextField    *identifyTextField;

@property (nonatomic, strong) ActiveEfubaoService  *activeService;

@property (nonatomic, strong) UITextField    *phoneNumTextField;

@property (nonatomic, strong) UITextField    *identifyingTextField;

@property (nonatomic, strong) UIButton       *getIdentifyingBtn;

@property (nonatomic, strong) CheckCodeService           *checkCodeService; 

@property (nonatomic, strong) NSMutableArray                   *getCodeList;

@property (nonatomic, strong) PasswordToggleView              *passwordToggleView;

//初始化页面的navigationItem
- (void)navigationItemInit;

//初始化页面数据源
- (void)datasourceInit;

//保存当前所填写的信息
- (void)saveEfubaoInfoToConfig;

//对所填写信息进行有效性验证
- (BOOL)valideAll;
- (BOOL)validateName:(NSString *)memberName;
- (BOOL)validePassword:(NSString *)passWord;
- (BOOL)valideReEnter:(NSString *)reEnter;
- (BOOL)valideIdentify:(NSString *)identify;
- (BOOL)validateIdentyString:(NSString *)identyString;
- (BOOL)validatePhoneNum:(NSString *)phoneNum;
- (BOOL)validateIdentifying:(NSString *)indetifyingNum;

@end

@implementation ActiveEfubaoViewController
@synthesize securityLabel = securityLabel_;
@synthesize identifyLabel = identifyLabel_;
@synthesize nameTextField = nameTextField_;
@synthesize passWordTextField = passWordTextField_;
@synthesize reEnterTextField = reEnterTextField_;
@synthesize securityTextField = securityTextField_;
@synthesize identifyTextField = identifyTextField_;
@synthesize activeService = _activeService;

@synthesize phoneNumTextField = _phoneNumTextField;
@synthesize identifyingTextField = _identifyingTextField;
@synthesize getIdentifyingBtn = _getIdentifyingBtn;
@synthesize checkCodeService = _checkCodeService;

@synthesize getCodeList = _getCodeList;



#pragma mark - ViewLife Circle Methods
#pragma mark   View的生命周期方法

- (void)dealloc {
    TT_RELEASE_SAFELY(securityLabel_);
    TT_RELEASE_SAFELY(identifyLabel_);
    TT_RELEASE_SAFELY(nameTextField_);
    TT_RELEASE_SAFELY(passWordTextField_);
    TT_RELEASE_SAFELY(reEnterTextField_);
    TT_RELEASE_SAFELY(securityTextField_);
    TT_RELEASE_SAFELY(identifyTextField_);
    SERVICE_RELEASE_SAFELY(_activeService);
    
    TT_RELEASE_SAFELY(_phoneNumTextField);
    TT_RELEASE_SAFELY(_identifyingTextField);
    TT_RELEASE_SAFELY(_getIdentifyingBtn);
    
    SERVICE_RELEASE_SAFELY(_checkCodeService);
    
    TT_RELEASE_SAFELY(_getCodeList)
}

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"activeEfubao");          
        
        self.pageTitle = L(@"member_myEbuy_activeEfubao");
        
        [self navigationItemInit];
        
        [self datasourceInit];
        
        self.bSupportPanUI = NO;
    }
    
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self.activeService beginSendGeneralEfubaoRequest];
    
    [self.activeService beginSendReadyEfubaoRequest];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [self saveEfubaoInfoToConfig];
    
    isWillBack_ = YES;
    
}

-(void)loadView{
    
    [super loadView];
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:self.hidesBottomBarWhenPushed];//self.view.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = frame.size.height;
    
    self.tpTableView.frame = frame;
    
    [self.view addSubview:self.tpTableView];
    
    self.hasSuspendButton = YES;
    
}

#pragma mark -  ActiveService Delegate Service
#pragma mark    激活易付宝接口调用
- (void)didActiveEfubaoComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    if (isSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeb" object:nil];
        
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailUnActive) {
            [UserCenter defaultCenter].efubaoStatus = eLoginByEmailActive;        
        }else{
            [UserCenter defaultCenter].efubaoStatus = eLoginByPhoneActive;        
        }        
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"activeEfubaoOK") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        [alertView setConfirmBlock:^{
            [Config currentConfig].isBindMobile = [NSNumber numberWithBool:YES];
            int i=0;
            for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                if ([ctrl isKindOfClass:[ProOrderListViewController class]] || [ctrl isKindOfClass:[OrderDetailViewController class]]) {
                    [self.navigationController popToViewController:ctrl animated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackConfirmGoods" object:nil];
                    i++;
                }
            }
            //edit by gjf
            UINavigationController *ctr = [self.navigationController viewControllers].lastObject;
            if([ctr isKindOfClass:[NewInviteFriendViewController class]]){
                [self.navigationController popToViewController:ctr animated:YES];
                return;
            }
            for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
                if ([ctrl isKindOfClass:[SNWebViewController class]]) {
                    [self.navigationController popToViewController:ctrl animated:YES];
                    i++;
                }
            }
            if (i==0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
        
    }else{
        
        [self presentSheet:errorDesc posY:50];
        
    }
}

#pragma mark -  GeneralEfubaoReques Delegate Service
#pragma mark    激活易付宝通用接口调用
- (void)didSendGeneralEfubaoRequestComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    if (!isSuccess) {
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:errorDesc
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert setCancelBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert show];
        
    }
    
}

#pragma mark -  ReadyEfubao Delegate Service
#pragma mark    激活易付宝准备接口调用
- (void)didSendSendReadyEfubaoRequestComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    if ([self.activeService.readyName isKindOfClass:[NSNull class]] || self.activeService.readyName == nil || [self.activeService.readyName isEqualToString:@""]) {
        
    }else{
        
        self.nameTextField.text = self.activeService.readyName;
        self.nameTextField.enabled = NO;
        
    }
    
	
    if ([self.activeService.readyCardType isKindOfClass:[NSNull class]] || self.activeService.readyCardType == nil || [self.activeService.readyCardType isEqualToString:@""]) {
        
    }else{
        
        identifyString_ = self.activeService.readyCardType;
        [self.tpTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]].accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    if ([self.activeService.readyIdCode isKindOfClass:[NSNull class]]||self.activeService.readyIdCode == nil || [self.activeService.readyIdCode isEqualToString:@""]) {
        
        isGetIdCode_ = NO;
        return;
    }else{
        
        isGetIdCode_ = YES;
        self.identifyTextField.text = self.activeService.readyIdCode;
        self.identifyTextField.enabled = NO;
    }
    
    [self.tpTableView reloadData];
    
}


#pragma mark -  Methods
#pragma mark    声明的方法实现

- (void)commitPhone:(id)sender{
    
    if ([self valideAll] == NO) {
        
        [self presentSheet:L(alertString_) posY:50];
        
        return;
    }
    
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        [self.activeService beginActiveEfubao:isLogonByPhone_  validateCode:self.identifyingTextField.text mobile:self.phoneNumTextField.text name:self.nameTextField.text password:self.passWordTextField.text rePassWord:self.reEnterTextField.text identifyType:identifyString_ identifyNum:self.identifyTextField.text securityQ:securityString_ SecurityA:self.securityTextField.text];
    }else{
        
        [self.activeService beginActiveEfubao:isLogonByPhone_  validateCode:nil mobile:nil name:self.nameTextField.text password:self.passWordTextField.text rePassWord:self.reEnterTextField.text identifyType:identifyString_ identifyNum:self.identifyTextField.text securityQ:securityString_ SecurityA:self.securityTextField.text];
    }
    
}

- (void)backForePage
{
    [self goBack:nil];
}

- (void)goBack:(id)sender{
    //gjf 如果从NewInviteFriendViewController进去，返回NewInviteFriendViewController
    UINavigationController *ctr = [self.navigationController viewControllers].lastObject;
    if([ctr isKindOfClass:[NewInviteFriendViewController class]]){
        [self.navigationController popToViewController:ctr animated:YES];
        return;
    }
    for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
        if ([ctrl isKindOfClass:[SNWebViewController class]]) {
            [self.navigationController popToViewController:ctrl animated:YES];
            return;
        }
    }

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)valideAll{
    
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        if ([self validatePhoneNum:self.phoneNumTextField.text] == NO ){
            [self.phoneNumTextField becomeFirstResponder];
            return NO;
        }else{
            if ([self validateIdentifying:self.identifyingTextField.text]==NO ) {
                [self.identifyingTextField becomeFirstResponder];
                return NO;
            }
        }
    }
    
    if ([self validateName:self.nameTextField.text] == NO) {
        [self.nameTextField becomeFirstResponder];
        return  NO;
    }
    
    if ([self validePassword:self.passWordTextField.text] == NO) {
        [self.passWordTextField becomeFirstResponder];
        return NO;
    }
    
    if ([self valideReEnter:self.reEnterTextField.text] == NO) {
        [self.reEnterTextField becomeFirstResponder];
        return NO;
    }
    
    if (IsStrEmpty(securityString_)) {
        //"SecurityType_NOT_Null"="安全问题不能为空，请选择安全问题";
        alertString_ = L(@"SecurityType_NOT_Null");
        [self.securityTextField becomeFirstResponder ];
        return NO;
    }
    
    if (self.securityTextField.text == nil || [self.securityTextField.text isEqualToString:@""] ) {
        alertString_ = L(@"Security_NOT_Null");
        [self.securityTextField becomeFirstResponder ];
        return NO;
    }
    
    //"identifyType_NOT_Null"="";
    if (IsStrEmpty(identifyString_)) {
        //"identifyType_NOT_Null"="证件类型不能为空，请选择证件类型";
        alertString_ = L(@"identifyType_NOT_Null");
        [self.identifyTextField becomeFirstResponder ];
        return NO;
    }
    
    if ([self validateIdentyString:self.identifyTextField.text] == NO) {
        [self.identifyTextField becomeFirstResponder ];
        return NO;
    }
    
    if ([self valideIdentify:self.identifyTextField.text] == NO) {
        [self.identifyTextField becomeFirstResponder];
        return NO;
    }
    
    return YES;
    
}


- (BOOL)validatePhoneNum:(NSString *)phoneNum{
    
    NSError *error = [ValidationService phoneNumChecking:phoneNum];
    
    if (error.code == kValidationFail) {
        NSString *errorStr = [NSString stringWithFormat:@"PhoneNum_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        alertString_ = L(errorStr);
        return NO;
    }else{
        
        alertString_ = @"";
        return YES;    
    } 
}

- (BOOL)validateIdentifying:(NSString *)indetifyingNum{
    
    NSError *error = [ValidationService NumOrCharacterChecking:indetifyingNum];
    if (error.code == kValidationFail) {
        NSString *errorStr = [NSString stringWithFormat:@"CodeNum_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        alertString_ = L(errorStr);
        return NO;
    }else{
        if ([indetifyingNum length] != 6) {
            //"CodeNum_Not_6bit"="验证码位数不正确，请输入6位数字或字母验证码";
            alertString_ = L(@"CodeNum_Error_Length");
            return NO;
        }else{
            alertString_ = @"";
            return YES;    
        }
    }
    
}

- (BOOL)validateName:(NSString *)memberName{
    
    //"Name_Error_Null"="姓名不能为空，请输入2-10位中文字符";
    //"Name_Error_Length"="请输入2-10位中文字符"
    //"Name_Error_NotValide"="请输入2-10位中文字符"
    
    //自动除去空格以及“.”的符号
    NSString *string1 = [memberName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSError *error =  [ValidationService chineseChecking:string2 Frome:2 To:10];
    if (error.code == kValidationFail) {
        NSString *errorStr = [NSString stringWithFormat:@"Name_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        alertString_ = L(errorStr);
        return NO;
    }else{
        alertString_ = @"";
        return YES;    
    }       
    
}

//验证密码是否是数字和字母的合集6-20位
- (BOOL)validePassword:(NSString *)passWord
{
    /*
     "Password_Error_Null"="密码不能为空，请输入6-20位数字和字母的合集";
     "PassWord_Error_NotValide"="密码不合法，请输入6-20位数字和字母的合集";
     "PassWord_Error_Length"="密码不合法，请输入6-20位数字和字母的合集";
     */
    
    NSError *error = [ValidationService  NumAndCharacterChecking:passWord minBit:6 maxBit:20];
    
    if (error.code == kValidationFail) {
        
        NSString *errorStr = [NSString stringWithFormat:@"PassWord_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        
        alertString_ = L(errorStr);
        
        return NO;
        
    }
    
    alertString_ = @"";
    
    return YES;        
}


//验证密码是否是数字和字母的合集6-20位
- (BOOL)valideReEnter:(NSString *)reEnter
{
    if (IsStrEmpty(reEnter) || [reEnter isEqualToString:@""]) {
        
        alertString_ = L(@"MyEBuy_PleaseEnterConfirmPassword");
        
        return NO;
    }
    //"ReEnter_NoEqual_Password"="二次输入密码不一致，请重新输入";
    if ([self.passWordTextField.text isEqualToString:reEnter]==NO) {
        
        alertString_ = L(@"ReEnter_NoEqual_Password");
        
        return NO;
        
    }else{
        
        alertString_ = @"";
        return YES;
        
    }
    
}

//验证身份证是否是18位，且最后一位是数字或者X
- (BOOL)valideIdentify:(NSString *)identify
{
    /*
     "Identify_Error_Null"="证件号不能为空";
     "Identify_Error_Length"="证件号长度不正确，请输入合法的证件号";
     "Identify_Error_NotValide"="证件号不合法，请输入合法的证件号";
     */
    
    if ([[efubaoInfoArray_ objectAtIndex:eIdentifyType] isEqualToString:@"001" ]) {
        
        NSError *error = [ValidationService valideIdentifyCard:identify];
        
        if (error.code == kValidationFail) {
            
            NSString *errorStr = [NSString stringWithFormat:@"Identify_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
            
            alertString_ = L(errorStr);
            
            return NO;
            
        }
        
    }
    
    alertString_ = @"";
    
    return YES;        
}

//@"Identify_Not_Valide"格式不正确
- (BOOL)validateIdentyString:(NSString *)identyString{
    
    NSError *error = [ValidationService NumOrCharacterChecking:identyString];
    
    if (error.code == kValidationFail) {
        
        NSString *errorStr = [NSString stringWithFormat:@"Identify_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        
        alertString_ = L(errorStr);
        
        return NO;
        
    }
    
    alertString_ = @"";
    return YES;
}

- (void)saveEfubaoInfoToConfig{
    
    NSString *userName = [UserCenter defaultCenter].userInfoDTO.logonId ;
    
    if (userName != nil && ![userName isEqualToString:@""]) {
        
        [efubaoInfoArray_ replaceObjectAtIndex:eUsername withObject:userName];
        
    }else{
        
        [efubaoInfoArray_ replaceObjectAtIndex:eName withObject:@""];
        
    }
    
    
    if (self.nameTextField.text != nil && ![self.nameTextField.text isEqualToString:@""]) {
        [efubaoInfoArray_ replaceObjectAtIndex:eName withObject:self.nameTextField.text];
    }else{
        [efubaoInfoArray_ replaceObjectAtIndex:eName withObject:@""];
    }
    
    if (self.securityTextField.text != nil && ![self.securityTextField.text isEqualToString:@""]) {
        [efubaoInfoArray_ replaceObjectAtIndex:eSecurityAnswer withObject:self.securityTextField.text];
    }else{
        [efubaoInfoArray_ replaceObjectAtIndex:eSecurityAnswer withObject:@""];
    }
    
    if (self.identifyTextField.text != nil && ![self.identifyTextField.text isEqualToString:@""]) {
        [efubaoInfoArray_ replaceObjectAtIndex:eIdentifyNum withObject:self.identifyTextField.text];
    }else{
        [efubaoInfoArray_ replaceObjectAtIndex:eIdentifyNum withObject:@""];
    }
    
    if (securityString_ != nil && ![securityString_ isEqualToString:@""]) {
        [efubaoInfoArray_ replaceObjectAtIndex:eSecurityQuestion withObject:securityString_];
    }else{
        [efubaoInfoArray_ replaceObjectAtIndex:eSecurityQuestion withObject:@""];
    }
    
    if (identifyString_ != nil && ![identifyString_ isEqualToString:@""]) {
        [efubaoInfoArray_ replaceObjectAtIndex:eIdentifyType withObject:identifyString_];
    }else{
        [efubaoInfoArray_ replaceObjectAtIndex:eIdentifyType withObject:@""];
    }
    
    if (efubaoInfoArray_ != nil && [efubaoInfoArray_ count]>0) {
        
        [[Config currentConfig] setEfubaoInfoList:efubaoInfoArray_];
        
    }
    
}

- (void)righBarClick
{
    [self commitPhone:nil];
}

- (void)navigationItemInit{
    
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTFinish")];

//    UIBarButtonItem *commitButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commitPhone:)];
//    [self.navigationItem setRightBarButtonItem:commitButton];
//    TT_RELEASE_SAFELY(commitButton);
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
//    [backButton setBackgroundImage :[UIImage imageNamed:@"backToMyEbuy.png"] forState:UIControlStateNormal];
//    UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 50, 28)];
//    buttonTitle.text = @"我的易购";
//    buttonTitle.font = [UIFont boldSystemFontOfSize:12];
//    buttonTitle.textColor = [UIColor whiteColor];
//    buttonTitle.backgroundColor = [UIColor clearColor];
//    [backButton addSubview:buttonTitle];
//    TT_RELEASE_SAFELY(buttonTitle);
//    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [self.navigationItem setLeftBarButtonItem:item];
//    TT_RELEASE_SAFELY(backButton);
//    TT_RELEASE_SAFELY(item);
    
}

- (void)datasourceInit{
    
    self.getCodeList = [Config currentConfig].getCodeList;
    /*"customPro"="自定义问题";
     "4"="我妈妈的名字是什么？";
     "5"="我爸爸的名字是什么？";
     "6"="我的出生地再哪？";
     "7"="我爱人的名字是什么？";
     "8"="我爱人的生日是什么？";
     "9"="我初中学校校名是什么？";
     "10"="我妈妈的生日是什么？";
     "11"="我外公的名字是什么？";
     */
    
    securityQueArray_ = [NSArray arrayWithObjects:@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
    
    /*
     "001"="居民身份证";
     "005"="护照";
     "006"="军人证";
     */
    identifyTypeArray_ = [NSArray arrayWithObjects:@"001",@"005",@"006",nil];
    
    isIdenTOpened_ = NO;
    
    isQAOpened_ = NO;
    
    isWillBack_ = NO;
    
    UserCenter *defaltCenter = [UserCenter defaultCenter];
    
    NSArray *tempArray = [Config currentConfig].efubaoInfoList;
    
    if (tempArray != nil && [tempArray count]>0) {
        
        efubaoInfoArray_ = [[NSMutableArray alloc] initWithArray:tempArray];
        
        NSString *userName = defaltCenter.userInfoDTO.logonId;
        
        NSString *infoUserName = [efubaoInfoArray_ objectAtIndex:eUsername];
        
        if ([userName isEqualToString:infoUserName]) {
            
            isEfubaoInfoConfiged_ = YES;
            securityString_ = [efubaoInfoArray_ objectAtIndex:eSecurityQuestion];
            identifyString_ = [efubaoInfoArray_ objectAtIndex:eIdentifyType];
            
        }else{
            
            TT_RELEASE_SAFELY(efubaoInfoArray_);
            efubaoInfoArray_ = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"", nil];
            isEfubaoInfoConfiged_ = NO;
            securityString_ = @"";
            identifyString_ = @"";
        }
        
    }else{
        
        efubaoInfoArray_ = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"", nil];
        isEfubaoInfoConfiged_ = NO;
        securityString_ = @"";
        identifyString_ = @"";
    }
    
    if (defaltCenter.efubaoStatus == eLoginByPhoneUnActive) {
        
        isLogonByPhone_ = YES;
        
    }else{
        
        isLogonByPhone_ = NO;
        
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark - CheckCode Methods
#pragma mark   验证码方法

- (void)getIdentifying:(id)sender{
    
    if (![self validatePhoneNum:self.phoneNumTextField.text]) {
        [self.phoneNumTextField becomeFirstResponder];
        [self presentSheet:alertString_ posY:50];
        return;
    }
    
    if ([self.getCodeList count] != 0) {
        for (NSString *CountString in self.getCodeList) {
            NSArray *CountList = [CountString componentsSeparatedByString:@","];
            if ([[CountList objectAtIndex:0] isEqualToString:self.phoneNumTextField.text]) {
                if ([[CountList objectAtIndex:2] intValue] == 3) {
                    [self presentSheet:L(@"Sorry,you can get only three times everyDay") posY:80];
                    return;
                }
            }
        }
    }
    
    [self.checkCodeService beginGetCheckCode:self.phoneNumTextField.text checkCodeState:eEfubaoCheckCode];
}


- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        [self presentSheet:L(@"Code is sending,please enclosed") posY:80];
        self.getCodeList = [Config currentConfig].getCodeList;
        if ([self.getCodeList count] == 0) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSString stringWithFormat:@"%@,%@,%@",self.phoneNumTextField.text,[Preferences yearMonthDay],@"1"]];
            [Config currentConfig].getCodeList = array;
            TT_RELEASE_SAFELY(array);
        }
        else{
            for (NSString *CountString in self.getCodeList) {
                NSArray *CountList = [CountString componentsSeparatedByString:@","];
                if ([[CountList objectAtIndex:0] isEqualToString:self.phoneNumTextField.text]) {
                    if ([[CountList objectAtIndex:2] intValue] <= 3) {
                        [self.getCodeList removeObject:CountString];
                        int count = [[CountList objectAtIndex:2] intValue] +1;                    
                        [self.getCodeList addObject:[NSString stringWithFormat:@"%@,%@,%d",self.phoneNumTextField.text,[Preferences yearMonthDay],count]];
                        [Config currentConfig].getCodeList = self.getCodeList;
                        DLog(@"%@",[[Config currentConfig].getCodeList description]);
                        return;
                    }
                }
            }
            [self.getCodeList addObject:[NSString stringWithFormat:@"%@,%@,%@",self.phoneNumTextField.text,[Preferences yearMonthDay],@"1"]];
            [Config currentConfig].getCodeList = self.getCodeList;
            DLog(@"%@",[[Config currentConfig].getCodeList description]); 
        }
    }else{
        [self presentSheet:L(errorDesc) posY:50];
    }
    
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        return 5;
    }else{
        return 4;
    }    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return 2;
    }
    
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        if (section == 2) {
            return 2;
        }else{
            section --;
        }
    }
    
    if (section == 2) {
        
        if (isQAOpened_ == YES) {
            
            return 2+[securityQueArray_ count];
            
        }else{
            
            return 2;
            
        }
    }
    
    if (section == 3) {
        
        if (isGetIdCode_ == YES) {
            
            return 2;
            
        }else{
            
            if (isIdenTOpened_ == YES) {
                
                return 2+[identifyTypeArray_ count];
                
            }else{
                
                return 2;
                
            }
            
        }
        
        
    }
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    static NSString *cellIndentifier = @"orderIndentifier";
//    
//    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//    
//    if (nil == cell)
//    {
       SNUITableViewCell  *cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor cellBackViewColor];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(20, 0, 80, 44);
        titleLabel.textAlignment  = UITextAlignmentLeft;
        titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor darkTextColor];
        [cell addSubview:titleLabel];
//    }
    
//    UITableViewCell *cell = [[UITableViewCell alloc]init]; 
//    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.backgroundColor = [UIColor cellBackViewColor];
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.frame = CGRectMake(20, 0, 80, 44);
//    titleLabel.textAlignment  = UITextAlignmentLeft;
//    titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = [UIColor darkTextColor];
//    [cell addSubview:titleLabel];
    
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        //"name"="姓名";
        titleLabel.text = L(@"name");
        [cell.contentView addSubview:self.nameTextField];
    }
    
    if (section == 1) {
        
        if (indexPath.row == 0) {
            titleLabel.text = L(@"passWord");
            [cell.contentView addSubview:self.passWordTextField];
            
            self.passwordToggleView.left = self.passWordTextField.right+5;
            self.passwordToggleView.top = 10;
            
            [cell.contentView addSubview:self.passwordToggleView];
            
            //"passWord"="密码";
        }else{
            
            //"re_Enter"="确认密码";
            titleLabel.text = L(@"re_Enter");
            [cell.contentView addSubview:self.reEnterTextField];
            
        }
    }
    
    //邮箱登陆且手机未绑定
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                titleLabel.text = L(@"PhoneNum");
                [cell.contentView addSubview:self.phoneNumTextField];
                
            }
            if (indexPath.row == 1) {
                titleLabel.text = L(@"Identifying");
                [cell.contentView addSubview:self.identifyingTextField];
                [cell.contentView addSubview:self.getIdentifyingBtn];
                
            }
            TT_RELEASE_SAFELY(titleLabel);
            return cell;
        }else{
            
            section --;
        }        
    }
    
    
    switch (section) {
        case 2:{
            
            if (isQAOpened_ == NO) {
                
                if (indexPath.row == 0) {
                    //"Select_Security_Question"="请选择安全问题"
                    titleLabel.text = L(@"Select_Security_Question");
                    if (!IsStrEmpty(securityString_)) {
                        [cell.contentView addSubview:self.securityLabel];
                        self.securityLabel.textColor = [UIColor lightGrayColor];
                        self.securityLabel.textAlignment = UITextAlignmentRight;
                        self.securityLabel.textColor = [UIColor skyBlueColor];
                        self.securityLabel.text = L(securityString_);
                    }else{
                        
                        [cell.contentView addSubview:self.securityLabel];
                        self.securityLabel.textColor = [UIColor lightGrayColor];
                        self.securityLabel.textAlignment = UITextAlignmentLeft;
                        self.securityLabel.text = L(@"select");                    
                        
                    }
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                
                if ( indexPath.row == 1) {
                    //"Enter_security_Answer"="答案"
                    titleLabel.text = L(@"Enter_security_Answer");
                    [cell.contentView addSubview:self.securityTextField]; 
                }
            }else{
                
                if (indexPath.row == 0) {
                    //"Select_Security_Question"="请选择安全问题";
                    cell.textLabel.text = L(@"Select_Security_Question");
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }else{
                    
                    if (indexPath.row == [securityQueArray_ count]+2-1) {
                        
                        //"Enter_security_Answer"="答案"
                        cell.textLabel.text = L(@"Enter_security_Answer");
                        [cell.contentView addSubview:self.securityTextField];                        
                        
                    }else{
                        
                        cell.textLabel.text = L([securityQueArray_ objectAtIndex:indexPath.row-1]);
                        cell.textLabel.textAlignment = UITextAlignmentCenter;
                        cell.textLabel.font = [UIFont systemFontOfSize:14];
                        cell.textLabel.textColor = [UIColor lightGrayColor];
                        
                    }
                }
            }
        }
            break;
        case 3:{
            
            if (isGetIdCode_ == YES) {
                
                if (indexPath.row == 0) {
                    //"Select_Identity_Style"="请选择证件类型";
                    titleLabel.text = L(@"Select_Identity_Style");
                    [cell.contentView addSubview:self.identifyLabel];
                    self.identifyLabel.textAlignment = UITextAlignmentRight;
                    self.identifyLabel.text = L(identifyString_);
                    self.identifyLabel.textColor = [UIColor skyBlueColor];
                    cell.accessoryType = UITableViewCellAccessoryNone;                    
                }
                
                if (indexPath.row == 1) {
                    //"Enter_Identity_Number"="证件号";
                    titleLabel.text = L(@"Enter_Identity_Number");
                    [cell.contentView addSubview:self.identifyTextField];
                }
            }else{
                if (isIdenTOpened_ == NO) {
                    
                    if (indexPath.row == 0) {
                        //"Select_Identity_Style"="请选择证件类型";
                        titleLabel.text = L(@"Select_Identity_Style");
                        [cell.contentView addSubview:self.identifyLabel];
                        if (identifyString_ != nil && ![identifyString_ isEqualToString:@""]) {
                            self.identifyLabel.textAlignment = UITextAlignmentRight;
                            self.identifyLabel.text = L(identifyString_);
                            self.identifyLabel.textColor = [UIColor skyBlueColor];
                        }else{
                            //"Enter_identify_Answer"="答案"
                            self.identifyLabel.text = L(@"select");
                            self.identifyLabel.textAlignment = UITextAlignmentLeft;
                            [cell.contentView addSubview:self.identifyLabel];
                        }
                        
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        
                    }
                    
                    if (indexPath.row == 1) {
                        //"Enter_Identity_Number"="证件号";
                        titleLabel.text = L(@"Enter_Identity_Number");
                        [cell.contentView addSubview:self.identifyTextField];
                    } 
                }else{
                    
                    if (indexPath.row == 0) {
                        //"Select_Identity_Style"="请选择证件类型";
                        
                        titleLabel.text = L(@"Select_Identity_Style");
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        
                    }else {
                        
                        if (indexPath.row != [identifyTypeArray_ count]+2-1) {
                            cell.textLabel.textAlignment = UITextAlignmentCenter;
                            cell.textLabel.textColor = [UIColor lightGrayColor];
                            cell.textLabel.font = [UIFont systemFontOfSize:14];
                            cell.textLabel.text = L([identifyTypeArray_ objectAtIndex:indexPath.row -1]);
                            
                        }else{
                            //"Enter_Identity_Number"="证件号";
                            titleLabel.text = L(@"Enter_Identity_Number");
                            [cell.contentView addSubview:self.identifyTextField];                            
                        }
                        
                    }
                }
            }
        }
            break;
            
        default:
            break;
            
    }
    
    TT_RELEASE_SAFELY(titleLabel);
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    
    //邮箱登陆且手机未绑定
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        section --;
    }
    
    if (section == 2 ) {        
        if (isQAOpened_ == YES) {
            
            if (indexPath.row == 0) {
                
                [tableView cellForRowAtIndexPath:indexPath];                
                
            }
            if (indexPath.row != 0 && indexPath.row != [securityQueArray_ count]+2-1) {
                
                securityString_ = [securityQueArray_ objectAtIndex:indexPath.row -1];
                
                if (securityString_!=nil && ![securityString_ isEqualToString:@""]) {
                    [efubaoInfoArray_ replaceObjectAtIndex:eSecurityQuestion withObject:securityString_];
                    
                }
                
                isQAOpened_ = NO;
                
                [self.tpTableView reloadData];
                
            }
            
            if (indexPath.row == 0) {
                
                isQAOpened_ = NO;
                [self.tpTableView reloadData];
                
            }
            
            
            return;
            
        }else{
            
            if (indexPath.row == 0) {
                
                isQAOpened_ = YES;
                [self.tpTableView reloadData];
                
            }else{
                
                return;
                
            }
            
        }
        
        if (isQAOpened_ == YES) {
            
            [self.tpTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];            
            
        }
        
        return;
    }
    
    if (section == 3 ) {
        
        if (isGetIdCode_ == YES) {
            
            return;
            
        }else{
            
            if (isIdenTOpened_ == YES) {
                
                if (indexPath.row != 0 && indexPath.row != [identifyTypeArray_ count]+2-1) {
                    
                    identifyString_ = [identifyTypeArray_ objectAtIndex:indexPath.row - 1];
                    
                    if (identifyString_ != nil && ![identifyString_ isEqualToString:@""]) {
                        
                        [efubaoInfoArray_ replaceObjectAtIndex:eIdentifyType withObject:identifyString_];
                    }
                    
                    isIdenTOpened_ = NO;
                    
                    [self.tpTableView reloadData];
                    
                }
                
                if (indexPath.row == 0) {
                    
                    isIdenTOpened_ = NO;
                    [self.tpTableView reloadData];
                    
                }
                
                
                return;
                
            }else{
                
                if (indexPath.row == 0) {
                    isIdenTOpened_ = YES;
                    [self.tpTableView reloadData];
                    
                }else{
                    return;
                }
            }
            if (isIdenTOpened_ == YES) {
                [self.tpTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];            
            }
            return;
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    v.backgroundColor = [UIColor clearColor];
    
    return v;
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}
#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法

- (PasswordToggleView *)passwordToggleView
{
    if (!_passwordToggleView) {
        _passwordToggleView = [[PasswordToggleView alloc] init];
        
        [_passwordToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];

    }
    return _passwordToggleView;
}
- (void)changePasswordShowState
{
    self.passWordTextField.secureTextEntry = !self.passwordToggleView.isShowWords;
    self.reEnterTextField.secureTextEntry = !self.passwordToggleView.isShowWords;
}
-(UITextField *)nameTextField{
    //"2-6bit_Chinese_Character"="请输入2-6位中文汉字字符";
    
    if (!nameTextField_) {
        nameTextField_ = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,150, 44)];
        nameTextField_.tag = eName;
        nameTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTextField_.delegate = self;
        nameTextField_.borderStyle = UITextBorderStyleNone;
        nameTextField_.textAlignment = UITextAlignmentLeft;
        nameTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // nameTextField_.placeholder = L(@"2-6bit_Chinese_Character");
        nameTextField_.placeholder = L(@"Must_Enter");
        nameTextField_.font = [UIFont  systemFontOfSize:14];
        nameTextField_.returnKeyType = UIReturnKeyDone;
        if (isEfubaoInfoConfiged_ == YES) {
            nameTextField_.text = [efubaoInfoArray_ objectAtIndex:eName];
        }else{
            nameTextField_.text = @"";
        }
    }
    return nameTextField_;
}

-(UITextField *)passWordTextField{
    //"6-29bit_Number_And_letter"="请输入6-29位的数字和字母组合";
    if (!passWordTextField_) {
        passWordTextField_ = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,160, 44)];
        passWordTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        passWordTextField_.delegate = self;
        passWordTextField_.borderStyle = UITextBorderStyleNone;
        passWordTextField_.textAlignment = UITextAlignmentLeft;
        passWordTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //  passWordTextField_.placeholder =L(@"6-29bit_Number_And_letter");
        passWordTextField_.returnKeyType = UIReturnKeyDone;
        passWordTextField_.secureTextEntry = YES;
        passWordTextField_.placeholder = L(@"PVPleaseInput6-20NumberAndLetterCombination");// L(@"Must_Enter");
        
        passWordTextField_.font = [UIFont  systemFontOfSize:14];
        
    }
    return passWordTextField_;
}

-(UITextField *)reEnterTextField{
    //"ReEnter_Password"="二次输入确认密码";
    if (!reEnterTextField_) {
        reEnterTextField_ = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,160, 44)];
        reEnterTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        reEnterTextField_.delegate = self;
        reEnterTextField_.borderStyle = UITextBorderStyleNone;
        reEnterTextField_.textAlignment = UITextAlignmentLeft;
        reEnterTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // reEnterTextField_.placeholder = L(@"ReEnter_Password");
        reEnterTextField_.placeholder = L(@"Must_Enter");
        reEnterTextField_.returnKeyType = UIReturnKeyDone;
        reEnterTextField_.secureTextEntry = YES;
        
        reEnterTextField_.font = [UIFont  systemFontOfSize:14];
        
    }
    return reEnterTextField_;
}

-(UITextField *)securityTextField{
    //"1-16bit_Chinese_Character"="由1-16个中文字符组成，请牢记答案";
    if (!securityTextField_) {
        securityTextField_ = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,150, 44)];
        securityTextField_.tag = eSecurityAnswer;
        securityTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        securityTextField_.delegate = self;
        securityTextField_.borderStyle = UITextBorderStyleNone;
        securityTextField_.textAlignment = UITextAlignmentLeft;
        securityTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //  securityTextField_.placeholder = L(@"1-16bit_Chinese_Character");
        securityTextField_.placeholder = L(@"Must_Enter");
        securityTextField_.adjustsFontSizeToFitWidth = YES;
        securityTextField_.returnKeyType = UIReturnKeyDone;
        securityTextField_.font = [UIFont  systemFontOfSize:14];
        if (isEfubaoInfoConfiged_ == YES) {
            securityTextField_.text = [efubaoInfoArray_ objectAtIndex:eSecurityAnswer];
        }else{
            securityTextField_.text = @"";
        }
    }
    return securityTextField_;
}

-(UITextField *)identifyTextField{
    //"Enter_Real_Num"="请填写真实的证件号码";
    if (!identifyTextField_) {
        identifyTextField_ = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,150, 44)];
        identifyTextField_.adjustsFontSizeToFitWidth = YES;
        identifyTextField_.tag = eIdentifyNum;
        identifyTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        identifyTextField_.delegate = self;
        identifyTextField_.borderStyle = UITextBorderStyleNone;
        identifyTextField_.textAlignment = UITextAlignmentLeft;
        identifyTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // identifyTextField_.placeholder = L(@"Enter_Real_Num")
        identifyTextField_.placeholder = L(@"Must_Enter");
        identifyTextField_.returnKeyType = UIReturnKeyDone;
        if (isEfubaoInfoConfiged_ == YES) {
            identifyTextField_.text = [efubaoInfoArray_ objectAtIndex:eIdentifyNum];
            identifyTextField_.font = [UIFont  systemFontOfSize:14];
            
        }else{
            identifyTextField_.text = @"";
            identifyTextField_.font = [UIFont  systemFontOfSize:14];
        }
    }
    return identifyTextField_;
}

-(UILabel *)securityLabel{
    
    if (!securityLabel_) {
        
        securityLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(100, 0,150, 44)];
        securityLabel_.backgroundColor = [UIColor clearColor];
        securityLabel_.font = [UIFont systemFontOfSize:14];
        securityLabel_.textColor = [UIColor lightGrayColor];
        securityLabel_.textAlignment = UITextAlignmentRight;
        securityLabel_.adjustsFontSizeToFitWidth = YES;
        securityLabel_.text = @"";
        
    }
    
    return securityLabel_;
    
}

-(UILabel *)identifyLabel{
    
    if (!identifyLabel_) {
        
        identifyLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(100, 0,150, 44)];
        identifyLabel_.backgroundColor = [UIColor clearColor];
        identifyLabel_.font = [UIFont systemFontOfSize:14];
        identifyLabel_.textColor = [UIColor lightGrayColor];
        identifyLabel_.textAlignment = UITextAlignmentRight;
        identifyLabel_.adjustsFontSizeToFitWidth = YES;
        if (isEfubaoInfoConfiged_ == YES) {
            identifyLabel_.text = [efubaoInfoArray_ objectAtIndex:eIdentifyType];
        }else{
            identifyLabel_.text = @"";
        }
    }
    
    return identifyLabel_;
    
}


- (ActiveEfubaoService *)activeService {
    
    if (!_activeService) {
        _activeService = [[ActiveEfubaoService alloc] init];
        
        _activeService.delegate = self;
    }
    
    return _activeService;
    
}


#pragma mark -  CheckCode
#pragma mark    验证码

- (CheckCodeService *)checkCodeService{
    if (!_checkCodeService) {
        _checkCodeService = [[CheckCodeService alloc] init];
        _checkCodeService.delegate = self;
    }
    return _checkCodeService;
}


//手机号码输入框
- (UITextField *)phoneNumTextField{
    
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,150, 44)];
        _phoneNumTextField.placeholder = L(@"required");
      _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.backgroundColor = [UIColor clearColor];
        _phoneNumTextField.delegate = self;
        _phoneNumTextField.borderStyle = UITextBorderStyleNone;
        _phoneNumTextField.font = [UIFont systemFontOfSize:14];
        _phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _phoneNumTextField;
}
//验证码输入框
- (UITextField *)identifyingTextField{
    
    if (!_identifyingTextField) {
        _identifyingTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0,100, 44)];
        _identifyingTextField.placeholder = L(@"required");
        _identifyingTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _identifyingTextField.backgroundColor = [UIColor clearColor];
        _identifyingTextField.delegate = self;
        _identifyingTextField.returnKeyType = UIReturnKeyDone;
        _identifyingTextField.borderStyle = UITextBorderStyleNone;
        _identifyingTextField.font = [UIFont systemFontOfSize:14];
        _identifyingTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _identifyingTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return _identifyingTextField;
}

//获取验证码按钮
- (UIButton *)getIdentifyingBtn{
    
    if (!_getIdentifyingBtn) {
        _getIdentifyingBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 7, 90, 30)];
        [_getIdentifyingBtn setTitle:L(@"Get indentify") forState:UIControlStateNormal];
        [_getIdentifyingBtn setTitleColor:RGBCOLOR(82, 92, 137) forState:UIControlStateNormal];
        [_getIdentifyingBtn setBackgroundImage:[UIImage imageNamed:kProductDetailAddToShoppingCarWithNoStore] forState:UIControlStateNormal];
        _getIdentifyingBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _getIdentifyingBtn.backgroundColor = [UIColor clearColor];
        _getIdentifyingBtn.layer.cornerRadius = 5;
        [_getIdentifyingBtn addTarget:self action:@selector(getIdentifying:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getIdentifyingBtn;
}

@end
