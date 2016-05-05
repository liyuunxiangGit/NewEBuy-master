//
//  MobilePayByYiFuBaoViewController.m
//  SuningEBuy
//
//  Created by david david on 12-8-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "MobilePayByYiFuBaoViewController.h"
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "UserCenter.h"
#import "CustomerPayTextField.h"


@interface MobilePayByYiFuBaoViewController(){
    //是否正在加载。避免重复请求
    BOOL                isLoading;
}

@property(nonatomic,strong)UILabel *yifubaoBalanceLbl;              //易付宝余额标签
@property(nonatomic,strong)UILabel *factPriceLbl;                   //实际支付金额标签
@property(nonatomic,strong)UITextField  *passwordTextField;          //密码输入框
@property(nonatomic,copy  )NSString *password;                      //支付密码
@property (nonatomic, strong) EfubaoAccountService  *efubaoAcountService;
@property (nonatomic, strong) MobilePayService      *mobilePayService;
@property (nonatomic, strong)NSString *validateCode;//易付宝支付校验码
@property (nonatomic, strong) CustomerPayTextField           *verifyField;
@property (nonatomic,strong)  UIButton              *verifyBtn;

@property (nonatomic, strong) UIImageView *line1;
@property (nonatomic, strong) UIImageView *line2;

- (void)switchToPaySuccessPage;
- (void)switchToPayment;
- (void)submit:(id)sender;
- (void)getVerifyCode:(id)sender;
@end


@implementation MobilePayByYiFuBaoViewController

@synthesize yifubaoBalanceLbl = _yifubaoBalanceLbl;
@synthesize factPriceLbl = _factPriceLbl;
@synthesize passwordTextField = _passwordTextField;
@synthesize paySource = _paySource;
@synthesize password = _password;
@synthesize efubaoAcountService = _efubaoAcountService;
@synthesize mobilePayService = _mobilePayService;

@synthesize validateCode = _validateCode;
@synthesize verifyField = _verifyField;
@synthesize verifyBtn = _verifyBtn;
@synthesize eppValidateService = _eppValidateService;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_yifubaoBalanceLbl);
    TT_RELEASE_SAFELY(_factPriceLbl);
    TT_RELEASE_SAFELY(_passwordTextField);
    TT_RELEASE_SAFELY(_paySource);
    TT_RELEASE_SAFELY(_password);
    SERVICE_RELEASE_SAFELY(_efubaoAcountService);
    SERVICE_RELEASE_SAFELY(_mobilePayService);
    TT_RELEASE_SAFELY(_validateCode);
    TT_RELEASE_SAFELY(_verifyField);
    TT_RELEASE_SAFELY(_verifyBtn);
    
    SERVICE_RELEASE_SAFELY(_eppValidateService);
    
    
}


- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"yifubaoPayWay");
        
        self.pageTitle = L(@"shopProcess_pay_virtualPay");

        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Pay")];

        [self eppValidateService];
        
    }
    
    return self;
}

- (void)righBarClick
{
    [self submit:nil];
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.efubaoAcountService beginGetEfubaoAccountInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopVerifyTime) name:STOP_VERIFY_CALCULAGRAPH object:nil];
}

-(void)loadView{

    [super loadView];
    
    self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.tpTableView.scrollEnabled =NO;
    UIView *view =[[UIView alloc]init];
    view.backgroundColor =[UIColor clearColor];
    
    self.tpTableView.tableFooterView =view;
    
    [self.view addSubview:self.tpTableView];
    
}


#pragma mark - HttpREquest Initialization Metnods
#pragma mark   数据请求的回调方法

- (void)requestValidateCodeComplete:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        DLog(@"验证码获取成功");
    }
    else
    {
        DLog(@"验证码获取失败");
        [self presentSheet:errorMsg?errorMsg:L(@"VPGetVerfyCodeSuccess")];
    }
}

- (void)getVerifyCodeCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) 
    {
        DLog(@"验证码获取成功");
    }
    else
    {
        DLog(@"验证码获取失败");
        [self presentSheet:errorMsg?errorMsg:L(@"VPGetVerfyCodeSuccess")];
    }
}


- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        self.paySource.yifubaoMoney = self.efubaoAcountService.efubaoBalance;
        [self.tpTableView reloadData];
    }else{
        [self presentSheet:errorMsg posY:50];
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
    //[self.passwordTextField becomeFirstResponder];
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) 
    {
        [self switchToPaySuccessPage];
    }
    else
    {
        [self switchToPayment];
    }
}

