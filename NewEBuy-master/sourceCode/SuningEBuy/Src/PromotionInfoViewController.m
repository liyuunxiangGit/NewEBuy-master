//
//  PromotionInfoViewController.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PromotionInfoViewController.h"
#import "SNWebViewController.h"


#define vHttpRequestInfoPageSize                 @"20"
#define kPromotionInfoLblTag                     10000


@interface PromotionInfoViewController ()


- (void)dismissOverFlowView;

- (UILabel *)createPromotionInfoLbl;

- (void)updateTable;
@end


@implementation PromotionInfoViewController

@synthesize isInfoLoaded = _isInfoLoaded;
@synthesize pageSize = _pageSize;
@synthesize promotionInfoList = _promotionInfoList;
@synthesize promotionInfoService = _promotionInfoService;

- (void)dealloc 
{
    
    TT_RELEASE_SAFELY(_pageSize);
    
	TT_RELEASE_SAFELY(_promotionInfoList);
    
    SERVICE_RELEASE_SAFELY(_promotionInfoService);
	
}

- (void)HttpRelease 
{
	
	DLog(@"promotionInfoASIHTTPRequest release \n");
	
}

- (id)init
{
	
    self = [super init];
	
    if (self) 
    {
        
        self.title = L(@"PromotionInfo");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];

        self.isInfoLoaded = NO;
        self.pageSize = @"1";
        self.currentPage = 1;
        
        _promotionInfoList = [[NSMutableArray alloc] init];
        
	}
	
	return self;
}

- (PromotionInfoService *)promotionInfoService
{
    if (!_promotionInfoService) {
        _promotionInfoService = [[PromotionInfoService alloc] init];
        _promotionInfoService.delegate = self;
    }

    return _promotionInfoService;

}


- (NSMutableArray *)promotionInfoList
{
    if (! _promotionInfoList) {
        _promotionInfoList = [[NSMutableArray alloc] init];
    }
    
    return _promotionInfoList;

}
- (void)loadView 
{
	
	[super loadView];
	
	UIView *contentView = self.view;
	CGRect frame = contentView.frame;
	frame.origin.x = 0;
	frame.origin.y = 0;
	frame.size.height = contentView.bounds.size.height - 92 ;
	
    self.tableView.frame = frame;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:self.refreshHeaderView]; // 下拉刷新视图
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isInfoLoaded = NO;
    self.currentPage = 1;
    self.pageSize = vHttpRequestInfoPageSize;
    //访问页码
    NSString *pageNumber = [NSString stringWithFormat:@"%d",self.currentPage];
    
    // 未加载时，发送资讯请求
    [self.promotionInfoService  beginGetPromotionInfoListWithPageNum:pageNumber PageSize:self.pageSize];

    
}

-(void)viewWillAppear:(BOOL)animated
{
	
	[super viewWillAppear:animated];
	
	if(!_isInfoLoaded)
    {
        
        [self refreshData];
	}
	
}

-(void)getPromotionInfoListWithSuccess:(BOOL)isSuccess 
                              errorMsg:(NSString *)errorMsg 
                     PromotionInfoList:(NSMutableArray *)list 
                             totalPage:(NSInteger)totalPage 
                           currentPage:(NSInteger)currPage
{   
    
    [self dismissOverFlowView];
    
    if (isSuccess) {
        self.isInfoLoaded = YES;

        if (self.isFromHead) {
            TT_RELEASE_SAFELY(_promotionInfoList);
            self.isFromHead=NO;
        }
        NSMutableArray *newList = list;
        NSInteger count = [newList count];
        if (_promotionInfoList && count >0) 
        {
            
            [_promotionInfoList addObjectsFromArray:newList];
        }
        
        else
        {
        
            self.promotionInfoList = newList;
        
        }
        
        self.totalCount = self.promotionInfoList.count;
        
        if (self.currentPage < self.totalPage) {
            self.currentPage ++;
            self.isLastPage = NO;
        }
        
        else
        {
            self.isLastPage = YES;
        
        }
        
        [self updateTable];
    }

    else
    {
        [self presentSheet:errorMsg];
    }
  
}


- (void)updateTable
{
    
    // 刷新当前页面
    if (!self.tableView.superview) 
    {
        [self.view addSubview:self.tableView];
    }
    else
    {
        [self.tableView reloadData];
    }



    

}

