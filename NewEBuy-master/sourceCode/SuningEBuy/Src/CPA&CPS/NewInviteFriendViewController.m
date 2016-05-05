//
//  NewInviteFriendViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewInviteFriendViewController.h"
#import "NewInviteFriendCell.h"
#import "UserCenter.h"
#import "InvitationService.h"
#import "ActiveRuleViewController.h"
#import "InviteFriendFaceByFaceViewController.h"
#import "GetRedPackEntryViewController.h"
#import "BoundPhoneViewController.h"
#import "ActiveEfubaoViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "NewGetRedPackEntryViewController.h"
#import "EfubaoUnboundPhoneViewController.h"
#import "EfubaoUnActiveViewController.h"
#import "EfubaoUnBoundEmailViewController.h"
#import "SNWebViewController.h"
@interface NewInviteFriendViewController ()
{
    InvitationDTO *invitaDto;
    NSString      *totalReward;
}
@property(nonatomic,strong)UIButton *activeRuleBtn;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)QueryRewardDTO *queryRewardDTO;
@end

@implementation NewInviteFriendViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    if (!_queryRewardDTO && invitaDto.cipher) {
        [self.invitaService beginQueryRewardHttpRequest:nil];
        [self displayOverFlowActivityView:L(@"CPACPS_LoadIng") yOffset: -60];
    }
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.bounds;
    [self.view addSubview:self.suspendButton];
    [self.invitaService beginInvitationHttpRequest];
    [self displayOverFlowActivityView:L(@"CPACPS_LoadIng") yOffset: -60];
    self.tableView.frame = CGRectMake(0, 0, 320, frame.size.height);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.activeRuleBtn];
    self.title=L(@"CPACPS_InviteFriendEarnMoney");
    SNUIBarButtonItem *leftButton = [SNUIBarButtonItem itemWithTitle:@""
                                                               Style:SNNavItemStyleBack
                                                              target:self
                                                              action:@selector(backForePage)];
    self.navigationItem.leftBarButtonItem = leftButton;

    // Do any additional setup after loading the view.
}