- (void)didSendMobilePayCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{

    isLoading = NO;
    [self removeOverFlowActivityView];
    if (isSuccess) {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
                                                        message:L(@"pay_Successed")
                                                       delegate:self
                                              cancelButtonTitle:L(@"Check Order")
                                              otherButtonTitles:L(@"Pay Again")];
        [alert show];
    }else{
    
        [self presentSheet:L(errorMsg)];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


#pragma mark - UIView
-(UILabel *)yifubaoBalanceLbl{

    if (_yifubaoBalanceLbl == nil) {
        
        _yifubaoBalanceLbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 180, 44)];
        
        _yifubaoBalanceLbl.backgroundColor = [UIColor clearColor];
        
        _yifubaoBalanceLbl.textColor = [UIColor orange_Red_Color];
    }
    
    return _yifubaoBalanceLbl;
}


-(UILabel *)factPriceLbl{
    
    if (_factPriceLbl == nil) {
        
        _factPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 180, 44)];
        
        _factPriceLbl.backgroundColor = [UIColor clearColor];
        
        _factPriceLbl.textColor = [UIColor orange_Red_Color];
    }
    
    return _factPriceLbl;
}

-(UITextField *)passwordTextField{

    if (_passwordTextField == nil) {
        
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, 180, 44)];
        
        _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _passwordTextField.placeholder = L(@"Please input your efubao password");
        
        _passwordTextField.secureTextEntry = YES;
        
        _passwordTextField.returnKeyType = UIReturnKeyGo;
        
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        
        _passwordTextField.delegate = self;
    }
    
    return _passwordTextField;
}

- (UIImageView *)line2
{
    if (!_line2) {
        _line2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray"]];
        _line2.frame = CGRectMake(109, 5, 1, 30);
    }
    return _line2;
}

- (UIImageView *)line1
{
    if (!_line1) {
        _line1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray"]];
        _line1.frame = CGRectMake(109, 5, 1, 30);
    }
    return _line1;
}

-(CustomerPayTextField *)verifyField
{
    if(!_verifyField)
    {
        _verifyField = [[CustomerPayTextField alloc] init];
        _verifyField.frame = CGRectMake(120, 2, 110, 39);
        _verifyField.borderStyle = UITextBorderStyleNone;
        _verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
        _verifyField.keyboardType = UIKeyboardTypeASCIICapable;
        _verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _verifyField.returnKeyType = UIReturnKeyDone;
        _verifyField.textAlignment = UITextAlignmentLeft;
        _verifyField.placeholder = L(@"input_EfuBao_VerifyNum");
//        _verifyField.font = [UIFont systemFontOfSize:12.0f];
        _verifyField.delegate = self;
    }
    return _verifyField;
}

-(UIButton*)verifyBtn
{
    if (!_verifyBtn) 
    {
        _verifyBtn = [[UIButton alloc] init];                      
        _verifyBtn.frame = CGRectMake(255, 7, 55, 30);
        [_verifyBtn setTitle:L(@"get_VerifyCode") forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:[UIColor orange_Light_Color]forState:UIControlStateNormal];
        [_verifyBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiu"] forState:UIControlStateNormal];
        _verifyBtn.layer.masksToBounds = YES;
//        _verifyBtn.layer.cornerRadius = 4;
        // [_verifyBtn setBackgroundColor:[UIColor blueColor]];
        [_verifyBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];        
    }
    return _verifyBtn;
}

#pragma mark -
#pragma mark text field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    
    NSCharacterSet *cs;          
    if(textField == _verifyField)  
    {  
        cs = [[NSCharacterSet characterSetWithCharactersInString:NormalChacracter] invertedSet];          
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];          
        BOOL basicTest = [string isEqualToString:filtered];  
        if(!basicTest)  
        {          
            [self presentSheet:L(@"Please_input_correct_VerifyNum") posY:50];
            return NO;  
        }      
    }   
    return YES;          
    
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.passwordTextField) {
        
        if(_verifyField.text.length == 0)
        {
            [self presentSheet:L(@"please_firstInput_VerifyCode")posY:50];
            [_verifyField becomeFirstResponder];
            return NO;
        }        
        NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];    
        NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
        if ([verifyCodeTest evaluateWithObject:_verifyField.text]==NO) {            
            [self presentSheet:L(@"Please_input_correct_VerifyNum")posY:50];
            [_verifyField becomeFirstResponder];
            return NO;                       
        }         

    }
    
    return  YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.passwordTextField resignFirstResponder];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.passwordTextField) {
        [self.passwordTextField resignFirstResponder];
        [self submit:nil];
    }
    return YES;

}

- (EppValidateCodeService *)eppValidateService
{
    if (!_eppValidateService) {
        _eppValidateService = [[EppValidateCodeService alloc] init];
        _eppValidateService.delegate = self;
    }
    return _eppValidateService;
}

