//
//  ProOrderListViewController.m
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ProOrderListViewController.h"

#import "NProOrderLastCell.h"
#import "NewOrderListDTO.h"
#import "NProOrderProductInfoCell.h"
#import "UITableViewMoreCell.h"
#import "MemberOrderNamesDTO.h"
#import "NProOrderListHeadCell.h"
#import "OrderDetailViewController.h"
#import "MemberOrderNamesDTO.h"
#import "MemberOrderDetailsDTO.h"
#import "ProductDetailViewController.h"
#import "NewOrderSnxpressViewController.h"
#import "ServiceDetailViewController.h"

#import "MobilePayQueryViewController.h"
#import "ActiveEfubaoViewController.h"
#import "ConfirmReceiptWebViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "EvalutionContentViewController.h"
#import "ProductDisOrderSubmitViewController.h"


@interface ProOrderListViewController () <NProOrderListHeadCellDelegate>
{
    BOOL isCShopShopPayOrder;
}
@property (nonatomic,strong) NewOrderListDTO *toDeleteOrderBean;
@property (nonatomic,assign) BOOL     isLoad;
@end

@implementation ProOrderListViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_orderListservice);
    SERVICE_RELEASE_SAFELY(_secondPayService);
    SERVICE_RELEASE_SAFELY(_detailService);
    SERVICE_RELEASE_SAFELY(_serviceDetailService);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
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

- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.groupTableView.frame = [self setViewFrame:self.hasNav WithTab:YES];
    
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.groupTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    
    [self.groupTableView addSubview:self.refreshHeaderView];
    
    self.tableView = self.groupTableView;
    
    [self.view addSubview:self.groupTableView];
    
}


- (id)initWithOrderStatus:(NSString*)str
{
    self = [super init];
    
    if(self)
    {
        self.title = L(@"MyEBuy_GoodsOrder");
        
        self.isLastPage = YES;
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        self.isSecondPayDetail = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshTable)
                                                     name:@"secondPaySuccess"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshTable)
                                                     name:CANCEL_ORDER_OK_MESSAGE
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshTable)
                                                     name:RETURN_GOODS_OK_MESSAGE
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ReceiptConfirmSuccess)
                                                     name:RECEIPT_CONFIRM_SUCCESS
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(activedJumpConfirmGoods)
                                                     name:@"BackConfirmGoods" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(evalutionSuccess) name:@"SuccessEvalution" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shaidanSuccess) name:@"shaidanSuccess" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DisplayOrderOrEvaluationSucessRefresh) name:@"DisplayOrderOrEvaluationSucessRefresh" object:nil];

        self.orderStatus = str;
        
        self.CSLists = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([self.orderList count] == 0 || self.isLoadOrderListData == YES) {
        
        [self refreshData];
    }
}


#pragma mark -
#pragma mark 分页
-(void)refreshData{
    
    [super refreshData];
    
    self.currentPage = 1;
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self displayOverFlowActivityView];
    
    [self.orderListservice beginGetOrderListHttpRequest:userId
                                            currentPage:pageNum
                                            orderStatus:self.orderStatus
                                             selectTime:@"all"];
    
    
}
-(void)loadMoreData{
    
    [super loadMoreData];
    
    if (self.isLoad) {
        
        self.isLoad = NO;
        self.currentPage++;
        NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
        NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
        [self.orderListservice beginGetOrderListHttpRequest:userId
                                                currentPage:pageNum
                                                orderStatus:self.orderStatus
                                                selectTime:@"all"];
        [self setTableFooterView];
    }
    
    
//    [self.orderListservice beginGetOrderListHttpRequest:userId
//                                            currentPage:pageNum
//                                            orderStatus:self.orderStatus
//                                             selectTime:@"all"];
//    
//    [self setTableFooterView];
}

- (NOrderListService*)orderListservice
{
    if(!_orderListservice)
    {
        _orderListservice = [[NOrderListService alloc] init];
        
        _orderListservice.delegate = self;
    }
    
    return _orderListservice;
}

- (NSMutableArray*)orderList
{
    if(!_orderList)
    {
        _orderList = [[NSMutableArray alloc]init];
        
    }
    
    return _orderList;
    
}

- (void)refreshDataComplete {
    [super refreshDataComplete];
    
    [self removeTableFooterView];
}

- (void)loadMoreDataComplete {
    [super loadMoreDataComplete];
    
    [self removeTableFooterView];
}

#pragma NOrderListServiceDelegate
-(void)orderListService:(NOrderListService *)service
              isSuccess:(BOOL)isSuccess{
    
    [self removeOverFlowActivityView];
    self.isLoad = YES;
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
        
        _alertImageV.frame = CGRectMake(116.5, self.view.frame.size.height/2-76-46, 77, 76);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];
        
    }
    
    return _alertImageV;
}

