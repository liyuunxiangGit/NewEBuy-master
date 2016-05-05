//
//  InviteFriendViewController.m
//  SuningEBuy
//
//  Created by leo on 14-3-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "InviteFriendCell.h"
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

@interface InviteFriendViewController ()
{
   
    InvitationDTO *invitaDto;
}
@end

@implementation InviteFriendViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
       
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self footview];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = self.view.bounds;
    [self.view addSubview:self.suspendButton];
    self.groupTableView.frame = frame;
    [self.view addSubview:self.groupTableView];
    [self.invita beginInvitationHttpRequest];
    [self displayOverFlowActivityView:L(@"CPACPS_LoadIng") yOffset: -60];
    self.title=L(@"CPACPS_InviteFriendEarnMoney");
    SNUIBarButtonItem *leftButton = [SNUIBarButtonItem itemWithTitle:@""
                                                                Style:SNNavItemStyleBack
                                                               target:self
                                                               action:@selector(backForePage)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)backForePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) InvitationServiceComplete:(InvitationDTO *)service isSuccess:(BOOL) isSuccess{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [UserCenter defaultCenter].cipher = service.cipher;
        invitaDto = service;
        [self.groupTableView reloadData];
        [self footview];
      
    }
    else{
//        if (service) {
            BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:service.errorMsg?service.errorMsg:L(@"NWRequestError") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
            [alertView setConfirmBlock:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertView show];
            TT_RELEASE_SAFELY(alertView);
//        }
    }
}


-(void)footview{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    NSString *myanhao = [NSString stringWithFormat:@"%@：%@",L(@"CPACPS_MyAnHao"),invitaDto.cipher?invitaDto.cipher:@""];
    label.font=[UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    label.text=myanhao;

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 280, 30)];
    [btn setTitle:L(@"CPACPS_CheckAward") forState:0];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(myredpack) forControlEvents:UIControlEventTouchUpInside];
    
    switch ([UserCenter defaultCenter].efubaoStatus) {
        case eLoginByPhoneActive:{
            [btn setUserInteractionEnabled:YES];
            break;
        }
        case eLoginByEmailActive:{
            [btn setUserInteractionEnabled:YES];
            break;
        }
        case eLoginByPhoneUnBound:
        case eLoginByPhoneUnActive:{
            btn.backgroundColor = [UIColor grayColor];
            btn.enabled = NO;
            UITextView *labe = [[UITextView alloc] initWithFrame:CGRectMake(5, 85, 300, 50)];
            labe.text=L(@"CPACPS_ActivateYFBSendAward");
            labe.editable=NO;
            labe.backgroundColor = [UIColor clearColor];
            labe.scrollEnabled=NO;
            labe.textColor = [UIColor orangeColor];
            [footView addSubview:labe];
            UIButton *activebtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 125, 100, 30)];
            [activebtn setTitle:L(@"CPACPS_ActivateYFB") forState:UIControlStateNormal];
            [activebtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [footView addSubview:activebtn];
            [activebtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiu"] forState:UIControlStateNormal];
            [activebtn addTarget:self action:@selector(activeclick) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case eLoginByEmailUnBound:{
            btn.backgroundColor = [UIColor grayColor];
            btn.enabled = NO;
            UITextView *label1 = [[UITextView alloc] initWithFrame:CGRectMake(5, 85, 300, 50)];
            label1.text=L(@"CPACPS_Tips3");
            label1.editable=NO;
            label1.backgroundColor = [UIColor clearColor];
            label1.scrollEnabled=NO;
            label1.textColor = [UIColor orangeColor];
            [footView addSubview:label1];
            break;
        }
            
        default:
            break;
    }
    
    [footView addSubview:label];
    [footView addSubview:btn];
    self.groupTableView.tableFooterView=footView;

}

//微信分享
-(void)wexinshare{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"";
        message.description = @"";
        [message setThumbImage:nil];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = YES;
        req.text=invitaDto.smsContent;
        req.message = message;
        
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
        default:
            break;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGSize sizeToFit = [invitaDto.actContent sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        CGSize size =  [invitaDto.actTitle sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        return 50+MAX(sizeToFit.height, 20.0f)+MAX(size.height, 20.0f);
    }
    else if(indexPath.section ==1){
        return 44;
    }
    else{
        CGSize sizeToFit = [invitaDto.rewardRule sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        return 26+sizeToFit.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    InviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[InviteFriendCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell setinvitefriendcell:indexPath];
    if (indexPath.section == 0) {
        CGSize size =  [invitaDto.actTitle sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [cell.invitefriden.note setFrame:CGRectMake(-5, 2, 320, MAX(size.height+16, 20.0f))];
        cell.invitefriden.note.font = [UIFont boldSystemFontOfSize:13];
        cell.invitefriden.note.text = invitaDto.actTitle;
        size =  [invitaDto.actContent sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        cell.invitefriden.invitetext.text = invitaDto.actContent;
        cell.invitefriden.invitetext.font = [UIFont systemFontOfSize:13];
        [cell.invitefriden.invitetext setFrame:CGRectMake(-5, cell.invitefriden.note.size.height+2, 320, MAX(size.height+16, 20.0f))];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(220, size.height+cell.invitefriden.note.size.height+20, 100, 20)];
        [btn setTitle:L(@"CPACPS_ActivityRule") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell addSubview:btn];
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, MAX(size.height+16, 20.0f)+cell.invitefriden.note.size.height+25)];
        btn1.backgroundColor = [UIColor clearColor];
        [btn1 addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn1];
        
    }
    else if(indexPath.section ==2)
    {
        CGSize size =  [invitaDto.rewardRule sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        cell.invitefriden.invitetext.text = invitaDto.rewardRule;
        cell.invitefriden.note.hidden = YES;
        cell.invitefriden.invitetext.font = [UIFont systemFontOfSize:13];
        [cell.invitefriden.invitetext setFrame:CGRectMake(-5, 5, 320, MAX(size.height+16, 44.0f))];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
      
    
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [self btnclick];
            break;
            
        case 1:{
            if (indexPath.row ==0) {
                //短信
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620202"], nil]];
                [self sendSms:invitaDto.smsContent];
                
            }
            else if(indexPath.row == 1){
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620203"], nil]];
                [self shareButtonPressed];
            }
            else if(indexPath.row ==2){
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620204"], nil]];
                [self wexinshare];
            }
            else{
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620205"], nil]];
                InviteFriendFaceByFaceViewController *facebyface = [[InviteFriendFaceByFaceViewController alloc] init];
                facebyface.ercodeurl = invitaDto.qrCodeUrl;
                [self.navigationController pushViewController:facebyface animated:YES];
            }
            break;
        }
        case 2:{
          
        }
        default:
            
            break;
    }
  
}


- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = invitaDto.smsContent;
    
    return message;
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


-(float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==1) {
        UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 20)];
        label.text =L(@"CPACPS_HaiKeYi");
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        UIButton *btn = [[UIButton   alloc] initWithFrame:CGRectMake(60, 5, 80, 20)];
        OHAttributedLabel *label2 = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 4, 80, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:L(@"CPACPS_CopyInvatationContent")];
        [attStr setTextColor:[UIColor orangeColor]];
        [attStr setTextIsUnderlined:YES];
        [attStr setFont:[UIFont systemFontOfSize:12]];
        label2.attributedText = attStr;
        [label2 setUserInteractionEnabled:NO];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [btn addSubview:label2];
        
        btn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(copytext) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 240, 20)];
        label1.text =L(@"CPACPS_ShareToRRQQ");
        label1.font = [UIFont systemFontOfSize:12];
        label1.backgroundColor = [UIColor clearColor];

        [footview addSubview:label];
        [footview addSubview:label1];
        [footview addSubview:btn];
        return footview;
    }
    if (section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    return nil;
}


