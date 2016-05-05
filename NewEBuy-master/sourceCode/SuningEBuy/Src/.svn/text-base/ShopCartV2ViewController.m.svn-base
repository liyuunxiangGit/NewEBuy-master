//
//  ShopCartV2ViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartV2ViewController.h"
#import "ReceiveInfoViewController.h"

#import "ShopCartItemCell.h"
#import "MyFavoriteViewController.h"
#import "ProductDetailViewController.h"
#import "Reachability.h"
#import "SNGraphics.h"
#import "ShopCartShopHeaderView.h"
#import "ShopCartTitleView.h"
#import "ShopCartDeleteView.h"
#import "JASidePanelController.h"

#import "ScreenShotNavViewController.h"
#import "ShopCartPromotionView.h"
#import "SuNingSellDao.h"//销售来源数据库

#import "SNWebViewController.h"


@interface ShopCartV2ViewController () <ShopCartShopHeaderViewDelegate,MyFavoriteServiceDelegate,ProductDetailServiceDelegate,AddressInfoPickerViewDelegate,ToolBarCellDelegate>
{
    //是否为全选
    BOOL    isSelectAll;
    
    NSArray *_dataSourceArray;
    
    //是否为编辑状态
    BOOL    isExpands;
}

//无商品时的view
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, strong) ShopCartTitleView *titleView;

@property (nonatomic, strong) ShopCartDeleteView *deleteView;

@property (nonatomic, strong) ShopCartPromotionView *promotionView;

@property (nonatomic, strong) AddressInfoPickerView *addressPickerView;

@property (nonatomic, assign) BOOL    isFirstLoaded;

//是否勾选了某个商品或店铺或全选
@property (nonatomic, assign) BOOL    isSelectAnyProduct;

@end

static ShopCartLogic *_sharedLogic;

@implementation ShopCartV2ViewController

@synthesize syncManager = _syncManager;
@synthesize logic = _logic;

- (void)dealloc
{
    if (_logic) {
        [_logic removeObserver:self forKeyPath:@"cityCode"];
    }
    SERVICE_RELEASE_SAFELY(_cartService);
    SERVICE_RELEASE_SAFELY(_pDetailService);
    SERVICE_RELEASE_SAFELY(_myFavorateService);
}

+ (ShopCartV2ViewController *)sharedShopCart
{
    static ShopCartV2ViewController *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[ShopCartV2ViewController alloc] init];
    });
    return __instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.isNeedBackItem = NO;
        
        self.hasNav = YES;
        
        self.title = L(@"shopCart");
        
        self.pageTitle = L(@"shopProcess_shop_shopCart");
        
        self.bSupportPanUI = NO;
        
        isExpands = NO;
        
        self.isSelectAnyProduct = NO;
        
        self.isFirstLoaded = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(finishShopping:)
                                                     name:CART_CLEAN_MESSAGE
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginOK:)
                                                     name:LOGIN_OK_MESSAGE
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(autoLoginOK:)
                                                     name:AUTOLOGIN_OK_MESSAGE
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(logOutOK:)
                                                     name:LOGOUT_OK_NOTIFICATION
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSessionFailure:)
                                                     name:LOGIN_SESSION_FAILURE
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkStatusDidChange:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cityDidChange:)
                                                     name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                   object:nil];
        self.logic = [ShopCartLogic cachedLogic];
        [self refreshShopCartView];
    }
    return self;
}

- (ShopCartV2Service *)cartService
{
    if (!_cartService) {
        _cartService = [[ShopCartV2Service alloc] init];
        _cartService.delegate = self;
    }
    return _cartService;
}

- (ProductDetailService *)pDetailService
{
    if (!_pDetailService) {
        _pDetailService = [[ProductDetailService alloc] init];
        _pDetailService.delegate = self;
    }
    return _pDetailService;
}

- (MyFavoriteService *)myFavorateService{
    if (!_myFavorateService) {
        _myFavorateService = [[MyFavoriteService alloc] init];
        _myFavorateService.delegate = self;
    }
    return _myFavorateService;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat titleViewHeigt = self.titleView.height;
    
	CGRect frame = self.view.bounds;
    self.titleView.bottom = frame.size.height;
    self.titleView.hidden = YES;
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    
    self.deleteView.top = frame.size.height;
    self.deleteView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;

	self.tpTableView.frame = frame;
    self.tpTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tpTableView.contentInset = UIEdgeInsetsMake(0, 0, titleViewHeigt, 0);
//    self.tpTableView->_priorInset = self.tpTableView.contentInset;
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tpTableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	[self.view addSubview:self.tpTableView];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.deleteView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    if (NotNilAndNull(_sharedLogic)) {
        self.logic = _sharedLogic;
    }
    if (self.logic.isEmpty && [UserCenter defaultCenter].isLogined) {
        [self displayOverFlowActivityView:L(@"Loading, please wait...")];
    }
    [self refreshShopCartView];
    [self.syncManager query];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _sharedLogic = self.logic;
    [ShopCartV2ViewController sharedShopCart].logic = self.logic;
    if (isExpands)
    {
        isExpands = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.deleteView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL isfinished){
            [UIView animateWithDuration:0.3 animations:^{
                self.titleView.transform = CGAffineTransformIdentity;
            }];
            
        }];
        self.navigationItem.rightBarButtonItem = [SNUIBarButtonItem itemWithTitle:L(@"BTEdit")
                                                                            Style:SNNavItemStyleDone
                                                                           target:self
                                                                           action:@selector(righBarClick)];
        
        [self.syncManager resume];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark control views

