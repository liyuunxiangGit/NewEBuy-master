//
//  EvaluationListViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EvaluationListViewController.h"
#import "MemberOrderDetailsDTO.h"
#import "EvalutionContentViewController.h"
#import "ProductDisOrderSubmitViewController.h"
#import "ProductDetailViewController.h"

@interface EvaluationListViewController ()
{
    NSInteger           selectSectionIndex;
    NSInteger           selectIndex;
    BOOL                isLoadOK;
    BOOL                isStartLoad;
}
@end

@implementation EvaluationListViewController

@synthesize evalutionList           = _evalutionList;
@synthesize evalutionService        = _evalutionService;
@synthesize displayorderService     = _displayorderService;
@synthesize emptyLabel              = _emptyLabel;

- (void)dealloc
{

    TT_RELEASE_SAFELY(_emptyLabel);
    SERVICE_RELEASE_SAFELY(_evalutionService);
    SERVICE_RELEASE_SAFELY(_displayorderService);
    TT_RELEASE_SAFELY(_evalutionList);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"HEvaluateDisplayOrder");
        self.pageTitle = L(@"member_myEbuy_evaluateAndDisOrder");
        if (!_evalutionList) {
            _evalutionList = [[NSMutableArray alloc] init];
        }
        isStartLoad = NO;
        isLoadOK = NO;
        self.currentPage = 1;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.tableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 92);
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];
}

- (UILabel *)emptyLabel
{
    if (!_emptyLabel)
    {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 120, 200)];
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.text = L(@"HNoGoodsForEvaluateOrDisplay");
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
    }
    return _emptyLabel;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (!isLoadOK) {
        [self displayOverFlowActivityView];
        
        [self.evalutionService getEvalutionListHttp:self.currentPage];
    }    
}


- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

- (void)getEvalutionListCompletedWithResult:(BOOL)isSucced isLastPage:(BOOL)isLastPages errorCode:(NSString *)errorCode List:(NSArray *)array number:(NSString *)evalutionNumber
{
    [self removeOverFlowActivityView];
    
    isStartLoad = YES;
    //刷新下拉完成
    if (self.isFromHead)
    {
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    
    if (isSucced)
    {
        isLoadOK = YES;
        if(isLastPages)
        {
            self.isLastPage = YES;
        }
        else
        {
            self.isLastPage = NO;
        }
        
        if (1 == self.currentPage)
        {
            [self.evalutionList removeAllObjects];
            [self.evalutionList addObjectsFromArray:array];
        }
        else
        {
            [self.evalutionList addObjectsFromArray:array];
        }
//    
//        if (IsArrEmpty(self.evalutionList) || [self.evalutionList count] == 0) {
//            self.tableView.tableFooterView = self.emptyLabel;
//        }else{
//            self.tableView.tableFooterView = nil;
//        }
//
    }else
    {
        isLoadOK = NO;
        [self presentSheet:errorCode];
    }
    
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:self waitUntilDone:NO];
}

- (void)updateTableView
{
    [self.tableView reloadData];
}


- (ProductDetailSubmitService *)displayorderService
{
    if (!_displayorderService) {
        _displayorderService = [[ProductDetailSubmitService alloc] init];
        _displayorderService.delegate = self;
    }
    return _displayorderService;
}



