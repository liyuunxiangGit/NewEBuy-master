//
//  FlightListViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightListViewController.h"
#import "FlightInfoCell.h"
#import "FlightInfoDTO.h"
#import "FlightRoomInfoDTO.h"
#import "FlightFilter.h"
#import "OrderSubmitRootViewController.h"
#import "roomInfoCell.h"
#import "PlanTicketSwitch.h"

@interface FlightListViewController(){
				
    NSInteger selectedSection;

}

- (void)updateTableView;

- (FlightListDetailDTO*)getFlightDetail:(NSIndexPath *)indexPath;
- (void)getSectionViewInSection:(NSInteger)section atView:(UIView*)control;
- (void)chooseCompany:(NSString *)companyId;

- (void)sendProductDetailHttpReqeust;
- (void)sendReturnFlightHttpReqeust;

@end

@implementation FlightListViewController
@synthesize queryDTO = _queryDTO;
@synthesize isBackView = _isBackView;
@synthesize selectedArr = _selectedArr;
@synthesize companyFilterView = _companyFilterView;
@synthesize filterView = _filterView;
@synthesize titleView = _titleView;
@synthesize noResult = _noResult;
@synthesize ticketinfoService = _ticketinfoService;

- (void)dealloc {
    TT_RELEASE_SAFELY(_queryDTO);
    TT_RELEASE_SAFELY(_selectedArr);
    TT_RELEASE_SAFELY(_companyFilterView);
    TT_RELEASE_SAFELY(_filterView);
    TT_RELEASE_SAFELY(_titleView);
    TT_RELEASE_SAFELY(_noResult);
    SERVICE_RELEASE_SAFELY(_ticketinfoService);
    
}

- (id)initWithQueryDTO:(QueryConditionDTO*)queryDTO {
    
    self = [super init];
    if (self) {
         isLoaded = NO;
        _isBackView = NO;
        
        if (!queryDTO.isRoundTicket) {
            isGoBack = NO;
        } else {
            isGoBack = YES;
        }
        
        self.queryDTO = queryDTO;
        selectedSection = -1;
        
    }

    return self;
}

- (void)updateTableView{
    
    if (self.ticketinfoService.displayList == nil || [self.ticketinfoService.displayList count]==0) {
        
        if (self.noResult.superview == nil) {
                        
            [self.view addSubview:self.noResult];
        }
        
        self.companyFilterView.companyList = nil;
        
    }else{
                
        if (self.noResult.superview != nil) {
            
            [self.noResult removeFromSuperview];
            
        }
        
        [self.companyFilterView setCompanyList:self.ticketinfoService.companyList];
        
    }
    
    [self.companyFilterView setQueryDTO:self.queryDTO];

    [self.tableView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hasSuspendButton = YES;
    
    self.pageTitle = L(@"virtual_business_flightList");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置城市和时间
    self.titleView.frame = CGRectMake(0, 0, 320, 44);
    NSString *cityTitleStr = nil;
    if (isGoBack) {
        if (self.isBackView) {
            cityTitleStr = [NSString stringWithFormat:@"%@-%@(%@)",self.queryDTO.orgCity,self.queryDTO.desCity,L(@"BTGoBackWay")];
            self.title = L(@"BTFlightList--GoBack");
        }else{
            cityTitleStr = [NSString stringWithFormat:@"%@-%@(%@)",self.queryDTO.orgCity,self.queryDTO.desCity,L(@"BTGoWay")];
            self.title = L(@"BTFlightList--Go");
        }
        
    }else{
        cityTitleStr = [NSString stringWithFormat:@"%@-%@(%@)",self.queryDTO.orgCity,self.queryDTO.desCity,L(@"BTOneWay")];
        self.title = L(@"BTFlightList--SingleWay");
    }
    
    [self.titleView setCityStr:IsNilOrNull(cityTitleStr)?@"":cityTitleStr];

    NSString *timeTileStr = self.queryDTO.orgTime;
    [self.titleView setTimeStr:IsNilOrNull(timeTileStr)?@"":timeTileStr];
    
    //布局筛选模块
    self.filterView.frame = CGRectMake(0, 44, 320, 35);
    [self.filterView layoutFlightView];
    
    //布局搜索列表
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    frame.origin.y+=79;
    frame.size.height-=79;
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    
    //布局日期以及公司筛选页面
    CGRect frame1 = self.view.frame;
    frame1.origin.y = 0;
    self.companyFilterView.frame = frame1;
    [self.companyFilterView setQueryDTO:self.queryDTO];
    
}

- (void)viewDidUnload
{
    
    self.titleView = nil;
    self.filterView = nil;
    
    [super viewDidUnload];

}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    //如果是单程页面
    if (isGoBack != YES) {
        
        if (isLoaded == YES) {
            
            return;
            
        }else{
            
            isLoaded = NO;
            
            [self sendProductDetailHttpReqeust];
        }

    }
           
//预先请求返程的数据  
    
    //如果是往返程 并且是去程页面
    if (isGoBack == YES && self.isBackView != YES) {
        
        if (isLoaded == YES) {
            
            return;
            
        }else{
            
            isLoaded = NO;
            
            [self sendProductDetailHttpReqeust];
        }

        
        if (isReturnLoaded == YES) {
            
            return;
            
        }else{
                        
            [self sendReturnFlightHttpReqeust];
        }

    }
 //如果是往返程 并且是返程页面
    if (isGoBack == YES && self.isBackView == YES) {
        
        
        if (IsNilOrNull(self.ticketinfoService.flightList)||[self.ticketinfoService.flightList count]==0) {
            
            isLoaded = NO;
            
            [self sendProductDetailHttpReqeust];
            
        }else{
        
            isLoaded = YES;
            
            self.ticketinfoService.displayList = self.ticketinfoService.flightList;
            
            [self updateTableView];
        
        }
    }
}