- (ShopCartTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [ShopCartTitleView view];
        [_titleView.jiesuanButton addTarget:self
                                     action:@selector(goSettleAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        [_titleView.checkButton addTarget:self
                                   action:@selector(selectAllAction:)
                         forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleView;
}

- (ShopCartDeleteView *)deleteView
{
    if (!_deleteView) {
        _deleteView = [ShopCartDeleteView view];
        [_deleteView.checkButton addTarget:self
                                    action:@selector(selectAllDeleteAction:)
                          forControlEvents:UIControlEventTouchUpInside];
        [_deleteView.deleteButton addTarget:self
                                     action:@selector(deleteItemsAction:)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteView;
}

- (UIButton *)editButton
{
    if (!_editButton)
    {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:L(@"Edit") forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
        _editButton.tag = 101;
        _editButton.frame = CGRectMake(0, 5, 50, 34);
//        [_editButton addTarget:self
//                        action:@selector(toggleEditAction:)
//              forControlEvents:UIControlEventTouchUpInside];
        [_editButton setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"]
                               forState:UIControlStateNormal];
    }
    return _editButton;
}

//购物车为空时展示的View
- (UIView *)backgroundView
{
    if (!_backgroundView) {
        
        if ([SystemInfo is_iPhone_5]) {
            _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kIphone5Fix/2+50, 320, 368)];
        }else{
            _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 368)];
        }
        _backgroundView.backgroundColor = [UIColor clearColor];
        
        
    }
    return _backgroundView;
}

- (AddressInfoPickerView *) addressPickerView
{
    if (!_addressPickerView)
    {
        AddressInfoDTO *dto = nil;
        
        if (self.logic.cityCode.length)
        {
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            dto = [dao getProvinceAndCityInfoByCityCode:self.logic.cityCode];
        }
        else
        {
            dto = [[AddressInfoDTO alloc] init];
            dto.province = [Config currentConfig].defaultProvince;
            dto.city = [Config currentConfig].defaultCity;
        }
        
        _addressPickerView = [[AddressInfoPickerView alloc]
                              initWithBaseAddressInfo:dto
                              compentCount:AddressPickerViewCompentTwo];
        _addressPickerView.addressDelegate = self;
    }
    return _addressPickerView;
}

- (ShopCartPromotionView *)promotionView
{
    if (!_promotionView) {
        _promotionView = [[ShopCartPromotionView alloc] init];
    }
    return _promotionView;
}

- (void)goToFavorite
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010202"], nil]];
    //防止从购物车到我的收藏夹后不能返回到我的购物车而是返回到我的易购
    MyFavoriteViewController *myFavorite = [[MyFavoriteViewController alloc] init];
    [self.navigationController pushViewController:myFavorite animated:YES];
    TT_RELEASE_SAFELY(myFavorite);
}

//添加编辑/结算按钮
- (void)setNavigationBarButtonItems
{
    //购物车为空时，不显示按钮
    if (self.logic.isEmpty || self.logic.isValidItemEmpty)
    {
//        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
    
//    if (self.navigationItem.leftBarButtonItem != nil)
//    {
//        return;
//    }
    
//    UIBarButtonItem *editItem =
//    [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
//    self.navigationItem.leftBarButtonItem = editItem;
    
    // 右上角结算按钮
    if (!self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTEdit")];
    }
}

- (void)righBarClick
{
    [self editAllItemsInShop];
}

//设置navigationItem是否可点
- (void)setSubmitButtonEnable:(BOOL)isEnable
{
    //    [self.titleView setJiesuanButtonEnable:isEnable];
}

//去商品详情
- (void)goToProductWithItem:(ShopCartV2DTO *)item
{
    if (item)
    {
        DataProductBasic *product = [[DataProductBasic alloc] init];
        product.productId = item.catentryId;
        product.cityCode = item.cityCode;
        product.shopCode = item.supplierCode;
        product.productCode = item.partNumber;
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 移入收藏夹

- (void)addItemToFavorite:(ShopCartV2DTO *)item
{
    if (![UserCenter defaultCenter].isLogined) {
        [self login];
        return;
    }
    
    DataProductBasic *product = [[DataProductBasic alloc] init];
    product.productId = item.catentryId;
    product.productCode = item.partNumber;
    product.shopCode = item.supplierCode;
    
    [self displayOverFlowActivityView:L(@"SCMovingToFavorites")];
    self.pDetailService.context = item;
    [self.pDetailService beginAddToFavorite:product];
}

- (void)addToFavoriteCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    if (isSuccess || [errorCode isEqualToString:@"D"])
    {
        ShopCartV2DTO *item = self.pDetailService.context;
        [self.logic deleteItem:item];
        
        [self refreshShopCartView];
        
        [self.syncManager deleteItems:@[item]];
        
        [self presentSheet:L(@"SCMoveToFavoritesSuccess")];
    }
    else
    {
        [self presentSheet:L(@"SCMoveToFavoritesFailed")];
    }
}

#pragma mark -
#pragma mark Navigation Item Event Handle Methods

//点击结算
- (void)goSettleAction:(id)sender
{
    //如果在编辑状态，先变为非编辑状态
    //    [self setShopCartEdit:NO];
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010110"], nil]];
    if (self.logic.isEmpty)
    {
        return;
    }
    
    if (self.logic.allItemList.count > 50)
    {
        [self presentSheet:L(@"ShopCart_Add_Error_Line_Beyond_50")];
        return;
    }
    
    //送货城市是否一致的校验 服务器的检查
    if (!self.logic.inSameCity)
    {
        [self presentSheet:L(@"ShopCart_Delivery_City_Not_Same_Error")];
        return;
    }
    
    //本地的检查
    if (!self.logic.localCheckIsInSameCity)
    {
        [self presentSheet:L(@"ShopCart_Delivery_City_Not_Same_Error")];
        return;
    }
    
    
    
    //liukun 如果没有勾选商品，提示勾选
    if (self.logic.checkedCartItemList.count == 0)
    {
        [self presentSheet:L(@"ShopCart_Empty_Error")];
        return;
    }
    
    //登录校验
    if([UserCenter defaultCenter].isLogined == NO)
    {
        LoginViewController *loginVC = [self checkLoginWithLoginedBlock:^{
            [self mobileOrderCheckOutASIHTTPRequest];
        } loginCancelBlock:NULL];
        
        //记录context， 用于识别
        loginVC.context = @{@"isInSettle": @YES};
    }
    else
    {
        [self mobileOrderCheckOutASIHTTPRequest];
    }
}

- (void)selectAllAction:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010109"], nil]];
    self.isSelectAnyProduct = YES;
    if (self.logic.isAllSelected)
    {
        NSArray *changedItemList = nil;
        [self.logic unSelectAllWithChangedItems:&changedItemList];
        
        //刷新页面
        [self refreshShopCartView];
        //同步购物车
        if ([changedItemList count]) {
            [self.syncManager modifyCheck:changedItemList];
        }
    }
    else
    {
        NSArray *changedItemList = nil;
        [self.logic selectAllWithChangedItems:&changedItemList];
        
        //有改动时刷新页面
        if ([changedItemList count])
        {
            //刷新页面
            [self refreshShopCartView];
            //同步购物车
            [self.syncManager modifyCheck:changedItemList];
        }
    }
}

- (void)selectAllDeleteAction:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010109"], nil]];
    if (self.logic.isEditAllSelect) {
        [self.logic unSelectEditAllWithChangedItems];
        [self refreshShopCartView];
    }
    else
    {
        [self.logic selectEditAllWithChangedItems];
        [self refreshShopCartView];
    }

}

