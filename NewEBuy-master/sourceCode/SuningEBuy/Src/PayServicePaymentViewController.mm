//
//  PayServicePaymentViewController.m
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PayServicePaymentViewController.h"
#import "NSString+MD5.h"
#import "UserCenter.h"
#import "SNSwitch.h"

static NSString *kMainLbl2 = @"mainLbl";
static NSString *kDetailLbl2 = @"detailLbl";
static NSString *kEnableLbl2 = @"kEnableLbl2";

@implementation PayServicePaymentViewController

@synthesize customerNameLabel = _customerNameLabel;
@synthesize payBalanceLabel = _payBalanceLabel;
@synthesize efubaoBalanceLabel = _efubaoBalanceLabel;
@synthesize payPasswordTextField = _payPasswordTextField;
@synthesize payDataSource = _payDataSource;
@synthesize payMethodArr =_payMethodArr;
@synthesize selectedPayModeRow = _selectedPayModeRow;
@synthesize payServicePaymentService = _payServicePaymentService;
@synthesize eppService = _eppService;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_customerNameLabel);
    TT_RELEASE_SAFELY(_payBalanceLabel);
    TT_RELEASE_SAFELY(_efubaoBalanceLabel);
    TT_RELEASE_SAFELY(_payPasswordTextField);
    TT_RELEASE_SAFELY(_payDataSource);
    TT_RELEASE_SAFELY(_payMethodArr);
    
    SERVICE_RELEASE_SAFELY(_payServicePaymentService);
    SERVICE_RELEASE_SAFELY(_eppService);
    
}

// 初始化数据
- (void)setupDatasource
{
    // 支付方式
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //易付宝
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:L(@"choosePayWayFor30") forKey:kMainLbl2];
    
    BOOL isEppEnable = NO;
    if (self.isEppActive)
    {
        if (self.eppBalance < [self.payDataSource.payAmount doubleValue]/100)
        {
            [dic setObject:L(@"Insufficient efubao balance") forKey:kDetailLbl2];
        }
        else
        {
            [dic setObject:L(@"choosePayWayFor313") forKey:kDetailLbl2];
            self.payDataSource.efubaoBalance = self.user.yifubaoBalance;
            isEppEnable = YES;
        }
    }
    else
    {
        [dic setObject:L(@"NoteActiveYifubao") forKey:kDetailLbl2];
    }
    [dic setObject:__INT(isEppEnable) forKey:kEnableLbl2];
    
    //    //设置默认选中的支付方式
    //    if (isEppEnable)
    //    {
    //        self.selectedPayModeRow = 0;
    //    }
    //    else
    //    {
    //        self.selectedPayModeRow = -1;
    //    }
    [array addObject:dic];
    
    if (KPaySDK)
    {
        NSMutableDictionary *sdkDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [sdkDic setObject:L(@"choosePayWayFor30") forKey:kMainLbl2];
        [sdkDic setObject:@"安全快捷，支持易付宝、零钱宝以及各大银行快捷支付" forKey:kDetailLbl2];
        [array addObject:sdkDic];
    }
    NSMutableDictionary *unDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [unDic setObject:L(@"choosePayWayFor50") forKey:kMainLbl2];
    
    [unDic setObject:@"安全，便捷，高效" forKey:kDetailLbl2];
    
    //#warning 启动银联2.0
    [array addObject:unDic];
    
    self.payMethodArr = array;
    [self.tpTableView reloadData];
}

#pragma mark -
#pragma mark property methods
- (PayServicePaymentService *)payServicePaymentService
{
    if (!_payServicePaymentService) {
        _payServicePaymentService = [[PayServicePaymentService alloc] init];
        _payServicePaymentService.delegate = self;
        self.payDataSource.accountNo = self.user.accountNo;
    }
    
    return _payServicePaymentService;
}

