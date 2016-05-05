//
//  ReturnGoodsListViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsListViewController.h"
#import "ReturnGoodsQueryViewController.h"
#import "ReturnGoodsQueryViewController.h"
#import "ReturnGoodsSubmitViewController.h"
#import "ReturnGoodsListCell.h"
#import "ReturnGoodsSubmitViewController.h"
#import "CShopReturnApplicationViewController.h"
#import "OSChatViewController.h"
#import "OSGetStatusCommand.h"
#import "ReturnGoodsPartSubmitViewController.h"
#import "NProOrderProductInfoCell.h"

#import "MemberOrderDetailsDTO.h"

#define kTopSortViewFrame CGRectMake(0, 0, 320, 35)

@implementation ReturnGoodsListViewController

@synthesize returnGoodsList = _returnGoodsList;

@synthesize emptyLabel = _emptyLabel;

@synthesize prepareDto = _prepareDto;

@synthesize reasonList = _reasonList;

@synthesize service = _service;
@synthesize applianceService = _applianceService;
@synthesize cShopApplianceService = _cShopApplianceService;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_returnGoodsList);
    
    TT_RELEASE_SAFELY(_emptyLabel);
    
    TT_RELEASE_SAFELY(_prepareDto);
    
    TT_RELEASE_SAFELY(_reasonList);
    TT_RELEASE_SAFELY(_proList);
    TT_RELEASE_SAFELY(_headList);

    SERVICE_RELEASE_SAFELY(_service);
//    _segment.delegate = nil;
    
    SERVICE_RELEASE_SAFELY(_applianceService);
    SERVICE_RELEASE_SAFELY(_cShopApplianceService);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [CommandManage cancelCommandByClass:[OSGetStatusCommand class]];
}

- (id)init
{
    
    self = [super init];
    
    if (self) {
        self.checkRow = -1;

        self.title = L(@"MyEBuy_SelectReturnGoods");//L( @"return orderList");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
        UIButton *nextBtn = [[UIButton alloc] init];
        
        [nextBtn setTitle:L(@"MyEBuy_NextStep") forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"button_orange_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [nextBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        [nextBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_click.png"]
                           forState:UIControlStateHighlighted];
        
//        [nextBtn addTarget:self action:@selector(refundAction:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.frame = CGRectMake(0, 0, 57, 35);
        //    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
        
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"MyEBuy_NextStep")];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"return order query")];
        
        isRequestOK = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(returnSuccess:)
                                                     name:RETURN_GOODS_OK_MESSAGE
                                                   object:nil];
    }
    return self;
}

- (void)righBarClick
{
    
    MemberOrderDetailsDTO *dto = [[MemberOrderDetailsDTO alloc] init];
    
    if([self.proList count] > self.checkRow)
    {
        dto = [self.proList safeObjectAtIndex:self.checkRow ];
    }
    
    
    [self displayOverFlowActivityView];
    
//    ReturnGoodsSubmitViewController *vc = [[ReturnGoodsSubmitViewController alloc] init];
//    
//    vc.productCode = dto.partNumber;

    self.returnRow = self.checkRow;
    
    self.proCode = dto.productCode;
    self.proPrice = dto.totalProduct;
    
    MemberOrderNamesDTO *nameDto = [self.headList safeObjectAtIndex:0];
    
    dto.orderId = nameDto.orderId;

    self.payWay = nameDto.policyDesc?nameDto.policyDesc:@"";
    
    if(!IsStrEmpty(nameDto.supplierCode))
    {
        [self.cShopApplianceService CShopBeginSendReturnGoodsApplicationHttpRequest:dto];
        
    }
    else
    {
        
        [self.applianceService beginSendReturnGoodsApplicationHttpRequest:dto];
        
    }
//    [self goToQuery:nil];
}

