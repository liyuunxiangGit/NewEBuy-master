//
//  flightPayOrderViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-17.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "flightPayOrderViewController.h"
#import "NSString+MD5.h"
#import "PlanTicketSwitch.h"
#import "SNWebViewController.h"
#import "LoginViewController.h"

BOOL  isNewPay = NO;


#define kPayOrderTableFooter L(@"1-20 minutes to complete recharge")

#define kLeftMargin      120
#define kTopMargin       5
#define kTextFieldWidth  190
#define kTextFieldHeight 40

static NSString *fMainLbl = @"mainLbl";
static NSString *fDetailLbl = @"detailLbl";
static NSString *fEnableLbl = @"fEnableLbl";

@interface flightPayOrderViewController ()
{
    BOOL isRepay_;
}

- (void)navigationItemInit;

@end

@implementation flightPayOrderViewController
@synthesize mobileNumberLabel = _mobileNumberLabel;
@synthesize mobilequoLabel    = _mobilequoLabel;
@synthesize payPriceLabel     = _payPriceLabel;
@synthesize factPayPriceLabel = _factPayPriceLabel;
@synthesize yifubaoBalanceLabel = _yifubaoBalanceLabel;
@synthesize payPasswordField   = _payPasswordField;
@synthesize payButton = _payButton;

@synthesize paySource = _paySource;

@synthesize payMethodArr = _payMethodArr;
@synthesize selectedPayModeRow = _selectedPayModeRow;
@synthesize errorTipMsg = _errorTipMsg;
@synthesize errorIndexPath = _errorIndexPath;
@synthesize flightOrderId = _flightOrderId;
@synthesize flightPrice = _flightPrice;

@synthesize orderService = _orderService;
@synthesize ticketOrderService = _ticketOrderService;
@synthesize efubaoService = _efubaoService;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_mobileNumberLabel);
    TT_RELEASE_SAFELY(_mobilequoLabel);
    TT_RELEASE_SAFELY(_payPriceLabel);
    TT_RELEASE_SAFELY(_factPayPriceLabel);
    TT_RELEASE_SAFELY(_yifubaoBalanceLabel);
    TT_RELEASE_SAFELY(_payPasswordField);
    TT_RELEASE_SAFELY(_payButton);
    TT_RELEASE_SAFELY(_paySource);
    TT_RELEASE_SAFELY(_payMethodArr);
    TT_RELEASE_SAFELY(_errorTipMsg);
    TT_RELEASE_SAFELY(_errorIndexPath);
    TT_RELEASE_SAFELY(_flightOrderId);
    TT_RELEASE_SAFELY(_flightPrice);
    
    SERVICE_RELEASE_SAFELY(_orderService);
    SERVICE_RELEASE_SAFELY(_ticketOrderService);
    SERVICE_RELEASE_SAFELY(_efubaoService);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"Bill payment");
        
        self.pageTitle = L(@"virtual_business_flightPayPage");
        
        self.selectedPayModeRow = -1;//默认不选择任何的支付方式
        
        payMobileOrderDTO *payMobileOrderTemp = [[payMobileOrderDTO alloc] init];
        self.paySource = payMobileOrderTemp;
        TT_RELEASE_SAFELY(payMobileOrderTemp);
        
        isGetYiFuBao = NO;
        
        [self navigationItemInit];
        
        [self setupDatasource];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (id)initRepay{
    
    self = [super init];
    if (self) {
        isRepay_ = YES;
        
        self.title = L(@"Bill payment");
        self.pageTitle = L(@"virtual_business_flightPayPage");

        self.selectedPayModeRow = -1;//默认不选择任何的支付方式
        
        payMobileOrderDTO *payMobileOrderTemp = [[payMobileOrderDTO alloc] init];
        self.paySource = payMobileOrderTemp;
        TT_RELEASE_SAFELY(payMobileOrderTemp);
        
        isGetYiFuBao = NO;
        
        [self navigationItemInit];
        
        [self setupDatasource];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)navigationItemInit
{
    if ([PlanTicketSwitch canUserNewServer] && isRepay_ == NO)
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
        [backButton setBackgroundImage :[UIImage imageNamed:@"backToMyEbuy.png"] forState:UIControlStateNormal];
        UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 50, 28)];
        buttonTitle.text = L(@"FlightOrder_Write");
        buttonTitle.font = [UIFont boldSystemFontOfSize:12];
        buttonTitle.textColor = [UIColor whiteColor];
        buttonTitle.backgroundColor = [UIColor clearColor];
        [backButton addSubview:buttonTitle];
        TT_RELEASE_SAFELY(buttonTitle);
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:item];
        TT_RELEASE_SAFELY(backButton);
        TT_RELEASE_SAFELY(item);
    }
}

