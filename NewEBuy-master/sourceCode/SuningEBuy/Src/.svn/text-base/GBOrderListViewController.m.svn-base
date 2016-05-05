//
//  GBOrderListViewController.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderListViewController.h"
#import "GBOrderListCell.h"

#import "NProOrderLastCell.h"
#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"

#import "GBSubmitDTO.h"
#import "GBPayModelViewController.h"

@implementation GBOrderListViewController
@synthesize orderState = _orderState;
@synthesize orderList = _orderList;
@synthesize filterPopoverController = _filterPopoverController;
@synthesize orderFilterViewController = _orderFilterViewController;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderList);
    TT_RELEASE_SAFELY(service);
    TT_RELEASE_SAFELY(searchTime);
    TT_RELEASE_SAFELY(orderStatusArray);
    TT_RELEASE_SAFELY(_filterPopoverController);
    TT_RELEASE_SAFELY(_orderFilterViewController);
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = L(@"PageTitleOrderList");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),L(@"PageTitleGroupLife")];
        _orderState = -1;
        currentStatus = -1;
//        isLoaded = NO;
        _orderList = [[NSMutableArray alloc]init];
        
        searchTime  = @"0";
        
        self.currentPage  =1;
        orderStatusArray =[ [NSMutableArray alloc]initWithObjects:L(@"PVWaitForPay"),L(@"Payment complete"),L(@"PVCloseTrade"),L(@"PVRefunding"), nil];
        
        service = [[GBOrderListService alloc]init];
        
        service.delegate = self;
        
        [self initRightBarButton];
        
        self.bSupportPanUI = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"GroupOrderCancel" object:Nil];
    }
    return self;
}

- (GBOrderFilterViewController *)orderFilterViewController{
    if (!_orderFilterViewController) {
        _orderFilterViewController =  [[GBOrderFilterViewController alloc]initWithStatusList:orderStatusArray];
        
        _orderFilterViewController.delegate = self;
    }
    
    return  _orderFilterViewController;
}

- (SNPopoverController *)filterPopoverController{
    if (!_filterPopoverController) {
        
        _filterPopoverController  = [[SNPopoverController alloc]initWithContentController:self.orderFilterViewController];
        CGRect frame = _filterPopoverController.blackLayerFrame;
        frame.size.height+=49;
        _filterPopoverController.blackLayerFrame = frame;
        _filterPopoverController.popoverSize = CGSizeMake(230, 240);
    }
    
    return _filterPopoverController;
}

- (void)pickFilter:(id *)sender{
    
   // [self changeRightBarButton];
    
    [self.filterPopoverController presentAnimated:YES];
}

- (void)initRightBarButton
{
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Filter")];
//    UIBarButtonItem *filterPickButton = [[UIBarButtonItem alloc]
//                                         initWithTitle:L(@"Filter")
//                                         style:UIBarButtonItemStylePlain
//                                         target:self
//                                         action:@selector(pickFilter:)];
//    
//    self.navigationItem.rightBarButtonItem = filterPickButton;
//    
//    TT_RELEASE_SAFELY(filterPickButton);
}

- (void)righBarClick
{
    [self pickFilter:nil];
}

- (void)backForePage
{
    [self backToFore:nil];
}

- (void)initBackItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToFore:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:L(@"BTBack") forState:UIControlStateNormal];
    
    
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"public_blue_leftBarButtonItem.png"] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    

    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBar;
    
    TT_RELEASE_SAFELY(backBar);
    
    TT_RELEASE_SAFELY(backButton);
}

- (void)backToFore:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    
    for (UIView *view in widow.subviews) {
        
        if (view.tag == 9777) {
            
            [view removeFromSuperview];
            
            break;
            
        }
    }

}
- (void)changeRightBarButton
{
    UIView *rightBarButttonsView = [[UIView alloc] initWithFrame:CGRectMake(320 - kUINavigationBarFrameHeight*2, 0, kUINavigationBarFrameHeight*2, kUINavigationBarFrameHeight)];
    
    UIButton *expandBtn = [[UIButton alloc] initWithFrame:CGRectMake(kUINavigationBarFrameHeight, 0, kUINavigationBarFrameHeight, kUINavigationBarFrameHeight)];
    [expandBtn addTarget:self action:@selector(pickFilter:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *expandIndicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 27, 27)];
    expandIndicatorView.image = [UIImage imageNamed:@"GB_navigationitem_expand_icon"];
    [expandBtn setBackgroundImage:[UIImage streImageNamed:@"GB_navigationitem_backgroud.png"] forState:UIControlStateNormal];
    [expandBtn addSubview:expandIndicatorView];
    TT_RELEASE_SAFELY(expandIndicatorView);
    [rightBarButttonsView addSubview:expandBtn];
    TT_RELEASE_SAFELY(expandBtn);
    UIBarButtonItem *custumItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButttonsView];
    TT_RELEASE_SAFELY(rightBarButttonsView);
    self.navigationItem.rightBarButtonItem = custumItem;
    TT_RELEASE_SAFELY(custumItem);
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:YES showTabBar:NO];

    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - kUINavigationBarFrameHeight;
    
