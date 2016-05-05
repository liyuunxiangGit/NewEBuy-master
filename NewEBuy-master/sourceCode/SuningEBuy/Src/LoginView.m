//
//  LoginView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LoginView.h"
#import "SNGraphics.h"
#import "OpenUDID.h"

// class 'MatchedAccountsView' XZoscar 2014-06-20 add
@interface MatchedAccountsView ()
@property (nonatomic,strong) NSMutableArray *sourcesArr;
@end

@implementation MatchedAccountsView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.delegate   = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourcesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"MatchedAccountsViewCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identify];
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor light_Gray_Color];
        cell.textLabel.textColor = [UIColor colorWithRed:112.0f/255.0f
                                                   green:112.0f/255.0f
                                                    blue:112.0f/255.0f alpha:1.0f];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(9.0f,38.0f,cell.frame.size.width-18.0f,1.0f)];
        line.backgroundColor  =  [UIColor colorWithRed:238.0f/255.0f
                                                 green:238.0f/255.0f
                                                  blue:238.0f/255.0f alpha:1.0f];
        [cell addSubview:line];
    }
    
    cell.textLabel.text = _sourcesArr[indexPath.row];
    
    return cell;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        
        if (nil != _text) {
            
            //NSLog(@"%@",_text);
            
            NSString *subStr = [_text substringToIndex:[_text rangeOfString:@"@"].location+1];
            
            NSArray *tmpArr = @[[NSString stringWithFormat:@"%@qq.com",subStr],
                                [NSString stringWithFormat:@"%@163.com",subStr],
                                [NSString stringWithFormat:@"%@126.com",subStr],
                                [NSString stringWithFormat:@"%@sina.com",subStr],
                                [NSString stringWithFormat:@"%@sohu.com",subStr]];
            self.sourcesArr = [NSMutableArray arrayWithArray:tmpArr];
            [_sourcesArr filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",_text]];
            if (_sourcesArr.count == 0) {
                 self.hidden = YES;
            }
            [self reloadData];
        }else {
            self.hidden = YES;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (nil != _selDelegate
        && [_selDelegate respondsToSelector:@selector(delegate_MatchedAccountsView_selected:)]) {
        [_selDelegate delegate_MatchedAccountsView_selected:_sourcesArr[indexPath.row]];
    }
}

@end

@interface LoginView () <MatchedAccountsViewDelegate>
@end

@implementation LoginView

@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize footerView = _footerView;
@synthesize loginButton = _loginButton;
@synthesize registerButton = _registerButton;


- (void)dealloc {
    TT_RELEASE_SAFELY(_usernameTextField);
    TT_RELEASE_SAFELY(_passwordTextField);
    TT_RELEASE_SAFELY(_footerView);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOwner:(id)owner
{
    self = [super initWithOwner:owner];
    if (self) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;
        CGFloat height = frame.size.height-kStatusBarHeight-kUITabBarFrameHeight-kUINavigationBarFrameHeight;
        frame.origin.x = 0;
        frame.origin.y = 0;
        frame.size.height = height;
        self.tpTableView.frame = frame;
        [self addSubview:self.tpTableView];
        
        frame = CGRectMake(50.0f,60.0f,frame.size.width-100.0f,200.0f);
        self.matchedAccView = [[MatchedAccountsView alloc] initWithFrame:frame];
        _matchedAccView.selDelegate = self;
        _matchedAccView.hidden      = YES;
        [self addSubview:_matchedAccView];
        
    }
    return self;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
    if(!_tpTableView)
    {
		
		if (IOS7_OR_LATER) {
            _tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                        style:UITableViewStyleGrouped];
        }else{
            _tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                        style:UITableViewStylePlain];
        }
		
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tpTableView.scrollEnabled = YES;
		
		_tpTableView.userInteractionEnabled = YES;
		
		_tpTableView.backgroundColor = [UIColor clearColor];
		
        _tpTableView.backgroundView = nil;
        
        _tpTableView.delegate = self.owner;
        
        _tpTableView.dataSource = self.owner;
	}
	
	return _tpTableView;
}

#pragma mark -
#pragma mark views

