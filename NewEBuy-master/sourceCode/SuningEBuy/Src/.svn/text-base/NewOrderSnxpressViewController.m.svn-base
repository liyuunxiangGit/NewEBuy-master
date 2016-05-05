//
//  NewOrderSnxpressViewController.m
//  SuningEBuy
//
//  Created by xmy on 2/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewOrderSnxpressViewController.h"
#import "NewOrderSnxpressCell.h"
#import "NewOrderSnxpressStatus.h"
#import "NewSnxpressDTO.h"

#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"

@interface NewOrderSnxpressViewController (){
    NSMutableArray  *_snxpressArray;
}

@end

@implementation NewOrderSnxpressViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (id)initWithStatus:(DeliveryInfoStatusNew)status
{
    self = [super init];
    
    if (self)
    {
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        __statusNew = status;
        
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"BTRefresh")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(bottomRefreshBtn)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        _snxpressArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}


- (void)loadView{
    
    [super loadView];
    
    self.title = L(@"InstallDetail");
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height  - 92;
    
    self.groupTableView.frame  = [self setCommonViewFrame:self.hasNav WithTab:YES];
    
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.groupTableView];
    
}

- (void)bottomRefreshBtn
{
    if([self.deliveryInforArray count] > 0)
    {
        [self.deliveryInforArray removeAllObjects];
        
    }
    
    [self sendServiceDetailInfoRequest];
    
    [_snxpressArray removeAllObjects];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(!isDetailInfoLoaded)
    {
        [self sendServiceDetailInfoRequest];

    }
}

#pragma mark -
#pragma mark - Service
- (ServiceDetailService *)serviceDetailServiceNew
{
    if (!_serviceDetailServiceNew) {
        
        _serviceDetailServiceNew = [[ServiceDetailService alloc] init];
        _serviceDetailServiceNew.delegate = self;
    }
    
    return _serviceDetailServiceNew;
}

- (void)getServiceDetailCompleteWithService:(ServiceDetailService *)service
                                     Result:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    if (__statusNew == eCShopDeliveryNew) {
        
        isDetailInfoLoaded = YES;
        if (self.isOrderDetailLogisticsQuery == YES) {
            if (IsArrEmpty(service.deliveryInforArray)) {
                self.deliveryInforArray = service.deliveryInforArray;
            }
            else
            {
                self.deliveryInforArray = [[NSMutableArray alloc] init];
                NewSnxpressDTO *dtoTmp = [[NewSnxpressDTO alloc] init];
                dtoTmp = [service.deliveryInforArray safeObjectAtIndex:[self.showParcel integerValue]];
                if (dtoTmp != nil) {
                    [self.deliveryInforArray addObject:dtoTmp];
                }
                
            }
            
        }
        else if (self.isOrderDetailLogisticsQuery == NO)
        {
            self.deliveryInforArray = service.deliveryInforArray;
        }
        
        
        if([ self.deliveryInforArray count] == 0)
        {
            if ([errorMsg isEqualToString:@"5015"]) {
                
                NSString *errorString = L(@"AlertNoOrderNumberOrLoginStateFailure");
                BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertTips") message:errorString delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
                [alert show];
                
            }else {
                
                [self presentSheet:L(@"MyEBuy_NoGoodsLogisticsQueryInformation")];
            }
            
        }
        
        [self.groupTableView reloadData];
    }
    else{
        
        if ([errorMsg eq:@"5015"]) {
            
            [self presentSheet:L(@"MyEBuy_NoGoodsLogisticsQueryInformation")];
            
        }else{
            
            [self presentSheet:errorMsg];
        }
    }
    
    [self.groupTableView reloadData];
    
    self.groupTableView.contentOffset = CGPointMake(0, 0);
    
}

#pragma mark -
#pragma mark -  发送请求
- (void)sendServiceDetailInfoRequest
{
    [self displayOverFlowActivityView];
    
    switch (__statusNew) {
            //订单中心非C店物流详情
        case eOrderCenterDeliveryNew:
        {
            [self.serviceDetailServiceNew beginGetServiceDetailWithOrderId:self.orderId
                                                               OrderItemId: self.orderItemId];
            break;
            
        }
            //首页非C店物流详情
        case eHomeDeliveryNew:{
            
            [self.serviceDetailServiceNew beginGetServiceDetailWithSaleNum:self.salNum];
            break;
        }
            //订单中心C店物流详情
        case eCShopDeliveryNew:{
            [self.serviceDetailServiceNew beginGetCShopServiceDetail:self.orderId cShopCode:self.cShopCode];
            break;
        }
        default:{
            
            [self removeOverFlowActivityView];
            break;
        }
    }
}