- (void)dismissOverFlowView
{
    
    if (![self.pageSize isEqualToString:@"1"]) 
    {
        
        if (self.isLoading)
        {
            [self refreshDataComplete];
        }
        
        [self removeOverFlowActivityView];
        
    }
    
}

- (UILabel *)createPromotionInfoLbl
{
    
    UILabel *_promotionInfoLbl = [[UILabel alloc] init];
    
    _promotionInfoLbl.frame = CGRectMake(10, 0, 260, 54);
    
    _promotionInfoLbl.backgroundColor = [UIColor clearColor];
    
    _promotionInfoLbl.textColor = [UIColor blackColor];
    
    _promotionInfoLbl.textAlignment = UITextAlignmentLeft;
    
    _promotionInfoLbl.font = [UIFont systemFontOfSize:17.0];
    
    _promotionInfoLbl.shadowColor = [UIColor whiteColor];
    
    _promotionInfoLbl.shadowOffset = CGSizeMake(1, 1);
    
    _promotionInfoLbl.tag = kPromotionInfoLblTag;
    
    _promotionInfoLbl.numberOfLines = 1;
    
    _promotionInfoLbl.lineBreakMode = UILineBreakModeTailTruncation;
    
    
    return _promotionInfoLbl;
}

#pragma mark -
#pragma mark Table View Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.totalCount==indexPath.row) {
        return 48;
    }
    
    return 54;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([self hasMore]) {
        return [self.promotionInfoList count]+1;
    }

    return [self.promotionInfoList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if([self hasMore] && self.totalCount == row)
    {
        
		static NSString *bookmarkMoreIdentifier = @"bookmarkMoreIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:bookmarkMoreIdentifier];
		
		if (cell == nil) 
        {
			
			
			UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bookmarkMoreIdentifier];
			
			cell.title = @"Get More...";
            
            cell.animating = NO;
			
			return cell;
		}
		
		cell.animating = NO;
		
		return cell;
		
	}
        static NSString *PromotionInfoIdentifier = @"PromotionInfoIdentifier";
        UITableViewMoreCell *cell = (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:PromotionInfoIdentifier];
        if (cell == nil) {
            cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PromotionInfoIdentifier];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        else
        {
            
            [cell.contentView removeAllSubviews];
        }
        
        PromotionInfoDTO *promotionInfoDTO = (PromotionInfoDTO *)[self.promotionInfoList objectAtIndex:indexPath.row];
        UILabel *promotionInfoLbl = [self createPromotionInfoLbl];
        if (promotionInfoDTO.isRead) {
            promotionInfoLbl.textColor = [UIColor darkGrayColor];
        }
        
        promotionInfoLbl.text = [promotionInfoDTO elementName];
        
        [cell.contentView addSubview:promotionInfoLbl];
    
        return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    UIColor *backgroundColor = (indexPath.row & 1) != 0 ? RGBCOLOR(244, 250, 255) : [UIColor whiteColor];
    
    cell.backgroundColor = backgroundColor;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	NSInteger row = [indexPath row];
    
    if([self hasMore] && self.totalCount == row)
    {
		
		if(self.isLoading)
        {
			return;
			
		}
		
		[self loadMoreData];
		
		return;
		
	}
    
    PromotionInfoDTO *dto = [self.promotionInfoList objectAtIndex:row];
    
    dto.isRead = YES;
    
    [tableView reloadData];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dto.linkUrl]];
    
    SNWebViewController *vc = [[SNWebViewController alloc] initWithRequest:request];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -
#pragma mark Refresh And Load More
- (void)refreshData
{
    
    [super refreshData];
    
    self.currentPage = 1;
    
    NSString *pageNumber = [NSString stringWithFormat:@"%d",self.currentPage];

    [self displayOverFlowActivityView];
    [self.promotionInfoService beginGetPromotionInfoListWithPageNum:pageNumber PageSize:self.pageSize];
}

- (void)loadMoreData
{
    
    [super loadMoreData];
    
    [self startMoreAnimation:YES];
    
    NSString *pageNumber = [NSString stringWithFormat:@"%d",self.currentPage];
    
    [self displayOverFlowActivityView];
    [self.promotionInfoService beginGetPromotionInfoListWithPageNum:pageNumber PageSize:self.pageSize];
}


@end
