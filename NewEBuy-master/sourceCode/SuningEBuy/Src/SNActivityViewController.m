//
//  SNActivityViewController.m
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SNActivityViewController.h"
#import "DataProductBasic.h"
#import "ProductDetailViewController.h"
#import "SNActivityProductDTO.h"
#import "SNActivityProductCell.h"
#import "AdModel3Cell.h"

#define kHttpRequestActivityId            @"activityId"
#define kHttpRequestPageNumId             @"pageNumber"
#define khttprequestPageSizeValue         @"8"
#define khttprequestPageSizeId            @"pageSize"

@interface SNActivityViewController ()
{
    BOOL isDataLoaded;
}

//@property (nonatomic, retain) NSArray                       *hotSaleProductList;

@property (nonatomic, strong)   NSMutableArray               *returnGoodsList;
@property (nonatomic, strong)   NSString                     *actRule;

//- (void)sendHotSaleProductHttpRequest;

- (NSInteger)getRowNum:(NSInteger)listCount;

//- (CGFloat)getStringHeight:(NSString *)string;

-(void)registKVO;
- (void)unRegistKVO;
@end

@implementation SNActivityViewController

//@synthesize hotSaleProductList = _hotSaleProductList;
@synthesize activityId=_activityId;
@synthesize activityDto=_activityDto;
@synthesize prdSortType=_prdSortType;
@synthesize returnGoodsList = _returnGoodsList;
@synthesize service=_service;
@synthesize actRule=_actRule;
@synthesize AdActiveRuleCellHeight;

- (void)dealloc
{
    
//    TT_RELEASE_SAFELY(_hotSaleProductList);
    TT_RELEASE_SAFELY(_dmDto);
    TT_RELEASE_SAFELY(_activityId);
    TT_RELEASE_SAFELY(_prdSortType);
    TT_RELEASE_SAFELY(_activityDto); 
    TT_RELEASE_SAFELY(_actRule);
    TT_RELEASE_SAFELY(_returnGoodsList);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    SERVICE_RELEASE_SAFELY(_service);
    
    [self unRegistKVO];
}

- (id)initWithActName:(NSString *)actName areaName:(NSString*)aAreaName
{
    if (self = [super init]) 
    {
        if (!IsStrEmpty(actName)) {
            self.title = actName;
        }else{
            self.title = L(@"top recomment");
        }
        if (aAreaName && [aAreaName isEqualToString:L(@"sale_hotPage")])
        {
            self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_hotPage"),self.title];
        }
        else
        {
            self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_hotTopic"),self.title];
        }
        // 注册进入详情通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(pushProductDetailAction:)
                                                     name:HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION
                                                   object:nil];
        
        self.currentPage = 1;
        
        if (!_returnGoodsList) {
            
            _returnGoodsList = [[NSMutableArray alloc] init];
        }
        _actRule = nil;
        self.hidesBottomBarWhenPushed = YES;
        self.iOS7FullScreenLayout = YES;
    }
    
    return self;
}


#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:(UIView*)self.refreshHeaderView];
    
    [self.view addSubview:self.emptyLabel];
//    [self sendHotSaleProductHttpRequest];
    [self displayOverFlowActivityView];
    
    if (IsStrEmpty(self.activityId)) {
        self.emptyLabel.hidden = NO;
    }
    else
    {
        self.emptyLabel.hidden = YES;
    }
    
    [self.service beginGetActivityProdcuctDetailList:self.activityId currentPage:self.currentPage];
    
    [self registKVO];

    self.hasSuspendButton = YES;
}

- (UILabel *)emptyLabel{
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.frame = CGRectMake(60, 100, 200, 200);
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.text = L(@"OSSorryForEnd");
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.hidden = YES;
    }
    return _emptyLabel;
}

- (UILabel *)emptyActiviLabel
{
    if (!_emptyActiviLabel)
    {
        _emptyActiviLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 60)];
        _emptyActiviLabel.backgroundColor = [UIColor clearColor];
        _emptyActiviLabel.text = L(@"No_Data_Error");
        _emptyActiviLabel.textColor = [UIColor grayColor];
        _emptyActiviLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _emptyActiviLabel.textAlignment = UITextAlignmentCenter;
        _emptyActiviLabel.numberOfLines = 0;
    }
    return _emptyActiviLabel;
}


