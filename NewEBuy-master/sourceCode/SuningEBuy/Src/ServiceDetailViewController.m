//
//  ServiceDetailViewController.m
//  SuningEMall
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "ServiceDetailDTO.h"
#import "ServiceDetailInfoDTO.h"
#import "ServiceDetailInfoCell.h"
#import "ServiceDetailListInforCell.h"
#import "InstallInforCell.h"
#import "MyFavoriteViewController.h"
#import "ProductUtil.h"

#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"
@interface ServiceDetailViewController (){
    DeliveryInfoStatus __status;
}

- (void)sendServiceDetailInfoRequest;

@end

@implementation ServiceDetailViewController

@synthesize salNum = _salNum;

@synthesize orderId = _orderId;

@synthesize orderItemId = _orderItemId;

@synthesize deliveryInfoArray = _deliveryInfoArray;

@synthesize installInforArray = _installInforArray;

@synthesize serviceDetailService = _serviceDetailService;

@synthesize dtoServiceDetail = _dtoServiceDetail;

- (id)initWithStatus:(DeliveryInfoStatus)status
{
    self = [super init];
    
    if (self) 
    {
        self.title = L(@"InstallDetail");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        __status = status;
        
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"Refresh")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(bottomRefreshBtn)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        self.orderList = [[NSMutableArray alloc] init];

        self.hasNav = YES;
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_salNum);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderItemId);
    TT_RELEASE_SAFELY(_backgroundView);
    TT_RELEASE_SAFELY(_deliveryInfoArray);
    TT_RELEASE_SAFELY(_installInforArray);
    SERVICE_RELEASE_SAFELY(_serviceDetailService);
    
    TT_RELEASE_SAFELY(_dtoServiceDetail);

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Property methods

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
        
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
        lab.text = L(@"SSNoInfoOfThisProduct");
        lab.textAlignment = UITextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor blackColor];
        [_backgroundView addSubview:lab];
        
        
        //add go to Favourite button
        UIButton *btnFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFavorite setTitle:L(@"goFavourite") forState:UIControlStateNormal];
        UIImage *blueImage = [UIImage imageNamed:@"blueButton_new.png"];
        UIImage *bluestreImage = [blueImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        [btnFavorite setBackgroundImage:bluestreImage forState:UIControlStateNormal];
        btnFavorite.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btnFavorite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFavorite addTarget:self action:@selector(goToFavorite) forControlEvents:UIControlEventTouchUpInside];
        btnFavorite.frame = CGRectMake(30, 240, 125, 40);
        [_backgroundView addSubview:btnFavorite];
        
        //add go to Shopping button
        UIButton *btnShopping = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnShopping setTitle:L(@"goShopping") forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"yellowButton_new.png"];
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        [btnShopping setBackgroundImage:streImage forState:UIControlStateNormal];
        btnShopping.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btnShopping setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnShopping addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
        btnShopping.frame = CGRectMake(165, 240, 125, 40);
        [_backgroundView addSubview:btnShopping];
    }
    return _backgroundView;
}

- (ServiceDetailService *)serviceDetailService
{
    if (!_serviceDetailService) {
        
        _serviceDetailService = [[ServiceDetailService alloc] init];
        _serviceDetailService.delegate = self;
    }
    
    return _serviceDetailService;
}

