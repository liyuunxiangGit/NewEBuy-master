//
//  OSLeaveMessageViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSLeaveMessageViewController.h"
#import "PlaceholderTextView.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CommonTextField.h"
#import "FormattersValidators.h"

#define kOSLMTextWidth      278
#define kOSLMTextHeight     110
#define kOSLMMARGIN         (320-kOSLMTextWidth)/2

@interface OSLeaveMessageViewController () <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *tpScrollView;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) OHAttributedLabel *tipLabel;
@property (nonatomic, strong) PlaceholderTextView *textView;
@property (nonatomic, strong) CommonTextField *textField;

@end

@implementation OSLeaveMessageViewController

- (id)initWithShopCode:(NSString *)shopCode
              ShopName:(NSString *)shopName
           ProductCode:(NSString *)productCode
           ProductName:(NSString *)productName
               OrderId:(NSString *)orderId
{
    self = [super init];
    if (self) {
        self.shopCode = shopCode;
        self.shopName = shopName;
        self.productCode = productCode;
        self.productName = productName;
        self.orderId = orderId;
        self.title = shopName.length?shopName:L(@"OnlineService_LeaveMessageToSeller");
    }
    return self;
}

- (id)initWithAGroupMember:(NSString *)grouMember
                vendorName:(NSString *)vendorName
                 classCode:(NSString *)classCode
               ProductCode:(NSString *)productCode
               ProductName:(NSString *)productName
                   OrderId:(NSString *)orderId

{
    self = [super init];
    if (self) {
        self.shopName = vendorName;
        self.groupMember = grouMember;
        self.classCode = classCode;
        self.productCode = classCode;
        self.productName = productName;
        self.orderId = orderId;
        self.title = self.shopName.length?self.shopName:L(@"OnlineService_LeaveMessageToSeller");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SNBarButtonItem *item = [[SNBarButtonItem alloc] initWithSNStyle:SNBarItemStyleDone title:L(@"CommitBtn") target:self selector:@selector(leaveMessageAction)];
    self.navigationItem.rightBarButtonItem = item;
    
	// Do any additional setup after loading the view.
    self.tpScrollView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    [self.view addSubview:self.tpScrollView];
    
    
    CGRect frame = self.tpScrollView.frame;
    
    frame.origin.y = 20;
    
    frame.size.height = 235;
    
    self.whiteView.frame = frame;
    
    [self.tpScrollView addSubview:self.whiteView];
    
    CGFloat top = 30;
    if (self.productName.length)
    {
        self.label1.text = L(@"OnlineService_ConsultGoods");
        CGSize textSize = [self.label1.text sizeWithFont:self.label1.font];
        self.label1.frame = CGRectMake(kOSLMMARGIN, top, textSize.width, textSize.height);
        [self.tpScrollView addSubview:self.label1];
        
        self.label2.text = self.productName;
        CGSize text2Size = [self.productName sizeWithFont:self.label2.font];
        CGFloat maxWidth = kOSLMTextWidth - self.label1.width;
        CGFloat width = text2Size.width > maxWidth ? maxWidth : text2Size.width;
        self.label2.frame = CGRectMake(self.label1.right, top, width, text2Size.height);
        [self.tpScrollView addSubview:self.label2];
        
        top = self.label2.bottom + 20;
    }
    else if (self.orderId.length)
    {
        self.label1.text = L(@"OnlineService_ConsultOrder");
        CGSize textSize = [self.label1.text sizeWithFont:self.label1.font];
        self.label1.frame = CGRectMake(kOSLMMARGIN, top, textSize.width, textSize.height);
        [self.tpScrollView addSubview:self.label1];
        
        self.label2.text = self.orderId;
        CGSize text2Size = [self.orderId sizeWithFont:self.label2.font];
        CGFloat maxWidth = kOSLMTextWidth - self.label1.width;
        CGFloat width = text2Size.width > maxWidth ? maxWidth : text2Size.width;
        self.label2.frame = CGRectMake(self.label1.right, top, width, text2Size.height);
        [self.tpScrollView addSubview:self.label2];
        
        top = self.label2.bottom + 20;
    }
    //定制店铺入口进的话
    if (!self.productName.length&&!self.orderId.length) {
        
        self.label1.text = L(@"OnlineService_ShopName");
        CGSize textSize = [self.label1.text sizeWithFont:self.label1.font];
        self.label1.frame = CGRectMake(kOSLMMARGIN, top, textSize.width, textSize.height);
        [self.tpScrollView addSubview:self.label1];
        
        self.label2.text = self.title;
        CGSize text2Size = [self.title sizeWithFont:self.label2.font];
        CGFloat maxWidth = kOSLMTextWidth - self.label1.width;
        CGFloat width = text2Size.width > maxWidth ? maxWidth : text2Size.width;
        self.label2.frame = CGRectMake(self.label1.right, top, width, text2Size.height);
        [self.tpScrollView addSubview:self.label2];
        
        top = self.label2.bottom + 20;

     }
    
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.label1.frame.size.height+20, 320, 1.)];
    line.backgroundColor = k233TextBorderColor;
    
    [self.whiteView addSubview:line];
    
    NSString *nick = [UserCenter defaultCenter].userInfoDTO.nickName;
    self.descLabel.text = [NSString stringWithFormat:@"%@%@%@%@:",
                           nick.length?nick:@"",L(@"OnlineService_Gei"),
                           self.shopName.length?self.shopName:L(@"OnlineService_Producter"),
                           L(@"OnlineService_LiuYan")];
    self.descLabel.frame = CGRectMake(kOSLMMARGIN, top, kOSLMTextWidth, self.descLabel.font.lineHeight);
    [self.tpScrollView addSubview:self.descLabel];
    
    self.textView.top = self.descLabel.bottom + 10;
    [self.tpScrollView addSubview:self.textView];
    
    self.textField.top = self.textView.bottom + 10;
    [self.tpScrollView addSubview:self.textField];
    //设置textField的初始值
    NSString *logonId = [UserCenter defaultCenter].userInfoDTO.logonId;
    if ([FormattersValidators isValidEmail:logonId] || [FormattersValidators isValidPhone:logonId])
    {
        self.textField.text = logonId;
    }
    
    NSString *tip = L(@"OnlineService_Tips");
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tip];
    [attStr setFont:[UIFont systemFontOfSize:14.0f]];
    [attStr setTextColor:RGBCOLOR(250, 128, 25) range:NSMakeRange(0, 5)];
    [attStr setTextColor:RGBCOLOR(153, 153, 153) range:NSMakeRange(5, tip.length-5)];
    [attStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByCharWrapping];
    CGSize size = [attStr sizeConstrainedToSize:CGSizeMake(kOSLMTextWidth, 1000)];
    self.tipLabel.frame = CGRectMake(kOSLMMARGIN, self.textField.bottom+20, kOSLMTextWidth, size.height);
    self.tipLabel.attributedText = attStr;
    [self.tpScrollView addSubview:self.tipLabel];
    
    self.tpScrollView.contentSize = CGSizeMake(self.tpScrollView.width, self.tipLabel.bottom + 10);
    
    self.bSupportPanUI = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)backForePage
{
    [self dismissModalViewControllerAnimated:YES];
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

-(UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] init];
        
        _whiteView.backgroundColor = [UIColor whiteColor];
        

    }
    
    return _whiteView;
}
- (UILabel *)label1
{
    if (!_label1)
    {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.font = [UIFont boldSystemFontOfSize:15.0];
        _label1.textColor = [UIColor light_Black_Color];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.shadowColor = [UIColor whiteColor];
        _label1.shadowOffset = CGSizeMake(0, 0);
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2)
    {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.font = [UIFont boldSystemFontOfSize:15.0];
        _label2.textColor = [UIColor light_Gray_Color];
        _label2.textAlignment = NSTextAlignmentLeft;
        _label2.shadowColor = [UIColor whiteColor];
        _label2.shadowOffset = CGSizeMake(0, 0);
    }
    return _label2;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
		_descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _descLabel.textColor = [UIColor light_Black_Color];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.shadowColor = [UIColor whiteColor];
        _descLabel.shadowOffset = CGSizeMake(0, 0);
    }
    return _descLabel;
}

