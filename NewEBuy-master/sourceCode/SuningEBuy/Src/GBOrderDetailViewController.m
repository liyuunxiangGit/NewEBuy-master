//
//  GBOrderDetailViewController.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderDetailViewController.h"
#import "GBVoucherInfoController.h"
#import "GBPayModelViewController.h"
#import "GBOrderShopListViewController.h"
#import "GBOrderListViewController.h"
#import "GBListGoodsDTO.h"
#import "GBDetailViewController.h"

#import "OrderDetailCell.h"
#import "NewOrderProInfoCell.h"
#import "OrderDetailBtnCell.h"
#import "OrderDetailBottomCell.h"
#import "GBDetailViewController.h"

@interface GBOrderDetailViewController ()

@end

@implementation GBOrderDetailViewController

@synthesize orderInfo = _orderInfo;
@synthesize orderDetailInfo = _orderDetailInfo;
@synthesize tipsView = _tipsView;
@synthesize tipsLabel = _tipsLabel;
@synthesize isFormPayPage = _isFormPayPage;
@synthesize service = service;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(service);
    TT_RELEASE_SAFELY(_orderInfo);
    TT_RELEASE_SAFELY(_orderDetailInfo);
    TT_RELEASE_SAFELY(_tipsView);
    TT_RELEASE_SAFELY(_tipsLabel);
    
}