//开始查询最近退货列表
- (void)goToQuery:(id)sender
{
    ReturnGoodsQueryViewController *vc = [[ReturnGoodsQueryViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    TT_RELEASE_SAFELY(vc);
}

//收到退货成功的通知，刷新页面
- (void)returnSuccess:(NSNotification *)notification
{
    
    if([self.proList count] > self.returnRow)
    {
        [self.proList removeObjectAtIndex:self.returnRow];

    }
    if([self.proList count] > self.checkRow)
    {
        
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    
    [self updateTable];
//    [self refreshData];
    
}


- (void)loadView
{
    [super loadView];
    
   

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    //    [self.view addSubview:self.segment];
    
    if(IOS7_OR_LATER)
    {
        frame.origin.y-=20;//self.segment.height;
        frame.size.height+=20;//self.segment.height;
    }
    else
    {
        
    }
    
    self.groupTableView.frame = frame;
    
    
    
    self.tableView = self.groupTableView;
    //    [self.tableView addSubview:self.refreshHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    frame.size.height+=92;
    self.hotKeywordsController.view.frame = frame;
    
    [self.view addSubview:self.tableView];
    
    [self.hotKeywordsController willMoveToParentViewController:self];
    [self addChildViewController:self.hotKeywordsController];
    [self.view addSubview:self.hotKeywordsController.view];
    [self.hotKeywordsController didMoveToParentViewController:self];
    self.hotKeywordsController.view.hidden = YES;
    if([self.proList count] > self.checkRow)
    {

    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;

    }
    
    [self updateTable];

//    if (!isRequestOK) {
//        
//        [self refreshData];
//    }
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
}

- (void)viewDidUnload{
    
    [super viewDidUnload];
}

//- (CShopReturngoodsSegementView *)topSortView
//{
//    if (!_topSortView) {
//        _topSortView = [[CShopReturngoodsSegementView alloc] initWithFrame:kTopSortViewFrame];
//        _topSortView.delegate = self;
//    }
//    return _topSortView;
//}

- (ReturnGoodsQueryViewController *)hotKeywordsController{
    if (!_hotKeywordsController) {
        _hotKeywordsController = [[ReturnGoodsQueryViewController alloc] init];
        
        _hotKeywordsController.view.backgroundColor = RGBCOLOR(240, 238, 222);
        
    }
    return _hotKeywordsController;
}
/*
//- (CustomSegment *)segment
//{
//    if (!_segment)
//    {
//        _segment = [[CustomSegment alloc] init];
//        _segment.delegate = self;
//        [_segment setItems:@[@"申请退货", @"退货查询"]];
//        
//    }
//    return _segment;
//}
//
//#pragma mark - Custom Controls
//
//- (void)setSegmentIndex:(NSInteger)index
//{
//    if (index < 3 && index >= 0)
//    {
//        self.segment.currentIndex = index;
//    }
//}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    [self removeOverFlowActivityView];
    if (index == 0)
    {
       
        self.hotKeywordsController.view.hidden = YES;
    
    }
    else 
    {
        self.hotKeywordsController.view.hidden = NO;
    }
}
*/
- (UILabel *)emptyLabel{
    
    if (!_emptyLabel) {
        
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
        
        _emptyLabel.backgroundColor = [UIColor clearColor];
        
        _emptyLabel.textColor = [UIColor darkGrayColor];
        
        _emptyLabel.textAlignment = UITextAlignmentCenter;
    }
    
    return _emptyLabel;
}

- (NSMutableArray*)proList
{
    if(!_proList)
    {
        _proList = [[NSMutableArray alloc] init];
    }
    
    return _proList;
}

#pragma mark  returnGoodsListServiceDelegate

- (ReturnGoodsListService *)service
{
    if (!_service) {
        _service = [[ReturnGoodsListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}
/*
- (void)returnGoodsListRequestCompletedWith:(BOOL)isSuccess
                             retunGoodsList:(NSArray *)list
                                   pageInfo:(SNPageInfo *)pageInfo
                                  errrorMsg:(NSString *)errrorMsg
{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        isRequestOK = YES;
        
        if (self.isFromHead)
        {
            [self refreshDataComplete];
            self.returnGoodsList = [NSMutableArray arrayWithArray:list];
        }
        else
        {
            [self loadMoreDataComplete];
            if (!_returnGoodsList)
            {
                self.returnGoodsList = [NSMutableArray arrayWithArray:list];
            }
            else
            {
                [self.returnGoodsList addObjectsFromArray:list];
            }
        }
        
        self.totalCount = [self.returnGoodsList count];
        self.totalPage = pageInfo->totalPage;
        self.currentPage = pageInfo->currentPage;
        
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
    else
    {
        [self presentSheet:errrorMsg];
    }
}*/

- (void)updateTable
{
    if ([self.proList count] == 0)
    {
        self.emptyLabel.text = L(@"you have no product to operate");
        self.tableView.tableFooterView = self.emptyLabel;
    }
    else
    {
        self.tableView.tableFooterView = nil;
    }

//    if (isRequestOK && [self.returnGoodsList count] == 0)
//    {
//        self.emptyLabel.text = L(@"you have no product to operate");
//        self.tableView.tableFooterView = self.emptyLabel;
//    }
//    else
//    {
//        self.tableView.tableFooterView = nil;
//    }
    
    [self.tableView reloadData];
}

- (NSArray*)headList
{
    if(!_headList)
    {
        _headList = [[NSArray alloc] init];
    }
    
    return _headList;
}

#pragma mark table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if ([self hasMore]) {
//        
//        return [self.proList count] +1;
//    }
    
    return [self.proList count];

//    if ([self hasMore]) {
//        
//        return [self.returnGoodsList count] +1;
//    }
//    
//    return [self.returnGoodsList count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([self hasMore] && [self.returnGoodsList count] == indexPath.row) {
//        
//        return 48;
//    }
//    if ([self hasMore] && [self.proList count] == indexPath.row) {
//        
//        return 48;
//    }

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self hasMore] && [self.proList count] == indexPath.row) {
//        
//        static NSString *moreIndentifier = @"moreIndentifier";
//        
//        UITableViewMoreCell *cell = (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:moreIndentifier];
//        
//        if (cell == nil) {
//            
//            UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreIndentifier];
//            cell.backgroundColor = [UIColor cellBackViewColor];
//            cell.title =  L(@"Get More...");
//            
//            cell.animating = NO;
//            
//            return cell;
//        }
//        [cell setCoolBgViewWithCellPosition:CellPositionBottom hasLine:NO];
//        cell.animating = NO;
//        
//        return cell;
//    }
    
    static  NSString  *returnGoodsListIdentifier = @"returnGoodsListIdentifier";
    
    NProOrderProductInfoCell *cell = (NProOrderProductInfoCell *)[tableView dequeueReusableCellWithIdentifier:returnGoodsListIdentifier];
    
    if (cell == nil) {
        
        cell = [[NProOrderProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsListIdentifier];
       

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    MemberOrderDetailsDTO *dto = [self.proList safeObjectAtIndex:indexPath.row];
    MemberOrderNamesDTO *nameDto = [self.headList safeObjectAtIndex:0];
  
    dto.supplierCode = nameDto.supplierCode;
    dto.cShopName = nameDto.cShopName;
    
    if(self.checkRow  == indexPath.row)
    {
        [cell setOrderReturnGoodsCellInfo:dto WithBtnSelect:YES];
        self.navigationItem.rightBarButtonItem.enabled = YES;

    }
    else
    {
        [cell setOrderReturnGoodsCellInfo:dto WithBtnSelect:NO];

    }

    return cell;
}


//1.加载更多
//2.获取商品退货申请准备数据

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if ([self hasMore] && [self.proList count] == indexPath.row){
//        
//        [self loadMoreData];
//        
//        return;
//        
//    }else{

        self.checkRow = indexPath.row;
        
        [self.tableView reloadData];
 /*       ReturnGoodsListDTO *dto = [self.returnGoodsList objectAtIndex:indexPath.row];
        
        [self displayOverFlowActivityView];
        
        ReturnGoodsSubmitViewController *vc = [[ReturnGoodsSubmitViewController alloc] init];
        
        vc.productCode = dto.partNumber;
        
        if([dto.cshopFlag isEqualToString:@"1"])
        {
            [self.cShopApplianceService CShopBeginSendReturnGoodsApplicationHttpRequest:dto];
            
        }
        else
        {
            
            [self.applianceService beginSendReturnGoodsApplicationHttpRequest:dto];
            
        }
        */
//    }
    
}

#pragma mark - ReturnGoodsApplianceServiceDelegate

- (ReturnGoodsApplicationService *)applianceService
{
    if (!_applianceService) {
        _applianceService = [[ReturnGoodsApplicationService alloc] init];
        _applianceService.delegate = self;
    }
    return _applianceService;
}

- (CShopReturnApplicationService *)cShopApplianceService
{
    if (!_cShopApplianceService) {
        _cShopApplianceService = [[CShopReturnApplicationService alloc] init];
        _cShopApplianceService.delegate = self;
    }
    return _cShopApplianceService;
}

- (void)returnGoodsApplicationRequestCompletedWithResult:(BOOL)isSuccess
                                              reasonList:(NSMutableArray *)reasonList
                                  returnGoodsPreparedDto:(ReturnGoodsPrepareDTO*) dto
                                                errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        self.reasonList = reasonList;
        
        self.prepareDto = dto;
        
        if (self.prepareDto == nil) {
            
            [self presentCustomDlg:L(@"this product can't be returned")];
            
            return ;
        }
        
        //接在线客服
        if ([self.prepareDto.needTOOnline isEqualToString:@"1"])
        {
            //先检查客服是否在线
            [self displayOverFlowActivityView];
            __weak ReturnGoodsListViewController *weakSelf = self;
            OSGetStatusCommand *command = [[OSGetStatusCommand alloc] initAsB2CReturnOrderWithOrderNo:self.prepareDto.orderId];
            [CommandManage excuteCommand:command completeBlock:^(id<Command> cmd) {
                
                ReturnGoodsListViewController *self = weakSelf;
                [self removeOverFlowActivityView];
                
                OSGetStatusCommand *cmd_ = (OSGetStatusCommand *)cmd;
                if (cmd_.onlineStatus == 1)
                {
                    //在线
                    OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CReturnOrderWithOrderNo:self.prepareDto.orderId];
                    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
                    [self presentModalViewController:nav animated:YES];
                }
                else
                {
                    //不在线或者系统异常等
                    [self presentSheet:kOSChatServerErrorMsg];
                }
                
            }];
            
            return;
        }
        
        //节能补贴商品申请退货
        if ([self.prepareDto.errorCode isEqualToString:@""] ||
            IsNilOrNull(self.prepareDto.errorCode))
        {
            if ([self.prepareDto.text isEqualToString:@"energySavingView"]) {
                
                BBAlertView *alertView = [[BBAlertView alloc]
                                          initWithTitle:L(@"Tips")
                                          message:L(@"energySaving tips")
                                          delegate:self
                                          cancelButtonTitle:L(@"cancel")
                                          otherButtonTitles:L(@"OK")];
                
                alertView.tag = 11;
                
                [alertView show];
                
                TT_RELEASE_SAFELY( alertView);
            }else
            {
                if ([self.prepareDto.payFlag  isEqualToString:@"2"]) {
                    
                    [self presentSheet:L(@"mobilePhone can't be paid by group")];
                    
                    return;
                }
                
                if ([self.prepareDto.returncard isEqualToString:@"1"]) {
                    
                    [self presentSheet:L(@"this product can't be paid by mobilePhone")];
                    
                    return;
                }
                
                if (!self.prepareDto.orderId.length)
                {
                    [self presentSheet:L(@"this product can't be returned")];

                }
                else
                {
                    
                    
                    ReturnGoodsSubmitViewController *vc = [[ReturnGoodsSubmitViewController alloc]init];
                    
                    
                    vc.headList = self.headList;
                    vc.prepareDto = dto;
                    vc.productCode = self.proCode;
                    vc.proPrice = self.proPrice;
                    vc.hasNav = YES;
                    vc.isCShopProduct = self.isCShopProduct;
                    
                    NSString *returnViewType = nil;
                    if ([self.distribution eq:@"自提"] && [dto.unreasonableReturnFlag eq:@"1"]) {
                        returnViewType = @"1";
                        [reasonList insertObject:@"服务原因>无理由退换货" atIndex:0];
                        [reasonList insertObject:@"315" atIndex:0];
                        vc.reasonDes = @"服务原因>无理由退换货";
                        vc.reasonId = @"315";
                    }
                    else if ([self.distribution eq:@"配送"] && [dto.unreasonableReturnFlag eq:@"1"])
                    {
                        returnViewType = @"2";
                        [reasonList insertObject:@"服务原因>无理由退换货" atIndex:0];
                        [reasonList insertObject:@"315" atIndex:0];
                        vc.reasonDes = @"服务原因>无理由退换货";
                        vc.reasonId = @"315";
                        
                    }
                    else
                    {
                        returnViewType = @"0";
                        vc.reasonDes = @"";
                        vc.reasonId = @"";
                    }
                    vc.returnType = returnViewType;
                    //                    //-临时
                    //vc.returnType = @"1";
                    //                    //-------------------------------
                    vc.reasonList = reasonList;
                    vc.distribution  = self.distribution;
                    vc.taxType = self.taxType;
                    vc.shopAddress = self.shopAddress;
                    
                    vc.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    TT_RELEASE_SAFELY(vc);
                }
                
                
            }
        }
        
        else{
            
            if ([self.prepareDto.errorCode hasPrefix:@"CMN"]) {
                
                [self presentSheet:L(@"Server used fault")];
                
                return;
            }
            
            [self presentSheet:!IsStrEmpty(self.prepareDto.errorCode)?L(self.prepareDto.errorCode):L(@"Server used fault")];
            
            return;
        }
    }else{
        [self presentSheet:!IsStrEmpty(self.applianceService.errorMsg)?self.applianceService.errorMsg:L(@"Server used fault")];
    }
    
}

- (void)CShopReturnGoodsApplicationRequestCompletedWithResult:(BOOL)isSuccess reasonList:(NSMutableArray *)reasonList returnGoodsPreparedDto:(ReturnGoodsPrepareDTO*) dto errorMsg:(NSString *)errorMsg;
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        
        self.reasonList = reasonList;
        
        self.prepareDto = dto;
        
        if (self.prepareDto == nil) {
            
            [self presentCustomDlg:L(@"this product can't be returned")];
            
            return ;
        }
        
        //节能补贴商品申请退货
        if ([self.prepareDto.errorCode isEqualToString:@""] ||
            IsNilOrNull(self.prepareDto.errorCode))
        {
            if ([self.prepareDto.text isEqualToString:@"energySavingView"]) {
                
                BBAlertView *alertView = [[BBAlertView alloc]
                                          initWithTitle:L(@"Tips")
                                          message:L(@"energySaving tips")
                                          delegate:self
                                          cancelButtonTitle:L(@"cancel")
                                          otherButtonTitles:L(@"OK")];
                
                alertView.tag = 11;
                
                [alertView show];
                
                TT_RELEASE_SAFELY( alertView);
            }else
            {
                if ([self.prepareDto.payFlag  isEqualToString:@"2"]) {
                    
                    [self presentSheet:L(@"mobilePhone can't be paid by group")];
                    
                    return;
                }
                
                if ([self.prepareDto.returncard isEqualToString:@"1"]) {
                    
                    [self presentSheet:L(@"this product can't be paid by mobilePhone")];
                    
                    return;
                }
                
                if (!self.prepareDto.orderId.length)
                {
                    [self presentSheet:L(@"this product can't be returned")];
                    
                }
                else
                {
                    CShopReturnApplicationViewController *vc = [[CShopReturnApplicationViewController alloc]init];
                    
                    vc.reasonList = reasonList;
                    
                    vc.prepareDto = dto;
                    
                    vc.proPrice = self.proPrice;
                    vc.productCode = self.proCode;
                    vc.payWay = self.payWay;
                    
                    vc.hasNav = YES;
                    vc.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    TT_RELEASE_SAFELY(vc);
                }
                
                
            }
        }
        
        else{
            
            if ([self.prepareDto.errorCode hasPrefix:@"CMN"]) {
                
                [self presentSheet:L(@"Server used fault")];
                
                return;
            }
            
            [self presentSheet:!IsStrEmpty(self.prepareDto.errorCode)?L(self.prepareDto.errorCode):L(@"Server used fault")];
            
            return;
        }
    }else{
        [self presentSheet:!IsStrEmpty(self.cShopApplianceService.errorMsg)?self.cShopApplianceService.errorMsg:L(@"Server used fault")];
    }
    
}


#pragma alertViewMessage delegate

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11 && buttonIndex == 1) {
        
        ReturnGoodsSubmitViewController *vc = [[ReturnGoodsSubmitViewController alloc]init];
        
        vc.reasonList = self.reasonList;

        vc.headList = self.headList;
        vc.prepareDto = self.prepareDto;
        vc.productCode = self.proCode;
        vc.proPrice = self.proPrice;
        vc.hasNav = YES;
        vc.isCShopProduct = self.isCShopProduct;

        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        TT_RELEASE_SAFELY(vc);
    }
}


#pragma mark -
#pragma mark 下拉以及加载更多
/*
- (void)refreshData{
    
    [super refreshData];
    
//    [self displayOverFlowActivityView];    
//    self.currentPage = 1;
//    
//    [[self service] beginSendReturnGoodsListHttpRequest:self.currentPage];
}

- (void)loadMoreData{
    
    [super loadMoreData];
    
//    [self displayOverFlowActivityView];
//    
//    [[self service] beginSendReturnGoodsListHttpRequest:self.currentPage];
}
*/

#pragma mark - Method not implemented in protocol

- (void)returnGoodsBtnPressed:(ButtonGoods)btnIndex {}

@end