//订单数量为0时，弹出提示信息
- (void)updateTable{
    
    if ([self.orderList count] > 0)
    {
        self.alertLbl.hidden = YES;
        self.alertImageV.hidden = YES;
    }
    else{
        
        self.alertLbl.hidden = NO;
        self.alertImageV.hidden = NO;
        
        if(self.selectType == eProductOrderList)
        {
            if([self.orderStatus isEqualToString:@"M"] )
            {
                self.alertLbl.text = L(@"MyEBuy_NoWaitingForPayOrders");
                
            }
            else if([self.orderStatus isEqualToString:@"MB_C"])
            {
                self.alertLbl.text = L(@"MyEBuy_NoWaitingForReceiveOrders");
                
            }
            else
            {
                self.alertLbl.text = L(@"MyEBuy_NoGoodsOrders");
                
            }
            
        }
        else if(self.selectType == eShopOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoStoreOrders");
            
        }
        else if(self.selectType == eMobileFeeOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoRechargeOrders");
            
        }
        else if(self.selectType == eCaiPiaoOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoLotteryOrders");
            
        }
//        else if(self.selectType == eTuanGouOrderList)
//        {
//            self.alertLbl.text = @"您当前还没有团购订单哟";
//            
//        }
        else if(self.selectType == eWaterOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoWaterFeePaymentOrders");
            
        }
        else if(self.selectType == eElectricOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoElectricityFeePaymentOrders");
            
        }
        else if(self.selectType == eGasOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoGasFeePaymentOrders");
            
        }
        else if(self.selectType == ePlaneOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoTicketOrders");
            
        }
        else if(self.selectType == eHotelOrderList)
        {
            self.alertLbl.text = L(@"MyEBuy_NoHotelOrders");
            
        }
        
    }
    
    [self refreshTable];
}

//刷新表
-(void)refreshTable{
    
    [self.groupTableView reloadData];
}