- (void)deleteItemsAction:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010107"], nil]];
    BBAlertView *alert =  [[BBAlertView alloc] initWithTitle:nil
                                                     message:L(@"SCDeleteAllGoods")
                                                    delegate:nil
                                           cancelButtonTitle:L(@"Cancel")
                                           otherButtonTitles:L(@"Confirmation")];
    [alert setConfirmBlock:^{
        
        //删除本地的已勾选商品，然后同步
        NSArray *cleanedItems = nil;
        [self.logic cleanEditCheckedCartItems:&cleanedItems];
        
        if ([cleanedItems count])
        {
            //先刷新界面
            [self refreshShopCartView];
            //同步购物车
            [self.syncManager deleteItems:cleanedItems];
        }
        
    }];
    
    [alert show];
    
}

#pragma mark -
#pragma mark itemCell delegate

//勾选状态改变
- (void)cartItemCell:(ShopCartItemCell *)cell modifyCheckOfItem:(ShopCartV2DTO *)item
{
/* edit by zj 2014-3-13
    //先判断是否有suning自营和C店不能同时勾选的冲突
    if (!item.isChecked)
    {
        if ((item.isCShop && self.logic.isSuningChecked) ||
            (!item.isCShop && self.logic.isCShopChecked))
        {
            [self presentSheet:kShopCartCheckConflict];
            return;
        }
    }
  */
    if (item == nil) {
        [self refreshShopCartView];
    }
    else
    {
        //更改勾选状态
        NSString *errorMsg = nil;
        if ([item modifyCheck:&errorMsg])
        {
            self.isSelectAnyProduct = YES;
            //先刷新
            [self refreshShopCartView];
            //因有单品直降等活动时，本地计算会不准确，所以需要同步
            [self.syncManager modifyCheck:@[item]];
        }
        else
        {
            [self presentSheet:errorMsg];
        }
    }
}

//商品数量改变
- (void)cartItemQuantityDidChange
{
    NSMutableArray *changedItems = [[NSMutableArray alloc] init];
    //商品数据
    for (ShopCartShopDTO *shop in self.logic.shopCartList)
    {
        //商品行项目
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            if (![dto.quantity isEqualToString:dto.editQuantity]) {
                dto.quantity = dto.editQuantity;
                [changedItems addObject:dto];
            }

            if (dto.packageType == PackageTypeAccessory)
            {
                for (ShopCartV2DTO *innerDto in dto.accessoryPackageList)
                {
                    if (![innerDto.quantity isEqualToString:innerDto.editQuantity]) {
                        innerDto.quantity = innerDto.editQuantity;
                        [changedItems addObject:innerDto];
                    }
                }
            }
        }
    }
    if ([changedItems count])
    {
//        [self refreshShopCartView];
        [self.syncManager modifyCount:changedItems];
    }
}

- (void)deleteItemAtCell:(ShopCartItemCell *)cell
{
    SuNingSellDao* dao = [[SuNingSellDao alloc] init];
    [dao deleteSuNingSellDAOFromDB:cell.item.partNumber isSearch:YES];
    [self.logic deleteItem:cell.item];
    
    [self refreshShopCartView];
    
    [self.syncManager deleteItems:@[cell.item]];
}

- (void)removeToFavorite:(ShopCartV2DTO *)item
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:L(@"SCMoveTheGoodToFavorites")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    [alert setConfirmBlock:^{
        
        [self addItemToFavorite:item];
    }];
    [alert show];
}

- (void)presentEditAlertTip
{
    [self presentSheet:L(@"SCPleaseClickUpperRightCornerCompleted")];
}
#pragma mark ----------------------------- tableview reload

- (void)reloadTableView
{
    [self prepareTableViewDatasource];
    
    [self.tpTableView reloadData];
}

- (void)prepareTableViewDatasource
{
    if (self.logic.isEmpty)
    {
        _dataSourceArray = nil;

        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    //登录行, 有商品时不展示登录行
    if (0)
    {
        NSDictionary *dic = @{
                              kTableViewNumberOfRowsKey: @1,
                              kTableViewCellListKey:@[
                                      
                                      @{
                                          kTableViewCellTypeKey: @"Login_Cell",
                                          kTableViewCellHeightKey : @40.0f
                                          },
                                      ],
                              kTableViewSectionHeaderHeightKey : @10.0f,
                              kTableViewSectionHeaderTypeKey : @"Empty_View",
                              
                              };
        [array addObject:dic];
    }
    
    //送至城市行
    /**
     add by kb 14-09-17 购物车取消选择城市行
     */
    if (0)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //送至城市行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"City_Cell",
                                      kTableViewCellHeightKey : @40.0f};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@10.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionHeaderTypeKey];
        
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionFooterTypeKey];
        
        [array addObject:dic];
    }
    
    //商品数据
    for (ShopCartShopDTO *shop in self.logic.shopCartList)
    {
        //店家
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *cellList = [NSMutableArray array];
        
        [dic setObject:@40.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@"Shop_View" forKey:kTableViewSectionHeaderTypeKey];
        [dic setObject:shop forKey:@"shopData"];
        
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionFooterTypeKey];
//        //第一行展示店家信息
//        {
//            NSDictionary *cellDic = @{
//                                      kTableViewCellTypeKey: @"Shop_Cell",
//                                      kTableViewCellDataKey: shop,
//                                      kTableViewCellHeightKey : @40.0f};
//            [cellList addObject:cellDic];
//        }
        
        //商品行项目
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            if (dto.isCanntCheck == NO) {
                switch (dto.packageType) {
                    case PackageTypeNormal:
                    {
                        NSDictionary *cellDic = @{
                                                  kTableViewCellTypeKey: @"Item_Cell",
                                                  kTableViewCellDataKey: dto,
                                                  kTableViewCellHeightKey : @([ShopCartItemCell height:dto])};
                        [cellList addObject:cellDic];
                        break;
                    }
                    case PackageTypeAccessory:  //配件套餐
                    {
                        //主商品
                        {
                            NSDictionary *cellDic = @{
                                                      kTableViewCellTypeKey: @"Item_Cell",
                                                      kTableViewCellDataKey: dto,
                                                      kTableViewCellHeightKey : @([ShopCartItemCell height:dto]),
                                                      @"dottedLine":@YES};
                            [cellList addObject:cellDic];
                        }
                        
                        //套餐内商品
                        for (ShopCartV2DTO *innerDto in dto.accessoryPackageList)
                        {
                            BOOL isLast = (innerDto == dto.accessoryPackageList.lastObject)?YES:NO;
                            
                            NSDictionary *cellDic = @{
                                                      kTableViewCellTypeKey: @"Item_Cell",
                                                      kTableViewCellDataKey: innerDto,
                                                      kTableViewCellHeightKey : @([ShopCartItemCell height:innerDto]),
                                                      @"dottedLine":@(!isLast)};
                            [cellList addObject:cellDic];
                        }
                        
                        break;
                    }
                    case PackageTypeSmall:      //小套餐
                    {
                        //主商品
                        {
                            NSDictionary *cellDic = @{
                                                      kTableViewCellTypeKey: @"Item_Cell",
                                                      kTableViewCellDataKey: dto,
                                                      kTableViewCellHeightKey : @([ShopCartItemCell height:dto]),
                                                      @"dottedLine":@YES};
                            [cellList addObject:cellDic];
                        }
                        
                        //套餐内商品
                        for (ShopCartV2DTO *innerDto in dto.smallPackageList)
                        {
                            BOOL isLast = (innerDto == dto.smallPackageList.lastObject)?YES:NO;
                            
                            NSDictionary *cellDic = @{
                                                      kTableViewCellTypeKey: @"Item_Cell",
                                                      kTableViewCellDataKey: innerDto,
                                                      kTableViewCellHeightKey : @([ShopCartItemCell height:innerDto]),
                                                      @"dottedLine":@(!isLast)};
                            [cellList addObject:cellDic];
                        }
                        break;
                    }
                    case PackageTypeXn:         //
                    {
                        //暂时没有
                        break;
                    }
                    default:
                        break;
                }

            }
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        //header高度
        
        if ([cellList count] > 0) {
            [array addObject:dic];
        }
        
    }
    
    //失效商品行
    if (self.invalidItemList.count > 0)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //送至城市行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"InvalidItem_Cell",
                                      kTableViewCellHeightKey : @40.0f};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@0.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionHeaderTypeKey];
        
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        [dic setObject:@"Empty_View" forKey:kTableViewSectionFooterTypeKey];
        
        [array addObject:dic];
    }
    
    _dataSourceArray = array;
}


