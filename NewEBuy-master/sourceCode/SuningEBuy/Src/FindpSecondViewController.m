//
//  FindpSecondViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FindpSecondViewController.h"
#import "FindpThirdViewController.h"

@interface FindpSecondViewController ()

@end

@implementation FindpSecondViewController

@synthesize codeTextField           = _codeTextField;
@synthesize codeBtn                 = _codeBtn;
@synthesize phoneNumLabel           = _phoneNumLabel;
@synthesize codeTimer               = _codeTimer;

@synthesize findPasswordDto         = _findPasswordDto;
@synthesize findPasswordService     = _findPasswordService;

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_findPasswordService);
    
    TT_RELEASE_SAFELY(_findPasswordDto);
    TT_RELEASE_SAFELY(_codeBtn);
    TT_RELEASE_SAFELY(_codeTextField);
    TT_RELEASE_SAFELY(_phoneNumLabel);
    
    [_codeTimer removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_codeTimer);

    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"find_password");
        self.pageTitle = L(@"Member_LoginAndRegister_ResetPassword2");
        if (!_findPasswordDto) {
            _findPasswordDto = [[FindPasswordDTO alloc] init];
        }
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Next Step")];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.groupTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 44);
    [self.groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.groupTableView];
    
    [self.codeTimer start];
    self.codeBtn.enabled = NO;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.codeTextField becomeFirstResponder];
    self.codeTextField.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTime];
}

- (void)stopTime
{
    [self.codeTimer stop];
    [self.codeBtn setTitle:L(@"get_code_again") forState:UIControlStateNormal];
    self.codeBtn.enabled = YES;
}

- (void)righBarClick
{

    if (![self validateAllInfo]) {
        return;
    }
    [self.codeTextField resignFirstResponder];
    
    self.findPasswordDto.validateCode = self.codeTextField.text;
    self.findPasswordDto.stepIndex = 3;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView];
    [self.findPasswordService beginFindPasswordHttpRequest:self.findPasswordDto];

}

- (FindPasswordService *)findPasswordService
{
    if (!_findPasswordService) {
        _findPasswordService = [[FindPasswordService alloc] init];
        _findPasswordService.delegate = self;
    }
    return _findPasswordService;
}


#pragma mark -
#pragma mark init view

- (UITextField *)codeTextField
{
    if (!_codeTextField) {
        CGRect rect = CGRectMake(75, 7, 320  - 28 - 75, 30);
        //if (IOS7_OR_LATER)
        rect = CGRectMake(30, 7, 180, 30);

        _codeTextField = [[UITextField alloc] initWithFrame:rect];
		_codeTextField.delegate = self;
        _codeTextField.font = [UIFont systemFontOfSize:14.0];
		_codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_codeTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.enablesReturnKeyAutomatically = YES;
		_codeTextField.placeholder = L(@"please_enter_code");
    }
    return _codeTextField;
}

- (UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = CGRectMake(220, 30, 90, 50);
         //if (IOS7_OR_LATER)
        rect = CGRectMake(210,-1, 110, 46);
        _codeBtn.frame = rect;
        _codeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _codeBtn.backgroundColor = [UIColor clearColor];
        //if (IOS7_OR_LATER)
        {
            [_codeBtn setTitleColor:[UIColor orange_Light_Color]forState:UIControlStateNormal];
            [_codeBtn setTitleColor:[UIColor colorWithRGBHex:0xa7a7a7] forState:UIControlStateDisabled];
        }
//        else
//        {
//            [_codeBtn setTitleColor:[UIColor colorWithRGBHex:0xffffff] forState:UIControlStateNormal];
//            [_codeBtn setTitleColor:[UIColor colorWithRGBHex:0x999999] forState:UIControlStateDisabled];
//        }
        
        
        [_codeBtn setTitle:L(@"get_code_again") forState:UIControlStateNormal];
        //if (IOS7_OR_LATER)
        {
            [_codeBtn setBackgroundImage:[UIImage imageNamed:@"ButtonArrNo.png"] forState:UIControlStateNormal];
            [_codeBtn setBackgroundImage:[UIImage imageNamed:kProductDetailAddToShoppingCarWithNoStore] forState:UIControlStateDisabled];
        }
//        else
//        {
//            [_codeBtn setBackgroundImage:[UIImage imageNamed:@"get_password_code_click_btn.png"] forState:UIControlStateNormal];
//            [_codeBtn setBackgroundImage:[UIImage imageNamed:@"get_password_code_unclick_btn.png"] forState:UIControlStateDisabled];
//        }
        [_codeBtn addTarget:self action:@selector(getCodeString) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

- (void)getCodeString
{
    [self displayOverFlowActivityView];
    self.findPasswordDto.stepIndex = 2;
    [self.findPasswordService beginFindPasswordHttpRequest:self.findPasswordDto];
}

- (void)findPasswordHttpComplete:(FindPasswordService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];

    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        if (self.findPasswordDto.stepIndex == 2) {
            [self.codeTimer start];
            self.codeBtn.enabled = NO;
        }else{
            FindpThirdViewController *third = [[FindpThirdViewController alloc] init];
            third.mobileNumString = self.mobileNumString;
            [self.navigationController pushViewController:third animated:YES];
        }
    }else{
        self.codeTextField.text = @"";
        [self presentSheet:service.errorMsg];
    }
}


