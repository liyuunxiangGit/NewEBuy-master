//
//  HotelOrderSubmitViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelOrderSubmitViewController.h"
#import "OrderInfoCell.h"
#import "HotelOrderSuccessViewController.h"
#import "HotelOrderHelpViewController.h"
//#import "SuningEBuyAppDelegate.h"
#import "HotelOrder.h"
#import "Preferences.h"

@implementation HotelOrderSubmitViewController

@synthesize selectRoomNum = _selectRoomNum;
@synthesize leaveTime = _leaveTime;
@synthesize arriveTime = _arriveTime;
@synthesize linkManName = _linkManName;
@synthesize linkManPhoneNum = _linkManPhoneNum;
@synthesize userNameDic = _userNameDic;

@synthesize headerView = _headerView;
@synthesize footerView = _footerView;
@synthesize hotelOrderSubmitHttpRequest = _hotelOrderSubmitHttpRequest;
@synthesize datasource = _datasource;
@synthesize orderService = _orderService;
@synthesize orderDto = _orderDto;

@synthesize bottomView=_bottomView;
@synthesize backBtn=_backBtn;
- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"Hotel_Order");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        self.selectRoomNum = @"1";
        isSelectOrNot = YES;
        isChangeRoomNum = YES;
        self.arriveTime=@"12:00";
        self.leaveTime=@"15:00";
        if (!_userNameDic) {
            _userNameDic = [[NSMutableDictionary alloc] init];
        }
        if (!_datasource) {
            _datasource = [[HotelDataSourceDTO alloc] init];
        }
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_backBtn);
    
    TT_RELEASE_SAFELY(_hotelOrderSubmitHttpRequest);
    TT_RELEASE_SAFELY(_footerView);
    TT_RELEASE_SAFELY(_headerView);
    TT_RELEASE_SAFELY(_selectRoomNum);
    TT_RELEASE_SAFELY(_linkManPhoneNum);
    TT_RELEASE_SAFELY(_linkManName);
    TT_RELEASE_SAFELY(_arriveTime);
    TT_RELEASE_SAFELY(_userNameDic);
    TT_RELEASE_SAFELY(_leaveTime);
    TT_RELEASE_SAFELY(_datasource);
    TT_RELEASE_SAFELY(_orderDto);
    SERVICE_RELEASE_SAFELY(_orderService);
}


- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	if (IOS7_OR_LATER) {
        frame.origin.y = -18;
    }else
        frame.origin.y = 0;
	
    
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.tpTableView.frame = frame;
    [self.tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tpTableView.backgroundColor=self.view.backgroundColor;
    
    [self.view addSubview:self.tpTableView];
    
    [self useBottomNavBar];
    [self configBottom];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(IsNilOrNull(self.linkManName))
    {
     
        self.linkManName = [[[UserCenter defaultCenter] userInfoDTO] userName]?  self.linkManName = [[[UserCenter defaultCenter] userInfoDTO] userName]:@"";
    }
    if(IsNilOrNull(self.linkManPhoneNum))
    {
    
        self.linkManPhoneNum = [[[UserCenter defaultCenter] userInfoDTO] phoneNo]?[[[UserCenter defaultCenter] userInfoDTO] phoneNo]:@"";
    }
    
    
//    self.arriveTime = @"12:00";
//    self.leaveTime = @"15:00";
    
}

