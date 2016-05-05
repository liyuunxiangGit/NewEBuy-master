//
//  AddCouponViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AddCouponViewController.h"
#import "UITableViewCell+BgView.h"
#import "SNReaderViewController.h"
#import "GiftCouponService.h"

@interface AddCouponViewController () <UITextFieldDelegate,SNReaderDelegate,GiftCouponServiceDelegate>

@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) GiftCouponService *service;

@end

@implementation AddCouponViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"PFAddCoupon");
        self.pageTitle = L(@"Product_ShoppingCart_AddCoupon");//[NSString stringWithFormat:@"%@-%@",L(@"shopProcess_shop_addTicket"),self.title];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.groupTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.groupTableView];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 320, 80);
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:self.confirmButton];
    self.groupTableView.tableFooterView = view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.codeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------------------- views

- (UITextField *)codeTextField
{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.frame = CGRectMake(15, 7, 250, 30);
        _codeTextField.backgroundColor = [UIColor clearColor];
        _codeTextField.font = [UIFont systemFontOfSize:14.0];
        _codeTextField.textColor = [UIColor blackColor];
        _codeTextField.placeholder = L(@"PFPleaseEnterCouponNumber");
        _codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.delegate = self;
        _codeTextField.keyboardType = UIKeyboardTypeDefault;
        _codeTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _codeTextField;
}

- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.frame = CGRectMake(15, 7, 280, 30);
        _passwordField.backgroundColor = [UIColor clearColor];
        _passwordField.font = [UIFont systemFontOfSize:14.0];
        _passwordField.textColor = [UIColor blackColor];
        _passwordField.placeholder = L(@"PFPleaseEnterCouponPassword");
        _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passwordField.borderStyle = UITextBorderStyleNone;
        _passwordField.delegate = self;
        _passwordField.keyboardType = UIKeyboardTypeDefault;
        _passwordField.returnKeyType = UIReturnKeyDone;
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordField.secureTextEntry = YES;
    }
    return _passwordField;
}

- (UIButton *)scanButton
{
    if (!_scanButton) {
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanButton.frame = CGRectMake(0, 0, 40, 40);
        [_scanButton setImage:[UIImage imageNamed:@"QR_code.png"]
                     forState:UIControlStateNormal];
        _scanButton.titleEdgeInsets = UIEdgeInsetsZero;
        _scanButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [_scanButton addTarget:self action:@selector(scanBarCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

- (UIButton *)confirmButton
{
    if(!_confirmButton)
    {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 5, 290, 35)];
        [_confirmButton setTitle:L(@"PFAdd") forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor light_White_Color]
                             forState:UIControlStateNormal];
        [_confirmButton setTitleShadowColor:[UIColor whiteColor]
                                   forState:UIControlStateNormal];
        _confirmButton.titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_confirmButton addTarget:self
                           action:@selector(confirm:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:[UIImage streImageNamed:@"button_orange_normal.png"]
                                  forState:UIControlStateNormal];
    }
    
    return _confirmButton;
}

#pragma mark ----------------------------- text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        
    if (indexPath.row == 0)
    {
        [cell.contentView addSubview:self.codeTextField];
        cell.accessoryView = self.scanButton;
    }
    else
    {
        [cell.contentView addSubview:self.passwordField];
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

//扫描条形码
- (void)scanBarCode
{
    SNReaderViewController *readerViewController = [[SNReaderViewController alloc] init];
    readerViewController.snDelegate = self;
    readerViewController.isServicePay = YES;
    [self presentModalViewController:readerViewController animated:YES];
}

#pragma mark ----------------------------- bar code reader call back

- (void)readerView:(ZBarReaderView *)view
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for (symbol in symbols)
    {
        break;
    }
    
    NSString *zbarString = symbol.data;
    
    [self dismissModalViewControllerAnimated: YES];
    self.codeTextField.text = zbarString;
}

- (void)manualInput
{
    if (IOS5_OR_LATER)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.codeTextField becomeFirstResponder];
        }];
    }
    else
    {
        [self dismissModalViewControllerAnimated:NO];
        
        [self.codeTextField becomeFirstResponder];
    }
}

#pragma mark ----------------------------- action

- (GiftCouponService *)service
{
    if (!_service) {
        _service = [[GiftCouponService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)confirm:(id)sender
{
    NSString *giftCouponId = [self.codeTextField.text trim];
    
    if (IsStrEmpty(giftCouponId)) {
        [self presentSheet:L(@"PFPleaseEnterCouponOrCardNumber") posY:50];
        [self.codeTextField becomeFirstResponder];
        return;
    }
    
    if (![GiftCouponService validateString:giftCouponId]) {
        [self presentSheet:L(@"PFPleaseEnterCorrectCouponOrCardNumber") posY:50];
        [self.codeTextField becomeFirstResponder];
        return;
    }
    
    NSString *giftCouponPass = [self.passwordField.text trim];
    
    if (![GiftCouponService validateString:giftCouponPass] && !IsStrEmpty(giftCouponPass)) {
        [self presentSheet:L(@"PFPleaseEnterCorrectPassword") posY:50];
        [self.passwordField becomeFirstResponder];
        return;
    }
    
    [self login];
    
    [self.codeTextField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    [self displayOverFlowActivityView];
    [self.service beginActiveGiftCouponRequest:giftCouponId?giftCouponId:@""
                                       cardPwd:giftCouponPass?giftCouponPass:@""
                                       phoneNo:@""];
}

- (void)activeGiftCouponCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info") message:L(@"PFAddSuccess") delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
        [alert setCancelBlock:^{
            
            if ([_delegate respondsToSelector:@selector(addCouponDidOk:)])
            {
                [_delegate addCouponDidOk:self];
            }
            [self.navigationController popViewControllerAnimated:YES];

        }];
        [alert show];
    }
    else
    {
        if (IsStrEmpty(errorMsg)) {
            [self presentSheet:L(@"PFAddCouponOrCardFailed")];
        }else{
            [self presentSheet:errorMsg];
        }
    }
}

@end
