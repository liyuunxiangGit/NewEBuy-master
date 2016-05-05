//
//  NewGetRedPackViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewGetRedPackViewController.h"
#import "LoginViewController.h"
#import "DataValidate.h"
#import "GetRedPackSuccessViewController.h"
#import "BoundPhoneViewController.h"
@implementation NewGetRedPackViewController
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkLogin];
    self.title=L(@"CPACPS_XinrenHongBao");
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = L(@"CPACPS_InputFriendAnHao");
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor  colorWithRGBHex:0x707070];
    [self.view addSubview:self.backView];
    UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view addSubview:self.getRedPack];
    [self.view addSubview:self.submit];
    [self.view addSubview:label];
    [self guizeTitle];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];

}

- (void)keyboardWillShow:(NSNotification *)note {
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES))
            [keyboard addSubview:doneButton];
    }
}

-(UITextField *)getRedPack{
    if (!_getRedPack) {
        _getRedPack = [[UITextField alloc] initWithFrame:CGRectMake(15, 40, 290, 30)];
        _getRedPack.clearButtonMode = UITextFieldViewModeWhileEditing;;
        _getRedPack.keyboardType=UIKeyboardTypeNumberPad;
        _getRedPack.delegate = self;
        _getRedPack.returnKeyType = UIReturnKeyDone;
        _getRedPack.placeholder = L(@"CPACPS_InputContent");
        _getRedPack.textColor = [UIColor  colorWithRGBHex:0xA0A0A0];
        _getRedPack.borderStyle =UITextBorderStyleLine;
        
    }
    return _getRedPack;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _backView.backgroundColor = [UIColor whiteColor];
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(15, self.getRedPack.bottom + 15, 100, 20)];
        label.font = [UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRGBHex:0xA0A0A0];
        label.text = L(@"CPACPS_OperationIllustration");
        CGSize size =  [[UserCenter defaultCenter].actverule sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        NSString *textstr = [UserCenter defaultCenter].actverule;
        UITextView *label1  = [[UITextView alloc] initWithFrame:CGRectMake(15, label.bottom + 5, 290, size.height+20)];
        label1.font = [UIFont systemFontOfSize:13];
        label1.backgroundColor = [UIColor clearColor];
        label1.textColor = [UIColor colorWithRGBHex:0xA0A0A0];
        label1.text = textstr;
        label1.editable = NO;
        _backView.frame = CGRectMake(0, 0, self.view.frame.size.width, size.height+40+label.bottom);
        UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor= [UIColor clearColor];
        [self.view addSubview:btn];
        [_backView addSubview:label];
        [_backView addSubview:label1];
    }
    return _backView;
}

-(void)btnClick{
    [_getRedPack resignFirstResponder];
}

//检查是否登录，如果未登录则弹出登录界面
- (BOOL)checkLogin
{
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginDelegate = self;
        AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
}

-(UIButton *)submit{
    if (!_submit) {
        _submit = [[UIButton alloc] initWithFrame:CGRectMake(15, self.backView.bottom + 15, 290, 30)];
        [_submit setTitle:L(@"CommitBtn") forState:UIControlStateNormal];
        [_submit setBackgroundImage:[UIImage imageNamed:@"button_orange_normal"] forState:UIControlStateNormal];
        [_submit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submit;
}

-(void)guizeTitle{
    if([UserCenter defaultCenter].ticketRuleUrl!=nil){
        float height =150;
        if ([SystemInfo is_iPhone_5]) {
            height = 200;
        }
        UIWebView *webview  = [[UIWebView alloc] initWithFrame:CGRectMake(10, self.submit.bottom + 5, 300, height)];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[UserCenter defaultCenter].ticketRuleUrl]]];
        
        //    label1.font = [UIFont systemFontOfSize:13];
        webview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:webview];

    }
}

-(void)submitClick{
    switch ([UserCenter defaultCenter].efubaoStatus) {
        case eLoginByPhoneUnBound:{
            BoundPhoneViewController *controller = [[BoundPhoneViewController alloc] init];
            controller.isEfubaoBound = YES;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        default:
            break;
    }

    if (_getRedPack.text.length==0 ) {
        return;
    }
    if([DataValidate isNumText:_getRedPack.text])
    {
        [self displayOverFlowActivityView:L(@"CPACPS_LoadIng") yOffset: -60];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.bSupportPanUI = NO;
        [self.invitaService beginGetRedPackHttpRequest:_getRedPack.text];
        
    }
    else{
        
    }
}

-(InvitationService *)invitaService
{
    if (!_invitaService) {
        _invitaService=[[InvitationService alloc]init];
        _invitaService.delegate=self;
    }
    return _invitaService;
}

- (void) GetRedPackServiceComplete:(NSString *)errmsg isSuccess:(BOOL) isSuccess{
    [self removeOverFlowActivityView];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.bSupportPanUI = YES;
    if (isSuccess) {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *name =@"cipher";
        [_getRedPack resignFirstResponder];
        [defaults setObject:_getRedPack.text forKey:name];
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"CPACPS_LingquSuccess") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        [alertView setConfirmBlock:^{
            GetRedPackSuccessViewController *getred = [[GetRedPackSuccessViewController alloc] init];
            [self.navigationController pushViewController:getred animated:YES];
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
    else{
        if ([errmsg isEqualToString:L(@"CPACPS_AnHaoNotExistReinput")]) {
            errmsg =L(@"CPACPS_AnHaoWrong");
        }
        if (errmsg&&![errmsg isEqualToString:@"null"]) {
            [self presentSheet:errmsg posY:50];

        }
        else{
            BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"CPACPS_NetworkErrorRetryLater") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
            [alertView setConfirmBlock:^{
                
            }];
            [alertView show];
            TT_RELEASE_SAFELY(alertView);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length>9&&![string isEqualToString:@""]) {
        [self presentSheet:L(@"CPACPS_AnHaoLengthTooLong") posY:50];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{

    return YES;
}


- (void)dealloc
{
    _invitaService.delegate=nil;
    SERVICE_RELEASE_SAFELY(_invitaService);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