- (void)righBarClick
{
    [self submit:nil];
}

// 初始化数据
- (void)setupDatasource
{
    // 支付方式
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //易付宝
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:L(@"choosePayWayFor30") forKey:fMainLbl];
    
    BOOL isEppEnable = NO;
    if (self.isEppActive)
    {
        if (self.eppBalance < [self.flightPrice doubleValue])
        {
            [dic setObject:L(@"Insufficient efubao balance") forKey:fDetailLbl];
        }
        else
        {
            [dic setObject:L(@"choosePayWayFor31") forKey:fDetailLbl];
            self.paySource.yifubaoMoney = self.user.yifubaoBalance;
            isEppEnable = YES;
        }
    }
    else
    {
        [dic setObject:L(@"NoteActiveYifubao") forKey:fDetailLbl];
    }
    [dic setObject:__INT(isEppEnable) forKey:fEnableLbl];
    
    //设置默认选中的支付方式
//    if (isEppEnable)
//    {
//        self.selectedPayModeRow = 0;
//    }
//    else
//    {
//        self.selectedPayModeRow = -1;
//    }
    self.selectedPayModeRow = -1;
    [array addObject:dic];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dic2 setObject:L(@"Unionpay") forKey:fMainLbl];
    [dic2 setObject:L(@"support bank card") forKey:fDetailLbl];
    

    //#warning 启动银联2.0
    [array addObject:dic2];
    
    self.payMethodArr = array;
    
    [self.tpTableView reloadData];
    
}


#pragma mark - payment Methods
#pragma mark - 支付
- (void)submit:(id)sender
{
    
    if (self.selectedPayModeRow == -1)
    {
        
        [self presentSheet:L(@"Please choose payment mode")];
        
        return;
    }
    
    else if (_selectedPayModeRow == 0) {//易付宝支付
        
        if (!isNewPay) {
            if ([self.paySource.yifubaoMoney doubleValue] < [self.flightPrice doubleValue])
            {
                [self presentSheet:L(@"Insufficient efubao balance") posY:50];
                return;
            }
            if (self.payPasswordField.text == nil ||[self.payPasswordField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please input your efubao password") posY:50];
                [self.payPasswordField becomeFirstResponder];
                return;
            }
            [self.payPasswordField resignFirstResponder];
            [self sendPaymentHttpRequest];

        }else{
            //Kristopher add 6.11
            
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeEppPayPlane attributes:@{@"url": [NSString stringWithFormat:@"%@/pay_%@.htm?userId=%@",kHostPlaneTicketNewForHttp,self.flightOrderId,[UserCenter defaultCenter].userInfoDTO.userId]}];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    else if (self.selectedPayModeRow == 1)
    {
        [self.orderService beginsendPayonBankwithOrderId:self.flightOrderId userId:[[UserCenter defaultCenter] userInfoDTO].userId memberId:[[UserCenter defaultCenter] userInfoDTO].memberCardNo payAmout:self.flightPrice];
        [self displayOverFlowActivityView];
    
    }
}


- (void)back:(id)sender
{
    
    BBAlertView *alertView = [[BBAlertView alloc]
                              initWithTitle:nil
                              message:L(@"BTMakeSureToGoBackToOrderPage")
                              delegate:self
                              cancelButtonTitle:L(@"cancel")
                              otherButtonTitles:L(@"ok")];
    
    [alertView setConfirmBlock:^{
        self.appDelegate.tabBarViewController.selectedIndex = 4;
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                            object:nil
                                                          userInfo:nil];
        NSArray *controllerArr = [self.navigationController viewControllers];
        NSInteger index = [controllerArr indexOfObject:self];
        UIViewController *controller = [controllerArr objectAtIndex:index-2];
        [self.navigationController popToViewController:controller animated:YES];
    } ];
    
    [alertView show];
    TT_RELEASE_SAFELY(alertView);
}

#pragma mark -
#pragma mark tpTableView and Labels and TextFields

- (UILabel *)mobileNumberLabel
{
    if (_mobileNumberLabel == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth-5, kTextFieldHeight);
        _mobileNumberLabel = [[UILabel alloc] initWithFrame:frame];
        _mobileNumberLabel.textColor = [UIColor blackColor];
        _mobileNumberLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _mobileNumberLabel.textAlignment = UITextAlignmentLeft;
        _mobileNumberLabel.backgroundColor = [UIColor clearColor];
        _mobileNumberLabel.text = self.paySource.mobileNumber;
        
    }
    return _mobileNumberLabel;
}

