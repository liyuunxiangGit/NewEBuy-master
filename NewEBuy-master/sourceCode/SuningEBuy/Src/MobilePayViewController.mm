//
//  MobilePayViewController.m
//  SuningEBuy
//
//  Created by david david on 12-8-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "MobilePayViewController.h"
#import "MobilePayCell.h"
#import "MobilePayByYiFuBaoViewController.h"
#import "UserCenter.h"
#import "SNSwitch.h"

@interface MobilePayViewController(){
    
    BOOL        isGetYiFuBao;
    
    BOOL        isYiFuBaoEnough; //add by wangjiaxing 20120828
    
}

//@property(nonatomic,strong) MobliePayHeadView *headView;
@property(nonatomic,strong) NSMutableArray    *itemList;
@property (nonatomic, strong) EfubaoAccountService  *efubaoService;
@property (nonatomic, strong) MobilePayService      *mobilePayService;

@end



@implementation MobilePayViewController

//@synthesize headView = _headView;
@synthesize paySource = _paySource;
@synthesize itemList = _itemList;
@synthesize efubaoService = _efubaoService;
@synthesize mobilePayService = _mobilePayService;

- (void)dealloc {
    
    //    TT_RELEASE_SAFELY(_headView);
    TT_RELEASE_SAFELY(_paySource);
    TT_RELEASE_SAFELY(_itemList);
    
    SERVICE_RELEASE_SAFELY(_efubaoService);
    SERVICE_RELEASE_SAFELY(_mobilePayService);
}


- (id)init {
    self = [super init];
    if (self) {
        
        self.title = @"账单支付";
        
        if (_itemList == nil) {
            if (KPaySDK)
            {
                _itemList = [[NSMutableArray alloc]initWithObjects:@"易付宝支付",
                             @"使用易付宝账户现有的余额支付",
                             __INT(YES),
                             @"易付宝支付",
                             @"安全快捷，支持易付宝、零钱宝以及各大银行快捷支付",
                             __INT(YES),
                             @"银联支付",
                             @"安全，快捷，高效",
                             __INT(YES),
                             @"快捷支付",
                             @"绑定储蓄卡，信用卡，无需开通网银",
                             __INT(YES), nil];
            }
            else
            {
                _itemList = [[NSMutableArray alloc]initWithObjects:@"易付宝支付",
                             @"使用易付宝账户现有的余额支付",
                             __INT(YES),
                             @"银联支付",
                             @"安全，快捷，高效",
                             __INT(YES),
                             @"快捷支付",
                             @"绑定储蓄卡，信用卡，无需开通网银",
                             __INT(YES), nil];
            }
            isGetYiFuBao = NO;
            isYiFuBaoEnough = NO;
            
        }
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_mobileCharge_payPage"),self.title];
    }
    
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    self.tpTableView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
    
    UIView *view =[[UIView alloc] init];
    view.backgroundColor =[UIColor clearColor];
    
    self.tpTableView.tableFooterView =view;
    
    [self.view addSubview:self.tpTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (isGetYiFuBao == NO) {
        [self displayOverFlowActivityView];
        [self.efubaoService beginGetEfubaoAccountInfo];
    }
    
}

#pragma mark - HTTP Delegate Metnods
#pragma mark   数据请求的代理方法

- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    if (isSuccess) {
        //易付宝未激活--提示易付宝未激活信息
        //易付宝激活----易付宝余额充足：提示余额  易付宝余额不足：提示不足
        if ([self.efubaoService.eppStatus isEqualToString:@"0"]) {
            
            self.paySource.yifubaoMoney = @"0.00";
            NSString *desStr = L(@"NoteActiveYifubao");
            
            [self.itemList replaceObjectAtIndex:1 withObject:desStr];
            
            [self.itemList replaceObjectAtIndex:2 withObject:__INT(NO)];
            
            isYiFuBaoEnough=NO;
            isGetYiFuBao = NO;
            
        }else{
            
            self.paySource.yifubaoMoney = self.efubaoService.efubaoBalance;
            if ([self.paySource.factPayPrice doubleValue]/100.0 > [self.paySource.yifubaoMoney doubleValue]){
                
                NSString *desStr = [NSString stringWithFormat:@"易付宝余额：%@元（余额不足）",self.paySource.yifubaoMoney];
                
                [self.itemList replaceObjectAtIndex:1 withObject:desStr];
                
                [self.itemList replaceObjectAtIndex:2 withObject:__INT(NO)];
                
                isYiFuBaoEnough=NO;
                isGetYiFuBao = NO;
                
            }else{
                
                NSString *desStr = [NSString stringWithFormat:@"易付宝余额：%@元",self.paySource.yifubaoMoney];
                
                [self.itemList replaceObjectAtIndex:1 withObject:desStr];
                
                isYiFuBaoEnough=YES;
                isGetYiFuBao = YES;
                
            }
        }
        
        [self.tpTableView reloadData];
        
    }else{
        
        [self presentSheet:errorMsg posY:50];
    }
}

- (void)didSendHuifuMobilePayCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    /* deprecated
     if (isSuccess) {
     
     #ifdef kReleaseH
     
     NSString *hostMobileHuiFu = @"https://pay.suning.com/epp-portal/td/trade/pay-trade.action?out_order_no";
     #elif kPreTest
     NSString *hostMobileHuiFu = @"https://192.168.121.82/epp-portal/td/trade/pay-trade.action?out_order_no";
     #else
     NSString *hostMobileHuiFu = @"https://192.168.157.100/epp-portal/td/trade/pay-trade.action?out_order_no";
     #endif
     //进入汇付天下页面
     NSString *urlwww = [NSString stringWithFormat:@"%@=%@",
     hostMobileHuiFu,
     self.mobilePayService.orderNumber];
     
     DLog(@"url is  %@",urlwww);
     
     PayModeWebViewController *payModeWebViewController =[[PayModeWebViewController alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlwww]]];
     
     [self.navigationController pushViewController:payModeWebViewController animated:YES];
     
     TT_RELEASE_SAFELY(payModeWebViewController);
     
     
     }else{
     
     [self presentSheet:errorMsg posY:50];
     }
     
     */
    
}

-(void)didSendPayOnBankCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg punchoutUrl:(id)url punchoutForm:(id)xml
{
    [self removeOverFlowActivityView];
    
    self.isNeedBackItem =YES;
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        [UPPayPlugin startPay:xml
                         mode:@"00"
               viewController:self
                     delegate:self];
    }else{
        [self presentSheet:self.mobilePayService.errorMsg];
    }
    
    
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 4;
    }
    //#warning 启动银联2.0
    if (KPaySDK)
    {
        return 3;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 40;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *infoCellIdentifier = @"infoCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (IOS7_OR_LATER) {
                cell.backgroundColor =[UIColor cellBackViewColor];
            }
            else
            {
                UIView *back = [UIView new];
                back.backgroundColor =[UIColor cellBackViewColor];
                cell.backgroundView = back;
            }
        }
        
        NSString *str ;
        if (indexPath.row ==0) {
            NSString *__mobileNumber = self.paySource.mobileNumber == nil?@"--":self.paySource.mobileNumber;
            
            str =[NSString stringWithFormat:@"充值号码：%@",__mobileNumber];
        }
        else if (indexPath.row ==1)
        {
            NSString *__mobilequo = self.paySource.mobilequo == nil?@"--":self.paySource.mobilequo;
            str =[NSString stringWithFormat:@"归属地：%@",__mobilequo];
        }
        else if (indexPath.row ==2)
        {
            NSString *__payPrice = @"--";
            if (self.paySource.payPrice) {
                
                double dPayPrice = [self.paySource.payPrice doubleValue];
                
                dPayPrice = dPayPrice/100.0;
                
                __payPrice = [NSString stringWithFormat:@"%0.2f元",dPayPrice];
                
            }
            str =[NSString stringWithFormat:@"充值金额：%@",__payPrice];
        }
        else if (indexPath.row ==3)
        {
            NSString *__factPayPrice = @"--";
            
            if (self.paySource.factPayPrice) {
                
                double dFactPayPrice = [self.paySource.factPayPrice doubleValue];
                
                dFactPayPrice = dFactPayPrice/100.0;
                
                __factPayPrice = [NSString stringWithFormat:@"%0.2f元",dFactPayPrice];
            }
            str =[NSString stringWithFormat:@"实付金额：%@",__factPayPrice];
            
        }
        
        cell.textLabel.text =str;
        cell.textLabel.font =[UIFont systemFontOfSize:14];
        cell.textLabel.textColor =[UIColor light_Black_Color];
        
        return cell;
    }
    
    if (indexPath.section == 1)
    {
        static NSString *payCellIdentifier = @"payCellIdentifier";
        
        MobilePayCell *cell = [tableView dequeueReusableCellWithIdentifier:payCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[MobilePayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        NSString *payModelString = [self.itemList objectAtIndex:indexPath.row*3];
        
        NSString *payDesString = [self.itemList objectAtIndex:indexPath.row*3+1];
        
        BOOL isEnable = [[self.itemList objectAtIndex:indexPath.row*3+2] boolValue];
        UIColor *color = isEnable?[UIColor dark_Gray_Color]:[UIColor orange_Light_Color];
        [cell setItem:payModelString payDes:payDesString color:color];
        
        if (isEnable)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return 40;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
    }
    else
    {
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor =[UIColor clearColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 290, 20)];
        label.backgroundColor =[UIColor clearColor];
        label.text =@"请选择支付方式";
        label.font =[UIFont systemFontOfSize:15];
        label.textColor =[UIColor dark_Gray_Color];
        
        [view addSubview:label];
        return view;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        //易付宝已经激活：易付宝余额充足-支付  易付宝余额不足-不响应
        //易付宝未激活：  提示激活易付宝信息
        if ([self isEppActive]) {
            
            if (isYiFuBaoEnough) {
                
                MobilePayByYiFuBaoViewController *ctrl = [[MobilePayByYiFuBaoViewController alloc]init];
                
                ctrl.paySource = self.paySource;
                
                [self.navigationController pushViewController:ctrl animated:YES];
                
                
            }else{
                
                return;
            }
            
        }else{
            
            //            NSString *desStr = L(@"NoteActiveYifubao");
            //
            //            [self presentCustomDlg:desStr];
            //
            //            return;
            
        }
        //add by wangjiaxing 20120828 ---------end---------
        
    }
    //        else if(indexPath.section == 1 && indexPath.row == 1){
    //        //汇付支付
    //
    //        [self displayOverFlowActivityView];
    //        [self.mobilePayService beginSendHuifuMobilePayHttpRequest:self.paySource];
    //    }
    else
    {
        if (KPaySDK)
        {
            if (indexPath.section == 1 && indexPath.row == 1)
            {
                self.navigationItem.leftBarButtonItem.enabled = NO;
                [self.mobilePayService beginsendPayOnSdkBankHttpRequest:self.paySource];
                [self displayOverFlowActivityView];
            }
            else
            {
                if (indexPath.section == 1 && indexPath.row == 2)
                {
                    self.navigationItem.leftBarButtonItem.enabled = NO;
                    [self.mobilePayService beginsendPayOnBankHttpRequest:self.paySource];
                    [self displayOverFlowActivityView];
                }
            }
        }
        else
        {
            if (indexPath.section == 1 && indexPath.row == 1)
            {
                self.navigationItem.leftBarButtonItem.enabled = NO;
                [self.mobilePayService beginsendPayOnBankHttpRequest:self.paySource];
                [self displayOverFlowActivityView];
            }
        }
        
        
    }
    
}


