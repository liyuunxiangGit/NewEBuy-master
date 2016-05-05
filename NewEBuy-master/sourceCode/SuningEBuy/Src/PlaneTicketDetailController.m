//
//  PlaneTicketDetailController.m
//  SuningEBuy
//
//  Created by david on 14-2-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneTicketDetailController.h"
#import "SNPopoverController.h"
#import "PlanTicketSwitch.h"
#import "RuleInfoViewController.h"
#import "TicketDetailDTO.h"
#import "PlaneTicketCell.h"
#import "BookPersonCell.h"
#import "HangChengDanCell.h"
#import "PlanePayModelCell.h"
#import "PlaneOrderInfoCell.h"
#import "flightPayOrderViewController.h"
#import "PlaneRefundViewController.h"
#import "SNWebViewController.h"

@interface PlaneTicketDetailController ()

@property (nonatomic, strong) PFOrderBasicDTO       *orderBasicDTO;
@property (nonatomic, strong) PFOrderDetailDTO      *orderDetailDTO;
@property (nonatomic, strong) SNPopoverController   *ruleInfoController;
@property (nonatomic, strong) NSArray               *itemList;
@property (nonatomic, strong) UILabel               *totalLbl;
@property (nonatomic, strong) UILabel               *totalValLbl;
@property (nonatomic, strong) UIButton              *barButton;


@end

@implementation PlaneTicketDetailController

- (id)initWithBasicOrderDTO:(PFOrderBasicDTO *)basicDto {
    self = [super init];
    if (self) {
        self.title = L(@"the detail orderList");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        self.orderBasicDTO =  basicDto;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    self.tableView.frame = frame;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isDataLoaded) {
        
        [self sendOrderDetailHttpRequest];
    }
}

#pragma mark -
#pragma mark UIView
-(UILabel *)totalLbl{
    if (!_totalLbl) {
        _totalLbl = [[UILabel alloc]init];
        _totalLbl.frame = CGRectMake(15, 9, 50, 30);
        _totalLbl.backgroundColor = [UIColor clearColor];
        _totalLbl.font = [UIFont systemFontOfSize:15];
        _totalLbl.text = L(@"BTTotal");
        [self.bottomNavBar addSubview:_totalLbl];
    }
    return _totalLbl;
}

-(UILabel *)totalValLbl{
    if (!_totalValLbl) {
        _totalValLbl = [[UILabel alloc]init];
        _totalValLbl.frame = CGRectMake(self.totalLbl.right, 9, 100, 30);
        _totalValLbl.backgroundColor = [UIColor clearColor];
        _totalValLbl.font = [UIFont boldSystemFontOfSize:15];
        _totalValLbl.textColor = [UIColor orange_Red_Color];
        _totalValLbl.text = @"￥0.00";
        [self.bottomNavBar addSubview:_totalValLbl];
    }
    return _totalValLbl;
}