//- (UITableView *)tableView
//{
//	if(!_tableView){
//		
//		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//		
//		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//		
//		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
//		
//		_tableView.scrollEnabled = YES;
//		
//		_tableView.userInteractionEnabled = YES;
//		
//		_tableView.delegate =self;
//		
//		_tableView.dataSource =self;
//		
//		_tableView.backgroundColor =[UIColor colorWithHexString:@"#F2F2F2"];
//		
////        _tableView.backgroundView = nil;
//	}
//	
//	return _tableView;
//}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.tableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    [self.view addSubview:self.tableView];
    
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
//    [self.view addSubview:self.bottomView];
//    self.bottomCell.yiGouBtn.hidden = YES;
//    self.bottomCell.bottomPayBtn.hidden = NO;
//    [self.bottomCell.bottomPayBtn setBackgroundImage:nil forState:UIControlStateNormal];
//    [self.bottomCell.bottomPayBtn setBackgroundImage:nil forState:UIControlStateHighlighted];
//    
//    [self.bottomCell.bottomPayBtn setTitle:@"刷新" forState:UIControlStateNormal];
//    [self.bottomCell.bottomPayBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateNormal ];
//    self.bottomCell.bottomPayBtn.frame = CGRectMake(self.view.frame.size.width-57, 10, 57, 35);
//    [self.bottomCell.bottomPayBtn addTarget:self action:@selector(bottomRefreshBtn) forControlEvents:UIControlEventTouchUpInside];
//   
    
    
    
}
- (void)bottomRefreshBtn
{
    if([self.deliveryInfoArray count] > 0)
    {
        [self.deliveryInfoArray removeAllObjects];
        
    }
    
    [self sendServiceDetailInfoRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    if (!isDetailInfoLoaded) {
        [self sendServiceDetailInfoRequest];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
}


#pragma mark -
#pragma mark Table View Delegate Methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (0 < [self.installInforArray count]) {
        
        return [self.deliveryInfoArray count] + 1;
        
    }
    
    return [self.deliveryInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    ServiceDetailDTO *dto = nil;
    if (0 < [self.installInforArray count]) {
        
        if (0 == section)
        {
            
        }
        else
        {
            dto = [self.deliveryInfoArray safeObjectAtIndex:section-1];

        }
    }
    else{
        
        dto = [self.deliveryInfoArray safeObjectAtIndex:section];
    }

    if (0 < [self.installInforArray count] && 0 == section) {
        
//        if (0 == section) {
        
            return [self.installInforArray count];
//        }
//            
//        ServiceDetailDTO *dto = [self.deliveryInfoArray objectAtIndex:section-1];
//        if([dto.deliveryItemList count] > 0)
//        {
//            return [dto.deliveryItemList count]+1;
//            
//        }
//        else
//        {
//            return 0;
//        }
    }
    else
    {
        
        if([dto.deliveryItemList count] > 0)
        {
            return [dto.deliveryItemList count]+1;
            
        }
        else
        {
            return 0;
        }

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailDTO *dto = nil;
    if (0 < [self.installInforArray count]) {
        
        if (0 == indexPath.section)
        {
            
        }
        else
        {
            dto = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section-1];

        }
    }
    else{
        
        dto = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section];
    }
    
    if (0 < [self.installInforArray count] &&  0 == indexPath.section)
    {
        return 140;

    }
    else
    {
        NSUInteger countArr = [dto.deliveryItemList count];
        
        ServiceDetailInfoDTO *infoDto = [dto.deliveryItemList safeObjectAtIndex:(countArr - indexPath.row)];
        
        if([dto.deliveryItemList count] > 0)
        {
            if(indexPath.row == 0)
            {
//                if(IsStrEmpty(dto.deliveryDate) && IsStrEmpty(self.verificationCode))
//                {
//                    return 0;
//                }
//                else
//                {
                    return 120;
                    
//                }
            }
            else
            {
                if(IsNilOrNull(infoDto))
                {
                    return 0;
                }
                
                return [ServiceDetailListInforCell cellHeight:infoDto.itemText];
                
            }

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
    
//    if(IOS7_OR_LATER)
//    {
//        view.backgroundColor = [UIColor uiviewBackGroundColor];
//        
//    }
//    else
//    {
        view.backgroundColor = [UIColor clearColor];
        
//    }
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NewSnxpressDTO *SnxpressDTO = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section];
    ServiceDetailDTO *dto = nil;
    if (0 < [self.installInforArray count]) {
        
        if (0 == indexPath.section) {
            
        }
        else{
            
            dto = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section-1];
        }
        
    }
    else{
        
        dto = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section];
        
    }
    
    
    if (0 < [self.installInforArray count] && 0 == indexPath.section) {
        
//        if (0 == indexPath.section) {

            ServiceDetailDTO *dto = [self.installInforArray safeObjectAtIndex:indexPath.row];
            
            static NSString *CellIdentifier = @"installCell";
            InstallInforCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[InstallInforCell alloc] initWithReuseIndetifier:CellIdentifier];
            }
            
            [cell setInstallInforCellContent:dto];
            
            return  cell;
