//
//  NShopOrderListViewController.m
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NShopOrderListViewController.h"
#import "ShopOrderInfoCell.h"
#import "ShopOrderItemCell.h"
#import "UITableViewMoreCell.h"
#import "UITableViewCell+BgView.h"
#import "ServiceDetailViewController.h"
#import "NewOrderSnxpressViewController.h"
#import "ProductDetailViewController.h"
#import "NShopOrderDetailViewController.h"
#import "ShopSnxpressViewController.h"

#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"
#import "NProOrderLastCell.h"

#define kShopLeftButtonNomalImage       @"search_normal_new.png"
#define kShopLeftButtonHightlightImage  @"search_fouce_left.png"

#define kShopRightButtonNomalImage      @"search_normal_new.png"
#define kShopRightButtonHightlightImage @"search_fouce_right.png"

@interface NShopOrderListViewController ()

@end

@implementation NShopOrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_shopOrdeListService);
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.isLastPage = YES;
        
        self.timeRange = @"all";
        
        self.orderStatus = @"ALL";
        
        self.title = L(@"MyEBuy_StoreOrder");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];

    CGRect frame = self.view.frame ;
    
    frame.origin.y = 37;
    
    frame.size.height-=92;
    
    self.groupTableView.frame = [self setViewFrame:self.hasNav WithTab:YES];//frame;
    
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    [self.view addSubview:self.groupTableView];
     
    [self.groupTableView addSubview:self.refreshHeaderView];
    
    self.tableView = self.groupTableView;
    
//    [self.view addSubview:self.bottomView];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([self.shopOrderList count] == 0) {
        
        [self refreshData];
    }
}


- (ShopOrderListService*)shopOrdeListService
{
    if(!_shopOrdeListService)
    {
        _shopOrdeListService = [[ShopOrderListService alloc] init];
        
        _shopOrdeListService.delegate = self;
    }
    
    return _shopOrdeListService;
}

/*
-(UIImageView *)headerView{
    
    if (_headerView == nil) {
        
        _headerView = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 37)];
        
        _headerView.backgroundColor = [UIColor clearColor];
        
        _headerView.image = [UIImage imageNamed:@"search_normal_new.png"];
        
        _headerView.userInteractionEnabled = YES;
        
        [_headerView addSubview:self.leftButton];
        
        [_headerView addSubview:self.rightButton];
        
    }
    
    return _headerView;
    
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 5, 160, 32);
        [_leftButton setBackgroundImage:[UIImage imageNamed:kShopLeftButtonHightlightImage] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(shopBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = 30;
        [_leftButton setTitle:@"六个月以内" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(160, 5, 160, 32);
        [_rightButton setBackgroundImage:[UIImage imageNamed:kShopRightButtonNomalImage] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(shopBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 31;
        [_rightButton setTitle:@"全部" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _rightButton;
}
*/
/*
- (void)shopBtnAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn.tag == 30)
    {
        self.timeRange = @"halfYear";//六个月以内的订单
        
        [self.leftButton setBackgroundImage:[UIImage imageNamed:kShopLeftButtonHightlightImage] forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:kShopRightButtonNomalImage] forState:UIControlStateNormal];
        
    }
    
    else  if (btn.tag == 31)
    {
        
        self.timeRange = @"all";//全部订单
        
        [self.leftButton setBackgroundImage:[UIImage imageNamed:kShopLeftButtonNomalImage] forState:UIControlStateNormal];
        
        [self.rightButton setBackgroundImage:[UIImage imageNamed:kShopRightButtonHightlightImage] forState:UIControlStateNormal];
        
    }
    
    [self.shopOrderList removeAllObjects];
    
    [self refreshData];
}
*/
-(void)refreshData{
    
    [super refreshData];
    
    [self displayOverFlowActivityView];
    
    self.currentPage = 1;
    
    NSString *token = [UserCenter defaultCenter].userInfoDTO.custNum;
    
    NSString *currentP = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self.shopOrdeListService sendShoporderListRequest:currentP
                                              WithTime:self.timeRange WithCustNum:token
                                           orderStatus:self.orderStatus];
    
    
}

- (void)loadMoreData{
    
    [super loadMoreData];
    
    self.currentPage++;

    [self displayOverFlowActivityView];
    
    [self startMoreAnimation:YES];
    
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
    
    NSString *token = [UserCenter defaultCenter].userInfoDTO.custNum;
    
    [self.shopOrdeListService sendShoporderListRequest:pageNum
                                              WithTime:self.timeRange WithCustNum:token
                                           orderStatus:self.orderStatus];
    
}