-(UIButton *)barButton{
    
    if (!_barButton) {
        
        _barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _barButton.frame = CGRectMake(self.totalValLbl.right+10, 9, 80, 30);
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_barButton setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_barButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        [_barButton setTitle:L(@"BTPayNow") forState:UIControlStateNormal];
        [_barButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _barButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        [_barButton addTarget:self action:@selector(repayPlaneTicket) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomNavBar addSubview:_barButton];
    }
    return _barButton;
}

#pragma mark -
#pragma mark 获取订单详情接口
-(PlanTicketService*)ticketService
{
    if( nil ==  _ticketService)
    {
        _ticketService = [[PlanTicketService alloc] init];
        _ticketService.delegate = self;
    }
    return _ticketService;
}

-(void)getPlanTicketDetailService:(PlanTicketService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if(isSuccess){
        
        self.orderDetailDTO = service.orderDetailDTO;
        
        self.totalValLbl.text = [NSString stringWithFormat:@"￥%.2f",[self.orderDetailDTO.totalAmount doubleValue]];
        
        //等待付款状态展示立即付款
        if ([self.orderDetailDTO.orderStatus eq:@"1"]) {
            self.barButton.hidden = NO;
        }else{
            self.barButton.hidden = YES;
        }
        
    }else{
        
        [self presentSheet:L(@"Sorry loading failed")];
    }
    
    [self.tableView reloadData];
}


- (void)sendOrderDetailHttpRequest
{
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:self.orderBasicDTO.ordersId forKey:@"orderId"];
    
    [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.userId forKey:@"userId"];
    
    [self.ticketService sendPlanOrderDetailRequest:postDataDic];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

#pragma mark -
#pragma mark - 取消订单
- (void)cancelOrder:(PFOrderBasicDTO *)dto{

    BBAlertView *alertview = [[BBAlertView alloc] initWithTitle:nil message:L(@"CacelOrder_Warning_Message") delegate:self cancelButtonTitle:L(@"cancel") otherButtonTitles:L(@"ok")];
    
    [alertview setConfirmBlock:^{
        [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
        [self.ticketService beginCancelPlanOderRequest:dto];
    }];
    
    [alertview show];
    
    TT_RELEASE_SAFELY(alertview);
    
}

- (void)endCancelOrderComplete:(PlanTicketService *)service Result:(BOOL)isSucces errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    if (isSucces) {

        BBAlertView *alertview = [[BBAlertView alloc] initWithTitle:nil message:L(@"BTCancel_Order_Success") delegate:self cancelButtonTitle:L(@"ok") otherButtonTitles:nil];
        
        [alertview setCancelBlock:^{
            
            *_isLoadOk = NO;

            [self.navigationController popViewControllerAnimated:YES];            
        }];
        
        [alertview show];
        
        TT_RELEASE_SAFELY(alertview);
        
    }else{
        
        [self presentSheet:errorMsg];
    }
}

#pragma mark -
#pragma mark 机票二次支付
-(void)repayPlaneTicket{
    
    flightPayOrderViewController *flightPayModeViewController = [[flightPayOrderViewController alloc]initRepay];
    flightPayModeViewController.flightOrderId = self.orderDetailDTO.orderId;
    flightPayModeViewController.flightPrice = self.orderDetailDTO.totalAmount?[NSString stringWithFormat:@"%.2f",[self.orderDetailDTO.totalAmount floatValue]]:@"0.00";
    [self.navigationController pushViewController:flightPayModeViewController animated:YES];
    TT_RELEASE_SAFELY(flightPayModeViewController);
    
}


#pragma mark -
#pragma mark 展示退改签规则

- (SNPopoverController *)ruleInfoController
{
    if (!_ruleInfoController) {
        _ruleInfoController = [[SNPopoverController alloc] init];
        _ruleInfoController.blackLayerFrame = [[UIScreen mainScreen] bounds];
    }
    return _ruleInfoController;
}

- (void)showRuleInfo:(AirlineInfoDTO *)airlineRule
{
    RuleInfoViewController *VC = [[RuleInfoViewController alloc] init];
    VC.airlineInfo = airlineRule;
    [self.ruleInfoController presentWithContentViewController:VC animated:YES];
}



#pragma mark -
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 4;
    count+= [self.orderDetailDTO.airLineInfoArray count];
    count+= [self.orderDetailDTO.goTicketArray count];
    count+= [self.orderDetailDTO.backTicketArray count];
    if (count == 4) {
        return 0;
    }
    //等待付款状态添加取消订单按钮
    if ([_orderDetailDTO.orderStatus eq:@"1"] || [_orderDetailDTO.orderStatus eq:@"2"] || [_orderDetailDTO.orderStatus eq:@"5"]) {
        count++;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单程
    if([_orderDetailDTO.airLineInfoArray count] == 1){
        
        if (indexPath.row == 0) {
            
            //航班信息
            return [AirLineCell height:_orderDetailDTO];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+1)){
            
            //预订人信息
            return [BookPersonCell height];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+2)){
            
            //航程单配送
            return [HangChengDanCell height:_orderDetailDTO];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+3)){
            
            //支付方式
            return [PlanePayModelCell height];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+4)){
            
            //订单信息
            return [PlaneOrderInfoCell height];
            
        }else if(([self.orderDetailDTO.orderStatus eq:@"1"] || [_orderDetailDTO.orderStatus eq:@"2"] || [_orderDetailDTO.orderStatus eq:@"5"] ) && indexPath.row == ([_orderDetailDTO.goTicketArray count]+5)){
        
            //取消订单或者退改签按钮
            return [PlaneOneButtonCell height];
        
        }else{
            
            //机票信息
            TicketDetailDTO *dto = [self.orderDetailDTO.goTicketArray objectAtIndex:(indexPath.row-1)];
            return [PlaneTicketCell height:dto];
        }
        
    }else{      //往返
        
        if (indexPath.row == 0 || indexPath.row == [_orderDetailDTO.goTicketArray count]+1) {
            //航班信息
            return [AirLineCell height:_orderDetailDTO];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+2)){
            //预订人信息
            return [BookPersonCell height];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+3)){
            //航程单配送
            return [HangChengDanCell height:_orderDetailDTO];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+4)){
            //支付方式
            return [PlanePayModelCell height];
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+5)){
            //订单信息
            return [PlaneOrderInfoCell height];
            
        }else if(([self.orderDetailDTO.orderStatus eq:@"1"] || [_orderDetailDTO.orderStatus eq:@"2"] || [_orderDetailDTO.orderStatus eq:@"5"])&& indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+6)){
            
            //取消订单或者退改签按钮
            return [PlaneOneButtonCell height];
            
        }else{
            
            //机票信息
            TicketDetailDTO *dto = nil;
            if (indexPath.row <= [_orderDetailDTO.goTicketArray count]) {
                
                NSInteger index = indexPath.row-1;
                if ([_orderDetailDTO.goTicketArray count] > index) {
                    dto = [_orderDetailDTO.goTicketArray objectAtIndex:index];
                }
                
            }else{
                
                NSInteger index = indexPath.row-[_orderDetailDTO.goTicketArray count]-2;
                if ([_orderDetailDTO.backTicketArray count] > index) {
                    dto = [_orderDetailDTO.backTicketArray objectAtIndex:index];
                }
            }
            return [PlaneTicketCell height:dto];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单程
    if ([_orderDetailDTO.airLineInfoArray count] == 1) {
        
        if (indexPath.row == 0) {
            
            //航班信息
            static NSString *airlineIdentifier = @"airlineIdentifier";
            AirLineCell *cell = [tableView dequeueReusableCellWithIdentifier:airlineIdentifier];
            if (cell == nil) {
                cell = [[AirLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:airlineIdentifier];
                cell.delegate = self;
            }
            [cell refreshCell:self.orderDetailDTO index:indexPath.row];
            return cell;
            
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+1)){
            
            //预订人信息
            static NSString *bookIdentifier = @"bookIdentifier";
            BookPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:bookIdentifier];
            if (cell == nil) {
                cell = [[BookPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bookIdentifier];
            }
            [cell refreshCell:self.orderDetailDTO];
            return cell;
            
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+2)){
            
            //航程单配送
            static NSString *hangIdentifier = @"hangIdentifier";
            HangChengDanCell *cell = [tableView dequeueReusableCellWithIdentifier:hangIdentifier];
            if (cell == nil) {
                cell = [[HangChengDanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hangIdentifier];
            }
            [cell refreshCell:_orderDetailDTO];
            return cell;
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+3)){
            
            //支付方式
            static NSString *payIdentifier = @"payIdentifier";
            PlanePayModelCell *cell = [tableView dequeueReusableCellWithIdentifier:payIdentifier];
            if (cell == nil) {
                cell = [[PlanePayModelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payIdentifier];
            }
            [cell refreshCell:self.orderDetailDTO];
            return cell;
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]+4)){
            
            //订单信息
            static NSString *orderIdentifier = @"orderIdentifier";
            PlaneOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderIdentifier];
            if (cell == nil) {
                cell = [[PlaneOrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderIdentifier];
            }
            [cell refreshCell:self.orderDetailDTO];
            return cell;
            
        }else if(([_orderDetailDTO.orderStatus eq:@"1"] || [_orderDetailDTO.orderStatus eq:@"2"] || [_orderDetailDTO.orderStatus eq:@"5"]) && indexPath.row == ([_orderDetailDTO.goTicketArray count]+5)){
            
            //取消订单或者退改签按钮
            static NSString *cancelIdentifier = @"cancelIdentifier";
            PlaneOneButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cancelIdentifier];
            if (cell == nil) {
                cell = [[PlaneOneButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cancelIdentifier];
                cell.delegate = self;
            }
            if ([self.orderDetailDTO.orderStatus eq:@"1"]) {
                [cell refreshCell:PlaneButtonTypeCancel];
            }else{
                [cell refreshCell:PlaneButtonTypeRefund];
            }
            return cell;
            
        }else{
            
            //机票信息
            static NSString *ticketIdentifier = @"ticketIdentifier";
            PlaneTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:ticketIdentifier];
            if (cell == nil) {
                cell = [[PlaneTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ticketIdentifier];
            }
            TicketDetailDTO *dto = [self.orderDetailDTO.goTicketArray objectAtIndex:(indexPath.row-1)];
            [cell refreshCell:dto];
            return cell;
        }
        
    }else{  //往返
        
        if (indexPath.row == 0 || indexPath.row == [_orderDetailDTO.goTicketArray count]+1) {

            //航班信息
            static NSString *airlineIdentifier = @"airlineIdentifier";
            AirLineCell *cell = [tableView dequeueReusableCellWithIdentifier:airlineIdentifier];
            if (cell == nil) {
                cell = [[AirLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:airlineIdentifier];
                cell.delegate = self;
            }
            if (indexPath.row == 0) {
                [cell refreshCell:self.orderDetailDTO index:0];
            }else{
                [cell refreshCell:self.orderDetailDTO index:1];
            }
            return cell;
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+2)){

            //预订人信息
            static NSString *bookIdentifier = @"bookIdentifier";
            BookPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:bookIdentifier];
            if (cell == nil) {
                cell = [[BookPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bookIdentifier];
            }
            [cell refreshCell:self.orderDetailDTO];
            return cell;
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+3)){

            //航程单配送
            static NSString *hangIdentifier = @"hangIdentifier";
            HangChengDanCell *cell = [tableView dequeueReusableCellWithIdentifier:hangIdentifier];
            if (cell == nil) {
                cell = [[HangChengDanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hangIdentifier];
            }
            [cell refreshCell:_orderDetailDTO];
            return cell;
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+4)){

            //支付方式
            static NSString *payIdentifier = @"payIdentifier";
            PlanePayModelCell *cell = [tableView dequeueReusableCellWithIdentifier:payIdentifier];
            if (cell == nil) {
                cell = [[PlanePayModelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payIdentifier];
            }
            [cell refreshCell:self.orderDetailDTO];
            return cell;
            
        }else if (indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+5)){

            //订单信息
            static NSString *orderIdentifier = @"orderIdentifier";
            PlaneOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderIdentifier];
            if (cell == nil) {
                cell = [[PlaneOrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderIdentifier];
            }
            [cell refreshCell:self.orderDetailDTO];
            return cell;

            
        }else if(([self.orderDetailDTO.orderStatus eq:@"1"] || [_orderDetailDTO.orderStatus eq:@"2"] || [_orderDetailDTO.orderStatus eq:@"5"]) && indexPath.row == ([_orderDetailDTO.goTicketArray count]*2+6)){
            
            //取消订单或者退改签按钮
            static NSString *cancelIdentifier = @"cancelIdentifier";
            PlaneOneButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cancelIdentifier];
            if (cell == nil) {
                cell = [[PlaneOneButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cancelIdentifier];
                cell.delegate = self;
            }
            if ([self.orderDetailDTO.orderStatus eq:@"1"]) {
                [cell refreshCell:PlaneButtonTypeCancel];
            }else{
                [cell refreshCell:PlaneButtonTypeRefund];
            }
            return cell;
            
        }else{
            
            //机票信息
            static NSString *ticketIdentifier = @"ticketIdentifier";
            PlaneTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:ticketIdentifier];
            if (cell == nil) {
                cell = [[PlaneTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ticketIdentifier];
            }
            
            TicketDetailDTO *dto = nil;
            if (indexPath.row <= [_orderDetailDTO.goTicketArray count]) {
                
                NSInteger index = indexPath.row-1;
                if ([_orderDetailDTO.goTicketArray count] > index) {
                    dto = [_orderDetailDTO.goTicketArray objectAtIndex:index];
                }
                
            }else{
                
                NSInteger index = indexPath.row-[_orderDetailDTO.goTicketArray count]-2;
                if ([_orderDetailDTO.backTicketArray count] > index) {
                    dto = [_orderDetailDTO.backTicketArray objectAtIndex:index];
                }
            }
            [cell refreshCell:dto];
            return cell;
        
        }
    }
}

#pragma mark -
#pragma mark 弹出退改签按钮
-(void)airlineCell:(AirLineCell *)cell airlineInfo:(AirlineInfoDTO *)info{
    
    [self showRuleInfo:info];
}


#pragma mark -
#pragma mark 取消订单或者退改签
-(void)planeOneButtonCell:(PlaneOneButtonCell *)cell buttonType:(PlaneButtonType)type{

    //取消订单
    if (type == PlaneButtonTypeCancel) {
        
        [self cancelOrder:self.orderBasicDTO];
    }else{
    //退改签
        
        PlaneRefundViewController *ctrl = [[PlaneRefundViewController alloc]init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
}

@end
