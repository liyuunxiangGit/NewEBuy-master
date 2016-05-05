//
//  NOrderListViewController.m
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NOrderListViewController.h"
#import "NOrderListCell.h"
#import "NewOrderListDTO.h"
#import "NOrderHeadCell.h"
#import "UITableViewMoreCell.h"
#import "payFlowDTO.h"
#import "NewOrderSnxpressViewController.h"
#import "ServiceDetailViewController.h"
#import "ProductDetailViewController.h"
#import "UITableViewCell+BgView.h"
#import "ShopSnxpressViewController.h"

@implementation NOrderListViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_secondPayService);
    SERVICE_RELEASE_SAFELY(_detailService);
    SERVICE_RELEASE_SAFELY(_service);
    SERVICE_RELEASE_SAFELY(_serviceDetailService);
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.isReturn = NO;
        
        self.isLastPage = YES;
        
        isLoadOk = NO;
        
        self.isGetDetailData = NO;
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"secondPaySuccess" object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:CANCEL_ORDER_OK_MESSAGE object:nil];
    }
    return self;
}
/*- (id)initWithOrderType:(OrderListType)orderListType{
 
 self = [super init];
 
 if (self) {
 
 self.title = @"待支付订单";
 
 self.orderListType = orderListType;
 
 self.timeRange = @"oneMonth";
 
 self.isReturn = NO;
 
 self.isLastPage = YES;
 
 isLoadOk = NO;
 
 self.isGetDetailData = NO;
 
 if (self) {
 
 switch (orderListType) {
 
 case OrderPayed:
 {
 //                    self.title = @"已支付订单";
 self.orderStatus = @"C";
 break;
 }
 case OrderWaitPay:{
 //                    self.title = @"待支付订单";
 self.orderStatus = @"M";
 break;
 }
 case OrderDelivery:{
 //                    self.title = @"发货处理中订单";
 self.orderStatus = @"W";
 break;
 }
 case OrderCanceled:{
 //                    self.title = @"已取消订单";
 self.orderStatus = @"X";
 break;
 }
 case OrderReturned:{
 //                    self.title = @"退货成功订单";
 self.orderStatus = @"R";
 break;
 }
 case OrderShippped:{
 //                    self.title = @"已发货订单";
 self.orderStatus = @"C000";
 break;
 }
 case OrderReceipt:{
 //                    self.title = @"收货完成订单";
 self.orderStatus = @"C010,C015";
 break;
 }
 case OrderAll:{
 //                    self.title = @"全部订单";
 self.orderStatus = @"A";
 break;
 }
 
 default:
 break;
 }
 
 self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:CANCEL_ORDER_OK_MESSAGE object:nil];
 }
 }
 
 return self;
 }*/

- (NSMutableArray*)orderList
{
    if(!_orderList)
    {
        _orderList = [[NSMutableArray alloc]init];
        
    }
    
    return _orderList;
    
}

//订单选择类型
- (void)setSelectOrderStytle:(OrderListType)orderListType
{
    
    //已支付订单／待支付订单／发货处理中订单/已取消订单／退货成功订单／已发货订单／收货完成订单/全部订单
    switch (orderListType) {
            
        case OrderPayed:
        {
            //            self.title = @"已支付订单";
            self.orderStatus = @"C";
            break;
        }
        case OrderWaitPay:{
            //            self.title = @"待支付订单";
            self.orderStatus = @"M";
            break;
        }
        case OrderDelivery:{
            //            self.title = @"发货处理中订单";
            self.orderStatus = @"W";
            break;
        }
        case OrderCanceled:{
            //            self.title = @"已取消订单";
            self.orderStatus = @"X";
            break;
        }
        case OrderReturned:{
            //            self.title = @"退货成功订单";
            self.orderStatus = @"R";
            break;
        }
        case OrderShippped:{
            //            self.title = @"已发货订单";
            self.orderStatus = @"C000";
            break;
        }
        case OrderReceipt:{
            //            self.title = @"收货完成订单";
            self.orderStatus = @"C010,C015";
            break;
        }
        case OrderAll:{
            //            self.title = @"全部订单";
            self.orderStatus = @"A";
            break;
        }
            
        default:
            break;
    }
    
}