- (UITextField *)usernameTextField
{
	
	if (!_usernameTextField)
    {
		_usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 320 - 28 - 70- 38 + 20, 30)];
		
		_usernameTextField.delegate = self.owner;
        
        _usernameTextField.font = [UIFont systemFontOfSize:14.0];
		
		_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		_usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
        
        _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        if (IOS5_OR_LATER) {
            _usernameTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        }
        
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        
        _usernameTextField.enablesReturnKeyAutomatically = YES;
		
		_usernameTextField.placeholder = L(@"UCName_Cellphone_Email_StoreMemberCard");//L(@"input User Name");
        
	}
	
	return _usernameTextField;
}

- (UITextField *)passwordTextField
{
	
    if(!_passwordTextField)
    {
		//added by gyj 251去掉明文密文转换后，让上下用户名输入框和密码输入框右侧的清除按钮“X”保持对齐
//		_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 320 - 28-70 + 10 - 37, 30)];
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 320 - 28 - 70- 38 + 20, 30)];
		
		_passwordTextField.delegate = self.owner;
		
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

- (UIButton *)findPassWordBtn
{
    if (!_findPassWordBtn) {
        _findPassWordBtn = [[UIButton alloc] init];
        _findPassWordBtn.frame = CGRectMake(15, 5, 100, 25);
        _findPassWordBtn.backgroundColor = [UIColor clearColor];
//        _findPassWordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
//        [_findPassWordBtn setTitleColor:[UIColor colorWithRGBHex:0x999081] forState:UIControlStateNormal];
        //[_findPassWordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
//        UIImage *image = [SNGraphics colorImage:[UIColor colorWithRGBHex:0x999081] withFrame:CGRectMake(0, 0, 52.5, 1)];
//        
//        UIImageView *view = [[UIImageView alloc] initWithImage:image];
//        view.backgroundColor = [UIColor clearColor];
//        view.frame = CGRectMake(1.5, 13, 48.5, 1);
//        [_findPassWordBtn addSubview:view];
        
        //        [_findPassWordBtn setBackgroundImage:[UIImage imageNamed:@"find_password_btn.png"] forState:UIControlStateNormal];
    }
    return _findPassWordBtn;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(170, 5, 120, 40);
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_loginButton setTitleColor:[UIColor colorWithRGBHex:0x543500]  forState:UIControlStateNormal];
        [_loginButton setTitle:L(@"BTLogin") forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage streImageNamed:@"login_newLoginbtn"] forState:UIControlStateNormal];
    }
    return _loginButton ;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [[UIButton alloc]init];
        _registerButton.frame = CGRectMake(25, 5, 100, 40);
        [_registerButton setBackgroundImage:[UIImage streImageNamed:@"login_fastRegister"] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_registerButton setTitleColor:[UIColor colorWithRGBHex:0x543500]  forState:UIControlStateNormal];
        [_registerButton setTitle:L(@"UCFastRegistration") forState:UIControlStateNormal];
    }
    return _registerButton ;
}

- (UIButton *)loginHistoryBtn
{
    if (!_loginHistoryBtn) {
        _loginHistoryBtn = [[UIButton alloc] init];
        _loginHistoryBtn.backgroundColor = [UIColor clearColor];
        //        [_loginHistoryBtn setBackgroundImage:[UIImage imageNamed:@"login_history_down_btn.png"] forState:UIControlStateNormal];
        //        [_loginHistoryBtn setBackgroundImage:[UIImage imageNamed:@"login_history_up_btn.png"] forState:UIControlStateSelected];
        _loginHistoryBtn.selected = NO;
        _loginHistoryBtn.frame = CGRectMake(self.usernameTextField.right+10, 2, 38, 38);
//        [_loginHistoryBtn addSubview:self.loginHistoryImg];
        [_loginHistoryBtn setImage:[UIImage imageNamed:@"arrow_bottom_gray"] forState:UIControlStateNormal];
        [_loginHistoryBtn setImage:[UIImage imageNamed:@"arrow_top_gray"] forState:UIControlStateSelected];

    }
    return _loginHistoryBtn;
}

- (UIImageView *)loginHistoryImg
{
    if (!_loginHistoryImg) {
        _loginHistoryImg = [[UIImageView alloc] init];
        _loginHistoryImg.frame = CGRectMake(8, 14, 12, 11);
        _loginHistoryImg.image = [UIImage imageNamed:@"login_history_down_btn.png"];
        _loginHistoryImg.backgroundColor = [UIColor clearColor];
        _loginHistoryImg.userInteractionEnabled = NO;
    }
    return _loginHistoryImg;
}


