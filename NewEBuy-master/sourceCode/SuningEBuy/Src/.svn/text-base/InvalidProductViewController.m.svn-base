//
//  InvalidProductViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvalidProductViewController.h"
#import "ProductDetailViewController.h"

@interface InvalidProductViewController ()
{
    NSArray *_dataSourceArray;
    id       _refreshObserver;
}
@end

@implementation InvalidProductViewController

- (void)dealloc
{
    [self.syncManager removeRefreshObserver:_refreshObserver];
    SERVICE_RELEASE_SAFELY(_pDetailService);
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"SCFailureGoods");
        self.pageTitle = L(@"Product_ShoppingCart_FailureGoods");
        self.bSupportPanUI = NO;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithLogic:(ShopCartLogic *)logic syncManager:(ShopCartSyncManager *)manager
{
    self = [self init];
    if (self) {
        self.logic = logic;
        self.syncManager = manager;
    }
    return self;
}

- (void)setSyncManager:(ShopCartSyncManager *)syncManager
{
    if (syncManager != _syncManager) {
        
        if (_refreshObserver) {
            [_syncManager removeRefreshObserver:_refreshObserver];
        }
        _syncManager = syncManager;
        
        @weakify(self);
        [_syncManager addRefreshBlock:^(ShopCartLogic *logic) {
            
            @strongify(self);
            self.logic = logic;
            [self reloadTableView];
        }];
    }
}

- (void)loadView
{
    [super loadView];
    
    if (!IOS7_OR_LATER) {
        self.tpGroupTableView = self.tpTableView;
    }
    
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];
    self.tpGroupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    frame.size.height = frame.size.height - 44;
    self.tpGroupTableView.frame = frame;
    [self.view addSubview:self.tpGroupTableView];
    self.tpGroupTableView.backgroundColor = [UIColor view_Back_Color];
    self.groupTableView = self.tpGroupTableView;
    
    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = YES;
    self.deleteBtn.frame = CGRectMake(50, 5, 254, 40);
    [self.bottomNavBar addSubview:self.allCheckedBtn];
    [self.bottomNavBar addSubview:self.deleteBtn];
    [self setAllCheckedBtnSelect];
    
}

- (void)setAllCheckedBtnSelect
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010112"], nil]];
    if (YES == [self isAllItemChecked]) {
        self.allCheckedBtn.selected = YES;
    }else
    {
        self.allCheckedBtn.selected = NO;
    }
}

- (BOOL)isAllItemChecked
{
    BOOL isAllChecked = YES;
    BOOL hasMatched = NO;
    for (ShopCartShopDTO *shop in self.logic.shopCartList)
    {
        //商品行项目
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            if (dto.isCanntCheck == YES) {
                hasMatched = YES;
                if (dto.isDeleteItemCheck == NO) {
                    isAllChecked = NO;
                    break;
                }
            }
        }
    }
    return isAllChecked && hasMatched;
}