//- (UIView *)headerView{
//    
//    if (!_headerView) {
//        
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
//        
//        _headerView.backgroundColor = [UIColor clearColor];
//        
//        EGOImageViewEx *hotelImage = [[EGOImageViewEx alloc] init];
//        hotelImage.backgroundColor = [UIColor clearColor];        
//        hotelImage.frame = CGRectMake(10, 5, 60, 70);
//        hotelImage.exDelegate = self;
//        hotelImage.delegate = self;
////        hotelImage.layer.cornerRadius = 5;
////        hotelImage.layer.masksToBounds = YES;
//        hotelImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
//        hotelImage.imageURL = self.datasource.productImg;
//        hotelImage.userInteractionEnabled = YES;
//        hotelImage.contentMode = UIViewContentModeScaleToFill;
//        [_headerView addSubview:hotelImage];
//
//        UILabel *hotelName = [[UILabel alloc] initWithFrame:CGRectMake(hotelImage.right + 10, 10, 245, 40)];
//        hotelName.backgroundColor = [UIColor clearColor];
//        hotelName.numberOfLines = 0;
//        hotelName.text = self.datasource.hotelName;
//        hotelName.font = [UIFont boldSystemFontOfSize:17.0];
//        [_headerView addSubview:hotelName];
//        
//        UILabel *hotelType = [[UILabel alloc] initWithFrame:CGRectMake(hotelName.left, hotelName.bottom, 150, 20)];
//        hotelType.backgroundColor = [UIColor clearColor];
//        hotelType.text = self.datasource.roomTypeName;
//        hotelType.textColor = [UIColor grayColor];
//        hotelType.font = [UIFont boldSystemFontOfSize:15.0];
//        [_headerView addSubview:hotelType];
//
//    }
//    
//    return _headerView;
//}

//- (UIView *)footerView{
//    
//    if (!_footerView) {
//        
//        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
//        _footerView.backgroundColor = [UIColor clearColor];
//        
//        UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
//        commit.frame = CGRectMake(10, 10, 301, 44);
//        //[commit setBackgroundImage:[UIImage imageNamed:@"hotel_order_commit.png"] forState:UIControlStateNormal];
//        [commit setTitle:L(@"commitPay") forState:UIControlStateNormal]; 
//        UIImage *image = [UIImage streImageNamed:@"join_YellowButton.png"];
//        [commit setBackgroundImage:image forState:UIControlStateNormal];
//        commit.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
//        [commit setTitleColor:[UIColor darkRedColor] forState:UIControlStateNormal];
//
//        [commit addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
//        [_footerView addSubview:commit];
//    }
//    
//    return _footerView;
//}

-(HotelOrderService *)orderService
{
    if(nil == _orderService)
    {
        _orderService = [[HotelOrderService alloc] init];
        _orderService.delegate = self;
    }   
    return _orderService;
}

-(HotelOrderDTO *)orderDto
{
    if(nil == _orderDto)
    {
        _orderDto = [[HotelOrderDTO alloc] init];
    }
    _orderDto.hotelId = self.datasource.hotelId;
    _orderDto.userId = [[[UserCenter defaultCenter] userInfoDTO] userId]; 
    _orderDto.memberCardNo = [[[UserCenter defaultCenter] userInfoDTO] memberCardNo];
    _orderDto.internalNum = [[[UserCenter defaultCenter] userInfoDTO] internalNum];
    _orderDto.roomTypeId = self.datasource.roomTypeId;
    _orderDto.ratePlanId = self.datasource.ratePlanId;
    _orderDto.startDate = self.datasource.startDate;
    _orderDto.endDate = self.datasource.endDate;
    _orderDto.linkManName = self.linkManName;
    _orderDto.linkManPhoneNum = self.linkManPhoneNum;
    _orderDto.selectRoomNum = self.selectRoomNum;
    _orderDto.arriveTime = self.arriveTime;
    _orderDto.leaveTime = self.leaveTime;
    return _orderDto;
}



- (void)resignKeyBoardInView:(UIView *)view 
{ 
    for (UIView *v in view.subviews) { 
        if ([v.subviews count] > 0) { 
            [self resignKeyBoardInView:v]; 
        } 
        
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]) { 
            [v resignFirstResponder]; 
        } 
    } 
} 

