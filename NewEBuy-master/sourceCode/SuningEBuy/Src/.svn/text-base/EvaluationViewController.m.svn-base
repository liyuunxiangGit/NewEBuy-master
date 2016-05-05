//
//  EvaluationViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EvaluationViewController.h"
#import "MemberOrderDetailsDTO.h"
#import "EvalutionContentViewController.h"
#import "ProductDisOrderSubmitViewController.h"
#import "ProductDetailViewController.h"
#import "UITableViewCell+BgView.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#import "SNCommentPostViewController.h"

@interface EvaluationViewController ()
{
    NSInteger           selectSectionIndex;
    NSInteger           selectIndex;
    BOOL                isLoadOK;
    BOOL                isStartLoad;
}
@end

@implementation EvaluationViewController

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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.selectRow = eWaitPingJiaList;
        
        self.title = L(@"HEvaluateDisplayOrder");
        self.pageTitle = L(@"member_myEbuy_evaluateAndDisOrder");
        if (!_evalutionList) {
            _evalutionList = [[NSMutableArray alloc] init];
        }
        isStartLoad = NO;
        isLoadOK = NO;
        self.currentPage = 1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotosss) name:@"sffff" object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoshaidan) name:@"shaidanchenggong" object:nil];
    }
    return self;
}

- (void)gotosss
{
    //    selectIndex = indexPath.row;
    //    selectSectionIndex = indexPath.section;
    
    EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:selectSectionIndex];
    NSArray *array = evaDto.orderItemList;
    EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:selectIndex];
    
    evaDetailDto.reviewFlag = @"1";
    
//    [self.groupTableView reloadData];
    [self.tableView reloadData];
}

//- (void)gotoshaidan
//{
//    EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:selectSectionIndex];
//    NSArray *array = evaDto.orderItemList;
//    EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:selectIndex];
//
//    evaDetailDto.orderShowFlag = @"1";
//
//    [self.groupTableView reloadData];
//}

- (void)loadView
{
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    [self.tableView addSubview:self.refreshHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    [self.view addSubview:self.tableView];
    if (!isLoadOK) {
        [self displayOverFlowActivityView];
        
        [self.evalutionService getEvalutionListHttp:self.currentPage];
    }
}

- (void)backForePage {
    
    if (IOS7_OR_LATER && !(IOS8_OR_LATER)) {
        
        sourcePageTitle = nil;
        daoPageTitle    = nil;
        [self.navigationController popViewControllerAnimated:NO];
    }else {
        [super backForePage];
    }
}

- (UIImageView*)alertImageV
{
    if(!_alertImageV)
    {
        _alertImageV = [[UIImageView alloc] init];
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoOrder.png"];
        
        _alertImageV.frame = CGRectMake(116.5, self.view.frame.size.height/2-76-46, 77, 76);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];
        
    }
    
    return _alertImageV;
}



- (UILabel *)emptyLabel
{
    if (!_emptyLabel)
    {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 30)];
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.text = L(@"HCurrentNoGoodsForEvaluateOrDisplay");
        _emptyLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        _emptyLabel.font = [UIFont systemFontOfSize:17];
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.hidden = YES;
        [self.view addSubview:_emptyLabel];

    }
    return _emptyLabel;
}

- (UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 400)];
        _emptyView.backgroundColor = [UIColor clearColor];
        [_emptyView addSubview:self.emptyLabel];
    }
    return _emptyView;
}

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

- (ProductDetailSubmitService *)displayorderService
{
    if (!_displayorderService) {
        _displayorderService = [[ProductDetailSubmitService alloc] init];
        _displayorderService.delegate = self;
    }
    return _displayorderService;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        //        if (IsArrEmpty(array)) {
        //            self.emptyLabel.hidden = NO;
        //        }
        //        else
        //        {
        //            self.emptyLabel.hidden = YES;
        //        }
        
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
//    [self.groupTableView reloadData];
    [self.tableView reloadData];
    
    if (IsArrEmpty(self.evalutionList)) {
        self.emptyLabel.hidden = NO;
        self.alertImageV.hidden = NO;
//        self.groupTableView.tableFooterView = self.emptyView;
//        self.tableView.tableFooterView = self.emptyView;
    }else{
        self.emptyLabel.hidden = YES;
        self.alertImageV.hidden = YES;

//        self.groupTableView.tableFooterView = nil;
//        self.tableView.tableFooterView = nil;
    }
}