#pragma mark - TableView Methods
#pragma mark   TableView的代理以及数据源方法


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (IsNilOrNull(self.ticketinfoService.displayList)||[self.ticketinfoService.displayList count]==0 ) {
        
        return 0;
    }
    
    return 95;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (IsNilOrNull(self.ticketinfoService.displayList)||[self.ticketinfoService.displayList count] == 0){
        
        return nil;
    }
    
    UIView  *backView = [[UIView alloc] init];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    [self getSectionViewInSection:section atView:backView];

    UIButton *control= [[UIButton alloc] init];
    
    control.backgroundColor = [UIColor clearColor];
    
    control.frame = CGRectMake(0, 0, 320, 95);
    
    control.tag = section;      
    
    [control addTarget:self action:@selector(selectFlight:) forControlEvents:UIControlEventTouchDown];
    
    [backView addSubview:control];
    
    TT_RELEASE_SAFELY(control);
        
    return backView;
    
}

-(void)selectFlight:(id)sender{
    
    UIControl *selectedView = (UIControl *)sender;
        
    if (selectedSection == selectedView.tag) {
        
        selectedSection = -1;        

        [self.tableView reloadData];

        CGRect rect = [self.tableView rectForHeaderInSection:selectedView.tag];
        
        [self.tableView scrollRectToVisible:rect animated:NO];
        
    }else{
        
        if (selectedSection != -1) {
            [self.tableView reloadData];
        }

        selectedSection = selectedView.tag;
        
        [self.tableView reloadData];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:selectedSection] atScrollPosition:UITableViewScrollPositionTop animated:NO ];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    }
    
}


