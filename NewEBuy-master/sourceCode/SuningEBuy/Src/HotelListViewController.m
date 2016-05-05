//
//  HotelListViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelListViewController.h"
#import "HotelListCell.h"
#import "HotelOrder.h"
#import "HotelDetailViewControlller.h"



@implementation HotelListViewController


@synthesize hotelListSegment=_hotelListSegment;
@synthesize hotelList = _hotelList;
@synthesize hotelListHttpRequest = _hotelListHttpRequest;
@synthesize searchData = _searchData;
@synthesize sort = _sort;

@synthesize sortType  = _sortType;
@synthesize dataSource = _dataSource;
@synthesize emptyDataLabel = _emptyDataLabel;
@synthesize hotelName = _hotelName;
@synthesize snStar = _snStar;

@synthesize queryHotelDto = _queryHotelDto;
@synthesize searchHotelService = _searchHotelService;

- (id)init {
    self = [super init];
    if (self) {
        
        self.title = L(@"Hotel_List");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        currentPage = 1;
        totalPage = 1;
        isLastPage = YES;
        self.sort = @"1";
        self.sortType = @"0";
        if (!_hotelList) {
            _hotelList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (id)initWithSearchData:(NSMutableArray *)searchData{
    
    self = [super init];
    if (self) {
        
        self.title = L(@"Hotel_List");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        currentPage = 1;
        totalPage = 1;
        isLastPage = YES;
        self.sort = @"1";
        self.sortType = @"0";
        
        isHttpRequestOk = NO;
        
        if (!_hotelList) {
            _hotelList = [[NSMutableArray alloc] init];
        }
        if (!_searchData) {
            _searchData = [[NSMutableArray alloc] init];
        }
        self.searchData = searchData;
        
        if (!_dataSource) {
            _dataSource = [[HotelDataSourceDTO alloc] init];
        }
        [self initDataSource];
        
    }
    
    return self;
    
}

- (void)initDataSource{
    
    self.dataSource.cityName = [self.searchData objectAtIndex:0];
    
    NSString *hotelAroundId = [self.searchData objectAtIndex:1];
    if ([hotelAroundId isEqualToString:L(@"BTIrrestriction")]) {
        self.dataSource.hotelAroundId = @"";
    }
    else{
        self.dataSource.hotelAroundId = hotelAroundId;
    }
 
    NSString *hotelName = [self.searchData objectAtIndex:2];
    if ([hotelName isEqualToString:L(@"BTIrrestriction")]) {
        self.dataSource.hotelName = @"";
    }
    else{
        self.dataSource.hotelName = hotelName;
    }
    
    self.dataSource.startDate = [self.searchData objectAtIndex:3];
    
    self.dataSource.dateTime = [self.searchData objectAtIndex:4];
    
    NSString *priceArea = [self.searchData objectAtIndex:5];
    if ([priceArea isEqualToString:L(@"BTIrrestriction")]) {
        self.dataSource.priceArea = @"0";
    }
    else{
        self.dataSource.priceArea = priceArea;
    }

    NSString *starGrade = [self.searchData objectAtIndex:6];
    if ([starGrade isEqualToString:L(@"BTIrrestriction")]) {
        self.dataSource.starGrade = @"0";
        self.snStar = @"0";
    }
    else{
        self.snStar = starGrade;
        self.dataSource.starGrade = starGrade;
    }

    self.dataSource.endDate = [self.searchData objectAtIndex:7];

}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_hotelList);
    TT_RELEASE_SAFELY(_hotelListSegment);
    TT_RELEASE_SAFELY(_hotelListHttpRequest);
    TT_RELEASE_SAFELY(_searchData);
    
    TT_RELEASE_SAFELY(_sortType);
    TT_RELEASE_SAFELY(_sort);
    TT_RELEASE_SAFELY(_dataSource);
    TT_RELEASE_SAFELY(_emptyDataLabel);
    TT_RELEASE_SAFELY(_snStar);
    TT_RELEASE_SAFELY(_queryHotelDto);
    SERVICE_RELEASE_SAFELY(_searchHotelService);
    
    
}

- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 32;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
        frame.size.height = contentView.bounds.size.height - 44 - 32-20;
    }else{
        frame.size.height = contentView.bounds.size.height - 44 - 32;
    }
    
