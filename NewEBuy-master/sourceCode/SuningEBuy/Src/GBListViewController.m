//
//  GBListViewController.m
//  SuningEBuy
//
//  Created by shasha on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBListViewController.h"
#import "GBListPrametersDTO.h"
#import "GBListGoodsCell.h"
#import "GBListGoodsBigModeCell.h"
#import "GBDetailViewController.h"
#import "GBSearchViewController.h"
#import "GBOrderListViewController.h"
#import "SNGraphics.h"
#import "LoginViewController.h"
#import "BBSideBarViewController.h"

#import "BottomNavBar.h"

#define kSmallModeIconImageName @"GroupBuy_mode_List.png"
#define kBigModeIconImageName   @"GroupBuy_mode_picture.png"

#define ModeChangeImageViewTag  101
#define CityIndicatorViewTag    102
#define CellSeperateLineTag     103

@interface GBListViewController(){
    
    ViewMode __currentViewMode;
    
    BOOL     __isLoaded;
    
    BOOL     __isRefreshCategory;
    
    BOOL     isClick;
}

@property (nonatomic, strong) NSArray  *goodsList;
@property (nonatomic, strong) NSMutableArray  *conditionList;
@property (nonatomic, strong) GBListPrametersDTO  *paramDTO;
@property (nonatomic, strong) GBFirstCategoryViewController  *firstCateViewController;
@property (nonatomic, strong) GBListService  *service;
@property (nonatomic, strong) AuthManagerNavViewController  *cityViewController;
@property(nonatomic,assign)   NSInteger				nowCount;
@property(nonatomic,assign)   NSInteger				allCount;

@property (nonatomic, strong) BottomNavBar    *backBottomView;
@property (nonatomic, strong) UIButton          *changeModeBtn;

@end


@implementation GBListViewController

@synthesize goodsList = _goodsList;
@synthesize conditionList = _conditionList;
@synthesize paramDTO = _paramDTO;
@synthesize firstCateViewController = _firstCateViewController;
@synthesize cityViewController = _cityViewController;
@synthesize service = _service;
@synthesize nowCount = _nowCount;
@synthesize allCount = _allCount;

- (void)dealloc
{
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_goodsList);
    TT_RELEASE_SAFELY(_conditionList);
    TT_RELEASE_SAFELY(_paramDTO);
    TT_RELEASE_SAFELY(_firstCateViewController);
    TT_RELEASE_SAFELY(_cityViewController);
    
}

- (id)init
{
    self = [super init];
    if (self) { 
        isClick = NO;
        _paramDTO = [[GBListPrametersDTO alloc] init];
        _paramDTO.cityId = @"11";
        _paramDTO.categoryId = nil;
        _paramDTO.areaId = nil;
        _paramDTO.indexId = nil;
        _paramDTO.keyWord = nil;
        _paramDTO.sortType = 0;
        _paramDTO.pageNumber = @"1";
        _paramDTO.pageSize = @"12";
        
        __currentViewMode = eSmallMode;
        
        __isLoaded = NO;
        
        __isRefreshCategory = YES;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),L(@"Group_Purchase_List")];
        [self initNavigationItems];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSessionFailure)
                                                     name:LOGIN_SESSION_FAILURE_NEED_LOGIN_GROUP
                                                   object:nil];
        
        self.bSupportPanUI = NO;
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)loginSessionFailure
{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.loginDelegate = self;
//    loginViewController.loginDidCancelSelector = @selector(loginDidCancel);
    
    AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                             initWithRootViewController:loginViewController];
    
    [self presentModalViewController:userNav animated:YES];
    
    TT_RELEASE_SAFELY(loginViewController);
    TT_RELEASE_SAFELY(userNav);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.firstCateViewController.parentViewController) {
        [self.revealSideViewController preloadViewController:self.firstCateViewController forSide:PPRevealSideDirectionRight];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
}

