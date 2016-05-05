//
//  ServiceTrackListViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceTrackListViewController.h"
#import "UserCenter.h"
#import "ServiceTrackListCell.h"
#import "ServiceDetailViewController.h"
#import "MyFavoriteViewController.h"
#import "NewOrderSnxpressViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface ServiceTrackListViewController()
{
    int currentPage;
    int totalPage;
    
    BOOL isLoading;
    BOOL isLastPage;
    BOOL isLoadMore;
    
    BOOL isStartLoad;
    
    NSDictionary *parametersDic;
}

@property (nonatomic, strong) ServiceTrackListService *serviceTrackListService;

@end


@implementation ServiceTrackListViewController

@synthesize tpkTableView = _tpkTableView;

@synthesize memberTextField = _memberTextField;

@synthesize marketNumTextField = _marketNumTextField;

@synthesize queryList = _queryList;

@synthesize loadMoreView = _loadMoreView;

@synthesize serviceTrackListService = _serviceTrackListService;

@synthesize backgroundView = _backgroundView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_tpkTableView);
    TT_RELEASE_SAFELY(_memberTextField);
    TT_RELEASE_SAFELY(_marketNumTextField);
    TT_RELEASE_SAFELY(_queryList);
    TT_RELEASE_SAFELY(_loadMoreView);
    TT_RELEASE_SAFELY(_backgroundView);
    SERVICE_RELEASE_SAFELY(_serviceTrackListService);
    
}

- (TPKeyboardAvoidingTableView *)tpkTableView{
    
    if (!_tpkTableView) {
        
        _tpkTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                     style:UITableViewStylePlain];
		
        [_tpkTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
        [_tpkTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
        _tpkTableView.scrollEnabled = YES;
		
        _tpkTableView.userInteractionEnabled = YES;
		
        _tpkTableView.delegate =self;
		
        _tpkTableView.dataSource =self;
		
        _tpkTableView.backgroundColor =[UIColor clearColor];
        
        _tpkTableView.backgroundView = nil;
    }
    return  _tpkTableView;
}

- (UITextField *)memberTextField
{
    if (_memberTextField == nil)
    {
        _memberTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
        
        _memberTextField.borderStyle = UITextBorderStyleNone;
        
        _memberTextField.textColor = [UIColor blackColor];
        
        _memberTextField.font = [UIFont systemFontOfSize:17];
        
        _memberTextField.backgroundColor = [UIColor clearColor];
        
        _memberTextField.userInteractionEnabled = NO;
        
        _memberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _memberTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _memberTextField.delegate = self;
        
        _memberTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        _memberTextField.returnKeyType = UIReturnKeyDone;
        
        _memberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return _memberTextField;
}

- (keyboardNumberPadReturnTextField *)marketNumTextField{
    
    if (!_marketNumTextField) {
        
        _marketNumTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
        
        _marketNumTextField.borderStyle = UITextBorderStyleNone;
        
        _marketNumTextField.textColor = [UIColor blackColor];
        
        _marketNumTextField.font = [UIFont systemFontOfSize:17];
        
        _marketNumTextField.backgroundColor = [UIColor clearColor];
        
        _marketNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _marketNumTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _marketNumTextField.delegate = self;
        
        _marketNumTextField.userInteractionEnabled = YES;
        
        _marketNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        _marketNumTextField.returnKeyType = UIReturnKeyDone;
        
        _marketNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _marketNumTextField.placeholder = L(@"Please enter SaleNo");
    }
    
    return _marketNumTextField;
}

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
        lab.text = L(@"SSNoInfoOfLogisticsNow");
        lab.textAlignment = UITextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor blackColor];
        [_backgroundView addSubview:lab];
        
        
        //add go to Favourite button
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

#pragma mark -
#pragma mark 收藏  逛逛
- (void)goAround
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"780802"], nil]];
    [super goAroundWithCompleteBlock:NULL];
}
- (void)goToFavorite
{
    //防止从购物车到我的收藏夹后不能返回到我的购物车而是返回到我的易购
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"780801"], nil]];
    MyFavoriteViewController *myFavorite = [[MyFavoriteViewController alloc] init];
    [self.navigationController pushViewController:myFavorite animated:YES];
    TT_RELEASE_SAFELY(myFavorite);
}

//- (void)goToHome
//{
//    [self jumpToHomeBoard];
//}
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