- (EfubaoAccountService *)efubaoService{
    
    if (!_efubaoService) {
        _efubaoService = [[EfubaoAccountService alloc] init];
        _efubaoService.delegate = self;
    }
    return _efubaoService;
}

- (MobilePayService *)mobilePayService{
    
    if (!_mobilePayService ) {
        _mobilePayService = [[MobilePayService alloc] init];
        _mobilePayService.delegate = self;
    }
    return _mobilePayService;
}

#pragma mark -
#pragma mark 银联支付回调

- (void)UPPayPluginResult:(NSString*)result
{
    [self removeOverFlowActivityView];
    DLog(@"result:%@", result);
    if([result isEqualToString:@"cancel"])
    {
        [self presentSheet:L(@"您已取消了本次订单的支付") posY:100];
        
    }
    else if(![result isEqualToString:@"fail"] &&![result isEqualToString:@"cancel"])
    {
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
                                                        message:@"充值成功"
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

-(void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter]postNotificationName:QUERY_MOBILE_RECORD object:nil];
    
}
- (void)didSendMobileSdkPayCompleted:(BOOL)isSuccess xml:(NSString *)xml code:(NSString*)code
{
    [self removeOverFlowActivityView];
    self.navigationItem.leftBarButtonItem.enabled = YES;
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
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
                                                    message:@"充值成功"
                                                   delegate:self
                                          cancelButtonTitle:L(@"confirm")
                                          otherButtonTitles:nil];
    [alert show];
    
}
- (void)didFailLoadSDKWithError:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    self.navigationItem.leftBarButtonItem.enabled = YES;
}
@end
