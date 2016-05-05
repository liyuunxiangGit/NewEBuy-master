//
//  MyTicketListViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyTicketListViewController.h"
#import "PFOrderBasicDTO.h"
#import "SNPopoverController.h"
#import "TicketOrderFilterViewController.h"
#import "flightPayOrderViewController.h"
#import "PlanTicketSwitch.h"
#import "PlaneTicketDetailController.h"
#import "SNWebViewController.h"


@interface MyTicketListViewController()

@property (nonatomic, strong) SNPopoverController *ticketPopoverController;
@property (nonatomic, strong) TicketOrderFilterViewController *filterController;

@property (nonatomic, assign) NSInteger orderStatus;

- (void)updateTableView;

@end

/*********************************************************************/

@implementation MyTicketListViewController

@synthesize orderList = _orderList;
@synthesize ticketPopoverController = _ticketPopoverController;
@synthesize filterController = _filterController;
@synthesize orderStatus = _orderStatus;
@synthesize ticketOrderService = _ticketOrderService;

#pragma mark - Life Circle Methods
#pragma mark   生命周期方法
- (void)dealloc {
    TT_RELEASE_SAFELY(_orderList);
    TT_RELEASE_SAFELY(_ticketPopoverController);
    SERVICE_RELEASE_SAFELY(_ticketOrderService);
    
    TT_RELEASE_SAFELY(_alertImageV);
    TT_RELEASE_SAFELY(_alertLbl);
    
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"MBTAirTicket");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        self.orderStatus = 0;
        
    }
    return self;
}

- (void)righBarClick
{
    [self showFilter];
}

- (void)loadView
{
    [super loadView];
    
    self.hasSuspendButton = YES;
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    
    
    if(self.isFromAllOrderCenter == YES)
    {
        if(!IOS7_OR_LATER)
        {
            frame.origin.y = -20;
            
            frame.size.height = contentView.bounds.size.height - 92+48;

        }
        else
        {
            frame.origin.y = 0;
            frame.size.height = contentView.bounds.size.height - 92+48-20;

        }
        
    }
    else
    {
        frame.origin.y = 0;
        
        
        if(IOS7_OR_LATER)
        {
            frame.size.height = contentView.bounds.size.height - 92+28;

        }
        else
        {
            frame.size.height = contentView.bounds.size.height - 92+48;

        }
        
    }
    
    self.tableView.frame = frame;
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isDataLoaded) {
        
        [self refreshData];
    }
}

#pragma mark - Filter  Metnods
#pragma mark   筛选模块

- (void)showFilter
{
    [self.ticketPopoverController presentWithContentViewController:self.filterController
                                                          animated:YES];
}

- (void)didSelectOrderStatus:(NSInteger)status
{
    self.orderStatus = status;
    
    [self refreshData];
}


#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.orderList count] > 0) {
        
        if ([self hasMore]) {
            
            return ([_orderList count]+1);
            
        }else{
            
            return [_orderList count];
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self hasMore] && self.totalCount == indexPath.row)
    {
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
			UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
			
			cell.title = L(@"loadMore");
            
            cell.animating = NO;
			
			return cell;
		}
		
		cell.animating = NO;
		
		return cell;
    }
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    TicketListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TicketListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PFOrderBasicDTO *dto = [self.orderList objectAtIndex:indexPath.row];
    [cell setItem:dto];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.totalCount == indexPath.row) {
        return 50;
    }
    
    PFOrderBasicDTO *dto = [self.orderList objectAtIndex:indexPath.row];
    
    return [TicketListCell height:dto];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.totalCount == indexPath.row) {
        [self loadMoreData];
        return;
    }
    
    PlaneTicketDetailController *detailVC = [[PlaneTicketDetailController alloc] initWithBasicOrderDTO:[self.orderList objectAtIndex:indexPath.row]];
    detailVC.isLoadOk = &isDataLoaded;
    
    if ([[self.view.superview nextResponder] isKindOfClass:[UIViewController class]]) {
        
        [((UIViewController *)self.view.superview.nextResponder).navigationController pushViewController:detailVC animated:YES];
    }else{
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.1)];
    
    if(IOS7_OR_LATER)
    {
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    else
    {
        view.backgroundColor = [UIColor clearColor];
        
    }
    
    return view;
}

#pragma mark - FlightOrderList Http Methods
#pragma mark   机票订单列表数据请求方法

- (void)sendOrderListHttpRequest
{
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    NSString *orderStatusStr = [NSString stringWithFormat:@"%d", self.orderStatus];
    NSString *currentPageStr = [NSString stringWithFormat:@"%d", self.currentPage];
    
    [self.ticketOrderService sendPlanOrderrRequest:orderStatusStr CurrentPage:currentPageStr];
    
}

- (UILabel*)alertLbl
{
    if(!_alertLbl)
    {
        _alertLbl = [[UILabel alloc] init];
        _alertLbl.font = [UIFont systemFontOfSize:17];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.frame = CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 30);
        _alertLbl.textAlignment = UITextAlignmentCenter;
        _alertLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _alertLbl.hidden = YES;
        [self.view addSubview:_alertLbl];
    }
    return _alertLbl;
}