- (UILabel *)mobilequoLabel
{
    if (_mobilequoLabel == nil) {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _mobilequoLabel = [[UILabel alloc] initWithFrame:frame];
        _mobilequoLabel.textColor = [UIColor blackColor];
        _mobilequoLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _mobilequoLabel.textAlignment = UITextAlignmentLeft;
        
        _mobilequoLabel.backgroundColor = [UIColor clearColor];
        
        _mobilequoLabel.text = self.paySource.mobilequo;
    }
    return _mobilequoLabel;
}

- (UILabel *)payPriceLabel
{
    if (_payPriceLabel == nil) {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _payPriceLabel = [[UILabel alloc] initWithFrame:frame];
        _payPriceLabel.textColor = [UIColor redColor];
        _payPriceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _payPriceLabel.textAlignment = UITextAlignmentLeft;
        
        _payPriceLabel.backgroundColor = [UIColor clearColor];
        
        float temp = [self.paySource.payPrice doubleValue] / 100;
        NSString *payMoney = [NSString stringWithFormat:@"%.2f",temp];
        self.payPriceLabel.text = [payMoney stringByAppendingString:L(@" yuan")];
    }
    return _payPriceLabel;
}

- (UILabel *)factPayPriceLabel
{
    if (_factPayPriceLabel == nil) {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _factPayPriceLabel = [[UILabel alloc] initWithFrame:frame];
        _factPayPriceLabel.textColor = [UIColor redColor];
        _factPayPriceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _factPayPriceLabel.textAlignment = UITextAlignmentLeft;
        
        _factPayPriceLabel.backgroundColor = [UIColor clearColor];
        
        float temp = [self.flightPrice doubleValue];
        NSString *payMoney = [NSString stringWithFormat:@"%.2f",temp];
        self.factPayPriceLabel.text = [payMoney stringByAppendingString:L(@" yuan")];
    }
    return _factPayPriceLabel;
}

- (UILabel *)yifubaoBalanceLabel
{
    if (_yifubaoBalanceLabel == nil) {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _yifubaoBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _yifubaoBalanceLabel.textColor = [UIColor redColor];
        _yifubaoBalanceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _yifubaoBalanceLabel.textAlignment = UITextAlignmentLeft;
        
        _yifubaoBalanceLabel.backgroundColor = [UIColor clearColor];
        NSString *yifMoney = self.paySource.yifubaoMoney?self.paySource.yifubaoMoney:@"0";
        NSString *payMoney = [NSString stringWithFormat:@"%.2f",[yifMoney doubleValue]];
        self.yifubaoBalanceLabel.text = [payMoney stringByAppendingString:L(@" yuan")];
    }
    return _yifubaoBalanceLabel;
    
}

