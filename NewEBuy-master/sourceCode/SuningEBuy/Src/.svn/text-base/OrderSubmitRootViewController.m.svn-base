
//
//  OrderSubmitRootViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "OrderSubmitRootViewController.h"
#import "ChooseDate.h"
#import "ValidationService.h"
#import "PlanTicketSwitch.h"
#import "SNWebViewController.h"

@interface OrderSubmitRootViewController() {
    BOOL  isSendingHttpRequest;
}

@property (nonatomic, strong) BoardingService  *boardingService;
@property (nonatomic, strong) FlightOrderService  *orderService;
@property (nonatomic, strong) InsuranceService *insuranceSerivce;
@property (nonatomic, strong) PlanTicketService  *ticketOrderService;
@property (nonatomic, strong) BackBarView      *backBarView;

- (BOOL)validateTime;

- (void)nextSectePayWay:(NSString *)flightOrderId TotalAmount:(NSString *)totalAmount;

- (void)sendOrderSubmitRequest;

- (NSString *)validateAll;

- (void)getInsurances;

@end


@implementation OrderSubmitRootViewController

@synthesize flightDetailDtoList = _flightDetailDtoList;
@synthesize personList = _personList;
@synthesize allPersonList = _allPersonList;
@synthesize selectAddrDto =_selectAddrDto;
@synthesize flightInfoDto = _flightInfoDto;

@synthesize addressType = _addressType;
@synthesize contactName = _contactName;
@synthesize contactMobile = _contactMobile;
@synthesize priceAmount = _priceAmount;
@synthesize dengjiData = _dengjiData;

@synthesize snPopoverController = _snPopoverController;
@synthesize insuranceList = _insuranceList;
@synthesize selectedInsurance = _selectedInsurance;

@synthesize boardingService = _boardingService;
@synthesize orderService    = _orderService;
@synthesize insuranceSerivce = _insuranceSerivce;
@synthesize ticketOrderService = _ticketOrderService;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_flightDetailDtoList);
    
    TT_RELEASE_SAFELY(_personList);
    TT_RELEASE_SAFELY(_selectAddrDto);
    TT_RELEASE_SAFELY(_addressType);
	TT_RELEASE_SAFELY(_flightInfoDto);
    
    TT_RELEASE_SAFELY(_contactName);
    TT_RELEASE_SAFELY(_contactMobile);
    TT_RELEASE_SAFELY(_priceAmount);
	TT_RELEASE_SAFELY(_dengjiData);
    
    TT_RELEASE_SAFELY(_snPopoverController);
    
    TT_RELEASE_SAFELY(_insuranceList);
    TT_RELEASE_SAFELY(_selectedInsurance);
    
    SERVICE_RELEASE_SAFELY(_boardingService);
    SERVICE_RELEASE_SAFELY(_orderService);
    SERVICE_RELEASE_SAFELY(_insuranceSerivce);
    SERVICE_RELEASE_SAFELY(_ticketOrderService);
}


#pragma mark - Life Circle Methods
#pragma mark   生命周期方法
- (id)init
{
    self = [super init];
	
    if (self)
    {
		//"FlightOrder_Write"="订单填写"
        self.title = L(@"FlightOrder_Write");
        
        self.pageTitle = L(@"virtual_business_flightOrderWrite");
        
        self.addressType = @"1";
        
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        self.personList = tempArray;
        TT_RELEASE_SAFELY(tempArray);
        
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        self.allPersonList = tempArray1;
        TT_RELEASE_SAFELY(tempArray1);
        
        customerCount = 0;
        
        isSendingHttpRequest = NO;
    }
    
    return self;
}

- (void)righBarClick
{
    [self submitHttp];
}

