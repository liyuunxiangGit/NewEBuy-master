//
//  LotteryPayPageViewController.m
//  SuningLottery
//
//  Created by yang yulin on 13-5-20.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LotteryPayPageViewController.h"
#import "AppDelegate.h"
#import "LotteryHallViewController.h"
#import "PasswdUtil.h"
#import "UPPayPlugin.h"
#import "LotteryDealsViewController.h"

#define kLotteryPayObservingKey              @"lotteryPayErrorMsg"
#define kCheckDateObservingKey               @"checkDate"

@interface LotteryPayPageViewController()
{
    BOOL            isLoadEppOK;
}

-(void)initData;

-(void)submit;

- (void)sendSubmitOrderHttpRequest;

@end

@implementation LotteryPayPageViewController

@synthesize lotteryInfo  = _lotteryInfo;
@synthesize money        = _money;
@synthesize buyCodes     = _buyCodes;
@synthesize payPassword  = _payPassword;
@synthesize projid       = _projid;
@synthesize itemList     = _itemList;
@synthesize lotteryDto   = _lotteryDto;
@synthesize lotteryPayRequest = _lotteryPayRequest;
@synthesize efubaoAccountService = _efubaoAccountService;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryInfo);
    
    TT_RELEASE_SAFELY(_money);
    
    TT_RELEASE_SAFELY(_itemList);
    
    TT_RELEASE_SAFELY(_buyCodes);
    
    TT_RELEASE_SAFELY(_lotteryDto);
    
    TT_RELEASE_SAFELY(_payPassword);
    
    TT_RELEASE_SAFELY(_projid);
    
    TT_RELEASE_SAFELY(_efubaoLabel);
    
    TT_RELEASE_SAFELY(_alertMsgLabel);
    
    TT_RELEASE_SAFELY(_efubaoBalanceLabel);
    
    TT_RELEASE_SAFELY(_balanceValueLabel);
    
    TT_RELEASE_SAFELY(_passwordLabel);
    
    TT_RELEASE_SAFELY(_passwordField);
    
    TT_RELEASE_SAFELY(_cutLineView);
    
    TT_RELEASE_SAFELY(_lotteryPayRequest);
    
    TT_RELEASE_SAFELY(_efubaoAccountService);
    
}

-(id)initWithSubmitLotteryDTO:(SubmitLotteryDto *)dto{
    
    self = [super init];
    
    if (self) {
        self.isLotteryController = YES;
        self.title = L(@"Order pay");
        self.lotteryDto = dto;
        
        isSending = NO;
        
        isEfubaoPay = YES;
        
        isLoadEppOK = NO;
        
        isRequestFinished = NO;
        
        self.pageTitle = L(@"shopProcess_pay_virtualPay");
     
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEpp) name:LOGIN_OK_MESSAGE object:nil];
    }
    
    return self;
}


- (void)refreshEpp
{
    
    [self displayOverFlowActivityView];
    
    [self.efubaoAccountService beginGetEfubaoAccountInfo];
}


-(NSMutableArray *)itemList
{
    if(!_itemList){
        _itemList = [[NSMutableArray alloc] init];
    }
    return _itemList;
}


-(void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
    
	frame.size.height = contentView.bounds.size.height-44;
    
	self.tableView.frame = frame;
    
    [self initData];
    
    [self addView];

    [self.tableView reloadData];
}

- (void)addView
{
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!_lotteryPayRequest) {
        _lotteryPayRequest = [[LotteryPayRequestService alloc] init];
        
        _lotteryPayRequest.delegate = self;

    }
    if (!isLoadEppOK) {
        
        [self displayOverFlowActivityView];
        
        [self.efubaoAccountService beginGetEfubaoAccountInfo];
        
    }
    UIWindow *window = [AppDelegate currentAppDelegate].window;
    
    for (UIView *view in window.subviews) {
        
        if (view.tag == 9666) {
            
            [view removeFromSuperview];
            
        }
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}


#pragma mark - tableView
- (UITableView *)tableView
{
	if(!_tableView)
    {
		
		_tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                  style:UITableViewStyleGrouped];
		
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.delegate =self;
		
        _tableView.backgroundView = nil;
        
		_tableView.dataSource =self;
		
		_tableView.backgroundColor =[UIColor clearColor];
		
	}
	
	return _tableView;
}

