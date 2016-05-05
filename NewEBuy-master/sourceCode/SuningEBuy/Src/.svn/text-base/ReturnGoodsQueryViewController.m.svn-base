//
//  ReturnGoodsQueryViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsQueryViewController.h"

#import "ReturnGoodsQueryCell.h"

#import "ReturnGoodsDetailViewController.h"

#import "NProOrderProductInfoCell.h"
#import "NProOrderListHeadCell.h"
#import "NProOrderLastCell.h"

@implementation ReturnGoodsQueryViewController

@synthesize returnGoodsQueryList = _returnGoodsQueryList;

@synthesize emptyLabel = _emptyLabel;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_returnGoodsQueryList);
    
    TT_RELEASE_SAFELY(_emptyLabel);
    TT_RELEASE_SAFELY(_alertImageV);

    SERVICE_RELEASE_SAFELY(service);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    self = [super init];
    if (self) {
        
        isRequestOK = NO;
        
        self.title = L(@"return order query");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];

        service = [[ReturnGoodsQueryService alloc]init];
        
        service.delegate = self;
        
        self.currentPage = 1;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(returnSuccess:)
                                                     name:RETURN_GOODS_OK_MESSAGE
                                                   object:nil];
    }
    return self;
}


- (void)loadView{
    
    [super loadView];
    
    
}

- (void)returnSuccess:(id)sender
{
    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:YES];
    
    UIView  *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height -92-10-10;
    
    self.groupTableView.frame = [self setViewFrame:self.hasNav WithTab:YES];
    
    self.groupTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.groupTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    self.tableView = self.groupTableView;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    self.selectRow = eReturnGoodsOrderList;

    if (!isRequestOK) {
        
        [self refreshData];
    }
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
}

- (void)viewDidUnload{
    
    [super viewDidUnload];
    
}

- (NSMutableArray *)returnGoodsQueryList{
    
    if (!_returnGoodsQueryList) {
        
        _returnGoodsQueryList = [[NSMutableArray alloc]init];
    }
    
    return  _returnGoodsQueryList;
}

- (UILabel *)emptyLabel{
    
    if (!_emptyLabel) {
        
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.alertImageV.bottom+15, 320, 60)];
        
        _emptyLabel.backgroundColor = [UIColor clearColor];
        
        _emptyLabel.textColor = [UIColor darkGrayColor];
        
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        
        _emptyLabel.hidden = YES;

    }
    return _emptyLabel;
}

- (UIImageView*)alertImageV
{
    if(!_alertImageV)
    {
        _alertImageV = [[UIImageView alloc] init];
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoOrder.png"];
        
        _alertImageV.frame = CGRectMake(116.5, self.view.frame.size.height/2-76-46, 77, 76);
        
        _alertImageV.hidden = YES;
        
    }
    
    return _alertImageV;
}

#pragma  mark table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self hasMore] && [self.returnGoodsQueryList count] == section) {
        
        return  1;
    }
    
    return 3;
//    if ([self hasMore]) {
//        
//        return [_returnGoodsQueryList count]+1;
//    }
//
//    return [_returnGoodsQueryList count];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self hasMore]) {
        
        return [_returnGoodsQueryList count]+1;
    }
    
    return [_returnGoodsQueryList count];
    
//    return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d-%d",indexPath.section,indexPath.row);
    if ([self hasMore] && [self.returnGoodsQueryList count] == indexPath.section) {
        
        return  48;
    }
    
    if(indexPath.row == 0)
    {
        return 40;
    }
    
    if(indexPath.row == 1)
    {
        return 110;
    }
    
    if(indexPath.row == 2)
    {
        ReturnGoodsQueryDTO *returnGoodsQueryDto = [self.returnGoodsQueryList objectAtIndex:indexPath.section];

        return [NProOrderLastCell setReturnGoodsQueryInfoHeight:returnGoodsQueryDto]+10;
//        return 50;
    }

    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self hasMore] && [self.returnGoodsQueryList count] == indexPath.section) {
        
        static NSString *orderListMoreIdentifier = @"OrderListMoreIdentifier";
        
        UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:orderListMoreIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderListMoreIdentifier];
            cell.title = L(@"loadMore");
            cell.animating = NO;
            cell.backgroundColor = [UIColor cellBackViewColor];
        }
        
        return cell;
        
    }
    else
    {
        ReturnGoodsQueryDTO *returnGoodsQueryDto = [self.returnGoodsQueryList objectAtIndex:indexPath.section];

        switch (indexPath.row) {
            case 0:
            {
                static NSString *headCell = @"ReturnGoodsListHeadCell-0";
                
                NProOrderListHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell];
                
                if (cell == nil) {
                    
                    cell = [[NProOrderListHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                }
                
                
                [cell setReturnGoodsQueryInfoCell:returnGoodsQueryDto];
                    
                
                return cell;
            }
                break;
                
            case 1:
            {
                static NSString *listCell = @"ReturnGoodsListHeadCell-1";
                
                NProOrderProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
                
                if (cell == nil) {
                    
                    cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
                    
                }
                
                
                [cell setReturnGoodsQueryCellInfo:returnGoodsQueryDto];
                    
                               
                cell.clipsToBounds = YES;
                
                
                return cell;

            }
                break;
                
            case 2:
            {
                
                static NSString *lastCell = @"ReturnGoodsListHeadCell";
                
                NProOrderLastCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCell];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCell];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [cell.payBtn addTarget:self action:@selector(submit:event:) forControlEvents:UIControlEventTouchUpInside];

                }
                
                self.returnGoodsDto = returnGoodsQueryDto;

                [cell setReturnGoodsQueryInfo:returnGoodsQueryDto];
                
                return cell;

            }
                break;
                
            default:
                break;
        }
        
    }
        