-(void)activeclick{
    switch ([UserCenter defaultCenter].efubaoStatus) {//defaultCenter.efubaoStatus
        case eLoginByPhoneUnBound:{
            //手机登录、易付宝激活
            BoundPhoneViewController *controller = [[BoundPhoneViewController alloc] init];
            controller.isEfubaoBound = YES;
            [self.navigationController pushViewController:controller animated:YES];
            TT_RELEASE_SAFELY(controller);
            
        }
            break;
        case eLoginByPhoneUnActive:{
            
            
            NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
            
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            
            if ([emailTest evaluateWithObject:logonName]) {
                [self presentSheet:L(@"EmailAccountToNetworkActivate")];
                
                return;
            }
            ActiveEfubaoViewController *controller = [[ActiveEfubaoViewController alloc] init];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            TT_RELEASE_SAFELY(controller);
            
        }
            
        break;
        default:{
            
        }
            break;
    }
}

-(void)btnclick{
    ActiveRuleViewController *active = [[ActiveRuleViewController alloc] init:invitaDto.actRuleURL];
    [self.navigationController pushViewController:active animated:YES];
}

-(void)myredpack{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620207"], nil]];
        GetRedPackEntryViewController *getred  = [[GetRedPackEntryViewController alloc] init];
        getred.activeurl =invitaDto.actRuleURL;
        getred.activetitle = invitaDto.actTitle;
        getred.activerule =invitaDto.actContent;
        [self.navigationController pushViewController:getred animated:YES];
}

-(void)copytext{
    [self  presentSheet:L(@"WC_CopySuccess")];
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620206"], nil]];
    NSString *copynote = invitaDto.smsContent;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copynote;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2)
    {
        return 0;
    }
    else if(section ==1){
        return 40;
    }
    return 10;
}

-(InvitationService *)invita
{
    if (!_invita) {
        _invita=[[InvitationService alloc]init];
        _invita.delegate=self;
    }
    return _invita;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *laber = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 20)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    view.backgroundColor = [UIColor orangeColor];
    if (section == 1) {
        laber.text =L(@"CPACPS_InviteRegister");
    }
    else if(section == 2){
        laber.text =L(@"CPACPS_DuiAnHaoGetAward");
    }
    laber.textColor = [UIColor whiteColor];
    laber.font = [UIFont systemFontOfSize:13];
    laber.backgroundColor = [UIColor clearColor];
    [view addSubview:laber];

    return view;
}

- (void)dealloc
{
    _invita.delegate=nil;
    SERVICE_RELEASE_SAFELY(_invita);
    TT_RELEASE_SAFELY(invitaDto);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
