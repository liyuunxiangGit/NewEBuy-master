//
//  NewGetRedPackEntryViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewGetRedPackEntryViewController.h"
#import "NewGetRedPackEntryCell.h"
@interface NewGetRedPackEntryViewController ()<InvitationServiceDelegate>
{
    NSArray      *monthArr;                 //月份数组
}
@property (nonatomic,strong)InvitationService *invitaService;
@property (nonatomic,strong)InvitationService *invitaServiceCip;

@end

@implementation NewGetRedPackEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.bounds;
    [self.view addSubview:self.suspendButton];
    if (!_queryRewardDTO)
    {
        self.navigationItem.leftBarButtonItem.enabled = NO;

        [self.invitaService beginInvitationHttpRequest];
    }
    else{
        [self.view addSubview:self.tableView];
    }
//    [self displayOverFlowActivityView:@"加载中..." yOffset: -60];
    self.title =L(@"CPACPS_CommissionDetail");
    
    self.tableView.frame = CGRectMake(0, 0, 320, frame.size.height);
    [self footView];
    [self getMonth];
   
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    _queryRewardDTO=nil;
    SERVICE_RELEASE_SAFELY(_invitaService);
    SERVICE_RELEASE_SAFELY(_invitaServiceCip);

}

-(void)getMonth{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:[NSDate date]];
    NSInteger curMonth = [comps month];
    NSInteger lastMonth = curMonth - 1;
    NSInteger breLastMonth = curMonth -2;
    if (lastMonth < 1) {
        lastMonth +=12;
    }
    if (breLastMonth < 1) {
        breLastMonth +=12;
    }
    NSString *curM = [NSString stringWithFormat:@"%d",curMonth];
    NSString *lastM = [NSString stringWithFormat:@"%d",lastMonth];
    NSString *breM = [NSString stringWithFormat:@"%d",breLastMonth];
    monthArr = [[NSArray alloc] initWithObjects:@"",curM,lastM,breM, nil];
}

-(InvitationService *)invitaService
{
    if (!_invitaService) {
        _invitaService=[[InvitationService alloc]init];
        _invitaService.delegate=self;
    }
    return _invitaService;
}

-(InvitationService *)invitaServiceCip
{
    if (!_invitaServiceCip) {
        _invitaServiceCip=[[InvitationService alloc]init];
        _invitaServiceCip.delegate=self;
    }
    return _invitaServiceCip;
}

- (void) QueryRewardServiceComplete:(QueryRewardDTO *)service isSuccess:(BOOL) isSuccess{
    if (isSuccess) {
        //推送情况的特殊处理
//        if (IsStrEmpty(_activeUrl))
//        {
//            [self.invitaService beginInvitationHttpRequest];
//            
//        }else{
            self.queryRewardDTO = service;
            
            [self removeOverFlowActivityView];
        
            [self.view addSubview:self.tableView];

//        }
        
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
        else{
            
        }
        
    }
}

- (void)InvitationServiceComplete:(InvitationDTO *)service isSuccess:(BOOL) isSuccess{
    self.navigationItem.leftBarButtonItem.enabled = YES;

    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        [UserCenter defaultCenter].cipher = service.cipher;

//        _activeUrl = service.actRuleURL;
//        
//        _activeTitle = service.actTitle;
//        
//        _activeRule = service.actContent;
        
        [self.invitaServiceCip beginQueryRewardHttpRequest:nil];
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

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}

//点击分享
- (void)share
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620211"], nil]];
    [self.shareKit shareWithContent:self.queryRewardDTO.shareContent  image:nil productImageURL:nil];
    
    [self.chooseShareWayView showChooseShareWayView];
    
}

- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView) {
        _chooseShareWayView = [[ChooseShareWayView alloc] initWithShareTypes:@[SNShareToWeiXin,SNShareToWeiXinFriend,SNShareToSinaWeibo,SNShareToTCWeiBo,SNShareToSMS]];
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    NewGetRedPackEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NewGetRedPackEntryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.totalCach = _queryRewardDTO.totalReward;
    switch (indexPath.row) {
        case 1:
            cell.hongBao = _queryRewardDTO.currCpaReward;
            cell.cashBack = _queryRewardDTO.currCpsReward;
            break;
        case 2:
            cell.hongBao = _queryRewardDTO.lastCpaReward;
            cell.cashBack = _queryRewardDTO.lastCpsReward;
            break;
        case 3:
            cell.hongBao = _queryRewardDTO.bfrLastCpaReward;
            cell.cashBack = _queryRewardDTO.bfrLastCpsReward;
            break;
        default:
            break;
    }
    cell.month = [monthArr objectAtIndex:indexPath.row];
    [cell setGetRedPackCell:indexPath];
    return cell;
}

-(void)footView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 280, 30)];
    [btn setTitle:L(@"CPACPS_XuanFu") forState:0];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    self.tableView.tableFooterView=footView;
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
