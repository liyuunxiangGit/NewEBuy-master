//
//  NServiceTrackListViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NServiceTrackListViewController.h"
#import "UserCenter.h"
#import "NServiceTrackListCell.h"
#import "ServiceDetailViewController.h"
#import "NewOrderListDTO.h"
#import "MyFavoriteViewController.h"
#import "NewOrderSnxpressViewController.h"

@implementation NServiceTrackListViewController


#pragma mark - View lifecycle

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"DiliverQueary");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
        self.timeRange = @"all";
        
        self.orderStatus = @"C";
        
        isLoadOk = NO;
        
    }
    return self;
}


- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.groupTableView.frame = frame ;
    
    [self.view addSubview:self.groupTableView];
    
    self.tableView = self.groupTableView;
    
    [self.groupTableView addSubview:self.refreshHeaderView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!isLoadOk) {
        
        [self refreshData];
    }
}

#pragma mark -
#pragma mark UIView
//送货安装为空时展示的View
- (UIView *)backgroundView
{
    if (!_backgroundView) {
        
        if ([SystemInfo is_iPhone_5]) {
            _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kIphone5Fix/2, 320, 368)];
        }else{
            _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 368)];
        }
        _backgroundView.backgroundColor = [UIColor clearColor];
        //add image
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(108, 70, 105, 72)];
        imageView.image = [UIImage imageNamed:@"trackface.png"];
        [_backgroundView addSubview:imageView];
        
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, 320, 20)];
        lab.text = L(@"SSNoInfoOfThisProduct");
        lab.textAlignment = UITextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor blackColor];
        [_backgroundView addSubview:lab];
        
        
        //add go to Favourite button
        UIButton *btnFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFavorite setTitle:L(@"goFavourite") forState:UIControlStateNormal];
        [btnFavorite setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"]
                               forState:UIControlStateNormal];
        [btnFavorite setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                               forState:UIControlStateHighlighted];
        btnFavorite.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [btnFavorite setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        [btnFavorite addTarget:self action:@selector(goToFavorite) forControlEvents:UIControlEventTouchUpInside];
        btnFavorite.frame = CGRectMake(30, 240, 125, 40);
        [_backgroundView addSubview:btnFavorite];
        
        //add go to Shopping button
        UIButton *btnShopping = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnShopping setTitle:L(@"goShopping") forState:UIControlStateNormal];
        [btnShopping setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"]
                               forState:UIControlStateNormal];
        //        [btnShopping setBackgroundImage:[UIImage imageNamed:@"shopcart_goaround_btn_press.png"]
        //                               forState:UIControlStateHighlighted];
        btnShopping.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [btnShopping setTitleColor:[UIColor colorWithRGBHex:0xffffff]
                          forState:UIControlStateNormal];
        [btnShopping addTarget:self action:@selector(goAround) forControlEvents:UIControlEventTouchUpInside];
        btnShopping.frame = CGRectMake(165, 240, 125, 40);
        [_backgroundView addSubview:btnShopping];
    }
    return _backgroundView;
}


/*
 last  section  尾文件
 Element 1：“加载更多” UIButton
 */