- (void)loadView
{
	
	[super loadView];
    
	CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
		
    frame.size.height -= 44;
    
	self.tpTableView.frame = frame;
    
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	[self.view addSubview:self.tpTableView];
    
    self.backBarView.backBtn.hidden = YES;
    self.backBarView.frame = CGRectMake(0, _tpTableView.bottom, 320, 44);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([PlanTicketSwitch canUserNewServer]) {
        if (!isInsurancesLoaded) {
            [self getInsurances];
        }
    }
    
    //如果联系人为空，则从UserCenter中取用户信息
    if (_contactName == nil) {
        self.contactName =
        [UserCenter defaultCenter].userInfoDTO.userName?[UserCenter defaultCenter].userInfoDTO.userName:@"";
        self.contactMobile =
        [UserCenter defaultCenter].userInfoDTO.phoneNo?[UserCenter defaultCenter].userInfoDTO.phoneNo:@"";
    
    }
    
    self.selectAddrDto = [[UserCenter defaultCenter] defaultAddressInfo];
    
    [self.tpTableView reloadData];  //add by wangjiaxing 20120820
}

- (NSInteger)ticketCount
{
    int cc = [self.personList count];
    int fc = [self.flightDetailDtoList count];
    return cc*fc;
}

#pragma mark -  OrderSubmit Methods
#pragma mark    订单提交事件相应方法
- (void)submitHttp
{
    //隐藏键盘
    yuDingRenItemCell *cell = (yuDingRenItemCell *)[self.tpTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]] ;
    if ([cell.yuDingNameFld isFirstResponder]) {
        [cell.yuDingNameFld resignFirstResponder];
    }else{
        if ([cell.yuDingPhoneFld isFirstResponder]) {
            [cell.yuDingPhoneFld resignFirstResponder];
        }
    }
    
    if (customerCount == 0) {
        
        if (isSendingHttpRequest == NO) {
            
            [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
            [self.boardingService sendBoardingListHttpReqeust];
            
        }
        return;
    }
    
    NSString *errorDesc = [self validateAll];
    
    if (!IsNilOrNull(errorDesc)) {
        [self presentSheet:L(errorDesc)];
        return;
    }
    
    [self sendOrderSubmitRequest];
    
}

- (NSString *)validateAll{
    NSError *error = nil;
    
    error = [ValidationService chineseChecking:self.contactName Frome:2 To:10];
    if (error.code == kValidationFail) {
        NSString *errorDesc=(NSString *) [error.userInfo objectForKey:kValidationErrorDesc_Key];
        NSString *nameErrorDesc =[NSString stringWithFormat:@"Name_%@",errorDesc];
        return nameErrorDesc;
    }
    
    error = [ValidationService phoneNumChecking:self.contactMobile];
    if (error.code == kValidationFail) {
        NSString *errorDesc=(NSString *) [error.userInfo objectForKey:kValidationErrorDesc_Key];
        NSString *phoneErrorDesc =[NSString stringWithFormat:@"PhoneNum_%@",errorDesc];
        return phoneErrorDesc;
    }
    
    if (![self validateTime]) {
        return @"ChooseReturnTimeError";
    }
    
    //检验是否有配送地址
    if ([self.addressType isEqualToString:@"3"]) {
        
        if (self.selectAddrDto == nil || IsStrEmpty(self.selectAddrDto.addressNo)) {
            return L(@"BTPleaseChooseDistributionRegion");
        }
    }
    
    return nil;
}

#pragma mark - UITableView DataSource Delegate Methods
#pragma mark   UITableView 数据源以及代理方法