- (HotelOrderSubmitHttpRequest *)hotelOrderSubmitHttpRequest{
    
    if (!_hotelOrderSubmitHttpRequest) {
        
        _hotelOrderSubmitHttpRequest = [[HotelOrderSubmitHttpRequest alloc] init];
        
        _hotelOrderSubmitHttpRequest.delegate = self;
    }
    
    return _hotelOrderSubmitHttpRequest;
}


- (void)commit:(id)sender{
    
    [self resignKeyBoardInView:self.view];
    
    NSString *guestNameList = @"";
    
    for (int i = 0; i < [self.selectRoomNum intValue]; i++) {
        
        NSString *guestName = [self.userNameDic objectForKey:[NSString stringWithFormat:@"%d",i]];
        
        if (guestName == nil || [guestName isEqualToString:@""]||[self validateChinese:guestName] == NO) {
            
            [self presentSheet:[NSString stringWithFormat:@"%@%d%@",L(@"BTHotelPartOne"),i+1,L(@"BTHotelPartTwo")]];
            return;
        }
        if (i == 0) {
            guestNameList = guestName;
        }
        else{
            guestNameList = [guestNameList stringByAppendingFormat:@",%@",guestName];
        }
    }
        
    if (self.arriveTime ==nil || [self.arriveTime isEqualToString:@""]) {
        
        [self presentSheet:L(@"Please select arrive time")];
        
        return;
    }
    
    NSString *arr = self.datasource.startDate;
    
    NSString *currentDate = [Preferences currentSystemTime];
    
    if ([currentDate hasPrefix:arr]) {
    
        if ([self  convertDateToString:[currentDate substringWithRange:NSMakeRange(11, 2)]] >= [self convertDateToString:[self.arriveTime substringWithRange:NSMakeRange(0, 2)]]) {
            
            [self presentSheet:L(@"BTMoveIntoTime")];
            
            return;        
        }
    }

    
    if((self.linkManName == nil) || [self.linkManName isEqualToString:@""]||[self validateChinese:self.linkManName] == NO){
      
        [self presentSheet:L(@"Linkman name need 2-6 chinese")];
		
        return;
	}

    
	if((self.linkManPhoneNum == nil) || [self.linkManPhoneNum isEqualToString:@""]){
        [self presentSheet:L(@"input phoneNum")];
		return;
	}
    
    if (![self validateMobileNo:self.linkManPhoneNum]) {
		[self presentSheet:L(@"please input your real number")];
		return;
	}
    
    if (isSelectOrNot) {
        
        [self presentSheet:L(@"BTPleaseAgreeNegotiate")];
        return;
    }
    
    [self displayOverFlowActivityView:L(@"BTPleaseWait")];
    
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
//
//    [postDataDic setObject:self.datasource.hotelId?self.datasource.hotelId:@"" forKey:kHttpRequestHotelId];
//   
//    [postDataDic setObject:[[[UserCenter defaultCenter] userInfoDTO] userId]?[[[UserCenter defaultCenter] userInfoDTO] userId]:@"" forKey:kHttpRequestMemberId];
//
//    [postDataDic setObject:[[[UserCenter defaultCenter] userInfoDTO] memberCardNo]?[[[UserCenter defaultCenter] userInfoDTO] memberCardNo]:@"" forKey:kHttpRequestMemberCardNum];
//    
//    [postDataDic setObject:[[[UserCenter defaultCenter] userInfoDTO] internalNum]?[[[UserCenter defaultCenter] userInfoDTO] internalNum]:@"" forKey:kHttpRequestInternalNum];
//   
//    [postDataDic setObject:self.datasource.roomTypeId?self.datasource.roomTypeId:@"" forKey:kHttpRequestRoomTypeId];
//    
//    [postDataDic setObject:self.datasource.ratePlanId?self.datasource.ratePlanId:@"" forKey:kHttpRequestRatePlanId];
//    [postDataDic setObject:self.datasource.startDate?self.datasource.startDate:@"" forKey:kHttpRequestCheckInDate];
//    [postDataDic setObject:self.datasource.endDate?self.datasource.endDate:@"" forKey:kHttpRequestCheckOutDate];
//    [postDataDic setObject:guestNameList?guestNameList:@"" forKey:kHttpRequestGuestNames];
//
//    [postDataDic setObject:self.linkManName?self.linkManName:@"" forKey:kHttpRequestLinkMan];
//    
//    [postDataDic setObject:self.linkManPhoneNum?self.linkManPhoneNum:@"" forKey:kHttpRequestLinkMobile];
//    [postDataDic setObject:self.selectRoomNum?self.selectRoomNum:@"" forKey:kHttpRequestRoomAmount];
//    [postDataDic setObject:self.arriveTime?self.arriveTime:@"" forKey:kHttpRequestArrivalEarlyTime];
//    [postDataDic setObject:self.leaveTime?self.leaveTime:@"" forKey:kHttpRequestArrivalLateTime];
//    [postDataDic setObject:@"" forKey:kHttpRequestLinkEmail];    
//
////    [postDataDic setObject:@"40101002" forKey:kHttpRequestHotelId];
////    [postDataDic setObject:@"33000698698" forKey:kHttpRequestMemberId];
////    [postDataDic setObject:@"" forKey:kHttpRequestMemberCardNum];
////    [postDataDic setObject:@"" forKey:kHttpRequestInternalNum];
////    [postDataDic setObject:@"1024" forKey:kHttpRequestRoomTypeId];
////    
////    [postDataDic setObject:@"33422" forKey:kHttpRequestRatePlanId];
////    [postDataDic setObject:@"2012-07-21" forKey:kHttpRequestCheckInDate];
////    [postDataDic setObject:@"2012-07-22" forKey:kHttpRequestCheckOutDate];
////    [postDataDic setObject:@"张建" forKey:kHttpRequestGuestNames];
////    [postDataDic setObject:@"张建" forKey:kHttpRequestLinkMan];
////    
////    [postDataDic setObject:@"15996267171" forKey:kHttpRequestLinkMobile];
////    [postDataDic setObject:@"1" forKey:kHttpRequestRoomAmount];
////    [postDataDic setObject:@"10:00" forKey:kHttpRequestArrivalEarlyTime];
////    [postDataDic setObject:@"13:00" forKey:kHttpRequestArrivalLateTime];
//    [postDataDic setObject:@"" forKey:kHttpRequestLinkEmail];    
//
//    [self.hotelOrderSubmitHttpRequest hotelOrderSubmitHttpRequest:postDataDic];
//    
//    [postDataDic release];
    self.orderDto.guestName = guestNameList;
    [self displayOverFlowActivityView];
    [self.orderService beginHotelOrderSumbit:self.orderDto];
}

