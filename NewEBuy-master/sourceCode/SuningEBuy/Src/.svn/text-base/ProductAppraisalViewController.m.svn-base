//
//  ProductAppraisalViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductAppraisalViewController.h"
#import "ProductEvaluateViewController.h"
#import "ProductAppraisalCell.h"
#import "BookAppraisalDTO.h"
#import "UserCenter.h"
#import "BookAppraisalCell.h"

@interface ProductAppraisalViewController()

@property (nonatomic, strong) NSMutableArray *appraisalList;

@property (nonatomic, strong) DataProductBasic *productBasic;

@property (nonatomic, strong) UISegmentedControl *appraisalSegment;

@property (nonatomic,strong) UIView *headerView;


@end

/*******************************************************************/

@implementation ProductAppraisalViewController

@synthesize productAppraisalService=_productAppraisalService;
@synthesize appraisalList = _appraisalList;
@synthesize productBasic = _productBasic;
@synthesize appraisalSegment = _appraisalSegment;
@synthesize type = _type;


- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_productAppraisalService);
    TT_RELEASE_SAFELY(_appraisalList);
    TT_RELEASE_SAFELY(_productBasic);
    
    TT_RELEASE_SAFELY(tableView_);
    TT_RELEASE_SAFELY(_appraisalSegment);
    TT_RELEASE_SAFELY(_headView);
    TT_RELEASE_SAFELY(_type);
    
    TT_RELEASE_SAFELY(_appraseBtnArray);
    
}

- (void)updateTable
{
    [self.tableView reloadData];
}