- (void) updateTable{
    
    [self.tpTableView reloadData];
    
    if (IsStrEmpty(self.priceAmount)) {
        
        [self.backBarView refreshBar:L(@"BTTotal") middleItem:@"￥0.00" rightItem:L(@"commitPay")];
    }else{
        [self.backBarView refreshBar:L(@"BTTotal") middleItem:self.priceAmount rightItem:L(@"commitPay")];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.flightDetailDtoList count];
    }else{
        return 1;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {       //航班信息
        
        if ([self.flightDetailDtoList count] > 0 ) {
            return 200;
        }else{
            return 0;
        }
        
    }else if (indexPath.section == 1) { //登机人信息
        
        return [dengJiRenItemCell height:[self.personList count]];
        
    }else if (indexPath.section == 2){  //预定人信息
        
        return 130;
        
    }else if(indexPath.section == 3){   //行程单信息
        
        return [xingChengDanItemCell height:self.addressType];
        
    }else{                              //保险信息
        
        return [baoXianItemCell height:self];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {   //去程
            
            static NSString *firstCellCellIdentifier = @"firstCellCellIdentifier";
            
            hangBanItemCell *cell = (hangBanItemCell *)[tableView dequeueReusableCellWithIdentifier:firstCellCellIdentifier];
            
            if(cell == nil)
            {
                
                cell = [[hangBanItemCell alloc]initWithReuseIdentifier:firstCellCellIdentifier];
                cell.delegate = self;
            }
            
            FlightInfoDTO *dto = [self.flightDetailDtoList objectAtIndex:0];
            self.dengjiData = dto.fDate;
            if ([self.flightDetailDtoList count]==1) {
                cell.quFanCheng = L(@"BTOneWay");
            }else{
                cell.quFanCheng = L(@"BTGoWay");
                
            }
            [cell setHanBanInfoItem:dto];
            
            return cell;
            
        }else{                  //返程
            
            static NSString *fanCellCellIdentifier = @"fanCellCellIdentifier";
            
            hangBanItemCell *cell = (hangBanItemCell *)[tableView dequeueReusableCellWithIdentifier:fanCellCellIdentifier];
            
            if(cell == nil)
            {
                
                cell = [[hangBanItemCell alloc]initWithReuseIdentifier:fanCellCellIdentifier];
                cell.delegate = self;
            }
            
            FlightInfoDTO *dto = [self.flightDetailDtoList objectAtIndex:1];
            
            cell.quFanCheng = L(@"BTGoBackWay");
            
            [cell setHanBanInfoItem:dto];
            
            return cell;

        }
        
    }else if(indexPath.section == 1){   //登机人信息
        
        static NSString *sanCellIdentifier = @"sanCellIdentifier";
        
        dengJiRenItemCell *cell = (dengJiRenItemCell *)[tableView dequeueReusableCellWithIdentifier:sanCellIdentifier];
        
        if(cell == nil)
        {
            
            cell = [[dengJiRenItemCell alloc]initWithReuseIdentifier:sanCellIdentifier];
            
            cell.delegate = self;
        }
        
        [cell setDengJiRenInfoByArray:self.personList];
        
        return cell;
        
    }else if (indexPath.section == 2){      //预订人信息
        
        static NSString *sanCellIdentifier = @"siCellIdentifier";
        
        yuDingRenItemCell *cell = (yuDingRenItemCell *)[tableView dequeueReusableCellWithIdentifier:sanCellIdentifier];
        
        if(cell == nil)
        {
            
            cell = [[yuDingRenItemCell alloc]initWithReuseIdentifier:sanCellIdentifier];
            
            cell.yuDingDelegate = self;
        }
        
        [cell setItem:self.contactName andPhone:self.contactMobile];

        return cell;

    }else if (indexPath.section == 3){      //行程单信息
        
        static NSString *sanCellIdentifier = @"wuCellIdentifier";
        
        xingChengDanItemCell *cell = (xingChengDanItemCell *)[tableView dequeueReusableCellWithIdentifier:sanCellIdentifier];
        
        if(cell == nil)
        {
            cell = [[xingChengDanItemCell alloc]initWithReuseIdentifier:sanCellIdentifier];
            cell.addressType = self.addressType;
            cell.controller = self;
        }
        
        [cell setItem:self.selectAddrDto];

        return cell;
        
    }else{          //保险信息
        
        static NSString *sanCellIdentifier = @"liuCellIdentifier";
        
        baoXianItemCell *cell = (baoXianItemCell *)[tableView dequeueReusableCellWithIdentifier:sanCellIdentifier];
        
        if(cell == nil)
        {
            cell = [[baoXianItemCell alloc]initWithReuseIdentifier:sanCellIdentifier
                                                        controller:self];
        }
        [cell setItem];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (IOS7_OR_LATER) {
        return 0.1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (IOS7_OR_LATER) {
        return 0.1;
    }
    return 0;
}

#pragma mark -
#pragma mark 显示价格和提交订单按钮
-(BackBarView *)backBarView{
    if (!_backBarView) {
        _backBarView = [[BackBarView alloc]init];
        [_backBarView refreshBar:L(@"BTTotal") middleItem:@"￥0.00" rightItem:L(@"commitPay")];
        [_backBarView.backBtn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
        [_backBarView.submitBtn addTarget:self action:@selector(submitHttp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backBarView];
    }
    return _backBarView;
}

//返回上一页
-(void)backForePage{
    
    [super backForePage];
}

#pragma mark - dengJiRenItemCell Delegate Methods
#pragma mark   登机人Cell 的代理方法的实现

- (void)dengJiRenManagement:(id)sender
{
    
    if (isSendingHttpRequest == NO) {
        
        [self.boardingService sendBoardingListHttpReqeust];
        
    }
}

#pragma mark - hangBanItemCell Delegate Methods
#pragma mark   航班Cell的代理方法的实现

- (void)returnRefundTicketAction:(FlightInfoDTO *)ruleInfo
{
    if (NotNilAndNull(ruleInfo)) {
        ExchangeTicketViewController *exchangeController = [[ExchangeTicketViewController alloc]init];
        exchangeController.flightInfo = ruleInfo;
        [self.snPopoverController presentWithContentViewController:exchangeController animated:YES];
    }
    
}

#pragma mark - BoardingPersionListViewController Delegate
#pragma mark   登机人选择代理方法
- (void)returnUserChoosePersonList:(NSMutableArray *)list{
    
    [self.personList removeAllObjects];
    [self.personList addObjectsFromArray:list];
    
    [self calculateTotalAmount];
    [self updateTable];
}

//运算订单总金额
- (void)calculateTotalAmount
{
    NSArray *dengjiList = self.personList;
    if ([dengjiList count]>0) {
        customerCount = [dengjiList count];//登机人总数
        
        int customer = 0;//成人个数
        int customerC = 0; //儿童个数
        for (int i = 0; i<[dengjiList count]; i++) {//获得成人的总数和儿童的总数
            
            BoardingInfoDTO *boardDto = [dengjiList objectAtIndex:i];
            
            if ([boardDto.travellerType isEqualToString:@"1"]) {
                customer = customer+1;
            }else {
                if ([boardDto.travellerType isEqualToString:@"2"]) {
                    customerC = customerC +1;
                }
            }
        }
        
        if ([self.flightDetailDtoList count]==1) {//单程
            
            float eprice = 0;//成人机票单价
            float epriceC = 0;//儿童机票单价
            float baoxianPrice = 0;
            
            float epr = 0;//订单总金额
            
            FlightInfoDTO *dto = [self.flightDetailDtoList objectAtIndex:0];
            if (![dto.roomList count]==0) {//获得成人单价和儿童单价
                
                FlightRoomInfoDTO *frDto = [dto.roomList objectAtIndex:0];
                
                eprice = [frDto.sysPrice?frDto.sysPrice:0 doubleValue] - [frDto.offPrice?frDto.offPrice:0 doubleValue];
                //加上机建费和燃油税
                eprice = eprice+ [dto.aptA?dto.aptA:0 doubleValue]+[dto.aotA?dto.aotA:0 doubleValue];
                
                epriceC = [frDto.sysPriceC?frDto.sysPriceC:0 doubleValue] - [frDto.offPriceC?frDto.offPriceC:0 doubleValue];
                //加上儿童机建费和燃油税
                epriceC = epriceC+ [dto.aptC?dto.aptC:0 doubleValue]+[dto.aotC?dto.aotC:0 doubleValue];
                
            }
            
            //保险金额
            if (self.selectedInsurance) {
                int insurCount = customerCount*self.selectedInsurance.copyCount;
                baoxianPrice = [self.selectedInsurance.salePrice floatValue]*(float)insurCount;
            }
            
            //订单总金额
            epr = eprice *customer + epriceC *customerC + baoxianPrice;
            
            self.priceAmount = [NSString stringWithFormat:@"%.2f",epr];
                 
            return;
        }
        
        if ([self.flightDetailDtoList count]==2) {//往返
            
            float eprice = 0;//成人去程机票单价
            float epriceC = 0;//儿童去程机票单价
            float epr = 0 ;//去程总金额
            
            float eprice2 = 0;//成人机票单价
            float epriceC2 = 0;//儿童机票单价
            float eprAll = 0;//往返总订单金额
            
            float baoxianPrice = 0;
            
            FlightInfoDTO *dto = [self.flightDetailDtoList objectAtIndex:0];
            if (![dto.roomList count]==0) {//获得成人单价和儿童单价
                
                FlightRoomInfoDTO *frDto = [dto.roomList objectAtIndex:0];
                
                eprice = [frDto.sysPrice?frDto.sysPrice:0 doubleValue] - [frDto.offPrice?frDto.offPrice:0 doubleValue];
                //加上机建费和燃油税
                eprice = eprice+ [dto.aptA?dto.aptA:0 doubleValue]+[dto.aotA?dto.aotA:0 doubleValue];
                
                epriceC = [frDto.sysPriceC?frDto.sysPriceC:0 doubleValue] - [frDto.offPriceC?frDto.offPriceC:0 doubleValue];
                //加上儿童机建费和燃油税
                epriceC = epriceC+ [dto.aptC?dto.aptC:0 doubleValue]+[dto.aotC?dto.aotC:0 doubleValue];
                
            }
            //去程订单总金额
            epr = eprice *customer + epriceC *customerC;
            
            FlightInfoDTO *dto2 = [self.flightDetailDtoList objectAtIndex:1];
            if (![dto2.roomList count]==0) {//获得成人单价和儿童单价
                
                FlightRoomInfoDTO *frDto = [dto2.roomList objectAtIndex:0];
                
                eprice2 = [frDto.sysPrice?frDto.sysPrice:0 doubleValue] - [frDto.offPrice?frDto.offPrice:0 doubleValue];
                //加上机建费和燃油税
                eprice2 = eprice2+ [dto2.aptA?dto2.aptA:0 doubleValue]+[dto2.aotA?dto2.aotA:0 doubleValue];
                
                epriceC2 = [frDto.sysPriceC?frDto.sysPriceC:0 doubleValue] - [frDto.offPriceC?frDto.offPriceC:0 doubleValue];
                //加上儿童机建费和燃油税
                epriceC2 = epriceC2+ [dto2.aptC?dto2.aptC:0 doubleValue]+[dto2.aotC?dto2.aotC:0 doubleValue];
            }
            
            //保险金额
            if (self.selectedInsurance) {
                int insurCount = customerCount*self.selectedInsurance.copyCount*2;
                baoxianPrice = [self.selectedInsurance.salePrice floatValue]*(float)insurCount;
            }
            
            //往返订单总金额
            eprAll = eprice2 *customer + epriceC2 *customerC + epr + baoxianPrice;
            
            self.priceAmount = [NSString stringWithFormat:@"%.2f",eprAll];
        
            return;
        }
        
    }else{
        self.priceAmount = @"";
     }
}


#pragma mark - rderSubmitHttp Requests
#pragma mark   发送订单提交请求

- (void)sendOrderSubmitRequest{
    
    [self displayOverFlowActivityView:L(@"Commiting") maxShowTime:kPlaneTicketTimeOut];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;

    if ([self.flightDetailDtoList count]== 1) {//单程
        
        FlightInfoDTO *dto = [self.flightDetailDtoList objectAtIndex:0];
        [self.orderService beginSendOrderSubmitRequest:customerCount
                                          BoardingList:self.personList
                                           AddressInfo:self.selectAddrDto
                                           AddressType:self.addressType
                                        BookPersonName:self.contactName
                                      BookPersonMobile:self.contactMobile
                                          GoFlightInfo:dto
                                        BackFlightInfo:nil
                                         insuranceInfo:self.selectedInsurance];
    }else {
        if ([self.flightDetailDtoList count]== 2) {//往返程
            FlightInfoDTO *dto = [self.flightDetailDtoList objectAtIndex:0];
            FlightInfoDTO *dto2 = [self.flightDetailDtoList objectAtIndex:1];
            
            [self.orderService beginSendOrderSubmitRequest:customerCount
                                              BoardingList:self.personList
                                               AddressInfo:_selectAddrDto
                                               AddressType:self.addressType
                                            BookPersonName:self.contactName
                                          BookPersonMobile:self.contactMobile
                                              GoFlightInfo:dto
                                            BackFlightInfo:dto2
                                             insuranceInfo:self.selectedInsurance];
        }
    }
}

- (void)didSendFlightOrderSubmitComplete:(FlightOrderService *)service
                                  Result:(BOOL)isSuccess
                                ErrorMsg:(NSString *)errorMsg
                               ErrorCode:(NSString *)errorCode
{
    
    [self removeOverFlowActivityView];
    
    if ([PlanTicketSwitch canUserNewServer]) {
        if (isSuccess) {
            [self nextSectePayWay:service.orderId TotalAmount:service.shouldPay];
        }else{
            
            switch (service.orderStatus) {            
                case eOrderSucc_InsuranceFail:           
                case eOrderSucc_PriceChange_InsuranceFail:           
                case eOrderSucc_PriceChange_InsuranceSucc:{
                    
                    BBAlertView *alertView = [[BBAlertView alloc]
                                              initWithTitle:nil
                                              message:errorMsg
                                              delegate:self
                                              cancelButtonTitle:L(@"cancel")
                                              otherButtonTitles:L(@"ok")];
                    
                    [alertView setConfirmBlock:^{
                        
                        [self nextSectePayWay:service.orderId
                                  TotalAmount:[NSString stringWithFormat:
                                               @"%.2f",[service.shouldPay floatValue]]];
                        
                    }];
                    [alertView setCancelBlock:^{
                        [self displayOverFlowActivityView:L(@"Loading...")
                                              maxShowTime:kPlaneTicketTimeOut];
                        PFOrderBasicDTO *dto = [[PFOrderBasicDTO alloc] init];
                        dto.ordersId = service.orderId;
                        [self.ticketOrderService beginCancelPlanOderRequest:dto];
                    }];
                    [alertView show];
                    TT_RELEASE_SAFELY(alertView);
                }
                    break;
                case eOrderFail_ReSubmit:{
                    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil
                                                                        message:errorMsg
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:L(@"ok")];
                    [alertView setConfirmBlock:^{
                        self.appDelegate.tabBarViewController.selectedIndex = 4;
                        [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER object:nil];
                        [self.navigationController popToRootViewControllerAnimated:NO];
                    }];
                    [alertView show];
                    TT_RELEASE_SAFELY(alertView);
                }
                    break;
                    
                case eOrderFail_CheckFail:            
                case eOrderFail_SaleOut:{
                    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil
                                                                        message:errorMsg
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:L(@"ok")];
                    [alertView setConfirmBlock:^{
                        [PlanTicketSwitch jumpToQueryPlaneView:self.navigationController];
                    }];
                    [alertView show];
                    TT_RELEASE_SAFELY(alertView);
                }
                    break;
                    
                case eOrderFail:
                case eOrderFail_DataCheckFail:
                {
                    [self presentSheet:errorMsg];
                }
                    break;
                default:
                    break;
            } 
        }
        
    }else{
        
        if (isSuccess) {
            [self nextSectePayWay:service.orderId TotalAmount:self.priceAmount];
        }else{
            [self presentSheet:errorMsg];
        }
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark - order Cancel 
#pragma mark   取消订单

- (void)endCancelOrderComplete:(PlanTicketService *)service Result:(BOOL)isSucces errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    if (isSucces) { 
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"BTYourOrderHasCancelled") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"ok")];
        [alertView setConfirmBlock:^{
            [PlanTicketSwitch jumpToQueryPlaneView:self.navigationController];
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
        
    }else{
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"BTOrderCancelledError") delegate:self cancelButtonTitle:L(@"cancel") otherButtonTitles:L(@"ok")];
        [alertView setCancelBlock:^{
            NSArray *controllerArr = [self.navigationController viewControllers];
            UIViewController *controller = [controllerArr objectAtIndex:2];
            [self.navigationController popToViewController:controller animated:YES];
        }];
        [alertView setConfirmBlock:^{
            self.appDelegate.tabBarViewController.selectedIndex = 4;
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                object:nil
                                                              userInfo:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }];
        [alertView show];
        TT_RELEASE_SAFELY(alertView);
    }
}

