//
//  UserFeedBackPreViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserFeedBackPreViewController.h"
#import "UserFeedBackViewController.h"
#import "OSChatViewController.h"
#import "UserFeedBackNewViewController.h"

#define kUFBPMargin     20
#define kUFBPWidth      280
#define kUFBPVMargin    15

@interface UserFeedBackPreViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;


@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *contactButton;
@property (nonatomic, strong) UIButton *tocaoButton;


@end

@implementation UserFeedBackPreViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"User Feedback");
        self.pageTitle = L(@"member_myEbuy_userFeedBack");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *tip1 = L(@"UserFeedBack_Tips1");
    CGSize size1 = [tip1 sizeWithFont:self.label1.font
                    constrainedToSize:CGSizeMake(kUFBPWidth, 1000)
                        lineBreakMode:self.label1.lineBreakMode];
    self.label1.text = tip1;
    self.label1.frame = CGRectMake(kUFBPMargin, kUFBPVMargin, kUFBPWidth, size1.height);
    [self.view addSubview:self.label1];
    
    self.label2.text = [NSString stringWithFormat:@"%@：",L(@"Order No")];
    CGSize size2 = [self.label2.text sizeWithFont:self.label2.font];
    self.label2.frame = CGRectMake(0, 0, size2.width+20, size2.height);
    self.textField.leftView = self.label2;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.frame = CGRectMake(0, self.label1.bottom+kUFBPVMargin, 320, 30);
    [self.view addSubview:self.textField];
    
    self.contactButton.frame = CGRectMake((320-self.contactButton.width)/2, self.textField.bottom+kUFBPVMargin, self.contactButton.width, self.contactButton.height);
    [self.view addSubview:self.contactButton];
    
    NSString *tip2 = L(@"UserFeedBack_Tips2");
    CGSize size3 = [tip2 sizeWithFont:self.label3.font
                    constrainedToSize:CGSizeMake(kUFBPWidth, 1000)
                        lineBreakMode:self.label3.lineBreakMode];
    self.label3.text = tip2;
    self.label3.frame = CGRectMake(kUFBPMargin, self.contactButton.bottom + kUFBPVMargin, kUFBPWidth, size3.height);
    [self.view addSubview:self.label3];
    
    self.tocaoButton.top = self.label3.bottom + 8;
    self.tocaoButton.left = kUFBPMargin ;
    [self.view addSubview:self.tocaoButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------------------- views

- (UILabel *)label1
{
    if (!_label1)
    {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.font = [UIFont systemFontOfSize:14.0];
        _label1.textColor = [UIColor colorWithRGBHex:0x444444];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.numberOfLines = 0;
        _label1.lineBreakMode = NSLineBreakByCharWrapping;
        _label1.shadowColor = [UIColor whiteColor];
        _label1.shadowOffset = CGSizeMake(0.5, 0.5);
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2)
    {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.font = [UIFont systemFontOfSize:14.0];
        _label2.textColor = [UIColor colorWithRGBHex:0x444444];
        _label2.textAlignment = NSTextAlignmentRight;
//        _label2.shadowColor = [UIColor whiteColor];
//        _label2.shadowOffset = CGSizeMake(0.5, 0.5);
    }
    return _label2;
}

- (UILabel *)label3
{
    if (!_label3)
    {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label3.backgroundColor = [UIColor clearColor];
        _label3.font = [UIFont systemFontOfSize:14.0];
        _label3.textColor = [UIColor colorWithRGBHex:0x444444];
        _label3.textAlignment = NSTextAlignmentLeft;
        _label3.numberOfLines = 0;
        _label3.lineBreakMode = NSLineBreakByCharWrapping;
        _label3.shadowColor = [UIColor whiteColor];
        _label3.shadowOffset = CGSizeMake(0.5, 0.5);
    }
    return _label3;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(0, 0, 0, 0);
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:14.0];
        _textField.textColor = [UIColor colorWithRGBHex:0x444444];
        _textField.placeholder = L(@"UserFeedBack_CanCopyInOrderCenter");
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
//        _textField.secureTextEntry = NO;
//        
//        _textField.layer.cornerRadius = 4.0f;
//        _textField.layer.borderColor = k233TextBorderColor.CGColor;
//        _textField.layer.borderWidth = 0.5;
    }
    return _textField;
}

- (UIButton *)contactButton
{
    if (!_contactButton) {
        _contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactButton.frame = CGRectMake(0, 0, 240, 32);
        _contactButton.backgroundColor = [UIColor clearColor];
        [_contactButton setImage:[UIImage imageNamed:@"Cdian-hewolianxi-normal.png"]
                        forState:UIControlStateNormal];
        [_contactButton setImage:[UIImage imageNamed:@"Cdian-hewolianxi-Press.png"]
                        forState:UIControlStateHighlighted];
        _contactButton.titleEdgeInsets = UIEdgeInsetsZero;
        _contactButton.imageEdgeInsets = UIEdgeInsetsZero;
        [_contactButton addTarget:self
                         action:@selector(contactWithMe:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
}

- (UIButton *)tocaoButton
{
    if (!_tocaoButton) {
        _tocaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tocaoButton.frame = CGRectMake(0, 0, 103.5, 22);
        _tocaoButton.backgroundColor = [UIColor clearColor];
        _tocaoButton.adjustsImageWhenHighlighted = NO;
       // [_tocaoButton setTitle:@"吐槽点这里" forState:UIControlStateNormal];
        //[_tocaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tocaoButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        UIImage *bgImage = [UIImage imageNamed:@"os_kefu-tucao-da.png"];
       // bgImage = [bgImage stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        [_tocaoButton setImage:bgImage
                                forState:UIControlStateNormal];
       // _tocaoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0);
        [_tocaoButton addTarget:self
                         action:@selector(tocao:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _tocaoButton;
}

#pragma mark ----------------------------- text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----------------------------- action

- (void)contactWithMe:(id)sender
{
    [self checkLoginWithLoginedBlock:^{
        OSChatViewController *vc = [[OSChatViewController alloc] initASB2CFeedBackWithOrderNo:self.textField.text];
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
        [self presentModalViewController:nav animated:YES];
    } loginCancelBlock:nil];
}

- (void)tocao:(id)sender
{
    UserFeedBackNewViewController *vc = [[UserFeedBackNewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
