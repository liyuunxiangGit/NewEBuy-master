//
//  MyFavoriteViewController.m
//  SuningEBuy
//
//  Created by huangtf on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyFavoriteViewController.h"
#import "MyFavoriteCell.h"
#import "ProductDetailViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ReceiveInfoViewController.h"
#import "ShopCartV2ViewController.h"
#import "BuyNowCommand.h"

@implementation MyFavoriteViewController
@synthesize bookmarkList                    =_bookmarkList;
@synthesize deletedIndexPath                =_deletedIndexPath;
@synthesize myFavoriteService               = _myFavoriteService;
@synthesize isBookMarkLoaded;

@synthesize cartService                     = _cartService;
@synthesize detailService                   = _detailService;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_bookmarkList);
    
    TT_RELEASE_SAFELY(_deletedIndexPath);
    
    TT_RELEASE_SAFELY(_productDetailDto);
    
    [CommandManage cancelCommandByClass:[BuyNowCommand class]];
}


-(id)init
{
    self=[super init];
    if (self) 
    {
        self.title=L(@"MyEBuy_MyCollection");
        self.currentPage=1;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];

        //添加购物车代理
        self.hidesBottomBarWhenPushed = YES;
        
        if (!_bookmarkList)
        {
            _bookmarkList=[[NSMutableArray alloc] init];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOK) name:LOGIN_OK_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutOK) name:LOGOUT_OK_NOTIFICATION object:nil];
        
        self.iOS7FullScreenLayout = YES;
        [self.view addGestureRecognizer:self.swipeRight];
        self.swipeRight.enabled=YES;

        self.bSupportPanUI = NO;
    }
    
    return self;

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)HttpRelease
{
    SERVICE_RELEASE_SAFELY(_myFavoriteService);
    SERVICE_RELEASE_SAFELY(_detailService);
    SERVICE_RELEASE_SAFELY(_cartService);
}

- (UISwipeGestureRecognizer *)swipeRight
{
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        _swipeRight.delegate = self;
    }
    return _swipeRight;
}


-(void)loadView
{
    [super loadView];

    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];
    
    self.hasSuspendButton = YES;
}

- (MyFavoriteService *)myFavoriteService
{
    if (!_myFavoriteService) {
        _myFavoriteService = [[MyFavoriteService alloc] init];
        _myFavoriteService.delegate = self;
    }
    return _myFavoriteService;
}

- (ProductDetailService *)detailService
{
    if (!_detailService) {
        _detailService = [[ProductDetailService alloc] init];
        _detailService.delegate = self;
    }
    return _detailService;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isBookMarkLoaded) 
    {
        [self refreshData];
    }
}

- (void)loginOutOK
{
    isBookMarkLoaded = NO;
}

-(void)loginOK
{
    isBookMarkLoaded = NO;
}


#pragma mark -
#pragma mark Table View Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.totalCount == indexPath.row) 
    {
        return 48;
    }
    return [MyFavoriteCell height:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore]) {
        return [_bookmarkList count] + 1;
    }
    return [_bookmarkList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if ([self hasMore] && row == self.totalCount) 
    {
        static NSString *myFavoriteMoreIdentifier = @"myFavoriteMoreIdentifier";
        
        UITableViewMoreCell *cell = (UITableViewMoreCell *) [tableView dequeueReusableCellWithIdentifier:myFavoriteMoreIdentifier];
        if (cell == nil) 
        {
            cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myFavoriteMoreIdentifier];
            cell.title=@"get more...";
            cell.animating = NO;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        cell.animating = NO;
        return cell;
    }
    
    static NSString *myFavoriteCellIdentifier = @"myFavoriteCellIdentifier";

    MyFavoriteCell *cell = (MyFavoriteCell *) [tableView dequeueReusableCellWithIdentifier:myFavoriteCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[MyFavoriteCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myFavoriteCellIdentifier]; 

//        [cell.addToShopCartBtn addTarget:self action:@selector(addToShoppingCart: event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    DataProductBasic *dto = [self.bookmarkList objectAtIndex:indexPath.row];
    
    cell.item = dto;
    
    return cell;
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
    DataProductBasic *dto = [self.bookmarkList objectAtIndex:row];
    dto.cityCode = [Config currentConfig].defaultCity;
    dto.shopName = dto.vendorName;
    dto.shopCode = dto.vendorCode;
	ProductDetailViewController *_ProductViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];	
	
    _ProductViewController.collectFlag = @"1";
    
	[self.navigationController pushViewController:_ProductViewController animated:YES];
    
	TT_RELEASE_SAFELY(_ProductViewController);
	
}