- (void)loadView{
    [super loadView];
        
    [self loadSearchBar];
    
    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = YES;
    
    CGRect frame = self.view.frame;
    frame.origin.y = 44;
    frame.size.height -= 135;
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.clipsToBounds = YES;
    [self.tableView addSubview:self.refreshHeaderView];
//    [self firstCallQueryCity];

    [self.bottomNavBar addSubview:self.changeModeBtn];
//    [self.view bringSubviewToFront:self.backBottomView];
    
    [self refreshCategoryView];
}

- (BottomNavBar *)backBottomView
{
    if (!_backBottomView) {
        _backBottomView = [[BottomNavBar alloc] init];

        _backBottomView.frame = CGRectMake(0, self.view.bounds.size.height - 112, 320, 48);
        [_backBottomView.backButton addTarget:self
                                     action:@selector(backForePage)
                           forControlEvents:UIControlEventTouchUpInside];
        
       
        [_backBottomView addSubview:self.changeModeBtn];
    }
    return _backBottomView;
}

- (UIButton *)changeModeBtn
{
    if (!_changeModeBtn) {
        _changeModeBtn = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, kUINavigationBarFrameHeight, kUINavigationBarFrameHeight)];
        _changeModeBtn.backgroundColor = [UIColor clearColor];
        [_changeModeBtn setImage:[UIImage imageNamed:kSmallModeIconImageName] forState:UIControlStateNormal];
        [_changeModeBtn addTarget:self action:@selector(modeChangeTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeModeBtn;
}

- (void)loadSearchBar{
    //添加searchBar
    UIView *searchView = [[UIView alloc] init];
    searchView.frame = CGRectMake(0, 0, 320, 44);
    searchView.backgroundColor = RGBCOLOR(239, 239, 239);
    [self.view addSubview:searchView];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.frame = CGRectMake(10, 15/2, 300, 30);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn addTarget:self action:@selector(gotoSearchView) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(17, 14, 20, 20)];
    searchImg.backgroundColor = [UIColor clearColor];
    searchImg.image = [UIImage imageNamed:@"Search_ZoomInIcon.png"];
    [searchView addSubview:searchImg];
    
    UILabel *searchLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 60, 15)];
    searchLbl.backgroundColor = [UIColor clearColor];
    searchLbl.textColor = RGBCOLOR(190, 190, 190);
    searchLbl.text = @"Search";
    [searchView addSubview:searchLbl];
    
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    searchBar.placeholder = L(@"GB_Search_Bar_Placeholder");
//    searchBar.barTintColor = [UIColor blueColor];
//    searchBar.delegate = self;
//    searchBar.showsCancelButton = YES;
//    
//    [self.view addSubview:searchBar];
//    
//    for (UIView *view in searchBar.subviews)
//    {
//        if ([view isKindOfClass:[UIButton class]])
//        {
//            UIButton *cancelBtn = (UIButton *)view;
//            [cancelBtn setTitle:L(@"GB_My_Group_Buy") forState:UIControlStateNormal];
//            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//            [cancelBtn setBackgroundImage:[UIImage imageNamed:@"addtocar_n@2x.png"] forState:UIControlStateNormal];
//            [cancelBtn setBackgroundImage:[UIImage imageNamed:@"addtocar_h@2x.png"] forState:UIControlStateHighlighted];
//            
//
////            [cancelBtn setBackgroundImage:[UIImage streImageNamed:@"blueButton.png"] forState:UIControlStateNormal];
//            [cancelBtn setEnabled:YES];
//            [cancelBtn setHighlighted:NO];
//            [cancelBtn addTarget:self action:@selector(goToMyGroupBuy) forControlEvents:UIControlEventTouchUpInside];
//            
//        }else if ([view isKindOfClass:[UITextField class]]){
//            
//            UITextField *searchField = (UITextField *)view;
//            searchField.frame = CGRectMake(searchField.left, searchField.top, searchField.width - 60, searchField.height);
//        }
//    }
}