- (ServiceTrackListService *)serviceTrackListService{
    
    if (!_serviceTrackListService) {
        _serviceTrackListService = [[ServiceTrackListService alloc] init];
        _serviceTrackListService.delegate = self;
    }
    
    return _serviceTrackListService;
}

#pragma mark - View lifecycle

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"DiliverQueary");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        self.hidesBottomBarWhenPushed = YES;
        isStartLoad = NO;
        
        if (!_queryList) {
            
            _queryList = [[NSMutableArray alloc] init];
            
            //加载更多相关
            currentPage = 1;
            totalPage = 1;
            isLoading = NO;
            isLastPage = YES;
        }
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLoginOk) name:AUTOLOGIN_OK_MESSAGE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLoginFailed) name:AUTOLOGIN_Failed_MESSAGE object:nil];
    }
    return self;
}


- (void)autoLoginOk
{
    if ([self.queryList count] == 0) {
        
        [self refreshData];
    }
}

- (void)autoLoginFailed
{
    if (![[UserCenter defaultCenter] isLogined])
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        loginViewController.loginDelegate = self;
        loginViewController.loginDidOkSelector = @selector(loginSuccess);
        loginViewController.loginDidCancelSelector = @selector(loginCancel);
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:loginViewController];
        [self presentModalViewController:userNav animated:YES];
        return;
    }
}

- (void)loginSuccess
{
    if ([self.queryList count] == 0) {
        
        [self refreshData];
    }
}

- (void)loginCancel
{
    
}

- (void)loadView{
    
    [super loadView];
    
    self.tpkTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    [self.view addSubview:self.tpkTableView];
    
    self.tableView = self.tpkTableView;
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F8"];

    [self.tpkTableView addSubview:self.refreshHeaderView];
    
    self.hasSuspendButton = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.memberTextField.text = [UserCenter defaultCenter].userInfoDTO.memberCardNo;        
    
    if ([self.queryList count] == 0) {
        
        [self refreshData];
    }
}

#pragma mark -
#pragma mark custom methods
- (NOrderListService*)orderListservice
{
    if(!_orderListservice)
    {
        _orderListservice = [[NOrderListService alloc] init];
        _orderListservice.delegate = self;
    }
    
    return _orderListservice;
}

//Kristopher
- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self displayOverFlowActivityView];

    [self.orderListservice beginGetOrderListHttpRequest:userId
                                            currentPage:pageNum
                                            orderStatus:@"MB_C"//@"MB_C"
                                             selectTime:@"all"];
    
    parametersDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.memberTextField.text,kMemberCardID,[NSString stringWithFormat:@"%d",self.currentPage],kCurrentPage, nil];
   
    
//    [self.serviceTrackListService beginGetServiceTrackList:parametersDic];
    
    TT_RELEASE_SAFELY(parametersDic);
}

- (void)loadMoreData{
    
    [super loadMoreData];
    isLoadMore = YES;
    
    self.currentPage++;
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self displayOverFlowActivityView];
    
    
    [self.orderListservice beginGetOrderListHttpRequest:userId
                                            currentPage:pageNum
                                            orderStatus:@"MB_C"
                                             selectTime:@"all"];
    
    parametersDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.memberTextField.text,kMemberCardID,[NSString stringWithFormat:@"%d",self.currentPage],kCurrentPage, nil];
    
//    [self.serviceTrackListService beginGetServiceTrackList:parametersDic];
    
    TT_RELEASE_SAFELY(parametersDic);
}

- (void)updateTableView{
    
    
    [self.backgroundView removeFromSuperview];
   
    if (0 == [self.queryList count]) {
        
        [self.view addSubview:self.backgroundView];
    }
    
    
    [self.tpkTableView reloadData];
    
}

#pragma mark - NOrderListServiceDelegate
-(void)orderListService:(NOrderListService *)service
              isSuccess:(BOOL)isSuccess{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        self.isLastPage = service.isLastPage;
        
        if (self.isFromHead) {
            
            [self.queryList removeAllObjects];
            
            [self.queryList addObjectsFromArray:service.orderList];
            
            [self refreshDataComplete];
            
        }else{
            
            [self.queryList addObjectsFromArray:service.orderList];
            
            [self loadMoreDataComplete];
        }
        [self updateTableView];
        
    }else{
        
        
        [self presentSheet:service.errorMsg posY:20];
    }
}