//        }
//        
////        ServiceDetailDTO *dto = [self.deliveryInfoArray objectAtIndex:indexPath.section-1];
//        static NSString *CellIdentifier = @"serviceCell_0";
//        ServiceDetailListInforCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil)
//        {
//            cell = [[ServiceDetailListInforCell alloc] initWithReuseIndetifier:CellIdentifier];
//        }
//        ServiceDetailInfoDTO *infoDto = [dto.deliveryItemList objectAtIndex:([dto.deliveryItemList count]-indexPath.row)];
//        
//        if (1 == indexPath.row) {
//            
//            infoDto.cell = 1;
//        }
//        else if([tableView numberOfRowsInSection:indexPath.section] == indexPath.row+1){
//            
//            infoDto.cell = 2;
//        }
//        else{
//            
//            infoDto.cell = 3;
//        }
//        
//        [cell setDetailListCellContent:infoDto];
//        
//        return cell;

    }
    else
    {
//        NSLog(@"%d-%d",indexPath.section, indexPath.row);
//        if(indexPath.row == 0)
//        {
//            static NSString *CellIdentifier = @"NProOrderListHeadCell_snxpress22";
//            
//            NProOrderListHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (cell == nil)
//            {
//                cell = [[NProOrderListHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//                
//                cell.contentView.backgroundColor = [UIColor whiteColor];
//                cell.backgroundColor = [UIColor whiteColor];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            }
//            
//            [cell setZiYingExpressCell:dto WithIsInStall:NO WithCode:self.verificationCode];
//            
//            
//            return cell;
//            
//        }
        if (indexPath.row == 0)
        {
            static NSString *cellIdentifier = @"cellIdentifier";
            
            NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            [cell setNewExpressCell:self.orderProductListDTO WithRow:indexPath.row newOrderListDTO:dto];
            
            return cell;

        }
        else
        {
            static NSString *CellIdentifier = @"serviceCell_1";
            
            ServiceDetailListInforCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[ServiceDetailListInforCell alloc] initWithReuseIndetifier:CellIdentifier];
            }
            
            NSUInteger arrCount = [dto.deliveryItemList count];
            
            ServiceDetailInfoDTO *infoDto = [dto.deliveryItemList safeObjectAtIndex:(arrCount-indexPath.row)];
            
            if (3 <= [dto.deliveryItemList count]) {
                
                if (1 == indexPath.row ) {
                    
                    infoDto.cell = 1;
                }
                else if([tableView numberOfRowsInSection:indexPath.section ] == indexPath.row+1){
                    
                    infoDto.cell = 2;
                }
                else{
                    
                    infoDto.cell = 3;
                }
            }
            else if(1 == [dto.deliveryItemList count]){
                
                infoDto.cell = 4;
            }
            else if(2 == [dto.deliveryItemList count]){
                
                if (1 == indexPath.row ) {
                    
                    infoDto.cell = 1;
                }
                else{
                    
                    infoDto.cell = 2;
                }
            }
            
            //        [cell setDetailListCellContentForIos7:infoDto];
            
#ifdef __IPHONE_7_0
            [cell setDetailListCellContentForIos7:infoDto];
#else
            [cell setDetailListCellContent:infoDto];