// 确认删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if ([self hasMore] && row == self.totalCount)
        return;
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        self.deletedIndexPath = indexPath;
        
        DataProductBasic *dto = [self.bookmarkList objectAtIndex:self.deletedIndexPath.row];
        if ([self checkUserLoginOrNot])
        {
            [self displayOverFlowActivityView];
            [self.myFavoriteService beginDeleteMyFavoriteList:dto];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self hasMore] && self.totalCount == indexPath.row) {
//        return NO;
//    }
    return YES;
}


#pragma mark -
#pragma mark 书签请求
    
- (void)getMyFavoriteCompletionWith:(BOOL)isSuccess 
                           errorMsg:(NSString *)errorMsg 
                       favoriteList:(NSArray *)list 
                          totalPage:(NSInteger)tPage 
                        currentPage:(NSInteger)currPage
{
    
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if (isSuccess) {
        isBookMarkLoaded = YES;
        if (self.isFromHead) {
            self.bookmarkList = [NSMutableArray arrayWithArray:list];
        }else{
            [self.bookmarkList addObjectsFromArray:list];
        }
        self.totalCount = self.bookmarkList.count;
        self.totalPage = tPage;
        self.currentPage = currPage;
        
        if (self.currentPage < self.totalPage)
        {
            self.currentPage++;
            
            self.isLastPage = NO;
        }
        else 
        {
            self.isLastPage = YES;            
        }
        [self.tableView reloadData];
        
        if ([self.bookmarkList count] == 0)
        {
            [self presentSheet:L(@"PVDontCollectAnyGoods")];
        }
        
    }else{
//        if (!IsArrEmpty(self.bookmarkList)) {
//            [self.bookmarkList removeAllObjects];
//        }
//        self.isLastPage = YES;
//        [self.tableView reloadData];
        [self presentSheet:errorMsg];
    }

}
 
- (void)getDeleteMyFavoriteCompletionWith:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    
    if (isSuccess) {
        if (self.deletedIndexPath)
            [self.bookmarkList removeObjectAtIndex:self.deletedIndexPath.row];
        
        self.totalCount = [self.bookmarkList count];
        
        [self.tableView reloadData];
        [self removeOverFlowActivityView];
        
        [self refreshData];
        
    }else{
        [self.tableView reloadData];
        [self removeOverFlowActivityView];
        if ([errorMsg isEqualToString:@"0"]) {
            [self presentSheet:L(@"PVDeleteFailedAndDontCollectAnyGoods")];
            
        }
        else{
            [self presentSheet:L(@"PVDeleteFailed")];
        }
    }
}

// 删除成功
- (void)updateBookMark
{
    // 刷新收藏列表
}

#pragma mark -
#pragma mark Refresh And Load More
- (void)refreshData
{
    
    [super refreshData];
    
    self.currentPage = 1;
        
    NSString *pageNum = [NSString stringWithFormat:@"%d", self.currentPage];
    
    if ([self checkUserLoginOrNot]) {
        
        [self displayOverFlowActivityView];
        
        [self.myFavoriteService beginGetMyFavoriteListWithPageNum:pageNum withListsize:@"20"];
    }
}

- (void)loadMoreData
{
    
    [super loadMoreData];
        
    NSString *pageNum = [NSString stringWithFormat:@"%d", self.currentPage];
    
    if ([self checkUserLoginOrNot]) {
        
        [self displayOverFlowActivityView];
        
        [self.myFavoriteService beginGetMyFavoriteListWithPageNum:pageNum withListsize:@"20"];
    }
}