- (UIImageView*)alertImageV
{
    if(!_alertImageV)
    {
        _alertImageV = [[UIImageView alloc] init];
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoOrder.png"];
        
        _alertImageV.frame = CGRectMake(116.5, 50, 77, 76);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];
        
    }
    
    return _alertImageV;
}

-(void)getPlanTicketService:(PlanTicketService *)service
                     Result:(BOOL)isSuccess
                   errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    
    if(isSuccess == YES)
    {
        //        if (self.isFromHead) {
        //            self.orderList = service.orderList;
        //        }else{
        //            [self.orderList addObjectsFromArray:service.orderList];
        //        }
        
        if (self.currentPage == 1) {
            [self.orderList removeAllObjects];
            self.orderList = service.orderList;
        }else{
            [self.orderList addObjectsFromArray:service.orderList];
        }
        
        self.isLastPage = service.isLastPage;
        isDataLoaded = service.isDataLoaded;
        self.totalCount = [self.orderList count];
        self.currentPage = service.currentPage;
        self.totalPage = service.totalPage;
        
        if (!_orderList || [_orderList count] == 0) {
            if (self.orderStatus == 0) {
                
                self.alertLbl.text = L(@"MBTDoNotBuyTicket");
                
//                [self presentSheet:@"您尚未购买过机票！" posY:80];
            }else{
                self.alertLbl.text = L(@"MBTNoTicketForThisState");
                
//                [self presentSheet:@"该状态机票尚无" posY:80];
            }
            self.alertImageV.hidden = NO;
            self.alertLbl.hidden = NO;
        }else{
            self.alertImageV.hidden = YES;
            self.alertLbl.hidden = YES;
        }
        
        [self updateTableView];
        
    }
    else
    {
        [self presentSheet:errorMsg?errorMsg:L(@"Sorry loading failed")];
    }
    
    
}

//提示无机票信息
- (void)alertWaringMessage:(NSString *)message
{
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
    
    //    [alertView setCancelBlock:^{
    //       UINavigationController *nc = [self navigationController];
    //
    //       [nc popViewControllerAnimated:YES];
    //
    //    } ];
    
    [alertView show];
    TT_RELEASE_SAFELY(alertView);
}

- (void)updateTableView
{
    
    [self.tableView reloadData];
}

#pragma mark - CancelOrder Methods
#pragma mark - 取消订单
- (void)cancelOrder:(PFOrderBasicDTO *)dto{
    //"CacelOrder_Warning_Message"="尊敬的顾客，确定取消订单";"cancel"="取消"; "ok"="确定";
    BBAlertView *alertview = [[BBAlertView alloc] initWithTitle:nil message:L(@"CacelOrder_Warning_Message") delegate:self cancelButtonTitle:L(@"cancel") otherButtonTitles:L(@"ok")];
    
    [alertview setCancelBlock:^{
        
    }];
    
    [alertview setConfirmBlock:^{
        [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
        [self.ticketOrderService beginCancelPlanOderRequest:dto];
    }];
    
    [alertview show];
    
    TT_RELEASE_SAFELY(alertview);
    
}

- (void)endCancelOrderComplete:(PlanTicketService *)service Result:(BOOL)isSucces errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    if (isSucces) {
        [self presentSheet:L(@"BTCancel_Order_Success")];
        [self refreshData];
    }else{
        [self presentSheet:errorMsg];
    }
}

#pragma mark - repay FlightOrder
#pragma mark - 二次支付

- (void)repayOrder:(PFOrderBasicDTO *)dto{
    flightPayOrderViewController *flightPayModeViewController = [[flightPayOrderViewController alloc]initRepay];
    flightPayModeViewController.flightOrderId = dto.ordersId;
    flightPayModeViewController.flightPrice = dto.totalAmount?[NSString stringWithFormat:@"%.2f",[dto.totalAmount floatValue]]:@"0.00";
    
    if ([[self.view.superview nextResponder] isKindOfClass:[UIViewController class]]) {
        
        [((UIViewController *)self.view.superview.nextResponder).navigationController pushViewController:flightPayModeViewController animated:YES];
    }else{
        
        [self.navigationController pushViewController:flightPayModeViewController animated:YES];
    }
    
    TT_RELEASE_SAFELY(flightPayModeViewController);
    
}

#pragma mark -
#pragma mark 下拉以及加载更多

- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self sendOrderListHttpRequest];
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    [self sendOrderListHttpRequest];
}



#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法

-(PlanTicketService *)ticketOrderService
{
    if(!_ticketOrderService)
    {
        _ticketOrderService = [[PlanTicketService alloc] init];
        _ticketOrderService.delegate = self;
    }
    return _ticketOrderService;
}

- (NSMutableArray *)orderList
{
    if (!_orderList) {
        _orderList = [[NSMutableArray alloc] init];
    }
    return _orderList;
}

- (SNPopoverController *)ticketPopoverController
{
    if (!_ticketPopoverController) {
        
        _ticketPopoverController = [[SNPopoverController alloc] init];
    }
    return _ticketPopoverController;
}

- (TicketOrderFilterViewController *)filterController
{
    if (!_filterController) {
        _filterController = [[TicketOrderFilterViewController alloc] initWithFilterIndex:0];
        _filterController.delegate = self;
    }
    return _filterController;
}
@end
