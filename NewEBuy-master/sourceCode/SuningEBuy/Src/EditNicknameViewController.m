//
//  EditNicknameViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-27.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "EditNicknameViewController.h"
#import "UserCenter.h"
#import "RegexKitLite.h"

@interface EditNicknameViewController()


@property (nonatomic, strong)  UITextField    *nicknameTextField;

@property (nonatomic, strong)  UILabel        *titleLabel;

@property (nonatomic, strong)  UIButton       *commitButton;

@property (nonatomic, strong)  UIButton       *cancelButton;


- (void)editNicknameHttpRequest;

- (BOOL)validateNickName: (NSString *) candidate;

@end


@implementation EditNicknameViewController

@synthesize nicknameTextField  = _nicknameTextField;
@synthesize titleLabel = _titleLabel;
@synthesize cancelButton = _cancelButton;
@synthesize commitButton = _commitButton;
@synthesize service = _service;
@synthesize delegate = _delegate;

- (void)dealloc {
    
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_nicknameTextField);
    TT_RELEASE_SAFELY(_cancelButton);
    TT_RELEASE_SAFELY(_commitButton);
    
}


- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"MyEBuy_AddNickname");
        self.pageTitle = L(@"member_myEbuy_addEditName");
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:L(@"BTBack") style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem = left;
    }
    
    return self;
}

- (void)back:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    
//    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    [self.view addSubview:self.nicknameTextField];
    [self.view addSubview:self.commitButton];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.titleLabel];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
        
    [self.nicknameTextField becomeFirstResponder];

}

- (EditNickNameService *)service
{
    if (!_service)
    {
        _service = [[EditNickNameService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancelButton.backgroundColor = [UIColor clearColor];
        
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"light_blue_button.png"] forState:UIControlStateNormal];
        
        _cancelButton.frame = CGRectMake(20, 120, 120, 35);
        
        _cancelButton.tag = 400;
        
        [_cancelButton setTitle:L(@"Cancel") forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;    
}

- (void)clickCancelBtn:(id)sender{

    [self dismissModalViewControllerAnimated:YES];
}

- (UIButton *)commitButton
{
    if (!_commitButton)
    {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _commitButton.backgroundColor = [UIColor clearColor];
        
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"light_blue_button.png"] forState:UIControlStateNormal];
        
        _commitButton.frame = CGRectMake(180, 120, 120, 35);
        
        _commitButton.tag = 401;
        
        [_commitButton setTitle:L(@"Ok") forState:UIControlStateNormal];
        
        [_commitButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _commitButton;
}
    

- (void)clickBtn:(id)sender{
            
    NSString *nickName = self.nicknameTextField.text;
    
    if (nickName.trim.length == 0) {
        
        [self presentSheet:L(@"MyEBuy_EnterNickname") posY:60];
        
        return;
    }
    
    if  ([nickName length] > 20) {
        
        [self presentSheet:L(@"MyEBuy_NicknameLessThanTwentyWords") posY:60];
        
        return;
    }
    
    NSString *regex = @"[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
    
    if ([nickName rangeOfRegex:regex].location != NSNotFound)
    {
        [self presentSheet:L(@"MyEBuy_NicknameContainSpecialCharacterEnterAgain") posY:60];
        return;
    }
    
    if ([nickName isMatchedByRegex:@"^\\d{12}$"])
    {
        [self presentSheet:L(@"MyEBuy_NicknameBanTwelveNumberAndEnterAgain") posY:60];
        return;
    }
    
    if ([nickName isMatchedByRegex:@"^1\\d{10}$"])
    {
        [self presentSheet:L(@"MyEBuy_NicknameBanElevenNumberBeginWithOne") posY:60];
        return;
    }
    
    if ([nickName rangeOfRegex:@"\\s+"].location != NSNotFound)
    {
        [self presentSheet:L(@"MyEBuy_NicknameCannotContainSpaces") posY:60];
        return;
    }
    
    [self.nicknameTextField resignFirstResponder];
    [self editNicknameHttpRequest];
    
}
    

- (UILabel *)titleLabel
{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 50)];
        
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.textColor = RGBCOLOR(46, 46, 46);
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        
        _titleLabel.text = L(@"MyEBuy_EnterNickname");
    }
    
    return _titleLabel;
}


