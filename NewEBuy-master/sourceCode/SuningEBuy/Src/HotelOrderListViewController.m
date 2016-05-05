//
//  HotelOrderListViewController.m
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderListViewController.h"
#import "HotelOrderListDto.h"
#import "HotelOrderListBodyCell.h"
#import "HotelOrderListFootCell.h"
#import "HotelOrderListHeadCell.h"



#import "HotelOrderDetailDTO.h"
#import "HotelOrderDetailViewController.h"

#define kMaxRequstItme          @"20"
@interface HotelOrderListViewController ()

@end

@implementation HotelOrderListViewController
@synthesize itemListArr = _itemListArr;
@synthesize isFromAllOrderCenter;

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.title = L(@"hotelOrderCentr");
        
        self.pageTitle = L(@"virtual_business_hotelOrderCenter");
        
        isLoaderOK = NO;
        
        _itemListArr = [[NSMutableArray alloc] init];
        
        
        isLoaderOK = NO;
    }
    
    return self;
}







- (void)dealloc
{
    TT_RELEASE_SAFELY(_itemListArr);
    
    
    TT_RELEASE_SAFELY(_alertLbl);
    TT_RELEASE_SAFELY(_alertImageV);
    
}

- (void)HttpRelease
{
    DLog(@"Http Release \n");
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
}

#pragma mark -
#pragma mark View lifecycle

//- (UITableView *)tableView
//{
//    if(!tableView_){
//		
//        tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
//                                                  style:UITableViewStyleGrouped];
//		
//		
//		[tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//		
//		[tableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
//		
//		tableView_.scrollEnabled = YES;
//		
//		tableView_.userInteractionEnabled = YES;
//		
//		tableView_.delegate =self;
//		
//		tableView_.dataSource =self;
//		
//		tableView_.backgroundColor =[UIColor clearColor];
//		
//        tableView_.backgroundView = nil;
//	}
//	
//	return tableView_;
//}


- (void)loadView
{
    [super loadView];
    
    CGRect frame=[self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.groupTableView.frame =frame;
    if (IOS7_OR_LATER) {
        self.groupTableView.frame =frame;
    }else{
        self.groupTableView.frame =frame;
        self.groupTableView.top=frame.origin.y-20;
        self.groupTableView.height=frame.size.height+20;
    }
    
    [self.groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.groupTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    [self.view addSubview:self.groupTableView];
    
    [self.groupTableView addSubview:self.refreshHeaderView];
    self.tableView=self.groupTableView;//pageRefresh只对self.tableView响应
    
    
    self.currentPage = 1;
    self.hasSuspendButton=1;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isLoaderOK== NO) {
        [self sendListHttpRequest];
    }
}

#pragma mark -
#pragma mark Http Request

- (void)sendListHttpRequest
{
    [self displayOverFlowActivityView];
    
    self.groupTableView.userInteractionEnabled = NO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSString *userId = [[[UserCenter defaultCenter] userInfoDTO] userId];
    
    [postDataDic setObject:(userId == nil ? @"" : userId)
                    forKey:@"memberId"];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d", self.currentPage] forKey:@"currentPage"];
    
    [postDataDic setObject:kMaxRequstItme forKey:@"pageSize"];
    
    [postDataDic setObject:@"" forKey:@"orderStatusCriteria"];
    
    [postDataDic setObject:@"1" forKey:@"howLong"];
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostHotelOrderForHttp,KHotelOrderList];
    
    sendCommendASIHTTPRequest = [Http sendHttpRequest:@"get history recharge List"
                                                  URL:url
                                           UrlParaDic:postDataDic
                                             Delegate:self
                                       SucessCallback:@selector(requestListOk:)
                                         FailCallback:@selector(requestListFail:)];
    
    
    TT_RELEASE_SAFELY(postDataDic);
    
    if (!sendCommendASIHTTPRequest) {
        
        [self removeOverFlowActivityView];
        
        self.groupTableView.userInteractionEnabled = YES;
        
        [self refreshDataComplete];
        
        return;
    }
    
}

