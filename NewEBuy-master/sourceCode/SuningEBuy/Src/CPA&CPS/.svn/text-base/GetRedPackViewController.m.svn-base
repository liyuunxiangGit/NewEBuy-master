//
//  GetRedPackViewController.m
//  SuningEBuy
//
//  Created by leo on 14-3-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GetRedPackViewController.h"
#import "LoginViewController.h"
#import "DataValidate.h"
#import "GetRedPackSuccessViewController.h"
@interface GetRedPackViewController ()

@end

@implementation GetRedPackViewController

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
    [self.view addSubview:self.getredpack];
    [self.view addSubview:self.titlelabel];
    [self checkLogin];
    
    SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"CommitBtn")
                                                                Style:SNNavItemStyleDone
                                                               target:self
                                                               action:@selector(goToRegist)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.title=L(@"CPACPS_DuiAnHaoGetHongbao");
    self.navigationItem.rightBarButtonItem.enabled = NO;

   	// Do any additional setup after loading the view.
}

//检查是否登录，如果未登录则弹出登录界面
- (BOOL)checkLogin
{
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginDelegate = self;
        loginVC.loginDidOkSelector = @selector(loginOK);
        AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
}

-(void)loginOK{
    SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"CommitBtn")
                                                                Style:SNNavItemStyleDone
                                                               target:self
                                                               action:@selector(goToRegist)];
    self.navigationItem.rightBarButtonItem = rightButton;

}

-(void)goToRegist{
    self.titlemsg.text=@"";
    if (_getredpack.text.length==0 ) {
        return;
    }
    if([DataValidate isNumText:_getredpack.text])
    {
        [self displayOverFlowActivityView:L(@"CPACPS_LoadIng") yOffset: -60];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.bSupportPanUI = NO;
        [self.invita beginGetRedPackHttpRequest:_getredpack.text];

    }
    else{
        self.titlemsg.text=L(@"CPACPS_InputNum");
    }
}

-(InvitationService *)invita
{
    if (!_invita) {
        _invita=[[InvitationService alloc]init];
        _invita.delegate=self;
    }
    return _invita;
}

- (void) GetRedPackServiceComplete:(NSString *)errmsg isSuccess:(BOOL) isSuccess{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.bSupportPanUI = YES;
    if (isSuccess) {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *name =@"cipher";
        [_getredpack resignFirstResponder];
        [defaults setObject:_getredpack.text forKey:name];
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"CPACPS_LingquSuccess") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        [alertView setConfirmBlock:^{
            GetRedPackSuccessViewController *getred = [[GetRedPackSuccessViewController alloc] init];
            [self.navigationController pushViewController:getred animated:YES];
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
    else{
        if (errmsg&&![errmsg isEqualToString:@"null"]) {
            self.titlemsg.text=errmsg;
        }
        else{
            BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"CPACPS_LingquFailed") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
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

-(UITextView *)titlelabel{
    if (!_titlelabel) {
        _titlelabel= [[UITextView alloc] init];
        CGSize size =  [[UserCenter defaultCenter].actverule sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(316, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [_titlelabel setFrame:CGRectMake(3, 168, 316, MAX(size.height+22, 40.0f))];
        _titlelabel.font = [UIFont systemFontOfSize:13];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, 320, _titlelabel.size.height+40)];
        imgview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imgview];
        UILabel *rule = [[UILabel alloc] initWithFrame:CGRectMake(8, 140, 100, 20)];
        rule.text=L(@"activeRule");
        _titlelabel.text=[UserCenter defaultCenter].actverule;
        _titlelabel.editable = NO;
        _titlelabel.scrollEnabled = NO;
        _titlelabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:rule];
    }
    return _titlelabel;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length==1&&[string isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.titlemsg.text=@"";
    self.navigationItem.rightBarButtonItem.enabled = NO;
    return YES;
}

-(UILabel *)titlemsg{
    if (!_titlemsg) {
        _titlemsg = [[UILabel alloc] initWithFrame:CGRectMake(5, self.getredpack.bottom+4, 310, 50)];
        _titlemsg.backgroundColor = [UIColor clearColor];
        _titlemsg.lineBreakMode = UILineBreakModeWordWrap;
        _titlemsg.numberOfLines = 0;
        _titlemsg.textColor = [UIColor orangeColor];
        [self.view addSubview:_titlemsg];
    }
    return _titlemsg;
}
-(UITextField *)getredpack{
    if (!_getredpack) {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 30)];
        imgview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imgview];
        _getredpack = [[UITextField alloc] initWithFrame:CGRectMake(5, 40, 310, 20)];
        _getredpack.clearButtonMode = UITextFieldViewModeWhileEditing;;
        _getredpack.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _getredpack.keyboardType=UIKeyboardTypeNumberPad;
        _getredpack.delegate = self;
        _getredpack.placeholder = L(@"CPACPS_InputAnhao");
        _getredpack.borderStyle =UITextBorderStyleNone;
//        [_getredpack becomeFirstResponder];
    }
    return _getredpack;
}

- (void)dealloc
{
    _invita.delegate=nil;
    SERVICE_RELEASE_SAFELY(_invita);
    TT_RELEASE_SAFELY(_getredpack);
    TT_RELEASE_SAFELY(_titlelabel);
    TT_RELEASE_SAFELY(_titlemsg);
    
}
@end