-(void)getHotelOrderService:(HotelOrderService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        HotelOrderSuccessViewController *hotelOrderSuccess = [[HotelOrderSuccessViewController alloc] init];
        
        [self.navigationController pushViewController:hotelOrderSuccess animated:YES];
        
    }
    else{
        
        [self presentSheet:errorMsg];
        
    }

}

- (void)httpRequestCompleted:(BOOL)successResult errorCode:(NSString *)errorCode errorDesc:(NSString *)errorDesc{

    [self removeOverFlowActivityView];
    
    if (YES == successResult ) {
        
        if (errorDesc == nil || [errorDesc isEqualToString:@""]) {
          
            HotelOrderSuccessViewController *hotelOrderSuccess = [[HotelOrderSuccessViewController alloc] init];
            
            [self.navigationController pushViewController:hotelOrderSuccess animated:YES];            
        }        
    }
    else{            
            [self presentSheet:errorDesc];        
    }
}


#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==1||section==2) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 165;
    }
    if (indexPath.section==1&&indexPath.row==0) {
        return 25;
    }
    if (indexPath.section ==1 && [self.selectRoomNum isEqualToString:@"1"]) {
        return 110;
    }
    if (indexPath.section == 1 && ![self.selectRoomNum isEqualToString:@"1"]) {
        return 75 + [self.selectRoomNum intValue] * 35;
    }
    if (indexPath.section==2&&indexPath.row==0) {
        return 25;
    }
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 80;
//    }
//    if (section == 3) {
//        return 15;
//    }
//    return 30;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        
//        return self.headerView;    
//    }
//    return nil;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    if (section == 3) {
//        return 70;
//    }
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return 0;
//    }else if(section==3){
//        return 30;
//    }
    return 15;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    if (section == 3) {
//        return self.footerView;
//    }
//    return nil;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section==1 || section==2) {
////        UIView* headerView=[[UIView alloc] init];
////        [headerView setBackgroundColor:[UIColor clearColor]];
////        [headerView setFrame:CGRectMake(0, 0, 320, 45)];
//        
//        UILabel* lbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 280, 24)];
//        [lbl setBackgroundColor:[UIColor clearColor]];
//        lbl.textColor=[UIColor dark_Gray_Color];
//        lbl.font=[UIFont systemFontOfSize:15];
//        lbl.text=((section==1)?L(@"Guest_Info"):L(@"LinkMan_Info"));
////        [headerView addSubview:lbl];
//        return lbl;
//    }
//    if (section==3) {
//        UIView* headerView=[[UIView alloc] init];
//        [headerView setBackgroundColor:[UIColor clearColor]];
//        
//        [headerView setFrame:CGRectMake(0, 0, 320, 30)];
//        return headerView;
//    }
//    return nil;
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    if (section == 1) {
//        return L(@"Guest_Info");
//    }
//    if (section == 2) {
//        return L(@"LinkMan_Info");
//    }
//    return @"";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *orderRoomNumIndentifier = @"orderRoomNumIndentifier";
        
        OrderRoomNumCell *cell = (OrderRoomNumCell *)[tableView dequeueReusableCellWithIdentifier:orderRoomNumIndentifier];
        
        if (cell == nil) {
            
            cell = [[OrderRoomNumCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderRoomNumIndentifier];
            cell.delegate = self;
        }
        
        UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 165)];//保证ios6白底
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView insertSubview:bgView atIndex:0];
        
        NSArray *item = [[NSArray alloc] initWithObjects:self.datasource.hotelName,self.datasource.roomTypeName,self.datasource.startDate,self.datasource.endDate, nil];
        
        [cell initDatasource:item];

        
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row==0) {
            static NSString *headSectionCell = @"headSectionCell";
            
            
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:headSectionCell];
            
            if (cell==nil) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headSectionCell];
                cell.backgroundView=nil;
                cell.backgroundColor=[UIColor clearColor];
                
                UILabel* headSectionLbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 18)];
                headSectionLbl.textColor=[UIColor dark_Gray_Color];
                headSectionLbl.backgroundColor=[UIColor clearColor];
                headSectionLbl.font=[UIFont boldSystemFontOfSize:15.0];
                headSectionLbl.text=L(@"Guest_Info");
                
                [cell addSubview:headSectionLbl];
            }
            return cell;
        }
        static NSString *GuestInfoIndentifier = @"GuestInfoIndentifier";
        
        GuestInfoCell *cell = (GuestInfoCell *)[tableView dequeueReusableCellWithIdentifier:GuestInfoIndentifier];
        
        if (isChangeRoomNum) {
            
            [cell.contentView removeAllSubviews];
        }
        
        if (cell == nil) {
            
            cell = [[GuestInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GuestInfoIndentifier];
            cell.delegate = self;
        }
        
//        float cellHeight=75+[self.selectRoomNum intValue] * 35;
//        
//        UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, cellHeight)];//保证ios6白底
//        [bgView setBackgroundColor:[UIColor whiteColor]];
//        [cell.contentView insertSubview:bgView atIndex:0];
        
        [cell initDataSourceWithRoomNum:self.selectRoomNum isChangeRoomNum:isChangeRoomNum checkInTime:self.datasource.startDate earliestArriveTime:self.arriveTime lastestArriveTime:self.leaveTime guestInfo:self.userNameDic];
        
        isChangeRoomNum = NO;
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row==0) {
            static NSString *headSectionCell = @"headSectionCell";
            
            
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:headSectionCell];
            
            if (cell==nil) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headSectionCell];
                cell.backgroundView=nil;
                cell.backgroundColor=[UIColor clearColor];
                
                UILabel* headSectionLbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 18)];
                headSectionLbl.textColor=[UIColor dark_Gray_Color];
                headSectionLbl.backgroundColor=[UIColor clearColor];
                headSectionLbl.font=[UIFont boldSystemFontOfSize:15.0];
                headSectionLbl.text=L(@"LinkMan_Info");
                
                [cell addSubview:headSectionLbl];
            }
            return cell;
        }
        static NSString *linkManInfoIndentifier = @"linkManInfoIndentifier";
        
        LinkManInfoCell *cell = (LinkManInfoCell *)[tableView dequeueReusableCellWithIdentifier:linkManInfoIndentifier];
        
        if (cell == nil) {
            
            cell = [[LinkManInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:linkManInfoIndentifier];
            cell.delegate = self;
        }
//        UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];//保证ios6白底
//        [bgView setBackgroundColor:[UIColor whiteColor]];
//        [cell.contentView insertSubview:bgView atIndex:0];
        
        [cell initLinkManInfo];
        
        return cell;
    }

    static NSString *orderInfoIndentifier = @"orderInfoIndentifier";
    
    OrderInfoCell *cell = (OrderInfoCell *)[tableView dequeueReusableCellWithIdentifier:orderInfoIndentifier];
    
    if (cell == nil) {
        
        cell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderInfoIndentifier];
        
        [cell.helpBtn addTarget:self action:@selector(goToHelp) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.selectBtn addTarget:self action:@selector(selectDelegateText) forControlEvents:UIControlEventTouchUpInside];
    }