-(void)initAppraseView{
    
    if (!_appraseBtnArray) {
        
        _appraseBtnArray = [[NSMutableArray alloc] initWithCapacity:3];
        
    }

    if (_headView) {
        
        return;
    }
    NSString *goodevaluate = [NSString stringWithFormat:@"%@(%@)",L(@"Product_GoodComment"),self.productBasic.goodevaluate];
    NSString *midEvaluate = [NSString stringWithFormat:@"%@(%@)",L(@"Product_MiddleComment"),self.productBasic.midEvaluate];
    NSString *badEvaluate = [NSString stringWithFormat:@"%@(%@)",L(@"Product_BadComment"),self.productBasic.badEvaluate];
    //评论的头部的背景
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    _headView.clipsToBounds = YES;
    _headView.backgroundColor = [UIColor colorWithRed:246.0/255 green:242.0/255 blue:229.0/255 alpha:1];
    
    UIButton *goodBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, -3, 107, 33)];
    [goodBtn setTitle:goodevaluate forState:UIControlStateNormal];
    goodBtn.selected = YES;
    [goodBtn addTarget:self action:@selector(appraiseChanged:) forControlEvents:UIControlEventTouchUpInside];
    [goodBtn setBackgroundImage:[UIImage imageNamed:@"apprais_n@2x.png"] forState:UIControlStateNormal];
    [goodBtn setBackgroundImage:[UIImage imageNamed:@"apprais_s@2x.png"] forState:UIControlStateSelected];
    goodBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [goodBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [goodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headView addSubview:goodBtn];
    [_appraseBtnArray addObject:goodBtn];
    
    UIButton *midBtn = [[UIButton alloc] initWithFrame:CGRectMake(107, -3, 107, 33)];
    [midBtn setTitle:midEvaluate forState:UIControlStateNormal];
    [midBtn addTarget:self action:@selector(appraiseChanged:) forControlEvents:UIControlEventTouchUpInside];
    [midBtn setBackgroundImage:[UIImage imageNamed:@"apprais_n@2x.png"] forState:UIControlStateNormal];
    [midBtn setBackgroundImage:[UIImage imageNamed:@"apprais_s@2x.png"] forState:UIControlStateSelected];
    midBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [midBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headView addSubview:midBtn];
    [_appraseBtnArray addObject:midBtn];
    
    
    UIButton *badBtn = [[UIButton alloc] initWithFrame:CGRectMake(214, -3, 107, 33)];
    [badBtn setTitle:badEvaluate forState:UIControlStateNormal];
    [badBtn addTarget:self action:@selector(appraiseChanged:) forControlEvents:UIControlEventTouchUpInside];
    [badBtn setBackgroundImage:[UIImage imageNamed:@"apprais_n@2x.png"] forState:UIControlStateNormal];
    [badBtn setBackgroundImage:[UIImage imageNamed:@"apprais_s@2x.png"] forState:UIControlStateSelected];
    badBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [badBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [badBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headView addSubview:badBtn];
    [_appraseBtnArray addObject:badBtn];
    
    
    

    [self.view addSubview:_headView];
    //return self.headView;
}

-(void)appraiseChanged:(UIButton *)btn{
    
    //当改按钮没有选中时 点击该按钮响应一下操作
    if (!btn.isSelected) {
        
        //该按钮设为选中
        //其他按钮改为 非选中
        for (int i=0;i<[self.appraseBtnArray count];i++) {
            
            UIButton *obj = (UIButton *)[self.appraseBtnArray objectAtIndex:i];
            if (btn != obj) {
                
                obj.selected = NO;
            }
            else{
                
                obj.selected = YES;
                switch (i) {
                    case 0:
                    {
                        DLog(@"UISegmentedControl is 0");
                        self.type = kHttpRequestGoodAppraisal;
                    }
                        break;
                        
                    case 1:
                    {
                        DLog(@"UISegmentedControl is 1");
                        self.type = kHttpRequestMidAppraisal;
                    }
                        break;
                        
                        
                    default:
                    {
                        DLog(@"UISegmentedControl is 2");
                        self.type = kHttpRequestLackAppraisal;
                    }
                        break;
                }
                
                [self.appraisalList removeAllObjects];
                self.totalCount = 0;
                self.isLastPage = YES;
                [self updateTable];
                
                [self refreshData];
            }
        }
        
     //   [self viewChangeWithType:self.selectType];
    }
}



- (UISegmentedControl *)appraisalSegment
{
	
	if (!_appraisalSegment)
    {
        
        NSString *goodevaluate = [NSString stringWithFormat:@"%@%@",L(@"Product_GoodComment"),self.productBasic.goodevaluate];
        NSString *midEvaluate = [NSString stringWithFormat:@"%@%@",L(@"Product_MiddleComment"),self.productBasic.midEvaluate];
        NSString *badEvaluate = [NSString stringWithFormat:@"%@%@",L(@"Product_BadComment"),self.productBasic.badEvaluate];
        NSArray *item = [[NSArray alloc] initWithObjects:goodevaluate,midEvaluate,badEvaluate,nil];
        
        _appraisalSegment = [[UISegmentedControl alloc] initWithItems:item];
        
        _appraisalSegment.selectedSegmentIndex = 0;
        
        _appraisalSegment.multipleTouchEnabled = YES;
        
        _appraisalSegment.segmentedControlStyle = UISegmentedControlStyleBar;
        
        _appraisalSegment.tintColor = RGBCOLOR(30, 196, 236);
        
        [_appraisalSegment addTarget:self action:@selector(segmentedControl2:) forControlEvents:UIControlEventValueChanged];
        
        [_appraisalSegment setFrame:CGRectMake(10, 10, 300, 35)];
        
        TT_RELEASE_SAFELY(item);
        
    }
	
	return _appraisalSegment;
}


- (void)segmentedControl2:(id)sender {
    
    NSInteger index = [(UISegmentedControl*)sender selectedSegmentIndex];
    
    switch (index) {
        case 0:
        {
            DLog(@"UISegmentedControl is 0");
            self.type = kHttpRequestGoodAppraisal;
        }
            break;
            
        case 1:
        {
            DLog(@"UISegmentedControl is 1");
            self.type = kHttpRequestMidAppraisal;
        }
            break;
            
            
        default:
        {
            DLog(@"UISegmentedControl is 2");
            self.type = kHttpRequestLackAppraisal;
        }
            break;
    }
    
    [self.appraisalList removeAllObjects];
    self.totalCount = 0;
    self.isLastPage = YES;
    [self updateTable];
    
    [self refreshData];
}


- (id)initWithProductBasicDTO:(DataProductBasic *)productBasc
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"Product Appraisal");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];

        self.productBasic = productBasc;
        
        self.type = kHttpRequestGoodAppraisal;
        
        self.currentPage = 1;
        
        // 关闭评价功能
        //        UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
        //
        //        self.navigationItem.rightBarButtonItem = addNew;
        //
        //        TT_RELEASE_SAFELY(addNew);
        //[self.productAppraisalService sendValidateHttpRequest:self.productBasic.productCode];
        
    }
    return self;
}

