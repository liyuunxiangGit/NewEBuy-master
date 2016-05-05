//
//  OrderDetailViewController.m
//  SuningEBuy
//
//  Created by xmy.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "OrderDetailViewController.h"

#import "OrderDetailItemInfoCell.h"

#import "OrderNamesItemCell.h"

#import "ServiceDetailViewController.h"

#import "ProductDisOrderSubmitViewController.h"

#import "PaymentModeViewController.h"


#import "NewDetailDeliveryInfoCell.h"
#import "NewDetailOrderInfoCell.h"
#import "NewOrderSnxpressViewController.h"
#import "EvalutionDTO.h"
#import "EvalutionContentViewController.h"
#import "ProductDetailViewController.h"

#import "OSGetStatusCommand.h"
#import "OSLeaveMessageViewController.h"
#import "NOrderContactCell.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "OrderDetailCell.h"
#import "OrderDetailBtnCell.h"
#import "ConfirmReceiptWebViewController.h"
//#import "ReturnGoodsListDTO.h"
//#import "ReturnGoodsSubmitViewController.h"
//#import "CShopReturnApplicationViewController.h"
#import "ReturnGoodsListViewController.h"
#import "ActiveEfubaoViewController.h"
#import "OrderDetailLeaveMessageCell.h"
#import "OrderAmountCell.h"
#import "ElectronicInvoiceDetailViewController.h"//电子发票类
#import "QRCodeGenerator.h"

@interface OrderDetailViewController()
{
    
}

//- (void)setRightNavItemEnable:(BOOL)isEnable;
@property (nonatomic,strong) UIButton  *ercodeBackBtn;
@end

/*********************************************************************/


@implementation OrderDetailViewController

@synthesize service = _service;

@synthesize orderId = _orderId;

@synthesize orderDetailTableView = _orderDetailTableView;

@synthesize isOrderDetailLoaded = _isOrderDetailLoaded;

@synthesize orderDetailDisplayLists = _orderDetailDisplayLists;

@synthesize orderNamesDTO = _orderNamesDTO;

@synthesize listType = _listType;

@synthesize memberOrderDetailsDTO = _memberOrderDetailsDTO;

@synthesize dataProductBasic = _dataProductBasic;

@synthesize isSubmitDisOrder = _isSubmitDisOrder;

@synthesize orderItemsId = _orderItemsId;

@synthesize prepayTrueAmount = _prepayTrueAmount;

@synthesize displayorderService=_displayorderService;

@synthesize secondPayService = _secondPayService;
@synthesize CShopLists = _CShopLists;
- (void)dealloc {
    
    SERVICE_RELEASE_SAFELY(_service);
    
    TT_RELEASE_SAFELY(_orderId);
    
    TT_RELEASE_SAFELY(_orderDetailTableView);
    
    TT_RELEASE_SAFELY(_orderDetailDisplayLists);
    
    TT_RELEASE_SAFELY(_orderNamesDTO);
    
    TT_RELEASE_SAFELY(_memberOrderDetailsDTO);
    TT_RELEASE_SAFELY(_shaiDanDetailsDTO);
    TT_RELEASE_SAFELY(_reasonList);
    
    
    TT_RELEASE_SAFELY(_dataProductBasic);
    
    TT_RELEASE_SAFELY(_orderItemsId);
    
    TT_RELEASE_SAFELY(_prepayTrueAmount);
    
    SERVICE_RELEASE_SAFELY(_displayorderService);
    
    SERVICE_RELEASE_SAFELY(_evalutionService);
    
    SERVICE_RELEASE_SAFELY(_secondPayService);
    //    SERVICE_RELEASE_SAFELY(_applianceService);
    //    SERVICE_RELEASE_SAFELY(_cShopApplianceService);
    //    TT_RELEASE_SAFELY(_prepareDto);
    TT_RELEASE_SAFELY(_evaDetailDto);
    TT_RELEASE_SAFELY(_dto);
    TT_RELEASE_SAFELY(_CShopLists);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [CommandManage cancelCommandByClass:[OSGetStatusCommand class]];
}

- (void)snxpressQueryDelegate
{
    
}

//- (id)initWithDTO:(MemberOrderNamesDTO *)dto WithItemDTO:(NewOrderItemListDTO*)itemDto
- (id)initWithDTO:(MemberOrderNamesDTO *)dto
{
    
    if (self = [super init ]) {
        
        self.title = L(@"the detail orderList");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
		self.orderId = dto.orderId;
        
        self.orderNamesDTO = dto;
        
        self.prepayTrueAmount = dto.prepayAmount;
        
        _service = [[OrderDetailService alloc]init];
        
        _service.delegate = self;
        
        _displayorderService=[[ProductDetailSubmitService alloc]init];
        
        _displayorderService.delegate=self;
        
        _onlineStatus = -1;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshData)
                                                     name:RETURN_GOODS_OK_MESSAGE
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ReceiptConfirmSuccess)
                                                     name:RECEIPT_CONFIRM_SUCCESS
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(activedJumpConfirmGoods)
                                                     name:@"BackConfirmGoods" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DisplayOrderOrEvaluationSucessRefresh) name:@"DisplayOrderOrEvaluationSucessRefresh" object:nil];

        self.CSLists = [[NSMutableArray alloc ] init];
        self.LogisticsShowDic = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
    
}


//视图出现前判断订单商品详细信息是否加载国，若未加载，则发送订单商品详细信息请求
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	if(_isOrderDetailLoaded == NO  || self.orderDetailDisplayLists == nil)
    {
        if ([UserCenter defaultCenter].isLogined)
        {
            [self getData];
            
        }else{
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            
            loginViewController.loginDelegate = self;
            
            loginViewController.loginDidOkSelector = @selector(getData);
            
            AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                     initWithRootViewController:loginViewController];
            
            [self presentModalViewController:userNav animated:YES];
            
            TT_RELEASE_SAFELY(loginViewController);
            
            TT_RELEASE_SAFELY(userNav);
        }
    }
//    self.isShowTopPicture = [SNSwitch isShowOrderTopPicture];
}

-(void)getData
{
    [self refreshData];
    
    if (!_isGetOnlineStatusOk)
    {
        [self getOnlineServiceStatus];
    }
}


//加载视图时发送订单商品详细信息请求
- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.orderDetailTableView.frame = [self setViewFrame:self.hasNav];
    
    [self.view addSubview:self.orderDetailTableView];
    
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    
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