- (PlaceholderTextView *)textView
{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc] init];
        _textView.frame = CGRectMake(kOSLMMARGIN, 40, kOSLMTextWidth, kOSLMTextHeight);
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.0f];
        _textView.textColor = [UIColor darkTextColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        //_textView.layer.cornerRadius = 5.0f;
        _textView.layer.borderColor = k233TextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = L(@"OnlineService_InputConsult250");
        _textView.returnKeyType = UIReturnKeyDone;
    }
    return _textView;
}

- (CommonTextField *)textField
{
    if (!_textField) {
        _textField = [[CommonTextField alloc] init];
        _textField.leftPadding = 7;
        _textField.frame = CGRectMake(kOSLMMARGIN, 0, kOSLMTextWidth, 29);
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:14.0];
        _textField.textColor = [UIColor colorWithRGBHex:0x444444];
        _textField.placeholder = L(@"OnlineService_InputTelAndEmail");
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        if (IOS5_OR_LATER) {
            _textField.spellCheckingType = UITextSpellCheckingTypeDefault;
        }
        _textField.secureTextEntry = NO;
        
        //_textField.layer.cornerRadius = 5.0f;
        _textField.layer.borderColor = k233TextBorderColor.CGColor;
        _textField.layer.borderWidth = 0.5;
    }
    return _textField;
}

- (OHAttributedLabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[OHAttributedLabel alloc] init];
        _tipLabel.backgroundColor = [UIColor clearColor];
    }
    return _tipLabel;
}

#pragma mark ----------------------------- text view delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.textField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark ----------------------------- service

- (OSChatService *)service
{
    if (!_service) {
        _service = [[OSChatService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)leaveMessageAction
{
    NSString *context = self.textView.text.trim;
    if (context.length == 0)
    {
        [self presentSheet:L(@"OnlineService_InputYouMessage")];
        return;
    }
    
    if (context.length > 250)
    {
        [self presentSheet:L(@"OnlineService_MessageLessThan250")];
        return;
    }
    
    NSString *contact = self.textField.text.trim;
    if (contact.length > 0)
    {
        if (![FormattersValidators isValidEmail:self.textField.text] &&
            ![FormattersValidators isValidPhone:self.textField.text])
        {
            [self presentSheet:L(@"UserFeedBack_InputPhoneAndEmailCorrectly")];
            return;
        }
    }
    
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
    [self displayOverFlowActivityView];
    [self.service requestLeaveMessage:nil
                              Context:context
                             ShopCode:self.shopCode
                          GroupMember:self.groupMember
                            ClassCode:self.classCode
                               UserId:[UserCenter defaultCenter].userInfoDTO.userId
                               CustNo:[UserCenter defaultCenter].userInfoDTO.custNum
                             NickName:[UserCenter defaultCenter].userInfoDTO.nickName
                          ProductCode:self.productCode
                              OrderNo:self.orderId
                              Contact:contact];//10.留言（商家或供应商）
}

- (void)osService:(OSChatService *)service leaveMessageComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:L(@"OnlineService_LeaveMessageSuccess")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert setCancelBlock:^{
            
            [self dismissModalViewControllerAnimated:YES];
        }];
        [alert show];
    }
    else
    {
        [self presentSheet:service.errorMsg];
    }
}

@end