#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionHeaderHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    NSString *type = [sectionDic objectForKey:kTableViewSectionHeaderTypeKey];
    
    if ([type isEqualToString:@"Empty_View"])
    {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
    else if ([type isEqualToString:@"Shop_View"])
    {
        ShopCartShopDTO *shopDTO = [sectionDic objectForKey:@"shopData"];
        
        ShopCartShopHeaderView *shopCartHeaderView = [[ShopCartShopHeaderView alloc] init];
        shopCartHeaderView.delegate = self;
        shopCartHeaderView.shopDTO = shopDTO;
        [shopCartHeaderView setHeadViewInfo:shopDTO withIsExpand:isExpands isSelectNow:self.isSelectAnyProduct];
        
        return shopCartHeaderView;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionFooterHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    NSString *type = [sectionDic objectForKey:kTableViewSectionFooterTypeKey];
    
    if ([type isEqualToString:@"Promotion_View"])
    {
        return self.promotionView;
    }
    else if ([type isEqualToString:@"Empty_View"])
    {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"Login_Cell"])
    {
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
            cell.textLabel.textColor = [UIColor colorWithRGBHex:0x313131];
            
            UIImageView *image = [[UIImageView alloc] init];
            image.frame = CGRectMake(0, 0, 320, 0.5);
            image.backgroundColor = RGBCOLOR(220, 220, 220);
            [cell.contentView addSubview:image];
            
            
            UIImageView *image1 = [[UIImageView alloc] init];
            image1.frame = CGRectMake(0, 39.5, 320, 0.5);
            image1.backgroundColor = RGBCOLOR(220, 220, 220);
            [cell.contentView addSubview:image1];
            
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        
        }
        cell.textLabel.text = L(@"SCLoginCanSynchronizeShoppingCart");
        
        return cell;
    }
    else if ([cellType isEqualToString:@"City_Cell"])
    {
        ToolBarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ToolBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.toolBarDelegate = self;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.inputView = self.addressPickerView;
            
            cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
            cell.textLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", L(@"SCSendTo"),self.logic.cityName];
        
        return cell;
    }
//    else if ([cellType isEqualToString:@"Shop_Cell"])
//    {
//        ShopCartShopHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
//        if (cell == nil) {
//            cell = [[ShopCartShopHeaderView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
//            cell.delegate = self;
//        }
//        
//        cell.shopDTO = item;
//        return cell;
//    }
    else if ([cellType isEqualToString:@"Item_Cell"])
    {
        BOOL isUseDottedLine = [[cellDic objectForKey:@"dottedLine"] boolValue];
        
        ShopCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil)
        {
            cell = [[ShopCartItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.delegate = self;
        }
        
        [cell setShopItemInfo:item hasExpands:isExpands];
        [cell setLineDotted:isUseDottedLine];
        return cell;
    }
    else if ([cellType isEqualToString:@"InvalidItem_Cell"])    //失效商品行
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        }
        NSInteger quantity = [self checkInvalidItemQuantity];
        cell.textLabel.text = [NSString stringWithFormat:@"%@%d%@",L(@"SCInShoppingCart"),quantity,L(@"SCTemporarilyUnableToBuy")];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"Item_Cell"])
    {
        if (!isExpands) {
            [self goToProductWithItem:item];
        }
    }
    else if ([cellType isEqualToString:@"Login_Cell"])
    {
        if (![UserCenter defaultCenter].isLogined)
        {
            [self login];
        }
        else
        {
            [self presentSheet:L(@"SCYouHaveLogined")];
            [self refreshShopCartView];
        }
    }
    else if ([cellType isEqualToString:@"InvalidItem_Cell"])    //失效商品行
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010111"], nil]];
        InvalidProductViewController *vc = [[InvalidProductViewController alloc] initWithLogic:self.logic syncManager:self.syncManager];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ----------------------------- headerView callBack