//    self.tableView.frame = frame;
    
    self.groupTableView.frame = [self setViewFrame:self.hasNav WithTab:YES];//[self visibleBoundsShowNav:YES showTabBar:YES];
    
    self.groupTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.groupTableView addSubview:self.refreshHeaderView];
    
    self.tableView = self.groupTableView;
    
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self initBackItem];
    
    if (!isLoaded) {
        
        [self displayOverFlowActivityView];
        
        [service beginGetGBOrderList:_orderState withSearchTime:searchTime withCurrentPage:currentPage];
        
    }
    
    [self.tableView reloadData];
}

#pragma  mark -
#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && [_orderList count] == indexPath.section)
    {
        return 48;
    }
    
    if(indexPath.row == 0)
    {
        return 40;
    }
    else if(indexPath.row == 1)
    {
        GBOrderInfoDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];

        return [NProOrderProductInfoCell setGroupOrderListCellHeight:dto];
    }
    else
    {
        return 50;
    }
    
    return  0.001;//[GBOrderListCell  height:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self hasMore]) {
        
        return  [_orderList count]+1;
    }
    return  [_orderList count];
//    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self hasMore] && [_orderList count] == section) {
        
        return  1;
    }
    return  3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    
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

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.00001)];
    
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSInteger  row = indexPath.row;
    if ([self hasMore] && [_orderList count] == indexPath.section ) {
        
        static NSString *OrderListMoreIdentifier = @"OrderListMoreIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:OrderListMoreIdentifier];
		
		if (cell == nil) {
			
            cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderListMoreIdentifier];
            
            cell.title = @"Get More...";
            
            cell.animating = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;            
        }
        cell.animating = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    
    GBOrderInfoDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];

    switch (indexPath.row) {
        case 0:
        {
            static NSString *headCell = @"NProOrderListHeadCell_group";
            
            NProOrderListHeadCell *cell = (NProOrderListHeadCell*)[tableView dequeueReusableCellWithIdentifier:headCell];
            
            if (cell == nil) {
                
                cell = [[NProOrderListHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            
            [cell setGroupOrderListCell:dto];
            
            return cell;

        }
            break;
            
        case 1:
        {
            static NSString *listCell = @"NProOrderProductInfoCell_group";
            
            NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:listCell];
            
            if (cell == nil) {
                
                cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            
            [cell setGroupOrderListCell:dto];
            
            cell.clipsToBounds = YES;
            
            return cell;
        }
            break;

        case 2:
        {
            static NSString *lastCell = @"NProOrderLastCell_group";
            
            NProOrderLastCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCell];
            
            if(cell == nil)
            {
                cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCell];
                
            }
            
            [cell setGroupOrderListCell:dto];
            
            [cell.payBtn addTarget:self action:@selector(payOrder:event:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;

        }
            break;

            
        default:
            break;
    }
    
//    static NSString *OrderListItemCellIdentifier = @"OrderListItemCellIdentifier";
    
//    GBOrderListCell *cell =(GBOrderListCell *)[tableView dequeueReusableCellWithIdentifier:OrderListItemCellIdentifier];
//    
//    if (cell  == nil)
//    {
//        cell = [[GBOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderListItemCellIdentifier];
//    }
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
//    GBOrderInfoDTO *dto = [self.orderList objectAtIndex:row];
//    
//    DLog(@"%@",dto.snProAmount);
//    
//    cell.item = dto;
    
    return [[UITableViewCell alloc] init];
}

- (GBOrderInfoDTO*)infoDto
{
    if(!_infoDto)
    {
        _infoDto = [[GBOrderInfoDTO alloc] init];
    }
    
    return _infoDto;
}

//付款
- (void)payOrder:(id)sender event:(id)event
{
    
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    GBOrderInfoDTO *infodto = [self.orderList safeObjectAtIndex:indexPath.section];

    GBSubmitDTO *dto = [[GBSubmitDTO alloc] init];
    dto.orderId = infodto.orderId;
    dto.eppAmount = infodto.orderAmount;
    dto.payAmount = infodto.orderAmount;
    dto.gbType = infodto.gbType;
    dto.snProId = infodto.snProId;
    GBPayModelViewController *gbModel = [[GBPayModelViewController alloc] init];
    gbModel.gbSubmitDto = dto;
    gbModel.gbSubmitDto.snProName = infodto.snProName;
    gbModel.isFormOrder = YES;
    [((UINavigationController*)self.view.superview.nextResponder).navigationController pushViewController:gbModel animated:YES];
    
}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (([self hasMore] &&  [self.orderList count]== indexPath.row) || (![self hasMore] && (([self.orderList count]-1)== indexPath.row)) ) {
        //do nothing
    }else{
        
        UIImageView *separatorLine = (UIImageView *)[cell.contentView viewWithTag:10000];
        
        if (separatorLine == nil) {
            separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, [GBOrderListCell  height:nil]-1, 320, 2)];
            separatorLine.tag = 10000;
            separatorLine.image = [UIImage imageNamed:@"GB_seperatLine.png"];
            
            [cell.contentView addSubview:separatorLine];
        }
        
        separatorLine.frame = CGRectMake(10, [GBOrderListCell  height:nil]-1, 300, 2);
        
        
    }
    
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSInteger row = [indexPath row];
    
    if ([self hasMore] && [self.orderList count] == indexPath.section) {
        
        if (self.isLoading) {
            
            return;
        }
        
        [self loadMoreData];
        
    }else
    {
        if(indexPath.row == 1)
        {
            GBOrderInfoDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
            
            self.infoDto = dto;
            
            GBOrderDetailViewController *vc = [[GBOrderDetailViewController alloc]initWithOrderInfo:dto];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [((UINavigationController*)self.view.superview.nextResponder).navigationController pushViewController:vc animated:YES];
            TT_RELEASE_SAFELY(vc);

        }
        
    }
    
}
#pragma mark -
#pragma mark - OrderStatusFilterDlegate