- (void)backForePage
{
    [self back];
}

- (void)initNavigationItems{
    
    UIView *rightBarButttonsView = [[UIView alloc] initWithFrame:CGRectMake(320 - kUINavigationBarFrameHeight*2, 0, kUINavigationBarFrameHeight*2, kUINavigationBarFrameHeight)];
    
    UIButton *expandBtn = [[UIButton alloc] initWithFrame:CGRectMake(kUINavigationBarFrameHeight, 0, kUINavigationBarFrameHeight, kUINavigationBarFrameHeight)];
    [expandBtn addTarget:self action:@selector(expandBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [expandBtn setTitle:L(@"Filter") forState:UIControlStateNormal];
    [expandBtn setTitleColor:RGBCOLOR(246, 102, 30) forState:UIControlStateNormal];
    expandBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [rightBarButttonsView addSubview:expandBtn];
    
    
    UIBarButtonItem *custumItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButttonsView];
    TT_RELEASE_SAFELY(rightBarButttonsView);
    self.navigationItem.rightBarButtonItem = custumItem;
    TT_RELEASE_SAFELY(custumItem);
        
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.frame = CGRectMake(0, 0, 120, kUINavigationBarFrameHeight);
    [titleButton titleRectForContentRect:CGRectMake(0, 0, 40, 44)];
    if (IsStrEmpty([Config currentConfig].gbDefaultCityName)) {
        [titleButton setTitle:L(@"GBChooseCity") forState:UIControlStateNormal];
    }else{
        [titleButton setTitle:[Config currentConfig].gbDefaultCityName forState:UIControlStateNormal];
    }
    titleButton.backgroundColor = [UIColor clearColor];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleButton.titleLabel.textAlignment = UITextAlignmentCenter;
    titleButton.titleLabel.backgroundColor = [UIColor clearColor];
    titleButton.titleLabel.textColor = [UIColor colorWithRGBHex:0x313131];
    [titleButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
//    [titleButton.titleLabel setShadowColor:[UIColor lightGrayColor]];
//    [titleButton.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    UIImageView *indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_bottom_gray.png"]];
    CGSize characterSize = [titleButton.titleLabel.text sizeWithFont:titleButton.titleLabel.font];
    CGFloat titleWidth =characterSize.width;
    indicatorView.frame = CGRectMake((120 - titleWidth)/2+ titleWidth + 5, 19, 13, 8);
    indicatorView.tag = CityIndicatorViewTag;
    [titleButton addSubview:indicatorView];
    [titleButton addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    TT_RELEASE_SAFELY(indicatorView);
    TT_RELEASE_SAFELY(titleButton);
}

- (void)back{
    
    [BBSideBarViewController backToEbuy];
}

- (void)firstCallQueryCity:(NSString *)tuanGouType snProId:(NSString *)snProId
{
    if (!IsStrEmpty(snProId)) {
        GBDetailViewController *detail = [[GBDetailViewController alloc] init];
        detail.snProId = snProId;
        detail.tuanGouType = tuanGouType;
        [self.navigationController pushViewController:detail animated:YES];
    }
    if (IsStrEmpty([Config currentConfig].gbDefaultCityId) ) {
        [self selectCity];
    }else{
        if (!__isLoaded) {
            self.isFromHead = YES;
            self.paramDTO.cityId = [Config currentConfig].gbDefaultCityId;
            [self getGBGoodsList];
        }
    }
}

- (void)gotoSearchView
{
    GBSearchViewController *vc = [[GBSearchViewController alloc] init];
    vc.cityId = self.paramDTO.cityId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark search bar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    GBSearchViewController *vc = [[GBSearchViewController alloc] init];
    vc.cityId = self.paramDTO.cityId;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

- (void)goToMyGroupBuy
{
    GBOrderListViewController *orderListVC = [[GBOrderListViewController alloc] init];
    [self.navigationController pushViewController:orderListVC animated:YES];
}

#pragma mark - Category Methods
#pragma mark   分类相关的方法
- (void)expandBtnTapped:(id)sender{
    
    //[self.navigationController pushViewController:self.firstCateViewController animated:YES];
    
//    UIButton *expandBtn = (UIButton *)sender;
    if (!isClick) {
//        UIImageView *expandIndicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 27, 27)];
//        expandIndicatorView.image = [UIImage imageNamed:@"GB_navigationitem_expand_icon_right.png"];
//        for (UIView *view in expandBtn.subviews) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                [view removeFromSuperview];
//            }
//        }
//        UIImage *image = [SNGraphics gradientImageWithTop:[UIColor darkTextColor]//RGBACOLOR(0, 198, 233, 0.7)
//                                                   bottom:[UIColor lightGrayColor]//RGBACOLOR(0, 136, 191, 0.7)
//                                                    frame:CGRectMake(0, 0, 1, 44)];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [expandBtn addSubview:imageView];
//        [expandBtn addSubview:expandIndicatorView];
//        TT_RELEASE_SAFELY(imageView);
//        TT_RELEASE_SAFELY(expandIndicatorView);
        isClick = !isClick;
    }
    else
    {
//        UIImageView *expandIndicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 27, 27)];
//        expandIndicatorView.image = [UIImage imageNamed:@"GB_navigationitem_expand_icon.png"];
//        for (UIView *view in expandBtn.subviews) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                [view removeFromSuperview];
//            }
//        }
//        
//        UIImage *image = [SNGraphics gradientImageWithTop:[UIColor darkTextColor]//RGBACOLOR(0, 198, 233, 0.7)
//                                                   bottom:[UIColor lightGrayColor]//RGBACOLOR(0, 136, 191, 0.7)
//                                                    frame:CGRectMake(0, 0, 1, 44)];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [expandBtn addSubview:imageView];
//        [expandBtn addSubview:expandIndicatorView];
//        TT_RELEASE_SAFELY(imageView);
//        TT_RELEASE_SAFELY(expandIndicatorView);
        isClick = !isClick;
    }
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}

- (void)categoryChangedWithCityName:(NSString *)cityName{
    [self.revealSideViewController popViewControllerAnimated:YES];
    
    if (!IsStrEmpty(cityName)) {
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:cityName forState:UIControlStateNormal];
        CGSize characterSize = [titleBtn.titleLabel.text sizeWithFont:titleBtn.titleLabel.font];
        CGFloat titleWidth =characterSize.width;
        UIImageView *indicatorImage = (UIImageView *)[titleBtn viewWithTag:CityIndicatorViewTag];
        indicatorImage.frame = CGRectMake((120 - titleWidth)/2+ titleWidth + 5, indicatorImage.top, indicatorImage.width, indicatorImage.height);
    }
    
    self.isFromHead = YES;
    [self getGBGoodsList];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO]; 
}

#pragma mark - Select City List Methods
#pragma mark   选择城市的相关方法

- (void)selectCity{
    if (!self.presentedViewController) {
        [self.revealSideViewController.rootViewController presentViewController:self.cityViewController animated:YES completion:NULL];
        
    }
}

- (void)selectCity:(GBCityDTO *)cityDTO{
    if (cityDTO == nil) {
        if (IsStrEmpty([Config currentConfig].gbDefaultCityId)) {
            [self back];
        }
    }else{
        [Config currentConfig].gbDefaultCityId = cityDTO.cityId;
        [Config currentConfig].gbDefaultCityName = cityDTO.cityName;
        self.paramDTO.cityId = cityDTO.cityId;
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:cityDTO.cityName forState:UIControlStateNormal];
        CGSize characterSize = [titleBtn.titleLabel.text sizeWithFont:titleBtn.titleLabel.font];
        CGFloat titleWidth =characterSize.width;
        UIImageView *indicatorImage = (UIImageView *)[titleBtn viewWithTag:CityIndicatorViewTag];
        indicatorImage.frame = CGRectMake((120 - titleWidth)/2+ titleWidth + 5, indicatorImage.top, indicatorImage.width, indicatorImage.height);
        
        self.paramDTO.categoryId = nil;
        _paramDTO.sortType = 0;
        _paramDTO.pageNumber = @"1";
        _paramDTO.pageSize = @"12";
        
        self.isFromHead = YES;
        [self getGBGoodsList];
        
        __isRefreshCategory = YES;
    }
}

- (GBFirstCategoryViewController *)firstCateViewController{
    if (!_firstCateViewController) {
        _firstCateViewController = [[GBFirstCategoryViewController alloc] init] ;
        _firstCateViewController.delegate = self;
    }
    return _firstCateViewController;
}

#pragma mark - modeChange Navigationitem tapped Methods
#pragma mark   浏览模式切换按钮点击响应事件

- (void)modeChangeTapped{
    
//    UIView *view = (UIView *)[self.view subviews];
//    UIImageView *viewModeImage =(UIImageView *)[view viewWithTag:ModeChangeImageViewTag];
    if (__currentViewMode == eSmallMode) {
        __currentViewMode = eBigMode;
        [self.changeModeBtn setImage:[UIImage imageNamed:kBigModeIconImageName] forState:UIControlStateNormal];
//        viewModeImage.image =[UIImage imageNamed:kBigModeIconImageName];
    }else{
        __currentViewMode = eSmallMode;
        [self.changeModeBtn setImage:[UIImage imageNamed:kSmallModeIconImageName] forState:UIControlStateNormal];
//        viewModeImage.image = [UIImage imageNamed:kSmallModeIconImageName];
    }
    [self.tableView reloadData];
}

- (void)refreshCategoryView{
    self.firstCateViewController.paramDTO = self.paramDTO;
    [self.firstCateViewController setFirstCategoryList:self.conditionList];
}

#pragma mark - GoodsList Request Methods
#pragma mark   团购列表数据请求方法
- (void)getGBGoodsList{
    [self displayOverFlowActivityView];
    
    [self.service beginSendGBListRequest:self.paramDTO];
}

- (void)didSendGBListRequestComplete:(GBListService *)service Result:(BOOL)isSuccess{
    
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if (isSuccess) {
        
        __isLoaded = YES;
        
        self.allCount = [service.numberFound integerValue];
        
        if (self.isFromHead) {
            self.goodsList = service.searchResultsList;
        }else{
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.goodsList];
            [tempArr addObjectsFromArray:service.searchResultsList];
            self.goodsList = tempArr;
            TT_RELEASE_SAFELY(tempArr);
        }
        
        self.nowCount = [self.goodsList count];
        
        if (self.nowCount == self.allCount) {
            self.isLastPage = YES;
        }else{
            self.isLastPage = NO;
        }
        
        if (!IsArrEmpty(service.filtersList)) {
            self.conditionList = service.filtersList;
        }
    }else{
        [self presentSheet:service.errorMsg];
    }
    
    self.service = nil;
    
    //只有重新选择城市的时候，才刷新筛选类别
    if (__isRefreshCategory) {
        [self refreshCategoryView];
    }
    __isRefreshCategory = NO;
    
    [self.tableView reloadData];
}

