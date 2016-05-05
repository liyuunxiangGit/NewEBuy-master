//
//  NShopOrderDetailViewController.m
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NShopOrderDetailViewController.h"
#import "ShopDetailHeadCell.h"
#import "ShopDetailDto.h"
#import "ShopOrderItemCell.h"
#import "ShopDetailProInfoCell.h"
#import "NewOrderSnxpressViewController.h"
#import "ServiceDetailViewController.h"
#import "ShopSnxpressViewController.h"

#import "OrderDetailCell.h"
#import "NewOrderProInfoCell.h"
#import "NSAttributedString+Attributes.h"


@interface NShopOrderDetailViewController ()

@end

@implementation NShopOrderDetailViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_detailService);
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self displayOverFlowActivityView];
    
    NSString *custNum = [UserCenter defaultCenter].userInfoDTO.custNum;

    [self.detailService sendShopOrderDetailRequestWithOmsOrderId:self.orderId
                                              WithOmsOrderItemId:self.orderItemId
                                           WithorderSourceSystem:self.orderSourceSystem
                                                     WithCustNum:custNum];
}

- (id)initDetailInfo
{
    self = [super init];

    if(self)
    {
        
    }
    
    return self;
    
}

- (void)loadView
{
    [super loadView];
    
    self.title = L(@"MyEBuy_OrderDetails");
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"member_myEbuy"),L(@"MyEBuy_StoreOrder"),self.title];

    self.groupTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];
    
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.groupTableView];
    
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    self.bottomCell.yiGouBtn.hidden = NO;
}

- (ShopOrderDetailService*)detailService
{
    if(!_detailService)
    {
        _detailService = [[ShopOrderDetailService alloc] init];
        
        _detailService.delegate = self;
    }
    
    return _detailService;
}

- (NSMutableArray*)shopDetailList
{
    if(!_shopDetailList)
    {
        _shopDetailList = [[NSMutableArray alloc] init];
    }
    
    return _shopDetailList;
}

#pragma mark -
#pragma service Detegate
- (void)getShopOrderDetail:(ShopOrderDetailService *)service success:(BOOL)isSuccess WithErrorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if(isSuccess)
    {
        self.shopDetailList = service.detailList;
                
        [self.groupTableView reloadData];
    }
    else
    {
        [self presentSheet:errorMsg];
    }
}