- (ProductAppraisalService *)productAppraisalService
{
    if (!_productAppraisalService) {
        _productAppraisalService = [[ProductAppraisalService alloc] init];
        _productAppraisalService.delegate = self;
    }
    return _productAppraisalService;
}

-(BOOL)isNickNameNilOrNot
{
    NSString *nickName = [UserCenter defaultCenter].userInfoDTO.nickName;
    
    if (NotNilAndNull(nickName) && ![nickName isEqualToString:@""])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (void)editNickNameOK{
    /*
     * author:cuizl
     * date:2012-08-27
     * desprition：关闭用户评价功能
     */
    //   [self addNew];
    
}

- (void)addNew
{
    if (![self isNickNameNilOrNot]) {
        
        EditNicknameViewController *edit = [[EditNicknameViewController alloc] init];
        
        edit.delegate = self;
        
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:edit];
        
        [self presentModalViewController:nav animated:YES];
        
        return;
    }
    DLog("%@", _isEvaluatable);
    
    if ([_isEvaluatable isEqualToString:@"false"] || _isEvaluatable==nil) {
        
        [self presentSheet:L(@"Product_NoBuyOrNoPay") posY:80];
        
        return;
    }
    ProductEvaluateViewController *nextController = [[ProductEvaluateViewController alloc] init];
    
    nextController.dataSource = self.productBasic;
    
    [self.navigationController pushViewController:nextController animated:YES];
    
    TT_RELEASE_SAFELY(nextController);
}


- (UITableView *)tableView
{
    if(!tableView_){
		
		tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
												  style:UITableViewStyleGrouped];
		
		
		[tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[tableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		tableView_.scrollEnabled = YES;
		
		tableView_.userInteractionEnabled = YES;
		
		tableView_.delegate =self;
		
		tableView_.dataSource =self;
		
//		tableView_.backgroundColor =[UIColor clearColor];
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        v.backgroundColor = [UIColor colorWithRed:238.0/255 green:235.0/255 blue:216.0/255 alpha:1];
       tableView_.backgroundView = v;
	}
	
	return tableView_;
}

- (NSMutableArray *)appraisalList
{
    if (!_appraisalList)
    {
        _appraisalList = [[NSMutableArray alloc] init];
    }
    return _appraisalList;
}

#pragma mark -
#pragma mark View lifycycle

- (void)loadView
{
    [super loadView];
    
   // [self initAppraseView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 30;
	
	frame.size.height = contentView.bounds.size.height - 122;
	
	self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:(UIView *)self.refreshHeaderView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initAppraseView];
    
    if (!isListLoaded) {
        [self refreshData];
    }
}
-(void)loadAppraseView{
    
  //  [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 30;
	
	frame.size.height = contentView.bounds.size.height - 122;
	
	self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:(UIView *)self.refreshHeaderView];
    
    if (!isListLoaded) {
        [self refreshData];
    }
}
#pragma mark -
#pragma mark Table View Delegate Methods
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    
//    return 30;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    return [self initAppraseView];
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore])
    {
        return [self.appraisalList count]+1;
    }
    return [self.appraisalList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row == 0) {
//        
//        static NSString *segmentCellIdentifier = @"segmentCellIdentifier";
//		
//		UITableViewCell * segmentCell = [tableView dequeueReusableCellWithIdentifier:segmentCellIdentifier];
//        if (segmentCell == nil) {
//            UITableViewCell * segmentCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:segmentCellIdentifier]autorelease];
//            [segmentCell.contentView addSubview:self.appraisalSegment];
//            return segmentCell;
//        }
//        return segmentCell;
//    }
    if ([self hasMore] && self.totalCount == indexPath.row)
    {
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
			
			UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
			
//            cell.backgroundColor = [UIColor colorWithRed:250.0/255 green:247.0/255 blue:237.0/255 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor cellBackViewColor];
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
			
			return cell;
		}
		
		cell.animating = NO;
		
		return cell;
    }
    
    if (self.productBasic.isABook) {
        
        static NSString *AppraisalCellIdentifier = @"AppraisalCellIdentifier";
        
        BookAppraisalCell *cell = (BookAppraisalCell *)[tableView dequeueReusableCellWithIdentifier:AppraisalCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[BookAppraisalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AppraisalCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor cellBackViewColor];
        }
        
        BookAppraisalDTO *dto = [self.appraisalList objectAtIndex:indexPath.row];
        
        [cell setItem:dto];
        
        return cell;
        
    }
    
    static NSString *AppraisalCellIdentifier = @"AppraisalCellIdentifier";
    
    ProductAppraisalCell *cell = (ProductAppraisalCell *)[tableView dequeueReusableCellWithIdentifier:AppraisalCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ProductAppraisalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AppraisalCellIdentifier];
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor colorWithRed:250.0/255 green:247.0/255 blue:237.0/255 alpha:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor cellBackViewColor];
    }
    
    ProductAppraisalDTO *dto = [self.appraisalList objectAtIndex:indexPath.row];
    
    [cell setItem:dto];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        return 50;