- (void)goToCShop:(NSString *)shopCode
{
    if (!isExpands) {
        if (!IsStrEmpty(shopCode))
        {
            NSString *mutableStr = shopCode;
            
            if(shopCode.length != 10)
            {
                mutableStr = [NSString stringWithFormat:@"00%@",mutableStr];
            }
            
            //购物车去店铺地址更换，10位、8位wap端兼容
            NSString *url = [NSString stringWithFormat:@"%@/%@.html?client=app",kMHostAddressForHttp,mutableStr?mutableStr:@""];
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCShop attributes:@{@"url": url, @"shopId": shopCode}];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (void)shopHeaderView:(ShopCartShopHeaderView *)headerView selectAllTapped:(ShopCartShopDTO *)shopDTO
{
    //判断是否是编辑状态
    if (isExpands) {
        //编辑状态下是否该供应商商品全勾选
        if (shopDTO.isEditAllSelect) {
            [shopDTO unSelectEditAllWithChangedItems];
            [self refreshShopCartView];
        }
        else
        {
            [shopDTO selectEditAllWithChangedItems];
            [self refreshShopCartView];
        }
    }
    else
    {
        self.isSelectAnyProduct = YES;
        if (shopDTO.isAllSelect)
        {
            NSArray *changedItemList = nil;
            [shopDTO unSelectAllWithChangedItems:&changedItemList];
            [self refreshShopCartView];
            if ([changedItemList count]) {
                [self.syncManager modifyCheck:changedItemList];
            }
        }
        else
        {
            //更改勾选
            NSArray *changedItemList = nil;
            [shopDTO selectAllWithChangedItems:&changedItemList];
            
            if ([changedItemList count])
            {
                [self refreshShopCartView];
                [self.syncManager modifyCheck:changedItemList];
            }
        }
    }
    
}

- (void)shopHeaderView:(ShopCartShopHeaderView *)headerView editItemsInShop:(ShopCartShopDTO *)shop
{
    [shop setEditing:![shop isEditing]];
}

- (void)editAllItemsInShop
{
    isExpands = !isExpands;
    NSString* str = nil;
    if (isExpands)
    {
        str = @"1010108";
    }
    else
    {
        str = @"1010104";
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",str], nil]];
    [self reloadTableView];
    if (isExpands == YES) {
        self.navigationItem.rightBarButtonItem = [SNUIBarButtonItem itemWithTitle:L(@"BTFinish")
                                                                            Style:SNNavItemStyleDone
                                                                           target:self
                                                                           action:@selector(righBarClick)];
        [UIView animateWithDuration:0.3 animations:^{
            self.titleView.transform = CGAffineTransformMakeTranslation(0, self.titleView.height);
        }completion:^(BOOL isfinished){
            [UIView animateWithDuration:0.3 animations:^{
                self.deleteView.transform = CGAffineTransformMakeTranslation(0, -self.deleteView.height);
            }];
            
        }];
        [self.syncManager pause];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            self.deleteView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL isfinished){
            [UIView animateWithDuration:0.3 animations:^{
                self.titleView.transform = CGAffineTransformIdentity;
            }];
            
        }];
        self.navigationItem.rightBarButtonItem = [SNUIBarButtonItem itemWithTitle:L(@"BTEdit")
                                                                            Style:SNNavItemStyleDone
                                                                           target:self
                                                                           action:@selector(righBarClick)];
        [self.syncManager resume];
    }
}

#pragma mark ----------------------------- address info

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    //
}

