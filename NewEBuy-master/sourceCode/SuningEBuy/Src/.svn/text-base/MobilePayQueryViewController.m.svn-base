//
//  MobilePayQueryViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MobilePayQueryViewController.h"
#import "MobileQueryDTO.h"
#import "QueryListItemCell.h"
#import "AppDelegate.h"


@implementation MobilePayQueryViewController
@synthesize service = _service;
@synthesize orderList = _orderList;

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_orderList);
    TT_RELEASE_SAFELY(_alertImageV);
    TT_RELEASE_SAFELY(_alertLbl);

}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"Recharge query");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_mobileCharge_mobileChargeHistory"),self.title];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.tableView.frame = [self setViewFrame:self.hasNav WithTab:YES];

    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshHeaderView];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    self.alertImageV.hidden =YES;
    self.alertLbl.hidden =YES;
    self.tableView.hidden =YES;
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.bottomView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    if (!isOrderLoaded)
    {
        [self refreshData];
    }
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
        _alertLbl.text =L(@"VPHaveNoTelephoneBillPayList");
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
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoMobileIcon.png"];
        
        _alertImageV.frame = CGRectMake(116.5, self.view.frame.size.height/2-76-46, 77, 76);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];
        
    }
    
    return _alertImageV;
}


- (void)requestMobileOrderComplete:(BOOL)isSuccess
                          errorMsg:(NSString *)errorMsg
                         orderList:(NSArray *)list
                              page:(SNPageInfo)pageInfo
{
    [self removeOverFlowActivityView];
    
    if (self.isFromHead)
    {
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    
    if (isSuccess)
    {
        
        if (self.isFromHead || !_orderList)
        {
            self.orderList = [NSMutableArray arrayWithArray:list];
        }
        else
        {
            [self.orderList addObjectsFromArray:list];
        }
        
        self.currentPage = pageInfo.currentPage;
        self.totalPage = pageInfo.totalPage;
        self.totalCount = [self.orderList count];
        
        if (self.currentPage < self.totalPage)
        {
            self.isLastPage = NO;
            self.currentPage++;
        }
        else
        {
            self.isLastPage = YES;
        }
        
        if (self.totalCount <= 0)
        {
//            [self presentSheet:@"您还没有充值记录"];
            
            self.alertImageV.hidden =NO;
            self.alertLbl.hidden =NO;
            
            self.tableView.hidden =YES;
        }
        else
        {
            self.alertImageV.hidden =YES;
            self.alertLbl.hidden =YES;
            
            self.tableView.hidden =NO;
            
            [self.tableView reloadData];
        }
    
    }
    else
    {
        [self presentSheet:errorMsg];
        
        self.alertImageV.hidden =NO;
        self.alertLbl.hidden =NO;
        
        self.tableView.hidden =YES;
    }
}

- (void)refreshData{
    
    [super refreshData];
    
    self.currentPage = 1;
    self.isLastPage = YES;
        
    [self displayOverFlowActivityView];

    [self.service requestMobileOrderWithPage:self.currentPage];
}


- (void)loadMoreData{
    
    [super loadMoreData];
    
    [self startMoreAnimation:YES];
    
    [self displayOverFlowActivityView];

    [self.service requestMobileOrderWithPage:self.currentPage];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self hasMore]) {
        return [self.orderList count]+1;
    }
    return [self.orderList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.orderList.count == indexPath.section)
    {
        return 40;
    }
    else if (indexPath.section <self.orderList.count)
        return [QueryListItemCell height:nil];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.orderList.count && [self hasMore]) {
        static NSString *MobileQueryMoreIdentifier = @"MobileQueryMoreIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MobileQueryMoreIdentifier];
		
		if (cell == nil) {
			
			UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MobileQueryMoreIdentifier];
			cell.backgroundColor = [UIColor cellBackViewColor];
			cell.title = @"Get More...";
            
            cell.animating = NO;
            return cell;
        }
        cell.title = @"Get More...";
        
        cell.animating = NO;

        return cell;
    }
    
    static NSString *MobileQueryCellIdentifier = @"MobileQueryCellIdentifier";
    
    QueryListItemCell *cell = (QueryListItemCell *)[tableView dequeueReusableCellWithIdentifier:MobileQueryCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[QueryListItemCell alloc] initWithReuseIdentifier:MobileQueryCellIdentifier];
    
        if (IOS7_OR_LATER) {
            cell.backgroundColor =[UIColor cellBackViewColor];
        }
        else
        {
            UIView *back = [UIView new];
            back.backgroundColor =[UIColor cellBackViewColor];
            cell.backgroundView = back;
        }
    }
    
    MobileQueryDTO *dto = [self.orderList objectAtIndex:indexPath.section];
    
    cell.itemDTO = dto;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    view.backgroundColor =[UIColor clearColor];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSInteger row = [indexPath section];
	
    if([self hasMore] && self.orderList.count == row){
		
		if(self.isLoading){
			
			return;
			
		}
		
		[self loadMoreData];
		
		return;
		
	}
    
}


- (MobileQueryService *)service
{
    if (!_service) {
        _service = [[MobileQueryService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

@end