- (BOOL)checkUserLoginOrNot{
    
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        loginViewController.loginDelegate = self;
        loginViewController.loginDidCancelSelector = @selector(loginCancel);
        
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:loginViewController];
        
        [self presentModalViewController:userNav animated:YES];
        
        TT_RELEASE_SAFELY(loginViewController);
        TT_RELEASE_SAFELY(userNav);
        return NO;
    }
}

- (void)loginCancel
{
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
}


//add to ShopCart
- (void)addToShoppingCart:(id)sender event:(id)event
{
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath != nil) {
        
        DataProductBasic *productDetailDTO = [self.bookmarkList objectAtIndex:indexPath.row];
                
        if (([productDetailDTO.cityCode isEqualToString:@""]) ||
            (nil == productDetailDTO.cityCode))
        {
            productDetailDTO.cityCode = [[Config currentConfig] defaultCity];
        }
        [self displayOverFlowActivityView];
        
        [self.detailService beginGetProductDetailInfo:productDetailDTO];
    }
}

- (ShopCartV2Service *)cartService
{
    if (!_cartService) {
        _cartService = [[ShopCartV2Service alloc] init];
        _cartService.delegate = self;
    }
    return _cartService;
}


- (void)service:(ShopCartV2Service *)service orderCheckOutComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        //       返回修改
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
        barButtonItem.title = L(@"BTBack");
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        // 导航到去结算页面
        ReceiveInfoViewController *receiveViewController = [[ReceiveInfoViewController alloc] init];
        
        ShopCartV2DTO *dto = [ShopCartV2DTO shopCartV2DTOFromProduct:_productDetailDto];
        NSMutableArray *array = [NSMutableArray arrayWithObject:dto];
        
        receiveViewController.powerFlag = _productDetailDto.powerFlgOrAmt;
//        receiveViewController.productList = array;  // 产品列表
        [receiveViewController calculateProduct:array];
        //刘坤5-28默认城市
        receiveViewController.deliveryCityCode = _productDetailDto.cityCode;
        receiveViewController.currentCityCode = _productDetailDto.cityCode;
        
        double price = [dto totalPrice];
        receiveViewController.totalPriceStr = [NSString stringWithFormat:@"￥%0.2f",price];
        receiveViewController.shouldPayPrice = [NSString stringWithFormat:@"￥%0.2f",price];
        
        receiveViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: receiveViewController animated:YES];
        
        TT_RELEASE_SAFELY(receiveViewController);
    }
    else
    {
        if ([service.exceptionList count] > 0)
        {
            ShopCartV2DTO *dto = [service errorItemFromExceptionList:service.exceptionList];
            NSString *errorMsg = dto.errorDesc.length > 0?dto.errorDesc:L(@"System_Abnomal_Try_later");
            [self presentSheet:errorMsg];
        }
        else
        {
            NSString *error = service.errorMsg ? service.errorMsg : L(@"System_Abnomal_Try_later");
            [self presentSheet:error];
        }
    }
}


/*
 检测商品有效性
 */
- (BOOL)checkProcutDTO:(DataProductBasic *)item
{
    if (!item || !item.cityCode || [item.cityCode isEmptyOrWhitespace] ||
        !item.productName || [item.productName isEmptyOrWhitespace] ||
        !item.productImageURL || !item.price)
    {
        return NO;
    }
    
    return YES;
}


#pragma mark -
#pragma mark service delegate

- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg productDetail:(DataProductBasic *)product
{
    if (isSuccess)
    {
        
        _productDetailDto = product;
        
        BuyNowCommand *command = [BuyNowCommand command];
        command.product = _productDetailDto;
        command.sController = self;
        [CommandManage excuteCommand:command completeBlock:nil];
    }
    else
    {
        [self removeOverFlowActivityView];
        
        [self presentSheet:errorMsg?errorMsg:L(@"PVBuyNowFailedAndTryAgainLater")];
    }
}




@end