- (void)doneClicked:(UITableViewCell *)cell
{
    AddressInfoDTO *selectAddress = self.addressPickerView.selectAddressInfo;
    if (selectAddress.city.length)
    {
        [cell resignFirstResponder];
        
        if (![self.logic.cityCode isEqualToString:selectAddress.city])
        {
            [self.logic changeAllItemsCity:selectAddress.city cityName:selectAddress.cityContent];
            [Config currentConfig].defaultProvince = selectAddress.province;
            [Config currentConfig].defaultCity = selectAddress.city;
            [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
            //刷新页面
            [self refreshShopCartView];
            //同步
            [self.syncManager modifyCity:selectAddress.city];
            
            if (isExpands == YES) {
                [self reloadTableView];
                isExpands = !isExpands;
                [UIView animateWithDuration:0.3 animations:^{
                    self.deleteView.transform = CGAffineTransformIdentity;
                }completion:^(BOOL isfinished){
                    [UIView animateWithDuration:0.3 animations:^{
                        self.titleView.transform = CGAffineTransformIdentity;
                    }];
                    
                }];
                self.navigationItem.rightBarButtonItem = [SNUIBarButtonItem itemWithTitle:L(@"BTEdit")
                                                                                    Style:SNNavItemStyleDone
                                                                                   target:self
                                                                                   action:@selector(righBarClick)];
                [self.syncManager resume];
            }

        }
    }
    else
    {
        [self presentSheet:L(@"SCNotSupportTheProvince")];
    }
}

#pragma mark -
#pragma mark 刷新购物车视图

- (void)refreshShopCartView
{
    //设置navigation
    [self setNavigationBarButtonItems];
    
    //设置badage
    NSInteger productQuantity = self.logic.allProductQuantity;
    if (productQuantity > 0) {
        [self changeBadgeValue:[NSString stringWithFormat:@"%d", productQuantity]];
    }else{
        [self changeBadgeValue:@"0"];
    }
    if (!self.isFirstLoaded) {
        [self removeOverFlowActivityView];
        if (self.logic.isEmpty)
        {
            [self refreshBackGroundView];
            if (self.backgroundView.superview == nil)
            {
                [self.view insertSubview:self.backgroundView aboveSubview:self.tpTableView];
            }
            
            self.tpTableView.scrollEnabled = NO;
            
            //清除促销信息
            self.logic.promotionDesc = nil;
            self.titleView.hidden = YES;
            self.deleteView.hidden = YES;
        }
        else
        {
            [self.backgroundView removeFromSuperview];
            
            self.tpTableView.scrollEnabled = YES;
            
            self.titleView.hidden = NO;
            self.deleteView.hidden = NO;
            self.titleView.logic = self.logic;
            self.deleteView.logic = self.logic;
        }
        
        //促销信息
        BOOL hasPromotion = self.logic.promotionDesc.trim.length?YES:NO;
        if (hasPromotion)
        {
            self.promotionView.promotionDesc = self.logic.promotionDesc;
            self.tpTableView.tableFooterView = self.promotionView;
        }
        else
        {
            self.tpTableView.tableFooterView = nil;
        }
        
        //刷新页面
        [self reloadTableView];

    }
    else
    {
        if (![UserCenter defaultCenter].isLogined) {
            if (self.logic.isEmpty)
            {
                [self removeOverFlowActivityView];
                [self refreshBackGroundView];
                if (self.backgroundView.superview == nil)
                {
                    [self.view insertSubview:self.backgroundView aboveSubview:self.tpTableView];
                }
                
                self.tpTableView.scrollEnabled = NO;
                
                //清除促销信息
                self.logic.promotionDesc = nil;
                self.titleView.hidden = YES;
                self.deleteView.hidden = YES;
            }
        }
        
    }
}

- (void)refreshBackGroundView
{
    [self.backgroundView removeAllSubviews];
    //add image
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 20, 82, 75)];
    imageView.image = [UIImage imageNamed:@"shopcart_empty.png"];
    [self.backgroundView addSubview:imageView];
    
    //add go to Favourite button
    UIButton *btnFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnFavorite.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    [self.backgroundView addSubview:btnFavorite];
    
    //add go to Shopping button
    UIButton *btnShopping = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShopping setTitle:L(@"goShopping") forState:UIControlStateNormal];
    
    //        [btnShopping setBackgroundImage:[UIImage imageNamed:@"shopcart_goaround_btn_press.png"]
    //                               forState:UIControlStateHighlighted];
    btnShopping.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    [btnShopping addTarget:self action:@selector(goAround)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundView addSubview:btnShopping];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.frame = CGRectMake(0, imageView.bottom +20, 320, 20);
    tipLabel.text = L(@"SCHaveNoGoodsInShoppingCartAndLogin");
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor colorWithRGBHex:0x707070];
    tipLabel.hidden = YES;
    [self.backgroundView addSubview:tipLabel];
    
    if ([UserCenter defaultCenter].isLogined) {
        tipLabel.hidden = YES;
        [btnFavorite setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"]
                               forState:UIControlStateNormal];
        [btnFavorite setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                               forState:UIControlStateHighlighted];
        [btnFavorite setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        [btnFavorite setTitle:L(@"goFavourite") forState:UIControlStateNormal];
        [btnFavorite addTarget:self action:@selector(goToFavorite) forControlEvents:UIControlEventTouchUpInside];
        btnFavorite.frame = CGRectMake(20, imageView.bottom+30, 134, 38);
        
        [btnShopping setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"]
                               forState:UIControlStateNormal];
        [btnShopping setTitleColor:[UIColor colorWithRGBHex:0xffffff]
                          forState:UIControlStateNormal];
        btnShopping.frame = CGRectMake(166, imageView.bottom+30, 134, 38);
        
        
    }
    else
    {
        tipLabel.hidden = NO;
        
        [btnFavorite setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"]
                               forState:UIControlStateNormal];
        [btnFavorite setTitle:L(@"LoginTitle") forState:UIControlStateNormal];
        [btnFavorite setTitleColor:[UIColor colorWithRGBHex:0xffffff] forState:UIControlStateNormal];
        [btnFavorite addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        btnFavorite.frame = CGRectMake(20, imageView.bottom+50, 134, 38);
        
        [btnShopping setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"]
                               forState:UIControlStateNormal];
        [btnShopping setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                               forState:UIControlStateHighlighted];
        [btnShopping setTitleColor:[UIColor colorWithRGBHex:0x707070]
                          forState:UIControlStateNormal];
        btnShopping.frame = CGRectMake(166, imageView.bottom+50, 134, 38);
    }
}

#pragma mark -
#pragma mark utils


#pragma mark -
#pragma mark NSNotification method

- (void)finishShopping:(NSNotification *)notification
{
    //删除本地的已勾选商品，然后同步
//    NSArray *cleanedItems = nil;
//    [self.logic cleanCheckedCartItems:&cleanedItems];
//
//    if ([cleanedItems count])
//    {
//        //先刷新界面
//        [self refreshShopCartView];
//        //同步购物车
//        [self.syncManager deleteItems:cleanedItems];
//    }
    
    [self.syncManager query];
}

- (void)loginOK:(NSNotification *)notification
{
    NSDictionary *context = [notification userInfo];
    BOOL isInSettle = [[context objectForKey:@"isInSettle"] boolValue];
    //同步
    [self.syncManager mergeWithLoginWinFlag:isInSettle];
}

- (void)autoLoginOK:(NSNotification *)notification
{
    //同步购物车
    [self.syncManager merge];
}

- (void)logOutOK:(NSNotification *)notification
{
    [self.syncManager cancelSync];
    self.logic = nil;
    _sharedLogic = nil;
    [self refreshShopCartView];
}

- (void)loginSessionFailure:(NSNotification *)notification
{
    [self.syncManager cancelSync];
    self.logic = nil;
    [self refreshShopCartView];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self.syncManager query];
}

- (void)networkStatusDidChange:(NSNotification *)notification
{
    [self.syncManager query];
}

- (void)cityDidChange:(NSNotification *)notification
{
    NSString *city = [Config currentConfig].defaultCity;
    if (![self.logic.cityCode isEqualToString:city] && [AddressInfoDAO isUpdateAddressOk]) {
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        AddressInfoDTO *dto = [dao getProvinceAndCityInfoByCityCode:city];
        [self.logic changeAllItemsCity:dto.city cityName:dto.cityContent];
        [self.syncManager modifyCity:dto.city];
    }
}

#pragma mark -
#pragma mark 添加商品到购物车

//预检查商品是否能够加入购物车(抢购或单价团用到)
- (BOOL)checkProductCanAddToShopCart:(DataProductBasic *)newProduct errorMsg:(NSString **)errorMsg
{
    if (newProduct == nil || newProduct.cityCode.length == 0)
    {
        *errorMsg = L(@"SCPleaseSelectDeliveryCity");
        return NO;
    }
    
    ShopCartV2DTO *itemNew = [ShopCartV2DTO shopCartV2DTOFromProduct:newProduct];
    
    NSInteger quantity = [self.logic quantityOfProduct:newProduct];
    //商品数量不能大于99
    if (quantity + itemNew.quantity.integerValue > 99)
    {
        *errorMsg = L(@"ShopCart_Add_Error_Beyond99");
        return NO;
    }
    //商品行不能大于50
    else if (quantity == 0 && [self.logic allCartItemQuantity]+[self.logic cartItemQuantityOfDTO:itemNew] > 50)
    {
        *errorMsg = L(@"ShopCart_Add_Error_Line_Beyond_50");
        return NO;
    }
    
    return YES;
}