- (UIView *)loadMoreView{
    
    if(_loadMoreView == nil){
        
        _loadMoreView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50) ];
        
        UIButton *_loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loadMoreBtn.frame = CGRectMake(10, 0, 300, 40);
        
        [_loadMoreBtn setTitle:L(@"loadMore") forState:UIControlStateNormal];
        
        [_loadMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        
        [_loadMoreBtn.titleLabel setHighlightedTextColor:([UIColor grayColor])];
        
        [_loadMoreBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        
        [_loadMoreBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
        
        [_loadMoreBtn addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
        
        [_loadMoreView addSubview:_loadMoreBtn];
        
        TT_RELEASE_SAFELY(_loadMoreBtn);
        
    }
    
    return _loadMoreView;
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
        
        isLoadOk = YES;
        
        if (self.isFromHead) {
            
            [self.orderList removeAllObjects];
            
            [self.orderList addObjectsFromArray:service.orderList];
            
            [self refreshDataComplete];
            
        }else{
            
            [self.orderList addObjectsFromArray:service.orderList];
            
            [self loadMoreDataComplete];
        }
        
        [self updateTableView];
        
    }else{
        
        [self presentSheet:service.errorMsg posY:20];
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


- (void)updateTableView{
    
    [self.backgroundView removeFromSuperview];
    
    if (0 == [self.orderList count]) {
        
        [self.view addSubview:self.backgroundView];
    }
    
    [self.groupTableView reloadData];
    
}




#pragma mark -
#pragma mark TableView Delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.orderList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    sectionHead.backgroundColor = [UIColor clearColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 44)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:16];
    lab.textColor = [UIColor blackColor];
    NewOrderListDTO *dto = [self.orderList objectAtIndex:section];
    lab.text = [NSString stringWithFormat:@"%@%@",L(@"BTOrderId"),dto.orderId];
    [sectionHead addSubview:lab];
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 110, 44)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:16];
    lab.textAlignment = UITextAlignmentRight;
    NSString *status = dto.oiStatus;
    NSString *statusStr = @"";
    
    if ([status isEqualToString:@"C"]) {
        
        statusStr = L(@"Payment complete");
    }
    else if([status isEqualToString:@"M"]){
        
        statusStr = L(@"Waiting payment");
    }
    else if([status isEqualToString:@"e"]){
        
        statusStr = L(@"Abnormal order");
    }
    lab.text = [NSString stringWithFormat:@"%@",statusStr];
    [sectionHead addSubview:lab];
    
    return sectionHead;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.orderList count] > section) {
        
        NewOrderListDTO *dto = [self.orderList objectAtIndex:section];
        
        return [dto.productList count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *quertListIdentifier = @"NquertListIdentifier";
    
    NServiceTrackListCell *cell = (NServiceTrackListCell *)[tableView dequeueReusableCellWithIdentifier:quertListIdentifier];
    
    if (cell == nil) {
        
        cell = [[NServiceTrackListCell alloc] initWithReuseIdentifier:quertListIdentifier];
        
    }
    
    if ([self.orderList count] > indexPath.section) {
        
        NewOrderListDTO *dto = [self.orderList objectAtIndex:indexPath.section];
        
        if ([dto.productList count] > indexPath.row) {
            
            ProductListDTO *product = [dto.productList objectAtIndex:indexPath.row];
            
            [cell refreshCell:product];
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewOrderListDTO *dto = [self.orderList objectAtIndex:indexPath.section];
    ProductListDTO *product = [dto.productList objectAtIndex:indexPath.row];
    
    if (!IsStrEmpty(product.supplierCode)) {
        
        NewOrderSnxpressViewController *ctrl = [[NewOrderSnxpressViewController alloc]initWithStatus:eCShopDeliveryNew];
        ctrl.orderId = dto.orderId;
        ctrl.cShopCode = product.supplierCode;
        
        ctrl.hasNav = YES;
        ctrl.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:ctrl animated:YES];
        
    }else{
        
        ServiceDetailViewController *detailController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
        
        detailController.orderId = dto.orderId;
        detailController.orderItemId = product.orderItemId;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == (tableView.numberOfSections-1) && !self.isLastPage) {
        
        return 50;
    }
    else if([self.orderList count] == 0)
    {
        return 300;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == (tableView.numberOfSections-1) && !self.isLastPage) {
        
        [self.backgroundView removeFromSuperview];
        
        return self.loadMoreView;
        
    }else if([self.orderList count] == 0){
        
        return self.backgroundView;
        
    }else{
        
        return nil;
    }
}


-(NSMutableArray *)orderList{
    
    if (!_orderList) {
        _orderList = [[NSMutableArray alloc]init];
    }
    return _orderList;
}

#pragma mark -
#pragma mark Action
- (void)goToFavorite
{
    //防止从购物车到我的收藏夹后不能返回到我的购物车而是返回到我的易购
    MyFavoriteViewController *myFavorite = [[MyFavoriteViewController alloc] init];
    [self.navigationController pushViewController:myFavorite animated:YES];
    TT_RELEASE_SAFELY(myFavorite);
}


@end