#pragma mark -
#pragma mark tableview delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore])
    {
        return [self.evalutionList count] + 1;
    }
    return [self.evalutionList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(self.evalutionList.count == 0 && isStartLoad)
    {
        return 300;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(self.evalutionList.count == 0 && isStartLoad)
    {
        return self.emptyLabel;
    }else{
        [self.emptyLabel removeFromSuperview];
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.evalutionList count]) {
        return  48;
    }
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.evalutionList count])
    {
        static NSString *MoreResultIdentify = @"MoreResultIdentify";
		
		UITableViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
		
		if (cell == nil)
        {
			cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
			
			return cell;
		}

        cell.title = L(@"Get More...");

		cell.animating = NO;
		
		return cell;
    }
    
    static NSString *evalutionListIdentifier = @"evalutionListIdentifier";
    
    EvalutionListCell *cell = [tableView dequeueReusableCellWithIdentifier:evalutionListIdentifier];
    if (cell == nil)
    {
        cell = [[EvalutionListCell alloc] initWithReuseIdentifier:evalutionListIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    EvalutionDTO *dto  = [self.evalutionList objectAtIndex:indexPath.row];
    
//    cell.merchanStruct = dto;
    
    EvalutionDetailDTO *detailDto = [self.evalutionList objectAtIndex:indexPath.row];
    
    cell.merchanStructDetail = detailDto;
    
    [cell.displayBtn addTarget:self action:@selector(disOrderAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.evalutionBtn addTarget:self action:@selector(evalutionAction:event:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.evalutionList count]) {
        [self loadMoreData];
    }
    else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        DataProductBasic *dataProductBasic = [[DataProductBasic alloc] init];
        EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:indexPath.section];
        
        NSArray *array = evaDto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:indexPath.row];
        
        dataProductBasic.productId = evaDetailDto.catentryId;
        dataProductBasic.productCode = evaDetailDto.partNumber;
#warning 暂时改为只支持自营，待支持后再更改
        dataProductBasic.shopCode = @"";
//        dataProductBasic.cityCode = [Config currentConfig].defaultCity;
        
        ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
        
        [self.navigationController pushViewController:productViewController animated:YES];
        
        TT_RELEASE_SAFELY(productViewController);
    }
}


- (void)disOrderAction:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView : self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint : currentTouchPosition];
    
    if (indexPath != nil)
    {
        selectIndex = indexPath.row;
        selectSectionIndex = indexPath.section;
        EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:indexPath.section];
        NSArray *array = evaDto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:indexPath.row];
        MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
        dto.orderItemId = evaDetailDto.orderItemId;
        [self displayOverFlowActivityView];
        [self.displayorderService checkURPhotoExistsHttpRequest:dto isSubmitDisOrder:NO isOrderDetailLoad:YES];
    }
}


-(void)CheckURPhotoExistsHttpRequestCompleteWithService:(BOOL)isSubmitDisOrder
                                      isOrderDetailLoad:(BOOL)isOrderDetailLoad
                                              isSuccess:(BOOL)isSuccess
                                               errorMsg:(NSString*)errorMsg
{
    [self removeOverFlowActivityView];
    if(isSuccess)
    {        
        if (isSubmitDisOrder) {            
            EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:selectSectionIndex];
            
            NSArray *array = evaDto.orderItemList;
            EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:selectIndex];
            
            MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
            dto.orderItemId = evaDetailDto.orderItemId;
            dto.productId = evaDetailDto.catentryId;
            ProductDisOrderSubmitViewController *productSubmitViewController = (ProductDisOrderSubmitViewController *)[[ProductDisOrderSubmitViewController alloc] initWithDTO:dto isMember:NO];
            
            [self.navigationController pushViewController:productSubmitViewController animated:YES];
            TT_RELEASE_SAFELY(productSubmitViewController);
        }else {
            [self presentSheet:L(@"Please Don't repeat Display Order") posY:100];
        }
    }
    else
    {
        [self presentSheet:errorMsg?errorMsg:kServerBusyErrorMsg posY:100];
    }
}

- (void)evalutionAction:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView : self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint : currentTouchPosition];
    
    if (indexPath != nil) {
        selectIndex = indexPath.row;
        selectSectionIndex = indexPath.section;

        EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:indexPath.section];
        NSArray *array = evaDto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:indexPath.row];

        [self displayOverFlowActivityView];
        
        [self.evalutionService beginEvalutionValidate:evaDetailDto.orderItemId];
    }
}

- (void)evalutionValidateCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg isBook:(BOOL)isBook
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        EvalutionDTO *dto = [self.evalutionList objectAtIndex:selectSectionIndex];
        
        NSArray *array = dto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:selectIndex];

        EvalutionContentViewController *next = [[EvalutionContentViewController alloc] init];
        next.evalutionDto = evaDetailDto;
        
        [self.navigationController pushViewController:next animated:YES];

    }else{
        [self presentSheet:errorMsg];
    }
}


#pragma mark -
#pragma mark Refresh And Load More
- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self.evalutionService getEvalutionListHttp:self.currentPage];
    
    [self displayOverFlowActivityView];
    
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    self.currentPage ++;
    
    [self.evalutionService getEvalutionListHttp:self.currentPage];
    
    [self displayOverFlowActivityView];
}


@end