- (void)filterSelectOk:(NSInteger)selectIndex{
    
    _orderState = selectIndex -1;
    
    [self refreshData];
}



#pragma mark -
#pragma mark - GBOrderListServiceDelegate

- (void)getGBOrderListCompleted:(BOOL)isSuccess orderList:(NSMutableArray *)list page:(NSMutableArray *)page errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        
        [self refreshDataComplete];
    }else{
        
        [self loadMoreDataComplete];
    }
    
    if (currentStatus != _orderState) {
        
        TT_RELEASE_SAFELY(_orderList);
        
        _orderList = [[NSMutableArray alloc]init];
    }
    self.totalPage  = [[page safeObjectAtIndex:4]integerValue];
    
    self.currentPage = [[page safeObjectAtIndex:2]integerValue];
    
    if (self.currentPage <self.totalPage) {
        
        self.isLastPage = NO;
    }else{
        self.isLastPage = YES;
    }
    
    if (isSuccess) {
        
        currentStatus = _orderState;
        isLoaded = YES;
        
        if ([list isKindOfClass:[NSArray class]]) {
            if (self.isFromHead) {
                self.orderList = list;
            }
            else{
                if (!_orderList) {
                    _orderList = [[NSMutableArray alloc]init];
                }
                
                [self.orderList addObjectsFromArray:list];
            }
        }
        if (!_orderList || [_orderList count] == 0){
            
            [self updateTable];
        }
        
        
    }
    else{
        //[self updateTable];
         [self presentSheet:L(errorMsg)];
        
    }
    [self.tableView reloadData];
    
}


- (void)updateTable{
    
    switch (self.orderState) {
        case -1:
        {
            self.alertPageFreshLbl.hidden = NO;
            self.alertPageFreshImageV.hidden = NO;
            self.alertPageFreshLbl.text = L(@"LBNoOrderRecode");
//            [self presentSheet:@"您没有订单记录！"];

            return;
        }
            break;
            
        case 0:
        {
            
            self.alertPageFreshLbl.text = L(@"LBNoOrderToBePaid");
//            [self presentSheet:@"您没有等待付款的订单！"];
            
        }

            break;
            
        case 1:
        {
            self.alertPageFreshLbl.text = L(@"LBNoPaidOrder");
//            [self presentSheet:@"您没有支付完成的订单！"];

        }
            break;

        case 3:
        {
            self.alertPageFreshLbl.text = L(@"LBNoClosedOrder");
//            [self presentSheet:@"您没有交易关闭的订单！"];
            
        }
            break;
            
        case 4:
        {
            self.alertPageFreshLbl.text = L(@"LBNoRefundingOrder");
//            [self presentSheet:@"您没有退款中的订单！"];
            
        }
            break;
            
        default:
            break;
    }
    
    self.alertPageFreshLbl.hidden = YES;
    self.alertPageFreshImageV.hidden = YES;
}
#pragma mark -
#pragma mark 下拉以及加载更多
-(void)refreshData{
    
    [super refreshData];
    
    self.currentPage = 1;
    
    [self displayOverFlowActivityView];
    
    [service beginGetGBOrderList:_orderState withSearchTime:searchTime withCurrentPage:self.currentPage];
}

- (void)loadMoreData{
    
    [super loadMoreData];
    
    self.currentPage++;
    [self displayOverFlowActivityView];
    
    [service beginGetGBOrderList:_orderState withSearchTime:searchTime withCurrentPage:self.currentPage];
}

- (BOOL)hasMore{
    
    if (self.isLastPage) {
        
        return NO;
    }
    
    return YES;
}

@end