- (Calculagraph *)codeTimer
{
    if (!_codeTimer)
    {
        _codeTimer = [[Calculagraph alloc] init];
        
        [_codeTimer addObserver:self
                     forKeyPath:@"time"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    }
    return _codeTimer;
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        int seconds = [[change objectForKey:@"new"] intValue];
        NSString *time = [NSString stringWithFormat:@"%d",60 - seconds];
        if ([time isEqualToString:@"0"]) {
            [self stopTime];
        }else{
            [self.codeBtn setTitle:[NSString stringWithFormat:@"%@%@秒",L(@"UCReObtain"),time] forState:UIControlStateDisabled];
        }
    }
}


#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//if (IOS7_OR_LATER)
    return 44;
//else
//    return 100;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, 320, 100);
    //if (IOS7_OR_LATER)
    rect = CGRectMake(0, 0, 320, 44);

    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    rect = CGRectMake(20, 40, 200, 30);
    //if (IOS7_OR_LATER)
    rect = CGRectMake(70, 8, 200, 30);

    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = [NSString stringWithFormat:@"%@%@",L(@"code_send_to"),self.mobileNumString];
    label.font = [UIFont boldSystemFontOfSize:14.0];
    label.textColor = [UIColor colorWithRGBHex:0x444444];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    //if (!IOS7_OR_LATER)
    //[view addSubview:self.codeBtn];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *findPasswordIdentifier = @"findPasswordIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:findPasswordIdentifier];
    
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:findPasswordIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (!IOS7_OR_LATER)
//        {
//            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_background_image.png"]];
//            image.frame = cell.frame;
//            image.backgroundColor = [UIColor clearColor];
//            cell.backgroundView = image;
//            cell.backgroundColor = [UIColor clearColor];
//            
//        }
        
//        if (!IOS7_OR_LATER)
//        {
//            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
//            cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
//        }
        
    }
    //if (IOS7_OR_LATER)
    [cell.contentView addSubview:self.codeBtn];
//    else
//    cell.textLabel.text = L(@"find_password_code");

    [cell.contentView addSubview:self.codeTextField];
    
    return cell;
}

#pragma mark - 
#pragma mark textfield delegate/datasource

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.codeTextField) {
        [self righBarClick];
        return YES;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.codeTextField) {
        if (textField.text.length >= 10 && range.location >= 10)
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark 校验数据
- (BOOL)validateAllInfo
{
    if(IsStrEmpty(self.codeTextField.text))
    {
        [self presentSheet:L(@"Please_input_message_VerifyNum") posY:50];
        [self.codeTextField becomeFirstResponder];
        return NO;
    }
    if (self.codeTextField.text.length < 4 || self.codeTextField.text.length > 10) {
        [self presentSheet:L(@"Please_input_correct_message_VerifyNum") posY:50];
        [self.codeTextField becomeFirstResponder];
        return NO;
    }
    
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:self.codeTextField.text]==NO) {
        [self presentSheet:L(@"Please_input_correct_message_VerifyNum") posY:50];
        [self.codeTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}

@end