- (UILabel *)efubaoLabel
{
    if (!_efubaoLabel)
    {
        _efubaoLabel = [[UILabel alloc]init];
        
        _efubaoLabel.frame = CGRectMake(25, 120, 90, 17);
        
        _efubaoLabel.text = L(@"Efubao pay");
        
        _efubaoLabel.textColor = RGBCOLOR(66, 31, 30);
        
        _efubaoLabel.backgroundColor = [UIColor clearColor];
        
        _efubaoLabel.font = [UIFont systemFontOfSize:17.0];
        
        
    }
    
    return _efubaoLabel;
}

- (UILabel *)alertMsgLabel
{
    if (!_alertMsgLabel)
    {
        _alertMsgLabel = [[UILabel alloc]init];
        
        _alertMsgLabel.frame = CGRectMake(25, 145, 200, 17);
        
        _alertMsgLabel.text = L(@"Please you make sure that your efubao has balance");
        
        _alertMsgLabel.textColor = [UIColor darkGrayColor];
        
        _alertMsgLabel.backgroundColor = [UIColor clearColor];
        
        _alertMsgLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    return _alertMsgLabel;
}

- (UILabel *)efubaoBalanceLabel
{
    if (!_efubaoBalanceLabel)
    {
        _efubaoBalanceLabel = [[UILabel alloc]init];
        
        _efubaoBalanceLabel.frame = CGRectMake(10, 175, 300, 24);
        
        [_efubaoBalanceLabel  setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pay_background.png"]]];
        
        _efubaoBalanceLabel.text = L(@"Yifubao balance:");
        
        _efubaoBalanceLabel.textColor = RGBCOLOR(66, 31, 30);
        
        _efubaoBalanceLabel.font = [UIFont systemFontOfSize:16.0];
        
        
    }
    
    return _efubaoBalanceLabel;
}

-(UILabel *)balanceValueLabel{
    
    if(_balanceValueLabel == nil)
    {
        
        _balanceValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 175, 240, 24)];
        
        _balanceValueLabel.font = [UIFont systemFontOfSize:16.0];
        
        _balanceValueLabel.backgroundColor = [UIColor clearColor];
        
        _balanceValueLabel.textColor = [UIColor redColor];
        
        _balanceValueLabel.text = [NSString stringWithFormat:@"¥ %@%@",[UserCenter defaultCenter].userInfoDTO.yifubaoBalance,L(@"Money Unit") ];
        
    }
    
    return _balanceValueLabel;
}

- (UILabel *)passwordLabel
{
    if (!_passwordLabel)
    {
        _passwordLabel = [[UILabel alloc]init];
        
        _passwordLabel.frame = CGRectMake(10, 212, 300, 24);
        
        [_passwordLabel  setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pay_background.png"]]];

        _passwordLabel.text = L(@"Payment password:");
        
        _passwordLabel.textColor = RGBCOLOR(66, 31, 30);
        
        _passwordLabel.font = [UIFont systemFontOfSize:16.0];
        
        
    }
    
    return _passwordLabel;
}

-(UITextField *)passwordField{
    
    if (!_passwordField) {
        
        _passwordField = [[UITextField alloc]init];
        
        _passwordField.frame = CGRectMake(115, 212, 240, 24);
        
        _passwordField.secureTextEntry = YES;
        
        _passwordField.delegate = self;
        
        _passwordField.tag = 100;
        
        _passwordField.font = [UIFont systemFontOfSize:15.0];
        
        _passwordField.keyboardType = UIKeyboardTypeDefault;
        
        _passwordField.returnKeyType = UIReturnKeyDone;
        
        _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _passwordField.placeholder = L(@"Please enter the payment password");
        
        
        
    }
    
    return _passwordField;
}

-(EfubaoAccountService*)efubaoAccountService
{
    if(_efubaoAccountService == nil)
    {
        _efubaoAccountService = [[EfubaoAccountService alloc]init];
        
        _efubaoAccountService.delegate = self;
    }
    return _efubaoAccountService;
}

- (void)changeView
{
    self.balanceValueLabel.text = [NSString stringWithFormat:@"¥ %0.2f%@",[[UserCenter defaultCenter].userInfoDTO.yifubaoBalance floatValue] <= 0 ? 0 : [[UserCenter defaultCenter].userInfoDTO.yifubaoBalance floatValue],L(@"Money Unit")];
    
    if ([UserCenter defaultCenter].userInfoDTO == nil) {
        
        return;
    }
    
    if (![UserCenter defaultCenter].isEppActive)
    {
        
        self.passwordLabel.text = L(@"Your Yifubao has not yet been activated");
        
        self.passwordLabel.font = [UIFont systemFontOfSize:12];
        
        self.passwordLabel.textColor = [UIColor redColor];
        
        self.passwordField.placeholder = @"";
        
        self.passwordField.userInteractionEnabled = NO;
        
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"pay_button_setGray.png"] forState:UIControlStateNormal];
        
        self.payButton.userInteractionEnabled = NO;
        
        self.passwordField.text = @"";
        
    }
    else if ([self.lotteryDto.productMoney doubleValue] > [[UserCenter defaultCenter].userInfoDTO.yifubaoBalance doubleValue])
    {
        self.passwordLabel.text = L(@"LOEfubaoNotEnough");//L(@"Your account balance is not enough");
        
        self.passwordLabel.textColor = [UIColor redColor];
        
        self.passwordField.placeholder = @"";
        
        self.passwordLabel.font = [UIFont systemFontOfSize:16];

        self.passwordField.userInteractionEnabled = NO;
        
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"pay_button_setGray.png"] forState:UIControlStateNormal];
        
        self.payButton.userInteractionEnabled = NO;
        
        self.passwordField.text = @"";
        
    }
    
    else
    {        
        self.passwordField.textColor = [UIColor blackColor];
        
        self.passwordLabel.font = [UIFont systemFontOfSize:16];
        
        self.passwordField.placeholder = L(@"Please enter the payment password");
        
        self.passwordField.secureTextEntry = YES;
        
        self.passwordField.userInteractionEnabled = YES;
        
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"pay_button_unselected.png"] forState:UIControlStateNormal];
        
        self.payButton.userInteractionEnabled = YES;
        
        self.passwordLabel.text = L(@"Payment password:");
        
        self.passwordLabel.textColor = RGBCOLOR(66, 31, 30);
        
    }
    
}