- (EfubaoAccountService *)eppService
{
    if (!_eppService) {
        _eppService = [[EfubaoAccountService alloc] init];
        _eppService.delegate = self;
    }
    return _eppService;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
    if (_tpTableView == nil)
    {
        _tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _tpTableView.scrollEnabled = YES;
        _tpTableView.userInteractionEnabled = YES;
        _tpTableView.delegate =self;
        _tpTableView.dataSource =self;
        _tpTableView.backgroundColor =[UIColor clearColor];
        _tpTableView.backgroundView = nil;
    }
    
    return _tpTableView;
}

- (UILabel *)customerNameLabel
{
    if (_customerNameLabel == nil) {
        CGRect frame = CGRectMake(120, 5, 185, 40);
        _customerNameLabel = [[UILabel alloc] initWithFrame:frame];
        _customerNameLabel.textColor = [UIColor blackColor];
        _customerNameLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _customerNameLabel.textAlignment = UITextAlignmentLeft;
        _customerNameLabel.backgroundColor = [UIColor clearColor];
        _customerNameLabel.text = self.payDataSource.customerName;
    }
    
    return _customerNameLabel;
}

- (UILabel *)payBalanceLabel
{
    if (_payBalanceLabel == nil) {
        CGRect frame = CGRectMake(120, 5, 185, 40);
        _payBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _payBalanceLabel.textColor = [UIColor redColor];
        _payBalanceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _payBalanceLabel.textAlignment = UITextAlignmentLeft;
        _payBalanceLabel.backgroundColor = [UIColor clearColor];
        float temp = [self.payDataSource.payAmount floatValue] / 100;
        NSString *payMoney = [NSString stringWithFormat:@"%.2f",temp];
        _payBalanceLabel.text = [payMoney stringByAppendingString:L(@" yuan")];
    }
    
    return _payBalanceLabel;
}

- (UILabel *)efubaoBalanceLabel
{
    if (_efubaoBalanceLabel == nil) {
        
        CGRect frame = CGRectMake(120, 5, 185, 40);
        _efubaoBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _efubaoBalanceLabel.textColor = [UIColor redColor];
        _efubaoBalanceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _efubaoBalanceLabel.textAlignment = UITextAlignmentLeft;
        _efubaoBalanceLabel.backgroundColor = [UIColor clearColor];
        NSString *payMoney = [NSString stringWithFormat:@"%.2f",self.eppBalance];
        _efubaoBalanceLabel.text = [payMoney stringByAppendingString:L(@" yuan")];
    }
    
    return _efubaoBalanceLabel;
}

- (UITextField *)payPasswordTextField
{
    if (_payPasswordTextField == nil) {
        CGRect frame = CGRectMake(120, 0, 180, 44);
        _payPasswordTextField = [[UITextField alloc] initWithFrame:frame];
        _payPasswordTextField.textColor = [UIColor blackColor];
        _payPasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _payPasswordTextField.borderStyle = UITextBorderStyleNone;
        _payPasswordTextField.placeholder = L(@"Please input your efubao password");
        _payPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _payPasswordTextField.text = @"";
        _payPasswordTextField.secureTextEntry = YES;
        _payPasswordTextField.returnKeyType = UIReturnKeyDone;
        _payPasswordTextField.delegate = self;
    }
    
    return _payPasswordTextField;
}

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

- (UIImageView *)line2
{
    if (!_line2) {
        _line2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray"]];
        _line2.frame = CGRectMake(109, 5, 1, 30);
    }
    return _line2;
}

- (id)init
{
    if(self = [super init])
    {
        self.title = L(@"Payment");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_wegCharge_payPage"),self.title];
        self.selectedPayModeRow = -2;
        
        self.navigationItem.rightBarButtonItem =[self rightBtnItemWithTitle:L(@"Pay")];
    }
    
    return self;
}

//- (UIButton *)rightBtn
//{
//    if (!_rightBtn) {
//        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//
//        _rightBtn.frame =CGRectMake(270, 4, 40, 40);
//
//        [_rightBtn setTitle:L(@"Pay") forState:UIControlStateNormal];
//
//        [_rightBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
//
//        [_rightBtn addTarget:self action:@selector(righBarClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _rightBtn;
//}