#pragma mark - Refresh LoadMore Methods
#pragma mark - 刷新列表以及加载更多方法

/*子类实现*/
- (void)refreshData{
    [super refreshData];
    self.paramDTO.pageNumber = @"1";
    [self getGBGoodsList];
}

/*子类实现*/
- (void)loadMoreData{
    [super loadMoreData];
    NSInteger pageNumber = [self.paramDTO.pageNumber integerValue];
    self.paramDTO.pageNumber = [NSString stringWithFormat:@"%d",++pageNumber];
    [self getGBGoodsList];
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (IsArrEmpty(self.goodsList)) {
        return 0;
    }else{
        if ([self hasMore])
        {
            return  [self.goodsList count] + 1;
        }else{
            return [self.goodsList count];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && self.nowCount == indexPath.row)
    {
        return 48;
    }else{
        if (__currentViewMode == eSmallMode) {
            
            return [GBListGoodsCell height];
        }else{
            
            return [GBListGoodsBigModeCell height];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    
    if ([self hasMore] && self.nowCount == row)
    {
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
		
		UITableViewMoreCell *cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
            cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			cell.title = L(@"loadMore");
            
            cell.animating = NO;
		}
        
		return cell;
    }
    
    GBListGoodsDTO *goodsDTO = [self.goodsList objectAtIndex:row];
    if (!IsNilOrNull(goodsDTO)) {
        
        if (__currentViewMode == eSmallMode) {
            static NSString *GBLitGoodsCellIdentifier = @"GBLitGoodsCellIdentifier";
            
            GBListGoodsCell *cell = (GBListGoodsCell *)[tableView dequeueReusableCellWithIdentifier:GBLitGoodsCellIdentifier];
            
            if (!cell) {
                cell = [[GBListGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBLitGoodsCellIdentifier];
                cell.backgroundColor = [UIColor whiteColor];
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
//            UIImageView *seperateLine = (UIImageView *)[cell viewWithTag:CellSeperateLineTag];
//            if (!seperateLine) {
//                seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110-2, 320, 2)];
//                seperateLine.image = [UIImage imageNamed:@"GB_seperatLine.png"];
//                seperateLine.tag = CellSeperateLineTag;
//                [cell.contentView addSubview:seperateLine];
//            }
            
            [cell setItem:goodsDTO];
            
            return cell;
        }else{
            static NSString *GBLitGoodsBigModeCellIdentifier = @"GBLitGoodsBigModeCellIdentifier";
            
            GBListGoodsBigModeCell *cell = (GBListGoodsBigModeCell *)[tableView dequeueReusableCellWithIdentifier:GBLitGoodsBigModeCellIdentifier];
            
            if (!cell) {
                cell = [[GBListGoodsBigModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBLitGoodsBigModeCellIdentifier];
                cell.backgroundColor = [UIColor whiteColor];
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
//            UIImageView *seperateLine = (UIImageView *)[cell viewWithTag:CellSeperateLineTag];
//            if (!seperateLine) {
//                seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 270-2, 320, 2)];
//                seperateLine.image = [UIImage imageNamed:@"GB_seperatLine.png"];
//                seperateLine.tag = CellSeperateLineTag;
//                [cell.contentView addSubview:seperateLine];
//            }
            
            [cell setItem:goodsDTO];
            
            return cell;
        }
        
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    if ([self hasMore]&&self.nowCount == row) {
        return;
    }
    
    GBListGoodsDTO *dto = [self.goodsList objectAtIndex:row];
    NSString *goodSrc = IsStrEmpty(dto.goodSrc)?@"":dto.goodSrc;
    NSString *snProId;
    if ([goodSrc isEqualToString:@"0"]) {
        snProId = IsStrEmpty(dto.snProId)?@"":dto.snProId;
    }else{
        snProId = IsStrEmpty(dto.goodId)?@"":dto.goodId;
    }
   
    GBDetailViewController *detail = [[GBDetailViewController alloc] init];
    detail.snProId = snProId;
    detail.tuanGouType = goodSrc;
    [self.navigationController pushViewController:detail animated:YES];
}

- (GBListService *)service{
    if (!_service) {
        _service = [[GBListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (AuthManagerNavViewController *)cityViewController{
    if (!_cityViewController) {
        GBCityListViewController *city = [[GBCityListViewController alloc] init];
        city.delegate =self;
        _cityViewController = [[AuthManagerNavViewController alloc] initWithRootViewController:city];
    }
    return _cityViewController;
}

@end