- (UIButton *)payButton
{
    if (!_payButton)
    {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _payButton.frame = CGRectMake(10, 256, 300, 37);
        
        [_payButton setBackgroundImage:[UIImage imageNamed:@"pay_button_unselected.png"] forState:UIControlStateNormal];
        
        [_payButton setBackgroundImage:[UIImage imageNamed:@"pay_button_selected.png"] forState:UIControlStateSelected];
        
        [_payButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _payButton;
}

- (UIImageView *)cutLineView
{
    if (!_cutLineView)
    {
        _cutLineView = [[UIImageView alloc]init];
        
        _cutLineView.frame = CGRectMake(0, 313, 320, 3);
        
        _cutLineView.image = [UIImage imageNamed:@"pay_cutLine.png"];
    }
    return _cutLineView;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == self.passwordField)
    {
        
        if (![textField.text isEqualToString:@""])
        {
            
            NSString *password = textField.text;
            
            self.payPassword = password;
            
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.passwordField)
    {
        
        [self.passwordField resignFirstResponder];
        
        if (![textField.text isEqualToString:@""])
        {
            
            NSString *password = textField.text;
            
            self.payPassword = password;
            
            
        }
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.passwordField) {
        if (textField.text.length >= 20 && range.location >=20)
        {
            return NO;
        }
        if (textField.text.length + string.length - range.length > 20) {

            return NO;
        }
    }
    return YES;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0)
    {
        return 2;
    }
    else
        return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 20;
    }
    return 220;    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];

    if (section == 0) {
        view.frame = CGRectMake(0, 0, 320, 220);
                
        [self.tableView addSubview:self.efubaoLabel];
        
        [self.tableView addSubview:self.alertMsgLabel];
        
        [self.tableView addSubview:self.efubaoBalanceLabel];
        
        [self.tableView addSubview:self.balanceValueLabel];
        
        [self.tableView addSubview:self.passwordLabel];
        
        [self.tableView addSubview:self.passwordField];
        
        [self.tableView addSubview:self.payButton];
        
        [self.tableView addSubview:self.cutLineView];

        [self changeView];
    }else{
        view.frame = CGRectMake(0, 0, 320, 20);
    }
    
    return view;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0)
    {
        
        static NSString *lotteryPayInfoIdentifier = @"lotteryPayInfoIdentifier";
        
        LotteryPayCell *cell = [tableView dequeueReusableCellWithIdentifier:lotteryPayInfoIdentifier];
        
        if (cell == nil) {
            
            cell = [[LotteryPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lotteryPayInfoIdentifier];
            
        }
        
        NSDictionary *dic  = [self.itemList objectAtIndex:indexPath.row];
        
        
        [cell setItem:dic];
        
        if (indexPath.row == 0)
        {
            
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pay_nameBackground.png"]];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pay_saleBackground.png"]];
            
        }
        
        return cell;
        
    }
    else
    {
        static NSString *unionpayInfoIdentifier = @"unionpayInfoIdentifier";
        
        LotteryPayCell *cell = [tableView dequeueReusableCellWithIdentifier:unionpayInfoIdentifier];
        
        if (cell == nil)
        {
            cell = [[LotteryPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unionpayInfoIdentifier];
            
        }
        
        NSDictionary *dic  = [self.itemList objectAtIndex:indexPath.row+2];
        
        [cell setItem:dic];
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pay_sectionBackground.png"]];
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if ([UserCenter defaultCenter].userInfoDTO == nil) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
            
            return;
        }

        if (![UserCenter defaultCenter].isEppActive)
        {
            [self presentSheet:L(@"Your Yifubao has not yet been activated,you can't use unionpay to pay")];
        }
        else
        {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            
            LotteryPayCell *cell = (LotteryPayCell *)[self.tpTableView cellForRowAtIndexPath:indexPath];
            
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pay_sectionBackground_selected.png"]];
            
            isEfubaoPay = NO;

            [self sendSubmitOrderHttpRequest];
            
        }
        
        
    }
}