- (void)reloadHotSaleDataSource
{
    NSInteger sortType = [self.prdSortType intValue];

    //一行一个小需要分割线
    if (sortType == 1)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    [self.tableView reloadData];
    
    if (IsArrEmpty(self.returnGoodsList)) {
        self.tableView.tableFooterView =self.emptyActiviLabel;
    }
}

#pragma mark -
#pragma mark Go Product Detail
- (void)pushProductDetailAction:(NSNotification *)notification
{
    DataProductBasic *productDto = [notification object];
    
    ProductDetailViewController *_ProductViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:productDto];
    
    [self.navigationController pushViewController:_ProductViewController animated:YES];
    
    TT_RELEASE_SAFELY(_ProductViewController);
}


#pragma mark -
#pragma mark Table Delegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!isDataLoaded) {
        return 0;
    }
    
    if ([self getRuleHeight]) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self getRuleHeight] && section == 0) {
        return 1;
    }
    
    NSInteger sortType = [self.prdSortType intValue];
    NSInteger numRows = 0;
    switch (sortType) {
        case 0:
        {
            if ([self hasMore]) 
            {
                numRows = [self.returnGoodsList count] + 1;
            }
            else
            {
                numRows = [self.returnGoodsList count];
            }
        }
            break;
        case 1:
        {
            if ([self hasMore]) 
            {
                numRows = [self.returnGoodsList count] + 1;
            }
            else
            {
                numRows = [self.returnGoodsList count];
            }
        }
            break;
        case 2:
        {
           
            numRows = [self getRowNum:[self.returnGoodsList count]];

            if ([self hasMore]) 
            {
                numRows = numRows + 1;
            }
        }
            break;
        case 3:
        {
        
            numRows = [self getNewRowNum:[self.returnGoodsList count]];
   
            if ([self hasMore])
            {
                numRows = numRows + 1;
            }
        }
            break;
            
        default:
            break;
    }
    
    return numRows;    
}

- (NSInteger)getRowNum:(NSInteger)listCount{
    
    if (listCount%2 == 1) {
        
        return listCount/2+1;
        
    }else{
        
        return listCount/2;
    }
    
}
//新增每行3个
- (NSInteger)getNewRowNum:(NSInteger)listCount{
    
    if (listCount%3 == 0) {
        
        return listCount/3;
        
    }else{
        
        return listCount/3+1;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self getRuleHeight] && indexPath.section == 0)
    {
        
        if (!IOS7_OR_LATER)
        {
            return  self.AdActiveRuleCellHeight + 20;
        }
        return self.AdActiveRuleCellHeight+20;

    }
    else
    {
        NSInteger sortType = [self.prdSortType intValue];
//        DLog(@"totalcount=%d, index.row = %d",self.totalCount,indexPath.row);
        
        if ([self hasMore]) {
            if (sortType == 3) {
                
                NSInteger lastRow = [self getNewRowNum:[self.returnGoodsList count]];
                
                if (lastRow == indexPath.row)
                {
                    return 48;
                }
                
            }else if (sortType == 2) {
                
                NSInteger lastRow = [self getRowNum:[self.returnGoodsList count]];
                
                if (lastRow == indexPath.row)
                {
                    return 48;
                }
                
            }else{
                
                if (self.totalCount == indexPath.row)
                {
                    return 48;
                }
            }
        }
        
        return [SNActivityProductCell height:sortType];
    }
}

//- (CGFloat)getStringHeight:(NSString *)string{
//
//    CGSize size = [string heightWithFont:[UIFont boldSystemFontOfSize:14] width:300 linebreak:UILineBreakModeWordWrap];
//    CGFloat height = size.height;
//    return height;
//
//}