//订单选择时间段
- (void)setSelectTime:(OrderListTime)orderTime
{
    switch (orderTime) {
        case OrderOneWeek:
        {
            self.timeRange = @"oneMonth";
            
        }
            break;
        case OrderOneMonth:
        {
            self.timeRange = @"halfYear";
            
        }
            break;
        case OrderTimeAll:
        {
            self.timeRange = @"all";
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame ;
    
    frame.origin.y = 50;
    
    frame.size.height-=142;
    
    self.groupTableView.frame = frame;
    
    [self.view addSubview:self.groupTableView];
    
    [self.groupTableView addSubview:self.refreshHeaderView];
    
    self.tableView = self.groupTableView;
        
    //xmy 2013-11-21
    [self.view addSubview:self.headView];
    
    self.orderSelectDownVC.view.hidden = YES;
    [self.view addSubview:self.orderSelectDownVC.view];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([self.orderList count] == 0) {
        
        [self refreshData];
    }
}

- (UIView*)headView
{
    if(!_headView)
    {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        
        _headView.backgroundColor = [UIColor clearColor];
        
        [_headView addSubview:self.orderStytleBtn];
        
        [_headView addSubview:self.timeBtn];
    }
    
    return _headView;
}

- (void)setBtnPropetry:(UIButton*)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    [btn addTarget:self action:@selector(downSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor = [UIColor clearColor];
    
}

- (UIButton*)orderStytleBtn
{
    if(!_orderStytleBtn)
    {
        _orderStytleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self setBtnPropetry:_orderStytleBtn];
        
        [_orderStytleBtn setTitle:L(@"MyEBuy_AllOrders") forState:UIControlStateNormal];
        
        [_orderStytleBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectDown.png"] forState:UIControlStateNormal];
        
        _orderStytleBtn.frame = CGRectMake(10, 10, 145, 30);
        
        _orderStytleBtn.tag = 1;
        
    }
    
    return _orderStytleBtn;
}

- (UIButton*)timeBtn
{
    if(!_timeBtn)
    {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self setBtnPropetry:_timeBtn];
        
        [_timeBtn setTitle:L(@"MyEBuy_NearlyOneMonth") forState:UIControlStateNormal];
        
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectDown.png"] forState:UIControlStateNormal];
        
        _timeBtn.frame = CGRectMake(165, 10, 145, 30);
        
        _timeBtn.tag = 2;
        
    }
    
    return _timeBtn;
}

#pragma mark -
#pragma  下拉按钮触发事件
-(void)btnsImage
{
    [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectDown.png"] forState:UIControlStateNormal];
    [self.orderStytleBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectDown.png"] forState:UIControlStateNormal];
    
}

- (void)downSelectBtnAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
        
    if(btn.tag == 1)
    {
        self.orderSelectDownVC.isTime = NO;
        self.orderSelectDownVC.backView.frame = CGRectMake(10, 44, 145, 260);
        self.orderSelectDownVC.tableView.frame = CGRectMake(1, 20, 143, 236);;
        [self.orderStytleBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectUp.png"] forState:UIControlStateNormal];
        
    }
    else if(btn.tag == 2)
    {
        self.orderSelectDownVC.isTime = YES;
        self.orderSelectDownVC.backView.frame = CGRectMake(165, 44, 145, 110);
        self.orderSelectDownVC.tableView.frame = CGRectMake(1, 20, 143, 86);;
        [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectUp.png"] forState:UIControlStateNormal];
        
    }
    
    [self.view bringSubviewToFront:self.orderSelectDownVC.view];
    
    self.orderSelectDownVC.view.hidden = NO;
    
    [self.orderSelectDownVC.tableView reloadData];
}

- (OrderSelectDownViewController*)orderSelectDownVC
{
    if(!_orderSelectDownVC)
    {
        _orderSelectDownVC = [[OrderSelectDownViewController alloc] initWithIsOnlineOrder:YES];
        
        _orderSelectDownVC.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height);
        
//        _orderSelectDownVC.isOnlineOrder = 1;

        _orderSelectDownVC.delegate = self;
        
    }
    return _orderSelectDownVC;
}

#pragma mark -
#pragma  OrderSelectDownDelegate
- (void)selectedOrderStyleOrTime:(NSString *)str WithRow:(NSInteger)row
{
    if(self.orderSelectDownVC.isTime == YES)
    {
        [self.timeBtn setTitle:str forState:UIControlStateNormal];
        [self setSelectTime:row];
        
        [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectDown.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.orderStytleBtn setTitle:str forState:UIControlStateNormal];
        
        [self setSelectOrderStytle:row];
        
        [self.orderStytleBtn setBackgroundImage:[UIImage imageNamed:@"Order_selectDown.png"] forState:UIControlStateNormal];
        
    }
    
    [self.orderList removeAllObjects];
    [self refreshTable];
    
    [self refreshData];
}

#pragma mark -
#pragma mark 获取订单列表接口
- (NOrderListService *)service
{
    if (!_service)
    {
        _service = [[NOrderListService alloc]init];
        _service.delegate = self;
    }
    return _service;
}

-(void)orderListService:(NOrderListService *)service
              isSuccess:(BOOL)isSuccess{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        self.isLastPage = service.isLastPage;
        
        if (self.isFromHead) {
            
            [self.orderList removeAllObjects];
            
            [self.orderList addObjectsFromArray:service.orderList];
            
            [self refreshDataComplete];
            
        }else{
            
            [self.orderList addObjectsFromArray:service.orderList];
            
            [self loadMoreDataComplete];
        }
        [self updateTable];
        [self refreshTable];
        
    }else{
        
        [self presentSheet:service.errorMsg];
    }
}

- (UILabel*)alertLbl
{
    if(!_alertLbl)
    {
        _alertLbl = [[UILabel alloc] init];
        _alertLbl.font = [UIFont systemFontOfSize:17];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 60);
        _alertLbl.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:_alertLbl];
    }
    return _alertLbl;
}

//订单数量为0时，弹出提示信息
- (void)updateTable{
    
    if ([self.orderList count] > 0)
    {
        self.alertLbl.hidden = YES;
    }
    else{
        
        self.alertLbl.hidden = NO;
        
        
        if([self.orderStatus isEqualToString:@"C"] || [self.orderStatus isEqualToString:@"SC"] || [self.orderStatus isEqualToString:@"SD"] || [self.orderStatus isEqualToString:@"WD"] || [self.orderStatus isEqualToString:@"SOMED"]){
            
            self.alertLbl.text = L(@"no paid order now");
            
        }else if([self.orderStatus isEqualToString:@"M"]){
            
            self.alertLbl.text = L(@"no order wating to be paid now");
            
        }else if([self.orderStatus isEqualToString:@"X"]){
            
            self.alertLbl.text = L(@"no canceled order now");
            
        }else if([self.orderStatus isEqualToString:@"R"]){
            
            self.alertLbl.text = L(@"no return order now");
            
        }else if([self.orderStatus isEqualToString:@"C000"]){
            
            self.alertLbl.text = L(@"MyEBuy_NoDeliveredOrders");
            
            
        }else if([self.orderStatus hasPrefix:@"C010"] || [self.orderStatus hasPrefix:@"C015"]){
            
            self.alertLbl.text = L(@"MyEBuy_NoReceiptedOrders");
            
        }
        else if([self.orderStatus isEqualToString:@"W"]){
            
            self.alertLbl.text = L(@"MyEBuy_NoProcessingOrders");
            
            
        }else if([self.orderStatus hasPrefix:@"A"]){
            
            self.alertLbl.text = L(@"MyEBuy_NoOrders");
            
        }
        
        
    }
    
    
    
	[self.groupTableView reloadData];
}


#pragma mark -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self hasMore] && [_orderList count] > 0) {
        
        return ([_orderList count]+1);
        
    }else{
        
        return [_orderList count];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self hasMore] && [_orderList count] == section) {
        
        return 1;
    }
    
    if ([_orderList count ]> section) {
        
        NewOrderListDTO *dto = [_orderList safeObjectAtIndex:section];
        
        return ([dto.productList count]+1);
        
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && [_orderList count] == indexPath.section) {
        
        return 40;
        
    }
    
    if ([_orderList count ]> indexPath.section) {
        
        NewOrderListDTO *dto = [_orderList safeObjectAtIndex:indexPath.section];
        
        if (indexPath.row == 0) {
            
            return 70;
            
        }else{
            
            if([self.orderStatus isEqualToString:@"H"] || [self.orderStatus isEqualToString:@"X"] || [self.orderStatus isEqualToString:@"r"] || [self.orderStatus isEqualToString:@"G"] || [self.orderStatus isEqualToString:@"R"])
            {
                return 80;//已退货，已取消订单无按钮行
                
            }
            else if([self.orderStatus isEqualToString:@"A"])
            {
                if ([dto.oiStatus isEqualToString:@"H"] || [dto.oiStatus isEqualToString:@"X"] || [dto.oiStatus isEqualToString:@"r"] || [dto.oiStatus isEqualToString:@"G"] || [dto.oiStatus isEqualToString:@"R"])
                {
                    
                    return 80;//已退货，已取消订单无按钮行
                    
                }
                else if([dto.oiStatus hasPrefix:@"M"])
                {
                    //                    if(IsStrEmpty(dto.supplierCode))
                    //                    {//自营
                    if([dto.ormOrder isEqualToString:@"11601"] || [dto.ormOrder isEqualToString:@"11701"])
                    {
                        return 120;//自营：货到付款和门店支付订单有按钮行
                        
                    }
                    else
                    {
                        return 80;//自营：其他类型订单有按钮行，但是显示在上面，商品行下不显示
                        
                    }
                    /*
                     //                    }
                     //                    else
                     //                    {//c店：M状态订单有按钮行且显示在商品行下，以商家个数为单位显示按钮行
                     //                        int row = indexPath.row;
                     //
                     //                            ProductListDTO *productDTO = [dto.productList objectAtIndex:row-1];
                     //
                     //                            ProductListDTO *productDTONext = [[ProductListDTO alloc] init];
                     //
                     //                            if([dto.productList count] > row)
                     //                            {
                     //                               productDTONext = [dto.productList objectAtIndex:row];
                     //
                     //                            }
                     //
                     //                        //c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                     //                        if(productDTO.supplierCode != productDTONext.supplierCode)
                     //                        {
                     //                            return 120;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                     //
                     //                        }
                     //                        else
                     //                        {
                     //                            return 80;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行，其余不显示
                     //                        }
                     //
                     //                    }*/
                    
                }
                else
                {
//                    return 120;
                    if(IsStrEmpty(dto.supplierCode))
                    {
                        return 120;
                        
                    }
                    else
                    {
                        //c店：M状态订单有按钮行且显示在商品行下，以商家个数为单位显示按钮行
                        int row = indexPath.row;
                        
                        ProductListDTO *productDTO = [dto.productList safeObjectAtIndex:row-1];
                        
                        ProductListDTO *productDTONext = [[ProductListDTO alloc] init];
                        
                        if([dto.productList count] > row)
                        {
                            productDTONext = [dto.productList safeObjectAtIndex:row];
                            
                        }
                        
                        //c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                        if(productDTO.supplierCode != productDTONext.supplierCode)
                        {
                            return 120;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                            
                        }
                        else
                        {
                            return 80;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行，其余不显示
                        }
                        
                    }

                }
            }
            else
            {
                if([dto.oiStatus hasPrefix:@"M"])
                {
                    //                    if(IsStrEmpty(dto.supplierCode))
                    //                    {
                    if([dto.ormOrder isEqualToString:@"11601"] || [dto.ormOrder isEqualToString:@"11701"])
                    {
                        return 120;//自营：货到付款和门店支付订单有按钮行
                        
                    }
                    else
                    {
                        return 80;
                        
                    }
                    /*
                     //                    }
                     //                    else
                     //                    {
                     //                        //c店：M状态订单有按钮行且显示在商品行下，以商家个数为单位显示按钮行
                     //                        int row = indexPath.row;
                     //
                     //                        ProductListDTO *productDTO = [dto.productList objectAtIndex:row-1];
                     //
                     //                        ProductListDTO *productDTONext = [[ProductListDTO alloc] init];
                     //
                     //                        if([dto.productList count] > row)
                     //                        {
                     //                            productDTONext = [dto.productList objectAtIndex:row];
                     //
                     //                        }
                     //
                     //                        if(productDTO.supplierCode != productDTONext.supplierCode)
                     //                        {
                     //                            return 120;
                     //
                     //                        }
                     //                        else
                     //                        {
                     //                            return 80;
                     //                        }
                     //                    } */
                    
                }
                else
                {
                    if(IsStrEmpty(dto.supplierCode))
                    {
                        return 120;
                                               
                    }
                    else
                    {
                        //c店：M状态订单有按钮行且显示在商品行下，以商家个数为单位显示按钮行
                        int row = indexPath.row;
                        
                        ProductListDTO *productDTO = [dto.productList safeObjectAtIndex:row-1];
                        
                        ProductListDTO *productDTONext = [[ProductListDTO alloc] init];
                        
                        if([dto.productList count] > row)
                        {
                            productDTONext = [dto.productList safeObjectAtIndex:row];
                            
                        }
                        
                        //c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                        if(productDTO.supplierCode != productDTONext.supplierCode)
                        {
                            return 120;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                            
                        }
                        else
                        {
                            return 80;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行，其余不显示
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && [_orderList count] == indexPath.section) {
        
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
			cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
			cell.title = L(@"loadMore");
            cell.animating = NO;
            cell.backgroundColor = [UIColor cellBackViewColor];
            [cell setCoolBgViewWithCellPosition:CellPositionSingle];
		}
        
		return cell;
    }
    
    NewOrderListDTO *dto = [_orderList safeObjectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        static NSString *headCell = @"headCell";
        
        NOrderHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell];
        
        if (cell == nil) {
            
            cell = [[NOrderHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
            
        }
        
        if (IsStrEmpty(dto.supplierCode)) {
            
            [cell refreshCell:dto WithIsCshop:NO];
            
        }
        else
        {
            [cell refreshCell:dto WithIsCshop:YES];
            
        }
        
        
        [cell.payBtn addTarget:self action:@selector(HeadCancelOrPayBtn:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.payBtn.tag = 101;
        
        [cell.cancelOrderBtn addTarget:self action:@selector(HeadCancelOrPayBtn:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.cancelOrderBtn.tag = 102;
        
        
        return cell;
    }
    
    static NSString *listCell = @"listCell";
    
    NOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    
    if (cell == nil) {
        
        cell = [[NOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
    }
    
    ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    if ([dto.productList count] == indexPath.row) {
        
        [cell refreshCell:product orderDto:dto cellType:BottomCell listOrderStatus:self.orderStatus];
        
    }else{
        
        [cell refreshCell:product orderDto:dto cellType:MiddleCell listOrderStatus:self.orderStatus];
    }
    
    cell.clipsToBounds = YES;
    
    [cell.snxpressQueryBtn addTarget:self action:@selector(snxpressQueryBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.payBtn addTarget:self action:@selector(cancelOrPayBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.payBtn.tag = 201;
    
    [cell.cancelOrderBtn addTarget:self action:@selector(cancelOrPayBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.cancelOrderBtn.tag = 202;
    
    [cell.iconImageView addTarget:self action:@selector(imageViewDidOkClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


- (void)imageViewDidOkClicked:(id)tap event:(id)event
{
    
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint:currentTouchPosition];
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    DataProductBasic *dtoData = [[DataProductBasic alloc] init];
    dtoData.productId = product.productId;
    dtoData.productCode = product.productCode;
    dtoData.productName = product.productName;
    dtoData.shopCode = product.supplierCode;
    
    ProductDetailViewController *productController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dtoData];
    
    
    [self.navigationController pushViewController:productController animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSInteger row = [indexPath section];
	
    if([self hasMore] && [self.orderList count] == row){
        
		[self loadMoreData];
        
		return;
		
	}
    else if(indexPath.row > 0)
    {
        MemberOrderNamesDTO *memberDto = [[MemberOrderNamesDTO alloc] init];
        
        NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
        
        ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
        
        memberDto.orderId = dto.orderId;
        memberDto.cShopName = product.supplierName;
        memberDto.supplierCode = product.supplierCode;
        
        
        OrderDetailViewController  *orderDetailVC =  [[OrderDetailViewController alloc]initWithDTO:memberDto];
        
        orderDetailVC.orderSt = self.orderStatus;
        
        orderDetailVC.supplierCode = product.supplierCode;
        
        orderDetailVC.supplierName = product.supplierName;
        
        if(IsStrEmpty(memberDto.supplierCode))
        {
            orderDetailVC.isCShopProduct = NO;
            
        }
        else
        {
            
            orderDetailVC.isCShopProduct = YES;
            
        }
        
        orderDetailVC.isFinishAccept = [dto isFinishAcceptOK:product.finishAccept];        
        orderDetailVC.isDelivery = [dto isDelivityOK:product.omsStatus];

        [self.navigationController pushViewController:orderDetailVC animated:YES];
        
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
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *productDto = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    if(IsStrEmpty(productDto.supplierCode))
    {
        ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
        
        detailViewController.orderId = dto.orderId;
        detailViewController.orderItemId = productDto.orderItemId;

        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
    else
    {
        NewOrderSnxpressViewController *snxpressViewController = [[NewOrderSnxpressViewController alloc] initWithStatus:eCShopDeliveryNew];
        
        snxpressViewController.orderId = dto.orderId;
        
        snxpressViewController.cShopCode = productDto.supplierCode;
        
        [self.navigationController pushViewController:snxpressViewController animated:YES];
        
    }
    
}
//- (void)snxpressQueryBtnActionZIYING:(id)sender event:(id)event
//{
//    NSSet *touches = [event allTouches ];
//
//    UITouch *touch = [touches anyObject ];
//
//    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
//
//    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
//
//
//    NewOrderListDTO *dto = [self.orderList objectAtIndex:indexPath.section];
//    ProductListDTO *product = [dto.productList objectAtIndex:(indexPath.row-1)];
//
//    ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
//
//    detailViewController.orderId = dto.orderId;
//    detailViewController.orderItemId = product.orderItemId;
//
//    [self.navigationController pushViewController:detailViewController animated:YES];
//
//    TT_RELEASE_SAFELY(detailViewController);
//
//}
#pragma mark -
#pragma mark 分页
-(void)refreshData{
    
    [super refreshData];
    
    self.currentPage = 1;
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self displayOverFlowActivityView];
    
    [self.service beginGetOrderListHttpRequest:userId
                                   currentPage:pageNum
                                   orderStatus:self.orderStatus
                                    selectTime:self.timeRange];
    
}

-(void)loadMoreData{
    
    [super loadMoreData];
    
    self.currentPage++;
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self displayOverFlowActivityView];
    
    [self.service beginGetOrderListHttpRequest:userId
                                   currentPage:pageNum
                                   orderStatus:self.orderStatus
                                    selectTime:self.timeRange];
}

- (void)HeadCancelOrPayBtn:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    self.selectIndexPath = indexPath;
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
    self.orderId = dto.orderId;
    //    self.orderItemId = product.orderItemId;
    self.supplierCode = dto.supplierCode;
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 101:
        {
            self.isSecondPayDetail = YES;
            self.isCancelorderDetail = NO;
            [self secondPay:indexPath];
            
        }
            break;
        case 102:
        {
            self.isCancelorderDetail = YES;
            self.isSecondPayDetail = NO;
            
            [self cancelOrder:indexPath];
            
        }
            
        default:
            break;
    }
    
}

- (void)cancelOrPayBtn:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    self.selectIndexPath = indexPath;
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    self.orderId = dto.orderId;
    self.supplierCode = product.supplierCode;
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 201:
        {
            self.isSecondPayDetail = YES;
            self.isCancelorderDetail = NO;
            [self secondPay:indexPath];
            
        }
            break;
        case 202:
        {
            self.isCancelorderDetail = YES;
            self.isSecondPayDetail = NO;
            
            [self cancelOrder:indexPath];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark 订单取消

- (OrderDetailService*)detailService
{
    if(!_detailService)
    {
        _detailService = [[OrderDetailService alloc] init];
        
        _detailService.delegate = self;
    }
    
    return _detailService;
}



//取消订单，发送订单取消请求

//- (void)cancelOrder
//{
//    //非货到付款，取消订单
//    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
//                                                    message:@"确认取消订单吗？"
//                                                   delegate:nil
//                                          cancelButtonTitle:L(@"Cancel")
//                                          otherButtonTitles:L(@"Ok")];
//    [alert setConfirmBlock:^{
//
//        NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
//
//        [self displayOverFlowActivityView:@"订单取消中..."];
//        [self setRightNavItemEnable:NO];
//
//        [self.detailService beginSendCancelOrderHttpRequest:userId orderId:self.orderId];
//
//    }];
//    [alert show];
//}

- (void)cancelOrder:(NSIndexPath *)indexPath
{
    //非货到付款，取消订单
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:L(@"MyEBuy_AreYouSureToCancelOrder")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    [alert setConfirmBlock:^{
        
        
        self.isGetDetailData = NO;
        [self displayOverFlowActivityView:L(@"MyEBuy_OrderCanceling")];
        
        //发送详情请求
        [self.detailService beginSendOrderDetailDTOHttpRequest:self.orderId WithCode:self.supplierCode];
        
    }];
    [alert show];
    
    
    
}


- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0 && alertView.tag ==21)
    {
        //回订单中心
        NSArray *viewControllers = [self.navigationController viewControllers];
        NSInteger index = [viewControllers indexOfObject:self]-2;
        if (index >= 0) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        
        }
    }
}

- (void)orderCancelHttpRequestCompletedWith: (BOOL)isSucess
                                   errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSucess == YES) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CANCEL_ORDER_OK_MESSAGE object:nil];
        
        BBAlertView *alertView = [[BBAlertView alloc]initWithTitle:nil
                                                           message:L(@"Cancel Order Success!")
                                                          delegate:self
                                                 cancelButtonTitle:L(@"Ok")
                                                 otherButtonTitles:nil];
        
        alertView.tag = 21;
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
        [self refreshData];
        
        
    }
    else
    {
        [self presentCustomDlg:errorMsg?errorMsg:L(@"Cancel Order Failed!")];
    }
    [self setRightNavItemEnable:YES];
}
- (void)setRightNavItemEnable:(BOOL)isEnable
{
    self.navigationItem.rightBarButtonItem.enabled = isEnable;
}


#pragma mark -
#pragma mark services

- (SecondPayService *)secondPayService
{
    if (!_secondPayService) {
        _secondPayService = [[SecondPayService alloc] init];
        _secondPayService.delegate = self;
    }
    return _secondPayService;
}


#pragma mark -
#pragma mark 二次支付
- (MemberOrderDetailsDTO*)secondDto
{
    if(!_secondDto)
    {
        _secondDto = [[MemberOrderDetailsDTO alloc] init];
    }
    return _secondDto;
}
- (void)secondPay:(NSIndexPath *)indexPath
{
    self.isGetDetailData = NO;
    [self displayOverFlowActivityView:L(@"MyEBuy_SecondPreparing")];
    
    //发送详情请求
    [self.detailService beginSendOrderDetailDTOHttpRequest:self.orderId WithCode:self.supplierCode];
    
}

//详情回调方法
- (void)orderDetailDTOHttpRequestCompletedWith:(NSArray *)orderDetailList
                                  ordeNamesDto:(MemberOrderNamesDTO *)ordeNamesDto
                                      isSucess: (BOOL) isSuccess
                                     errorCode: (NSString *)errorCode
                                    WithCSList:(NSArray *)CSList
                                  WithHeadList:(NSArray *)headList
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        self.isGetDetailData = YES;
        self.orderDetailDisplayLists = orderDetailList;//自营商品
//        CShopOrderListDTO *tmpList = [[CShopOrderListDTO alloc] init];
//        tmpList = [CSList safeObjectAtIndex:0];
//
        if (IsArrEmpty(CSList)) {
            for (int i = 0; i < [CSList count]; i++)
            {
                CShopOrderListDTO *tmpDto = [CSList objectAtIndex:i];
                if (IsArrEmpty(tmpDto.itemList))
                {
                    for (int j = 0;j < [tmpDto.itemList count] ; j++)
                    {
                        
                        MemberOrderDetailsDTO *tmpMemberDto = [tmpDto.itemList objectAtIndex:j];
                        if (j != [tmpDto.itemList count] - 1) {
                            tmpMemberDto.isconfirmReceipt = nil;
                        }
                        [self.CSLists addObject:tmpMemberDto];
                    }
                }
            }
            
        }

        
//        self.CSLists = tmpList.itemList;//c店商品
        self.detailHeadLists = headList;//详情head
        
        [self detailDatasGet:self.selectIndexPath];
        
        if(self.isSecondPayDetail == YES)
        {
            //            [self displayOverFlowActivityView:@"二次支付校验中..."];
            [self setRightNavItemEnable:NO];
            [self.secondPayService beginSecondPayOrderCheckWithOrderId:self.orderId];
        }
        
        
        
        if(self.isCancelorderDetail == YES)
        {
            NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
            
            //            [self displayOverFlowActivityView:@"订单取消中..."];
            [self setRightNavItemEnable:NO];
            
            [self.detailService beginSendCancelOrderHttpRequest:userId orderId:self.orderId];
            
        }
        
        
        
    }else{
        [self presentSheet:errorCode];
    }
}

//详情数据
- (void)detailDatasGet:(NSIndexPath*)indexPath
{
    MemberOrderNamesDTO *nameDto = [self.detailHeadLists safeObjectAtIndex:0];
    
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if(IsStrEmpty(nameDto.supplierCode))
    {
        if([self.orderDetailDisplayLists count] > 0)
        {
            detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
            
        }
        
    }
    else
    {
        if([self.CSLists count] > 0)
        {
            detailDto = [self.CSLists safeObjectAtIndex:0];
            
        }
        
    }
    
    self.secondDto = detailDto;
    
}

- (void)secondPayCheckCompletionWithResult:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg
                                    payDto:(payFlowDTO *)payDTO
{
    [self removeOverFlowActivityView];
    [self setRightNavItemEnable:YES];
    
    if (isSuccess) {
        
        //        MemberOrderDetailsDTO *detailDto = [self.orderDetailDisplayLists objectAtIndex:0];
        
        if(self.isGetDetailData == YES)
        {
            ShipMode mode = [self.secondDto.currentShipModeType isEqualToString:L(@"MyEBuy_Delivery")]?ShipModeSuningSend:ShipModeSelfTake;
            
            
            PaymentModeViewController *payController =
            [[PaymentModeViewController alloc] initWithPayFlowDTO:payDTO
                                                      andShipMode:mode];
            payController.isSecondPay = YES;
            [self.navigationController pushViewController:payController animated:YES];
        }
        
        
        
    }else{
        
        [self presentSheet:errorMsg];
    }
}



@end