-(void)backForePage{
    for (UINavigationController *ctrl in [self.navigationController viewControllers]){
        if ([ctrl isKindOfClass:[SNWebViewController class]]) {
            [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:4];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UIButton *)activeRuleBtn{
    if (!_activeRuleBtn) {
        _activeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bottom-104, self.view.frame.size.width, 40)];
        _activeRuleBtn.backgroundColor = [UIColor whiteColor];
        [_activeRuleBtn setTitle:L(@"activeRule") forState:UIControlStateNormal];
        [_activeRuleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_activeRuleBtn addTarget:self action:@selector(ruleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activeRuleBtn;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(hideRule) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:btn];
    }
    return _backView;
}
-(void)ruleClick{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620210"], nil]];
    ActiveRuleViewController *active = [[ActiveRuleViewController alloc] init:invitaDto.actRuleURL];
    active.view.frame =CGRectMake(0, 150, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-150 );
    active.webView.frame =CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-150);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-58, 150-29, 58, 58)];
    [btn setImage:[UIImage imageNamed:@"button_closed_normal.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hideRule) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:active.view];
    [self.backView addSubview:btn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
}

-(void)hideRule{
    [_backView removeFromSuperview];
}

- (void) QueryRewardServiceComplete:(QueryRewardDTO *)service isSuccess:(BOOL) isSuccess{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        //推送情况的特殊处理
        _queryRewardDTO = service;
        totalReward = service.totalReward;
        [self.tableView reloadData];
    }
    else{
        if (service.errorMsg.length) {
            if ([service.errorMsg hasPrefix:@"socket"] || service.errorMsg.length>15) {
                service.errorMsg = L(@"Network anomalies, please try again later");
            }
            BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:service.errorMsg delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
            [alertView setConfirmBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView show];
            TT_RELEASE_SAFELY(alertView);
        }
        
    }
}

- (void) InvitationServiceComplete:(InvitationDTO *)service isSuccess:(BOOL) isSuccess{
    self.navigationItem.leftBarButtonItem.enabled = YES;

    if (isSuccess) {
        [UserCenter defaultCenter].cipher = service.cipher;
        invitaDto = service;
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByPhoneActive || [UserCenter defaultCenter].efubaoStatus == eLoginByEmailActive) {
             [self.invitaService beginQueryRewardHttpRequest:nil];
        }
        else{
            [self.tableView reloadData];
            [self removeOverFlowActivityView];
        }
    }
    else{
        [self removeOverFlowActivityView];
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:service.errorMsg?service.errorMsg:L(@"NWRequestError") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        [alertView setConfirmBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//微信分享
-(void)wexinShare{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.scene = 0;
        req.bText = NO;
        WXMediaMessage *message = [WXMediaMessage message];
        message.description     = invitaDto.smsContent;
        [message setThumbImage:[UIImage imageNamed:@"icon"]];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl      = @"http://m.suning.com";
        message.mediaObject = ext;
        req.message         = message;
        [WXApi sendReq:req];
    }else{
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                        message:L(@"CPACPS_DeviceNotInstallWeixin")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}

-(void)sendWeiXinContentWithType:(int)scene{
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = YES;
        req.scene = 1;
        req.text  = invitaDto.smsContent;
        [WXApi sendReq:req];
        
    }else{
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                        message:L(@"CPACPS_DeviceNotInstallWeixin")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert show];
    }
}


//调用短信分享API
- (void)sendSms:(NSString *)string
{
    //判断是否可以发送短信
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    DLog(@"can send SMS [%d]", canSendSMS);
    if (canSendSMS) {
        ABAddressBookRef addressBook = NULL;
        __block BOOL accessGranted = NO;
        
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips")
                                                            message:L(@"CPACPS_OpenAuthority")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        if (ABAddressBookRequestAccessWithCompletion != NULL) { // iOS 6
            addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                accessGranted = granted;
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            dispatch_release(sema);
            
            if (accessGranted) {
                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                picker.messageComposeDelegate = self;
                if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
                {
                    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
                    picker.navigationBar.tintColor = RGBCOLOR(101, 141, 179);
                    
                }
                picker.body = invitaDto.smsContent;
                [self presentModalViewController:picker animated:YES];
            }
        }
        else{
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
            {
                [picker.navigationBar setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
                picker.navigationBar.tintColor = RGBCOLOR(101, 141, 179);
                
            }
            picker.body = invitaDto.smsContent;
            [self presentModalViewController:picker animated:YES];
        }
    }else
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                        message:L(@"Device_Unsupport_Send_SMS")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//发送短信api的回调函数
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self  dismissModalViewControllerAnimated:YES];
    
    switch (result) {
        case MessageComposeResultCancelled:
        {
            DLog(@"cancel send message");
            break;
        }
        case MessageComposeResultSent:
        {
            DLog(@"send message success");
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:L(@"SMS_Share_Success")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        case MessageComposeResultFailed:
        {
            DLog(@"send message fail");
            break;
        }
        default:
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 125;
    }
     CGSize size1 =  [invitaDto.actContent sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(self.view.frame.size.width-60, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
     CGSize size2 =  [invitaDto.rewardRule sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(self.view.frame.size.width-60, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return size1.height + size2.height + 85 + 100 + 50 +80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    NewInviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NewInviteFriendCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier];
        cell.ower = self;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.iconvalue = totalReward;
    cell.inviteFriendString = invitaDto.actContent;
    cell.inviteIndex = invitaDto.rewardRule;
    [cell setInviteFriendCell:indexPath];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        switch ([UserCenter defaultCenter].efubaoStatus) {
            case eLoginByPhoneUnBound:{
                BoundPhoneViewController *controller = [[BoundPhoneViewController alloc] init];
                controller.isEfubaoBound = YES;
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
            case eLoginByEmailPhoneUnBound:
            case eLoginByPhoneUnActive:
            case eLoginByEmailUnActive:
            {
                NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
                
                NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
                
                NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
                
                if ([emailTest evaluateWithObject:logonName]) {
                    [self presentSheet:L(@"EmailAccountToNetworkActivate")];
                    
                    return;
                }
                ActiveEfubaoViewController *controller = [[ActiveEfubaoViewController alloc] init];
                
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
            case eLoginByEmailUnBound:
            {
                EfubaoUnBoundEmailViewController *efubaoController = [[EfubaoUnBoundEmailViewController alloc] init];
                
                [self.navigationController pushViewController:efubaoController animated:YES];
                break;
            }
            default:
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620207"], nil]];
                NewGetRedPackEntryViewController *getpack = [[NewGetRedPackEntryViewController alloc] init];
                getpack.queryRewardDTO = _queryRewardDTO;
                getpack.activeUrl =invitaDto.actRuleURL;
                getpack.activeTitle = invitaDto.actTitle;
                getpack.activeRule =invitaDto.actContent;
                [self.navigationController pushViewController:getpack animated:YES];
                break;
        }
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

- (void)dealloc
{
    _invitaService.delegate=nil;
    SERVICE_RELEASE_SAFELY(_invitaService);
}

-(void)fenXiang:(id)sender{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag-1000) {
        case 0:
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620203"], nil]];
            [self shareButtonPressed];
            break;
        case 1:
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620208"], nil]];
            [self wexinShare];
            break;
        case 2:
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620209"], nil]];
            [self sendWeiXinContentWithType:1];
            break;
        case 3:
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620202"], nil]];
            [self sendSms:invitaDto.smsContent];
            break;
        case 4:{
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620205"], nil]];
            InviteFriendFaceByFaceViewController *facebyface = [[InviteFriendFaceByFaceViewController alloc] init];
            facebyface.ercodeurl = invitaDto.qrCodeUrl;
            [self.navigationController pushViewController:facebyface animated:YES];
        }
            break;
        case 5:
            [self copyText];
            break;
            
        default:
            break;
   
    }
}

- (void)shareButtonPressed
{
    BOOL isweibo = [WeiboSDK isWeiboAppInstalled];
    if (isweibo) {
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
        [WeiboSDK sendRequest:request];
    }
    else{
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"CPACPS_DeviceNotInstallSina") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        [alertView setConfirmBlock:^{
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
    
}


- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = invitaDto.smsContent;
    
    return message;
}



-(void)copyText{
    [self  presentSheet:L(@"WC_CopySuccess")];
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620206"], nil]];
    NSString *copynote = invitaDto.smsContent;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copynote;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