#pragma mark -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.orderList count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:section];
//    return dto.productList.count;
    
    if ([self hasMore] && [self.orderList count] == section) {
        
        return 1;
    }
    
    if ([self.orderList count ]> section) {
        
        NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:section];
        
        return ([dto.productList count]+1);
        
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([self hasMore] && [self.orderList count] == indexPath.section) {
//        
//        return 0;
//        
//    }
//    
//    if ([self.orderList count ]> indexPath.section) {
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
    if (indexPath.row == 0)
    {
        
        return 75;
        
    }
    //        else if(indexPath.row == [dto.productList count]+1)
    //        {
    //            return 50;
    //        }
    else
    {
        ProductListDTO *productListDto = [dto.productList safeObjectAtIndex:indexPath.row - 1];
        if (productListDto.isShowShopName) {
            return 150;
        }
        else
        {
            return 115;
        }
        /*
         if ([dto.oiStatus isEqualToString:@"H"] ||
         [dto.oiStatus isEqualToString:@"X"] ||
         [dto.oiStatus isEqualToString:@"r"] ||
         [dto.oiStatus isEqualToString:@"G"] ||
         [dto.oiStatus isEqualToString:@"R"] )
         {
         
         return 110;//已退货，已取消订单无按钮行
         
         }
         else if([dto.oiStatus hasPrefix:@"M"])
         {
         
         //                if([dto.ormOrder isEqualToString:@"11601"] || [dto.ormOrder isEqualToString:@"11701"])
         //                {
         //                    return 163;//自营：货到付款和门店支付订单有按钮行
         //
         //                }
         //                else
         //                {
         //                    return 110;//自营：其他类型订单有按钮行，但是显示在上面，商品行下不显示
         //
         //                }
         if([dto.ormOrder isEqualToString:@"11601"])
         {
         return 163;//自营：货到付款和门店支付订单有按钮行
         
         }
         else
         {
         return 110;//自营：其他类型订单有按钮行，但是显示在上面，商品行下不显示
         
         }
         
         }
         else if([dto.oiStatus hasPrefix:@"e"])
         {
         return 110;
         }
         else
         {
         ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
         
         if(IsStrEmpty(product.supplierCode))
         {
         return 163;
         
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
         return 163;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
         
         }
         else
         {
         return 110;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行，其余不显示
         }
         
         }
         
         }*/
        
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([self hasMore] && [_orderList count] == indexPath.section) {
//        
//        static NSString *MoreCellIdentifier = @"MoreCellIdentifierNew";
//        
//        UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
//        
//        if (cell == nil) {
//            cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
//        }
//        return cell;
//    }
//    
    
    NewOrderListDTO *dto = [_orderList safeObjectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        ProductListDTO *productDto = [dto.productList safeObjectAtIndex:0];
        static NSString *headCell = @"NProOrderListHeadCell-0";
        
        NProOrderListHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell];
        
        if (cell == nil) {
            
            cell = [[NProOrderListHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        if (IsStrEmpty(dto.supplierCode)) {
            
            [cell setNProOrderListHeadCellInfo:dto WithIsCshop:NO productDto:productDto];
            
        }
        else
        {
            [cell setNProOrderListHeadCellInfo:dto WithIsCshop:YES productDto:productDto];
            
        }
        [cell.payBtn addTarget:self action:@selector(HeadCancelOrPayBtn:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.payBtn.tag = 101;
        [cell.cancelOrderBtn addTarget:self action:@selector(HeadCancelOrPayBtn:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.cancelOrderBtn.tag = 102;
        
        return cell;
    }
    
    static NSString *listCell = @"NProOrderProductInfoCell-1";
    
    NProOrderProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    
    if (cell == nil) {
        
        cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    int rowInt = indexPath.row - 2;
    
    ProductListDTO *productDTONext = [[ProductListDTO alloc] init];
    
    if([dto.productList count] > rowInt) {
        productDTONext = [dto.productList safeObjectAtIndex:rowInt];
    }
    
    if ([dto.productList count] == indexPath.row) {
        
        [cell setNProOrderProductInfoCell:product orderDto:dto cellType:BottomCell withRow:indexPath.row];
        
    }else{
        
        [cell setNProOrderProductInfoCell:product orderDto:dto cellType:MiddleCell withRow:indexPath.row];
    }
    
    cell.clipsToBounds = YES;
    
    //c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
    if(![product.supplierCode eq:productDTONext.supplierCode] &&
       product.canConfirmAcceptPro == YES && !IsStrEmpty(product.supplierCode))
    {
        cell.confirmAcceptBtn.hidden = NO;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
        cell.orderStatusLbl.hidden = YES;
    }
    else
    {
        cell.confirmAcceptBtn.hidden = YES;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行，其余不显示
        
    }
    [cell.confirmAcceptBtn addTarget:self action:@selector(confirmAcceptBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.snxpressQueryBtn addTarget:self action:@selector(snxpressQueryBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.iconImageView addTarget:self action:@selector(imageViewDidOkClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.pingjiaBtn addTarget:self action:@selector(pingJiaBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.shaidanBtn addTarget:self action:@selector(displayOrderBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.bothBtn addTarget:self action:@selector(commentAndShowBtn:event:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSInteger row = [indexPath section];
    
//    if([self hasMore] && [self.orderList count] == row){
//        
//        [self loadMoreData];
//        
//        return;
//        
//    }
    if(indexPath.row > 0)
    {
        self.currentRow = indexPath.row - 1;
        self.currentSection = indexPath.section;
        MemberOrderNamesDTO *memberDto = [[MemberOrderNamesDTO alloc] init];
        
        NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
        
        if(indexPath.row == [dto.productList count]+1)
        {
            return;
        }
        else
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"720202"], nil]];
            ProductListDTO *product = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
            
            if ([product.supplierOrderStatus eq:@"r"]) {
                [self displayOverFlowActivityView];
                isReturnStatus = YES;
                //发送详情请求
                [self.detailService beginSendOrderDetailDTOHttpRequest:dto.orderId WithCode:product.supplierCode];
            }
            else if (([product.supplierOrderStatus eq:@"M"] || [product.supplierOrderStatus eq:@"M1"] || [product.supplierOrderStatus eq:@"M2"])
                 && [dto.ormOrder eq:@"11701"] && !IsStrEmpty(product.supplierCode) ) {
                [self displayOverFlowActivityView];
                isCShopShopPayOrder = YES;
                //发送详情请求
                [self.detailService beginSendOrderDetailDTOHttpRequest:dto.orderId WithCode:product.supplierCode];

            }
            else
            {
                memberDto.orderId = dto.orderId;
                memberDto.cShopName = product.supplierName;
                memberDto.supplierCode = product.supplierCode;
                
                OrderDetailViewController  *orderDetailVC =  [[OrderDetailViewController alloc]initWithDTO:memberDto];
                orderDetailVC.isFromOrderListEntry = YES;
                
                orderDetailVC.orderSt = product.supplierOrderStatus;
                
                orderDetailVC.supplierCode = product.supplierCode;
                
                orderDetailVC.supplierName = product.supplierName;
                orderDetailVC.orderItemsId = product.orderItemId;
                //            orderDetailVC.orderItemIdDic = self.orderItemIdDic;
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
                
                orderDetailVC.hasNav = YES;
                orderDetailVC.hidesBottomBarWhenPushed = YES;
                
                [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:orderDetailVC animated:YES];
                
            }
            
            //
        }
    }
    
}

#pragma Btns Actions

- (void)imageViewDidOkClicked:(id)tap event:(id)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"720201"], nil]];
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
    
    
    [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:productController animated:YES];
    
}
#pragma mark - 确认收货功能 测试wap支付页
- (void)confirmAcceptBtnAction:(id)sender event:(id)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"720205"], nil]];
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    self.selectSection = indexPath.section;
    self.selectRow = indexPath.row;
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
//    ProductListDTO *productDto = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    self.orderId = dto.orderId;
    self.supplierCode = dto.supplierCode;
    
    
    [self isActiveEFuBao];
}
//激活易付宝
- (void)activeAction
{
    NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if ([emailTest evaluateWithObject:logonName]) {
        [self presentSheet:L(@"MyEBuy_PleaseGoToWebsiteToActivateEmailAccount")];
        
        return;
    }
    ActiveEfubaoViewController *controller = [[ActiveEfubaoViewController alloc] init];
    
    [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:controller animated:YES];
}

#pragma mark - 物流查询
- (void)snxpressQueryBtnAction:(id)sender event:(id)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"720204"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *productDto = [dto.productList safeObjectAtIndex:(indexPath.row-1)];
    
    if(IsStrEmpty(productDto.supplierCode))
    {
        ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc] initWithStatus:eOrderCenterDelivery];
        
        detailViewController.orderId = dto.orderId;
        detailViewController.orderItemId = productDto.orderItemId;
        
        detailViewController.verificationCode = @"";
        detailViewController.orderListDTO = dto;
        detailViewController.orderProductListDTO = productDto;
        [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:detailViewController animated:YES];
        
    }
    else
    {
        NewOrderSnxpressViewController *snxpressViewController = [[NewOrderSnxpressViewController alloc] initWithStatus:eCShopDeliveryNew];
        
        snxpressViewController.orderId = dto.orderId;
        
        snxpressViewController.cShopCode = productDto.supplierCode;
        
        snxpressViewController.hasNav = YES;
        snxpressViewController.hidesBottomBarWhenPushed = YES;
        snxpressViewController.isOrderDetailLogisticsQuery  = NO;
        
        [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:snxpressViewController animated:YES];
        
    }
    
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
#pragma mark 评价按钮响应
- (void)pingJiaBtnAction:(id)sender event:(id)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730305"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    NewOrderListDTO *dto = [_orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *productDto = [[ProductListDTO alloc] init];
    
    if([dto.productList count] > 0)
    {
        productDto = [dto.productList objectAtIndex:indexPath.row - 1];
        
        //            _memberOrderDetailsDTO = detailDto;
    }

    if(IsStrEmpty(dto.supplierCode))
    {
        self.evaDetailDto.supplierName = L(@"MyEBuy_SuningSelf");
    }
    else
    {
        self.evaDetailDto.supplierName = productDto.supplierName;
    }
    
    self.dto.orderId = dto.orderId;
    self.dto.orderTime = dto.lastUpdate;
    
    self.evaDetailDto.orderItemId = productDto.orderItemId;
    self.evaDetailDto.partNumber = productDto.productCode;
    self.evaDetailDto.catentryId = productDto.productId;
    self.evaDetailDto.productUrl = [ProductUtil getImageUrlWithProductCode:productDto.productCode size:ProductImageSize120x120];
    self.evaDetailDto.catentryName = productDto.productName;
    
    [self displayOverFlowActivityView];
    [self.evalutionService beginEvalutionValidate:productDto.orderItemId];

}

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

- (EvalutionDetailDTO*)evaDetailDto
{
    if(!_evaDetailDto)
    {
        _evaDetailDto = [[EvalutionDetailDTO alloc] init];
    }
    
    return _evaDetailDto;
}

- (EvalutionDTO*)dto
{
    if(!_dto)
    {
        _dto = [[EvalutionDTO alloc] init];
    }
    
    return _dto;
}



- (void)evalutionValidateCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (isEvalutionAndShowPhoto == YES) {
            isEvalutionAndShowPhoto = NO;
            EvaluationAndDisplayProductPictureViewController *vc = [[EvaluationAndDisplayProductPictureViewController alloc] initWithDTO:_displayorderMemMemberOrderDetailsDTO isMember:NO];
            vc.evalutionDto = self.evaDetailDto;
            vc.evalDto = self.dto;
            vc.showReviewStatus = self.evalutionService.showReviewStatus;
            
            vc.evalutionDto.orderItemId = self.shaiDanDetailsDTO.orderItemId;
            vc.evalutionDto.catentryId = self.shaiDanDetailsDTO.productId;
            
            if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
                
                vc.evalutionDto.productUrl = [ProductUtil getImageUrlWithProductCode:self.shaiDanDetailsDTO.productCode size:ProductImageSize160x160];
            }
            else{
                
                vc.evalutionDto.productUrl = [ProductUtil getImageUrlWithProductCode:self.shaiDanDetailsDTO.productCode size:ProductImageSize120x120];
            }
            
            //             productSubmitViewController.evalutionDto.partNumber = self.shaiDanDetailsDTO.productCode;
            vc.evalutionDto.catentryName = self.shaiDanDetailsDTO.productName;
            

            vc.showPJOrSD = @"0";//默认显示评价
            vc.hasNav = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:vc animated:YES];

        }
        else
        {
            //        self.isOrderDetailLoaded = NO;
            EvalutionContentViewController *next = [[EvalutionContentViewController alloc] init];
            next.evalutionDto = self.evaDetailDto;
            next.evalDto = self.dto;
            next.showReviewStatus = self.evalutionService.showReviewStatus;
            next.hasNav = YES;
            next.hidesBottomBarWhenPushed = YES;
            [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:next animated:YES];
        }
    }else{
        [self presentSheet:errorMsg];
        isEvalutionAndShowPhoto = NO;
    }
}