-(id)initWithOrderInfo:(GBOrderInfoDTO *)dto{
    
    self = [super init];
    if (self) {
        self.orderInfo =dto;
        self.orderInfo.hotelName = dto.snProName;
       // TT_RELEASE_SAFELY(dto);
        service = [[GBOrderDetailInfoService alloc]init];
        service.delegate = self;
        isLoaded = NO;
        orderStatus = self.orderInfo.orderStatus;
        tuanGouType = self.orderInfo.gbType;
        self.isFormPayPage = NO;
//        if (tuanGouType == 0) {
//            self.title = @"订单详情";
//        }else{
//            self.title = @"团购搜索";
//        }
        
        self.title = L(@"the detail orderList");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.groupTableView.frame = [self setViewFrame:self.hasNav];
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTableView.indicatorStyle =UIScrollViewIndicatorStyleDefault;
    self.groupTableView.scrollEnabled = YES;
    [self.view addSubview:self.groupTableView];
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    self.bottomCell.backBtn.hidden = YES;
//    UIView *contentView = self.view;
//    CGRect frame = contentView.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    frame.size.height = contentView.bounds.size.height  -44;
//    
//    self.tableView.frame = frame;
//    self.tableView.indicatorStyle =UIScrollViewIndicatorStyleDefault;
//    self.tableView.scrollEnabled = YES;
//    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!isLoaded)
    {
        [self displayOverFlowActivityView];
        [self.service sendOrderDetailInfoHttpRequest:_orderInfo];
    }
    if(self.isFormPayPage)
    {
//        [self initBackItem];
    }
}


- (void)initBackItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToFore:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 9777;
    
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    [widow addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
}

- (void)backToFore:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.isFormPayPage)
    {
        UIWindow *widow = [UIApplication sharedApplication].keyWindow;
        
        for (UIView *view in widow.subviews) {
            
            if (view.tag == 9777) {
                
                [view removeFromSuperview];
                
                break;
                
            }
        }
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;//1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1)
    {
        return [OrderDetailWayCell setRowsOfSection:self.orderDetailInfo];
    }
    else if(section == 3)
    {
        return 3;
    }
    else
    {
        return 1;
    }
//    if (NotNilAndNull(_orderDetailInfo)) {
//        return 2;
//    }
//    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(IsNilOrNull(self.orderDetailInfo))
    {
        return 0;
    }
    
    if(indexPath.section == 0)
    {
        self.orderDetailInfo.snProName = self.orderInfo.snProName;

        return [NewOrderProInfoCell setGroupOrderDetailCellHeight:self.orderDetailInfo];
    }
//    else if(indexPath.section == 1)
//    {
//        return [OrderDetailWayCell setGroupOrderDetailCellHeight:self.orderDetailInfo WithSectionPosition:indexPath.section WithCellPosition:indexPath.row];
//    }
    else
    {
        return 40;
    }
    
//    NSInteger row = indexPath.row;
//    if (row == 0) {
//        return 220;
//    }else if(row == 1 )
//    {
//        return [GBOrderMoreInfoCell height:self.orderDetailInfo];
//    }
//    return 0;
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
    
    
    [self.bottomCell setGroupOrderDetailCell:self.orderDetailInfo];
    
    [self.bottomCell.bottomPayBtn addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];
    
    if(indexPath.section == 0)
    {
        static NSString *GBorderDetailInfoCellIdentifier  =  @"GBorderDetailInfoCellIdentifier";
        NewOrderProInfoCell *cell = (NewOrderProInfoCell *)[tableView dequeueReusableCellWithIdentifier:GBorderDetailInfoCellIdentifier];
        if (cell == nil) {
            cell = [[NewOrderProInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBorderDetailInfoCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        self.orderDetailInfo.snProName = self.orderInfo.snProName;
        
        [cell setGroupOrderDetailCell:self.orderDetailInfo];
        
        return cell;

    }
    else if(indexPath.section == 4)
    {
        static NSString *GBOrdderMoreInfoCellIndentifier = @"OrderDetailBtnCell_group";
        OrderDetailBtnCell *cell = (OrderDetailBtnCell *)[tableView dequeueReusableCellWithIdentifier:GBOrdderMoreInfoCellIndentifier];
        if (cell == nil) {
            cell= [[OrderDetailBtnCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrdderMoreInfoCellIndentifier];
            
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.isAddNotifition = YES;
        }
        
        
//        if (2 == self.orderDetailInfo.voucherType) {
//            
//            if (0 == self.orderDetailInfo.voucherMap.notUse
//                || NO == self.orderDetailInfo.voucherMap.canRefund) {
//                
//                cell.refundBtn.enabled = NO;
//            }
//            else
//            {
//                cell.refundBtn.enabled = YES;
//
//            }
//        }
//        else{
//            
//            cell.refundBtn.enabled = NO;
//
////            for (GBVoucherSingleInfoDTO *dto in self.orderDetailInfo.voucherList) {
////                
////                if (2 == dto.status && 0 == dto.gbType
////                    && YES == dto.canRefund) {
////                    
////                    cell.refundBtn.enabled = YES;
////                }
////            }
//            
//            
//        }
        
        [cell.refundBtn addTarget:self action:@selector(returnOrder) forControlEvents:UIControlEventTouchUpInside];

        [cell.cancelOrderBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
        
        [cell setGroupOrderDetailCell:self.orderDetailInfo];

        return cell;

        
    }
    else
    {
        static NSString *GBOrdderMoreInfoCellIndentifier = @"OrderDetailWayCell_group";
        OrderDetailWayCell *cell = (OrderDetailWayCell *)[tableView dequeueReusableCellWithIdentifier:GBOrdderMoreInfoCellIndentifier];
        if (cell == nil) {
            cell= [[OrderDetailWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrdderMoreInfoCellIndentifier];
            
        }
        
        if(indexPath.section == 1)
        {
            
        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

        [cell setGroupOrderDetailCell:self.orderDetailInfo WithSectionPosition:indexPath.section WithCellPosition:indexPath.row WithRows:[self tableView:self.groupTableView numberOfRowsInSection:1]];
        
        return cell;
    }
    
    
/*    NSInteger row  = indexPath.row;
    if (row == 0) {
        static NSString *GBorderDetailInfoCellIdentifier  =  @"GBorderDetailInfoCellIdentifier";
        GBOrderDetailInfoCell *cell = (GBOrderDetailInfoCell *)[tableView dequeueReusableCellWithIdentifier:GBorderDetailInfoCellIdentifier];
        if (cell == nil) {
            cell = [[GBOrderDetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBorderDetailInfoCellIdentifier];
            cell.myDelegate = self;
        }
        [cell setItem:self.orderDetailInfo];
        return cell;
    }else{
        static NSString *GBOrdderMoreInfoCellIndentifier = @"GBOrdderMoreInfoCellIndentifier";
        GBOrderMoreInfoCell *cell = (GBOrderMoreInfoCell *)[tableView dequeueReusableCellWithIdentifier:GBOrdderMoreInfoCellIndentifier];
        if (cell == nil) {
            cell= [[GBOrderMoreInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrdderMoreInfoCellIndentifier];
        }
        [cell setItem:self.orderDetailInfo];
        cell.delegate= self;
        return cell;
    }*/
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        GBDetailViewController *detail = [[GBDetailViewController alloc] init];
        detail.snProId = self.orderDetailInfo.snProId;
        detail.tuanGouType = [NSString stringWithFormat:@"%i",self.orderDetailInfo.gbType];
        
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if(indexPath.section == 1)
    {
        NSInteger rowNum = [self tableView:self.groupTableView numberOfRowsInSection:1];
        
        if(rowNum == 1)
        {
            [self gotoVoucherNotice];

        }
        else if(rowNum == 2)
        {
            if (self.orderDetailInfo.gbType == 0 &&
                (self.orderDetailInfo.orderStatus == 1 ||
                 self.orderDetailInfo.orderStatus == 2))
            {
                if(indexPath.row == 0)
                {
                    [self gotoVoucherInfo:NO];
                }
                else if(indexPath.row == 1)
                {
                    [self gotoVoucherNotice];
                }
            }
            
            if (self.orderDetailInfo.gbType == 1 &&
                (self.orderDetailInfo.orderStatus !=1 &&
                 self.orderDetailInfo.orderStatus !=2))
            {
                if(indexPath.row == 0)
                {
                    [self gotoVoucherNotice];
                }
                else if(indexPath.row == 1)
                {
                    [self gotoShopInfo];
                }
            }

        }
        else
        {
            if(indexPath.row == 0)
            {
                [self gotoVoucherInfo:NO];
            }
            else if(indexPath.row == 1)
            {
                [self gotoVoucherNotice];
            }
            else
            {
                [self gotoShopInfo];
            }

        }
 /*
//        if (self.orderDetailInfo.gbType == 0 &&( self.orderDetailInfo.orderStatus != 1 && self.orderDetailInfo.orderStatus !=2)) {
//
//            [self gotoVoucherNotice];
//            
//        }
//        else if ((self.orderDetailInfo.gbType == 0 &&
//                  (self.orderDetailInfo.orderStatus == 1 ||
//                   self.orderDetailInfo.orderStatus == 2)) ||
//                 (self.orderDetailInfo.gbType == 1&&
//                  ( self.orderDetailInfo.orderStatus!=1 &&
//                   self.orderDetailInfo.orderStatus != 2)))
//        {
//            if (self.orderDetailInfo.gbType == 0 &&
//                (self.orderDetailInfo.orderStatus == 1 ||
//                 self.orderDetailInfo.orderStatus == 2))
//            {
//                if(indexPath.row == 0)
//                {
//                    [self gotoVoucherInfo];
//                }
//                else if(indexPath.row == 1)
//                {
//                    [self gotoVoucherNotice];
//                }
//            }
//            
//            if (self.orderDetailInfo.gbType == 1 &&
//                (self.orderDetailInfo.orderStatus !=1 &&
//                 self.orderDetailInfo.orderStatus !=2))
//            {
//                if(indexPath.row == 0)
//                {
//                    [self gotoVoucherNotice];
//                }
//                else if(indexPath.row == 1)
//                {
//                    [self gotoShopInfo];
//                }
//            }
//            
//        }
//        else if (self.orderDetailInfo.gbType == 1 && (self.orderDetailInfo.orderStatus ==1 || self.orderDetailInfo.orderStatus == 2)) {
//            if(indexPath.row == 0)
//            {
//                [self gotoVoucherInfo];
//            }
//            else if(indexPath.row == 1)
//            {
//                [self gotoVoucherNotice];
//            }
//            else
//            {
//                [self gotoShopInfo];
//            }
//        
//        }*/
    }
}


- (void)getOrderDetailInfoCopleted:(BOOL)isSuccess orderDetailInfoDTO:(GBOrderInfoDTO *)dto errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    TT_RELEASE_SAFELY(_orderDetailInfo);
    if (isSuccess) {
        isLoaded = YES;
        if (dto) {
            if (!_orderDetailInfo) {
                _orderDetailInfo = [[GBOrderInfoDTO alloc]init];
            }
            self.orderDetailInfo = dto;
            self.orderInfo.orderStatus = dto.orderStatus;
            orderStatus = dto.orderStatus;
            tuanGouType = dto.gbType;
        }else{
            [self presentSheet:errorMsg];
        }
    }else{
        [self presentSheet:L(@"GBInternetError")];
    }
    [self.groupTableView reloadData];
}
//退款
- (void)returnOrder{
    BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:L(@"GBApplyForRefund") message:L(@"GBAreYouSureRefund") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    [alert show];
    [alert setConfirmBlock:^{
        
        [self gotoVoucherInfo:YES];
        
    }];
    [alert setCancelBlock:^{
        [self.groupTableView reloadData];
    }];
    TT_RELEASE_SAFELY(alert);
}
//退款
-(void)refundAction:(UIButton *)btn{
    
    
    NSMutableArray *selectList = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (GBVoucherSingleInfoDTO *dto in self.orderDetailInfo.voucherList) {
        
        if (dto.isSelect) {
            
            [selectList addObject:dto];
        }
    }
    
    ReFundInfoDto *reFundDto = [[ReFundInfoDto alloc] init];
    
    reFundDto.orderId = self.orderDetailInfo.orderId;
    reFundDto.tuanGouType = [NSString stringWithFormat:@"%d",self.orderDetailInfo.gbType];
    reFundDto.userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    if (2 == self.orderDetailInfo.voucherType) {
        
        reFundDto.vouncherType = @"2";
        
        reFundDto.maxCount = self.orderDetailInfo.voucherMap.notUse;
    }
    else{
        
        reFundDto.vouncherType = @"";
    }
    
    reFundDto.orderItemIdArray = selectList;
    
    if (0 != [self.orderDetailInfo.saleCount length]
        && 0 != [self.orderDetailInfo.orderAmount length]
        && 0 != [self.orderDetailInfo.saleCount intValue]) {
        
        reFundDto.price = [self.orderDetailInfo.orderAmount floatValue]/[self.orderDetailInfo.saleCount floatValue];
    }
    else{
        reFundDto.price = 0;
    }
    
    GBRefundViewController *v = [[GBRefundViewController alloc] init];
    v.refundDto = reFundDto;
    v.orderDto = self.orderDetailInfo;
    v.hasNav = NO;
    v.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:v animated:YES];
    
    
}


//付款
- (void)payOrder
{
    GBSubmitDTO *dto = [[GBSubmitDTO alloc] init];
    dto.orderId = self.orderDetailInfo.orderId;
    dto.eppAmount = self.orderDetailInfo.orderAmount;
    dto.payAmount = self.orderDetailInfo.orderAmount;
    dto.gbType = self.orderInfo.gbType;
    dto.snProId = self.orderInfo.snProId;
    GBPayModelViewController *gbModel = [[GBPayModelViewController alloc] init];
    gbModel.gbSubmitDto = dto;
    gbModel.gbSubmitDto.snProName = self.orderInfo.snProName;
    gbModel.isFormOrder = YES;
    [self.navigationController pushViewController:gbModel animated:YES];
    
}
//取消订单
- (void)cancelOrder{
    BBAlertView *alert = [[BBAlertView alloc]initWithTitle:L(@"Cancel Order") message:L(@"GBAreYouSureCancelGroupBuy") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    [alert show];
    [alert setConfirmBlock:^{

        [self.cancelService beginCancelOrder:self.orderDetailInfo.orderId
                                     isHotel:[NSString stringWithFormat:@"%d",self.orderDetailInfo.gbType]
                                        user:[UserCenter defaultCenter].userInfoDTO.userId];//[UserCenter defaultCenter].userInfoDTO.userId
    }];
    [alert setCancelBlock:^{
        [ [NSNotificationCenter defaultCenter ]postNotificationName:GB_ORDER_CANCEL_FAIL object:nil];
        
    }];
    [self.groupTableView reloadData];
    TT_RELEASE_SAFELY(alert);
}
//商家详情
- (void)gotoShopInfo{
    GBOrderShopListViewController *vc = [[GBOrderShopListViewController alloc]initWithShopList:self.orderDetailInfo.shopList];
    vc.hasNav = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    TT_RELEASE_SAFELY(vc);
}
//团购券详情
- (void)gotoVoucherInfo:(BOOL)isRefund
{
//    if (0 == [self.orderDetailInfo.voucherList count]
//        &&  2 != self.orderDetailInfo.voucherType) {
//        //一圈一用 但券未生效时不展示
//        
//        [self presentSheet:@"团购券还未生效，请等待"];
//        return;
//    }
    GBVoucherInfoController *voucherInfoVC = [[GBVoucherInfoController alloc] init];
    voucherInfoVC.orderDetailDto = self.orderDetailInfo;
    voucherInfoVC.hidesBottomBarWhenPushed = YES;
    voucherInfoVC.hasNav = YES;
    voucherInfoVC.isRefund = isRefund;
    [self.navigationController pushViewController:voucherInfoVC animated:YES];
}


- (void)gotoVoucherNotice{
    NSString *title;
    if (self.orderDetailInfo.gbType == 0) {
        title = L(@"GB_Kindly_Reminder");
    }else{
        title = L(@"GBProjectOfGroupBuy");
    }
    
    GBGoodsInfoViewController *vc = [[GBGoodsInfoViewController alloc]initWithRequestUrl:[self getVoucherUrl]  titleName:title];
    
    vc.hasNav = YES;
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    TT_RELEASE_SAFELY(vc);
}

- (NSString *)getVoucherUrl{
    
//    NSString *url = [NSString stringWithFormat:@"%@?snProId=%@",self.orderDetailInfo.notice,self.orderDetailInfo.snProId];
//    return url;
    
    return self.orderDetailInfo.notice;
}

-(GBCancelOrderService *)cancelService{
    
    if (!_cancelService) {
        
        _cancelService = [[GBCancelOrderService alloc] init];
        _cancelService.myDelagate = self;
    }
    
    return _cancelService;
}
- (void)cancelOrder:(GBCancelOrderService *)service
               info:(NSDictionary *)dicinfo
             Result:(BOOL)isSuccess{
    
    if (isSuccess) {
        
        BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:L(@"GBCancelSuccess") message:L(@"GBYourOrderCancelSuccess") delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
        [alert show];
        [alert setCancelBlock:^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupOrderCancel" object:nil];
            
            NSArray *array = self.navigationController.viewControllers;
            if (2 <= [array count]) {
                
                UIViewController *v = (UIViewController *)[array safeObjectAtIndex:1];
                
                if ([v isKindOfClass:[GBOrderListViewController class]]) {
                    
                    [(GBOrderListViewController *)v refreshData];
                }
                
                [self.navigationController popToViewController:(UIViewController *)[array safeObjectAtIndex:1] animated:YES];
            }
            else{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            
        }];
        TT_RELEASE_SAFELY(alert);
    }
    else{
    
        if (![self.cancelService.errorCode isEqualToString:@"400000"]) {
            
            [self presentSheet:L(self.cancelService.errorMsg) posY:70];
        }
    
    }
}

-(void)gotoGroupDetail{
    
    
//    GBListGoodsDTO *dto = [self.goodsList objectAtIndex:row];
//    NSString *snProId = IsStrEmpty(dto.snProId)?@"":dto.snProId;
//    NSString *goodSrc = IsStrEmpty(dto.goodSrc)?@"":dto.goodSrc;
    GBDetailViewController *detail = [[GBDetailViewController alloc] init];
    detail.snProId = self.orderInfo.snProId;
    detail.tuanGouType = [NSString stringWithFormat:@"%d",self.orderInfo.gbType];
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