- (void)righBarClick
{
    [self submit];
}

#pragma mark -
#pragma mark View lifecycle
- (void)loadView
{
    [super loadView];
    
    [self setupDatasource];
    
    
    self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.tpTableView];
    
    UIView *view =[[UIView alloc]init];
    view.backgroundColor =[UIColor clearColor];
    self.tpTableView.tableFooterView =view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.eppService beginGetEfubaoAccountInfo];
}

#pragma mark -
#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.selectedPayModeRow == 0)
    {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNumbers = 0;
    switch (section)
    {
        case 0:
            rowNumbers = [self.payMethodArr count];
            break;
            
        case 1:
        {
            switch (self.selectedPayModeRow)
            {
                case 0:
                    rowNumbers = 3;
                    break;
                case 1:
                case 2:
                    rowNumbers = 0;
                    break;
                default:
                    break;
            }
            break;
        }
            
        default:
            break;
    }
    
    return rowNumbers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    static NSString *SettlementIdentifier = @"CellIdentifier";
    MobilePayCell *cell = nil;
    
    if (cell == nil)
    {
        cell = [[MobilePayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SettlementIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else
    {
        [cell.contentView removeAllSubviews];
    }
    
    switch (section)
    {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            if (indexPath.row == 0) {
                BOOL isEnable = [[[self.payMethodArr objectAtIndex:row] objectForKey:kEnableLbl2] boolValue];
                UIColor *color = isEnable?[UIColor dark_Gray_Color]:[UIColor orange_Light_Color];
                
                [cell setItem:[[self.payMethodArr objectAtIndex:row] objectForKey:kMainLbl2] payDes:[[self.payMethodArr objectAtIndex:row] objectForKey:kDetailLbl2] color:color];
                
                if (row == self.selectedPayModeRow)
                {
                    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellMark.png"]];
                }
            }
            else
            {
                [cell setItem:[[self.payMethodArr objectAtIndex:row] objectForKey:kMainLbl2] payDes:[[self.payMethodArr objectAtIndex:row] objectForKey:kDetailLbl2] color:[UIColor dark_Gray_Color]];
                
                if (row == self.selectedPayModeRow)
                {
                    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellMark.png"]];
                }
                
            }
            
            break;
        }
            
        case 1:
        {
            
            cell.textLabel.font =[UIFont systemFontOfSize:14];
            
            cell.textLabel.textColor =[UIColor light_Black_Color];
            
            switch (self.selectedPayModeRow)
            {
                case 0: // yifubaozhifu
                {
                    if (row == 0)
                    {
                        cell.textLabel.text =IOS7_OR_LATER? @"易付宝余额：":@" 易付宝余额：";
                        
                        [cell.contentView addSubview:self.yifubaoBalanceLbl];
                        
                        self.yifubaoBalanceLbl.text = self.efubaoBalanceLabel.text;
                        //                        cell.leftTextLbl.text = L(@"YIfuaboBalance");
                        //                        cell.rightTextLbl.text = self.efubaoBalanceLabel.text;
                        //                        cell.rightTextLbl.textColor = [UIColor redColor];
                    }
                    else if (row == 1)
                    {
                        cell.textLabel.text =IOS7_OR_LATER? @"需要支付：":@" 需要支付：";
                        
                        [cell.contentView addSubview:self.factPriceLbl];
                        
                        self.factPriceLbl.text = self.payBalanceLabel.text;
                        
                        //                        cell.leftTextLbl.text = L(@"need to pay");
                        //                        cell.rightTextLbl.text = self.payBalanceLabel.text;
                        //                        cell.rightTextLbl.textColor = [UIColor redColor];
                    }
                    else if (row == 2)
                    {
                        cell.textLabel.text =IOS7_OR_LATER? @"支付密码":@" 支付密码";
                        
                        [cell.contentView addSubview:self.payPasswordTextField];
                        [cell.contentView addSubview:self.line2];
                        
                        //                        cell.leftTextLbl.text = L(@"passWordPay");
                        //                        cell.rightTextFld.placeholder = L(@"please input pay password");
                        //                        cell.rightTextFld.secureTextEntry = YES;
                        //                        self.payPasswordTextField = cell.rightTextFld;
                        //                        self.payPasswordTextField.delegate = self;
                    }
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor =[UIColor uiviewBackGroundColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 290, 30)];
    label.backgroundColor =[UIColor clearColor];
    
    if (section == 1 && self.selectedPayModeRow == 0)
    {
        label.text = L(@"choosePayWayFor30");//yifubao
    }
    
    if (section == 0 ) {
        label.text = @"请选择支付方式";
    }
    
    label.font =[UIFont systemFontOfSize:15];
    label.textColor =[UIColor dark_Gray_Color];
    
    [view addSubview:label];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 60;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section)
    {
        case 0:
        {
            if (row == 0) {
                BOOL isEnable = [[[self.payMethodArr objectAtIndex:row] objectForKey:kEnableLbl2] boolValue];
                if (isEnable) {
                    self.selectedPayModeRow = row;
                }
                else
                {
                    [self presentSheet:@"请选择其它支付方式"];
                }
            }
            else
            {
                self.selectedPayModeRow = row;
            }
            
            [tableView reloadData];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark Text Field Delegate Methods



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.payPasswordTextField resignFirstResponder];
    return YES;
}
//sdk支付
-(void)sdkPay
{
    [self displayOverFlowActivityView];
    [self.payServicePaymentService beginsendPayOnSdkBankHttpRequest:self.payDataSource];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
}
//银联
-(void)unionPay
{
    [self displayOverFlowActivityView];
    [self.payServicePaymentService beginsendPayOnBankHttpRequest:self.payDataSource];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
}
#pragma mark -
#pragma mark actions
- (void)submit
{
    
    if (self.selectedPayModeRow == -2) {
        [self presentSheet:@"请选择支付方式"];
        return;
    }
    if (self.selectedPayModeRow == -1) {
        [self presentSheet:@"请选择其它支付方式"];
        return;
    }
    
    if (_selectedPayModeRow == 1)
    {
        if (KPaySDK)
        {
            [self sdkPay];
        }
        else
        {
            [self unionPay];
        }
    }
    else if (_selectedPayModeRow == 2)
    {
        [self unionPay];
    }
    
    if (_selectedPayModeRow == 0) {//yifubaozhifu
        if ([self.payDataSource.payAmount floatValue] == 0.0)
        {
            [self presentSheet:L(@"You don't have a bill to pay") posY:80];
            return;
        }
        
        if ([self.payDataSource.efubaoBalance floatValue] < [self.payDataSource.payAmount floatValue] / 100)
        {
            [self presentSheet:L(@"Insufficient efubao balance") posY:80];
            return;
        }
        
        if (self.payPasswordTextField.text == nil || [self.payPasswordTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please input your efubao password") posY:80];
            [self.payPasswordTextField becomeFirstResponder];
            return;
        }
        
        [self.payPasswordTextField resignFirstResponder];
        [self displayOverFlowActivityView];
        [self.payServicePaymentService beginGetPaymentApplyWith:self.payDataSource PayMode:_selectedPayModeRow PayPassword:self.payPasswordTextField.text];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    //    self.tpTableView.userInteractionEnabled = NO;
    
    
}

- (void)applyFail:(NSString *)errorCode
{
    if (errorCode == nil)
    {
        [self presentSheet:L(@"Request Failed") posY:80];
    }
    else
    {
        [self presentSheet:errorCode posY:80];
    }
}

#pragma mark -
#pragma mark 委托方法
- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess
                            errorMsg:(NSString *)errorMsg
{
    if (isSuccess) {
        [self setupDatasource];
    }
}

- (void)getPaymentApplyCompleteWithService:(PayServicePaymentService *)service
                                    Result:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    self.tpTableView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        if (_selectedPayModeRow == 0) {
            
            if(IsStrEmpty(service.desc))
            {
                service.desc = @"缴费成功";
            }
            
            [self presentCustomDlg:service.desc];
        }
        else
        {
            /* deprecated
             PayModeWebViewController *payModeWebViewController =[[PayModeWebViewController alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:service.wwwUrl]]];
             [self.navigationController pushViewController:payModeWebViewController animated:YES];
             TT_RELEASE_SAFELY(payModeWebViewController);
             */
        }
    }
    else
    {
        if (_selectedPayModeRow == 0) {
            [self applyFail:service.desc];
        }
        else
        {
            if (service.isNotSuccess) {
                [self presentSheet:service.desc posY:80];
            }
            else
            {
                [self presentSheet:L(@"Sorry loading failed")];
            }
        }
    }
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isPaySuccess" object:nil];
}

- (void)didSendPayOnBankCompleted:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg
                      punchoutUrl:(id)url
                     punchoutForm:(id)xml
{
    [self removeOverFlowActivityView];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        
        [UPPayPlugin startPay:xml
                         mode:@"00"
               viewController:self
                     delegate:self];
    }
    else
    {
        [self presentSheet:self.payServicePaymentService.errorMsg];
    }
    
    
}
#pragma mark -
#pragma mark 银联支付回调

- (void)UPPayPluginResult:(NSString*)result
{
    [self removeOverFlowActivityView];
    DLog(@"result:%@", result);
    self.tpTableView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if([result isEqualToString:@"cancel"])
    {
        [self presentSheet:L(@"您已取消了本次订单的支付") posY:100];
    }
    else if(![result isEqualToString:@"fail"] &&![result isEqualToString:@"cancel"])
    {
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
                                                        message:@"缴费成功"
                                                       delegate:self
                                              cancelButtonTitle:L(@"confirm")
                                              otherButtonTitles:nil];
        alert.tag = 1111;
        [alert show];
    }
    else
    {
        [self presentSheet:L(@"支付失败") posY:100];
    }
    
}
- (void)didSendPaySdkOnBankCompleted:(BOOL)isSuccess xml:(NSString *)xml code:(NSString*)code
{
    [self removeOverFlowActivityView];
    self.tpTableView.userInteractionEnabled = YES;
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess&&([xml length]))
    {
        SNMPayRequest *request = [[SNMPayRequest alloc] init];
        request.orderType = SPOrderTypeRecharge;
        request.orderString = xml;
        [SNMPaySDK setSDKUserType:SPUserTypeSNEG];
#ifdef kPreTest
        [SNMPaySDK setSDKRemoteAPIEnv:SPRemoteAPIEnvPre];
#elif kSitTest
        [SNMPaySDK setSDKRemoteAPIEnv:SPRemoteAPIEnvSit];
#elif kReleaseH
        [SNMPaySDK setSDKRemoteAPIEnv:SPRemoteAPIEnvPrd];
#endif
#ifdef DEBUGLOG
        [SNMPaySDK enableDebugMode:YES];
#else
        [SNMPaySDK enableDebugMode:NO];
#endif
        [SNMPaySDK submitOrderRequest:request delegate:self];
    }
    else
    {
        if (isSuccess&&(![xml length]))
        {
            [self presentSheet:@"xml为空"];
        }
        if (!isSuccess)
        {
            [self presentSheet:code];
        }
    }
    
}
- (void)didFinishSDKPayment
{
    [self removeOverFlowActivityView];
    self.tpTableView.userInteractionEnabled = YES;
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
                                                    message:@"缴费成功"
                                                   delegate:self
                                          cancelButtonTitle:L(@"confirm")
                                          otherButtonTitles:nil];
    [alert show];
    
}
- (void)didFailLoadSDKWithError:(NSString *)errorMsg
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.tpTableView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}
@end