#pragma mark -
#pragma mark 银联支付回调

- (void)UPPayPluginResult:(NSString*)result
{
    DLog(@"result:%@", result);
    if([result isEqualToString:@"cancel"])
    {
        
        [self.navigationController popToViewController:self animated:NO];
        
        isSending = NO;

//        [self presentSheet:@"支付失败"];
        
    }
    else if(![result isEqualToString:@"fail"] &&![result isEqualToString:@"cancel"])
    {
        NSString * resultString = L(@"Submit orders for success, I wish you the award-winning");
        
        BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error")  message:resultString customView:nil delegate:nil cancelButtonTitle:L(@"Goto Lottery hall")  otherButtonTitles:L(@"View orders")];
        alertView.tag = 226;
                
        [alertView setConfirmBlock:^{
            
            [self alertViewDismiss:1];
            
        }];
        
        [alertView setCancelBlock:^{
            
            [self alertViewDismiss:0];
            
        }];

        [alertView show];

        TT_RELEASE_SAFELY(alertView);
        
    }
    else
    {
        [self presentSheet:L(@"Pay failed")];
        
        isSending = NO;
    }
    
}



#pragma mark - action

-(void)initData{
    
    NSString *dic1ItemName = [NSString stringWithFormat:@"%@-%@-%@",self.lotteryDto.productName,
                              self.lotteryDto.productTimes,
                              self.lotteryDto.saleType];
    
    NSString *dic2ItemValue = [NSString stringWithFormat:@"¥ %@元",self.lotteryDto.productMoney];
    
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:L(@"Product Name:"),@"itemName",
                          dic1ItemName,@"itemValue",
                          RGBCOLOR(66, 31, 30),@"valueColor",@"isNotPay",@"isPay",nil];
    
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:L(@"Total merchandise:"),@"itemName",
                          dic2ItemValue,@"itemValue",
                          RGBCOLOR(66, 31, 30),@"valueColor",@"isNotPay",@"isPay",nil];
    
    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:L(@"Unionpay"),@"itemName",L(@"It's safe,fast and supports all banks to pay"),@"itemValue",
                          [UIColor darkGrayColor],@"valueColor",@"isUnionpay",@"isPay",nil];
    
    if ([self.itemList count] == 0) {
        [self.itemList addObject:dic1];
        [self.itemList addObject:dic2];
        [self.itemList addObject:dic3];
        
    }else
    {
        [self.itemList replaceObjectAtIndex:0 withObject:dic1];
        [self.itemList replaceObjectAtIndex:1 withObject:dic2];
        [self.itemList replaceObjectAtIndex:2 withObject:dic3];
        
        
    }
    
    
    
}