- (void)getSectionViewInSection:(NSInteger)section atView:(UIView*)control{
    
    FlightInfoCell *cell = [[FlightInfoCell alloc] init];
    
    cell.height = 95;
        
    FlightListDetailDTO *dto = [self getFlightDetail:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    [cell setItem:dto];
    
    [control addSubview:cell];  
    
    TT_RELEASE_SAFELY(cell);
     
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (!IsNilOrNull(self.ticketinfoService.displayList)) {
                
        return [self.ticketinfoService.displayList count];
        
    }else{
        
        return 0;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    if (!IsNilOrNull(self.ticketinfoService.displayList)&&[self.ticketinfoService.displayList count]>0) {
        
        FlightInfoDTO *infoDto = [self.ticketinfoService.displayList objectAtIndex:section];
        
        NSArray *roomArr = infoDto.roomList;
        
        if (!IsNilOrNull(roomArr)) {
            
            if (selectedSection == section) {
                
                return [roomArr count] ;
                
            }else{
                
                return 0;
            }            
            
        } else {
            
            return 0;
            
        }
        
    } else {
        
        return 0;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!IsNilOrNull(self.ticketinfoService.displayList)&&[self.ticketinfoService.displayList count]>0){
        return 60;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flightListCell = @"flightListCell";
    
    roomInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:flightListCell];
    
    if (cell == nil)
    {
        cell = [[roomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flightListCell];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
    }
    
    [cell setItem: [self getFlightDetail:indexPath]];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  //获取点击的航班机票的信息列表。  
    if (IsNilOrNull(self.ticketinfoService.displayList)) {
        return;
    }
    
    FlightInfoDTO *dto = (FlightInfoDTO*)[self.ticketinfoService.displayList objectAtIndex:indexPath.section];
    
    FlightInfoDTO *flightDto = [dto copy];
    
    NSArray *roomList = flightDto.roomList;
    
    if (IsNilOrNull(roomList)) {
        
        TT_RELEASE_SAFELY(flightDto);
        
        return;
        
    }
    
    FlightRoomInfoDTO *roomDto = [roomList objectAtIndex:indexPath.row];
    
    if (IsNilOrNull(roomDto)) {
        
        TT_RELEASE_SAFELY(flightDto);
        
        return ;
        
    }
    
    flightDto.roomList = [NSArray arrayWithObject:roomDto];
    
    if (IsNilOrNull(self.selectedArr) ) {
        
        _selectedArr = [[NSMutableArray alloc] initWithObjects:flightDto, nil];
        
    }else{
        
        if ([self.selectedArr count]>0 ) {
            
            if (self.isBackView == NO) {
                
                [self.selectedArr removeAllObjects];

            }else if([self.selectedArr count] > 1){
            
                [self.selectedArr removeLastObject];
                
            }
            
        }
                
        [self.selectedArr addObject:flightDto];
    }

    
    if ((isGoBack == YES && self.isBackView == YES)||(isGoBack == NO)) {
         //往返类型，且当前页面是返程页面,进入结算页面。或者单程类型，进入结算页面。
                   
        OrderSubmitRootViewController *controller = [[OrderSubmitRootViewController alloc] init];
        
        controller.flightDetailDtoList = self.selectedArr;
        
        controller.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:controller animated:YES];
        
        TT_RELEASE_SAFELY(controller);
        
    }
    
    TT_RELEASE_SAFELY(flightDto);
    
    if ( isGoBack == YES &&self.isBackView == NO) {
        //往返类型，当前页面是去程页面，进入返程价格查询页面。
        QueryConditionDTO *backFlightDto = [[QueryConditionDTO alloc] init];
        
        backFlightDto.orgCity = self.queryDTO.desCity;
        backFlightDto.desCity = self.queryDTO.orgCity;
        backFlightDto.orgTime = self.queryDTO.returnTime;
        // backFlightDto.returnTime = self.queryDTO.returnTime;
        backFlightDto.isRoundTicket = self.queryDTO.isRoundTicket;
        
        FlightListViewController *backFlightListViewController = [[FlightListViewController alloc] initWithQueryDTO:backFlightDto];
        
        TT_RELEASE_SAFELY(backFlightDto);
                
        //传入提前请求的航班列表信息
        backFlightListViewController.ticketinfoService.flightList = self.ticketinfoService.returnFlightList;
        
        backFlightListViewController.ticketinfoService.companyList = self.ticketinfoService.rFlightCompanyList;
        
        backFlightListViewController.isBackView = YES; 
        
        backFlightListViewController.selectedArr = self.selectedArr;
        
        [self.navigationController pushViewController:backFlightListViewController animated:YES];
        
        TT_RELEASE_SAFELY(backFlightListViewController);
        
    }
        
}
    
- (FlightListDetailDTO*)getFlightDetail:(NSIndexPath *)indexPath{

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row ;
    
    FlightListDetailDTO *dto = [[FlightListDetailDTO alloc] init];
    if (section >= [self.ticketinfoService.displayList count]) {
        
        return nil;
    }
    
    FlightInfoDTO *infoDTO = [self.ticketinfoService.displayList objectAtIndex:section];
    FlightRoomInfoDTO *roomDTO = nil;
    if (!IsNilOrNull(infoDTO)) {
        
        dto.companyName = infoDTO.companyName;
        dto.oaFullName = infoDTO.oaFullName;
        dto.fTime = infoDTO.fTime;
        dto.aaFullName = infoDTO.aaFullName;
        dto.aTime = infoDTO.aTime; 
        dto.fNo = infoDTO.fNo;
        dto.fDate = infoDTO.fDate;
        dto.aDate = infoDTO.aDate;
        dto.company = infoDTO.company;

    }else{
        
        return nil;
        
    }
    
    if (! IsNilOrNull( infoDTO.roomList ) && [infoDTO.roomList count] != 0) {
        
        if (row >= [infoDTO.roomList count]) {
            
            return nil;
        }
        
        roomDTO = [infoDTO.roomList objectAtIndex:row];
        dto.roomPrice =[NSString stringWithFormat:@"%d",[roomDTO.sysPrice intValue] - [roomDTO.offPrice intValue]] ;
        dto.retPrice = roomDTO.retPrice;
        dto.offPrice = roomDTO.offPrice;
        dto.offRate = roomDTO.offRate;
        dto.room = roomDTO.room;
        if ([roomDTO.roomB isEqualToString:@"F"]) {
            dto.roomB = L(@"BTFirstClassCabin");
        }else if([roomDTO.roomB isEqualToString:@"C"]){
            dto.roomB = L(@"BTOfficalCabin");
        }else{
            dto.roomB = L(@"BTEconomyClass");
        }
                
    } else {
        
        return nil;
    }
 
    return dto;

}


#pragma mark - Request Product Detail
#pragma mark   数据请求方法

- (void)sendProductDetailHttpReqeust
{
    if (IsNilOrNull(self.queryDTO)) {
        return;
    } 
    
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    NSString *startCity = IsNilOrNull(self.queryDTO.orgCity )?@"":self.queryDTO.orgCity;
    
    NSString *stopCity = IsNilOrNull(self.queryDTO.desCity)?@"":self.queryDTO.desCity;
    
    NSString *startTime = IsNilOrNull(self.queryDTO.orgTime)?@"":self.queryDTO.orgTime;
        
    [self.ticketinfoService beginGetPlanTicketList:startCity toStopCity:stopCity atStartTime:startTime];
    
}

-(void)getGoFlightTicketService:(QueryTicketInfoService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];     

    if(YES == isSuccess)
    {
        self.noResult.text = L(@"BTSorryForNoFlight");
        isLoaded = YES;
      
    }
    else
    {
        isLoaded = NO;
        //[self presentSheet:L(@"Sorry loading failed")];
        
        if([errorMsg isEqualToString:L(@"NWFailTryLater")]){
         
            self.noResult.text = L(@"NWFailTryLater");
        }
    }
    
    [self updateTableView];
}


#pragma mark - 
#pragma mark ReturnFlight HttpRequest

- (void)sendReturnFlightHttpReqeust
{
    if (IsNilOrNull(self.queryDTO)) {
        
        return;
        
    } 
    
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    NSString *startCity = IsNilOrNull(self.queryDTO.desCity)?@"":self.queryDTO.desCity;
    
    NSString *stopCity = IsNilOrNull(self.queryDTO.orgCity )?@"":self.queryDTO.orgCity;
    
    NSString *returnTime = IsNilOrNull(self.queryDTO.orgTime)?@"":self.queryDTO.returnTime;
    
    [self.ticketinfoService beginGetReturnPlanTicketList:startCity toStopCity:stopCity atReturnTime:returnTime];
    
}


-(void)getBackFlightTicketService:(QueryTicketInfoService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];     

    if(YES == isSuccess)
    {
        isReturnLoaded = YES;
    }else{
        isReturnLoaded = NO;
        [self presentSheet:L(service.errorMsg)];
    }
    
}