#pragma mark - payment Methods
#pragma mark   确认支付
- (void)nextSectePayWay:(NSString *)flightOrderId TotalAmount:(NSString *)totalAmount
{
    flightPayOrderViewController *flightPayModeViewController = [[flightPayOrderViewController alloc]init];
    flightPayModeViewController.flightOrderId = flightOrderId?flightOrderId:@"";
    flightPayModeViewController.flightPrice = totalAmount?totalAmount:@"0.00";
    [self.navigationController pushViewController:flightPayModeViewController animated:YES];
    TT_RELEASE_SAFELY(flightPayModeViewController);
    
}

#pragma mark -
#pragma mark 更新收货列表

- (void)didSelectAddress:(AddressInfoDTO *)address
{
    self.selectAddrDto = address;
    [self updateTable];
}


#pragma mark -
#pragma mark yudingcell  delegate

- (void)sendPhone:(NSString *)phone{
    self.contactMobile = phone;
}

- (void)sendName:(NSString *)name{
    self.contactName = name;
}

-(BOOL)validateTime{
    
    if (self.flightDetailDtoList!=nil && [self.flightDetailDtoList count] == 2)
    {
        FlightInfoDTO *goDto = [self.flightDetailDtoList objectAtIndex:0];
        FlightInfoDTO *returnDto = [self.flightDetailDtoList objectAtIndex:1];
        
        NSString *goTime = [NSString stringWithFormat:@"%@ %@:00",goDto.aDate,goDto.aTime];
        NSString *returnTime = [NSString stringWithFormat:@"%@ %@:00",returnDto.fDate,returnDto.fTime];
        
        NSDate *goDate = [ChooseDate dateFromString:goTime withFormatString:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *returnDate = [ChooseDate dateFromString:returnTime withFormatString:@"yyyy-MM-dd HH:mm:ss"];
        
        DLog(@"%@", [goDate description]);
        DLog(@"%@", [returnDate description]);
        
        //如果去程的抵达时间早于返程的起飞时间，则返回false
        if ([[goDate laterDate:returnDate]isEqualToDate:goDate])
        {
            return NO;
        }else{
            return YES;
        }
        
    }
    //如果是单程旅行，则返回yes
    return YES;
}


#pragma mark - sendHttpRequest for person list
#pragma mark   获取登记人列表
- (void)getBoardingListService:(BoardingService *)service Result:(BOOL)isSuccess_ errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess_==NO) {
        isSendingHttpRequest = YES;
        [self presentSheet:L(errorMsg)];
    }else{
        isSendingHttpRequest = NO;
        self.allPersonList = service.personList;
        [self chooseJumpPage];
    }
}