//    UIView *contentView = self.view;
//    CGRect frame = contentView.frame;
//    
//    frame.origin.y=frame.origin.y+32;
//    frame.size.height=frame.size.height-39;
    self.tableView.frame = frame;
    
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    [self.view addSubview:self.tableView];
    
    self.hasSuspendButton=YES;
}

- (UILabel *)emptyDataLabel{
    
    if (!_emptyDataLabel) {
        
        _emptyDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
        
        _emptyDataLabel.backgroundColor = [UIColor clearColor];
                
        _emptyDataLabel.textColor = [UIColor darkGrayColor];
        
        _emptyDataLabel.textAlignment = UITextAlignmentCenter;
    }
    
    return _emptyDataLabel;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    [self.view addSubview:self.hotelListSegment];
    
    if (!isHttpRequestOk) {

        //[self.hotelListHttpRequest searchHotelHttpRequest:[self packagePostDataDic]];
        [self displayOverFlowActivityView];
        [self.searchHotelService beginSearchHotelHttpRequest:self.queryHotelDto];    
    }
    
}

-(HotelListSegment*)hotelListSegment{
    if (_hotelListSegment==nil) {
        _hotelListSegment=[[HotelListSegment alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
        _hotelListSegment.delegate=self;
    }
    return _hotelListSegment;
}


- (NSMutableDictionary *)packagePostDataDic{    
    
    [self displayOverFlowActivityView];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];

    [postDataDic setObject:self.dataSource.cityName?self.dataSource.cityName:@"" forKey:kHttpRequestCityName];
    [postDataDic setObject:self.dataSource.hotelAroundId?self.dataSource.hotelAroundId:@"" forKey:kHttpRequestHotelAroundId];
    [postDataDic setObject:self.hotelName?self.hotelName:@"" forKey:kHttpRequestHotelName];
    
    [postDataDic setObject:self.dataSource.startDate?self.dataSource.startDate:@"" forKey:kHttpRequestStartDate];
    [postDataDic setObject:self.dataSource.endDate?self.dataSource.endDate:@"" forKey:kHttpRequestEndDate];
    
    [postDataDic setObject:self.dataSource.priceArea?self.dataSource.priceArea:@"" forKey:kHttpRequestPriceArea];
    [postDataDic setObject:self.snStar?self.snStar:@"" forKey:kHttpRequestStarGrade];
    [postDataDic setObject:self.sortType?self.sortType:@"" forKey:kHttpRequestSorttype];
    [postDataDic setObject:self.sort?self.sort:@"" forKey:kHttpRequestSort];
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:kHttpRequestPageNum];  

    return postDataDic;
}

-(QueryHotelDTO *)queryHotelDto
{
    if(nil == _queryHotelDto)
    {
        _queryHotelDto = [[QueryHotelDTO alloc] init];
    }
    _queryHotelDto.cityName = self.dataSource.cityName;
    _queryHotelDto.hotelAroundId = self.dataSource.hotelAroundId;
    _queryHotelDto.hotelName = self.dataSource.hotelName;
    _queryHotelDto.startDate = self.dataSource.startDate;
    _queryHotelDto.endDate = self.dataSource.endDate;  
    _queryHotelDto.priceArea = self.dataSource.priceArea;
    _queryHotelDto.snStar = self.snStar;
    _queryHotelDto.sortType = self.sortType;   
    _queryHotelDto.sort = self.sort;
    _queryHotelDto.currentPage = [NSString stringWithFormat:@"%d",currentPage];
    return _queryHotelDto;
}

-(SearchHotelService *)searchHotelService
{
    if(nil == _searchHotelService)
    {
        _searchHotelService = [[SearchHotelService alloc] init];
        _searchHotelService.delegate = self;
    }
    return _searchHotelService;
}