#pragma mark -FlightListFilterViewDelegate Methods
#pragma mark  FlightListFilterViewDelegate 代理方法

- (void)filterPrice{
    
    if (self.companyFilterView.superview) {
        
        [self.companyFilterView removeFromSuperview];
    }
    
    NSArray *PriceHighToLow = [FlightFilter PriceHighToLow:self.ticketinfoService.displayList];
    
    if (self.filterView.isPriceLowToHigh == YES) {
        //价格从高到低
        
        if (IsNilOrNull(PriceHighToLow)) {
            
            // [self presentSheet:@"暂无航班" positon:CGPointMake(30, 50)];  
            
        }else{
            
            self.ticketinfoService.displayList = PriceHighToLow;
            
        }
        
    }else{
        //价格从低到高
        if (IsNilOrNull(PriceHighToLow)) {
            
            // [self presentSheet:@"暂无航班" positon:CGPointMake(30, 50)];  
            
        }else{
            
            NSMutableArray *PriceLowToHigh = [[NSMutableArray alloc] init];
            
            for (FlightInfoDTO *dto in PriceHighToLow) {
                
                [PriceLowToHigh insertObject:dto atIndex:0];
                
            }
            
            self.ticketinfoService.displayList = PriceLowToHigh;
            
            TT_RELEASE_SAFELY(PriceLowToHigh);
        }
        
    }
    
    TT_RELEASE_SAFELY(PriceHighToLow);
    
    [self updateTableView];
    
}