- (UILabel*)alertLbl
{
    if(!_alertLbl)
    {
        _alertLbl = [[UILabel alloc] init];
        _alertLbl.font = [UIFont systemFontOfSize:17];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.frame = CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 60);
        _alertLbl.textAlignment = UITextAlignmentCenter;
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
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoShopOrder.png"];
        
        _alertImageV.frame = CGRectMake(122.25, self.view.frame.size.height/2-75-46, 75.5, 75);

//        _alertImageV.frame = CGRectMake(122.25, self.view.frame.size.height/2 - 15, 75.5, 75);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];

    }
    
    return _alertImageV;
}

//订单数量为0时，弹出提示信息
- (void)updateTable{
    
    if ([self.shopOrderList count] > 0)
    {
        self.alertLbl.hidden = YES;
        self.alertImageV.hidden = YES;
    }
    else{
        
        self.alertLbl.hidden = NO;
        self.alertImageV.hidden = NO;
        self.alertLbl.text = L(@"MyEBuy_NoStoreOrders");

        
 /*       if([self.orderStatus isEqualToString:@"A"]){
            
            self.alertLbl.text = @"您当前还没有已支付订单哟";
            
        }else if([self.orderStatus isEqualToString:@"B"]){
            
            self.alertLbl.text = @"您当前还没有退货处理中订单哟";
            
        }else if([self.orderStatus isEqualToString:@"C"]){
            
            self.alertLbl.text = @"您当前还没有退货完成订单哟";
            
        }else if([self.orderStatus isEqualToString:@"D"]){
            
            self.alertLbl.text = @"您当前还没有退款成功订单哟";
            
        }else if([self.orderStatus hasPrefix:@"ALL"]){
  
            self.alertLbl.text = @"您当前还没有门店订单哟";
            
        }*/
  
    }
    
	[self.groupTableView reloadData];
}



#pragma ShopOrderListServiceDelegate

- (NSMutableArray*)shopOrderList
{
    if(!_shopOrderList)
    {
        _shopOrderList = [[NSMutableArray alloc] init];
    }
    
    return _shopOrderList;
}

- (void)getShopOrderList:(BOOL)isSuccess
               errorCode:(NSString *)errorCode
             WithService:(ShopOrderListService *)service
{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        self.alertLbl.hidden = YES;
        self.alertImageV.hidden = YES;
        
        self.isLastPage = service.isLastPage;
        
        if (self.isFromHead) {
            
            [self.shopOrderList removeAllObjects];
            
            [self.shopOrderList addObjectsFromArray:service.shopOrderList];
            
            [self refreshDataComplete];
            
        }else{
            
            [self.shopOrderList addObjectsFromArray:service.shopOrderList];
            
            [self loadMoreDataComplete];
        }
        [self updateTable];
        [self refreshTable];
        
    }else{
        [self presentSheet:service.errorMsg];
    }
}