- (CGFloat)getRuleHeight{
    
    if (![AdActiveRuleCell canShowRuleCell:self.actRule]) {
        
        return 0;
        
    }else{
        
        return   [AdActiveRuleCell height: self.actRule];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
//    if (indexPath.section == 0 && !IsStrEmpty(self.actRule)) {
//        
//        static NSString *MobileRuleIdentifier = @"MobileRuleIdentifier";
//        
//        UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:MobileRuleIdentifier];
//        
//        if (!cell) {
//            
//            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MobileRuleIdentifier]autorelease];
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.accessoryType =  UITableViewCellAccessoryNone;
//                                    
//            UILabel *ruleTitleLbl = [[UILabel alloc] init];
//            ruleTitleLbl.frame = CGRectMake(10, 10, 300, 16);
//            ruleTitleLbl.font = [UIFont boldSystemFontOfSize:16];
//            ruleTitleLbl.shadowOffset = CGSizeMake(1, 1);
//            ruleTitleLbl.shadowColor = [UIColor whiteColor];
//            ruleTitleLbl.textColor = [UIColor darkRedColor];
//            ruleTitleLbl.textAlignment = UITextAlignmentCenter;
//            ruleTitleLbl.backgroundColor = [UIColor clearColor];
//            [cell.contentView addSubview:ruleTitleLbl];
//            ruleTitleLbl.text = @"活动规则";
//
//            UILabel *ruleContentLbl = [[UILabel alloc] init];
//            CGFloat height = [self getStringHeight:self.actRule];
//            ruleContentLbl.frame = CGRectMake(10, ruleTitleLbl.bottom + 10, 300, height);
//            ruleContentLbl.font = [UIFont boldSystemFontOfSize:14];
//            ruleContentLbl.textColor = [UIColor darkGrayColor];
//            ruleContentLbl.textAlignment = UITextAlignmentLeft;
//            ruleContentLbl.lineBreakMode = UILineBreakModeWordWrap;
//            ruleContentLbl.numberOfLines = 0;
//            ruleContentLbl.text = self.actRule;
//            ruleContentLbl.backgroundColor = [UIColor clearColor];
//            [cell.contentView addSubview:ruleContentLbl];
//            
//            UIImageView *cellSeperateView = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"cellSeparatorLine.png"]];
//            cellSeperateView.frame = CGRectMake(0, ruleContentLbl.bottom + 8, 320,2 );
//            [cell.contentView addSubview:cellSeperateView];
//            
//            cell.contentView.backgroundColor = [UIColor clearColor];
//            
//            TT_RELEASE_SAFELY(ruleTitleLbl);
//            TT_RELEASE_SAFELY(ruleContentLbl);
//            TT_RELEASE_SAFELY(cellSeperateView);
//        }
//        return cell;
//    }
    
    if (indexPath.section == 0 && [self getRuleHeight])
    {
        static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier";
        
        AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
        
        if(acell == nil){
            
            acell = [[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier];
            acell.delegate=self;
            acell.accessoryType = UITableViewCellAccessoryNone;
            acell.layer.zPosition = -1;
        }
        
        [acell setRuleContent:self.actRule];
        
        return acell;
        
    }
    
    NSInteger sortType = [self.prdSortType intValue];
    
    if ([self hasMore]) {
        
        if (sortType == 3) {
            
            NSInteger lastRow = [self getNewRowNum:[self.returnGoodsList count]];
            
            if (lastRow == indexPath.row)
            {
                static NSString *MobileQueryMoreIdentifier = @"MobileQueryMoreIdentifier";
                
                UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MobileQueryMoreIdentifier];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MobileQueryMoreIdentifier];
                    
                    cell.title = @"Get More...";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.animating = NO;
                }
              
                return cell;
            }
            
        }else if (sortType == 2) {
            
            NSInteger lastRow = [self getRowNum:[self.returnGoodsList count]];
            
            if (lastRow == indexPath.row)
            {
                static NSString *MobileQueryMoreIdentifier = @"MobileQueryMoreIdentifier";
                
                UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MobileQueryMoreIdentifier];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MobileQueryMoreIdentifier];
                    
                    cell.title = @"Get More...";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.animating = NO;
                }
                
                return cell;
            }
            
        }else{
            if (self.totalCount == indexPath.row)
            {
                static NSString *MobileQueryMoreIdentifier = @"MobileQueryMoreIdentifier";
                
                UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MobileQueryMoreIdentifier];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MobileQueryMoreIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.title = @"Get More...";
                    
                    cell.animating = NO;
                    
                }
                
                return cell;
                
            }
        }
    }
    
        
    switch (sortType) {
        case 0:
        {
            static NSString *topRecommentItemCellIdentifier = @"topRecommentItemCellIdentifier";
            
            SNActivityProductCell *cell = (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier];
            
            if(cell == nil)
            {
                
                cell = [[SNActivityProductCell alloc]initWithReuseIdentifier:topRecommentItemCellIdentifier];
                
            }

//            DLog(@"row=%d",indexPath.row);
            SNActivityProductDTO *centerDto = [self.returnGoodsList objectAtIndex:indexPath.row];
            
            [cell setBigCenterItem:centerDto];
            
            return cell;
        }
            break;
            
        case 1:
        {
            static NSString *topRecommentItemCellIdentifier = @"topRecommentItemCellIdentifier";
            
            SNActivityProductCell *cell = (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier];
            
            if(cell == nil)
            {
                
                cell = [[SNActivityProductCell alloc]initWithReuseIdentifier:topRecommentItemCellIdentifier];
                
            }

//            DLog(@"row=%d",indexPath.row);
            SNActivityProductDTO *centerDto = [self.returnGoodsList objectAtIndex:indexPath.row];
            
            [cell setSmallCenterItem:centerDto];
            
            return cell;
            
        }
            break;
            
        case 2:
        {

//            DLog(@"row=%d",indexPath.row);
//
//            if ([self.returnGoodsList count]%2 == 1 && indexPath.row*2 == [self.returnGoodsList count] - 1) {
//                static NSString *topRecommentItemCellIdentifier = @"topRecommentItemCellIdentifier";
//
//                SNActivityProductCell *cell= (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier];
//                
//                if(cell == nil)
//                {
//                    
//                    cell = [[SNActivityProductCell alloc]initWithReuseIdentifier:@"topRecommentItemCellIdentifier1"];
//                    
//                }
//                
//                SNActivityProductDTO *leftDto = [self.returnGoodsList objectAtIndex:indexPath.row*2];
//
////                SNActivityProductDTO *rightDto = [self.returnGoodsList objectAtIndex:(indexPath.row*2)+1];
//                
//                [cell setItem:leftDto rightItem:nil];
//                
//                return cell;
//                
//            }else{
//                static NSString *topRecommentItemCellIdentifier1 = @"topRecommentItemCellIdentifier1";
//                
//                SNActivityProductCell *cell = (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier1];
//                
//                if(cell == nil)
//                {
//                    
//                    cell = [[SNActivityProductCell alloc]initWithReuseIdentifier:topRecommentItemCellIdentifier1];
//                    
//                }
//
//                DLog(@"row=%d",indexPath.row);
//                SNActivityProductDTO *leftDto = [self.returnGoodsList objectAtIndex:indexPath.row*2];
//                
//                SNActivityProductDTO *rightDto = [self.returnGoodsList objectAtIndex:indexPath.row*2+1];
//                
//                [cell setItem:leftDto rightItem:rightDto];
//                return cell;
//            }
            static NSString *topRecommentItemCellIdentifier = @"topRecommentItemCellIdentifier";
            
            SNActivityProductCell *cell= (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier];
            
            if(cell == nil){
//            DLog(@"row=%d",indexPath.row);

            static NSString *topRecommentItemCellIdentifier = @"topRecommentItemCellIdentifier";
            
            SNActivityProductCell *cell= (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier];
            
            if(cell == nil)
            {

                cell = [[SNActivityProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topRecommentItemCellIdentifier];
                cell = [[SNActivityProductCell alloc]initWithReuseIdentifier:@"topRecommentItemCellIdentifier1"];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
//                cell.imageDidDelegate = self;
            }
            
            
            int row = indexPath.row;
            int count;
            
            SNActivityProductDTO *leftDto = nil;
            SNActivityProductDTO *rightDto = nil;
            
                count = [self.returnGoodsList count];
                
                if (row*2 < count) {
                    leftDto = [self.returnGoodsList objectAtIndex:row*2];
                }
                
                if (row*2+1 < count) {
                    rightDto = [self.returnGoodsList objectAtIndex:row*2+1];
                }
            
            [cell setItem:leftDto rightItem:rightDto withTag:row];
            
            
            return cell;
            }
            
        }
            break;
        case 3:
        {
            static NSString *adModel3CellIdentifier = @"adModel3CellIdentifier";
            
            AdModel3Cell *cell = (AdModel3Cell *)[tableView dequeueReusableCellWithIdentifier:adModel3CellIdentifier];
            
            if(cell == nil){
                
                cell = [[AdModel3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adModel3CellIdentifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.imageDidDelegate = self;
            }
            
//            DLog(@"row=%d",indexPath.row);
            
            int row = indexPath.row;
            
            int count = [self.returnGoodsList count];
            SNActivityProductDTO *leftDto = nil;
            SNActivityProductDTO *centerDto = nil;
            SNActivityProductDTO *rightDto = nil;
            
            if (row*3 < count) {
                leftDto = [self.returnGoodsList objectAtIndex:row*3];
            }
            
            if (row*3+1 < count) {
                centerDto = [self.returnGoodsList objectAtIndex:row*3+1];
            }
            
            if (row*3+2 < count) {
                rightDto = [self.returnGoodsList objectAtIndex:row*3+2];
            }
            
            [cell leftDto:leftDto centerItem:centerDto rightItem:rightDto withTag:row];
            
            return cell;
//            if ([self.returnGoodsList count]%3 == 1) {
//                
//                SNActivityProductDTO *centerDto = [self.returnGoodsList objectAtIndex:indexPath.row*3 + 2];
//                
//                cell= (SNActivityProductCell*)[tableView dequeueReusableCellWithIdentifier:@"topRecommentItemCellIdentifier1"];
//                
//                if(cell == nil)
//                {
//                    
//                    cell = [[[SNActivityProductCell alloc]initWithReuseIdentifier:@"topRecommentItemCellIdentifier1"] autorelease];
//                    
//                }
//                
//                [cell setItem:nil centerItem:centerDto rightItem:nil withTag:indexPath.row];
//                
//            }else if([self.returnGoodsList count]%3 == 2){
//                DLog(@"row=%d",indexPath.row);
//
//                SNActivityProductDTO *centerDto = [self.returnGoodsList objectAtIndex:indexPath.row*3 + 2];
//                
//                SNActivityProductDTO *rightDto = [self.returnGoodsList objectAtIndex:indexPath.row*3+1];
//                
//                [cell setItem:nil centerItem:centerDto rightItem:rightDto withTag:indexPath.row];
//                
//            }else{
//                
//                DLog(@"row=%d",indexPath.row);
//                SNActivityProductDTO *leftDto = [self.returnGoodsList objectAtIndex:indexPath.row*3];
//                
//                SNActivityProductDTO *centerDto = [self.returnGoodsList objectAtIndex:indexPath.row*3 + 1];
//
//                SNActivityProductDTO *rightDto = [self.returnGoodsList objectAtIndex:indexPath.row*3+2];
//                
//                [cell setItem:leftDto centerItem:centerDto rightItem:rightDto withTag:indexPath.row];
//            }
        }
            break;
            
        default:
            break;
    }
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //加载更多
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[UITableViewMoreCell class]])
    {
        [self loadMoreData];
        return;
    }
	
	NSInteger section = [indexPath section];
	
    NSInteger sortType = [self.prdSortType intValue];
    
    if (sortType == 0)
    {
        if (indexPath.row >= [self.returnGoodsList count] && [self hasMore])
        {
//            [self loadMoreData];
        }
    }
    else if(sortType == 1)
    {
        if ([self getRuleHeight] && section == 0) {
            //do nothing
        }else{
            if (indexPath.row >= [self.returnGoodsList count] && [self hasMore])
            {
//                [self loadMoreData];
            }
            else
            {
                SNActivityProductDTO *dto  = [self.returnGoodsList objectAtIndex:indexPath.row];
                DataProductBasic *tempDto = dto.transformToProductDTO;
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION
                 object:tempDto];
                TT_RELEASE_SAFELY(tempDto);
            }
        }
    }
    else if (sortType == 2)
    {
        int numRows = [self getRowNum:[self.returnGoodsList count]];
        if (indexPath.row >= numRows && [self hasMore]) {
//            [self loadMoreData];
        }
    }else if(sortType == 3)
    {
        int numRows = [self getNewRowNum:[self.returnGoodsList count]];
        if (indexPath.row >= numRows && [self hasMore]) {
            //            [self loadMoreData];
        }

    }
    
}

