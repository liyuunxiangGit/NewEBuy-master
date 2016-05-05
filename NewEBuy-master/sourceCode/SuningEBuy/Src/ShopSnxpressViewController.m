//
//  ShopSnxpressViewController.m
//  SuningEBuy
//
//  Created by xmy on 26/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopSnxpressViewController.h"
#import "ServiceDetailDTO.h"
#import "InstallInforCell.h"
#import "ServiceDetailListInforCell.h"
#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"
@interface ShopSnxpressViewController ()

@end

@implementation ShopSnxpressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_snxpressService);
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
        lab.text = L(@"MyEBuy_NoGoodsLogisticsQueryInformation");
        lab.textAlignment = UITextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor blackColor];
        [_backgroundView addSubview:lab];
        
        
        }
    return _backgroundView;
}

- (ShopSnxpressService *)snxpressService
{
    if (!_snxpressService) {
        
        _snxpressService = [[ShopSnxpressService alloc] init];
        _snxpressService.delegate = self;
    }
    
    return _snxpressService;
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
//		_tableView.backgroundColor =[UIColor clearColor];
//		
//        _tableView.backgroundView = nil;
//	}
//	
//	return _tableView;
//}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.title = L(@"MyEBuy_StoreLogisticsQuery");
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.tableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
    SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"BTRefresh")
                                                                Style:SNNavItemStyleDone
                                                               target:self
                                                               action:@selector(bottomRefreshBtn)];
    self.navigationItem.rightBarButtonItem = rightButton;

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
    
//    [self.snxpressService sendShopSnxpressRequest:self.salNum WithCatalogId:@"10051"];
    
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
            return 140;
        }
        else
        {
            dto = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section-1];

        }
    }
    else{
        
        dto = [self.deliveryInfoArray safeObjectAtIndex:indexPath.section];
    }
    
    NSUInteger countArr = [dto.deliveryItemList count];
    
    ServiceDetailInfoDTO *infoDto = [dto.deliveryItemList safeObjectAtIndex:(countArr - indexPath.row)];
    
   
    
    if(indexPath.row == 0)
    {
        if(IsStrEmpty(dto.deliveryDate))
        {
            return 0;
        }
        else
        {
            return 80;
            
        }
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
            
            static NSString *CellIdentifier = @"installCell_shop";
            InstallInforCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[InstallInforCell alloc] initWithReuseIndetifier:CellIdentifier];
            }
            
            [cell setInstallInforCellContent:dto];
            
            return  cell;
//        }
//        
//        static NSString *CellIdentifier = @"serviceCell_shop1";
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
        if(indexPath.row == 0)
        {
//            static NSString *CellIdentifier = @"NProOrderListHeadCell_shopExpress22";
//            
//            NProOrderListHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (cell == nil)
//            {
//                cell = [[NProOrderListHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//                
//                cell.contentView.backgroundColor = [UIColor whiteColor];
//                cell.backgroundColor = [UIColor whiteColor];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            }
//            
//            [cell setZiYingExpressCell:dto WithIsInStall:NO WithCode:@""];
//            
//            
//            return cell;
            static NSString *cellIdentifier = @"cellIdentifier22";
            
            NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.backgroundColor = [UIColor whiteColor];
            }
            [cell setExpressCell:self.orderProductListDTO WithRow:indexPath.row];
            
            return cell;
        }
        else
        {
            static NSString *CellIdentifier = @"serviceCell_shop2";
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
            
#ifdef __IPHONE_7_0
            [cell setDetailListCellContentForIos7:infoDto];
#else
            [cell setDetailListCellContent:infoDto];
#endif
            
            
            return cell;
            

        }
    }
    
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
    
    UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    sectionHead.backgroundColor = [UIColor clearColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor blackColor];
    lab.text = headStr;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailDTO *dto = nil;
    if (0 < [self.installInforArray count]) {
        
        if (0 == indexPath.section) {
            
            return 140;
        }
        
        dto = [self.deliveryInfoArray objectAtIndex:indexPath.section-1];
    }
    else{
        
        dto = [self.deliveryInfoArray objectAtIndex:indexPath.section];
    }
    ServiceDetailInfoDTO *infoDto = [dto.deliveryItemList objectAtIndex:([dto.deliveryItemList count]-indexPath.row-1)];
    return [ServiceDetailListInforCell cellHeight:infoDto.itemText];
    
}
 */

- (ServiceDetailService *)serviceDetailService
{
    if (!_serviceDetailService) {
        
        _serviceDetailService = [[ServiceDetailService alloc] init];
        _serviceDetailService.delegate = self;
    }
    
    return _serviceDetailService;
}
#pragma mark - ServiceDetailServiceDelegate

- (void)sendServiceDetailInfoRequest
{
    [self displayOverFlowActivityView];
    
    [self.snxpressService sendShopSnxpressRequest:self.salNum WithCatalogId:@"10051"];
}

- (void)getShopSnxpress:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        isDetailInfoLoaded = YES;
        
        self.deliveryInfoArray = self.snxpressService.deliveryInforArray;
        self.installInforArray = self.snxpressService.installInforArray;
        
        if ([self.deliveryInfoArray count]+[self.installInforArray count] == 0) {

            if ([errorMsg isEqualToString:@"5015"]) {
                
                NSString *errorString = L(@"AlertNoOrderNumberOrLoginStateFailure");
                BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertTips") message:errorString delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
                [alert show];
            }else {
                [self presentSheet:L(@"MyEBuy_NoGoodsLogisticsQueryInformation")];
            }
            
        }
        [self.tableView reloadData];
        
    }else{
        
        [self presentSheet:errorMsg];
    }
}


- (void) alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