#pragma mark -
#pragma UITableView Delegate  And DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self hasMore] && [self.shopOrderList count] != 0)
    {
        return [self.shopOrderList count]+1;
    }
    else
    {
        return [self.shopOrderList count];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self hasMore] && [self.shopOrderList count] == section){
        
        return  1;
    }
    else
    {
        ShopOrderListDto *listDto = [self.shopOrderList safeObjectAtIndex:section];
        
        if([listDto.orderItemList count] > 0)
        {
            return [listDto.orderItemList count]+2;

        }
        else
        {
            return 0;
        }
        
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self hasMore] && [self.shopOrderList count]==indexPath.section){
        
        return  40;
    }
    else
    {
        ShopOrderListDto *listDto = [[ShopOrderListDto alloc] init];
        
        if([self.shopOrderList count] > indexPath.section)
        {
            listDto =[self.shopOrderList safeObjectAtIndex:indexPath.section];
            
        }
        if ([self.shopOrderList count ]> indexPath.section) {
                        
            if (indexPath.row == 0) {
                
                return 40;
                
            }
            else if(indexPath.row == [listDto.orderItemList count] + 1)
            {
                return 50;
            }
            else{
                
                return 163;
            }
        }
        
    }
    
    return 0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && [self.shopOrderList count] == indexPath.section) {
        
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier_shopOrder";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
			cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
			cell.title = L(@"loadMore");
            cell.animating = NO;
//            cell.backgroundColor = [UIColor clearColor];
//            [cell setCoolBgViewWithCellPosition:CellPositionSingle];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

		}
        
		return cell;
    }
    
    ShopOrderListDto *listDto = [[ShopOrderListDto alloc] init];
    
    if([self.shopOrderList count] > indexPath.section)
    {
        listDto =[self.shopOrderList safeObjectAtIndex:indexPath.section];
        
    }
    
    ShopOrderItemListDto *product = [[ShopOrderItemListDto alloc] init];
    
    if([listDto.orderItemList count] > indexPath.row - 1)
    {
        product = [listDto.orderItemList safeObjectAtIndex:(indexPath.row-1)];
        
    }
    if (indexPath.row == 0) {
        
        static NSString *headCell = @"NProOrderListHeadCell_shopOrder";
        
        NProOrderListHeadCell *cell = (NProOrderListHeadCell*)[tableView dequeueReusableCellWithIdentifier:headCell];
        
        if (cell == nil) {
            
            cell = [[NProOrderListHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
        }
    
        [cell refreshShopOrderInfoCell:listDto];
        
        return cell;
    }
    
    
    if (indexPath.row == [listDto.orderItemList count]+1)
    {        
        static NSString *lastCell = @"NProOrderLastCell_shopOrder";
        
        NProOrderLastCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCell];
        
        if(cell == nil)
        {
            cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCell];
            
        }
        
        ShopOrderItemListDto *productDto = [[ShopOrderItemListDto alloc] init];
        
        if([listDto.orderItemList count] > 0)
        {
            productDto = [listDto.orderItemList safeObjectAtIndex:0];
            
        }
        
        [cell refreshShopOrderCellInfo:listDto productDto:productDto];
        
        return cell;
    }
    
    static NSString *listCell = @"NProOrderProductInfoCell_shopOrder";
    
    NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:listCell];
    
    if (cell == nil) {
        
        cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    
    if ([listDto.orderItemList count] == indexPath.row) {
        
        [cell refreshCell:product orderDto:listDto cellType:BottomCell];
        
    }else{
        
        [cell refreshCell:product orderDto:listDto cellType:MiddleCell];
    }
    
    cell.clipsToBounds = YES;
    
    [cell.snxpressQueryBtn addTarget:self action:@selector(snxpressQueryBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self hasMore] && [self.shopOrderList count]== indexPath.section){
		
        [self loadMoreData];
    }

    else if(indexPath.row > 0)
    {
        
        ShopOrderListDto *listDto = [self.shopOrderList safeObjectAtIndex:indexPath.section];
        
        
        if(indexPath.row == [listDto.orderItemList count]+1)
        {
            return;
        }
        else
        {
            ShopOrderItemListDto *itemDto = [listDto.orderItemList safeObjectAtIndex:indexPath.row-1];

            NShopOrderDetailViewController *detailVC = [[NShopOrderDetailViewController alloc] init];
            
            detailVC.orderId = listDto.omsOrderId;
            detailVC.orderItemId = itemDto.omsOrderItemId;
            detailVC.orderSourceSystem = @"1";
            
            detailVC.hasNav = YES;
            detailVC.hidesBottomBarWhenPushed = YES;
            
            [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:detailVC animated:YES];
        }
        
        
        
    }

}

#pragma mark -
#pragma mark - Action
//刷新表
-(void)refreshTable{
    
    [self.groupTableView reloadData];
}

- (void)snxpressQueryBtnAction:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    /*    下单时间2013年4月1日前的订单调用接口《智能终端接口概要设计.docx》  2.15.11 线下SAP单号查询物流  传入sap单号  SNMobileLogisticsInfoView
     下单时间2013年4月1日后的订单调用接口《智能终端接口概要设计.docx》  2.15.2  送货/安装详情接口【服务易栈】 传入 omsItemId   SNIPhoneDistributionServiceDetailInfoView*/

    ShopOrderListDto *dto = [self.shopOrderList safeObjectAtIndex:indexPath.section];
    
    ShopOrderItemListDto *productDto = [dto.orderItemList safeObjectAtIndex:(indexPath.row-1)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *orderTempDate = [dateFormatter dateFromString:dto.orderDttm];
    
    NSDate *lastestDate = [dateFormatter dateFromString:@"2013-04-02 00:00:00"];

    NSComparisonResult dateComparResult = [orderTempDate compare:lastestDate];
    
    ProductListDTO *productDTO = [[ProductListDTO alloc] init];
    productDTO.productName = productDto.commodityName;
    productDTO.productCode = productDto.commodityCode;
    productDTO.productId = productDto.sourceOrderItemId;
    

    if(dateComparResult == NSOrderedAscending)
    {
        ShopSnxpressViewController *detailViewController = [[ShopSnxpressViewController alloc] init];
        
        detailViewController.salNum = productDto.sapOrderId;
        
        detailViewController.hasNav = YES;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.orderProductListDTO = productDTO;
        [((UIViewController*)self.view.superview.nextResponder).navigationController.navigationController pushViewController:detailViewController animated:YES];

    }
    else
    {
        ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc] initWithStatus:eShopOrderDelivery];
        
//http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet/SNIPhoneDistributionServiceDetailInfoView?storeId=10052&catalogId=10051&omsOrderId =6333005& omsOrderItemId =104281001
        
        detailViewController.orderItemId = productDto.omsOrderItemId;
        detailViewController.orderId = dto.omsOrderId;
        detailViewController.orderProductListDTO = productDTO;
        
        [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:detailViewController animated:YES];

        
        
    }
}



@end