/*    static NSString *returnGoodsListIndentifier = @"ReturnGoodsListIndentifier";
   
    ReturnGoodsQueryCell *cell = (ReturnGoodsQueryCell *)[tableView dequeueReusableCellWithIdentifier:returnGoodsListIndentifier];
    
    if (cell == nil) {
        
        cell = [[ReturnGoodsQueryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsListIndentifier];
    }
    
    cell.returnGoodsQueryDto = [self.returnGoodsQueryList objectAtIndex:indexPath.row];
    [cell setCoolBgViewWithCellPosition:CellPositionMake([self hasMore]?[_returnGoodsQueryList count]+1:[_returnGoodsQueryList count], indexPath.row) hasLine:NO];
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"New_Arrow_right_btn.png"]];
    arrow.frame = CGRectMake(0, 0, 18/2, 29/2);
    cell.accessoryView = arrow;
    */
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self hasMore] && [self.returnGoodsQueryList count] == indexPath.section ) {
        
        [self  loadMoreData];
        
        return;
    }
    
    if(indexPath.row == 1)
    {
        ReturnGoodsDetailViewController *vc = [[ReturnGoodsDetailViewController alloc]init];
        
        vc.returnGoodsDto = [self.returnGoodsQueryList objectAtIndex:indexPath.section];
        vc.expressList = self.expressList;
        
        vc.hasNav = YES;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        TT_RELEASE_SAFELY(vc);
    }
    
   
}

- (ReturnGoodsQueryDTO*)returnGoodsDto
{
    if(!_returnGoodsDto)
    {
        _returnGoodsDto = [[ReturnGoodsQueryDTO alloc] init];
    }
    
    return _returnGoodsDto;
}

-(void)submit:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches ];
    
    UITouch *touch = [touches anyObject ];
    
    CGPoint currentTouchPosition = [touch locationInView:self.groupTableView];
    
    NSIndexPath *indexPath = [self.groupTableView indexPathForRowAtPoint : currentTouchPosition];
    ReturnGoodsQueryDTO *returnGoodsQueryDto = [self.returnGoodsQueryList objectAtIndex:indexPath.section];
    
    CShopChooseExpressListViewController *vc = [[CShopChooseExpressListViewController alloc]init];
    vc.queryDto =returnGoodsQueryDto;//self.returnGoodsDto;
    vc.expressList = self.expressList;
    vc.hasNav = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark ReturnGoodsQueryServiceDelegate

- (void)returnGoodsQueryHttpRequestCompletedWith:(BOOL)isSucess
                                  returnGoodList:(NSMutableArray *)list
                                        pageInfo:(SNPageInfo )pageInfo
                               returnexpresslist:(NSMutableArray *)expresslist
                                        errorMsg:(NSString*)errorMsg
{
    
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        
        [self refreshDataComplete];
    }else{
        
        [self loadMoreDataComplete];
    }
    
    if (isSucess == NO) {
        
        [self presentSheet:errorMsg?errorMsg:L(@"Sorry loading failed")];
    }
    else
    {
        isRequestOK = YES;
        
        if (self.isFromHead) {
            
            self.returnGoodsQueryList = list;
        }
        else{
            
            if (!_returnGoodsQueryList) {
                
                _returnGoodsQueryList = [[NSMutableArray alloc]init];
            }
            
            [self.returnGoodsQueryList addObjectsFromArray:list];
        }
        
        self.expressList = expresslist;
        
        self.totalPage = pageInfo.totalPage;
        
        self.totalCount = self.returnGoodsQueryList.count;
        
        if (self.currentPage < self.totalPage)
        {
            self.isLastPage = NO;
            self.currentPage++;
        }
        else
        {
            self.isLastPage = YES;
        }
        
        [self updateTable];
    }
}


- (void)updateTable{
    
    if (self.returnGoodsQueryList.count) {
        self.tableView.tableFooterView = nil;
        
        self.alertImageV.hidden = YES;
        self.emptyLabel.hidden = YES;
    }else{
        
        self.emptyLabel.hidden = NO;
        self.alertImageV.hidden = NO;
        
        self.emptyLabel.text = L(@"MyEBuy_NoReturnsOrder");//L(@"no returned goods history");
        
        [self.view addSubview:self.alertImageV];
//        [self.view addSubview:self.emptyLabel];
        [self.view addSubview:self.emptyLabel];
    }
    [self.tableView reloadData];
}


- (void)refreshData{
    
    [super refreshData];
    
    [self displayOverFlowActivityView];
    
    self.currentPage = 1;
    
    [service beginSendReturnGoodsQueryHttpRequest:self.currentPage];
    
}

- (void)loadMoreData{
    
    [super loadMoreData];
    
    [self displayOverFlowActivityView];
    
    [service beginSendReturnGoodsQueryHttpRequest:self.currentPage];
}

@end