- (void)filterTime{
    
    if (self.companyFilterView.superview) {
        
        [self.companyFilterView removeFromSuperview];
    }
    
    NSArray *TimeEarlyToLateList =  [FlightFilter TimeEarliToLateByString:self.ticketinfoService.displayList];
    
    if (self.filterView.isTimeEarlyToLate == YES) {
         
        if (IsNilOrNull(TimeEarlyToLateList)) {
            
            //[self presentSheet:@"暂无航班" positon:CGPointMake(30, 50)];  
            
        }else{
            
            self.ticketinfoService.displayList = TimeEarlyToLateList;
            
        }
        
    }else{
        
        if (IsNilOrNull(TimeEarlyToLateList)) {
            
           // [self presentSheet:@"暂无航班" positon:CGPointMake(30, 50)];  
            
        }else{
            
            NSMutableArray *TimeLateToEarly = [[NSMutableArray alloc] init];
            
            for (FlightInfoDTO *dto in TimeEarlyToLateList) {
                
                [TimeLateToEarly insertObject:dto atIndex:0];
                
            }
            
            self.ticketinfoService.displayList = TimeLateToEarly; 
            
            TT_RELEASE_SAFELY(TimeLateToEarly);
        }
    }
    
    TT_RELEASE_SAFELY(TimeEarlyToLateList);

    [self updateTableView];

}

- (void)filterCompany{
    
    if (self.companyFilterView.superview == nil) {
        
        [self.view addSubview:self.companyFilterView];
        
    }else{
        
        [self.companyFilterView removeFromSuperview];
        
    }
}

- (void)chooseCompany:(NSString *)companyId{
    
    
    if (IsNilOrNull(self.ticketinfoService.flightList)) {
        
        return;
        
    }
    
    if ([companyId isEqualToString: @""]) {
        
        self.ticketinfoService.displayList = self.ticketinfoService.flightList; 
        
    }else{
        
        NSArray *filteredList =  [FlightFilter companyFilter:self.ticketinfoService.flightList byCompany:companyId];
        
        if (IsNilOrNull(filteredList)) {
            
            // [self presentSheet:@"暂无航班" positon:CGPointMake(30, 50)];  
            
        }else{
            
            self.ticketinfoService.displayList = filteredList;
            
        }
        
        TT_RELEASE_SAFELY(filteredList);
        
    }
        
    [self updateTableView];
    
}


#pragma mark -CompanyFilterViewDelegate Methods
#pragma mark  CompanyFilterViewDelegate 代理方法
- (void)chooseCompanyFilter:(NSString *)companyId{
    
    selectedSection = -1;
    
    [self chooseCompany:companyId];  
    
}

- (void)chooseFlightDate{
    
    NSString *timeTileStr = self.queryDTO.orgTime;
    
    [self.titleView setTimeStr:IsNilOrNull(timeTileStr)?@"":timeTileStr];
    
    [self sendProductDetailHttpReqeust];
    
}


#pragma mark - 
#pragma mark CustomizeUI  Methods

- (UILabel *)noResult{
    
    if (!_noResult) {
        
        _noResult = [[UILabel alloc] init];
        
        _noResult.font = [UIFont boldSystemFontOfSize:18];
        
        _noResult.textColor = [UIColor lightGrayColor];
        
        _noResult.textAlignment = UITextAlignmentCenter;
        
        _noResult.backgroundColor = [UIColor clearColor];
        
        _noResult.shadowColor = [UIColor blackColor];
        
        _noResult.shadowOffset = CGSizeMake(0.5, 0.5);
        
        _noResult.frame = CGRectMake(0, 150, 320, 20);
        
        _noResult.text = L(@"BTSorryForNoFlight");
        
        [self.view addSubview:_noResult];
        
    }

    return _noResult;
}

- (FlightListFilterView *)filterView{

    if (!_filterView) {
        _filterView = [[FlightListFilterView alloc] init];
        _filterView.delegate = self;
        [self.view addSubview:_filterView];
    }
    return _filterView;
}


- (CompanyFilterView *)companyFilterView{

    if (!_companyFilterView) {
        
        _companyFilterView = [[CompanyFilterView alloc] init];
        
        _companyFilterView.filterDelegate = self;
                
    }

    return _companyFilterView;
}


- (FlightListTitleView *)titleView{

    if (!_titleView) {
        
        _titleView = [[FlightListTitleView alloc] init];
                
        [_titleView setCityStr:@""];
        
        [_titleView setTimeStr:@""];
        
        _titleView.lineImage.frame = CGRectMake(0, 39, 320, 1);
        
        [self.view addSubview:_titleView];
        
    }
    
    return _titleView;

}

-(QueryTicketInfoService *)ticketinfoService
{
    if(nil == _ticketinfoService)
    {
        _ticketinfoService = [[QueryTicketInfoService alloc] init];
        _ticketinfoService.delegate = self;
    }
    return _ticketinfoService;
}


@end