#pragma mark -
#pragma UITableView Delegate  And DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else  if(section == 1)
    {
        return [self.shopDetailList count];
    }
    else if(section == 4)
    {
        return 3;

    }
    else
    {
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailDto *dto = nil;
    
    if([self.shopDetailList count] > 0)
    {
        dto = [self.shopDetailList safeObjectAtIndex:0];
    }
    
    if(dto == nil || IsNilOrNull(dto))
    {
        return 0;
    }
    
    if(indexPath.section == 0)
    {
        return [OrderDetailCell setShopOrderDetailCellHeight:dto];
    }
    else if(indexPath.section == 1)
    {
        
        return 163;
    }
    else
    {
        return 40;
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopDetailDto *dto = nil;
    
    ShopDetailItemDto *itemDto = nil;
    
    if([self.shopDetailList count] > 0)
    {
        dto = [self.shopDetailList safeObjectAtIndex:0];
    }
    
    if([dto.orderItemList count] > indexPath.row)
    {
        itemDto = [dto.orderItemList safeObjectAtIndex:indexPath.row];
        
    }
    
    [self.bottomCell setShopBottomCellInfo:itemDto];
    
    if(indexPath.section == 0)
    {
        static NSString *str = @"OrderDetailCell_ShopDetail";
        OrderDetailCell *cell = (OrderDetailCell*) [tableView dequeueReusableCellWithIdentifier:str];
        
        if(cell == nil)
        {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        
        [cell setShopDetailHeadCellInfo:dto];
        
        return cell;

    }
    else if(indexPath.section == 1)
    {
        static NSString *listCell = @"ShopDetailProInfoCell_shopOrder";
        
        NewOrderProInfoCell *cell = (NewOrderProInfoCell*)[tableView dequeueReusableCellWithIdentifier:listCell];
        
        if (cell == nil) {
            
            cell = [[NewOrderProInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        //0只有一个cell 1第一个cell 2中间cell 3最后cell
        if([dto.orderItemList count] == 1)
        {
            [cell setShopDetailProInfoCellInfo:dto WithHeadDto:itemDto WithPosition:0];

        }
        else if([dto.orderItemList count] > 1)
        {
            if(indexPath.row == 0)
            {
                [cell setShopDetailProInfoCellInfo:dto WithHeadDto:itemDto WithPosition:1];

            }
            else if(indexPath.row == [dto.orderItemList count] - 1)
            {
                [cell setShopDetailProInfoCellInfo:dto WithHeadDto:itemDto WithPosition:3];

            }
            else
            {
                [cell setShopDetailProInfoCellInfo:dto WithHeadDto:itemDto WithPosition:2];

            }
        }
        else
        {
            [cell setShopDetailProInfoCellInfo:dto WithHeadDto:itemDto WithPosition:0];
 
        }
       
        cell.clipsToBounds = YES;
        
        [cell.snxpressQueryBtn addTarget:self action:@selector(snxpressQueryBtnDetailAction:event:) forControlEvents:UIControlEventTouchUpInside];
                
        return cell;

    }
    else
    {
        static NSString *detailWayCellId = @"detailWayCellId_shopOrder";
        
        OrderDetailWayCell *cell = (OrderDetailWayCell*)[tableView dequeueReusableCellWithIdentifier:detailWayCellId];
        
        if(cell == nil)
        {
            cell = [[OrderDetailWayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailWayCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        ShopDetailItemDto *nameDto = [[ShopDetailItemDto alloc] init];
        
        if([dto.orderItemList count] > 0)
        {
            nameDto = [dto.orderItemList safeObjectAtIndex:0];
            
        }

        [cell setShopDetailHeadCellInfo:dto WithItemDto:nameDto WithSectionPosition:indexPath.section WithCellPosition:indexPath.row];
        
        return cell;

    }
    
    
    
    return [[UITableViewCell alloc] init];
}

#pragma btnsAction

- (void)snxpressQueryBtnDetailAction:(id)sender event:(id)event
{
    
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    
    ShopDetailDto *dto = [self.shopDetailList safeObjectAtIndex:0];
    
    
    ShopDetailItemDto *itemDto = [dto.orderItemList safeObjectAtIndex:indexPath.row];
    
/*    下单时间2013年4月1日前的订单调用接口《智能终端接口概要设计.docx》  2.15.11 线下SAP单号查询物流  传入sap单号  SNMobileLogisticsInfoView
    下单时间2013年4月1日后的订单调用接口《智能终端接口概要设计.docx》  2.15.2  送货/安装详情接口【服务易栈】 传入 omsItemId   SNIPhoneDistributionServiceDetailInfoView*/
      
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
    //设置时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       
    NSDate *orderTempDate = [dateFormatter dateFromString:dto.orderDttm];
    
    NSDate *lastestDate = [dateFormatter dateFromString:@"2013-04-02 00:00:00"];
    
    NSComparisonResult dateComparResult = [orderTempDate compare:lastestDate];

    ProductListDTO *productDto = [[ProductListDTO alloc] init];
    productDto.productName = itemDto.commodityName;
    productDto.productCode = itemDto.commodityCode;
    productDto.productId = itemDto.sourceOrderItemId;

    if(dateComparResult == NSOrderedAscending)
    {
        ShopSnxpressViewController *detailViewController = [[ShopSnxpressViewController alloc] init];
                
        detailViewController.salNum = itemDto.sapOrderId;
        
        detailViewController.hasNav = YES;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.orderProductListDTO = productDto;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else
    {
        
        ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc]initWithStatus:eShopOrderDelivery];
        
//        detailViewController.salNum = itemDto.sourceOrderItemId;
        
        
        //http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet/SNIPhoneDistributionServiceDetailInfoView?storeId=10052&catalogId=10051&omsOrderId =6333005& omsOrderItemId =104281001
        
        detailViewController.orderItemId = self.orderItemId;
        
        detailViewController.orderId = self.orderId;
        detailViewController.verificationCode = @"";
//        detailViewController.orderListDTO = dto;
        detailViewController.orderProductListDTO = productDto;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end