- (UITextField *)payPasswordField
{
    if (_payPasswordField == nil) {
        CGRect frame = CGRectMake(110, 9, 185, 32);
        _payPasswordField = [[UITextField alloc] initWithFrame:frame];
        _payPasswordField.textColor = [UIColor blackColor];
        _payPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _payPasswordField.borderStyle = UITextBorderStyleNone;
        _payPasswordField.placeholder = L(@"Please input your efubao password");
        _payPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _payPasswordField.text = @"";
        _payPasswordField.secureTextEntry = YES;
        _payPasswordField.delegate = self;
        _payPasswordField.returnKeyType = UIReturnKeyGo;
    }
    return _payPasswordField;
}

-(UIButton *)payButton{
    
    if (!_payButton) {
        
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(15, 9, 290, 30);
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_payButton setBackgroundImage:stretchableButtonImageNormal
                              forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_payButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        [_payButton setTitle:L(@"gotoPay") forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        [_payButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}


#pragma mark -
#pragma mark View lifecycle

- (void)loadView{
    
    [super loadView];
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    self.tpTableView.frame = frame;
    
    [self.view addSubview:self.tpTableView];

    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = YES;
    [self.bottomNavBar addSubview:self.payButton];
}

-(FlightOrderService *)orderService
{
    if(nil == _orderService)
    {
        _orderService = [[FlightOrderService alloc] init];
        _orderService.delegate = self;
    }
    return _orderService;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isGetYiFuBao && [UserCenter defaultCenter].isLogined)
    {
        [self sendFirstEfubaoHttpRequest];
    }
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString *activeKey = [[UserCenter defaultCenter] userInfoDTO].eppStatuss;  // 易付宝激活状态
    
    if ([activeKey isEqualToString:@"0"])
    {
        self.errorTipMsg = L(@"NoteActiveYifubao");
        
        return 1;
        
        
    }else if ([self.paySource.yifubaoMoney doubleValue] < [self.flightPrice doubleValue]){
        self.errorTipMsg = L(@"Insufficient efubao balance");
        
        return 1;
        
    }
    else
    {
        if (!isNewPay) {
            if (self.selectedPayModeRow == 0) {
                return 2;
            }else{
                return 1;
            }

        }else{
           return 1;
        }
        
    }
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
            if (!isNewPay) {
                switch (self.selectedPayModeRow)
                {
                    case -1:
                        rowNumbers = 0;
                        break;
                    case 0:
                        rowNumbers = 3;
                        break;
                    case 1:
                        rowNumbers = 0;
                        break;
                    default:
                        break;
                }
            }
            break;
        }
        default:
            break;
    }
    
    return rowNumbers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    
    NSInteger section = indexPath.section;
    
    static NSString *SettlementIdentifier = @"CellIdentifier";
    
    SettleItemCell *cell = nil;
    
    if (cell == nil)
    {
        cell = [[SettleItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SettlementIdentifier];
        
    }
    else
    {
        [cell.contentView removeAllSubviews];
        
    }
    
    switch (section)
    {
            
        case 0:
        {
            if (indexPath.row == 0) {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.text = [[self.payMethodArr objectAtIndex:row] objectForKey:fMainLbl];
                cell.detailTextLabel.text = [[self.payMethodArr objectAtIndex:row] objectForKey:fDetailLbl];
                
                BOOL isEnable = [[[self.payMethodArr objectAtIndex:row] objectForKey:fEnableLbl] boolValue];
                if (isEnable) {
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                }else{
                    cell.detailTextLabel.textColor = [UIColor redColor];
                }
                
                if (row == self.selectedPayModeRow)
                {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                
            }
            else if (indexPath.row ==1)
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.text = [[self.payMethodArr objectAtIndex:row] objectForKey:fMainLbl];
                cell.detailTextLabel.text = [[self.payMethodArr objectAtIndex:row] objectForKey:fDetailLbl];
                if (row == self.selectedPayModeRow)
                {
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
            break;
            
        }
        case 1:
        {
            if (isNewPay) {
                break;//Kristopher
            }
            
            switch (self.selectedPayModeRow)
            {
                case 0: // yifubaozhifu
                {
                    if (row == 0)
                    {
                        
                        cell.leftTextLbl.text = L(@"YIfuaboBalance");
                        
                        cell.rightTextLbl.text = self.yifubaoBalanceLabel.text;
                        
                        cell.rightTextLbl.textColor = [UIColor redColor];
                    }
                    else if (row == 1)
                    {
                        
                        cell.leftTextLbl.text = L(@"need to pay");
                        
                        cell.rightTextLbl.text = [NSString stringWithFormat:@"%.2f",[self.flightPrice doubleValue]];
                        cell.rightTextLbl.textColor = [UIColor redColor];
                    }
                    else if (row == 2)
                    {
                        
                        cell.leftTextLbl.text = L(@"passWordPay");
                        
                        cell.rightTextFld.placeholder = L(@"please input pay password");
                        
                        cell.rightTextFld.secureTextEntry = YES;
                        
                        cell.rightTextFld.returnKeyType = UIReturnKeyGo;
                        
                        cell.rightTextFld.delegate = self;
                        
                        self.payPasswordField = cell.rightTextFld;
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
    
    return 48.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = nil;
    
    if (!isNewPay) {
        if (section == 1)
        {
            
            if (self.selectedPayModeRow == 0)
            {
                sectionTitle = L(@"choosePayWayFor30");//yifubao
            }
            
        }

    }
    
    if (section == 0 ) {
        sectionTitle = L(@"Please_Choose_Pay_Type");
    }
    
    return sectionTitle;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
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
                BOOL isEnable = [[[self.payMethodArr objectAtIndex:row] objectForKey:fEnableLbl] boolValue];
                if (isEnable) {
                    self.selectedPayModeRow = row;
                }
            }
           else if (row == 1)
           {
               self.selectedPayModeRow = row;
           }
            [tableView reloadData];
        }

        default:
            break;
    }
    
}

#pragma mark -
#pragma mark Text Field Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self submit:nil];
    
    return YES;
}


#pragma mark - Efubao Balance Methods
#pragma mark - 获取易付宝余额

- (EfubaoAccountService *)efubaoService
{
    if (!_efubaoService) {
        _efubaoService = [[EfubaoAccountService alloc] init];
        _efubaoService.delegate = self;
    }
    return _efubaoService;
}

- (void)sendFirstEfubaoHttpRequest
{
	[self displayOverFlowActivityView];
    
    [self.efubaoService beginGetEfubaoAccountInfo];
}

- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess
                            errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        isGetYiFuBao = YES;
        
        NSString *balance = [UserCenter defaultCenter].userInfoDTO.yifubaoBalance;
        self.paySource.yifubaoMoney =  balance;
        self.yifubaoBalanceLabel.text = balance;
        self.factPayPriceLabel.text = balance;
        
        [self setupDatasource];
    }
    else
    {
        isGetYiFuBao = NO;
        [self presentSheet:L(errorMsg)];
    }
}

#pragma mark - Payment Methods
#pragma mark - 支付
- (void)sendPaymentHttpRequest
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView:L(@"Commit...") maxShowTime:kPlaneTicketTimeOut];
    
    if (_selectedPayModeRow == 0)   //易付宝支付
    {
        if (!isNewPay) {
            //Kristopher add 6.11
            [self.orderService beginPaymentByEppWithOrderId:self.flightOrderId
                                                     userId:[[UserCenter defaultCenter] userInfoDTO].userId
                                                epayAccount:[[UserCenter defaultCenter] userInfoDTO].accountNo password:self.payPasswordField.text];
        }
    }
    else  //汇付支付
    {
        [self.orderService beginPaymentByHftxWithOrderId:self.flightOrderId
                                                  userId:[[UserCenter defaultCenter] userInfoDTO].userId
                                             epayAccount:[[UserCenter defaultCenter] userInfoDTO].accountNo];
    }
	
}