#pragma mark - UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    headview.backgroundColor =[UIColor uiviewBackGroundColor];
   
    UILabel *title =[[UILabel alloc]init];
    title.backgroundColor =[UIColor clearColor];
    title.frame =CGRectMake(0, 0, 320, 30);
    title.font =[UIFont systemFontOfSize:15];
    title.textColor =[UIColor dark_Gray_Color];
    title.text =L(@"VPEfubaoPay");
    [headview addSubview:title];
    
    return headview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *itemCellIdentifier = @"itemCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        
        cell.textLabel.textColor =[UIColor light_Black_Color];
    }
    
    if (indexPath.row == 0) {

        cell.textLabel.text = L(@"YifubaoBalance: ");
        
        [cell.contentView addSubview:self.yifubaoBalanceLbl];
        
        NSString *nYiFuBaoBalance = [NSString stringWithFormat:@"%@%@",self.paySource.yifubaoMoney,L(@"Constant_RMB")];
        
        self.yifubaoBalanceLbl.text = nYiFuBaoBalance;
    
    }else if(indexPath.row == 1){
    
        cell.textLabel.text = L(@"VPNeedToPay");
        
        [cell.contentView addSubview:self.factPriceLbl];
        
        double dFactPrice = [self.paySource.factPayPrice doubleValue]/100.0;
        
        NSString *nFactPrice = [NSString stringWithFormat:@"%0.2f%@",dFactPrice,L(@"Money Unit")];
                
        self.factPriceLbl.text = nFactPrice;
        
    }else if(indexPath.row == 2) {
        
        cell.textLabel.text = L(@"VPMobileVerifyCode");
        [cell.contentView addSubview:self.verifyField];
        [cell.contentView addSubview:self.verifyBtn];
        [cell.contentView addSubview:self.line1];

    }
    else{
    
        cell.textLabel.text = L(@"Payment code");
        
        [cell.contentView addSubview:self.passwordTextField];
        [cell.contentView addSubview:self.line2];
        
       // [self.passwordTextField becomeFirstResponder];

    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate


#pragma mark - Action

- (void)submit:(id)sender{
    
    self.validateCode = self.verifyField.text;
    
    NSString *error = nil;        
    if (![EppValidateCodeService checkVerifyCode:self.validateCode error:&error])
    {
        [self presentSheet:error];
        return;
    }

    if (self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]) {
        
        [self presentSheet:L(@"VPInputPaymentCode")];
        
        [self.passwordTextField becomeFirstResponder];
        
        return;
    }
    
    self.password = self.passwordTextField.text;

    
    [self.passwordTextField resignFirstResponder];
    
    if (isLoading == NO) {
        
        isLoading = YES;
        
        [self displayOverFlowActivityView];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;

        [self.mobilePayService beginSendMobilePayHttpRequest:self.paySource
                                             yifubaoPassWord:self.password validateCode:self.validateCode];
 
    }
}



- (void)switchToPaySuccessPage
{
//    MobilePaySuccessViewController *nextCtrl = [[MobilePaySuccessViewController alloc]init];
//    
//    [self.navigationController pushViewController:nextCtrl animated:YES];
//    
//    [nextCtrl release];
    
    //去历史订单页面
    [[NSNotificationCenter defaultCenter]postNotificationName:QUERY_MOBILE_RECORD object:nil];

}

-(void)switchToPayment
{
    //返回充值界面继续充值
    [[NSNotificationCenter defaultCenter]postNotificationName:PAY_MOBILE_AGAIN object:nil];

}

-(void)stopVerifyTime
{
    [self.eppValidateService stopPayCalculagraph];
}

- (EfubaoAccountService *)efubaoAcountService{

    if (!_efubaoAcountService) {
        _efubaoAcountService = [[EfubaoAccountService alloc] init];
        _efubaoAcountService.delegate = self;
    }
    return _efubaoAcountService;
}

- (MobilePayService *)mobilePayService{

    if (!_mobilePayService ) {
        _mobilePayService = [[MobilePayService alloc] init];
        _mobilePayService.delegate = self;
    }
    return _mobilePayService;
}

#pragma mark -
#pragma mark http request


-(void)getVerifyCode:(id)sender
{    
    if ([self.eppValidateService available]) {
        [self displayOverFlowActivityView:L(@"Loading...")];
        [self.eppValidateService requestValidateCode];
    }
}

- (void)eppRemainTimeToRetry:(NSInteger)seconds
{
    if(seconds <= 0)
    {
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitle:L(@"get_VerifyCode") forState:UIControlStateNormal];
        return;
    }else{
        // Joe.2014年07月09日17:22:20
        // setTitle won't work when button is not enable on iOS7.1.
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitle:[NSString stringWithFormat:@"%d%@",seconds,L(@"Seconds")]
                    forState:UIControlStateNormal];
        _verifyBtn.enabled = NO;
    }
    
}

@end