- (void)evalutionSuccess
{
    self.isLoadOrderListData = YES;
}



#pragma mark -
#pragma mark 晒单按钮响应
- (void)displayOrderBtn:(id)sender event:(id)event{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730306"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    NewOrderListDTO *dto = [_orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *productDto = [[ProductListDTO alloc] init];
    
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if([dto.productList count] > 0)
    {
        productDto = [dto.productList objectAtIndex:indexPath.row - 1];//商品行从第二行开始
        
        //---------是否能晒单接口传参需要---------------
        detailDto.orderItemId = productDto.orderItemId;
        detailDto.productId = productDto.productId;
        //-----------------end----------------------
        
        _displayorderMemMemberOrderDetailsDTO = detailDto;
    }

    self.shaiDanDetailsDTO = productDto;
        
    self.isSubmitDisOrder = NO;
    
    [self.displayorderService checkURPhotoExistsHttpRequest:detailDto isSubmitDisOrder:self.isSubmitDisOrder isOrderDetailLoad:NO];
    
}

- (ProductDetailSubmitService *)displayorderService
{
    if (!_displayorderService) {
        _displayorderService = [[ProductDetailSubmitService alloc] init];
        _displayorderService.delegate = self;
    }
    return _displayorderService;
}

-(void)CheckURPhotoExistsHttpRequestCompleteWithService:(BOOL)isSubmitDisOrder
                                      isOrderDetailLoad:(BOOL)isOrderDetailLoad
                                              isSuccess:(BOOL)isSuccess
                                               errorMsg:(NSString*)errorMsg
{
    if(isSuccess)
    {
        self.isSubmitDisOrder=isSubmitDisOrder;
//        self.isOrderDetailLoaded=isOrderDetailLoad;
        
        if (self.isSubmitDisOrder) {
            
            ProductDisOrderSubmitViewController *productSubmitViewController = [[ProductDisOrderSubmitViewController alloc] initWithDTO:_displayorderMemMemberOrderDetailsDTO isMember:NO];
            
            
            productSubmitViewController.evalutionDto.orderItemId = self.shaiDanDetailsDTO.orderItemId;
            productSubmitViewController.evalutionDto.catentryId = self.shaiDanDetailsDTO.productId;
            
            if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
                
                productSubmitViewController.evalutionDto.productUrl = [ProductUtil getImageUrlWithProductCode:self.shaiDanDetailsDTO.productCode size:ProductImageSize160x160];
            }
            else{
                
                productSubmitViewController.evalutionDto.productUrl = [ProductUtil getImageUrlWithProductCode:self.shaiDanDetailsDTO.productCode size:ProductImageSize120x120];
            }
            
            //             productSubmitViewController.evalutionDto.partNumber = self.shaiDanDetailsDTO.productCode;
            productSubmitViewController.evalutionDto.catentryName = self.shaiDanDetailsDTO.productName;
            
            
            productSubmitViewController.hasNav = YES;
            productSubmitViewController.hidesBottomBarWhenPushed = YES;
            
            [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:productSubmitViewController animated:YES];
            
            TT_RELEASE_SAFELY(productSubmitViewController);
        }else {
            [self presentSheet:L(@"Please Don't repeat Display Order") posY:100];
        }
    }
    else
    {
        [self presentSheet:errorMsg?errorMsg:kServerBusyErrorMsg posY:100];
    }
}