-(void)chooseJumpPage{
    
    if ([self.allPersonList count] == 0) {
        
        BoardingPersionListViewController *listCtrl = [[BoardingPersionListViewController alloc]init];
        
        listCtrl.delegate = self;
        
        if ([self.flightDetailDtoList count]>0) {
            
            listCtrl.flightInfoDto = [self.flightDetailDtoList objectAtIndex:0];
        }
        [self.navigationController pushViewController:listCtrl animated:NO];
        
        [listCtrl goToAddPersonPage];
        
        TT_RELEASE_SAFELY(listCtrl);
        
    }else{
        
        BoardingPersionListViewController *listCtrl = [[BoardingPersionListViewController alloc]init];
        
        listCtrl.delegate = self;
        
        if ([self.flightDetailDtoList count]>0) {
            
            listCtrl.flightInfoDto = [self.flightDetailDtoList objectAtIndex:0];
        }
        
        listCtrl.personList = self.allPersonList;
        
        listCtrl.isLoaded = YES;
        
        if ([self.personList count] > 0) {
            
            [listCtrl.userChoosePersonList removeAllObjects];
            
            for (int i = 0; i< [self.personList count]; i++) {
                [listCtrl.userChoosePersonList addObject:[self.personList objectAtIndex:i]];
            }
        }
        
        [listCtrl filterSelectedBoarding:self.allPersonList];
        
        //        BBAlertView *alertView = [[BBAlertView alloc]
        //                                  initWithTitle:nil
        //                                  message: L(@"Please Choose Boarding Person")
        //                                  delegate:self
        //                                  cancelButtonTitle:L(@"Cancel")
        //                                  otherButtonTitles:nil];
        //        [alertView show];
        //        [alertView release];
        
        [self.navigationController pushViewController:listCtrl animated:YES];
        
        TT_RELEASE_SAFELY(listCtrl);
    }
}

