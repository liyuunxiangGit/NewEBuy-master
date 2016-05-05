//
//  UserFeedBackNewViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserFeedBackNewViewController.h"
#import "PlaceholderTextView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UserFeedBackService.h"
#import "FormattersValidators.h"
#import "CommonTextField.h"

@interface UserFeedBackNewViewController () <UITextFieldDelegate, UITextViewDelegate, UserFeedBackServiceDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *tpScrollView;
@property (nonatomic, strong) PlaceholderTextView *textView;
@property (nonatomic, strong) CommonTextField *textField;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UserFeedBackService *userFeedBackService;

@end

@implementation UserFeedBackNewViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_userFeedBackService);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"User Feedback");
        //self.hasNav = NO;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        self.hidesBottomBarWhenPushed = YES;

    }
    return self;
}

- (void)loadView{
    [super loadView];
    
//    [self useBottomNavBar];
//    
//    [self.bottomNavBar.ebuyBtn addTarget:self action:@selector(goToMyEbuy) forControlEvents:UIControlEventTouchUpInside];
    self.hasSuspendButton = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.tpScrollView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.tpScrollView];
    
    CGFloat hMargin = 21, vMargin = 17;
    CGFloat width = 320 - 2 * hMargin;
    
    self.textView.frame = CGRectMake(hMargin, vMargin, width, 110);
    [self.tpScrollView addSubview:self.textView];
    
    self.textField.frame = CGRectMake(hMargin,self.textView.frame.size.height+2*vMargin, width, 29);
    [self.tpScrollView addSubview:self.textField];
    
    self.commitButton.frame = CGRectMake(hMargin, self.textField.frame.size.height+self.textField.frame.origin.y+3*vMargin-35 , width, 39);
    [self.tpScrollView addSubview:self.commitButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---------------action
- (void)goToMyEbuy
{
    
//    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:4];
    
    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:4] popToRootViewControllerAnimated:NO];
    
}
#pragma mark ----------------------------- views

- (TPKeyboardAvoidingScrollView *)tpScrollView
{
    if (!_tpScrollView) {
        _tpScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
        _tpScrollView.backgroundColor = [UIColor clearColor];
    }
    return _tpScrollView;
}

- (PlaceholderTextView *)textView
{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc] init];
        _textView.frame = CGRectMake(0, 0, 278, 110);
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.0f];
        _textView.textColor = [UIColor darkTextColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 8.0f;
        _textView.layer.borderColor = k233TextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = L(@"UserFeedBack_IsSatisfied");
        
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
        _textView.layer.borderColor = [UIColor light_Gray_Color].CGColor;//k233TextBorderColor.CGColor;
        _textView.layer.borderWidth = 1.0;
    }
    return _textView;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[CommonTextField alloc] init];
        _textField.isDrawer = YES;
        _textField.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textField.leftPadding = 7;
        _textField.frame = CGRectMake(0, 0, 278, 29);
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:14.0];
        _textField.textColor = [UIColor darkTextColor];
        _textField.placeholder = L(@"UserFeedBack_PhonenumAndEmail");
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.borderStyle = UITextBorderStyleLine;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        if (IOS5_OR_LATER)
        {
            _textField.spellCheckingType = UITextSpellCheckingTypeDefault;
        }
        _textField.secureTextEntry = NO;
        _textField.layer.cornerRadius = 4.0f;
        _textField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        _textField.layer.borderWidth = 1.0;

    }
    return _textField;
}

- (UILabel *)label1
{
    if (!_label1)
    {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.font = [UIFont systemFontOfSize:14.0];
        _label1.textColor = [UIColor colorWithRGBHex:0x444444];
        _label1.textAlignment = NSTextAlignmentRight;
        _label1.shadowColor = [UIColor whiteColor];
        _label1.shadowOffset = CGSizeMake(0.5, 0.5);
        
        _label1.hidden = YES;
    }
    return _label1;
}

- (UIButton *)commitButton
{
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = [UIColor clearColor];
        [_commitButton setTitle:L(@"Commit") forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_commitButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitButton.titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [_commitButton setBackgroundImage:[UIImage streImageNamed:@"orange_button.png"]
                                 forState:UIControlStateNormal];
        [_commitButton setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"]
                                 forState:UIControlStateHighlighted];
        _commitButton.titleEdgeInsets = UIEdgeInsetsZero;
        _commitButton.imageEdgeInsets = UIEdgeInsetsZero;
        [_commitButton addTarget:self
                         action:@selector(commit:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----------------------------- commit

- (UserFeedBackService *)userFeedBackService
{
    if (!_userFeedBackService) {
        _userFeedBackService = [[UserFeedBackService alloc] init];
        _userFeedBackService.delegate = self;
    }
    return _userFeedBackService;
}

- (void)commit:(id)sender
{
    if ([self.textView.text.trim length] == 0) {
        
        return [self presentSheet:L(@"UserFeedBack_InputYourOpinion")timer:3];
    }
    NSLog(@"%d",[self.textView.text.trim length]);
    if ([self.textView.text.trim length] >= 150)
    {
        [self presentSheet:L(@"UserFeedBack_MessageConstrained") timer:3];
        return;
    }
    if ([self.textField.text.trim length] == 0) {
        
        return [self presentSheet:L(@"UserFeedBack_InputYourContactWay") timer:3];
    }
    
    if (![FormattersValidators isValidEmail:self.textField.text] &&
        ![FormattersValidators isValidPhone:self.textField.text])
    {
        return [self presentSheet:L(@"UserFeedBack_InputPhoneAndEmailCorrectly") timer:3];
        //return [self presentCustomDlg:@"请输入正确的邮箱或手机号"];
    }
    
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    UserFeedBackDTO *feedbackDto = [[UserFeedBackDTO alloc] init];
//    feedbackDto.feedbackType = [NSString stringWithFormat:@"%d",lastSelect+1];
    feedbackDto.feedbackType = @"7";    //默认其他
    feedbackDto.feedbackContext = self.textView.text;
    feedbackDto.contactInfo = self.textField.text;
    
    NSString *platform = [SystemInfo platform];
    if ([platform hasPrefix:@"iPhone"]) {
        feedbackDto.terminal = @"1";
    }else if ([platform hasPrefix:@"iPad"]) {
        feedbackDto.terminal = @"2";
    }else {
        feedbackDto.terminal = @"3";
    }
    feedbackDto.terminalOsVersion= [SystemInfo osVersion];
    feedbackDto.appId = @"1";   //苏宁易购
    feedbackDto.terminalAppVersion = [NSString stringWithFormat:@"%@ %@",L(@"eBuy"),
                                      [SystemInfo appVersion]];
    feedbackDto.clientId =
    [NSString stringWithFormat:@"%@",[UserCenter defaultCenter].userInfoDTO.logonId];
    [self displayOverFlowActivityView];
    [self.userFeedBackService beginSendFeedBackRequest:feedbackDto];
}

- (void)didSendFeedBackRequestComplete:(UserFeedBackService *)service Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"system-info")
                              message:L(@"Send success, thank for your feedback")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];
        [alert setCancelBlock:^{
            
           // NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
           // [vcs removeLastObject]; [vcs removeLastObject];
           // UIViewController *vc = [vcs lastObject];
//            if (vc)
//            {
               [self.navigationController popViewControllerAnimated:YES];
//            }
        }];
        [alert show];
    }
    else
    {
        [self presentSheet:(service.errorMsg.length?service.errorMsg:L(@"Send failed")) timer:3];
    }
}


@end