//姓名输入框
- (UITextField *)nicknameTextField{
    
    if (!_nicknameTextField) {
        _nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 280, 30)];
        _nicknameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nicknameTextField.backgroundColor = RGBCOLOR(242, 242, 242);
        _nicknameTextField.delegate = self;
        _nicknameTextField.returnKeyType = UIReturnKeyDone;
        _nicknameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _nicknameTextField.keyboardType = UIKeyboardTypeDefault;
        _nicknameTextField.enablesReturnKeyAutomatically = YES;
        _nicknameTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _nicknameTextField;
}


- (void)editNicknameHttpRequest{
    
    
    [self displayOverFlowActivityView];
    
    [self.service beginEditNickNameRequest:self.nicknameTextField.text];
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
//    
//    
//    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
//    [postDataDic setObject:self.nicknameTextField.text?self.nicknameTextField.text:@"" forKey:@"nickName"];
////    [postDataDic setObject:self.usernameTextField.text?self.usernameTextField.text:@"" forKey:@"firstName"];
//
//        
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNiPhoneAppUserUpdateCmd"];
//    HTTP_RELEASE_SAFELY(editNicknameASIHTTPRequest);
//    editNicknameASIHTTPRequest = [Http sendHttpRequest:@"editNicknameASIHTTPRequest " 
//                                                    URL:url 
//                                                isHttps:YES 
//                                             UrlParaDic:postDataDic 
//                                               Delegate:self
//                                         SucessCallback:@selector(sendEditNicknameRequestOK:) 
//                                           FailCallback:@selector(sendEditNicknameRequestFail:)];
//    [editNicknameASIHTTPRequest retain];
//    TT_RELEASE_SAFELY(postDataDic);
//    if (!editNicknameASIHTTPRequest) {
//        
//        [self removeOverFlowActivityView];
//        return;
//    }
}


- (void)didServiceComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        [UserCenter defaultCenter].userInfoDTO.nickName = self.nicknameTextField.text;
        
        if ([self.delegate conformsToProtocol:@protocol(EditNicknameDelegate) ]) {
            if ([self.delegate respondsToSelector:@selector(editNickNameOK)]) {
                
                [self.delegate editNickNameOK];
            }
        }
        
        [self dismissModalViewControllerAnimated:YES];
    
    }else{
        [self presentSheet:self.service.errorMsg posY:100];
    }
}
////
////
////- (void)sendEditNicknameRequestOK:(ASIFormDataRequest *)request{
////   
////    [self removeOverFlowActivityView];
////    
////    NSDictionary *items = request.jasonItems;
////    
////    NSString *errorCode = [items objectForKey:@"errorCode"];
////    
////    DLog(@"sendEditNicknameRequestFail from server  NSUrlString=%@\n",[items description]);	
////    
////    if (IsNilOrNull(errorCode) || [errorCode isEqualToString:@""])
////    {
////
////        [UserCenter defaultCenter].userInfoDTO.nickName = self.nicknameTextField.text;
////        
////        if ([self.delegate conformsToProtocol:@protocol(EditNicknameDelegate) ]) {
////            if ([self.delegate respondsToSelector:@selector(editNickNameOK)]) {
////    
////                [self.delegate editNickNameOK];
////            }
////        }
////        
////        [self dismissModalViewControllerAnimated:YES];           
////    }
////
////    else
////    { 
////        if (!([errorCode isEqualToString:@"userName_invalid"]||[errorCode isEqualToString:@"nickName_exists"]||[errorCode isEqualToString:@"nickName_forbidden_words"]||[errorCode isEqualToString:@"nickName_used"]||[errorCode isEqualToString:@"nickName_length>20"]||[errorCode isEqualToString:@"nickName_@_forbidden"]||[errorCode isEqualToString:@"nickName_12digital_forbidden"]||[errorCode isEqualToString:@"nickName_1_10_forbidden"]||[errorCode isEqualToString:@"nickName_blankspace_forbidden"]||[errorCode isEqualToString:@"nickName_exceptional_character"])) {
////            errorCode = @"nickName_Failed";
////        }
////        [self presentSheet:L(errorCode) posY:60];
////    }
////    
////}
//
//- (void)sendEditNicknameRequestFail:(ASIFormDataRequest *)request{
//
//    DLog(@"sendEditNicknameRequestFail from server  NSUrlString=%@\n",[request.jasonItems description]);	
//	
//    [self removeOverFlowActivityView];
//	
//	[self presentCustomDlg:L(@"Fail")];
//
//}


//昵称验证
- (BOOL)validateNickName:(NSString *) candidate {
    
    NSString *emailRegex = @"[A-Z0-9a-z\\u4e00-\\u9fa5]{1,20}"; 
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:candidate];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self clickBtn:nil];
    
    return YES;
}


@end