- (void)requestListOk:(ASIFormDataRequest *)request
{
    NSDictionary *items = request.jasonItems;
	
	DLog(@"requestMobilePayHistory from server  NSUrlString=%@\n",[items description]);
    
    [self removeOverFlowActivityView];
    
    isLoaderOK = YES;
    
    self.groupTableView.userInteractionEnabled = YES;
    
    [self refreshDataComplete];
    
    if (!items) {
        [self presentSheet:kHttpResponseJSONValueFailError];
    }else{
        [self performSelectorInBackground:@selector(parseHttpRequestList:) withObject:items];
        
    }
    
}

- (void)requestListFail:(ASIFormDataRequest *)request
{
    [self removeOverFlowActivityView];
    
    isLoaderOK = NO;
    
    [self refreshDataComplete];
    
    self.groupTableView.userInteractionEnabled = YES;
    
    [self presentCustomDlg:L(@"Please check your network")];
    
}

- (void)showInfo:(NSString *)infomation
{
    if (infomation == nil || [infomation isEqualToString:@""])
    {
        [self presentSheet:@"error" posY:80];
        return;
    }
    
    self.alertLbl.text = [NSString stringWithFormat:@"%@",infomation];
    self.alertImageV.hidden = NO;
    self.alertLbl.hidden = NO;
//    [self presentSheet:infomation posY:80];
}

- (void)refreshTableView
{
    [self.groupTableView reloadData];
}

- (UILabel*)alertLbl
{
    if(!_alertLbl)
    {
        _alertLbl = [[UILabel alloc] init];
        _alertLbl.font = [UIFont systemFontOfSize:17];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.frame = CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 30);
        _alertLbl.textAlignment = UITextAlignmentCenter;
        _alertLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _alertLbl.hidden = YES;
        [self.view addSubview:_alertLbl];
    }
    return _alertLbl;
}

- (UIImageView*)alertImageV
{
    if(!_alertImageV)
    {
        _alertImageV = [[UIImageView alloc] init];
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoOrder.png"];
        
        _alertImageV.frame = CGRectMake(116.5, 50, 77, 76);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];
        
    }
    
    return _alertImageV;
}