/*
#pragma mark -
#pragma mark ServiceTrackListServiceDelegate

- (void)getServiceTrackListCompleteWithService:(ServiceTrackListService *)service
                                        Result:(BOOL)isSuccess
                                      errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];

    isStartLoad = YES;
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if (isSuccess) {
        
        self.totalPage = service.totalPage;
        self.currentPage = service.currentPage;
        
        self.isLastPage = service.isLastPage;
        
        if (self.isFromHead) {
            
            self.queryList = service.queryResultArray;
            
        }else{
            
            [self.queryList addObjectsFromArray:service.queryResultArray];
        }
        
        [self updateTableView];
        
    }else{
                
        [self presentSheet:errorMsg posY:20];
    }
    
}
*/


#pragma mark - 
#pragma mark TableView Delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self hasMore]) {
        
        return [self.queryList count]+1;
    }

    return [self.queryList count]; //== 0 ? 1 :2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && [self.queryList count] == indexPath.section) {
        
        return  48;
    }

    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self hasMore] && [self.queryList count] == section) {
        
        return  1;
    }

    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self hasMore] && [self.queryList count] == section) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        return view;

    }
    else
    {
        UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        sectionHead.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 44)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor blackColor];
        NSString *orderId = ((NewOrderListDTO *)[self.queryList safeObjectAtIndex:section]).orderId;
        lab.text = [NSString stringWithFormat:@"%@%@",L(@"BTOrderId"),orderId];
        [sectionHead addSubview:lab];
        
        lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 110, 44)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = UITextAlignmentRight;
        //    NSString *status = ((LogisticsQueryDTO *)[self.queryList objectAtIndex:section]).oiStatus;
        NSString *statusStr = ((NewOrderListDTO *)[self.queryList safeObjectAtIndex:section]).lastUpdate;//@"";
        
        
        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 0.5)];
        separatorLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [sectionHead addSubview:separatorLine];
        
        //    if ([status isEqualToString:@"C"]) {
        //
        //        statusStr = @"支付完成";
        //    }
        //    else if([status isEqualToString:@"M"]){
        //
        //        statusStr = @"等待支付";
        //    }
        //    else if([status isEqualToString:@"e"]){
        //
        //        statusStr = @"异常订单";
        //    }
        lab.text = [NSString stringWithFormat:@"%@",[statusStr substringToIndex:10]];
        [sectionHead addSubview:lab];
        
        
        return sectionHead;

    }

    