//construct the displays of the orderDetailTableView
- (UITableView*)orderDetailTableView
{
	
	if(!_orderDetailTableView){
		
        if(IOS7_OR_LATER)
        {
            _orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            
        }
        else
        {
            _orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            
        }
        
        //		_orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		
		[_orderDetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_orderDetailTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_orderDetailTableView.scrollEnabled = YES;
		
		_orderDetailTableView.userInteractionEnabled = YES;
		
		_orderDetailTableView.delegate =self;
		
		_orderDetailTableView.dataSource =self;
		
		_orderDetailTableView.backgroundColor =[UIColor uiviewBackGroundColor];
        
        _orderDetailTableView.backgroundView = nil;
	}
	
	return _orderDetailTableView;
}


#pragma mark -
#pragma mark Table View Delegate Methods
/*
 - (UIImage *)bgImgeAtIndexPath:(NSIndexPath *)indexPath
 {
 int rowCountSection = [self tableView:self.orderDetailTableView numberOfRowsInSection:indexPath.section];
 
 if (rowCountSection == 1)
 {
 return [UIImage streImageNamed:@"yellowbackground.png"];
 }
 else if (indexPath.row == 0)
 {
 return [UIImage streImageNamed:@"yellow_top.png"];
 }
 else if (indexPath.row == rowCountSection-1)
 {
 return [UIImage streImageNamed:@"yellow_buttom.png"];
 }
 else
 {
 return [UIImage streImageNamed:@"yellow_mid.png"];
 }
 }
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if ([_isShowTopPicture eq:@"1"]) {
//        if (section == 0) {
//            return 80;
//        }
//    }
    if (section == 6)
    {
        return 0.1;
        //        if (!IsStrEmpty(self.orderRemark) && _isCShopProduct == YES) {
        //            return 0.1;
        //        }
        //        else
        //        {
        //            return 15;
        //        }
    }
    return 15;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
//    if ([_isShowTopPicture eq:@"1"]) {
//        if (section == 0) {
//            view.frame = CGRectMake(0, 0, 320, 80);
//            NSString *url = [SNSwitch orderTopPicture];
//            self.topPictureImageView.imageURL = [NSURL URLWithString:url];
//            [view addSubview:self.topPictureImageView];
//        }
//    }
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberOrderNamesDTO *dto = [self.detailHeadLists safeObjectAtIndex:0];
    MemberOrderDetailsDTO *detailDto = nil;
    NSLog(@"%d",indexPath.section);
    if(self.isCShopProduct == YES)
    {
        detailDto = [self.CSLists safeObjectAtIndex:0];
    }
    else
    {
        detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
    }
    
    if(IsNilOrNull(detailDto) || IsNilOrNull(dto))
    {
        return 0;
    }
   
    if(indexPath.section == 1)
    {
        
        if ((indexPath.row == 1 || indexPath.row == 2) && self.isCShopProduct == NO)
        {
            //合约机
            if ([detailDto.simOrPhoneFlag eq:@"1"] || [detailDto.simOrPhoneFlag eq:@"2"])
            {
                return 80;
            }
        }
        if (self.isCShopProduct == YES)
        {
            MemberOrderDetailsDTO *detailDtoNext = [[MemberOrderDetailsDTO alloc] init];
            detailDtoNext = [self.CSLists safeObjectAtIndex:indexPath.row];
            if(IsNilOrNull(detailDtoNext))
            {
                return 0;
            }
            
            if ([detailDtoNext.isconfirmReceipt isEqualToString:@"true"] && self.isCShopProduct == YES)
            {
                return 163;
            }
            
        }
        if (self.isCShopProduct == YES) {
            NSString *num = [self.LogisticsBtnShowArr objectAtIndex:indexPath.row];
            if ([num eq:@"1"]) {
                return 163;
            }
        }
        
        MemberOrderDetailsDTO *detailDto2 = nil;
        
        if(self.isCShopProduct == YES)
        {
            detailDto2 = [self.CSLists safeObjectAtIndex:indexPath.row];
        }
        else
        {
            detailDto2 = [self.orderDetailDisplayLists safeObjectAtIndex:indexPath.row];
        }
        
        if ([detailDto2.commentOrNot eq:@"1"] || [detailDto2.showOrNot eq:@"1"]) {
            return 163;
        }
        
        if(IsNilOrNull(detailDto2))
        {
            return 0;
        }
        
        if([detailDto2.exWarrantyFlag isEqualToString:@"1"])
        {
            return  80;
        }
        else
        {
            //只有一个cell
            if([self tableView:self.orderDetailTableView numberOfRowsInSection:1] == 1)
            {
                return [NewOrderProInfoCell orderProInfoNewCellHeight:dto Withrow:3];
                
            }
            else //多个cell
            {
                if(indexPath.row == 0)
                {
                    return [NewOrderProInfoCell orderProInfoNewCellHeight:dto Withrow:0];//第一个cell
                    
                }
                else if(indexPath.row == [self tableView:self.orderDetailTableView numberOfRowsInSection:1]-1)
                {
                    return [NewOrderProInfoCell orderProInfoNewCellHeight:dto Withrow:1];//最后一个cell
                    
                }
                else
                {
                    return [NewOrderProInfoCell orderProInfoNewCellHeight:dto Withrow:2];//中间cell
                }
            }
        }
        
    }
    else if(indexPath.section == 0)
    {
        return [OrderDetailCell setOrderDetailCellHeight:detailDto];
    }
    else if (indexPath.section == 4)//订单金额
    {
        if(IsNilOrNull(detailDto))
        {
            return 0;
        }
        return 117;
    }
    else if (indexPath.section == 3)//发票类型
    {
        if(IsNilOrNull(detailDto))
        {
            return 0;
        }
        return 40;
    }
    else if (indexPath.section == 6)//订单留言
    {
        if (!IsStrEmpty(self.orderRemark) && _isCShopProduct == YES) {
            CGSize stringSize = [self.orderRemark heightWithFont:[UIFont systemFontOfSize:14.0f] width:270 linebreak:UILineBreakModeWordWrap];
            
            CGSize labelHeight = [self.orderRemark sizeWithFont:[UIFont systemFontOfSize:14.0f]];
            
            NSInteger lineNumber = ceil(stringSize.height/labelHeight.height);
            
            return 35 + 10 + 22*lineNumber;
        }
        else
        {
            return 0;
        }
    }
    else if(indexPath.section == 7)//退款或者取消
    {
        BOOL canCancelOrder = dto.merchantOrderNew ;
        
        if([dto.oiStatus isEqualToString:@"C"] ||
           [dto.oiStatus isEqualToString:@"SC"] ||
           [dto.oiStatus isEqualToString:@"SD"] ||
           [dto.oiStatus isEqualToString:@"WD"] ||
           [dto.oiStatus isEqualToString:@"SOMED"] ||
           ([dto.oiStatus hasPrefix:@"M"] &&
            [dto.ormOrder isEqualToString:@"11601"]))
        {
            if(([dto.oiStatus isEqualToString:@"C"]  ||
               [dto.oiStatus isEqualToString:@"SC"] ||
               [dto.oiStatus isEqualToString:@"SD"] ||
               [dto.oiStatus isEqualToString:@"WD"]  ||
               [dto.oiStatus isEqualToString:@"SOMED"] )&& ![dto.ormOrder isEqualToString:@"11601"])
            {
//                if(IsNilOrNull(detailDto))
//                {
//                    return 0;
//                }
                if ([dto.canReturnOrder eq:@"1"])
                {
                    if(IsNilOrNull(detailDto))
                    {
                        return 0;
                    }

                    return 40;
                }
                else if(canCancelOrder == YES)
                {
                    if(IsNilOrNull(detailDto))
                    {
                        return 0;
                    }
                    
                    return 40;
                }

                else
                {
                    return 0;
                }
            }
            else
            {
                if ([dto.canReturnOrder eq:@"1"])
                {
                    if(IsNilOrNull(detailDto))
                    {
                        return 0;
                    }
                    
                    return 40;
                }

                else if(canCancelOrder == YES)
                {
                    if(IsNilOrNull(detailDto))
                    {
                        return 0;
                    }
                    
                    return 40;
                }
                else
                {
                    return 0;
                }
            }
            
            
        }
        else
        {
            return [OrderDetailBtnCell setDetailBtncellInfoHeight:dto];
            
        }
        

        
    }
    else
    {
        if(indexPath.section == 5 && indexPath.row == 3)//在线客服电话号码
        {
            
            if( _onlineStatus != -1)
            {
                return [NOrderContactCell height];
                
            }
            //不显示在线客服但是是自营商品时展示客服电话
            else if (_onlineStatus == -1)
            {
                if (self.isCShopProduct == NO) {
                    return [NOrderContactCell height];
                }
            }
            else
            {
                return 0;
            }
        }
        
        return [OrderDetailWayCell setOrderDetailWayCellHeight:detailDto];
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 8;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    MemberOrderNamesDTO *dto = [self.detailHeadLists safeObjectAtIndex:0];
    MemberOrderDetailsDTO *detailDto = nil;
    
    if(self.isCShopProduct == YES)
    {
        detailDto = [self.CSLists safeObjectAtIndex:0];
    }
    else
    {
        detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
    }
    
    if(IsNilOrNull(detailDto) || IsNilOrNull(dto))
    {
        return 0;
    }
    
    if(section == 0 || section == 6 || section == 7)
    {
        return 1;
    }
    else if(section == 1)
    {
        if(self.isCShopProduct == YES)
        {
            
            return [self.CSLists count];
        }
        else if(self.isCShopProduct == NO)
        {
            if ([detailDto.simOrPhoneFlag eq:@"1"]) {
                return [self.orderDetailDisplayLists count] + 2;
            }
            else if ([detailDto.simOrPhoneFlag eq:@"2"])
            {
                return [self.orderDetailDisplayLists count] + 1;
            }
            else
            {
                return [self.orderDetailDisplayLists count];
            }
        }
        else
        {
            return 0;
            
        }
    }
    else if (section == 3)
    {
        if ([detailDto.taxType eq:@"2"])//电子发票
        {
            return 3;
        }
        else
        {
            return 2;
        }
    }
    else if (section == 4)
    {
        return 1;
    }
    else if(section == 5)
    {
        NSInteger rowCount = 3;
        
        if (_onlineStatus != -1)
        {
            rowCount ++;
        }
        //不显示在线客服但是是自营商品时展示客服电话
        else if (_onlineStatus == -1)
        {
            if (self.isCShopProduct == NO) {
                rowCount ++;
            }
        }
        
        return rowCount;
    }
    else
    {
        return 2;
    }
    
    return 0;
}


//将订单信息传送到cell中显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberOrderDetailsDTO *detailDto = nil;
    
    if(self.isCShopProduct == YES)
    {
        detailDto = [self.CSLists safeObjectAtIndex:0];
    }
    else
    {
        detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
    }
    
    MemberOrderNamesDTO *headDTO = [self.detailHeadLists objectAtIndex:0];
    
    
    
    [self.bottomCell setBottomCellInfo:headDTO productDto:detailDto WithYiGouBtn:nil];
    
    self.bottomCell.userInteractionEnabled = YES;
    [self.bottomCell.bottomPayBtn addTarget:self action:@selector(changeView:event:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomCell.bottomPayBtn.tag = 101;
    
    if(indexPath.section == 0)
    {
        static NSString *detailCellId = @"detailCellId";
        
        OrderDetailCell *cell = (OrderDetailCell*)[tableView dequeueReusableCellWithIdentifier:detailCellId];
        
        if(cell == nil)
        {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setOrderDetailCellInfo:detailDto WithNameDto:headDTO];
        
        
        return cell;
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            if([detailDto.simOrPhoneFlag eq:@"1"])
            {
                static NSString *simProductCellIndentifier = @"SimProductCell_1";
                NewOrderProInfoCell *cell = (NewOrderProInfoCell*)[tableView dequeueReusableCellWithIdentifier:simProductCellIndentifier];
                
                if(cell == nil){
                    
                    cell = [[NewOrderProInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simProductCellIndentifier];
                    
                    cell.contentView.backgroundColor = [UIColor clearColor];
                    
                    cell.backgroundColor = [UIColor cellBackViewColor];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
                
                dto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
                
                [cell setSimCardInfo:dto WithHeadDto:headDTO];
                
                return cell;
                
                
            }
            else if ([detailDto.simOrPhoneFlag eq:@"2"])
            {
                static NSString *simProductCellIndentifier = @"SimProductCell_2";
                OrderAmountCell *cell = (OrderAmountCell*)[tableView dequeueReusableCellWithIdentifier:simProductCellIndentifier];
                
                if(cell == nil){
                    
                    cell = [[OrderAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simProductCellIndentifier];
                    
                    cell.contentView.backgroundColor = [UIColor clearColor];
                    
                    cell.backgroundColor = [UIColor cellBackViewColor];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
                
                dto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
                
                [cell setSimCardInfo:dto];
                return cell;
                
            }
        }
        else if (indexPath.row == 2)
        {
            if ([detailDto.simOrPhoneFlag eq:@"1"]) {
                static NSString *contractMachineInfoCellIndentifier = @"ContractMachineInfoCell";
                OrderAmountCell *cell = (OrderAmountCell*)[tableView dequeueReusableCellWithIdentifier:contractMachineInfoCellIndentifier];
                
                if(cell == nil){
                    
                    cell = [[OrderAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contractMachineInfoCellIndentifier];
                    
                    cell.contentView.backgroundColor = [UIColor clearColor];
                    
                    cell.backgroundColor = [UIColor cellBackViewColor];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    
                }
                
                MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
                
                dto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
                
                [cell setSimCardInfo:dto];
                return cell;
                
            }
        }
    
            static NSString *NewOrderProInfoCellIdentifier = @"NProOrderProductInfoCell_1";
            
            NewOrderProInfoCell *cell = (NewOrderProInfoCell*)[tableView dequeueReusableCellWithIdentifier:NewOrderProInfoCellIdentifier];
            
            if(cell == nil){
                
                cell = [[NewOrderProInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewOrderProInfoCellIdentifier];
                
                cell.contentView.backgroundColor = [UIColor clearColor];
                
                cell.backgroundColor = [UIColor cellBackViewColor];
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
            
            if(self.isCShopProduct == YES)
            {
                
                dto = [self.CSLists safeObjectAtIndex:indexPath.row];
                
            }
            else
            {
                dto = [self.orderDetailDisplayLists safeObjectAtIndex:indexPath.row];
                
            }
            
            MemberOrderDetailsDTO *detailDtoNext = nil;
            
            if(self.isCShopProduct == YES)
            {
                
                detailDtoNext = [self.CSLists safeObjectAtIndex:indexPath.row];
            }
            else
            {
                detailDtoNext = [self.orderDetailDisplayLists safeObjectAtIndex:indexPath.row+1];
            }
            BOOL isExWarrantyFlag = NO;
            
            if([detailDtoNext.exWarrantyFlag isEqualToString:@"1"])
            {
                isExWarrantyFlag = YES;
            }
            else
            {
                isExWarrantyFlag = NO;
            }
            
            //        headDTO.oiStatus = self.orderSt;
            //row 0为第一个 1为最后一个 2为中间 3只有一个
            
            if([self tableView:self.orderDetailTableView numberOfRowsInSection:1] == 1)
            {
                [cell setDetailNewOrderProInfo:dto WithHeadDto:headDTO WithCodeBOOL:self.isCShopProduct WithRow:3 WithFinish:self.isFinishAccept WithDelivery:self.isDelivery WithIsYangGuangBao:isExWarrantyFlag logisticsShowReference:[self.LogisticsBtnShowArr safeObjectAtIndex:indexPath.row]];
                
            }
            else
            {
                if(indexPath.row == 0)
                {
                    [cell setDetailNewOrderProInfo:dto WithHeadDto:headDTO WithCodeBOOL:self.isCShopProduct WithRow:0 WithFinish:self.isFinishAccept WithDelivery:self.isDelivery WithIsYangGuangBao:isExWarrantyFlag logisticsShowReference:[self.LogisticsBtnShowArr safeObjectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.row == [self tableView:self.orderDetailTableView numberOfRowsInSection:1]-1)
                {
                    [cell setDetailNewOrderProInfo:dto WithHeadDto:headDTO WithCodeBOOL:self.isCShopProduct WithRow:1 WithFinish:self.isFinishAccept WithDelivery:self.isDelivery WithIsYangGuangBao:isExWarrantyFlag logisticsShowReference:[self.LogisticsBtnShowArr safeObjectAtIndex:indexPath.row]];
                    
                }
                else
                {
                    [cell setDetailNewOrderProInfo:dto WithHeadDto:headDTO WithCodeBOOL:self.isCShopProduct WithRow:2 WithFinish:self.isFinishAccept WithDelivery:self.isDelivery WithIsYangGuangBao:isExWarrantyFlag logisticsShowReference:[self.LogisticsBtnShowArr safeObjectAtIndex:indexPath.row]];
                    
                }
                
            }
            
            [cell cShopOrderLine:detailDtoNext isCShopList:self.isCShopProduct];
            cell.clipsToBounds = YES;
            
            //        [cell.returnGoodsBtn addTarget:self action:@selector(returnGoodsBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.confirmBtn.tag = indexPath.row;
            cell.snxpressQueryBtn.tag = indexPath.row;
            if ([detailDtoNext.isconfirmReceipt isEqualToString:@"true"] && self.isCShopProduct == YES) {
                cell.confirmBtn.hidden = NO;
                
            }
            else
            {
                cell.confirmBtn.hidden = YES;
                //            cell.confirmBtn.hidden = NO;
            }
            [cell.confirmBtn addTarget:self action:@selector(confirmAcceptBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
            [cell.snxpressQueryBtn addTarget:self action:@selector(snxpressQueryBtnDetailAction:event:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.pingJiaBtn addTarget:self action:@selector(pingJiaBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.shaiDanBtn addTarget:self action:@selector(displayOrderBtn:event:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.payBtn addTarget:self action:@selector(changeView:event:) forControlEvents:UIControlEventTouchUpInside];
            cell.payBtn.tag = 101;
            
            [cell.bothBtn addTarget:self action:@selector(commentAndShowBtn:event:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.cancelOrderBtn addTarget:self action:@selector(changeView:event:) forControlEvents:UIControlEventTouchUpInside];
            cell.cancelOrderBtn.tag = 102;
            
            NSLog(@"%@",cell.subviews);
            return cell;
        }
    
    else if(indexPath.section == 5 && indexPath.row == 3)
    {
        static NSString *nordercontaceCellIndentifier = @"nordercontaceCellIndentifier_5";
        NOrderContactCell *cell = [tableView dequeueReusableCellWithIdentifier:nordercontaceCellIndentifier];
        if (!cell) {
            cell = [[NOrderContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nordercontaceCellIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.userInteractionEnabled = YES;
            cell.contentView.userInteractionEnabled = YES;
            if (self.isCShopProduct)
            {
                [cell.cShopConnect addTarget:self action:@selector(contactCShop) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [cell.shopConnect addTarget:self action:@selector(contactSNShop) forControlEvents:UIControlEventTouchUpInside];
                [cell.Phone addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
            }
            if(IOS7_OR_LATER)
            {
                
            }
            else
            {
                cell.backgroundColor = [UIColor whiteColor];
            }
        }
        
        if( _onlineStatus != -1)
        {
            [cell setState:self.isCShopProduct status:_onlineStatus];
            
        }
        else if (_onlineStatus == -1 && self.isCShopProduct == NO)
        {
            [cell setPhone:self.isCShopProduct status:_onlineStatus];
        }
        
        else
        {
            return [[UITableViewCell alloc] init];
        }
        
        [cell setNeedsDisplay];
        
        return cell;
        
    }
    else if(indexPath.section == 7)
    {
        static NSString *btnsCellId = @"detailWayCellId_proOrder";
        
        OrderDetailBtnCell *cell = (OrderDetailBtnCell*)[tableView dequeueReusableCellWithIdentifier:btnsCellId];
        
        if(cell == nil)
        {
            cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnsCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor clearColor];
            
            cell.backgroundColor = [UIColor clearColor];
        }
        
        //申请退货
        [cell.returnGoodsBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.cancelOrderBtn addTarget:self action:@selector(changeView:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.cancelOrderBtn.tag = 102;
        
        [cell setDetailBtncellInfo:headDTO WithOrderStatus:self.orderSt];
        
        return cell;
        
    }
    else if (indexPath.section == 6)
    {
        static NSString *detailLeaveMessageCellId = @"detailLeaveMessageCellId";
        
        OrderDetailLeaveMessageCell *cell = (OrderDetailLeaveMessageCell *)[tableView dequeueReusableCellWithIdentifier:detailLeaveMessageCellId];
        
        if (cell == nil) {
            cell = [[OrderDetailLeaveMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailLeaveMessageCellId];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            cell.backgroundColor = [UIColor whiteColor];
            
        }
        if (!IsStrEmpty(self.orderRemark) && _isCShopProduct == YES) {
            [cell setItem:self.orderNamesDTO];
            
        }
        //        if(!IOS7_OR_LATER)
        //        {
        //            cell.backgroundColor = [UIColor whiteColor];
        //        }
        
        return cell;
    }
    else if (indexPath.section == 4)
    {
        static NSString *detailWayCellId = @"detaiOrderAmountCellId";
        
        OrderAmountCell *cell = (OrderAmountCell*)[tableView dequeueReusableCellWithIdentifier:detailWayCellId];
        
        if(cell == nil)
        {
            cell = [[OrderAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailWayCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        [cell setOrderAmountCell:detailDto WithNameDto:headDTO WithSectionPosition:indexPath.section WithCellPosition:indexPath.row];

        return cell;
    }
    else
    {
        static NSString *detailWayCellId = @"detailWayCellId";
        
        OrderDetailWayCell *cell = (OrderDetailWayCell*)[tableView dequeueReusableCellWithIdentifier:detailWayCellId];
        
        if(cell == nil)
        {
            cell = [[OrderDetailWayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailWayCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        detailDto.oiStatus = headDTO.oiStatus;
        
        [cell setOrderDetailWayCellInfo:detailDto WithNameDto:headDTO WithSectionPosition:indexPath.section WithCellPosition:indexPath.row];
        //        }
        
//        cell.backgroundColor = [UIColor blueColor];
        
        return cell;
    }
    
    
    return [[UITableViewCell alloc] init];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MemberOrderDetailsDTO *detailDto;
    MemberOrderDetailsDTO *tmpDto;
//    if (indexPath.section == 0) {
//        return;
//    }
    if(self.isCShopProduct == YES)
    {
        tmpDto = [self.CSLists safeObjectAtIndex:0];
    }
    else
    {
        tmpDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
    }
    
//    if (indexPath.section != 1) {
//        return;
//    }
    if (indexPath.section == 1) {
        if (( [tmpDto.simOrPhoneFlag eq:@"1"] || [tmpDto.simOrPhoneFlag eq:@"2"] ) && indexPath.row != 0) {
            return;
        }
        if(self.isCShopProduct == YES)
        {
            if([self.CSLists count] > 0)
            {
                detailDto = [self.CSLists objectAtIndex:indexPath.row];
                
            }
            
        }
        else
        {
            if([self.orderDetailDisplayLists count] > 0)
            {
                detailDto = [self.orderDetailDisplayLists objectAtIndex:indexPath.row];
                
            }
        }
        
        
        DataProductBasic *dto = [[DataProductBasic alloc] init];
        dto.productId = detailDto.productId;
        dto.productCode = detailDto.productCode;
        dto.productName = detailDto.productName;
        dto.shopCode = self.supplierCode;
        
        if([detailDto.exWarrantyFlag isEqualToString:@"1"])
        {
            //        [self presentSheet:@"您好，客户端暂不支持查看延保产品详情"];
            return;
        }
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730301"], nil]];
        ProductDetailViewController *productController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
        
        [self.navigationController pushViewController:productController animated:YES];
        

    }
//    add by gjf
    if(indexPath.section == 2 && indexPath.row == 1){
        
        if ([tmpDto.currentShipModeType isEqualToString:L(@"MyEBuy_PickedUpInStores")]) {
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.ercodeBackBtn];
        }
    }
    
    if (indexPath.section == 3 && indexPath.row == 2) {
    ElectronicInvoiceDetailViewController *vc = [[ElectronicInvoiceDetailViewController alloc] init];
    vc.SNShopList = self.orderDetailDisplayLists;
    vc.CShopList = self.CSLists;
    [self.navigationController pushViewController:vc animated:YES];
}
}

-(UIButton *)ercodeBackBtn{
    if (!_ercodeBackBtn) {
        float height =(self.view.width-50)*0.6;
        _ercodeBackBtn = [[UIButton  alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(25, self.view.centerY-(self.view.width-50)/2, self.view.width-50, self.view.width-50)];
        backview.backgroundColor = [UIColor whiteColor];
        
        UIImageView *ercodeView = [[UIImageView alloc] initWithFrame:CGRectMake(25, self.view.centerY-height/2, self.view.width-50, height)];
        ercodeView.backgroundColor = [UIColor whiteColor];
        _ercodeBackBtn.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        ercodeView.image = [UIImage imageNamed:@"tanchukuang_pic"];
        UIImageView *ercodeimg = [[UIImageView alloc] initWithFrame:CGRectMake(60, 5, 150, 150 )];
        ercodeimg.image = [QRCodeGenerator qrImageForString:[self generateOrderString] imageSize:ercodeimg.bounds.size.width];
        [ercodeView addSubview:ercodeimg];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, backview.bottom-40, self.ercodeBackBtn.width, 30)];
        label.text=L(@"MyEBuy_ReadErcodePickedUpInStores");
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor  colorWithRGBHex:0x313131];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [_ercodeBackBtn addSubview:backview];
        [_ercodeBackBtn addSubview:ercodeView];
        [_ercodeBackBtn addTarget:self action:@selector(dismissErcodeView) forControlEvents:UIControlEventTouchUpInside];
        [_ercodeBackBtn addSubview:label];

    }
    return _ercodeBackBtn;
}

-(void)dismissErcodeView{
    [self.ercodeBackBtn removeFromSuperview];
}

-(NSString *)generateOrderString{
    MemberOrderNamesDTO *headDTO = [self.detailHeadLists objectAtIndex:0];

    MemberOrderDetailsDTO *detailDto;
    if(self.isCShopProduct == YES)
    {
        detailDto = [self.CSLists safeObjectAtIndex:0];
    }
    else
    {
        detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
    }
    
    NSString *orderstr = [NSString stringWithFormat:@"%@%@",headDTO.orderId,[detailDto.itemMobilePhone substringFromIndex:7]];
    return orderstr;
    
}
#pragma mark - 申请退货

//退货
-(void)returnBtnAction
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730308"], nil]];
    ReturnGoodsListViewController *vc = [[ReturnGoodsListViewController alloc]init];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *ziyingArr = [[NSMutableArray alloc] init];
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    if(self.isCShopProduct == YES)
    {
        detailDto = [self.CSLists safeObjectAtIndex:0];
    }
    else
    {
        detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:0];
    }

    if([self.CSLists count] > 0)
    {
        arr = [[NSMutableArray alloc] initWithArray:self.CSLists];
        
        for(int i=0; i<[arr count]; i++)
        {
            MemberOrderDetailsDTO *dto = [arr objectAtIndex:i];
            
            if(![dto.returnStatus isEqualToString:@"applyReturn"] || [dto.exWarrantyFlag isEqualToString:@"1"])
            {
                [arr removeObjectAtIndex:i];
                
            }
        }
        
        vc.proList = arr;
        
    }
    else if([self.orderDetailDisplayLists count] > 0)
        
    {
        ziyingArr = [[NSMutableArray alloc] initWithArray:self.orderDetailDisplayLists];
        
        for(int i=0; i<[ziyingArr count]; i++)
        {
            MemberOrderDetailsDTO *dto = [ziyingArr objectAtIndex:i];
            
            if([dto.exWarrantyFlag isEqualToString:@"1"])
            {
                [ziyingArr removeObjectAtIndex:i];
                
            }
        }
        
        vc.proList = ziyingArr;
        
    }
    
    vc.headList = self.detailHeadLists;
    vc.isCShopProduct = self.isCShopProduct;
    vc.taxType = detailDto.taxType;
    vc.shopAddress = detailDto.address;
    vc.distribution = detailDto.currentShipModeType;
    [self.navigationController pushViewController:vc animated:YES];
    
    TT_RELEASE_SAFELY(vc);
    
    
}

#pragma mark - btnsAction
//物流查询
- (void)snxpressQueryBtnDetailAction:(id)sender event:(id)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730302"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.orderDetailTableView];
    
    NSIndexPath *indexPath = [self.orderDetailTableView indexPathForRowAtPoint : currentTouchPosition];
    
    UIButton *btn = (UIButton *)sender;
    
    NSInteger row = btn.tag;
    
    
    MemberOrderDetailsDTO *csDto = [[MemberOrderDetailsDTO alloc] init];
    
    MemberOrderNamesDTO *nameDto = [self.detailHeadLists objectAtIndex:0];
    
    NSString *showParcel = [self.LogisticsShowDic objectForKey:[NSString stringWithFormat:@"%d",row]];
    
    if(IsStrEmpty(nameDto.supplierCode))
    {
        if([self.orderDetailDisplayLists count] > 0)
        {
            csDto = [self.orderDetailDisplayLists objectAtIndex:indexPath.row];
            
        }
        
        ProductListDTO *productDto = [[ProductListDTO alloc] init];
        productDto.productName = csDto.productName;
        productDto.productCode = csDto.productCode;
        productDto.productId = csDto.productId;
        
        ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
        
        detailViewController.orderId = nameDto.orderId;
        
        detailViewController.orderItemId = csDto.orderItemId;
        detailViewController.verificationCode = csDto.verificationCode;
        detailViewController.orderProductListDTO = productDto;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
    else
    {
        
        NewOrderSnxpressViewController *snxpressViewController = [[NewOrderSnxpressViewController alloc] initWithStatus:eCShopDeliveryNew];
        snxpressViewController.orderId = nameDto.orderId;
        
        snxpressViewController.cShopCode = nameDto.supplierCode;
        snxpressViewController.showParcel = showParcel;
        snxpressViewController.hasNav = YES;
        snxpressViewController.hidesBottomBarWhenPushed = YES;
        snxpressViewController.isOrderDetailLogisticsQuery = YES;
        
        [self.navigationController pushViewController:snxpressViewController animated:YES];
    }
}

#pragma mark - 确认收货功能 测试wap支付页
- (void)confirmAcceptBtnAction:(id)sender event:(id)event
{
    //    NSSet *touches = [event allTouches];
    //
    //    UITouch *touch = [touches anyObject];
    //
    //    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    
    //    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
     [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730304"], nil]];
    UIButton *btn = (UIButton *)sender;
    
    NSInteger row = btn.tag;
    
    //    MemberOrderDetailsDTO *dto = [self.CSLists safeObjectAtIndex:row];
    //    self.orderItemsId =
    self.orderItemsId = [self.orderItemIdDic objectForKey:[NSString stringWithFormat:@"%d",row]];
    if (IsStrEmpty(self.orderItemsId)) {
        self.orderItemsId = @"";
    }
    [self isActiveEFuBao];
}


- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}
//评价按钮
- (void)pingJiaBtnAction:(id)sender event:(id)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730305"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.orderDetailTableView];
    
    NSIndexPath *indexPath = [self.orderDetailTableView indexPathForRowAtPoint : currentTouchPosition];
    
    MemberOrderNamesDTO *dto = [self.detailHeadLists objectAtIndex:0];
    
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if(IsStrEmpty(dto.supplierCode))
    {
        if([self.orderDetailDisplayLists count] > 0)
        {
            detailDto = [self.orderDetailDisplayLists objectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        
        self.dto.orderId = dto.orderId;
        self.dto.orderTime = dto.lastUpdate;
        
        self.evaDetailDto.orderItemId = detailDto.orderItemId;
        self.evaDetailDto.partNumber = detailDto.productCode;
        self.evaDetailDto.catentryId = detailDto.productId;
        self.evaDetailDto.supplierName = L(@"MyEBuy_SuningSelf");
        self.evaDetailDto.productUrl = detailDto.imageURL;
        self.evaDetailDto.catentryName = detailDto.productName;
        
        [self displayOverFlowActivityView];
        [self.evalutionService beginEvalutionValidate:detailDto.orderItemId];
    }
    else
    {
        if([self.CSLists count] > 0)
        {
            detailDto = [self.CSLists objectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        
        self.dto.orderId = dto.orderId;
        self.dto.orderTime = dto.lastUpdate;
        
        self.evaDetailDto.orderItemId = detailDto.orderItemId;
        self.evaDetailDto.partNumber = detailDto.productCode;
        self.evaDetailDto.catentryId = detailDto.productId;
        self.evaDetailDto.supplierName = detailDto.cShopName;
        self.evaDetailDto.productUrl = detailDto.imageURL;
        self.evaDetailDto.catentryName = detailDto.productName;
        
        [self displayOverFlowActivityView];
        [self.evalutionService beginEvalutionValidate:detailDto.orderItemId];
        
    }
    
}

#pragma mark -
#pragma mark 评价晒单按钮响应
- (void)commentAndShowBtn:(id)sender event:(id)event
{
    isEvalutionAndShowPhoto = YES;
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730305"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.orderDetailTableView];
    
    NSIndexPath *indexPath = [self.orderDetailTableView indexPathForRowAtPoint : currentTouchPosition];
    
    MemberOrderNamesDTO *dto = [self.detailHeadLists objectAtIndex:0];
    
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if(IsStrEmpty(dto.supplierCode))
    {
        if([self.orderDetailDisplayLists count] > 0)
        {
            detailDto = [self.orderDetailDisplayLists objectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        
        self.dto.orderId = dto.orderId;
        self.dto.orderTime = dto.lastUpdate;
        
        self.evaDetailDto.orderItemId = detailDto.orderItemId;
        self.evaDetailDto.partNumber = detailDto.productCode;
        self.evaDetailDto.catentryId = detailDto.productId;
        self.evaDetailDto.supplierName = L(@"MyEBuy_SuningSelf");
        self.evaDetailDto.productUrl = detailDto.imageURL;
        self.evaDetailDto.catentryName = detailDto.productName;
        
//        [self displayOverFlowActivityView];
//        [self.evalutionService beginEvalutionValidate:detailDto.orderItemId];
    }
    else
    {
        if([self.CSLists count] > 0)
        {
            detailDto = [self.CSLists objectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        
        self.dto.orderId = dto.orderId;
        self.dto.orderTime = dto.lastUpdate;
        
        self.evaDetailDto.orderItemId = detailDto.orderItemId;
        self.evaDetailDto.partNumber = detailDto.productCode;
        self.evaDetailDto.catentryId = detailDto.productId;
        self.evaDetailDto.supplierName = detailDto.cShopName;
        self.evaDetailDto.productUrl = detailDto.imageURL;
        self.evaDetailDto.catentryName = detailDto.productName;
    }
    
    if(IsStrEmpty(dto.supplierCode))
    {
        if([self.orderDetailDisplayLists count] > 0)
        {
            detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        self.shaiDanDetailsDTO = detailDto;
        
        self.isSubmitDisOrder = NO;
    }
    else
    {
        if([self.CSLists count] > 0)
        {
            detailDto = [self.CSLists safeObjectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        self.shaiDanDetailsDTO = detailDto;
        
        self.isSubmitDisOrder = NO;
        
    }

    
//    //---------------晒单---------------------
//    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
//    
//    if([dto.productList count] > 0)
//    {
//        //        productDto = [dto.productList objectAtIndex:indexPath.row - 1];//商品行从第二行开始
//        
//        //---------是否能晒单接口传参需要---------------
//        detailDto.orderItemId = productDto.orderItemId;
//        detailDto.productId = productDto.productId;
//        //-----------------end----------------------
//        
//        _displayorderMemMemberOrderDetailsDTO = detailDto;
//    }
//    
//    self.shaiDanDetailsDTO = productDto;
//    
//    self.isSubmitDisOrder = NO;
//    //---------------end--------------------
//    
    
//    [self displayOverFlowActivityView];
//    [self.evalutionService beginEvalutionValidate:productDto.orderItemId];
    [self displayOverFlowActivityView];
    [self.evalutionService beginEvalutionValidate:detailDto.orderItemId];

    
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
//    [self removeOverFlowActivityView];
//    if (isSuccess) {
//        self.isOrderDetailLoaded = NO;
//        EvalutionContentViewController *next = [[EvalutionContentViewController alloc] init];
//        next.evalutionDto = self.evaDetailDto;
//        next.evalDto = self.dto;
//        next.showReviewStatus = self.evalutionService.showReviewStatus;
//        next.hasNav = YES;
//        next.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:next animated:YES];
//        
//    }else{
//        [self presentSheet:errorMsg];
//    }
    
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (isEvalutionAndShowPhoto == YES) {
            isEvalutionAndShowPhoto = NO;
            EvaluationAndDisplayProductPictureViewController *vc = [[EvaluationAndDisplayProductPictureViewController alloc] initWithDTO:_memberOrderDetailsDTO isMember:NO];
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
            [self.navigationController pushViewController:vc animated:YES];
            
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
            [self.navigationController pushViewController:next animated:YES];
        }
    }else{
        [self presentSheet:errorMsg];
        isEvalutionAndShowPhoto = NO;
    }

}

// 用户触击晒单按钮
- (void)displayOrderBtn:(id)sender event:(id)event{
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730306"], nil]];
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.orderDetailTableView];
    
    NSIndexPath *indexPath = [self.orderDetailTableView indexPathForRowAtPoint : currentTouchPosition];
    
    MemberOrderNamesDTO *dto = [self.detailHeadLists safeObjectAtIndex:0];
    
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if(IsStrEmpty(dto.supplierCode))
    {
        if([self.orderDetailDisplayLists count] > 0)
        {
            detailDto = [self.orderDetailDisplayLists safeObjectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        self.shaiDanDetailsDTO = detailDto;
        
        self.isSubmitDisOrder = NO;
        
        [self.displayorderService checkURPhotoExistsHttpRequest:detailDto isSubmitDisOrder:self.isSubmitDisOrder isOrderDetailLoad:self.isOrderDetailLoaded];
    }
    else
    {
        if([self.CSLists count] > 0)
        {
            detailDto = [self.CSLists safeObjectAtIndex:indexPath.row];
            
            _memberOrderDetailsDTO = detailDto;
        }
        self.shaiDanDetailsDTO = detailDto;
        
        self.isSubmitDisOrder = NO;
        
        [self.displayorderService checkURPhotoExistsHttpRequest:detailDto isSubmitDisOrder:self.isSubmitDisOrder isOrderDetailLoad:self.isOrderDetailLoaded];
        
        
    }
}

- (MemberOrderDetailsDTO*)shaiDanDetailsDTO
{
    if(!_shaiDanDetailsDTO)
    {
        _shaiDanDetailsDTO = [[MemberOrderDetailsDTO alloc] init];
    }
    
    return _shaiDanDetailsDTO;
}

#pragma Snxpress Query Delegate

//用户点击送货/安装查询按钮
- (void)logisticsAction:(id)sender event:(id)event
{
    
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView : self.orderDetailTableView];
    
    NSIndexPath *indexPath = [self.orderDetailTableView indexPathForRowAtPoint : currentTouchPosition];
    
    if (indexPath != nil && indexPath.section-1 < [self.orderDetailDisplayLists count]) {
        
        self.memberOrderDetailsDTO = [self.orderDetailDisplayLists safeObjectAtIndex:indexPath.section-1];
        
        ProductListDTO *productDTO = [[ProductListDTO alloc] init];
        productDTO.productName = self.memberOrderDetailsDTO.productName;
        productDTO.productCode = self.memberOrderDetailsDTO.productCode;
        productDTO.productId = self.memberOrderDetailsDTO.productId;
        
        
        ServiceDetailViewController *detailViewController = [[ServiceDetailViewController alloc]initWithStatus:eOrderCenterDelivery];
        
        detailViewController.orderId = self.orderId;
        
        detailViewController.orderItemId = self.memberOrderDetailsDTO.orderItemId;
        
        detailViewController.hasNav = YES;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.orderProductListDTO = productDTO;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
        TT_RELEASE_SAFELY(detailViewController);
        
    }
}

-(void)CheckURPhotoExistsHttpRequestCompleteWithService:(BOOL)isSubmitDisOrder
                                      isOrderDetailLoad:(BOOL)isOrderDetailLoad
                                              isSuccess:(BOOL)isSuccess
                                               errorMsg:(NSString*)errorMsg
{
    if(isSuccess)
    {
        self.isSubmitDisOrder=isSubmitDisOrder;
        self.isOrderDetailLoaded=isOrderDetailLoad;
        
        if (self.isSubmitDisOrder) {
            
            ProductDisOrderSubmitViewController *productSubmitViewController = [[ProductDisOrderSubmitViewController alloc] initWithDTO:_memberOrderDetailsDTO isMember:NO];
            
            
            productSubmitViewController.evalutionDto.orderItemId = self.shaiDanDetailsDTO.orderItemId;
            productSubmitViewController.evalutionDto.catentryId = self.shaiDanDetailsDTO.productId;
            
            //            NSMutableString *mutableStr = [NSMutableString stringWithString:self.shaiDanDetailsDTO.productCode];
            //
            //            if(self.shaiDanDetailsDTO.productCode.length > 8)
            //            {
            //                [mutableStr deleteCharactersInRange:NSMakeRange(0, 8)];
            //            }
            //
            //            productSubmitViewController.evalutionDto.partNumber = [NSString stringWithFormat:@"%@",mutableStr];
            
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
            
            [self.navigationController pushViewController:productSubmitViewController animated:YES];
            
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

- (void)DisplayOrderOrEvaluationSucessRefresh
{
    _isOrderDetailLoaded = NO;
}
#pragma mark - OrderDeatilServiceDelegate

- (void)reloadView
{
    [self.orderDetailTableView reloadData];
    
}

- (void)changeView:(id)sender event:(id)event
{
    //    NSSet *touches = [event allTouches ];
    
    //    UITouch *touch = [touches anyObject ];
    
    //    CGPoint currentTouchPosition = [touch locationInView : self.orderDetailTableView];
    
    //    NSIndexPath *indexPath = [self.orderDetailTableView indexPathForRowAtPoint : currentTouchPosition];
    
    MemberOrderNamesDTO *dto = [self.detailHeadLists safeObjectAtIndex:0];
    
    MemberOrderDetailsDTO *detailDto = [[MemberOrderDetailsDTO alloc] init];
    
    if(IsStrEmpty(dto.supplierCode))
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
    
    self.orderId = dto.orderId;
    
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 101:
            [self secondPay];
            break;
        case 102:
            [self cancelOrder];
            break;
        default:
            break;
    }
}

- (void)segmentedAction:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger index = segment.selectedSegmentIndex;
    
    if (index == 0)
    {
        [self secondPay];
    }
    else if (index == 1)
    {
        [self cancelOrder];
    }
}

//获取道订单商品详细信息
//1.刷新表格
//2.未支付订单添加取消订单按钮
#pragma mark -
#pragma mark 获取订单详情

- (void)refreshData
{
    [self displayOverFlowActivityView];
    if ( [self.orderSt isEqualToString:@"C"] ||
        [self.orderSt isEqualToString:@"D"] ||
        [self.orderSt isEqualToString:@"E"] ||
        [self.orderSt isEqualToString:@"SC"] ||
        [self.orderSt isEqualToString:@"SD"] ||
        [self.orderSt isEqualToString:@"WD"] ||
        [self.orderSt isEqualToString:@"SOMED"])
    {
        [_service beginSendOrderDetailDTOHttpRequest:self.orderId WithCode:self.supplierCode];
        
    }
    else
    {
        [_service beginSendOldOrderDetailDTOHttpRequest:self.orderId WithCode:self.supplierCode];
        
    }
}

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
        _isOrderDetailLoaded = YES;
        self.orderRemark = ordeNamesDto.orderRemark;
        self.orderDetailDisplayLists = orderDetailList;//自营商品
        
        if ( [self.orderSt isEqualToString:@"C"] ||
            [self.orderSt isEqualToString:@"D"] ||
            [self.orderSt isEqualToString:@"E"] ||
            [self.orderSt isEqualToString:@"SC"] ||
            [self.orderSt isEqualToString:@"SD"] ||
            [self.orderSt isEqualToString:@"WD"] ||
            [self.orderSt isEqualToString:@"SOMED"])
            
        {
            [self.CSLists removeAllObjects];
            NSInteger tmpNumber = 0;
            if (!IsArrEmpty(CSList)) {
                for (int i = 0; i < [CSList count]; i++)
                {
                    CShopOrderListDTO *tmpDto = [CSList objectAtIndex:i];
                    if (!IsArrEmpty(tmpDto.itemList))
                    {
                        tmpNumber = tmpNumber + [tmpDto.itemList count] ;
                        for (int j = 0;j < [tmpDto.itemList count] ; j++)
                        {
                            MemberOrderDetailsDTO *tmpMemberDto = [tmpDto.itemList objectAtIndex:j];
                            if (j != [tmpDto.itemList count] - 1) {
                                tmpMemberDto.isconfirmReceipt = @"NONONO";
                            }
                            [self.CSLists addObject:tmpMemberDto];
                        }
                        [self.LogisticsShowDic setObject:[NSString stringWithFormat:@"%d",i] forKey:[NSString stringWithFormat:@"%d",tmpNumber - 1]];
                    }
                    else
                    {
                        //                        self.CSLists = [[NSMutableArray alloc] initWithArray:CSList];
                        
                    }
                    
                }
                
            }
            //                self.CSLists = tmpList.itemList;//c店商品
            self.CShopLists = CSList;
            self.LogisticsBtnShowArr = [[NSMutableArray alloc] initWithCapacity:[self.CSLists count]];
            for (int i = 0; i < [self.CSLists count]; i ++) {
                [self.LogisticsBtnShowArr addObject:[NSString stringWithFormat:@"%d",0]];
            }
            NSInteger number = 0;
            if (!IsArrEmpty(CSList)) {
                for (int i = 0; i < [CSList count]; i++)
                {
                    
                    CShopOrderListDTO *tmpDto = [CSList objectAtIndex:i];
                    if (!IsArrEmpty(tmpDto.itemList))
                    {
                        number = number + [tmpDto.itemList count];
                        [self.LogisticsBtnShowArr replaceObjectAtIndex:number - 1 withObject:[NSString stringWithFormat:@"%d",1]];
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
                
                //                [self.orderItemIdDic setObject:[self.orderItemIdArr safeObjectAtIndex:i] forKey:[self.keyArr safeObjectAtIndex:i]];
            }
            
            
        }
        else
        {
            
            self.CSLists = [[NSMutableArray alloc] initWithArray:CSList];
            
        }
        
        
        self.detailHeadLists = headList;//详情head
        
        self.orderNamesDTO = ordeNamesDto;
        
        
        [self reloadView];
        
        //        [self setRightNavItemEnable:YES];
    }else{
        [self presentSheet:errorCode];
    }
}

#pragma mark -
#pragma mark 订单取消

//取消订单，发送订单取消请求

- (void)cancelOrder
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730307"], nil]];
    //非货到付款，取消订单
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:L(@"MyEBuy_AreYouSureToCancelOrder")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    [alert setConfirmBlock:^{
        
        NSString *userId = [UserCenter defaultCenter].userInfoDTO.logonId;
        
        [self displayOverFlowActivityView:L(@"MyEBuy_OrderCanceling")];
        
        MemberOrderNamesDTO *detailDto = [self.detailHeadLists safeObjectAtIndex:0];
        
        
        [self.service beginSendCancelOrderHttpRequest:userId orderId:detailDto.orderId];
        
    }];
    [alert show];
}




- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0 && alertView.tag ==11 )
    {
        if (_isFromOrderListEntry) {
            
             [[NSNotificationCenter defaultCenter] postNotificationName:RECEIPT_CONFIRM_SUCCESS object:nil];
            
            [self backForePage];
            
        }else {
            //回订单中心
            NSArray *viewControllers = [self.navigationController viewControllers];
            NSInteger index = [viewControllers indexOfObject:self]-2;
            if (index >= 0) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
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
        
        alertView.tag = 11;
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
    }
    else
    {
        [self presentCustomDlg:errorMsg?errorMsg:L(@"Cancel Order Failed!")];
    }
    //    [self setRightNavItemEnable:YES];
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
- (void)secondPay
{
     [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730303"], nil]];
    [self displayOverFlowActivityView:L(@"MyEBuy_SecondPaymentPreparing")];
    //    [self setRightNavItemEnable:NO];
    [self.secondPayService beginSecondPayOrderCheckWithOrderId:self.orderId];
}

- (void)secondPayCheckCompletionWithResult:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg
                                    payDto:(payFlowDTO *)payDTO
{
    [self removeOverFlowActivityView];
    //    [self setRightNavItemEnable:YES];
    
    if (isSuccess) {
        
        
        ShipMode mode =
        [self.secondDto.currentShipModeType isEqualToString:L(@"MyEBuy_Delivery")]?ShipModeSuningSend:ShipModeSelfTake;
        
        PaymentModeViewController *payController =
        [[PaymentModeViewController alloc] initWithPayFlowDTO:payDTO
                                                  andShipMode:mode];
        payController.isSecondPay = YES;
        [self.navigationController pushViewController:payController animated:YES];
        
    }else{
        
        [self presentSheet:errorMsg];
    }
}

////评价按钮
//- (void)pingJiaBtn
//{
//
//}

#pragma mark ----------------------------- 在线客服

- (void)getOnlineServiceStatus
{
    @weakify(self);
    
    
    if (self.supplierCode.length)
    {
        OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initAsCShop:self.supplierCode ProductName:nil ProductCode:nil OrderNo:self.orderId];
        
        [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
            
            @strongify(self);
            OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
            if (__cmd.onlineStatus >= -1)
            {
                self->_onlineStatus = __cmd.onlineStatus;
                self->_isGetOnlineStatusOk = YES;
                [self.orderDetailTableView reloadData];
            }
            
        }];
    }
    else
    {
        OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initAsB2CReturnOrderWithOrderNo:self.orderId];
        [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
            
            @strongify(self);
            OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
            if (__cmd.onlineStatus >= -1)
            {
                self->_onlineStatus = __cmd.onlineStatus;
                self->_isGetOnlineStatusOk = YES;
                [self.orderDetailTableView reloadData];
            }
            
        }];
    }
}

- (void)contactSNShop
{
    //b2c客服
    [self checkLoginWithLoginedBlock:^{
        OSChatViewController *vc = [[OSChatViewController alloc] initAsB2COrderDetailWithOrderNo:self.orderId];
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
        [self presentModalViewController:nav animated:YES];
    } loginCancelBlock:nil];
}

- (void)contactCShop
{
    [self checkLoginWithLoginedBlock:^{
        if (_onlineStatus == 0)
        {
            OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithShopCode:self.supplierCode ShopName:self.supplierName ProductCode:nil ProductName:nil OrderId:self.orderId];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
        else
        {
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:self.supplierCode ProductName:nil ProductCode:nil OrderNo:self.orderId];
            vc.vendorName = self.supplierName;
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
    } loginCancelBlock:nil];
}

- (void)callPhone
{
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730309"], nil]];
    [_callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4008365365"]]];
}

- (void)ReceiptConfirmSuccess
{
    self.isOrderDetailLoaded = NO;
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
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)activedJumpConfirmGoods
{
    [self isActiveEFuBao];
}

- (void)isActiveEFuBao
{
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
        NSString *urlStr = [NSString stringWithFormat:@"%@",kOrderConfirmAcceptWapUrl];//@"http://mpaypre.cnsuning.com/epp-m/showCheckPayPWD.htm?redecitString=suningMobileCheckPassSucess";
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ConfirmReceiptWebViewController *recommendViewController = [[ConfirmReceiptWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
        recommendViewController.orderID = self.orderId;
        recommendViewController.orderItemId = self.orderItemsId;
        recommendViewController.supplierCode = self.supplierCode;
        
        //    [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:recommendViewController animated:NO];
        [self.navigationController pushViewController:recommendViewController animated:NO];
        
    }
    
    
}

- (NSMutableArray *)orderItemIdArr
{
    if (!_orderItemIdArr) {
        _orderItemIdArr = [[NSMutableArray alloc] init];
    }
    return  _orderItemIdArr;
}

- (NSMutableDictionary *)orderItemIdDic
{
    if (!_orderItemIdDic) {
        _orderItemIdDic = [[NSMutableDictionary alloc] init];
    }
    return  _orderItemIdDic;
}

- (NSMutableArray *)keyArr
{
    if (!_keyArr) {
        _keyArr = [[NSMutableArray alloc] init];
    }
    return _keyArr;
}
- (void)evalutionSuccess
{
    _isOrderDetailLoaded = NO;
}

- (void)shaidanSuccess
{
    _isOrderDetailLoaded = NO;
    
}


@end