#pragma mark -
#pragma mark 获取险种列表

- (void)getInsurances
{
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.insuranceSerivce beginGetInsuranceListRequest];
}

- (void)getInsuranceListCompletionWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg
                               insuranceList:(NSArray *)insurances
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        isInsurancesLoaded = YES;
        self.insuranceList = insurances;
        //获取险种列表成功，如果用户还未选择保险，则选择第一个为默认保险
        if (self.selectedInsurance == nil && [self.insuranceList count] > 0)
        {
            self.selectedInsurance = [self.insuranceList objectAtIndex:0];
            self.selectedInsurance.copyCount = CopyCountSingle;
        }
        [self calculateTotalAmount];
        [self updateTable];
    }else{
        [self presentSheet:L(@"BTGetInsuranceTypeFail")];
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark -  Properties Methods
#pragma mark    属性初始化方法
- (BoardingService *)boardingService{
    
    if (!_boardingService) {
        _boardingService = [[BoardingService alloc] init];
        _boardingService.delegate = self;
    }
    return _boardingService;
}

- (FlightOrderService *)orderService{
    
    if (!_orderService) {
        _orderService = [[FlightOrderService alloc] init];
        _orderService.delegate = self;
    }
    return _orderService;
}

- (InsuranceService *)insuranceSerivce
{
    if (!_insuranceSerivce) {
        _insuranceSerivce = [[InsuranceService alloc] init];
        _insuranceSerivce.delegate = self;
    }
    return _insuranceSerivce;
}

- (SNPopoverController *)snPopoverController
{
    if (!_snPopoverController) {
        _snPopoverController = [[SNPopoverController alloc] init];
        _snPopoverController.blackLayerFrame = self.view.frame;
    }
    return _snPopoverController;
}


- (PlanTicketService *)ticketOrderService{

    if (!_ticketOrderService) {
        _ticketOrderService = [[PlanTicketService alloc] init];
        _ticketOrderService.delegate = self;
    }
    return _ticketOrderService;
}
@end