//加入购物车
- (void)addProductToShoppingCart:(DataProductBasic *)newProduct
                 completionBlock:(SNOperationCallBackBlock)block
{
    if (newProduct==nil || newProduct.cityCode.length == 0)
    {
        return;
    }
    
    ShopCartV2DTO *itemNew = [ShopCartV2DTO shopCartV2DTOFromProduct:newProduct];
    
    NSInteger quantity = [self.logic quantityOfProduct:newProduct];
    //商品数量不能大于99
    if (itemNew.quantity.integerValue > 99)
    {
        NSString *errorMsg = L(@"ShopCart_Add_Error_Beyond99");
        if (block) {
            block(NO, errorMsg);
        }
        return;
    }
    //商品行不能大于50
    else if (quantity == 0 && [self.logic allCartItemQuantity]+[self.logic cartItemQuantityOfDTO:itemNew] > 50)
    {
        NSString *errorMsg = L(@"ShopCart_Add_Error_Line_Beyond_50");
        if (block) {
            block(NO, errorMsg);
        }
        return;
    }
    else if (quantity > 0 && itemNew.special == ShopCartSpecialRush)
    {
        //若果有同样的抢购商品，直接添加成功 (抢购只能添加一件)
        if (block) {
            block(YES, nil);
        }
        return;
    }

    //使用syncManager
    @weakify(self);
    
    [self.syncManager addProduct:newProduct callBack:^(BOOL canAdd, NSString *errorMsg) {
        
        @strongify(self);
        if (canAdd)
        {
            //添加到本地购物车
            [self.logic addProductToLocalShopCart:newProduct];
            
            //刷新页面
            [self refreshShopCartView];
            
            //同步购物车
            [self.syncManager query];
        }
        
        if (block) {
            block(canAdd, errorMsg);
        }
    }];
}

#pragma mark -
#pragma mark 同步购物车

- (ShopCartSyncManager *)syncManager
{
    if (!_syncManager) {
        _syncManager = [[ShopCartSyncManager alloc] initWithController:self];
        
        @weakify(self);
        [_syncManager addRefreshBlock:^(ShopCartLogic *logicNew) {
            
            @strongify(self);
            self.isSelectAnyProduct = NO;
            self.invalidItemList = logicNew.invalidItemList;
            self.logic = logicNew;
            self.isFirstLoaded = NO;
            [self removeOverFlowActivityView];
            [self refreshShopCartView];
        }];
        
        [_syncManager addMissedItemEvent:^(NSString *missItemId) {
            
            if (missItemId.length) {
                
                BBAlertView *alert = [[BBAlertView alloc]
                                      initWithTitle:nil
                                      message:L(@"AlertoperationFailed")
                                      delegate:nil
                                      cancelButtonTitle:L(@"Ok")
                                      otherButtonTitles:nil];
                [alert show];
            }
            
        }];
    }
    
    return _syncManager;
}

#pragma mark -
#pragma mark 提交去结算接口

- (void)mobileOrderCheckOutASIHTTPRequest
{
    [self displayOverFlowActivityView];
    
    [self setSubmitButtonEnable:NO];
    
    //为防止当前的同步操作未完成
    @weakify(self);
    [self.syncManager addEventWhenIdle:^{
        @strongify(self);
        [self.cartService requestOrderCheckOutV3:self.logic.shopCartList];
    }];
}

- (void)service:(ShopCartV2Service *)service orderCheckOutComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    [self setSubmitButtonEnable:YES];
    
    //去结算页面的请求
    if (service.context)
    {
        if ([service.context isKindOfClass:NSClassFromString(@"__NSMallocBlock__")])
        {
            void (^callBack)(BOOL, ShopCartV2Service *, ShopCartLogic *) = service.context;
            callBack(isSuccess, service, self.logic);
            self.cartService = nil;
        }
        else if ([service.context isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = (NSDictionary *)service.context;
            ShopCartLogic *logic = [dic objectForKey:@"logic"];
            void (^callBack)(BOOL, ShopCartV2Service *, ShopCartLogic *) = [dic objectForKey:@"block"];
            callBack(isSuccess, service, logic);
            self.cartService = nil;
        }
        
        return;
    }
    
    if (isSuccess)
    {
        // 导航到去结算页面
        ReceiveInfoViewController *receiveViewController = [[ReceiveInfoViewController alloc] init];
        receiveViewController.powerFlag = service.powerFlag;
        [receiveViewController calculateProduct:service.shopCartItemList];
        
        NSString *cityCode = nil, *cityName = nil;
        [self.logic getDeliveryCityCode:&cityCode cityName:&cityName];
        receiveViewController.deliveryCityCode  = cityCode;
        receiveViewController.deliveryCityName  = cityName;
        receiveViewController.currentCityCode   = cityCode;
        
        double price = [service.productAllPrice doubleValue];
        receiveViewController.totalPriceStr     = [NSString stringWithFormat:@"￥%0.2f",price];
        
        double shouldPayprice = [service.userPayAllPrice doubleValue];
        receiveViewController.shouldPayPrice    = [NSString stringWithFormat:@"￥%0.2f",shouldPayprice];
        
        double fare = [service.totalShipPrice doubleValue];
        receiveViewController.totalFareStr      = [NSString stringWithFormat:@"￥%0.2f",fare];
        
        double discount = [service.totalDiscount doubleValue];
        receiveViewController.totalDiscount     = [NSString stringWithFormat:@"￥%0.2f",discount];
        
        receiveViewController.isCOrder          = service.isCOrder;
        receiveViewController.isAllCOrder       = service.isallCorder;
        receiveViewController.canUseEleInvoice  = service.canUseEleInvoice;
        receiveViewController.eleInvoiceIsDefault = service.eleInvoiceIsDefault;
        receiveViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: receiveViewController animated:YES];
        TT_RELEASE_SAFELY(receiveViewController);
    }
    else
    {
        if (self.cartService.shopCartItemList.count)
        {
            self.logic = [[ShopCartLogic alloc] initWithCartList:service.shopCartItemList
                                                 productAllPrice:service.productAllPrice
                                                 userPayAllPrice:service.userPayAllPrice
                                                     sunpgkPrice:service.sunpgkPrice
                                                   totalDiscount:service.totalDiscount
                                                   promotionDesc:service.promotionDesc
                                                      inSameCity:service.inSameCity];
            self.invalidItemList = self.logic.invalidItemList;
            [self refreshShopCartView];
        }
        
        NSArray *array = self.cartService.errorItemList;
        NSString *errorDesc;
        for (ShopCartV2DTO *errorItem in array) {
            if (errorItem)
            {
                //抢购商品
                if ([errorItem.errorDesc isEqualToString:L(@"SCPanicBuyingQualificationHasExpired")])
                {
                    [self showQuickBuyError:errorItem];
                    self.cartService = nil;
                    return;
                }
                //单价团商品
                else if ([errorItem.errorDesc isEqualToString:L(@"SCGroupPurchaseHasExpired")])
                {
                    [self showDanJiaGroupError:errorItem];
                    self.cartService = nil;
                    return;
                }
                //大聚会商品
                else if (errorItem.special == ShopCartSpecialMarket &&
                         [errorItem.errorDesc rangeOfString:L(@"SCOver")].length != 0)
                {
                    [self showDaJuHuiError:errorItem];
                    self.cartService = nil;
                    return;
                }
                else
                {
                    
                    NSString *errorStr = [NSString stringWithFormat:L(@"ShopCart_OrderCheck_Product_Error%@%@"),
                                          errorItem.productName, errorItem.errorDesc];
                    if (IsStrEmpty(errorDesc)) {
                        errorDesc = errorStr;
                    }else{
                        errorDesc = [NSString stringWithFormat:@"%@\n%@",errorDesc,errorStr];
                    }
                    
                }
            }
            else
            {
                NSString *error = service.errorMsg ? service.errorMsg : L(@"System_Abnomal_Try_later");
                [self presentSheet:error];
                self.cartService = nil;
                return;
            }
        }
        
        [self presentSheet:errorDesc];
    }
    
    self.cartService = nil;
}