- (HotelListHttpRequest *)hotelListHttpRequest{
    
    if (!_hotelListHttpRequest) {
        
        _hotelListHttpRequest = [[HotelListHttpRequest alloc] init];
        
        _hotelListHttpRequest.delegate = self;
    }
    
    return _hotelListHttpRequest;
}

- (void)httpRequestCompleted:(NSArray *)list pageCount:(NSString *)pageCount withResult:(NSString *)successResult errorDesc:(NSString *)errorDesc{
    
    [self removeOverFlowActivityView];
    
    if ([successResult isEqualToString:@"0"]) {
       
        [self presentSheet:errorDesc];
        
        return;
    }
    
    isHttpRequestOk = YES;
    
    if (currentPage < [pageCount intValue]) {
        isLastPage = NO;
    }
    else{
        isLastPage = YES;
    }
    if (currentPage == 1) {
        
        if (list == nil || [list count] == 0) {

            self.emptyDataLabel.text = L(@"BTCanNotSearchForThisKindOfHotel");
            self.tableView.tableFooterView = self.emptyDataLabel;

        }
        
        else{
            self.emptyDataLabel.text = @"";
            
            self.hotelList = (NSMutableArray *)list;   
        }     
    }
    else{
        [self.hotelList addObjectsFromArray:list];
    }


    [self performSelectorOnMainThread:@selector(updateTableView) withObject:self waitUntilDone:NO];
    
}

-(void)getHotelListService:(SearchHotelService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (NO == isSuccess) {
        
        [self presentSheet:errorMsg];
        
        return;
    }
    
    isHttpRequestOk = YES;
    
    if (currentPage < [service.pageCount intValue]) {
        isLastPage = NO;
    }
    else{
        isLastPage = YES;
    }
    if (currentPage == 1) {
        
        if (service.hotelList == nil || [service.hotelList count] == 0) {
            
            self.emptyDataLabel.text = L(@"BTCanNotSearchForThisKindOfHotel");
            self.tableView.tableFooterView = self.emptyDataLabel;
            
        }
        
        else{
            self.emptyDataLabel.text = @"";
            
            self.hotelList = (NSMutableArray *)service.hotelList;   
        }     
    }
    else{
        [self.hotelList addObjectsFromArray:service.hotelList];
    }
    
    
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:self waitUntilDone:NO];

}