-(void)submit{
    
    [self.passwordField resignFirstResponder];
    
    if ([UserCenter defaultCenter].userInfoDTO == nil) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        
        return;
    }
    
    if (isSending||![UserCenter defaultCenter].isEppActive) {
        if (![UserCenter defaultCenter].isEppActive) {
            
            [self presentSheet:L(@"Your Yifubao has not yet been activated")];
        }
        return;
    }
    if (self.passwordField.text == nil || [self.passwordField.text isEqualToString:@""])
    {
        
        [self presentSheet:L(@"Please input your password") posY:100.0];
        
        return;
        
    }
    if (self.passwordField.text.trim.length < 6 || self.passwordField.text.trim.length > 20) {
        
        [self presentSheet:L(@"LOPleaseInputSecretCode")];
        
        return;
    }
    
    self.payPassword = self.passwordField.text;
    
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:L(@"Confirm the payment you") customView:nil delegate:nil cancelButtonTitle:L(@"Cancel")  otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        if (isSending == NO) {
            
            isEfubaoPay = YES;
            
            [self sendSubmitOrderHttpRequest];
        }
    }];
    
    [alertView show];

    TT_RELEASE_SAFELY(alertView);

}


#pragma mark - 取消登陆
-(void)cancelLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)alertViewDismiss:(NSInteger)buttonIndex
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSNumber *type = [self.lotteryDto.periods integerValue]<=1?[NSNumber numberWithInteger:kDealsType_DaiGou]:[NSNumber numberWithInteger:kDealsType_ZhuiHao];
    [dic setObject:type forKey:@"type"];
    
    if (self.tabBarController.selectedIndex == 0)
    {
        if (buttonIndex == 0) {
            
            for (UIViewController *ctrl in [self.navigationController viewControllers] )
            {
                if ([ctrl isKindOfClass:[LotteryHallViewController class]])
                {
                    [self.navigationController popToViewController:ctrl animated:YES];
                }
            }
        }
        else if (buttonIndex == 1)
        {
                
            [[NSNotificationCenter defaultCenter ]postNotificationName:@"GoToLotteryOrderDetail" object:nil];
            
            [dic setObject:self.projid forKey:@"projid"];
            [dic setObject:self.lotteryDto.gid forKey:@"gid"];            
        }
    
    }else if (self.tabBarController.selectedIndex == 4){
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"GoLotteryOrderDetailFormOrder" object:nil];

        if (buttonIndex == 0) {
            [dic setObject:@"1" forKey:@"goToType"];
        }else{
            [dic setObject:@"2" forKey:@"goToType"];
            [dic setObject:self.projid forKey:@"projid"];
            [dic setObject:self.lotteryDto.gid forKey:@"gid"];
        }
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_MYLOTTERY object:nil userInfo:dic];

}