//    UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    sectionHead.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 44)];
//    lab.backgroundColor = [UIColor clearColor];
//    lab.font = [UIFont systemFontOfSize:13];
//    lab.textColor = [UIColor blackColor];
//    NSString *orderId = ((NewOrderListDTO *)[self.queryList safeObjectAtIndex:section]).orderId;
//    lab.text = [NSString stringWithFormat:@"订单号：%@",orderId];
//    [sectionHead addSubview:lab];
//    
//    lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 110, 44)];
//    lab.backgroundColor = [UIColor clearColor];
//    lab.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
//    lab.font = [UIFont systemFontOfSize:13];
//    lab.textAlignment = UITextAlignmentRight;
////    NSString *status = ((LogisticsQueryDTO *)[self.queryList objectAtIndex:section]).oiStatus;
//    NSString *statusStr = ((NewOrderListDTO *)[self.queryList safeObjectAtIndex:section]).lastUpdate;//@"";
//    
//    
//    UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 0.5)];
//    separatorLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
//    [sectionHead addSubview:separatorLine];
//    
////    if ([status isEqualToString:@"C"]) {
////        
////        statusStr = @"支付完成";
////    }
////    else if([status isEqualToString:@"M"]){
////        
////        statusStr = @"等待支付";
////    }
////    else if([status isEqualToString:@"e"]){
////        
////        statusStr = @"异常订单";
////    }
//    lab.text = [NSString stringWithFormat:@"%@",[statusStr substringToIndex:10]];
//    [sectionHead addSubview:lab];
//    
//    
//    return sectionHead;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (section == 1) {
//        return [self.queryList count];
//    }
//    
//    return [((LogisticsQueryDTO *)[self.queryList objectAtIndex:section]).orderItemArray count];
    if ([self hasMore] && [self.queryList count] == section) {
        
        return  1;
    }

    NewOrderListDTO *dto = [self.queryList safeObjectAtIndex:section];

    return [dto.productList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // if (indexPath.section == 1) {
    if ([self hasMore] && [self.queryList count] == indexPath.section) {
        
        static NSString *orderListMoreIdentifier = @"ListMoreIdentifier";
        
        UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:orderListMoreIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderListMoreIdentifier];
            cell.title = L(@"loadMore");
            cell.animating = NO;
            cell.backgroundColor = [UIColor cellBackViewColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        return cell;
        
    }
    else
    {
        static NSString *quertListIdentifier = @"quertListIdentifier";
        
        ServiceTrackListCell *cell = (ServiceTrackListCell *)[tableView dequeueReusableCellWithIdentifier:quertListIdentifier];
        
        if (cell == nil) {
            
            cell = [[ServiceTrackListCell alloc] initWithReuseIdentifier:quertListIdentifier];
            
            //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (!IOS7_OR_LATER)
            {
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
        }
        
        if ([self.queryList count] != 0 ) {
            
            //            OrderItemDTO *dto = (OrderItemDTO *)[((LogisticsQueryDTO *)[self.queryList objectAtIndex:indexPath.section]).orderItemArray objectAtIndex:indexPath.row];
            
            NewOrderListDTO *dto = [self.queryList safeObjectAtIndex:indexPath.section];
            
            ProductListDTO *proDto = [dto.productList safeObjectAtIndex:indexPath.row];
            
            [cell setServiceQueryDto:proDto];
            
        }
        return cell;

    }

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 /*
//    OrderItemDTO *dto = (OrderItemDTO *)[((LogisticsQueryDTO *)[self.queryList objectAtIndex:indexPath.section]).orderItemArray objectAtIndex:indexPath.row];
//    NewOrderListDTO *dto = (OrderItemDTO *)[((LogisticsQueryDTO *)[self.queryList objectAtIndex:indexPath.section]).orderItemArray objectAtIndex:indexPath.row];
    NewOrderListDTO *dto = [self.queryList safeObjectAtIndex:indexPath.section];
    
    ProductListDTO *productDto = [dto.productList safeObjectAtIndex:indexPath.row];
    
    ServiceDetailViewController *detailController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
    
//    detailController.dtoServiceDetail = dto;
//    detailController.orderId = ((LogisticsQueryDTO *)[self.queryList objectAtIndex:indexPath.section]).orderId;
    detailController.orderId = dto.orderId;
    
    detailController.orderItemId = productDto.orderItemId;
    
    detailController.hasNav = YES;
    detailController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    TT_RELEASE_SAFELY(detailController);*/
    
    
    if ([self hasMore] && [self.queryList count] == indexPath.section ) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self  loadMoreData];
        
        return;
    }

    NewOrderListDTO *dto = [self.queryList objectAtIndex:indexPath.section];
    ProductListDTO *product = [dto.productList objectAtIndex:indexPath.row];
    
    if (!IsStrEmpty(product.supplierCode)) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"780803"], nil]];
        NewOrderSnxpressViewController *ctrl = [[NewOrderSnxpressViewController alloc]initWithStatus:eCShopDeliveryNew];
        ctrl.orderId = dto.orderId;
        ctrl.cShopCode = product.supplierCode;
        
        ctrl.hasNav = YES;
        ctrl.hidesBottomBarWhenPushed = YES;
        ctrl.isOrderDetailLogisticsQuery = NO;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    }else{
        
        ServiceDetailViewController *detailController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
        
        detailController.orderId = dto.orderId;
        detailController.orderItemId = product.orderItemId;
        
        detailController.hasNav = YES;
        detailController.hidesBottomBarWhenPushed = YES;
        detailController.verificationCode = @"";
        detailController.orderListDTO = dto;
        detailController.orderProductListDTO = product;
        
        [self.navigationController pushViewController:detailController animated:YES];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == (tableView.numberOfSections-1) && !self.isLastPage) {
        
//        return 50;
    }
    if ([self hasMore] && [self.queryList count] == section) {
        
        return  1;
    }

    else if([self.queryList count] == 0 && isStartLoad)
    {
        return 300;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

//    if (section == (tableView.numberOfSections-1) && !self.isLastPage) {
//        [self.backgroundView removeFromSuperview];
//        return self.loadMoreView;
//        
//    }else
    
    if([self.queryList count] == 0 && isStartLoad){
        return self.backgroundView;
//        return nil;
    }
    else
    {
        if (!IOS7_OR_LATER) {
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
            footerView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F8"];
            return footerView;
        }
        else
        {
            return nil;
        }
    }
}

@end
