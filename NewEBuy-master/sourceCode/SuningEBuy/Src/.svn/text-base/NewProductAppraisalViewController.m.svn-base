//
//  NewProductAppraisalViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewProductAppraisalViewController.h"
#import "UITableViewCell+BgView.h"

@interface NewProductAppraisalViewController ()

@end

@implementation NewProductAppraisalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_evalutionService);
}

- (id)init
{
    self = [super init];
    if (self) {

        self.currentPage = 1;
        self.isLastPage = YES;
    }
    return self;
}

- (void)loadView
{
    CGFloat height = [[UIScreen mainScreen] bounds].size.height-20-44-36;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 36, 320, height)];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.bounds;
	
//	frame.origin.x = 0;
//	
//	frame.origin.y = 0;
//	
//	frame.size.height = contentView.bounds.size.height - 120;
	
	self.groupTableView.frame = frame;
    self.groupTableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);

    self.tableView = self.groupTableView;
    [self.groupTableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.groupTableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isListLoaded) {
        [self refreshData];
    }
}

- (id)initWithProductBasicDTO:(DataProductBasic *)productBasc
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"Product Appraisal");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail_userEvaluate"),self.title];
        
        self.productBasic = productBasc;
                
        self.currentPage = 1;
        
    }
    return self;
}

- (DataProductBasic *)productBasic
{
    if (!_productBasic) {
        _productBasic = [[DataProductBasic alloc] init];
    }
    return _productBasic;
}

- (NSMutableArray *)productReviewList
{
    if (!_productReviewList)
    {
        _productReviewList = [[NSMutableArray alloc] init];
    }
    return _productReviewList;
}

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

-(void)sendHttpRequest{
        
    NSArray *list = [self.productBasic colorVersionMap];
    NSString *string = self.productBasic.productCode;
    for (DataProductBasic *basic in list) {
        if (IsStrEmpty(string)) {
            string = basic.productCode;
        }else{
            string = [NSString stringWithFormat:@"%@_%@",string,basic.productCode];
        }
    }
    
    [self.evalutionService beginProductDetailEvaluationHttp:string CurrentPage:self.currentPage ReviewType:0];
}

- (void)evaluationProductDetailCompletedWithService:(NewEvalutionService *)service isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorMsg list:(NSArray *)array{
    
    
    //刷新下拉完成
    if (self.isFromHead)
    {
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    
    self.groupTableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);

    if(isSuccess)
    {
        isListLoaded = YES;

        if (self.isFromHead)
        {
            [self.productReviewList removeAllObjects];
            [self.productReviewList addObjectsFromArray:array];
        }
        else
        {
            [self.productReviewList addObjectsFromArray:array];
        }
        
        if ([_delegate respondsToSelector:@selector(backRecordsDelegate:)]) {
            [_delegate backRecordsDelegate:[NSString stringWithFormat:@"%i",service.totalNum]];
        }
        
        if (self.currentPage < service.totalPage)
        {
            self.isLastPage = NO;
            
            self.currentPage++;
        }
        else
        {
            self.isLastPage = YES;
        }
        
    }
    else{
        isListLoaded = NO;
    }
    [self.groupTableView reloadData];
}

#pragma mark -
#pragma mark tableview delegate/datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore])
    {
        return [self.productReviewList count] + 1;
    }
    return [self.productReviewList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.productReviewList count]) {
        return  48;
    }
    else
    {
        NewProductAppraisalDTO *dto = [self.productReviewList objectAtIndex:indexPath.row];
        
        return [NewProductAppraisalCell height:dto];
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.productReviewList count])
    {
        static NSString *MoreResultIdentify = @"MoreResultIdentify";
		
		UITableViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
		
		if (cell == nil)
        {
			cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            
            [cell setCoolBgViewWithCellPosition:CellPositionBottom];

			cell.title = L(@"Get More...");
            
            cell.animating = NO;
            
			return cell;
		}
        
        cell.title = L(@"Get More...");
        
		cell.animating = NO;
		
		return cell;
    }
    
    static NSString *appraisalIdentify=@"appraisalIdentify";

    NewProductAppraisalCell *cell=[tableView dequeueReusableCellWithIdentifier:appraisalIdentify];
    
    if (cell == nil) {
        cell = [[NewProductAppraisalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appraisalIdentify];
        
        cell.backgroundColor = [UIColor clearColor];
    }


    NewProductAppraisalDTO *dto = [self.productReviewList objectAtIndex:indexPath.row];
    
    if ([self hasMore]) {
        [cell setCoolBgViewWithCellPosition:CellPositionMake(self.productReviewList.count + 1, indexPath.row)];
    }else{
        [cell setCoolBgViewWithCellPosition:CellPositionMake(self.productReviewList.count, indexPath.row)];
    }
    [cell setItem:dto];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self hasMore] && [self.productReviewList count] == indexPath.row){
        
        [self loadMoreData];
    }
}

#pragma mark -
#pragma mark 下拉刷新和加载更多

- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self sendHttpRequest];
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    [self startMoreAnimation:YES];
    
    [self sendHttpRequest];
}
@end
