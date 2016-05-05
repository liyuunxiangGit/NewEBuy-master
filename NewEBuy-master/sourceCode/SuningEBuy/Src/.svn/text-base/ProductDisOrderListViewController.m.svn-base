//
//  ProductDisOrderViewController.m
//  SuningEBuy
//
//  Created by caowei on 12-2-17.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ProductDisOrderListViewController.h"
#import "ProductDetailViewController.h"


@interface ProductDisOrderListViewController(){
    
    
}



@end

/**********************************************************/
@implementation ProductDisOrderListViewController

@synthesize dataProductBasic = _dataProductBasic;

@synthesize orderList = _orderList;

@synthesize selectDisOrderDTO = _selectDisOrderDTO;

@synthesize service=_service;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = L(@"Display Order");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];

    }
    return self;
}

- (ProductDisorderListService *)service
{
    if (!_service) {
        _service = [[ProductDisorderListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderList);
    TT_RELEASE_SAFELY(_dataProductBasic);
    TT_RELEASE_SAFELY(orderTableView_);
    TT_RELEASE_SAFELY(_selectDisOrderDTO);
    SERVICE_RELEASE_SAFELY(_service);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle


- (void)loadView
{
    [super loadView];
    
	UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = contentView.bounds.size.height - 92 ;
	
	self.tableView.frame = frame; 
    
	[self.view addSubview:self.tableView];
    
    [self.tableView addSubview: (UIView *)self.refreshHeaderView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isLoadingOK) {
        
        [self refreshData];
    }
    
}

- (UITableView *)tableView
{
    if(!orderTableView_){
		
		orderTableView_ = [[UITableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStylePlain];    		
		
		[orderTableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[orderTableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		orderTableView_.scrollEnabled = YES;
		
		orderTableView_.userInteractionEnabled = YES;
		
		orderTableView_.delegate =self;
		
		orderTableView_.dataSource =self;
		
		orderTableView_.backgroundColor =[UIColor clearColor];		
	}
	return orderTableView_;
}

#pragma mark-
#pragma mark tableview delegate & datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    if([self hasMore] && self.totalCount == indexPath.row){
        
        return  50;
    }
    
    return [ProductDisOrderCell height:[self.orderList objectAtIndex:indexPath.row]];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore])
    {
        return self.totalCount+1;
    }
    
    return self.totalCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self hasMore] && indexPath.row == self.totalCount)
    {
        static NSString *loadMoreDisOrderIdentifier = @"loadMoreDisOrderIdentifier";
		
		LoadMoreDisOrderCell *moreCell = (LoadMoreDisOrderCell *)[tableView dequeueReusableCellWithIdentifier:loadMoreDisOrderIdentifier];
		
		if (moreCell == nil) {
            
			moreCell = [[LoadMoreDisOrderCell alloc] initWithReuseIdentifier:loadMoreDisOrderIdentifier];
            
		}
        
        moreCell.title = L(@"Get More...");
        
        [moreCell setAnimating:NO];
        
        return moreCell;
    }
    
    static NSString *disOrderCellIdentifier = @"disOrderCellIdentifier";
    
    ProductDisOrderCell *cell = (ProductDisOrderCell *)[tableView dequeueReusableCellWithIdentifier:disOrderCellIdentifier];
    
    if (nil == cell) 
    { 
        cell = [[ProductDisOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:disOrderCellIdentifier];        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DisProductDetailsDTO *dto = [self.orderList objectAtIndex:indexPath.row];
    
    [cell setItem:dto];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row % 2 == 0)
//    {
//        cell.backgroundColor = RGBCOLOR(234, 244, 255);
//    }
//    else
//    {
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//    //如果有加载更多，则颜色为透明（为了能看到转动的动画）
//    if (indexPath.row == [self.orderList count]) {
//        
//        cell.backgroundColor = [UIColor clearColor];
//        
//    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = [indexPath row];
    
    if([self hasMore] && self.totalCount == row)
    {
		
        [self loadMoreData];
        
        return ;
	}
    
    
    self.selectDisOrderDTO = [self.orderList objectAtIndex:indexPath.row];
    
    
    ProductDisOrderDetailsViewController *productDisOrderDetailsViewController = [[ProductDisOrderDetailsViewController alloc] initWithDTO:_selectDisOrderDTO];
    
    productDisOrderDetailsViewController.dataProductBasic = _dataProductBasic;
    
    [self.navigationController pushViewController:productDisOrderDetailsViewController animated:YES];
    
    TT_RELEASE_SAFELY(productDisOrderDetailsViewController);
    
    return ;
    
}

//下拉刷新
- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self displayOverFlowActivityView];
    
    [self.service sendDisorderListHttpRequest:self.dataProductBasic.productId
                                  currentPage:self.currentPage];
}

// 加载更多
- (void)loadMoreData
{
    
    [super loadMoreData];
    
    [self displayOverFlowActivityView];
    
    [self.service sendDisorderListHttpRequest:self.dataProductBasic.productId
                                  currentPage:self.currentPage];
}


- (void)backToProductDetail:(NSString *)message{
    
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error") message:L(message) delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
    alert.tag = 226;
    [alert show];
    
    
}



#pragma mark - AlertMessageViewDelegate
-(void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 226) {
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}

#pragma -
#pragma mark ProductDisorderListDelegate

- (void)ProductDisorderListHttpRequestCompleteWithResult:(BOOL)isSuccess
                                                errorMsg:(NSString *)errorMsg
                                                pageInfo:(const SNPageInfo *)pageInfo
                                            disorderList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if (isSuccess)
    {
        isLoadingOK = YES;
        
        if (self.isFromHead) {
            self.orderList = [NSMutableArray arrayWithArray:list];
        }else{
            if (!_orderList) {
                self.orderList = [NSMutableArray arrayWithArray:list];
            }else{
                [self.orderList addObjectsFromArray:list];
            }
        }
        
        self.currentPage = pageInfo->currentPage;
        self.totalPage = pageInfo->totalPage;
        self.totalCount = [self.orderList count];
        
        if (self.currentPage < self.totalPage) {
            self.isLastPage = NO;
            self.currentPage++;
        }else{
            self.isLastPage = YES;
        }
        
        [self.tableView reloadData];
        
        if (self.totalCount == 0)
        {
            [self backToProductDetail:L(@"Product_NoDisOrderThisProduct")];
        }
    }
    else
    {
        [self presentSheet:errorMsg?errorMsg:L(@"Fail")];

    }
}

@end