#pragma mark -
#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.deliveryInforArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.deliveryInforArray count] > 0) {
        
        NewSnxpressDTO *dto = [self.deliveryInforArray safeObjectAtIndex:section];
        
        return ([dto.deliveryItemList count]+1+1+[dto.productList count]) ;
        
    }
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewSnxpressDTO *dto = [self.deliveryInforArray safeObjectAtIndex:indexPath.section];

    if(IsNilOrNull(dto))
    {
        return 0;
    }
    
    
    if(indexPath.row == 0)
    {
        return 0;
    }
    else if (indexPath.row > 0 && indexPath.row <= [dto.productList count])
    {
        return 80;
        
    }
    else if (indexPath.row > 0 && indexPath.row == [dto.productList count] + 1)
    {
        CGSize stringSize = [dto.dlAddress heightWithFont:[UIFont systemFontOfSize:14.0f] width:220 linebreak:UILineBreakModeWordWrap];
        CGSize labelheight = [dto.dlAddress sizeWithFont:[UIFont systemFontOfSize:14.0f]];
        NSInteger lineNumber = ceil(stringSize.height/labelheight.height);
        
        return 85 + 20 * lineNumber;
    }
    else{
        
//        NewSnxpressDTO *dto = [self.deliveryInforArray safeObjectAtIndex:indexPath.section];
        
        NSDictionary *dic = [[NSDictionary alloc] init];
        
        if (indexPath.row == 1+[dto.productList count] + 1) {
            
            if ([dto.deliveryItemList count] >0) {
                
                dic = [dto.deliveryItemList safeObjectAtIndex:[dto.deliveryItemList count]-1];
                
            }
            
        }else if (indexPath.row == [dto.deliveryItemList count]+[dto.productList count]  + 1){
            
            dic = [dto.deliveryItemList safeObjectAtIndex:0];
            
        }else{
            
            dic = [dto.deliveryItemList safeObjectAtIndex:([dto.deliveryItemList count]-1-(indexPath.row-[dto.productList count]-2))];
            
        }
        
        return [NewOrderSnxpressCell expressHeight:dic];
    }
    
    return 0;
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
    
    NewSnxpressDTO *dto = [self.deliveryInforArray safeObjectAtIndex:indexPath.section];

    if (indexPath.row == 0) {
        
        static NSString *statusIdentifier = @"statusIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:statusIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:statusIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
                
        return cell;
        
    }
    if (indexPath.row > 0 && indexPath.row <= [dto.productList count])
    {
        NewSnxpressDTO *proDto = [self.deliveryInforArray safeObjectAtIndex:indexPath.section];

        static NSString *cellIdentifier = @"cellIdentifier";
        
        NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            
            cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        [cell setCshopExpressCell:proDto WithRow:indexPath.row];
        
        return cell;
        
    }
    else if (indexPath.row > 0 && indexPath.row == [dto.productList count] + 1)
    {
        static NSString *cellIdentifier = @"LogisticCompanyCell";
        LogisticCompanyDetailCell *cell = (LogisticCompanyDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LogisticCompanyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        }
        NewSnxpressDTO *dto = [[NewSnxpressDTO alloc] init];
        if ([self.deliveryInforArray count]>indexPath.section) {
            dto = [self.deliveryInforArray objectAtIndex:indexPath.section];
            [cell setItem:dto];
            return cell;
        }
        return nil;
        
    }
    else
    {
        NewOrderSnxpressCell *cell;
        
        NSUInteger row = (indexPath.row-([dto.productList count]+2));
        
        if ([_snxpressArray count]>row) {
            cell = [_snxpressArray objectAtIndex:row];
        }else{
            static NSString *cellIdentifier = @"NewOrderSnxpressCell";
            
            cell = [[NewOrderSnxpressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            
            
            if ([dto.deliveryItemList count] > 1) {
                
                NSDictionary *dic = [[NSDictionary alloc] init];
                
                if (indexPath.row == 1+[dto.productList count] + 1) {
                    
                    if ([dto.deliveryItemList count] >0) {
                        
                        dic = [dto.deliveryItemList safeObjectAtIndex:[dto.deliveryItemList count]-1];
                        
                    }
                    
                }else if (indexPath.row == [dto.deliveryItemList count]+[dto.productList count] + 1){
                    
                    dic = [dto.deliveryItemList safeObjectAtIndex:0];
                    
                }else{
                    
                    dic = [dto.deliveryItemList safeObjectAtIndex:([dto.deliveryItemList count]-1-(indexPath.row-[dto.productList count]-2))];
                    
                }
                
                if([dto.deliveryItemList count] == 1)
                {
                    [cell refreshCell:dic celType:TopCell WithMorePack:NO];
                    
                }
                else
                {
                    if(indexPath.row == [dto.productList count]+1 + 1)
                    {
                        [cell refreshCell:dic celType:TopCell WithMorePack:YES];
                        
                    }
                    else
                    {
                        if(indexPath.row == [dto.deliveryItemList count]+[dto.productList count] + 1)
                        {
                            [cell refreshCell:dic celType:BottomCell WithMorePack:YES];
                            
                        }
                        else
                        {
                            [cell refreshCell:dic celType:MiddleCell WithMorePack:YES];
                            
                        }
                        
                        
                    }
                    
                }
            }
            
            [_snxpressArray addObject:cell];
            
        }
        
        return cell;
        
        
    }
    
    return [[UITableViewCell alloc] init];
    
}

@end