- (void)refreshData{
    
    [super refreshData];
    
    self.currentPage = 1;
    self.isLastPage = NO;
    
    [self displayOverFlowActivityView];
    [self.service beginGetActivityProdcuctDetailList:self.activityId currentPage:self.currentPage];
}


- (void)loadMoreData{
        
    [super loadMoreData];
    [self startMoreAnimation:YES];
    
    [self displayOverFlowActivityView];
    [self.service beginGetActivityProdcuctDetailList:self.activityId currentPage:self.currentPage];
}

#pragma mark -
#pragma mark service data

- (SNActivityService *)service
{
    if (!_service) {
        _service = [[SNActivityService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)getActivityProductListCompletionWithResult:(BOOL)isSuccess 
                                          errorMsg:(NSString *)errorMsg 
                                  SNActivityDetail:(SNActivityDTO *)dto
                            SNActivityProductArray:(NSArray *)array
                                           pageNum:(NSInteger)pageNum
                                         pageCount:(NSInteger)pageCount
                                           actRule:(NSString *)actRule
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        [self.view hideNetworkErrorView];
        
        isDataLoaded = YES;
        
        self.activityDto = dto;
        
        self.activityDto.prdSortType = self.prdSortType;
        
        //如果是从dm、消息推送进来 就用带过来的规则
        if (nil != _dmDto && 0 != [_dmDto.activityRule length]) {
            
            self.actRule = _dmDto.activityRule;
        }
        else{
            
            self.actRule = actRule;
        }
        
        
        if(array != nil && [array count] > 0){
            
            NSMutableArray *topArray = [[NSMutableArray alloc] init];
            
            for(NSDictionary *dic in array){
                
                SNActivityProductDTO *dto = [[SNActivityProductDTO alloc] init];
                
                [dto encodeFromDictionary:dic];
                
                [topArray addObject:dto];
                
                
            }
            if (self.currentPage == 1) {
                [self refreshDataComplete];
                [self.returnGoodsList removeAllObjects];
            }else{
                [self loadMoreDataComplete];
            }
            
            [self.returnGoodsList addObjectsFromArray:topArray];
            
//            DLog(@"topArray count is %d",[topArray count]);
        }
        
        self.currentPage = pageNum;
        self.totalPage = pageCount;
        self.totalCount = [self.returnGoodsList count];
        
        if (pageNum < pageCount) {
            self.isLastPage = NO;
            self.currentPage++;
        }else{
            self.isLastPage = YES;
        }
        
        self.AdActiveRuleCellHeight = [AdActiveRuleCell height: self.actRule] + 30;

        
//        [self reloadHotSaleDataSource];
        
    }
    else
    {
//        [self presentSheet:errorMsg];
        if (self.currentPage > 1)
        {
            [self presentSheet:errorMsg];
        }
        else
        {
            __weak SNActivityViewController *weakSelf = self;
            [self.view showNetworkErrorViewWithRefreshBlock:^{
                
                [weakSelf refreshData];
            }];
        }
    }
}

#pragma mark -
#pragma mark KVO

- (void)registKVO
{
    [self addObserver:self
           forKeyPath:@"AdActiveRuleCellHeight"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)unRegistKVO
{
    [self removeObserver:self
              forKeyPath:@"AdActiveRuleCellHeight"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"AdActiveRuleCellHeight"])
    {
        [self reloadHotSaleDataSource];
    }
}

#pragma mark - Delegate Method
-(void)setAdRowHeight:(CGFloat)height
{
    if ([AdActiveRuleCell canShowRuleCell:self.actRule])
    {
        self.AdActiveRuleCellHeight = height;
    }
    else
    {
        self.AdActiveRuleCellHeight = height+30;
    }
    
}

- (void)cellImageDidClicked:(DataProductBasic *)dto
{
//    DLog(@"here clicked");
    
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    controller.productType = EightBannerProduct;
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
}

@end

