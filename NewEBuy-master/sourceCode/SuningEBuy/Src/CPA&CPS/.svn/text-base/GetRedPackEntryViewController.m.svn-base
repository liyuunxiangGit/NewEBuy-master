//
//  GetRedPackEntryViewController.m
//  SuningEBuy
//
//  Created by leo on 14-3-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GetRedPackEntryViewController.h"
#import "InvitationService.h"
#import "ActiveRuleViewController.h"
@interface GetRedPackEntryViewController ()

@end

@implementation GetRedPackEntryViewController

- (id)init
{
    self = [super init];
    if (self) {
        

        // Custom initialization
    }
    return self;
}

-(InvitationService *)invita
{
    if (!_invita) {
        _invita=[[InvitationService alloc]init];
        _invita.delegate=self;
    }
    return _invita;
}

- (void) QueryRewardServiceComplete:(QueryRewardDTO *)service isSuccess:(BOOL) isSuccess{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    if (isSuccess) {
        //推送情况的特殊处理
        if (IsStrEmpty(_activeurl))
        {
            [self.invita beginInvitationHttpRequest];
            
        }else{
            
            [self removeOverFlowActivityView];
        }
        
        _totalcount.text=[NSString stringWithFormat:@"%@：%@%@",L(@"CPACPS_3MonthMoney"),service.totalReward,L(@"Money Unit")];
        CGSize sizeName = [_totalcount.text sizeWithFont:[UIFont systemFontOfSize:15]
                              constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
                                  lineBreakMode:NSLineBreakByWordWrapping];
        _totalcount.frame = CGRectMake((320-sizeName.width)/2, 5, sizeName.width, 30);
        _tuijian.text=[NSString stringWithFormat:@"%@%@",service.cpaReward,L(@"Money Unit")];
        _xiadan.text=[NSString stringWithFormat:@"%@%@",service.cpsReward,L(@"Money Unit")];
        [self.view bringSubviewToFront:_tuijian];
        [self.view bringSubviewToFront:_xiadan];
     }
    else{
        
        [self removeOverFlowActivityView];
        
        if (service.errorMsg.length) {
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
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        _activeurl = service.actRuleURL;
        
        _activetitle = service.actTitle;
        
        _activerule = service.actContent;
    }
    else{
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:service.errorMsg?service.errorMsg:L(@"NWRequestError") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.invita beginQueryRewardHttpRequest:nil];
    [self displayOverFlowActivityView:L(@"CPACPS_LoadIng") yOffset: -60];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.title =L(@"CPACPS_AwardCount");
    [self.view addSubview:self.invitetext];
    [self.view addSubview:self.totalcount];
    [self.view addSubview:self.tuijian];
    [self.view addSubview:self.xiadan];
    [self.view addSubview:self.note];
    UIView *view = (UIView *)[self.view viewWithTag:1000];
    if (view) {
        [self.view bringSubviewToFront:view];
    }
    view = (UIView *)[self.view viewWithTag:1001];
    if (view) {
        [self.view bringSubviewToFront:view];
    }
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.xiadan.bottom+20, 310, 2)];
    imgview.image = [UIImage imageNamed:@"line_dotted"];
    [self.view addSubview:imgview];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UILabel *)totalcount{
    if (!_totalcount) {
        _totalcount = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 210, 30)];
        _totalcount.font= [UIFont systemFontOfSize:15];
        _totalcount.textColor = [UIColor redColor];
        _totalcount.backgroundColor = [UIColor clearColor];
    }
    return _totalcount;
}

-(UITextView *)note{
    if (!_note) {
        _note = [[UITextView alloc] initWithFrame:CGRectMake(10, self.xiadan.bottom+20, 310, 20)];
        CGSize sizeToFit = [self.activetitle sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [_note setFrame:CGRectMake(5, self.xiadan.bottom+20, 310,  MAX(sizeToFit.height+16, 20))];
        _note.text = self.activetitle;
        _note.editable = NO;
        _note.scrollEnabled = NO;
        _note.font = [UIFont boldSystemFontOfSize:16];
        
    }
    return _note;
}


-(UILabel *)tuijian{
    if (!_tuijian) {
        UILabel *tuijiantitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.totalcount.bottom+10, 300, 40)];
        tuijiantitle.text =L(@"CPACPS_Tips1");
        tuijiantitle.font = [UIFont systemFontOfSize:16];
        tuijiantitle.lineBreakMode = UILineBreakModeWordWrap;
        tuijiantitle.numberOfLines = 0;
        tuijiantitle.tag =1001;
        tuijiantitle.textColor = [UIColor blackColor];
        [self.view addSubview:tuijiantitle];
        _tuijian = [[UILabel alloc] initWithFrame:CGRectMake(40, self.totalcount.bottom+32, 250, 20)];
        _tuijian.textColor = [UIColor redColor];
        _tuijian.backgroundColor = [UIColor clearColor];
        _tuijian.lineBreakMode = UILineBreakModeWordWrap;
        _tuijian.numberOfLines = 0;
        _tuijian.font = [UIFont systemFontOfSize:16];

    }
    return _tuijian;
}

-(UILabel *)xiadan{
    if (!_xiadan) {
        UILabel *tuijiantitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.tuijian.bottom+20, 300, 40)];
        tuijiantitle.text =L(@"CPACPS_Tips2");
        tuijiantitle.font = [UIFont systemFontOfSize:16];
        tuijiantitle.lineBreakMode = UILineBreakModeWordWrap;
        tuijiantitle.numberOfLines = 0;

        tuijiantitle.textColor = [UIColor blackColor];
        tuijiantitle.tag = 1000;
        [self.view addSubview:tuijiantitle];
        _xiadan = [[UILabel alloc] initWithFrame:CGRectMake(65, self.tuijian.bottom+42, 250, 20)];
        _xiadan.textColor = [UIColor redColor];
        _xiadan.backgroundColor = [UIColor clearColor];
        _xiadan.font = [UIFont systemFontOfSize:16];
        _xiadan.lineBreakMode = UILineBreakModeWordWrap;
        _xiadan.numberOfLines = 0;
    }
    return _xiadan;
}

-(UITextView *)invitetext{
    if (!_invitetext) {
        _invitetext = [[UITextView alloc] initWithFrame:CGRectMake(10, self.note.bottom, 270, 50)];
        _invitetext.editable = NO;
        CGSize size = [self.activerule sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(310, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [_invitetext setFrame:CGRectMake(5, self.note.bottom, 310,  MAX(size.height+16, 40))];
        _invitetext.text=self.activerule;
        _invitetext.scrollEnabled = NO;
        _invitetext.font = [UIFont systemFontOfSize:16];
        _invitetext.backgroundColor = [UIColor clearColor];
        UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, self.totalcount.bottom, 320, 170+size.height+self.note.size.height)];
        backview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backview];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, _invitetext.bottom, 100, 20)];
        [btn setTitle:L(@"CPACPS_ActivityRule") forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

        }
    return _invitetext;
}

-(void)btnclick{
    ActiveRuleViewController *active = [[ActiveRuleViewController alloc] init:_activeurl];
    [self.navigationController pushViewController:active animated:YES];
}

- (void)dealloc
{
    _invita.delegate=nil;
    SERVICE_RELEASE_SAFELY(_invita);
    TT_RELEASE_SAFELY(_totalcount);
    TT_RELEASE_SAFELY(_tuijian);
    TT_RELEASE_SAFELY(_xiadan);
    TT_RELEASE_SAFELY(_note);
    TT_RELEASE_SAFELY(_invitetext);
}
@end