#pragma mark -  提交订单接口
- (void)sendSubmitOrderHttpRequest
{
    isSending = YES;
    
    [self displayOverFlowActivityView];
    
    NSString *productTimes = self.lotteryDto.productTimes == nil ?@"":self.lotteryDto.productTimes;
    NSString *buyCodes = self.lotteryDto.buyCodes == nil ?@"":self.lotteryDto.buyCodes;
    NSString *multiNo = self.lotteryDto.multiNo == nil?@"":self.lotteryDto.multiNo;
    NSString *saleType = self.lotteryDto.saleType == nil?@"":self.lotteryDto.saleType;
    NSString *productMoney = self.lotteryDto.productMoney==nil?@"":self.lotteryDto.productMoney;
    NSString *password = self.payPassword == nil?@"":self.payPassword;
    NSString *gid = self.lotteryDto.gid == nil?@"":self.lotteryDto.gid;
    NSString *periods = self.lotteryDto.periods == nil?@"":self.lotteryDto.periods; //追号期数
    BOOL    stopWhenWin = self.lotteryDto.stopWhenWin;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    //公用参数
    [postDataDic setObject:@"1"  forKey:@"json"];                          //是否返回json格式字符串,1:是，0否
    [postDataDic setObject:gid forKey:@"gid"];                             //游戏编号
    [postDataDic setObject:buyCodes forKey:@"codes"];                      //投注号码 |分割红蓝 ;分割不同两组号
    
    [postDataDic setObject:productMoney forKey:@"money"];                  //方案金额
    
    [postDataDic setObject:@"2" forKey:@"source"];                         //投注来源（0:网站 1:客户端 2:手机 3:wap）
    
    //非公用参数
    if ([self.lotteryDto.saleType isEqualToString:L(@"purchasing")])
    {
        //代购订单易付宝支付和手机银联支付公用参数
        [postDataDic setObject:productTimes forKey:@"pid"];                    //期次编号
        [postDataDic setObject:@"1" forKey:@"play"];                           //玩法编号，默认为1
        [postDataDic setObject:@"0" forKey:@"fflag"];                          //是否文件，代购为0
        [postDataDic setObject:@"0" forKey:@"type"];                           //方案类型，代购为0
        [postDataDic setObject:multiNo forKey:@"muli"];                        //投注倍数
        [postDataDic setObject:saleType forKey:@"name"];                       //方案标题，默认为"代购"
        [postDataDic setObject:saleType forKey:@"desc"];                       //方案描述，默认为"代购"
        [postDataDic setObject:@"1" forKey:@"tnum"];                           //方案份数，代购为1
        [postDataDic setObject:@"1" forKey:@"bnum"];                           //购买份数，代购为1
        [postDataDic setObject:@"0" forKey:@"pnum"];                           //保底份数，代购为0
        [postDataDic setObject:@"0" forKey:@"oflag"];                          //公开标志，默认为0
        [postDataDic setObject:@"0" forKey:@"wrate"];                          //提成比率，默认为0
        [postDataDic setObject:@"" forKey:@"comeFrom"];                        //方案来源，默认为空
        [postDataDic setObject:@"" forKey:@"endTime"];                         //截至时间，默认为空
        //代购订单易付宝支付独享参数
        if (isEfubaoPay)
        {
            
            NSString *loginId = [UserCenter defaultCenter].userInfoDTO.logonId;
            [postDataDic setObject:loginId forKey:@"loginId"];                      // 登录账号
            
            NSData *plainPassword = [password dataUsingEncoding:NSUTF8StringEncoding];
            NSString *encryptPassword = [PasswdUtil encryptData:plainPassword forUser:loginId];
            [postDataDic setObject:encryptPassword forKey:@"passWord"];                   //易付宝密码
            
            [postDataDic setObject:@"1" forKey:kRequestPwdFlag];
            
            [postDataDic setObject:@"0" forKey:@"payMethod"];                      //支付方式：0或者null 易付宝支付； 1 手机银联支付
            
        }
        //代购订单银联支付独享参数
        else
        {
            [postDataDic setObject:@"1" forKey:@"payMethod"];                      //支付方式：0或者null 易付宝支付； 1 手机银联支付
            
        }
        
    }
    else
    {
        //追号订单易付宝支付和手机银联支付公用参数
        [postDataDic setObject:periods forKey:@"pidNum"]; //追号次数
        [postDataDic setObject:multiNo forKey:@"mulitys"]; //倍数
        [postDataDic setObject:[NSString stringWithFormat:@"%d",stopWhenWin] forKey:@"zflag"];
        [postDataDic setObject:@"1" forKey:@"ichase"];   //未知项  必填
        //追号订单易付宝支付独享参数
        
        if (isEfubaoPay)
        {
            
            NSString *loginId = [UserCenter defaultCenter].userInfoDTO.logonId;
            [postDataDic setObject:loginId forKey:@"loginId"];                      // 登录账号
            
            NSData *plainPassword = [password dataUsingEncoding:NSUTF8StringEncoding];
            NSString *encryptPassword = [PasswdUtil encryptData:plainPassword forUser:loginId];
            [postDataDic setObject:encryptPassword forKey:@"passWord"];                   //易付宝密码
            
            [postDataDic setObject:@"1" forKey:kRequestPwdFlag];
            
            [postDataDic setObject:@"0" forKey:@"payMethod"];                      //支付方式：0或者null 易付宝支付； 1 手机银联支付
            
        }
        //追号订单银联支付独享参数
        else
        {
            [postDataDic setObject:@"1" forKey:@"payMethod"];                      //支付方式：0或者null 易付宝支付； 1 手机银联支付
        }
    }
    
    [self.lotteryPayRequest beginLotteryPay:postDataDic];
    

}

#pragma mark -
#pragma mark - EfubaoAccountService

- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess
                            errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if(isSuccess)
    {
        isLoadEppOK = YES;
        
        [self initData];
    
        [self.tableView reloadData];
    
    }else{
//        isLoadEppOK = NO;
    }
}

#pragma mark -
#pragma mark - LotteryPayRequestServiceDelegate