- (void)shaidanSuccess
{
    self.isLoadOrderListData = YES;
}

#pragma mark -
#pragma mark 评价晒单按钮响应
- (void)commentAndShowBtn:(id)sender event:(id)event
{
    isEvalutionAndShowPhoto = YES;
    
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    NewOrderListDTO *dto = [_orderList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *productDto = [[ProductListDTO alloc] init];
    
    if([dto.productList count] > 0)
    {
        productDto = [dto.productList objectAtIndex:indexPath.row - 1];
        
        //            _memberOrderDetailsDTO = detailDto;
    }
    
    if(IsStrEmpty(dto.supplierCode))
    {
        self.evaDetailDto.supplierName = L(@"MyEBuy_SuningSelf");
    }
    else
    {
        self.evaDetailDto.supplierName = productDto.supplierName;
    }
    
    self.dto.orderId = dto.orderId;
    self.dto.orderTime = dto.lastUpdate;
    
    self.evaDetailDto.orderItemId = productDto.orderItemId;
    self.evaDetailDto.partNumber = productDto.productCode;
    self.evaDetailDto.catentryId = productDto.productId;
    self.evaDetailDto.productUrl = [ProductUtil getImageUrlWithProductCode:productDto.productCode size:ProductImageSize120x120];
    self.evaDetailDto.catentryName = productDto.productName;
    
    //---------------晒单---------------------
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if([dto.productList count] > 0)
    {
//        productDto = [dto.productList objectAtIndex:indexPath.row - 1];//商品行从第二行开始
        
        //---------是否能晒单接口传参需要---------------
        detailDto.orderItemId = productDto.orderItemId;
        detailDto.productId = productDto.productId;
        //-----------------end----------------------
        
        _displayorderMemMemberOrderDetailsDTO = detailDto;
    }
    
    self.shaiDanDetailsDTO = productDto;
    
    self.isSubmitDisOrder = NO;
    //---------------end--------------------

    
    [self displayOverFlowActivityView];
    [self.evalutionService beginEvalutionValidate:productDto.orderItemId];

}

- (void)DisplayOrderOrEvaluationSucessRefresh
{
    self.isLoadOrderListData = YES;
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
- (void)cancelOrder:(NSIndexPath *)indexPath
{
    //非货到付款，取消订单
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:L(@"MyEBuy_AreYouSureToCancelOrder")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    [alert setConfirmBlock:^{
        
        self.clickConfirm = NO;
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
            
            [((UIViewController*)self.view.superview.nextResponder).navigationController popToRootViewControllerAnimated:YES];
            
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
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"720203"], nil]];
    self.clickConfirm = NO;
    self.isGetDetailData = NO;
    [self displayOverFlowActivityView:L(@"MyEBuy_PaymentPreparing")];
    
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
        if (isCShopShopPayOrder == YES) {
            isCShopShopPayOrder = NO;
            [self creatOrderDetailViewController:orderDetailList ordeNamesDto:ordeNamesDto isSucess:isSuccess errorCode:errorCode WithCSList:CSList WithHeadList:headList];
        }
        if (isReturnStatus == YES) {
            isReturnStatus = NO;
            [self creatOrderDetailViewController:orderDetailList ordeNamesDto:ordeNamesDto isSucess:isSuccess errorCode:errorCode WithCSList:CSList WithHeadList:headList];
        }
        else
        {
            self.isGetDetailData = YES;
            self.isLoadOrderListData = NO;
            self.orderDetailDisplayLists = orderDetailList;//自营商品
            //        CShopOrderListDTO *tmpList = [[CShopOrderListDTO alloc] init];
            //        tmpList = [CSList safeObjectAtIndex:0];
            
            if ( [ordeNamesDto.oiStatus isEqualToString:@"C"] ||
                [ordeNamesDto.oiStatus isEqualToString:@"D"] ||
                [ordeNamesDto.oiStatus isEqualToString:@"E"] ||
                [ordeNamesDto.oiStatus isEqualToString:@"SC"] ||
                [ordeNamesDto.oiStatus isEqualToString:@"SD"] ||
                [ordeNamesDto.oiStatus isEqualToString:@"SOMED"] ||
                [ordeNamesDto.oiStatus isEqualToString:@"WD"])
            {
                if (!IsArrEmpty(CSList)) {
                    [self.CSLists removeAllObjects];
                    for (int i = 0; i < [CSList count]; i++)
                    {
                        CShopOrderListDTO *tmpDto = [CSList objectAtIndex:i];
                        if (!IsArrEmpty(tmpDto.itemList))
                        {
                            for (int j = 0;j < [tmpDto.itemList count] ; j++)
                            {
                                
                                MemberOrderDetailsDTO *tmpMemberDto = [tmpDto.itemList objectAtIndex:j];
                                if (j != [tmpDto.itemList count] - 1) {
                                    tmpMemberDto.isconfirmReceipt = @"NONONO";
                                }
                                [self.CSLists addObject:tmpMemberDto];
                            }
                        }
                    }
                    
                }
                [self.orderItemIdArr removeAllObjects];
                [self.keyArr removeAllObjects];
                
                NSString *orderItemIdTmp = nil;
                BOOL isEnterArr = NO;
                //        self.orderItemIdDic = [[NSMutableDictionary alloc] init];
                for (CShopOrderListDTO *dto in CSList) {
                    if ([dto.itemList count] > 1) {
                        for (int i = 0; i < [dto.itemList count]; i ++) {
                            MemberOrderDetailsDTO *tmpMemberDto = [dto.itemList objectAtIndex:i];
                            if (i == 0) {
                                orderItemIdTmp = tmpMemberDto.orderItemId;
                            }
                            else
                            {
                                orderItemIdTmp = [NSString stringWithFormat:@"%@_%@",orderItemIdTmp,tmpMemberDto.orderItemId];
                            }
                            if ([tmpMemberDto.isconfirmReceipt isEqualToString:@"true"]) {
                                isEnterArr = YES;
                            }
                            else
                            {
                                isEnterArr = NO;
                            }
                        }
                    }
                    else
                    {
                        MemberOrderDetailsDTO *tmpMemberDto = [dto.itemList safeObjectAtIndex:0];
                        orderItemIdTmp = tmpMemberDto.orderItemId;
                        if ([tmpMemberDto.isconfirmReceipt isEqualToString:@"true"]) {
                            isEnterArr = YES;
                        }
                        else
                        {
                            isEnterArr = NO;
                        }
                        
                    }
                    //            for (int j = 0; j < [self.CSLists count]; j++) {
                    //                MemberOrderDetailsDTO *tmpMemberDto = [self.CSLists objectAtIndex:j];
                    //                if ([tmpMemberDto.isconfirmReceipt isEqualToString:@"true"]) {
                    //                    [self.orderItemIdDic setObject:orderItemIdTmp forKey:[NSString stringWithFormat:@"%d",j]];
                    //
                    //                }
                    //            }
                    
                    if (isEnterArr == YES) {
                        [self.orderItemIdArr addObject:orderItemIdTmp];
                    }
                    //                [self.orderItemIdArr addObject:orderItemIdTmp];
                }
                for (int j = 0; j < [self.CSLists count]; j++) {
                    MemberOrderDetailsDTO *tmpMemberDTO = [self.CSLists safeObjectAtIndex:j];
                    if ([tmpMemberDTO.isconfirmReceipt isEqualToString:@"true"]) {
                        [self.keyArr addObject:[NSString stringWithFormat:@"%d",j]];
                    }
                }
                for (int i = 0; i < [self.keyArr count]; i ++) {
                    if (!IsArrEmpty(self.keyArr) && !IsArrEmpty(self.orderItemIdArr)) {
                        [self.orderItemIdDic setObject:[self.orderItemIdArr safeObjectAtIndex:i] forKey:[self.keyArr safeObjectAtIndex:i]];
                    }
                    
                }
                
                
            }
            else
            {
                self.CSLists = [[NSMutableArray alloc] initWithArray:CSList];
            }
            
            
            
            //        self.CSLists = tmpList.itemList;//c店商品
            self.detailHeadLists = headList;//详情head
            
            [self detailDatasGet:self.selectIndexPath];
            
            if(self.clickConfirm == YES)
            {
                self.clickConfirm = NO;
                //确认收货功能，若包裹数大于1则跳转至订单详情页，否则直接到确认收货wap页
                MemberOrderNamesDTO *memberDto = [[MemberOrderNamesDTO alloc] init];
                //            OrderDetailDto *memberDto = [[OrderDetailDto alloc] init];
                
                NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:self.selectSection];
                
                ProductListDTO *product = [dto.productList safeObjectAtIndex:(self.selectRow-1)];
                
                if([CSList count] > 1)
                {
                    memberDto.orderId = dto.orderId;
                    memberDto.cShopName = product.supplierName;
                    memberDto.supplierCode = product.supplierCode;
                    
                    OrderDetailViewController  *orderDetailVC =  [[OrderDetailViewController alloc]initWithDTO:memberDto];
                    
                    orderDetailVC.orderSt = dto.oiStatus;
                    
                    orderDetailVC.supplierCode = product.supplierCode;
                    
                    orderDetailVC.supplierName = product.supplierName;
                    orderDetailVC.orderItemsId = product.orderItemId;
                    
                    orderDetailVC.orderItemIdArr = self.orderItemIdArr;
                    //                orderDetailVC.orderItemIdDic = self.orderItemIdDic;
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
                    
                    orderDetailVC.hasNav = YES;
                    orderDetailVC.hidesBottomBarWhenPushed = YES;
                    
                    [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:orderDetailVC animated:YES];
                }
                else
                {
                    NSString *urlStr = [NSString stringWithFormat:@"%@",kOrderConfirmAcceptWapUrl];//@"http://mpaypre.cnsuning.com/epp-m/showCheckPayPWD.htm?redecitString=suningMobileCheckPassSucess";
                    
                    NSURL *url = [NSURL URLWithString:urlStr];
                    ConfirmReceiptWebViewController *recommendViewController = [[ConfirmReceiptWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
                    
                    recommendViewController.orderID = dto.orderId;
                    //                recommendViewController.orderItemId = product.orderItemId;
                    recommendViewController.orderItemId = [self.orderItemIdArr safeObjectAtIndex:0];
                    recommendViewController.orderItemId = [self.orderItemIdDic objectForKey:[NSString stringWithFormat:@"%d",[self.CSLists count] - 1]];
                    recommendViewController.supplierCode = product.supplierCode;
                    recommendViewController.activeName = L(@"MyEBuy_ConfirmReceipt");
                    [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:recommendViewController animated:NO];
                    //                [self.navigationController pushViewController:recommendViewController animated:NO];
                }
            }
            
            self.clickConfirm = NO;
            
            if(self.isSecondPayDetail == YES)
            {
                //            [self displayOverFlowActivityView:@"二次支付校验中..."];
                [self setRightNavItemEnable:NO];
                [self.secondPayService beginSecondPayOrderCheckWithOrderId:self.orderId];
                self.isSecondPayDetail = NO;
            }
            
            
            
            if(self.isCancelorderDetail == YES)
            {
                NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
                
                //            [self displayOverFlowActivityView:@"订单取消中..."];
                [self setRightNavItemEnable:NO];
                
                [self.detailService beginSendCancelOrderHttpRequest:userId orderId:self.orderId];
                
            }
            
        }
        
        
        
    }
    else
    {
        [self presentSheet:errorCode];
        isReturnStatus = NO;
        isReturnStatus = NO;

    }
}

- (void)creatOrderDetailViewController:(NSArray *)orderDetailList
                                  ordeNamesDto:(MemberOrderNamesDTO *)ordeNamesDto
                                      isSucess: (BOOL) isSuccess
                                     errorCode: (NSString *)errorCode
                                    WithCSList:(NSArray *)CSList
                                  WithHeadList:(NSArray *)headList
{
    MemberOrderNamesDTO *memberDto = [[MemberOrderNamesDTO alloc] init];
    
    NewOrderListDTO *dto = [self.orderList safeObjectAtIndex:self.currentSection];
    ProductListDTO *product = [dto.productList safeObjectAtIndex:self.currentRow];
    
    MemberOrderNamesDTO *displayDTO = [headList safeObjectAtIndex:0];
    self.orderDetailStatus = displayDTO.oiStatus;
    
    memberDto.orderId = dto.orderId;
    memberDto.cShopName = product.supplierName;
    memberDto.supplierCode = product.supplierCode;
    
    OrderDetailViewController  *orderDetailVC =  [[OrderDetailViewController alloc]initWithDTO:memberDto];
    
    //            orderDetailVC.orderSt = product.supplierOrderStatus;
    
    orderDetailVC.orderSt = self.orderDetailStatus;
    
    
    orderDetailVC.supplierCode = product.supplierCode;
    
    orderDetailVC.supplierName = product.supplierName;
    orderDetailVC.orderItemsId = product.orderItemId;
    //            orderDetailVC.orderItemIdDic = self.orderItemIdDic;
    if(IsStrEmpty(product.supplierCode))
    {
        orderDetailVC.isCShopProduct = NO;
        
    }
    else
    {
        
        orderDetailVC.isCShopProduct = YES;
        
    }
    
    orderDetailVC.isFinishAccept = [dto isFinishAcceptOK:product.finishAccept];
    orderDetailVC.isDelivery = [dto isDelivityOK:product.omsStatus];
    
    orderDetailVC.hasNav = YES;
    orderDetailVC.hidesBottomBarWhenPushed = YES;
    
    [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:orderDetailVC animated:YES];
    
    

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
        
        if(self.isGetDetailData == YES)
        {
            ShipMode mode = [self.secondDto.currentShipModeType isEqualToString:L(@"MyEBuy_Delivery")]?ShipModeSuningSend:ShipModeSelfTake;
            
            PaymentModeViewController *payController =
            [[PaymentModeViewController alloc] initWithPayFlowDTO:payDTO
                                                      andShipMode:mode];
            payController.isSecondPay = YES;
            [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:payController animated:YES];
        }
        
        
        
    }else{
        
        [self presentSheet:errorMsg];
    }
}