- (void)updateTableView{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark HotelListSegmentDelegate
- (void)SearchHotelSortType:(NSString *)sortType sort:(BOOL)sort{
    
    DLog(@"sortType %@",sortType);
    
    currentPage = 1;
    
    self.sortType = sortType;
    
    if (sort) {
        self.sort = @"0";
    }
    else{
        self.sort = @"1";
    }
    
    //    [self.hotelListHttpRequest searchHotelHttpRequest:[self packagePostDataDic]];
    [self displayOverFlowActivityView];
    [self.searchHotelService beginSearchHotelHttpRequest:self.queryHotelDto];
}
#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self hasMore]) {
        
        return [self.hotelList count] + 1;
    }
    return [self.hotelList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && indexPath.row == [self.hotelList count]) {
        
        return 46;
    }
    
    return 88;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self hasMore] && indexPath.row == [self.hotelList count]) {
        static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
		
		UITableViewMoreCell *moreCell = (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
		
		if (moreCell == nil) {
			moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchMoreIdentifier];            
		}
        
        moreCell.title = L(@"Get More...");
        
        [moreCell setAnimating:NO];
        
        UIView *view = [[UIView alloc] init];
        view.frame = moreCell.bounds;
//        view.backgroundColor = RGBCOLOR(250, 250, 250);
        view.backgroundColor=[UIColor whiteColor];
        moreCell.backgroundView = view;
        
        return moreCell;
    }

    
    static NSString *hotelListIdentifier = @"hotelListIdentifier";
    
    HotelListCell *cell = (HotelListCell *)[tableView dequeueReusableCellWithIdentifier:hotelListIdentifier];
    
    if (cell == nil) {
        
        cell = [[HotelListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:hotelListIdentifier];
   
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView *view = [[UIView alloc] init];
        view.frame = cell.bounds;
        view.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = view;
        
    }

    HotelListDTO *dto = [self.hotelList objectAtIndex:indexPath.row];
    
    [cell setItem:dto];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && indexPath.row == [self.hotelList count]) {

        [self loadMoreData];

        return;
    }
    HotelListDTO *dto =  [self.hotelList objectAtIndex:indexPath.row];    
    
    HotelDataSourceDTO *detailDataSource = [[HotelDataSourceDTO alloc] init];
    detailDataSource.hotelId =  dto.hotelId;
    detailDataSource.productImg = dto.hotelImg;
    detailDataSource.hotelName = dto.hotelName;
    detailDataSource.starGrade = dto.snstar;
    
    detailDataSource.cityName = self.dataSource.cityName;
    detailDataSource.startDate = self.dataSource.startDate;
    detailDataSource.endDate = self.dataSource.endDate;
    detailDataSource.priceArea = self.dataSource.priceArea;
    detailDataSource.hotelAroundId = self.dataSource.hotelAroundId;
    detailDataSource.sort = self.dataSource.sort;
    detailDataSource.sortType = self.dataSource.sortType;
    detailDataSource.ratePlanId = self.dataSource.ratePlanId;
    detailDataSource.roomTypeId = self.dataSource.roomTypeId;
    detailDataSource.dateTime = self.dataSource.dateTime;
    detailDataSource.totalPrice = self.dataSource.totalPrice;
    detailDataSource.roomTypeName = self.dataSource.roomTypeName;
    
    HotelDetailViewControlller *next = [[HotelDetailViewControlller alloc] init];
    next.postDto = detailDataSource;
    [self.navigationController pushViewController:next animated:YES];
    TT_RELEASE_SAFELY(detailDataSource);

}


#pragma mark -
#pragma mark Scroll View Delegate 即加载更多

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
    /*判是否加载更多*/
    CGSize contentOffset = [self.tableView contentSize];
    
    CGRect bounds = [self.tableView bounds];
    
    
    if (scrollView.contentOffset.y + bounds.size.height >= contentOffset.height && contentOffset.height>=(self.view.frame.size.height-46)) {
        
        if([self hasMore]){
            
            [self loadMoreData];
        }
    }
    
}


#pragma mark -
#pragma mark 加载更多相关

- (BOOL)hasMore
{
    return !isLastPage;
}

//- (void)refreshData
//{
//    isLoadMore = NO;
//    
//    currentPage = 1;
//    
//    self.sort = @"0";
//    self.sortType = @"0";
//
//    [self.hotelListHttpRequest searchHotelHttpRequest:[self packagePostDataDic]];
//
//}

- (void)loadMoreData
{
    isLoadMore = YES;
    
    currentPage ++;
    
    [self startMoreCellAnimation:YES];
    
//    [self.hotelListHttpRequest searchHotelHttpRequest:[self packagePostDataDic]];
    [self displayOverFlowActivityView];
    [self.searchHotelService beginSearchHotelHttpRequest:self.queryHotelDto];    
}

- (void)startMoreCellAnimation:(BOOL)animating
{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.hotelList count]+1 inSection:0] ;		
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[UITableViewMoreCell class]]) {
		
		UITableViewMoreCell *_cell = (UITableViewMoreCell *)cell;
        
		[_cell setAnimating: animating];
	}
	
}

//- (NSString *)calculateLeaveTime:(NSString *)arriveTime date:(NSString *)date{
//    
//    NSDateFormatter* formater = [[[NSDateFormatter alloc] init] autorelease];
//    [formater setDateFormat:@"yyyy-MM-dd"];
//    
//    NSDate *arriveDate = [formater dateFromString:arriveTime]; 
//    
//    NSDate *leaveDate = [arriveDate dateByAddingTimeInterval:[date intValue]*24*3600];  
//
//    NSString *leaveTime = [formater stringFromDate:leaveDate];
//
//    return leaveTime;
//}


@end