#endif
            
            
            return cell;
            
        }

    }
        return [[UITableViewCell alloc] init];
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *headStr = @"";
    ServiceDetailDTO *dto = nil;
    if (0 < [self.installInforArray count]) {
        
        if (0 == section) {
            
            headStr = L(@"InstallState");
        }
        else{
            
            dto = [self.deliveryInfoArray objectAtIndex:section-1];
            headStr = dto.deliveryType;
        }
        
    }
    else{
        
        dto = [self.deliveryInfoArray objectAtIndex:section];
        headStr = dto.deliveryType;
        
    }
 
    UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 116)];
    sectionHead.backgroundColor = [UIColor whiteColor];
    
    UIImageView *separateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 1)];
    separateLine.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
    [sectionHead addSubview:separateLine];
    
    UIImageView *separateLineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 115, 320, 1)];
    separateLineBottom.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
    [sectionHead addSubview:separateLineBottom];

    EGOImageView *productImage = [[EGOImageView alloc] initWithFrame:CGRectMake(20, 55, 53, 53)];
    productImage.layer.borderWidth = 0.5f;
    productImage.layer.borderColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
    productImage.imageURL = [ProductUtil getImageUrlWithProductCode:_dtoServiceDetail.productCode size:ProductImageSize160x160];
    [sectionHead addSubview:productImage];
    
    UILabel *productDetail = [[UILabel alloc] init];
    CGSize maximumSize =CGSizeMake(228,MAXFLOAT);
    CGSize dateStringSize =[_dtoServiceDetail.productName sizeWithFont:[UIFont systemFontOfSize:12]
                                                     constrainedToSize:maximumSize
                                                         lineBreakMode:productDetail.lineBreakMode];
    productDetail.frame = CGRectMake(80, 56, 228, dateStringSize.height);
    productDetail.backgroundColor = [UIColor clearColor];
    productDetail.textAlignment = UITextAlignmentLeft;
    productDetail.numberOfLines = 0;
    productDetail.text = _dtoServiceDetail.productName;
    productDetail.lineBreakMode = UILineBreakModeWordWrap;
    productDetail.font = [UIFont systemFontOfSize:12];
    [sectionHead addSubview:productDetail];

    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor blackColor];
    lab.text = @"包裹一";// headStr;
    [sectionHead addSubview:lab];

    if ([dto.deliveryType isEqualToString:@"送货状态"]
        && 0 !=[dto.deliveryDate length]) {
        
        lab = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 210, 44)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = UITextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = [NSString stringWithFormat:@"预计到达时间：%@",dto.deliveryDate];
        [sectionHead addSubview:lab];
    }
    
    return sectionHead;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    
    if (0 < [self.installInforArray count]) {
        
        if (0 == section) {
            
            return L(@"InstallState");
        }
        
        ServiceDetailDTO *dto = [self.deliveryInfoArray objectAtIndex:section-1];
        return dto.deliveryType;
    }
    
    ServiceDetailDTO *dto = [self.deliveryInfoArray objectAtIndex:section];
    return dto.deliveryType;
}
*/


#pragma mark - ServiceDetailServiceDelegate

- (void)sendServiceDetailInfoRequest
{
    [self displayOverFlowActivityView];
    
    if (__status == eHomeDelivery) {
        [self.serviceDetailService beginGetServiceDetailWithSaleNum:self.salNum];
    }
    else if(__status == eShopOrderDelivery)
    {
        [self.serviceDetailService beginGetShopOrderServiceDetailWithOrderId:self.orderId
                                                                 OrderItemId:self.orderItemId];
    }
    else{
    
        [self.serviceDetailService beginGetServiceDetailWithOrderId:self.orderId 
                                                        OrderItemId: self.orderItemId];
    }
    
    
}

- (void)getServiceDetailCompleteWithService:(ServiceDetailService *)service
                                     Result:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];

    if (isSuccess) {
        isDetailInfoLoaded = YES;
        self.deliveryInfoArray = service.deliveryInforArray;
        self.installInforArray = service.installInforArray;
        
        if ([self.deliveryInfoArray count]+[self.installInforArray count] == 0) {
           
            if ([errorMsg isEqualToString:@"5015"]) {
                
                NSString *errorString = L(@"SSSorryForNotFound");
                BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips") message:errorString delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
                [alert show];
            }else {
               // [self.view addSubview:self.backgroundView];
                [self presentSheet:L(@"SSNoInfoOfThisProduct")];
            }

        }
        [self.tableView reloadData];
        
    }else{
        
        if ([errorMsg eq:@"5015"]) {
            
            [self presentSheet:L(@"SSNoInfoOfThisProduct")];
            
        }else{
            
            [self presentSheet:errorMsg];
        }
//        [self presentSheet:errorMsg];
    }
}


- (void) alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToFavorite
{
    //防止从购物车到我的收藏夹后不能返回到我的购物车而是返回到我的易购
    MyFavoriteViewController *myFavorite = [[MyFavoriteViewController alloc] init];
    [self.navigationController pushViewController:myFavorite animated:YES];
    TT_RELEASE_SAFELY(myFavorite);
}

- (void)goToHome
{
    [self jumpToHomeBoard];
}
@end