- (void)ReceiptConfirmSuccess
{
    self.isLoadOrderListData = YES;
}

- (void)isActiveEFuBao
{
    //    eLoginByPhoneUnBound, //手机登录、手机未绑定、易付宝未激活
    //    eLoginByEmailUnBound, //邮箱登录、邮箱未激活、手机位激活、易付宝未激活
    //    eLoginByEmailPhoneUnBound, //邮箱登录、邮箱已激活、手机未激活、易付宝未激活
    //    eLoginByPhoneUnActive
    UserCenter *defaultCenter = [UserCenter defaultCenter];
    
    if(defaultCenter.efubaoStatus == eLoginByPhoneUnBound ||
       defaultCenter.efubaoStatus == eLoginByEmailUnBound ||
       defaultCenter.efubaoStatus == eLoginByEmailPhoneUnBound ||
       defaultCenter.efubaoStatus == eLoginByPhoneUnActive)
    {
        BBAlertView *alertview = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault Title:nil message:L(@"MyEBuy_EfubaoAccountIsntActivatedAndGoToActivate") customView:nil delegate:self cancelButtonTitle:L(@"AlertBack") otherButtonTitles:L(@"Ok")];
        
        [alertview setConfirmBlock:^{[self activeAction];}];
        [alertview setCancelBlock:^{}];
        
        [alertview show];
    }
    else
    {
        self.clickConfirm = YES;
        
        [self displayOverFlowActivityView];
        [self.detailService beginSendOrderDetailDTOHttpRequest:self.orderId WithCode:self.supplierCode];
        
    }
    
}

