//
//  PageRefreshTableViewController.m
//  SuningEBuy
//
//  Created by zhaojw on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//




#import "PageRefreshTableViewController.h"

@implementation PageRefreshTableViewController

@synthesize  currentPage;

@synthesize  totalPage;

@synthesize  totalCount;

@synthesize  isLastPage;


@synthesize  reloading = _reloading;

@synthesize  isFromHead = _isFromHead;

@synthesize  isLoading = _isLoading;


@synthesize  refreshHeaderView = _refreshHeaderView;



- (id)init
{
	
    self = [super init];
	
    if (self) {
        
		self.currentPage = 0;
        
        self.totalPage   = 0;
        
        self.isLastPage  = YES;
		
    }
    return self;
}

- (void)dealloc {
    
	TT_RELEASE_SAFELY(_refreshHeaderView);
	
	
}

- (EGORefreshTableHeaderView*)refreshHeaderView
{
    if(!_refreshHeaderView){
        
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320, self.tableView.bounds.size.height)];
		
		_refreshHeaderView.backgroundColor = [UIColor clearColor];
		
		//[self.tableView addSubview:_refreshHeaderView];
		
		self.tableView.showsVerticalScrollIndicator = YES;
		
		
    }
    
    return _refreshHeaderView;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //如果是第一次滑动，先获取initInset
    if (self.iOS7FullScreenLayout && !_isInsetGeted && _tableView)
    {
        _initScrollViewInset = _tableView.contentInset;
        _isInsetGeted = YES;
    }
}

- (CGFloat)getOffsetY
{
    return self.tableView.contentOffset.y+_initScrollViewInset.top;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
	if (scrollView.isDragging && _refreshHeaderView) {
		if (_refreshHeaderView.state == EGOOPullRefreshPulling && self.getOffsetY > -60.0f && self.getOffsetY < 0.0f && !_reloading) {
			[_refreshHeaderView setState:EGOOPullRefreshNormal];
		}
        else if (_refreshHeaderView.state == EGOOPullRefreshNormal && self.getOffsetY > -60.0f && self.getOffsetY < 0.0f && !_reloading) {
            [_refreshHeaderView setBegin];
        }
        else if (_refreshHeaderView && _refreshHeaderView.state == EGOOPullRefreshNormal && self.getOffsetY < -60.0f && !_reloading) {
			[_refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
	
	
	//[(TSwipeableTableView*)self.tableView hideVisibleBackView:YES];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    /*判是否下拉刷新*/
    
    if (_refreshHeaderView && self.getOffsetY <= - 65.0f && !_reloading && !_isLoading) {
		
        [self startRefreshLoading];
	}
    
    /*判是否加载更多*/
    float contentHeight = scrollView.contentSize.height;
    float tableViewHeight = scrollView.bounds.size.height;
    float originY = MAX(contentHeight, tableViewHeight);
    CGFloat showHeight = scrollView.contentOffset.y + scrollView.size.height - originY - _initScrollViewInset.bottom;

    if (showHeight > 0 && [self hasMore])
    {
        [self loadMoreData];
    }
    
}





- (void)startMoreAnimation:(BOOL)animating {
	
    
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:totalCount inSection:0] ;
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[UITableViewMoreCell class]]) {
		
		UITableViewMoreCell *_cell = (UITableViewMoreCell *)cell;
		
		_cell.animating = animating;
		
	}
	
}

- (void)startRefreshLoading{
	
	_reloading = YES;
	
	[self reloadTableViewDataSource];
	
	[_refreshHeaderView setState:EGOOPullRefreshLoading];
    
    
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration:0.2];
	
	self.tableView.contentInset = UIEdgeInsetsMake(_initScrollViewInset.top+60.0f, _initScrollViewInset.left, _initScrollViewInset.bottom, _initScrollViewInset.right);
	
	[UIView commitAnimations];
	
//    [_refreshHeaderView setBegin];  //  should check if data reload was successful

}

- (void)dataSourceDidFinishLoadingNewData{
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[self.tableView setContentInset:_initScrollViewInset];
	[UIView commitAnimations];
	
	[_refreshHeaderView setState:EGOOPullRefreshNormal];
	[_refreshHeaderView setCurrentDate];  //  should check if data reload was successful
}


- (void)reloadTableViewDataSource{
	
	_isFromHead = YES ;
	
	[self refreshData];
	
}

- (BOOL)hasMore{
    
    return !self.isLastPage;
}


/*子类实现*/
- (void)refreshData{
    
    self.isFromHead = YES;
    
    self.isLoading = YES;
}

/*子类实现*/
- (void)refreshDataComplete{
    
    self.isLoading = NO;
    
    [self dataSourceDidFinishLoadingNewData];
}
/*子类实现*/
- (void)loadMoreData{
    
    self.isFromHead = NO;
    
    self.isLoading = YES;
    
}
/*子类实现*/
- (void)loadMoreDataComplete{
    
    self.isLoading = NO;
    [self startMoreAnimation:NO];
    
}

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	[self dataSourceDidFinishLoadingNewData];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