- (void)showQuickBuyError:(ShopCartV2DTO *)dto
{
    
    NSString *errorDesc = [NSString stringWithFormat:L(@"ShopCart_OrderCheck_Special_TimeOut_Error%@"),
                           dto.productName];
    
    BBAlertView *quickbuyErrorAlert = [[BBAlertView alloc] initWithTitle:nil
                                                                 message:errorDesc
                                                                delegate:self
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:L(@"Ok")];
    @weakify(self);
    [quickbuyErrorAlert setConfirmBlock:^{
        
        @strongify(self);
        ShopCartV2DTO *item = nil;
        [self.logic changeSpecialItemToNormal:dto changedItem:&item];
        if (item)
        {
            [self.syncManager modifySpecial:@[item]];
        }
    }];
    
    [quickbuyErrorAlert show];
}

- (void)showDanJiaGroupError:(ShopCartV2DTO *)dto
{
    
    NSString *errorDesc = [NSString stringWithFormat:L(@"ShopCart_OrderCheck_DanJiaGroup_TimeOut_Error%@"),
                           dto.productName];
    
    BBAlertView *quickbuyErrorAlert = [[BBAlertView alloc] initWithTitle:nil
                                                                 message:errorDesc
                                                                delegate:self
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:L(@"Ok")];
    @weakify(self);
    [quickbuyErrorAlert setConfirmBlock:^{
        
        @strongify(self);
        ShopCartV2DTO *item = nil;
        [self.logic changeSpecialItemToNormal:dto changedItem:&item];
        if (item)
        {
            [self.syncManager modifySpecial:@[item]];
        }
    }];
    
    [quickbuyErrorAlert show];
}

- (void)showDaJuHuiError:(ShopCartV2DTO *)dto
{
    
    NSString *errorDesc = [NSString stringWithFormat:L(@"ShopCart_OrderCheck_DaJuHui_TimeOut_Error%@"),
                           dto.productName];
    
    BBAlertView *quickbuyErrorAlert = [[BBAlertView alloc] initWithTitle:nil
                                                                 message:errorDesc
                                                                delegate:self
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:L(@"Ok")];
    @weakify(self);
    [quickbuyErrorAlert setConfirmBlock:^{
        
        @strongify(self);
        ShopCartV2DTO *item = nil;
        [self.logic changeSpecialItemToNormal:dto changedItem:&item];
        if (item)
        {
            [self.syncManager modifySpecial:@[item]];
        }
    }];
    
    [quickbuyErrorAlert show];
}

//修改购物车数量
- (void)changeBadgeValue:(NSString *)badgeValue
{
    //    self.tabBarItem.badgeValue = badgeValue;
    [self.appDelegate.tabBarViewController showBadgeValue:badgeValue];
    [[RightSideToolView sharedInstance] showBadgeValue:badgeValue];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeProductDetailCarNum" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeProductDetailCarNum" object:nil userInfo:@{@"badgeValueChaged": badgeValue}];
}

#pragma mark ----------------------------- 更换城市结算

- (void)reOrderCheckOutWithCity:(NSString *)cityCode cityName:(NSString *)cityName logic:(ShopCartLogic *)logic complete:(void(^)(BOOL isSuccess, ShopCartV2Service *service, ShopCartLogic *logic))block
{
    [self setSubmitButtonEnable:NO];
    if (logic)
    {
        [logic changeAllItemsCity:cityCode cityName:cityName];
        self.cartService.context = @{@"logic": logic, @"block" : [block copy]};
        [self.cartService requestOrderCheckOut:logic.shopCartList];
    }
    else
    {
        [self.logic changeAllItemsCity:cityCode cityName:cityName];
        [self refreshShopCartView];
        self.cartService.context = [block copy];
        [self.cartService requestOrderCheckOut:self.logic.shopCartList];
    }
}

- (void)removeObserverForOrderCheckOut
{
    if (self.cartService.context)
    {
        self.cartService.context = nil; //取消监听
        SERVICE_RELEASE_SAFELY(_cartService);   //取消请求
    }
}

#pragma mark ----------------------------- logic init

- (ShopCartLogic *)logic
{
    if (!_logic) {
        _logic = [ShopCartLogic emptyLogic];
        [_logic addObserver:self forKeyPath:@"cityCode"
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                    context:NULL];
    }
    return _logic;
}

- (void)setLogic:(ShopCartLogic *)logic
{
    if (_logic != logic) {
        if (_logic) {
            [_logic removeObserver:self forKeyPath:@"cityCode"];
        }
        
        _logic = logic;
        
        [_logic addObserver:self forKeyPath:@"cityCode"
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                    context:NULL];
        
        [self checkSelectedCityInPickView];
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"cityCode"] && [object isKindOfClass:[ShopCartLogic class]])
    {
        [self checkSelectedCityInPickView];
    }
}

- (void)checkSelectedCityInPickView
{
    if (![self.addressPickerView.selectAddressInfo.city isEqualToString:self.logic.cityCode])
    {
        //设置pickerView的选择框
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        AddressInfoDTO *dto = [dao getProvinceAndCityInfoByCityCode:self.logic.cityCode];
        self.addressPickerView.baseAddressInfo = dto;
    }
}

- (NSInteger)checkInvalidItemQuantity
{
    NSInteger quantity = 0;
    for (ShopCartV2DTO *dto in self.invalidItemList) {
        quantity += [dto.quantity integerValue];
    }
    return quantity;
}

@end