- (UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc] init];
        
        _footerView.frame = CGRectMake(0, 0, 320, 45);
        
        _footerView.backgroundColor = [UIColor clearColor];
        
        //0[_footerView addSubview:self.findPassWordBtn];
        [_footerView addSubview:self.loginButton];
        [_footerView addSubview:self.registerButton];
        //[_footerView addSubview:self.findPassWordBtn];
        
        
    }
    
    return _footerView;
}

- (UIView *)verifyCodeView
{
    if (!_verifyCodeView)
    {
        _verifyCodeView = [[UIView alloc] init];
        _verifyCodeView.frame = CGRectMake(0, 0, 320, 50);
        _verifyCodeView.backgroundColor = [UIColor clearColor];
        
        [_verifyCodeView addSubview:self.labelandTFBackView];
        [_verifyCodeView addSubview:self.verifyCodeImageView];
        [_verifyCodeView addSubview:self.btnRefresh];
//        [_verifyCodeView addSubview:self.labelRefresh];
    }
    return _verifyCodeView;
}

- (UIView *)labelandTFBackView
{
    if (!_labelandTFBackView)
    {
        _labelandTFBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 6, 175, 40)];
        
        [_labelandTFBackView addSubview:self.tipLabel];
        [_labelandTFBackView addSubview:self.verifyCodeTextField];
    }
    return _labelandTFBackView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 18)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.text = [NSString stringWithFormat:@"%@:",L(@"LBVerificationCode")];
    }
    return _tipLabel;
}

- (UITextField *)verifyCodeTextField
{
    if (!_verifyCodeTextField)
    {
        _verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 8, 126, 23)];
        _verifyCodeTextField.borderStyle = UITextBorderStyleNone;
        _verifyCodeTextField.placeholder = L(@"UCPleaseInputRightVerificationCode");
        _verifyCodeTextField.font = [UIFont systemFontOfSize:14];
        _verifyCodeTextField.backgroundColor = [UIColor clearColor];
        _verifyCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verifyCodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _verifyCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _verifyCodeTextField;
}

- (EGOImageView *)verifyCodeImageView
{
    if (!_verifyCodeImageView)
    {
        _verifyCodeImageView = [EGOImageView captchaView];
        _verifyCodeImageView.frame = CGRectMake(195, 6, 64, 40);
    }
    return _verifyCodeImageView;
}

- (void)loadVerifyCodeImage
{
    NSString *strUUID = [OpenUDID value];
    
    self.verifyCodeImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?uuid=%@", kHostVCSImageCode,strUUID]];
}

- (OHAttributedLabel *)labelRefresh
{
    if (!_labelRefresh)
    {
        _labelRefresh = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(270, 17, 40, 16)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:L(@"UCChangeOne")];
        [attStr setTextColor:RGBCOLOR(83, 122, 203)];
        [attStr setTextIsUnderlined:YES];
        [attStr setFont:[UIFont systemFontOfSize:13]];
        _labelRefresh.attributedText = attStr;
        [_labelRefresh setUserInteractionEnabled:NO];
    }
    
    return _labelRefresh;
}

- (UIButton *)btnRefresh
{
    if (!_btnRefresh)
    {
        _btnRefresh = [[UIButton alloc] initWithFrame:CGRectMake(270, 5, 40, 40)];
        _btnRefresh.showsTouchWhenHighlighted = NO;
        _btnRefresh.adjustsImageWhenHighlighted = NO;
        [_btnRefresh addTarget:self action:@selector(refreshVerifycode:) forControlEvents:UIControlEventTouchUpInside];
        [_btnRefresh setImage:[UIImage streImageNamed:@"login_refreshVCode"] forState:UIControlStateNormal];
    }
    return _btnRefresh;
}

- (PasswordToggleView *)passwdToggleView
{
    if (!_passwdToggleView) {
        _passwdToggleView = [[PasswordToggleView alloc] init];
        
    }
    return _passwdToggleView;
}

- (void)refreshVerifycode:(id)sender
{
    //NSLog(@"refreshcode");
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                         keyArray:@[@"clickno"]
                                       valueArray:@[@"1030104"]];
    
    self.verifyCodeImageView.imageURL = nil;
    [self loadVerifyCodeImage];
}

- (void)delegate_MatchedAccountsView_selected:(NSString *)matchedAccount {
    [_usernameTextField setText:matchedAccount];
    [self.matchedAccView setText:nil];
}

@end