- (void)parseHttpRequestList:(NSDictionary *)items
{
    if (IsNilOrNull(items))
    {
        return;
    }
    
    NSMutableArray *array = [items objectForKey:@"orderItems"];
    
    DLog(@"accountInfo is : %@", array);
    self.alertLbl.hidden = YES;
    self.alertImageV.hidden = YES;
    if (array == nil || [array count] == 0)
    {
        NSString *infomation = L(@"NotHasCenterList");
        
        [self performSelectorOnMainThread:@selector(showInfo:) withObject:infomation waitUntilDone:YES];
        
        return;
        
    }
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    //    NSInteger countItems = [array count];
    
    //    NSInteger limitCount = (countItems > kLimitMaxItme)?kLimitMaxItme:countItems;
    //
    //    for (NSInteger indexg = 0; indexg <limitCount; indexg++) {
    //
    //        NSDictionary *dic = [array objectAtIndex:indexg];
    //
    //        BusinessOrderCenterListDTO *tempDto = [[BusinessOrderCenterListDTO alloc] init];
    //
    //        [tempDto encodeFromDictionary:dic];
    //
    //        [resultList addObject:tempDto];
    //
    //        TT_RELEASE_SAFELY(tempDto);
    //    }
    
    for (NSDictionary *dic in array)
    {
        HotelOrderListDto *tempDto = [[HotelOrderListDto alloc] init];
        
        [tempDto encodeFromDictionary:dic];
        
        [resultList addObject:tempDto];
        
        TT_RELEASE_SAFELY(tempDto);
    }
    
    NSInteger count = [resultList count];
    
    if (count == 0) {
        
        self.isLastPage = (self.isFromHead == YES)? NO: YES;
        [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:NO];
        TT_RELEASE_SAFELY(resultList);
        
        return;
    }
    
    if ([resultList count] == 0) {
        
        self.isLastPage = (self.isFromHead == YES)? NO: YES;
        [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:NO];
        TT_RELEASE_SAFELY(resultList);
        
        return;
    }
    
    if(self.isFromHead){
        
        self.isFromHead = NO;
        
        [self.itemListArr removeAllObjects];
        
        self.itemListArr = resultList;
        
    }else
    {
        if(self.itemListArr && [self.itemListArr count] > 0){
            
            [self.itemListArr addObjectsFromArray: resultList];
            
        }
        else{
            
            self.itemListArr = resultList;
        }
        
    }
    
    TT_RELEASE_SAFELY(resultList);
    
    //设置分页
    self.totalCount = [self.itemListArr count];
    
    self.totalPage = [NotNilAndNull([items objectForKey:@"pageCount"])? [items objectForKey:@"pageCount"] : @"0" intValue];
    
    self.currentPage = [NotNilAndNull([items objectForKey:@"currentPage"])? [items objectForKey:@"currentPage"] : @"0" intValue];
    
    if (self.currentPage < self.totalPage)
    {
        self.isLastPage = NO;
        
        self.currentPage++;
    }
    else
    {
        self.isLastPage = YES;
    }
    
    [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self hasMore])
    {
        return [self.itemListArr count] + 1;
    }
    return [self.itemListArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore] && self.totalCount == section)
    {
        return 1;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.totalCount == indexPath.section)
    {
        return 48;
    }
    if (indexPath.row==0) {
        return 40;
    }else if(indexPath.row==2){
        return 50;
    }
    HotelOrderListDto* dto=[self.itemListArr objectAtIndex:indexPath.section];
    return [HotelOrderListBodyCell cellHeightWithDto:dto];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.totalCount == indexPath.section)
    {
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
			
			UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
			
			cell.title = L(@"loadMore");
            
            cell.animating = NO;
			
			return cell;
		}
		
		cell.animating = NO;
		
		return cell;
    }
    
    HotelOrderListDto* dto=[self.itemListArr objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
        static NSString *headCellIdentifier = @"HeadCell";
        
        HotelOrderListHeadCell* cell=[tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
        
        if (cell==nil) {
            cell=(HotelOrderListHeadCell*)[[HotelOrderListHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setHeadCellWithDto:dto];
        return cell;
    }else if(indexPath.row==2){
        static NSString *footCellIdentifier = @"FootCell";
        
        HotelOrderListFootCell* cell=[tableView dequeueReusableCellWithIdentifier:footCellIdentifier];
        
        if (cell==nil) {
            cell=(HotelOrderListFootCell*)[[HotelOrderListFootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:footCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setFootCellWithDto:dto];
        return cell;
    }
    
    static NSString *bodyCellIdentifier = @"BodyCell";
    
    HotelOrderListBodyCell *cell = (HotelOrderListBodyCell *)[tableView dequeueReusableCellWithIdentifier:bodyCellIdentifier];
    
    if(cell == nil){
        
        cell = [[HotelOrderListBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bodyCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    [cell setBodyCellWithDto:dto];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSInteger section = [indexPath section];
	
    if([self hasMore] && self.totalCount == section){
		
		if(self.isLoading){
			
			return;
			
		}
		
		[self loadMoreData];
		
		return;
	}
    if (indexPath.row==0||indexPath.row==2) {
        return;
    }
//    BusinessOrderCenterListDTO *dto = [self.itemListArr objectAtIndex:indexPath.section];
//    
//    BusinessOrderDetailViewController *nextController = [[BusinessOrderDetailViewController alloc] init];
//    nextController.postDto= dto;
    
    HotelOrderListDto* dto=[self.itemListArr objectAtIndex:indexPath.section];
    HotelOrderDetailViewController *nextController = [[HotelOrderDetailViewController alloc] init];
    nextController.postDto=dto;
    nextController.hidesBottomBarWhenPushed=YES;
    
    if (self.isFromAllOrderCenter) {
        [((UIViewController*)self.view.superview.nextResponder).navigationController pushViewController:nextController animated:YES];
    }else{
        [self.navigationController pushViewController:nextController animated:YES];
    }
    
    
    
}

- (void)refreshData{
    [super refreshData];
    
    self.currentPage = 1;
    
    self.isLastPage = YES;
    
    // self.appDelegate.isShowNetworkAlert = YES;
    
    [self sendListHttpRequest];
}


- (void)loadMoreData{
    
    [super loadMoreData];
    
    self.currentPage++;
    [self startMoreAnimation:YES];
    
    [self sendListHttpRequest];
}


@end