#pragma mark -
#pragma mark tableview delegate/datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self hasMore] && !IsArrEmpty(self.evalutionList))
    {
        return [self.evalutionList count] + 1;
    }
    return [self.evalutionList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore] && section == [self.evalutionList count]) {
        return 1;
    }
    EvalutionDTO *dto = [self.evalutionList objectAtIndex:section];
    
    NSArray *array = [dto orderItemList];
    
    return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.evalutionList.count == 0)
    {
        return 0;
    }else{
        if ([self hasMore] && section == self.evalutionList.count) {
            return 0;
        }
//        return 30;
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.evalutionList.count == 0 && isStartLoad)
    {
        return 300;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.evalutionList.count == 0)
    {
        //        [self.emptyLabel removeFromSuperview];
        return nil;
    }else{
//        if ([self hasMore] && section == [self.evalutionList count]) {
//            return nil;
//        }
//        UIView *headView = [[UIView alloc] init];
//        headView.frame = CGRectMake(0, 0, 320, 30);
//        //        headView.backgroundColor = [UIColor lightGrayColor];
//        
//        UILabel *orderIdLabel = [[UILabel alloc] init];
//        orderIdLabel.frame = CGRectMake(10, 0, 160, 30);
//        orderIdLabel.font = [UIFont boldSystemFontOfSize:14.0];
//        orderIdLabel.backgroundColor = [UIColor clearColor];
//        orderIdLabel.textColor = RGBCOLOR(93, 93, 93);
//        orderIdLabel.textAlignment = UITextAlignmentLeft;
//        orderIdLabel.text = [NSString stringWithFormat:@"订单编号:%@",[[self.evalutionList objectAtIndex:section] orderId]];
//        
//        UILabel *orderTimeLabel = [[UILabel alloc] init];
//        orderTimeLabel.frame = CGRectMake(175, 0, 160, 30);
//        orderTimeLabel.font = [UIFont boldSystemFontOfSize:14.0];
//        orderTimeLabel.backgroundColor = [UIColor clearColor];
//        orderTimeLabel.textColor = RGBCOLOR(93, 93, 93);
//        orderTimeLabel.textAlignment = UITextAlignmentLeft;
//        
//        NSString *orderTimeStr = [[[self.evalutionList objectAtIndex:section] orderTime] substringToIndex:10];
//        
//        orderTimeLabel.text = [NSString stringWithFormat:@"下单时间:%@",orderTimeStr];
//        
//        [headView addSubview:orderIdLabel];
//        [headView addSubview:orderTimeLabel];
//        
//        return headView;
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(self.evalutionList.count == 0 && isStartLoad)
    {
        //        return self.emptyLabel;
        return nil;
    }else{
        //        [self.emptyLabel removeFromSuperview];
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.section == [self.evalutionList count]) {
        return  48;
    }
    return 163;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.section == [self.evalutionList count])
    {
        static NSString *MoreResultIdentify = @"MoreResultIdentify";
		
		UITableViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
		
		if (cell == nil)
        {
			cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
            
//            cell.backgroundColor=RGBCOLOR(250, 247, 235);
            
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.backgroundColor = [UIColor clearColor];
//            imageView.image = [UIImage streImageNamed:@"evalution_cell.png"];
            
//            cell.backgroundView = imageView;
			
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
    
    EvalutionDTO *dto = [self.evalutionList objectAtIndex:indexPath.section];
    
    EvalutionDetailDTO *detailDto = [dto.orderItemList objectAtIndex:indexPath.row];
    
    cell.merchanStructDetail = detailDto;
    
    
    
//    NSArray *array = [dto orderItemList];
//    NSUInteger listCount = [array count];
//    [cell setCoolBgViewWithCellPosition:CellPositionMake(listCount, indexPath.row)];
    
    if ([cell.merchanStructDetail.reviewFlag isEqualToString:@"1"]) {
        [cell.evalutionBtn setTitle:L(@"BTHaveEvaluated") forState:UIControlStateNormal];
        [cell.evalutionBtn setTitleColor:RGBCOLOR(173, 146, 74) forState:UIControlStateNormal];
        [cell.evalutionBtn setBackgroundImage:[UIImage imageNamed:@"button_gray_normal.png"] forState:UIControlStateNormal];
        cell.evalutionBtn.adjustsImageWhenHighlighted = NO;
        //        cell.evalutionBtn.userInteractionEnabled = YES;
        //        cell.evalutionBtn.enabled = NO;
    }else{
        [cell.evalutionBtn setTitle:L(@"Evaluation") forState:UIControlStateNormal];
        [cell.evalutionBtn setTitleColor:RGBCOLOR(56, 51, 39) forState:UIControlStateNormal];
        [cell.evalutionBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiu.png"] forState:UIControlStateNormal];
    }
    
    //    if ([cell.merchanStructDetail.orderShowFlag isEqualToString:@"1"]) {
    //        [cell.displayBtn setTitle:@"已晒单" forState:UIControlStateNormal];
    //        [cell.displayBtn setTitleColor:RGBCOLOR(173, 146, 74) forState:UIControlStateNormal];
    //        [cell.displayBtn setBackgroundImage:[UIImage imageNamed:@"evalution_btn_gray.png"] forState:UIControlStateNormal];
    //        cell.displayBtn.adjustsImageWhenHighlighted = NO;
    //
    //        //        cell.evalutionBtn.userInteractionEnabled = YES;
    //        //        cell.evalutionBtn.enabled = NO;
    //    }else{
    [cell.displayBtn setTitle:L(@"HDisplayOrder") forState:UIControlStateNormal];
    [cell.displayBtn setTitleColor:RGBCOLOR(56, 51, 39) forState:UIControlStateNormal];
    [cell.displayBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiu.png"] forState:UIControlStateNormal];
    //    }
    
    [cell.displayBtn addTarget:self action:@selector(disOrderAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.evalutionBtn addTarget:self action:@selector(evalutionAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self hasMore] && indexPath.section == [self.evalutionList count]) {
//        [self loadMoreData];
//    }
//    else{
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        DataProductBasic *dataProductBasic = [[DataProductBasic alloc] init];
//        EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:indexPath.section];
//        
//        NSArray *array = evaDto.orderItemList;
//        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:indexPath.row];
//        
//        dataProductBasic.productId = evaDetailDto.catentryId;
//        dataProductBasic.productCode = evaDetailDto.partNumber;
//#warning 暂时改为只支持自营，待支持后再更改
//        dataProductBasic.shopCode = @"";
//        //        dataProductBasic.cityCode = [Config currentConfig].defaultCity;
//        
//        ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
//        
//        [self.navigationController pushViewController:productViewController animated:YES];
//        
//        TT_RELEASE_SAFELY(productViewController);
//    }
}


- (void)disOrderAction:(id)sender event:(id)event{
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"770704", nil]];
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
//    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    CGPoint currentTouchPosition = [touch locationInView : self.tableView];
    
//    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint : currentTouchPosition];
    
    if (indexPath != nil)
    {
        selectIndex = indexPath.row;
        selectSectionIndex = indexPath.section;
        EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:indexPath.section];
        NSArray *array = evaDto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:indexPath.row];
        
        if ([evaDetailDto.orderShowFlag isEqualToString:@"1"]) {
            
            [self presentSheet:L(@"HGoodsHasDisplayed")];
            
            return;
        }
        else
        {
            MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
            dto.orderItemId = evaDetailDto.orderItemId;
            [self displayOverFlowActivityView];
            [self.displayorderService checkURPhotoExistsHttpRequest:dto isSubmitDisOrder:NO isOrderDetailLoad:YES];
        }
        
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
            ProductDisOrderSubmitViewController *productSubmitViewController = (ProductDisOrderSubmitViewController *)[[ProductDisOrderSubmitViewController alloc] initWithDTO:dto isMember:YES];
            
            productSubmitViewController.evalutionDto = evaDetailDto;
            
            productSubmitViewController.hasNav = YES;
            productSubmitViewController.hidesBottomBarWhenPushed = YES;
            productSubmitViewController.title = L(@"HDisplayOrder");
            
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
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"770703", nil]];
    /*
    SNCommentPostViewController *vc = [[SNCommentPostViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    return;
     */
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
//    CGPoint currentTouchPosition = [touch locationInView : self.groupTableView];
    CGPoint currentTouchPosition = [touch locationInView : self.tableView];
    
//    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint : currentTouchPosition];
    
    if (indexPath != nil) {
        selectIndex = indexPath.row;
        selectSectionIndex = indexPath.section;
        
        EvalutionDTO *evaDto = [self.evalutionList objectAtIndex:indexPath.section];
        NSArray *array = evaDto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:indexPath.row];
        
        
        
        if ([evaDetailDto.reviewFlag isEqualToString:@"1"]) {
            return;
        }
        else
        {
            [self displayOverFlowActivityView];
            [self.evalutionService beginEvalutionValidate:evaDetailDto.orderItemId];
        }
    }
}

- (void)evalutionValidateCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        EvalutionDTO *dto = [self.evalutionList objectAtIndex:selectSectionIndex];
        
        NSArray *array = dto.orderItemList;
        EvalutionDetailDTO *evaDetailDto = (EvalutionDetailDTO *)[array objectAtIndex:selectIndex];
        
        EvalutionContentViewController *next = [[EvalutionContentViewController alloc] init];
        next.evalutionDto = evaDetailDto;
        next.evalDto = dto;
        next.showReviewStatus = self.evalutionService.showReviewStatus;
        next.hasNav = YES;
        next.hidesBottomBarWhenPushed = YES;
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