//    }
    
    if([self hasMore] && self.totalCount==indexPath.row)
    {
        return  48;
    }
    
    if (self.productBasic.isABook)
    {
        BookAppraisalDTO *dto = [self.appraisalList objectAtIndex:indexPath.row];
        
        return [BookAppraisalCell height:dto];
    }else{
        
        ProductAppraisalDTO *dto = [self.appraisalList objectAtIndex:indexPath.row];
        
        return [ProductAppraisalCell height:dto];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self hasMore] && self.totalCount == indexPath.row){
        
        [self loadMoreData];
        
        return;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    cell.backgroundColor = RGBCOLOR(247, 247, 247);
}
//无评价信息时提示用户，用户点击确定后返回"商品详情"界面
- (void)BackToProductDetail:(NSString *)message{
    
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

#pragma mark -
#pragma mark Http Request



-(void)sendHttpRequest{
    
    BOOL tag = self.productBasic.isABook;

    NSArray *list = [self.productBasic colorVersionMap];
    NSString *string;
    for (DataProductBasic *basic in list) {
        if (IsStrEmpty(string)) {
            string = basic.productCode;
        }else{
            string = [NSString stringWithFormat:@"%@_%@",string,basic.productCode];
        }
    }
    DLog(@"------------%@",string);
    if (tag)
    {
        [self displayOverFlowActivityView];
        [self.productAppraisalService sendBookAppraisalHttpRequest:self.productBasic.productCode ProductId:self.productBasic.productId currentPage:self.currentPage type:self.type];
        
    }else{
        [self displayOverFlowActivityView];
        [self.productAppraisalService sendProductAppraisalHttpRequest:self.productBasic.productCode ProductId:self.productBasic.productId currentPage:self.currentPage type:self.type];
    }
}


-(void)BookAppraisalHttpRequestCompletedWithService:(ProductAppraisalService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if (isSucess) {
        isListLoaded = YES;
        self.totalPage = service.pageInfo.totalPage;
        self.currentPage = service.pageInfo.currentPage;
        
        if (self.isFromHead) {
            self.appraisalList = service.appraiseList;
        }else{
            [self.appraisalList addObjectsFromArray:service.appraiseList];
        }
        
        self.totalCount=[self.appraisalList count];
        if (self.currentPage < self.totalPage)
        {
            self.isLastPage = NO;
            
            self.currentPage++;
        }
        else
        {
            self.isLastPage = YES;
        }
        
        double resultSetSize =[self.productBasic.goodevaluate intValue]+[self.productBasic.midEvaluate intValue]+[self.productBasic.badEvaluate intValue];
        
        if(resultSetSize==0){
            
            [self BackToProductDetail:@"no appraise"];
        }
        
    }else{
        
    }
    
    [self updateTable];

    
}


-(void)ProductAppraisalHttpRequestCompletedWithService:(ProductAppraisalService *)service
                                              isSucess:(BOOL)isSucess
                                             errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if(isSucess)
    {
        isListLoaded = YES;
        if(service.totalEvaludate<=0){
            [self BackToProductDetail:L(@"Product_NoCommentNow")];
            return;
        }
        if (self.isFromHead)
        {
            self.appraisalList = service.appraiseList;
        }
        else
        {
            [self.appraisalList addObjectsFromArray:service.appraiseList];
        }
        
        self.currentPage=service.pageInfo.currentPage;
        self.totalPage=service.pageInfo.totalPage;
        self.totalCount=[self.appraisalList count];
        if (self.currentPage < self.totalPage)
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
        
    }

    [self updateTable];


}

-(void)ValidateHttpRequestCompletedWithService:(ProductAppraisalService *)service isSuccess:(BOOL)isSuccess
{
    if(isSuccess){
        
        _isEvaluatable=service.isEvaluatable;
        
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