-(void)getLotteryPayCompletionWithResult:(BOOL)isSussecc Service:(LotteryPayRequestService *)service
{
    [self removeOverFlowActivityView];

    if ([_lotteryPayRequest.unLoginErrorCode isEqualToString:@"common.2.userNotLoggedIn"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        return;
    }
    

    if (_lotteryPayRequest.lotteryPayErrorMsg)
    {
        //网络问题
        [self presentSheet:service.lotteryPayErrorMsg posY:[AppDelegate currentAppDelegate].window.bounds.size.height/2 - 100];
        
        isSending = NO;
    }
    else
    {
        
        NSDictionary *items = service.items;
        
        NSString *resultString = @"";
        
        if ([[items objectForKey:kHttpResponseCode] isEqualToString:@"0"])
        {
            
            //支付成功
            isSending = YES;
            
            
            if([self.lotteryDto.saleType isEqualToString:@"代购"])
            {
                NSDictionary *resultDic = [items objectForKey:@"result"];
                
                if (resultDic)
                {
                    
                    self.projid = [resultDic objectForKey:@"@projid"]==nil?@"":[resultDic objectForKey:@"@projid"];
                    
                    self.unionUrl = [resultDic objectForKey:@"@eppUrl"]==nil?@"":[resultDic objectForKey:@"@eppUrl"];
                }
            }
            else
            {
                NSDictionary *resultDic = [items objectForKey:@"zhuihao"];
                
                if (resultDic)
                {
                    
                    self.projid = [resultDic objectForKey:@"@id"]==nil?@"":[resultDic objectForKey:@"@id"];
                    self.unionUrl = [resultDic objectForKey:@"@eppUrl"]==nil?@"":[resultDic objectForKey:@"@eppUrl"];
                    
                }
            }
            
            if(isEfubaoPay)
            {
                double eppbalance =  [[UserCenter defaultCenter].userInfoDTO.yifubaoBalance doubleValue]- [self.lotteryDto.productMoney doubleValue];
                
                [UserCenter defaultCenter].userInfoDTO.yifubaoBalance   = [NSString stringWithFormat:@"%0.2f",eppbalance];
                
                resultString = L(@"Submit orders for success, I wish you the award-winning");
                BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleLottery Title:L(@"system-error") message:resultString customView:nil delegate:nil cancelButtonTitle:L(@"Goto Lottery hall")  otherButtonTitles:L(@"View orders")];
                
                
                alertView.tag = 224;
                
                [alertView setConfirmBlock:^{
        
                    [self alertViewDismiss:1];
                    
                }];
                
                [alertView setCancelBlock:^{
                   
                    [self alertViewDismiss:0];
                    
                }];
                
                [alertView show];
                
                TT_RELEASE_SAFELY(alertView);

            }
            
            else
            {
                if (self.unionUrl.length >0)
                {
                    
                    //彩票现在只有易付宝收银柜台支付。
                    
//                    [UPPayPlugin startPay:self.unionUrl
//                               sysProvide:@"11173000"
//                                     spId:@"0229"
//                                     mode:@"00"
//                           viewController:self
//                                 delegate:self];

                }
                else
                {
                    [self presentSheet:L(@"Pay failed")];
                    return;
                }
            }
            
            [self.tableView reloadData];
        }else
        {
            //支付失败
            if([[items objectForKey:kHttpResponseCode]isEqualToString:@"-99"])
            {
                
                NSDictionary *resultDic = [items objectForKey:@"result"];
                
                if (resultDic)
                {
                    
                    if ([[resultDic objectForKey:@"@failure"] isEqualToString:@"3"])
                    {

                        [self presentSheet:L(@"Password input wrong more than three times the account has been frozen, automatically unlock after 24 hours")];
                    }
                    else
                    {
                        
                        int leftNo = [[resultDic objectForKey:@"@failure"]intValue];
                        
                        if (leftNo == -1)
                        {
                            resultString = L(@"yifubao check failure");
                        }
                        else
                        {
                            resultString = [NSString stringWithFormat:@"%@%d%@",L(@"Enter the wrong password, but also can to try"),(3-leftNo),L(@"times,if failed account will be frozen")];
                        }
                        
                        [self presentSheet:resultString];

                    }
                }
                
            }
            else
            {
                resultString = [items objectForKey:kHttpResponseDesc];
                
                if (IsStrEmpty(resultString))
                {
                    resultString = L(@"Network anomalies, please try again later");
                }
                
                [self presentSheet:resultString];
            }
            
            isSending = NO;
        }
    }

}

@end