//    UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];//保证ios6白底
//    [bgView setBackgroundColor:[UIColor whiteColor]];
//    [cell.contentView insertSubview:bgView atIndex:0];
    
    int totalPrice = [self.selectRoomNum intValue] * [self.datasource.totalPrice intValue] * [self.datasource.dateTime intValue];
    
    [cell initOrderPrice:[NSString stringWithFormat:@"￥%d", totalPrice] isSelect:isSelectOrNot];
    
    return cell;
    
}


- (void)goToHelp{
    
    HotelOrderHelpViewController *next = [[HotelOrderHelpViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)selectDelegateText{
    
//    NSIndexSet *index = [[NSIndexSet alloc] initWithIndex:3];
    
    isSelectOrNot = !isSelectOrNot;
//    if (!isSelectOrNot) {
//        [self goToHelp];
//    }    
//    [self.tpTableView reloadSections:index withRowAnimation:UITableViewRowAnimationMiddle];
    
    [self.tpTableView reloadData];
    
    
}
#pragma mark - bottomView
-(void)configBottom
{
    self.bottomNavBar.backButton.hidden=YES;
    self.bottomNavBar.ebuyBtn.hidden=YES;
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(30, 6.5, 260, 35);
    [commit setTitle:L(@"commitPay") forState:UIControlStateNormal];
    UIImage *image = [UIImage streImageNamed:@"orange_button.png"];
    [commit setBackgroundImage:image forState:UIControlStateNormal];
    UIImage *clickedImage = [UIImage streImageNamed:@"orange_button_clicked.png"];
    [commit setBackgroundImage:clickedImage forState:UIControlStateSelected];
    commit.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomNavBar addSubview:commit];
    
}
//- (UIView*)bottomView
//{
//    if(!_bottomView)
//    {
//        _bottomView = [[UIView alloc] init];
//        
//        _bottomView.backgroundColor = [UIColor whiteColor];
//        
//        _bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height -55-20, self.view.frame.size.width, 55);
//        [_bottomView addSubview:self.backBtn];
//        
//        UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
//        commit.frame = CGRectMake(40, 8, 260, 40);
//        [commit setTitle:L(@"commitPay") forState:UIControlStateNormal];
//        UIImage *image = [UIImage streImageNamed:@"orange_button.png"];
//        [commit setBackgroundImage:image forState:UIControlStateNormal];
//        UIImage *clickedImage = [UIImage streImageNamed:@"orange_button_clicked.png"];
//        [commit setBackgroundImage:clickedImage forState:UIControlStateSelected];
//        commit.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
//        [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [commit addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:commit];
//        
//        UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
//        [lineImage setImage:img];
//        [_bottomView addSubview:lineImage];
//        
//    }
//    
//    return _bottomView;
//}
//
//- (UIButton*)backBtn
//{
//    if(!_backBtn)
//    {
//        _backBtn = [[UIButton alloc] init];
//        
//        _backBtn.backgroundColor = [UIColor clearColor];
//        
//        _backBtn.frame = CGRectMake(0, 6, 44, 44);
//        
//        [_backBtn setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
//        
//        [_backBtn setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
//        
//        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [self.bottomView addSubview:_backBtn];
//    }
//    
//    return _backBtn;
//}
//
//
//
//- (void)backBtnAction
//{
//    [self backForePage];
//}

#pragma mark -
#pragma mark cell delegate

//OrderRoomNumCell

- (void)selectOrderRoomNum:(NSString *)roomNum{
        
    if ([self.selectRoomNum isEqualToString:roomNum]) {
        
        return;
    }else
    {
         isChangeRoomNum = YES;   
    }
    
    self.selectRoomNum = roomNum;
    
    NSIndexSet *index = [[NSIndexSet alloc] initWithIndex:1];
    
    [self.tpTableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
//LinkManInfoCell
- (void)sendLinkManName:(NSString *)username{
    
    self.linkManName = username;
}

- (void)sendLinkManPhoneNum:(NSString *)phoneNum{
    
    self.linkManPhoneNum = phoneNum;
}

//GuestInfoCell
- (void)setGuestName:(NSString *)username withTag:(int)tag{
    
//    _userNameDic = [username mutableCopy];
    [_userNameDic setObject:username forKey:[NSString stringWithFormat:@"%d",tag]];
}

- (void)setArriveTime:(NSString *)arriveTime leaveTime:(NSString *)leaveTime{

    if (arriveTime == nil || [arriveTime isEqualToString:@""]) {
        
        self.arriveTime = @"";
        
        [self presentSheet:L(@"BTMoveIntoTime") posY:50];
        
        return;

    }
    
    self.arriveTime = arriveTime;
    
    self.leaveTime = leaveTime;
    
}

//数据校验
- (BOOL) validateChinese: (NSString *)userName{
    if (!userName || [userName isEmptyOrWhitespace]) 
    {
        return NO;
    }
    NSString *shouhuorenRegex = @"[\\u4e00-\\u9fa5]{2,6}";    
    NSPredicate *shouhuorenTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", shouhuorenRegex];
    return [shouhuorenTest evaluateWithObject:userName];  
}

- (BOOL) validateMobileNo: (NSString *) mobileNo {
    NSString *mobileNoRegex = @"1\\d{10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex]; 
    return [mobileNoTest evaluateWithObject:mobileNo];
}



- (int)convertDateToString:(NSString *)string{
    
    int date = 0;
    
    if ([string hasPrefix:@"0"]) {
        
        date = [[string substringToIndex:1] intValue];
    }
    else{
        date = [string intValue];
    }
    
    return date;
}


@end