- (void)setDeleteBtnAbled
{
    BOOL isHasChecked = NO;
    for (ShopCartShopDTO *shop in self.logic.shopCartList)
    {
        //商品行项目
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            if (dto.isCanntCheck == YES) {
                if (dto.isDeleteItemCheck == YES) {
                    isHasChecked = YES;
                    break;
                }
            }
        }
    }
    if (isHasChecked == YES) {
        self.deleteBtn.enabled = YES;
    }
    else
    {
        self.deleteBtn.enabled = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self reloadTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backForePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_normal.png"]
                      forState:UIControlStateNormal];
        [_deleteBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_disable.png"]
                              forState:UIControlStateDisabled];
        [_deleteBtn setTitle:L(@"BTDelete") forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self
                         action:@selector(deleteAction)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)allCheckedBtn
{
    if (!_allCheckedBtn) {
        _allCheckedBtn = [[UIButton alloc] init];
        _allCheckedBtn.frame = CGRectMake(0, 0, 50, 50);
        [_allCheckedBtn setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                      forState:UIControlStateSelected];
        [_allCheckedBtn setImage:[UIImage streImageNamed:@"checkbox_unselect.png"]
                      forState:UIControlStateNormal];
        [_allCheckedBtn addTarget:self
                           action:@selector(allChecked)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _allCheckedBtn;
}

- (ProductDetailService *)pDetailService
{
    if (!_pDetailService) {
        _pDetailService = [[ProductDetailService alloc] init];
        _pDetailService.delegate = self;
    }
    return _pDetailService;
}

#pragma mark ----------------------------- tableview reload

- (void)reloadTableView
{
    [self prepareTableViewDatasource];
    
    [self.groupTableView reloadData];
    
    [self setAllCheckedBtnSelect];
    
    [self setDeleteBtnAbled];
}

- (void)prepareTableViewDatasource
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *cellList = [NSMutableArray array];
    //商品数据
    for (ShopCartShopDTO *shop in self.logic.shopCartList)
    {
        //商品行项目
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            if (dto.isCanntCheck == YES) {
                switch (dto.packageType) {
                    case PackageTypeNormal:
                    {
                        NSDictionary *cellDic = @{
                                                  kTableViewCellTypeKey: @"Item_Cell",
                                                  kTableViewCellDataKey: dto,
                                                  kTableViewCellHeightKey : @([InvalidProductItemCell height:dto])};
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
                                                      kTableViewCellHeightKey : @([InvalidProductItemCell height:dto]),
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
                                                      kTableViewCellHeightKey : @([InvalidProductItemCell height:innerDto]),
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
                                                      kTableViewCellHeightKey : @([InvalidProductItemCell height:dto]),
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
                                                      kTableViewCellHeightKey : @([InvalidProductItemCell height:innerDto]),
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
        
    }
    [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
    [dic setObject:cellList forKey:kTableViewCellListKey];
    
    [dic setObject:@44.0f forKey:kTableViewSectionHeaderHeightKey];
    [dic setObject:@"Shop_View" forKey:kTableViewSectionHeaderTypeKey];
    
    
    [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
    [dic setObject:@"Empty_View" forKey:kTableViewSectionFooterTypeKey];
    
    [array addObject:dic];
    _dataSourceArray = array;
}

#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
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
    
    if ([type isEqualToString:@"Shop_View"])
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 200, 20)];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.font = [UIFont systemFontOfSize:16];
        titleLbl.text = L(@"SCFollowingGoodsTemporarilyUnableToBuy");
        [view addSubview:titleLbl];
        return view;
    }
    else{
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionFooterHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"Item_Cell"])
    {
        InvalidProductItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[InvalidProductItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.delegate = self;
        }
        
        [cell setItem:item];
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
        [self goToProductWithItem:item];
    }
    
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
#pragma mark ----------------------------- 全部商品勾选

- (void)allChecked
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010112"], nil]];
    self.allCheckedBtn.selected = !self.allCheckedBtn.selected;
    for (ShopCartShopDTO *shop in self.logic.shopCartList)
    {
        //商品行项目
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            if (dto.isCanntCheck == YES) {
                if (self.allCheckedBtn.selected == YES) {
                    dto.isDeleteItemCheck = YES;
                }
                else
                {
                    dto.isDeleteItemCheck = NO;
                }
            }
        }
    }
    [self reloadTableView];
}

- (void)reloadInvalidTableView
{
    [self reloadTableView];
}

#pragma mark - 移入收藏夹

- (void)addItemToFavorite:(ShopCartV2DTO *)item
{
    if (![UserCenter defaultCenter].isLogined) {
        [self login];
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
        
        [self reloadTableView];
        [self.syncManager deleteItems:@[item]];
        
        [self presentSheet:L(@"SCMoveToFavoritesSuccess")];
    }
}

- (void)removeToAddFavorite:(ShopCartV2DTO *)item
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


#pragma mark -
#pragma mark ------------ deleteItems method ------------

- (void)deleteAction
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010113"], nil]];
    NSArray *cleanedItems = [self.logic cleanItemsWillDelete];
    
    if ([cleanedItems count])
    {
        [self reloadTableView];
        [self.syncManager deleteItems:cleanedItems];
    }
    else
    {
        [self presentSheet:L(@"SCHaveNotCheckedDeleteGoods")];
    }
}

- (void)deleteItemWithCell:(InvalidProductItemCell *)cell
{
    if (cell.item) {
        [self.logic deleteItem:cell.item];
        
        [self reloadTableView];
        [self.syncManager deleteItems:@[cell.item]];
    }
}

@end