- (void)paymentByEppCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg status:(int)status
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:L(@"BTOrderPaySuccess")
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:L(@"ok")];
        [alertView setConfirmBlock:^{
            self.appDelegate.tabBarViewController.selectedIndex = 4;
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
    else
    {
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:errorMsg
                                  delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:L(@"Ok")];
        switch (status) {
            case 1:
            case 5:
            {
                //跳转到航班列表页面
                [alertView setConfirmBlock:^{
                    [PlanTicketSwitch jumpToQueryPlaneView:self.navigationController];
                    
                }];
                break;
            }
            case 3:
            {
                //跳转到订单列表页面
                [alertView setConfirmBlock:^{
                    self.appDelegate.tabBarViewController.selectedIndex = 4;
                    [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                        object:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                break;
            }
            default:
            {
                break;
            }
        }
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
}

- (void)paymentByHftxCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
                                   payUrl:(NSString *)url
                                   status:(int)status
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        /* deprecated
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        PayModeWebViewController *payModeWebViewController =
        [[PayModeWebViewController alloc] initWithRequest:request];
        
        [self.navigationController pushViewController:payModeWebViewController animated:YES];
        
        TT_RELEASE_SAFELY(payModeWebViewController);
         */
    }
    else
    {
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:errorMsg
                                  delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:L(@"Ok")];
        switch (status) {
            case 1:
            {
                //跳转到航班列表页面
                [alertView setConfirmBlock:^{
                    [PlanTicketSwitch jumpToQueryPlaneView:self.navigationController];
                }];
                break;
            }
            case 3:
            {
                //跳转到订单列表页面
                [alertView setConfirmBlock:^{
                    self.appDelegate.tabBarViewController.selectedIndex = 4;
                    [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                        object:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                break;
            }
            default:
            {
                break;
            }
        }
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
}
#pragma mark
#pragma mark - 银联回调
- (void)paymentbyOnBankComPletionWithResult:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg
                                  errorCode:(NSString *)errorCode
                                        xml:(NSString *)xml
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        [UPPayPlugin startPay:xml
                         mode:@"00"
               viewController:self
                     delegate:self];
        
    }else{
        [self presentSheet:errorMsg];
    }

}
-(void)UPPayPluginResult:(NSString *)result
{

    [self removeOverFlowActivityView];
    DLog(@"result:%@", result);
    if([result isEqualToString:@"cancel"])
    {
        [self presentSheet:L(@"BTHaveCancelledPayForThisOrder") posY:100];
        
    }
    else if(![result isEqualToString:@"fail"] &&![result isEqualToString:@"cancel"])
    {
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
                                                        message:@"pay_Successed"
                                                       delegate:self
                                              cancelButtonTitle:L(@"confirm")
                                              otherButtonTitles:nil];
        alert.tag = 1111;
        [alert show];
        //跳转到订单列表页面
        [alert setCancelBlock:^{
            self.appDelegate.tabBarViewController.selectedIndex = 4;
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];

        
    }
    else
    {
        [self presentSheet:L(@"Pay failed") posY:100];
    }

}

- (PlanTicketService *)ticketOrderService
{
    if (!_ticketOrderService) {
        _ticketOrderService = [[PlanTicketService alloc] init];
        _ticketOrderService.delegate = self;
    }
    return _ticketOrderService;
}


@end