- (void)activedJumpConfirmGoods
{
    [self isActiveEFuBao];
}

- (NSMutableArray *)orderItemIdArr
{
    if (!_orderItemIdArr) {
        _orderItemIdArr = [[NSMutableArray alloc] init];
    }
    return _orderItemIdArr;
}

- (NSMutableDictionary *)orderItemIdDic
{
    if (!_orderItemIdDic) {
        _orderItemIdDic = [[NSMutableDictionary alloc] init];
    }
    return _orderItemIdDic;
}

- (NSMutableArray *)keyArr
{
    if (!_keyArr) {
        _keyArr = [[NSMutableArray alloc] init];
    }
    return _keyArr;
}

#pragma mark - Method not implemented in protocol

- (void)selectedAllOrderStyleOrTime:(NSString *)str WithRow:(NSInteger)row {}
- (void)btnsImage {}


#pragma mark - xzoscar 订单删除

// 订单删除 xzoscar 2014/08/21 add
- (void)delegate_NProOrderListHeadCell_operation:(int)operation view:(NProOrderListHeadCell *)view {
    
    [self displayOverFlowActivityView];
    
    self.toDeleteOrderBean = view.item;
    
    [self.detailService beginRequestDeleteTheOrderWithOrderId:view.item.orderId];
}

