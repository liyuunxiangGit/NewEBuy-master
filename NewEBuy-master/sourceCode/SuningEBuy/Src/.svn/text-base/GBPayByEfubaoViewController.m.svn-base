//
//  GBPayByEfubaoViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBPayByEfubaoViewController.h"
#import "GBPaySuccessViewController.h"

@interface GBPayByEfubaoViewController ()

@property (nonatomic, strong) UITextField                                   *passwordTextField;
@property (nonatomic, strong) UIButton                                      *submitBtn;
@property (nonatomic, strong) UILabel                                       *efubaoBalance;
@property (nonatomic, strong) UILabel                                       *eppBalance;

@end

@implementation GBPayByEfubaoViewController

@synthesize passwordTextField                   = _passwordTextField;
@synthesize submitBtn                           = _submitBtn;
@synthesize efubaoBalance                       = _efubaoBalance;
@synthesize eppBalance                          = _eppBalance;


@synthesize gbPayService                        = _gbPayService;
@synthesize submitDto                           = _submitDto;
@synthesize efubaoAccountService                = _efubaoAccountService;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_submitDto);
    TT_RELEASE_SAFELY(_gbPayService);
    TT_RELEASE_SAFELY(_submitBtn);
    TT_RELEASE_SAFELY(_passwordTextField);
    TT_RELEASE_SAFELY(_eppBalance);
    TT_RELEASE_SAFELY(_efubaoBalance);
    TT_RELEASE_SAFELY(_efubaoAccountService);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"GB_Efubao_Pay");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        if (!_submitDto) {
            _submitDto = [[GBSubmitDTO alloc] init];
        }
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    [self.view addSubview:self.tpTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self displayOverFlowActivityView:L(@"Loading...")];
//    [self.efubaoAccountService beginGetEfubaoAccountInfo];

    [self initBackItem];
}

- (void)initBackItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToFore:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 9777;
    
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    [widow addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
}

- (void)backToFore:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.passwordTextField resignFirstResponder];
    
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    
    for (UIView *view in widow.subviews) {
        
        if (view.tag == 9777) {
            [view removeFromSuperview];
        }
    }
}

- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [self.tpTableView reloadData];
    }
}

- (EfubaoAccountService *)efubaoAccountService
{
//    if (!_efubaoAccountService) {
//        _efubaoAccountService = [[EfubaoAccountService alloc] init];
//        _efubaoAccountService.delegate = self;
//    }
    return _efubaoAccountService;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField)
    {
        _passwordTextField = [[UITextField alloc] init];
        
        _passwordTextField.frame = CGRectMake(120, 5, 200, 30);
        
		_passwordTextField.delegate = self;
		
        _passwordTextField.font = [UIFont systemFontOfSize:14.0];
        
		_passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _passwordTextField.returnKeyType = UIReturnKeyGo;
        
        _passwordTextField.enablesReturnKeyAutomatically = YES;
		
		_passwordTextField.placeholder = L(@"input User PassWord");
		
		_passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn)
    {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _submitBtn.frame = CGRectMake(15, 30, 290, 30);
        
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal"] forState:UIControlStateNormal];
        
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_submitBtn setTitle:L(@"surePay") forState:UIControlStateNormal];
        
        [_submitBtn addTarget:self action:@selector(goToSumit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UILabel *)eppBalance
{
    if (!_eppBalance)
    {
        _eppBalance = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 200, 30)];
        
        _eppBalance.backgroundColor = [UIColor clearColor];
        
        _eppBalance.textColor = [UIColor orange_Light_Color];
        
    }
    return _eppBalance;
}


- (UILabel *)efubaoBalance
{
    if (!_efubaoBalance)
    {
        _efubaoBalance = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 200, 30)];
        
        _efubaoBalance.backgroundColor = [UIColor clearColor];
        
        _efubaoBalance.textColor = [UIColor orange_Light_Color];
        
    }
    return _efubaoBalance;
}

- (void)goToSumit:(id)sender
{
    
    if (IsStrEmpty(self.passwordTextField.text) || [self.passwordTextField.text isEqualToString:@""]) {
        [self presentSheet:L(@"Please input your password")];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    if (self.passwordTextField.text.trim.length < 6 || self.passwordTextField.text.trim.length > 20) {
        
        [self presentSheet:L(@"GBPleaseInputSecretCode")];
        [self.passwordTextField becomeFirstResponder];
        
        return;
    }
    [self.passwordTextField resignFirstResponder];
    
    self.submitDto.eppPassword = self.passwordTextField.text;//[PasswdUtil encryptData:[self.passwordTextField.text dataUsingEncoding:NSUTF8StringEncoding] forUser:[Config currentConfig].username];
    
    [self displayOverFlowActivityView];
    [self.gbPayService beginPayByEppChannel:self.submitDto];
}

- (GBPayService *)gbPayService
{
    if (!_gbPayService) {
        _gbPayService = [[GBPayService alloc] init];
        _gbPayService.delegate = self;
    }
    return _gbPayService;
}

- (void)payByEppChannelComplete:(GBPayService *)service Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        GBPaySuccessViewController *success = [[GBPaySuccessViewController alloc] init];
        success.gbSubmitDto = self.submitDto;
        success.gbSubmitDto.snProName = self.submitDto.snProName;
        [self.navigationController pushViewController:success animated:YES];
    }else{
        [self presentSheet:self.gbPayService.errorMsg];
    }
}


#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    foot.backgroundColor = [UIColor clearColor];
    foot.userInteractionEnabled = YES;
    [foot addSubview:self.submitBtn];
    return foot;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *efubaoIdentifier = @"efubaoIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:efubaoIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:efubaoIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor light_Black_Color];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = L(@"YIfuaboBalance");
            [cell.contentView addSubview:self.efubaoBalance];
            self.efubaoBalance.text = [NSString stringWithFormat:@"￥%@",[UserCenter defaultCenter].userInfoDTO.yifubaoBalance?[UserCenter defaultCenter].userInfoDTO.yifubaoBalance:@"0.00"];
            break;
        case 1:
            cell.textLabel.text = L(@"GB_Pay_Balance");
            [cell.contentView addSubview:self.eppBalance];
            self.eppBalance.text = [NSString stringWithFormat:@"￥%0.2f",[self.submitDto.payAmount?self.submitDto.payAmount:@"" floatValue]];
            break;
        case 2:
            cell.textLabel.text = L(@"passWordPay");
            [cell.contentView addSubview:self.passwordTextField];
            break;
        default:
            break;
    }
    
    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self goToSumit:nil];
  
    return YES;
}

@end