- (void)orderDeleteOperationCommplete:(NSError *)error {
    
    if (nil == error) {
        
        if (nil != _toDeleteOrderBean) {
            
            NSArray *toDeleteRows =
            [_orderList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.orderId==%@",_toDeleteOrderBean.orderId]];
            
            for (NewOrderListDTO *bean in toDeleteRows) {
                
                NSUInteger idx = [_orderList indexOfObject:bean];
                [_orderList removeObject:bean];
                
                NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:idx];
                [self.groupTableView beginUpdates];
                [self.groupTableView deleteSections:idxSet withRowAnimation:UITableViewRowAnimationRight];
                [self.groupTableView endUpdates];
            
                
            }
            
            self.toDeleteOrderBean = nil;
            [self presentSheet:L(@"MyEBuy_DeleteSuccess")];
            [self.groupTableView reloadData];
            if (_groupTableView.contentSize.height<=self.view.bounds.size.height && self.totalPage!=1) {
                [self loadMoreData];
                [self refreshData];
            }
        }
        
    }else {
        [self presentSheet:error.localizedDescription];
    }
    
    [self removeOverFlowActivityView];
}

- (void)setTableFooterView {
    
    CGSize sz = self.groupTableView.frame.size;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,52.0f)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    lbl.backgroundColor = self.groupTableView.backgroundColor;
    lbl.font = [UIFont systemFontOfSize:15.0f];
    [lbl setText:L(@"Get More...")];
    
    UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    v.frame = CGRectMake(85.0f,16.0f,20.0f,20.0f);
    [v startAnimating];
    [lbl addSubview:v];
    
    self.groupTableView.tableFooterView = lbl;
    
}

- (void)removeTableFooterView {
    self.groupTableView.tableFooterView = nil;
}

@end
