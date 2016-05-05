//
//  SearchListViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchListViewController.h"
#import "UITableViewMoreCell.h"

#import "SNPopoverController.h"
#import "CatePickViewController.h"
#import "ProvincePickViewController.h"
#import "FilterPickViewController.h"
#import "ProductDetailViewController.h"
#import "FXLabel.h"
#import "ProductDetailViewController.h"
#import "SolrSearchHistoryDAO.h"
#import "ProductUtil.h"
#import "AddressInfoDAO.h"
#import "AuthNavigationBar.h"
#import "SearchTextField.h"
#import "SearchSegmentView.h"
#import "JASidePanelController.h"
#import "FilterRootViewController.h"
#import "NewCatePickViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FilterNavigationController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "ShopSearchListViewController.h"
#import "InnerProductDTO.h"

#define kSearchBarShowFrame     CGRectMake(0, 0, 320, 44)
#define kSearchBarHideFrame     CGRectMake(0, -44, 320, 44)


#define kTableViewInsetTopWithKeyWord      (44 + 65)
#define kTableViewInsetTopWithKeyWordIOS7  (64 + 65)
#define kTableViewInsetTopWithoutKeyWord  [self getReasonableTabelViewContentInsetTop]

//推荐商品视图
@implementation UIFootRecommendView
- (InterestProductsView *)recommendViewForkeywordSearch
{
    if (!_recommendViewForkeywordSearch) {
        _recommendViewForkeywordSearch = [[InterestProductsView alloc]
                                          initWithFrame:self.bounds];
        _recommendViewForkeywordSearch.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _recommendViewForkeywordSearch.delegate = self.delegate;
        [self addSubview:_recommendViewForkeywordSearch];
    }
    
    return _recommendViewForkeywordSearch;
}

- (InterestProductsView *)recommendViewForCategoryFilter
{
    if (!_recommendViewForCategoryFilter)
    {
        _recommendViewForCategoryFilter = [[InterestProductsView alloc]initWithFrame:self.bounds];
        _recommendViewForCategoryFilter.infoLabel.text = L(@"Hot_Product_Recommend");
        _recommendViewForCategoryFilter.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _recommendViewForCategoryFilter.delegate = self.delegate;
        [self addSubview:_recommendViewForCategoryFilter];
        _recommendViewForCategoryFilter.hidden = YES;
    }
    
    return _recommendViewForCategoryFilter;
}

- (void)setIsKeywordSearch:(BOOL)isKeywordSearch
{
    if (isKeywordSearch)
    {
        self.recommendViewForCategoryFilter.hidden = YES;
        self.recommendViewForkeywordSearch.hidden = NO;
    }
    else
    {
        self.recommendViewForkeywordSearch.hidden = YES;
        self.recommendViewForCategoryFilter.hidden = NO;
    }
    
    _isKeywordSearch = isKeywordSearch;
}

- (void)showIntrestedProductView:(NSMutableArray *)productList
{
    if (_isKeywordSearch)
    {
        self.productListForKeyword = productList;
        [_recommendViewForkeywordSearch showIntrestedProductView:_productListForKeyword];
    }
    else
    {
        self.productListForCategoryFilter = productList;
        [_recommendViewForCategoryFilter showIntrestedProductView:_productListForCategoryFilter];
    }
}
@end

@interface SearchListViewController()
{
    SearchResultViewType _footViewType;
    
    BOOL  bShowItemNum;
    
    SearchSegmentCell    *_segmentCell;
    
    CGPoint ptLastOffset;
    BOOL  isNoResult;
    BOOL  bSearchConditionChanged; //是否正要进行与当前搜索不同的搜索
}
@property (nonatomic, assign) BOOL isKeywordSearch;

@property (nonatomic, strong) SearchSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) AssociationalAndHistoryWordDisplayController *keywordDisplayController;
@property (nonatomic, strong) UINavigationBar *customNavigationBar;
@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) SearchTextField *searchTextField;
@property (nonatomic, strong) UIButton *filterButton;
@property (nonatomic, strong) UIButton *searchCancelButton;
@property (nonatomic, strong) UIButton *zxingBtn;//扫码按钮
@property (nonatomic, strong) SearchSegmentView *searchsegmentView;

@property (nonatomic, strong) SNPopoverController *catePopoverController;
@property (nonatomic, strong) SNPopoverController *cityPopoverController;
@property (nonatomic, strong) SNPopoverController *filterPopoverController;

@property (nonatomic, strong) CatePickViewController *catePickController;
@property (nonatomic, strong) ProvincePickViewController *cityPickController;
@property (nonatomic, strong) FilterPickViewController *filterPickController;


@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIFootRecommendView *footRecommendView;
@property (nonatomic, copy)   NSString *errorMsg;


/*保存上次搜索关键字，避免重复收集数据*/
@property (nonatomic, copy) NSString *lastSearchKeyword;
@property (nonatomic, copy) NSString *initialSearchCateID; //初始化时的ci，从类别进入搜索，重置时使用

- (BOOL)hasMore;
- (void)refreshData;
- (void)loadMoreData;
- (void)startMoreCellAnimation:(BOOL)animating;

- (void)resetSearchSort;
- (void)updateTableView;

//设置右边按钮不可点
- (void)setRightItemsEnable:(BOOL)enable;
@end

/*********************************************************************/

@implementation SearchListViewController

@synthesize service = _service;
@synthesize searchCondition = _searchCondition;

@synthesize sectionHeaderView = _sectionHeaderView;
@synthesize searchBar = _searchBar;
@synthesize keywordDisplayController = _keywordDisplayController;

@synthesize catePopoverController = _catePopoverController;
@synthesize cityPopoverController = _cityPopoverController;
@synthesize filterPopoverController = _filterPopoverController;

@synthesize catePickController = _catePickController;
@synthesize cityPickController = _cityPickController;
@synthesize filterPickController = _filterPickController;

@synthesize footView = _footView;
@synthesize footRecommendView = _footRecommendView;
@synthesize errorMsg = _errorMsg;

@synthesize lastSearchKeyword = _lastSearchKeyword;

- (void)dealloc {
    _service.delegate = nil;
    TT_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_searchCondition);
    
    TT_RELEASE_SAFELY(_sectionHeaderView);
    TT_RELEASE_SAFELY(_searchBar);
    TT_RELEASE_SAFELY(_keywordDisplayController);
    TT_RELEASE_SAFELY(_catePopoverController);
    TT_RELEASE_SAFELY(_cityPopoverController);
    TT_RELEASE_SAFELY(_filterPopoverController);
    
    TT_RELEASE_SAFELY(_catePickController);
    TT_RELEASE_SAFELY(_cityPickController);
    TT_RELEASE_SAFELY(_filterPickController);
    
    TT_RELEASE_SAFELY(_footView);
    TT_RELEASE_SAFELY(_footRecommendView);
    TT_RELEASE_SAFELY(_errorMsg);
    
    TT_RELEASE_SAFELY(_lastSearchKeyword);
    TT_RELEASE_SAFELY(_segmentCell);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithSearchCondition:(SearchParamDTO *)condition
{
    self = [super init];
    if (self) {
        _searchCondition = condition;
        
        _lastRequestArray = [NSMutableArray array];
//        if (_searchCondition.keyword) {
//            isKeywordSearch = YES;
//            self.pageTitle =[NSString stringWithFormat:@"搜索-搜索结果-%@",_searchCondition.keyword] ;
//        }
//        else
//            self.pageTitle =[NSString stringWithFormat:@"搜索-搜索结果-%@",_searchCondition.categoryId];

        
        _initialSearchCateID = condition.categoryId;
        
        bShowItemNum = NO;
        //监听默认城市是否改变
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(defaultCityDidChange)
                                                     name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                   object:nil];
        
        
//        [self setNavigationRightItems];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTypeChanged) name:SEARCHTYPE_CHANGED object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:REFRESH_SEARCHLIST object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceSearchByKeyWord) name:VOICE_SEARCH object:nil];
    }
    return self;
}


- (void)voiceSearchByKeyWord
{
    if ([VoiceSearchViewController sharedVoiceSearchCtrl].from == From_SearchList)
    {
        [[VoiceSearchViewController sharedVoiceSearchCtrl] removeVoiceSearchView];
        [self didSelectAssociationalWord:[VoiceSearchViewController sharedVoiceSearchCtrl].result];
        
    }
}

- (void)searchTypeChanged
{
    NSNumber *number = [Config currentConfig].searchType;
    if (number.intValue == 0)
    {
        [self.searchTypeBtn setTitle:L(@"Search_Goods") forState:UIControlStateNormal];
    }
    else if (number.intValue == 1)
    {
        [self.searchTypeBtn setTitle:L(@"Search_Store") forState:UIControlStateNormal];
    }
    
    [self.searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_downArrowGray.png"] forState:UIControlStateNormal];
}

- (void)refreshTableView
{
    [self.tableView reloadData];
}

- (void)setIsKeywordSearch:(BOOL)isKeywordSearch
{
    self.footRecommendView.isKeywordSearch = isKeywordSearch;
    _isKeywordSearch = isKeywordSearch;
}
#pragma mark -
#pragma mark notification receiver

//系统默认城市改变
- (void)defaultCityDidChange
{
    NSString *defaultCity = [Config currentConfig].defaultCity;
    if (![self.searchCondition.cityId eq:defaultCity]) {
        self.searchCondition.cityId = defaultCity;
        
        [self refreshData];
    }
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.hasSuspendButton = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchTopView];
    [self.view addSubview:self.customNavigationBar];
    [self.view addSubview:self.statusbarBack];

    
    self.tableView.frame = self.view.bounds;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    if (_searchCondition.keyword) {
        self.isKeywordSearch = YES;
        self.pageTitle =[NSString stringWithFormat:@"%@-%@",L(@"search_searchResult"),_searchCondition.keyword] ;
    }
    else
    {
        self.isKeywordSearch = NO;
        self.pageTitle =[NSString stringWithFormat:@"%@-%@",L(@"search_searchResult_category"),_searchCondition.categoryName];
    }
    

    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);

    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    _searchTextField.text = _searchCondition.keyword;
    [self refreshData];
    
}

- (int)getReasonableTabelViewContentInsetTop
{
    if (IOS7_OR_LATER)
    {
//        if (self.searchTopView.hidden)
//            return 64;
//        else
            return 64 + self.searchTopView.height;
    }
    else
    {
//        if (self.searchTopView.hidden)
//            return 44;
//        else
            return 44 + self.searchTopView.height;
    }
    
//    switch (State) {
//        case NOVIEW:
//        {
//            self.height = 0;
//            break;
//        }
//        case SEGMENTVIEW:
//        {
//            self.height = 40;
//            break;
//        }
//        case CATALOG_SEGMENTVIEW:
//        {
//            if (self.catalogArray.count <= 4)
//                self.height = 54 + 40;
//            else
//                self.height = 93 + 40;
//            break;
//        }
//        case BRAND_SEGMENTVIEW:
//        {
//            self.height = 115;
//            break;
//        }
//        case BRAND_CATALOG_SEGMENTVIEW:
//        {
//            if (self.catalogArray.count <= 4)
//                self.height = 75 + 54 + 40;
//            else
//                self.height = 75 + 93 + 40;
//            break;
//        }

//    switch (self.searchTopView.State) {
//        case NOVIEW:
//        {
//            if (IOS7_OR_LATER)
//                return 64 ;
//            else
//                return 44 ;
//        }
//        case SEGMENTVIEW:
//        {
//            if (IOS7_OR_LATER)
//                return 64 + 40;
//            else
//                return 44 + 40;
//        }
//        case CATALOG_SEGMENTVIEW:
//        {
//            if (IOS7_OR_LATER)
//            {
//                if (self.service.sugdirsArray.count < 5 && self.service.sugdirsArray.count > 0)
//                    return 64 + 54 + 40;
//                else if (self.service.sugdirsArray.count == 0)
//                    return 40;
//                else
//                    return 64 + 93 + 40;
//            }
//            else
//            {
//                if (self.service.sugdirsArray.count < 5 && self.service.sugdirsArray.count > 0)
//                    return 44 + 54 + 40;
//                else if (self.service.sugdirsArray.count == 0)
//                    return 40;
//                else
//                    return 44 + 93 + 40;
//            }
//        }
//        case BRAND_SEGMENTVIEW:
//        {
//            if (IOS7_OR_LATER)
//                return 64 + 40 + 75;
//            else
//                return 44 + 40 + 75;
//        }
//        case BRAND_CATALOG_SEGMENTVIEW:
//        {
//            if (IOS7_OR_LATER)
//            {
//                if (self.service.sugdirsArray.count < 5)
//                {
//                    return 64 + 54 + 40 + 75;
//                }
//                else if (self.service.sugdirsArray.count == 0)
//                    return 64 + 40 + 75;
//                else
//                    return 64 + 93 + 40 + 75;
//            }
//            else
//            {
//                if (self.service.sugdirsArray.count < 5)
//                {
//                    return 44 + 54 + 40 + 75;
//                }
//                else if (self.service.sugdirsArray.count == 0)
//                    return 44 + 40 + 75;
//                else
//                    return 44 + 93 + 40 + 75;
//            }
//        }
//        default:
//            break;
//    }
    
    return 0;
}

- (SearchSegmentView *)searchsegmentView
{
    if (!_searchsegmentView)
    {
        CGRect frame;

//        if (IOS7_OR_LATER)
//        {
//            frame = CGRectMake(0, 64, 320, 40);
//        }
//        else
//        {
//            frame = CGRectMake(0, 44, 320, 40);
//        }
        
        frame = CGRectMake(0, 0, 320, 40);
        
        _searchsegmentView = [[SearchSegmentView alloc] initWithFrame:frame];
        _searchsegmentView.delegate = self;
    }
    return _searchsegmentView;
}

- (SearchListTopView *)searchTopView
{
    if (!_searchTopView)
    {
        int y = 44;
        if (IOS7_OR_LATER)
            y = 64;
        _searchTopView = [[SearchListTopView alloc] initWithFrame:CGRectMake(0, y, 320, 40)];
        _searchTopView.delegate = self;
        _searchTopView.searchSegmentView = self.searchsegmentView;
        
        
    }
    
    return _searchTopView;
}

#pragma mark - searchTop delegate
- (void)usualCatalogTapped:(NSString *)ci
{
    if (self.searchQueryRecommendedBrandService.brandList)//有热销品牌时，传过来的ci其实是品牌对应的cf
    {
//        self.searchCondition.brandRecommended = ci;
        if (ci.length > 4)
        {
            ci = [ci substringFromIndex:4];
            [self.searchCondition.checkedFilters setObject:ci forKey:@"bnf"];
            [self refreshData];
        }
    }
    else
    {
        self.searchCondition.categoryId = ci;
        [self refreshData];
    }
    
}

- (void)brandShopTapped:(NSString *)url
{
    NSString *strUrl = [url copy];
    if (NotNilAndNull(strUrl) && strUrl.length > 19)
    {
        strUrl = [strUrl substringWithRange:NSMakeRange(11, 8)]; //获取店铺编码，进行拼接
        strUrl = [NSString stringWithFormat:@"00%@", strUrl];
        NSString *jumpUrl = [NSString stringWithFormat:shopJumpToUrlHost, strUrl];
        SNWebViewController *webv = [[SNWebViewController alloc] initWithRequestUrl:jumpUrl];
        [self.navigationController pushViewController:webv animated:YES];
        
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"820601", nil]];
    }
}

- (void)resetTopView
{
    if (self.isKeywordSearch)
    {
        if (!self.service.isJianCi)
        {
            if (self.searchQueryRecommendedBrandService.brandList && self.searchQueryRecommendedBrandService.brandList.count > 0)
            {
                _searchTopView.catalogArray = self.searchQueryRecommendedBrandService.brandList;
                if (self.searchQueryRecommendedBrandService.brandList.count == 0)
                    _searchTopView.State = SEGMENTVIEW;
                else
                    _searchTopView.State = CATALOG_SEGMENTVIEW;
            }
            else
            {
                if (!self.service.brandShopDTO && !self.service.sugdirsArray)  //无旗舰店，无常用分类
                {
                    _searchTopView.State = SEGMENTVIEW;
                }
                else if (!self.service.brandShopDTO && self.service.sugdirsArray)  //无旗舰店,有常用分类
                {
                    _searchTopView.catalogArray = self.service.sugdirsArray;
                    _searchTopView.State = CATALOG_SEGMENTVIEW;
                }
                else if (!self.service.sugdirsArray && self.service.brandShopDTO)  //无常用分类,有旗舰店
                {
                    _searchTopView.brandShopDto = self.service.brandShopDTO;
                    _searchTopView.State = BRAND_SEGMENTVIEW;
                }
                else   // 旗舰店，分类，segment 都有
                {
                    _searchTopView.brandShopDto = self.service.brandShopDTO;
                    _searchTopView.catalogArray = self.service.sugdirsArray;
                    _searchTopView.State = BRAND_CATALOG_SEGMENTVIEW;
                }
                
            }
            
        }
        else if (self.service.isJianCi || !IsStrEmpty(self.service.errorMsg))
        {
            _searchTopView.State = NOVIEW;
        }
    }
    
    
    
    [_searchTopView.tableView reloadData];
    _searchTopView.tableView.frame = _searchTopView.bounds;
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
//    self.tableView.contentOffset = CGPointMake(0, -kTableViewInsetTopWithoutKeyWord);

    self.footView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height - kTableViewInsetTopWithoutKeyWord);
//    self.footView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height - 100);
  
    CGFloat posY = self.footView.height - 200;
    self.footRecommendView.frame = CGRectMake(0, posY, 320, 200);
}

- (UIToolbar *)statusbarBack
{
    if (!_statusbarBack)
    {
        if (IOS7_OR_LATER)
        {
            _statusbarBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            _statusbarBack.translucent = YES;
                       // _statusbarBack.barTintColor = RGBCOLOR(247, 247, 248);
            [_statusbarBack setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(320, 20)] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }
        else
        {
            _statusbarBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
    }
    
    return _statusbarBack;
}

- (UINavigationBar *)customNavigationBar
{
    if (!_customNavigationBar)
    {
        if (IOS7_OR_LATER)
        {
            _customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
            [_customNavigationBar setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(320, 64)] forBarMetrics:UIBarMetricsDefault];
            _customNavigationBar.translucent = YES;

            _customNavigationBar.shadowImage = [UIImage imageWithColor:[UIColor colorWithRGBHex:0xdcdcdc] size:CGSizeMake(320, 1)];
            //_customNavigationBar.barTintColor = RGBCOLOR(247, 247, 248);
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            view.clipsToBounds = NO;
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:self.navLeftBtn];
            [view addSubview:self.searchTextField];
            [view addSubview:self.filterButton];
            [view addSubview:self.searchCancelButton];
            [view addSubview:self.zxingBtn];
            [view addSubview:self.searchTypeBtn];
            [view addSubview:self.showModelBtn];
            
           
            
            self.searchTypeBtn.hidden = YES;
            [self.searchCancelButton setHidden:YES];
            
//            UIImageView *vSepline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44.5, 320, 0.5)];
//            vSepline.image = [UIImage imageNamed:@"line"];
//            UIView *vSepline = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, 320, 0.5)];
//            vSepline.backgroundColor = RGBCOLOR(220, 220, 220);
//            [view addSubview:vSepline];

            [_customNavigationBar addSubview:view];
        }
        else
        {
            _customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            _customNavigationBar.translucent = NO;
            
            UIImage *image = [UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(320, 44)];
            
            if ([_customNavigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
            {
                [_customNavigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            }
            else
            {
                _customNavigationBar.layer.contents = (id)image.CGImage;
            }

            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:self.navLeftBtn];
            [view addSubview:self.searchTextField];
            [view addSubview:self.filterButton];
            [view addSubview:self.searchCancelButton];
            [view addSubview:self.zxingBtn];
            [view addSubview:self.searchTypeBtn];
            [view addSubview:self.showModelBtn];
            
            
            
            self.searchTypeBtn.hidden = YES;
            [self.searchCancelButton setHidden:YES];

            [_customNavigationBar addSubview:view];

        }
    }
    return _customNavigationBar;
}

- (UIButton *)searchTypeBtn
{
    if (!_searchTypeBtn)
    {
        if (!_searchTypeBtn)
        {
            _searchTypeBtn = [[UIButton alloc] init];
            _searchTypeBtn.frame = CGRectMake(6, 7, 60, 28);
            
            if (IOS7_OR_LATER)
            {
                _searchTypeBtn.backgroundColor = [UIColor clearColor];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
            }
            else
            {
                _searchTypeBtn.backgroundColor = [UIColor clearColor];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
                
            }
            
            int searchType = [[Config currentConfig].searchType intValue];
            if (searchType == 0)
            {
                [_searchTypeBtn setTitle:L(@"Search_Goods") forState:UIControlStateNormal];
            }
            else if (searchType == 1)
            {
                [_searchTypeBtn setTitle:L(@"Search_Store") forState:UIControlStateNormal];
            }
            
            [_searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_downArrowGray.png"] forState:UIControlStateNormal];
            
            _searchTypeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
            _searchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
            //            _searchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
            
            _searchTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            
            _searchTypeBtn.hidden = YES;
            _searchTypeBtn.tag = 3001;
            [_searchTypeBtn addTarget:self action:@selector(searchTypeBtnTapped) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
    }
    
    return _searchTypeBtn;
}

- (void)searchTypeBtnTapped
{
    [ChooseSearchTypeView showOnWindow];
    
    [_searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_upArrowGray.png"] forState:UIControlStateNormal];
}


- (UIButton *)navLeftBtn
{
    if (!_navLeftBtn)
    {
        _navLeftBtn = [[UIButton alloc] init];
        if (IOS7_OR_LATER)
        {
            _navLeftBtn.frame = CGRectMake(0, 0, 41, 41);
        }
        else
        {
            _navLeftBtn.frame = CGRectMake(0, 0, 41, 41);
        }
        
        _navLeftBtn.tag = 100;
//        [_navLeftBtn setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
//        [_navLeftBtn setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
        [_navLeftBtn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btnForeGround = [[UIButton alloc] init];
        btnForeGround.frame = CGRectMake(15, 10, 12, 20);
        [btnForeGround setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
        [btnForeGround setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
        [btnForeGround addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
        
        [_navLeftBtn addSubview:btnForeGround];
    }
    return _navLeftBtn;
}

- (void)backForePage
{
    NSArray *viewCtrls = self.parentViewController.navigationController.viewControllers;
    
    if (self.needBackForePage == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (viewCtrls.count >= 2)
    {
        UIViewController *v = (UIViewController *)[viewCtrls objectAtIndex:1];
        if ([v isKindOfClass:[NextCategoryViewController class]])
        {
            [self.parentViewController.navigationController popToViewController:v animated:YES];
        }
        else
        {
            [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#define BIGVIEW_BTN_WIDTH 24
- (SearchTextField *)searchTextField
{
    if (!_searchTextField)
    {
        _searchTextField = [[SearchTextField alloc] init];
        _searchTextField.placeholder = L(@"Search_SearchGoodAndStore");
        _searchTextField.editingRect = CGRectMake(27, 0, 140 - BIGVIEW_BTN_WIDTH, 30);
        _searchTextField.clearButtonRect = CGRectMake(187 - 20, 0, 20, 30);
        _searchTextField.borderRect = CGRectMake(0, 0, 212 - BIGVIEW_BTN_WIDTH, 30);
        _searchTextField.leftViewRect = CGRectMake(5, 6, 22, 17);
        UIImageView *imgIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        imgIconView.image = [UIImage imageNamed:@"Search_ZoomInIcon"];
        imgIconView.contentMode = UIViewContentModeBottomLeft;
        _searchTextField.leftView = imgIconView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        
        if (IOS7_OR_LATER)
        {
            _searchTextField.frame = CGRectMake(42, 7, 212 - BIGVIEW_BTN_WIDTH, 30);
        }
        else
            _searchTextField.frame = CGRectMake(42, 7, 212 - BIGVIEW_BTN_WIDTH, 30);
        
        //_searchTextField.background = [UIImage streImageNamed:@"search_searchlist_searchTextfieldBack"];
        _searchTextField.layer.borderWidth = 0.5;
        _searchTextField.layer.borderColor = [UIColor colorWithRGBHex:0xd8d8d8].CGColor;
        _searchTextField.layer.cornerRadius = 1;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.font = [UIFont systemFontOfSize:14.0];
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchTextField.delegate = self;
        _searchTextField.textColor = RGBCOLOR(74, 74, 74);
        [_searchTextField addTarget:self action:@selector(beginSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_searchTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.tag = 101;
  
        _searchTextField.inputAccessoryView = self.keyboardView;
    }
    return _searchTextField;
}

- (VoiceSearchKeyboardView *)keyboardView
{
    if (!_keyboardView)
    {
        _keyboardView = [[VoiceSearchKeyboardView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _keyboardView.delegate = self;
    }
    
    return _keyboardView;
}
#pragma mark - 语音按钮代理
- (void)btnSpeakerTapped
{
    [VoiceSearchViewController sharedVoiceSearchCtrl].from = From_SearchList;
    [[VoiceSearchViewController sharedVoiceSearchCtrl] showVoiceSearchView];
    
    [self.searchTextField resignFirstResponder];
}

- (UIButton *)filterButton
{
    if (!_filterButton)
    {
        _filterButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 7, 48, 30)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(6, 3, 20, 24)];
        [btn setBackgroundImage:[UIImage imageNamed:@"searchList_FilterBtn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showFilterView:) forControlEvents:UIControlEventTouchUpInside];
        [_filterButton addSubview:btn];
//        
//        _filterButton.layer.borderWidth = 1;
//        _filterButton.layer.borderColor = RGBCOLOR(120, 120, 120).CGColor;
//        [_filterButton setTitle:L(@"Filter") forState:UIControlStateNormal];
        _filterButton.titleLabel.font = [UIFont systemFontOfSize:16];
//        [_filterButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
//        [_filterButton setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
//        [_filterButton setBackgroundImage:[UIImage imageNamed:@"searchList_FilterBtn"] forState:UIControlStateNormal];
        _filterButton.backgroundColor = [UIColor clearColor];
        _filterButton.adjustsImageWhenHighlighted = YES;
        [_filterButton addTarget:self action:@selector(showFilterView:) forControlEvents:UIControlEventTouchUpInside];
        _filterButton.tag = 102;
    }
    return _filterButton;
}

- (UIButton*)searchCancelButton
{
    if (!_searchCancelButton)
    {
        _searchCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 7, 48, 30)];
   
        [_searchCancelButton setTitle:L(@"Cancel") forState:UIControlStateNormal];
        _searchCancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_searchCancelButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [_searchCancelButton setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateHighlighted];
        _searchCancelButton.backgroundColor = [UIColor clearColor];
        [_searchCancelButton addTarget:self action:@selector(cancelSearch:) forControlEvents:UIControlEventTouchUpInside];
        _searchCancelButton.tag = 103;
    }
    return _searchCancelButton;
}


- (UIButton *)showModelBtn
{
    if (!_showModelBtn)
    {
        _showModelBtn = [[UIButton alloc] initWithFrame:CGRectMake(235, 7, 40, 30)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 3, 20, 24)];
        [btn setBackgroundImage:[UIImage imageNamed:@"searchList_BigViewModel"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeShowModel:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000;
        
        UIView *sepline = [[UIView alloc] initWithFrame:CGRectMake(37, 0, 0.5, 20)];
        sepline.backgroundColor = RGBCOLOR(230, 230, 230);
        [_showModelBtn addSubview:sepline];
        [_showModelBtn addSubview:btn];
    
//        [_showModelBtn setBackgroundImage:[UIImage imageNamed:@"searchList_BigViewModel"] forState:UIControlStateNormal];
        _showModelBtn.backgroundColor = [UIColor clearColor];
        [_showModelBtn addTarget:self action:@selector(changeShowModel:) forControlEvents:UIControlEventTouchUpInside];
        _showModelBtn.tag = 104;
    }
    return _showModelBtn;
}

- (void)changeShowModel:(id)sender
{
    self.showModel = !self.showModel;
    UIButton *btn = (UIButton *)[self.showModelBtn viewWithTag:1000];
    if (_showModel == SmallView)
    {
        
        [btn setBackgroundImage:[UIImage imageNamed:@"searchList_BigViewModel"] forState:UIControlStateNormal];
    }
    else if (_showModel == BigView)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"searchList_ListViewMode"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"820206", nil]];
}

- (UIButton *)zxingBtn
{
    if (!_zxingBtn)
    {
        _zxingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _zxingBtn.frame = CGRectMake(264 , 7, 35, 35);
        
        //[readerButton_ setImage:[UIImage imageNamed:@"QR_code.png"] forState:UIControlStateNormal];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 31, 28)];
        imgV.userInteractionEnabled = NO;
        imgV.image = [UIImage imageNamed:@"Newhome_QR_code.png"];
        
        [_zxingBtn addSubview:imgV];
        
        [_zxingBtn addTarget:self action:@selector(readerBegin) forControlEvents:UIControlEventTouchUpInside];
        
        _zxingBtn.hidden = YES;
    }
    return _zxingBtn;
}

- (SNReaderController *)readerController
{
    if (!_readerController) {
        _readerController = [[SNReaderController alloc] initWithContentController:self];
        //        _readerController.rootControl = SEARCH_PAGE_TYPE;
    }
    return _readerController;
}

- (void)readerBegin
{
    [self.readerController beginReader];
}

- (void)showFilterView:(id)sender
{
    self.FilterCtrl.categoryList = self.service.categoryList;
    self.FilterCtrl.filterList = [self.service.filterList mutableCopy];
    self.FilterCtrl.searchCondition = self.searchCondition;
    self.FilterCtrl.delegate = self;
//    self.FilterCtrl.iOS7FullScreenLayout = YES;
    if (!self.FilterCtrl.view.superview)
    {
        [self.FilterCtrl showOnWindow];
    }
//    [self.navigationController pushViewController:self.FilterCtrl animated:YES];
}

- (FilterPopupViewController *)FilterCtrl
{
    if (!_FilterCtrl)
    {
        _FilterCtrl = [[FilterPopupViewController alloc] init];
    }
    
    return _FilterCtrl;
}

- (void)cancelSearch:(id)sender
{
    [self.searchTextField resignFirstResponder];
    self.searchTextField.text = _searchCondition.keyword;
    
//    if (!self.tableView.tableFooterView) //搜索无结果页面要继续隐藏筛选按钮
//    {
//       
//    }
//    else
//    {
//        self.filterButton.hidden = YES;
//        self.zxingBtn.hidden = NO;
//    }
//    self.searchCancelButton.hidden = YES;
    
    if (self.service.productList.count == 0 || !self.service.productList)
    {
        [self showButtons:NORESULT];
    }
    else
    {
        [self showButtons:NORMAL];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
//    NSString *pageName = nil;
//    if (self.searchCondition.searchType == SearchTypeKeyword) {
//        pageName = self.searchCondition.keyword;
//    }else{
//        pageName = self.searchCondition.title;
//    }
//    pageName = [NSString stringWithFormat:@"%@-%@",L(@"search_searchResult"),pageName];
//    self.pageTitle = pageName;
    
    if (_searchCondition.keyword) {
        self.isKeywordSearch = YES;
        self.pageTitle =[NSString stringWithFormat:@"%@-%@",L(@"search_searchResult"),_searchCondition.keyword] ;
    }
    else
    {
        self.isKeywordSearch = NO;
        self.pageTitle =[NSString stringWithFormat:@"%@-%@",L(@"search_searchResult_category"),_searchCondition.categoryName];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self  showTopBars];


}

#pragma mark -
#pragma mark views

- (SearchSectionHeaderView *)sectionHeaderView
{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[SearchSectionHeaderView alloc] init];
        _sectionHeaderView.delegate = self;
    }
    return _sectionHeaderView;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] init];
        
        _footView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height - kTableViewInsetTopWithoutKeyWord);
        //        if (isKeywordSearch) {
        //            _footView.height-=30;   //去掉商品toolBar
        //        }
        _footView.backgroundColor = [UIColor clearColor];
        
        

    }
    return _footView;
}

- (void)changeFootViewStyle:(BOOL)isKeyWordSearch
{
    [self.footView removeAllSubviews];
    if (isKeyWordSearch)
    {
        UIView *vWhiteBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.tableView.frame.size.height - kTableViewInsetTopWithoutKeyWord - 200)];
        vWhiteBack.backgroundColor = [UIColor whiteColor];
        
        UIView *vBottomGrayLine = [[UIView alloc] initWithFrame:CGRectMake(0, vWhiteBack.height - 0.5, vWhiteBack.frame.size.width, 0.5)];
        vBottomGrayLine.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
//        [vWhiteBack addSubview:vBottomGrayLine];
        
        UIImageView *notFoundImgView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 75) / 2, 50, 75, 75)];
        notFoundImgView.image = [UIImage imageNamed:@"Search_notFoundNew"];
        notFoundImgView.tag = 200;
        
        OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 140, 320, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.automaticallyAddLinksForType = 0;
        label.underlineLinks = NO;
        label.tag = 100;
        NSString *keyword = self.searchCondition.keyword;
        
        NSString *str;
        if (keyword)
            str = [NSString stringWithFormat:@"%@，%@%@",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_RelevantGoods")];
        else
            str = [NSString stringWithFormat:@"%@，%@%@",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_RelevantGoods")];
        NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:str];
        [muteStr setFont:[UIFont systemFontOfSize:14.0]];
        [muteStr setTextColor:[UIColor colorWithRGBHex:0x707070]];
        
        if (keyword)
        {
            [muteStr setTextColor:[UIColor colorWithRGBHex:0xfc7c26] range:[str rangeOfString:keyword]];
        }
        [muteStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByTruncatingTail];
        label.attributedText = muteStr;
        
        [_footView addSubview:vWhiteBack];
        [_footView addSubview:notFoundImgView];
        [_footView addSubview:label];
    }
    else
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 320, 35)];
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:14.0];
       // label1.text = @"没有筛选到相关商品";
        label1.text = @"";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = RGBCOLOR(116, 116, 116);
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 35)];
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:13.0];
        label2.text = [NSString stringWithFormat:@"%@，%@%@！",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_MatchConditionGoods")];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = RGBCOLOR(185, 185, 185);
        
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(115, 135, 88, 30)];
//        [btn setTitle:@"重新筛选" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn setBackgroundColor:RGBCOLOR(250, 105, 3)];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [btn addTarget:self action:@selector(rePick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_footView addSubview:label1];
        [_footView addSubview:label2];
//        [_footView addSubview:btn];
    }
}

- (void)rePick:(id)sender
{
    [self showFilterView:nil];
}

- (void)refreshNotFoundInfo
{
    if (self.footView)
    {
        OHAttributedLabel *label = (OHAttributedLabel *)[self.footView viewWithTag:100];
        if (label && [label isKindOfClass:[OHAttributedLabel class]])
        {
            NSString *keyword = self.searchCondition.keyword;
            
            NSString *str;
            if (keyword)
                str = [NSString stringWithFormat:@"%@，%@%@",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_RelevantGoods")];
            else
                str = [NSString stringWithFormat:@"%@，%@%@",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_RelevantGoods")];
            NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:str];
            [muteStr setFont:[UIFont systemFontOfSize:14.0]];
            [muteStr setTextColor:[UIColor colorWithRGBHex:0x707070]];
            
            if (keyword)
            {
                [muteStr setTextColor:[UIColor colorWithRGBHex:0xfc7c26] range:[str rangeOfString:keyword]];
            }
            [muteStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByTruncatingTail];
            
            label.attributedText = muteStr;
        }
    }
}

- (void)refreshNotFoundInfoWithErrorMsg:(NSString *)errorMsg
{
    if (self.footView)
    {
        OHAttributedLabel *label = (OHAttributedLabel *)[self.footView viewWithTag:100];
        if (label && [label isKindOfClass:[OHAttributedLabel class]])
        {
            if (errorMsg)
            {
                NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:errorMsg];
                [muteStr setFont:[UIFont systemFontOfSize:14.0]];
                [muteStr setTextColor:[UIColor colorWithRGBHex:0x707070]];
                
                [muteStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByTruncatingTail];
                
                label.attributedText = muteStr;

            }
        }
        
        UIImageView *v = (UIImageView *)[self.footView viewWithTag:200];
        if (v)
        {
            v.image = [UIImage imageNamed:@"searchList_NetWork"];
        }
    }
}

- (UIFootRecommendView *)footRecommendView
{
    if (!_footRecommendView) {
        _footRecommendView = [[UIFootRecommendView alloc]
                              initWithFrame:CGRectZero];
        
        CGFloat posY = self.footView.height - 200;
        _footRecommendView.frame = CGRectMake(0, posY, 320, 200);
        _footRecommendView.backgroundColor = RGBCOLOR(243, 243, 243);
        
        _footRecommendView.delegate = self;
    }
    return _footRecommendView;
}

- (AssociationalAndHistoryWordDisplayController *)keywordDisplayController
{
    if (!_keywordDisplayController) {
        _keywordDisplayController = [[AssociationalAndHistoryWordDisplayController alloc]
                                     initWithContentController:self];
        if (IOS7_OR_LATER)
            _keywordDisplayController.tableTopPosY = 64;
        else
            _keywordDisplayController.tableTopPosY = 44;
        _keywordDisplayController.distanceToTop = 20 + 44;
        _keywordDisplayController.delegate = self;
    }
    return _keywordDisplayController;
}

- (SNPopoverController *)catePopoverController
{
    if (!_catePopoverController) {
        _catePopoverController =
        [[SNPopoverController alloc] initWithContentController:self.catePickController];
    }
    return _catePopoverController;
}

- (SNPopoverController *)cityPopoverController
{
    if (!_cityPopoverController) {
        _cityPopoverController =
        [[SNPopoverController alloc] initWithContentController:self.cityPickController];
    }
    return _cityPopoverController;
}

- (SNPopoverController *)filterPopoverController
{
    if (!_filterPopoverController) {
        _filterPopoverController =
        [[SNPopoverController alloc] initWithContentController:self.filterPickController];
    }
    return _filterPopoverController;
}

- (CatePickViewController *)catePickController
{
    if (!_catePickController) {
        _catePickController =
        [[CatePickViewController alloc] initWithCateList:self.service.categoryList];
        _catePickController.delegate = self;
    }
    return _catePickController;
}

- (ProvincePickViewController *)cityPickController
{
    if (!_cityPickController) {
        _cityPickController =
        [[ProvincePickViewController alloc] init];
        _cityPickController.delegate = self;
    }
    return _cityPickController;
}

- (FilterPickViewController *)filterPickController
{
    if (!_filterPickController) {
        _filterPickController =
        [[FilterPickViewController alloc] initWithFitlerList:self.service.filterList];
        _filterPickController.delegate = self;
        _filterPickController.searchCondition = self.searchCondition;
    }
    return _filterPickController;
}

#pragma mark - Search Textfiled Delegate Methods

- (void)beginSearch:(id)sender
{
    [ChooseSearchTypeView hide];
    [self didSelectAssociationalWord:self.searchTextField.text];
}

- (void)textChanged:(id)sender
{
    self.keywordDisplayController.keyWord = self.searchTextField.text;
    [self.keywordDisplayController refreshViewWithKeyword:self.searchTextField.text];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.keywordDisplayController displayView:nil];
    [self showButtons:SHOWING_TEXTFIELD];
    
    
    if (_searchCondition.keyword)
        self.searchTextField.text = _searchCondition.keyword;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.keywordDisplayController.keyWord = _searchCondition.keyword;
    [self.keywordDisplayController refreshViewWithKeyword:_searchCondition.keyword];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.service.productList.count == 0 || self.service.productList)
    {
        [self showButtons:NORESULT];
    }
    else
    {
        [self showButtons:NORMAL];
    }
    
    [self.keywordDisplayController removeView];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    // _searchCondition.keyword = string;
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.keywordDisplayController.keyWord = nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

#pragma mark -
#pragma mark Table View DataSource And Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.showModel == SmallView)
    {
        if (self.service.isJianCi)
            return 2;
        return 1;
    }
    else if (self.showModel == BigView)
    {
        if (self.service.isJianCi)
            return 2;
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.showModel == SmallView)
    {
        if (self.service.isJianCi)
        {
            if (section == 0)
            {
                return 1;
            }
            else if (section == 1)
            {
                if (_service.productList && [_service.productList count] > 0) {
                    if ([self hasMore]) {
                        return [_service.productList count] + 1;
                    }
                    return [_service.productList count];
                }
                if (_footViewType == SearchResultViewLoading ||
                    _footViewType == SearchResultViewNormal) {
                    return 0;
                }else{
                    return 0;
                }
            }
        }
        else
        {
            if (_service.productList && [_service.productList count] > 0) {
                if ([self hasMore]) {
                    return [_service.productList count] + 1;
                }
                return [_service.productList count];
            }
            if (_footViewType == SearchResultViewLoading ||
                _footViewType == SearchResultViewNormal) {
                return 0;
            }else{
                return 0;
            }
        }
    }
    else if (self.showModel == BigView)
    {
        if (self.service.isJianCi)
        {
            if (section == 0)
            {
                return 1;
            }
            else if (section == 1)
            {
                if (_service.productList && [_service.productList count] > 0)
                {
                    int rows = 0;
                
                    if (_service.productList.count % 2 == 0)
                    {
                        rows = _service.productList.count / 2;
                    }
                    else
                    {
                        rows = _service.productList.count / 2 + 1;
                    }

                    if ([self hasMore]) {
                        rows += 1;
                    }
                    
                    return rows;
                }
                else
                    return 0;
                
                if (_footViewType == SearchResultViewLoading ||
                    _footViewType == SearchResultViewNormal) {
                    return 0;
                }else{
                    return 0;
                }
            }
        }
        else
        {
            if (_service.productList && [_service.productList count] > 0) {
                int rows = 0;
                
                if (_service.productList.count % 2 == 0)
                {
                    rows = _service.productList.count / 2;
                }
                else
                {
                    rows = _service.productList.count / 2 + 1;
                }
                
                if ([self hasMore]) {
                    rows += 1;
                }
                
                return rows;
            }
            else
                return 0;
            
            if (_footViewType == SearchResultViewLoading ||
                _footViewType == SearchResultViewNormal) {
                return 0;
            }else{
                return 0;
            }
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showModel == SmallView)
    {
        if (self.service.isJianCi)
        {
            if (indexPath.section == 0)
            {
                return 105;
            }
            else if (indexPath.section == 1)
            {
                if (_service.productList && _service)
                {
                    if (indexPath.row == _service.productList.count) //加载更多cell
                        return 52;
                }
                
                return 105;
            }
        }
        else
        {
            if (_service.productList && _service)
            {
                if (indexPath.row == _service.productList.count) //加载更多cell
                    return 52;
            }
            
            return 105;
        }

    }
    else if (self.showModel == BigView)
    {
        if (self.service.isJianCi)
        {
            if (indexPath.section == 0)
            {
                return 105;
            }
            else if (indexPath.section == 1)
            {
                if (_service.productList && _service)
                {
                    if (_service.productList.count % 2 == 0)
                    {
                        if ([self hasMore])
                        {
                            if (indexPath.row == _service.productList.count / 2)
                            {
                                return 52;
                            }
                        }
                    }
                    else
                    {
                        if ([self hasMore])
                        {
                            if (indexPath.row == _service.productList.count / 2 + 1)
                                return 52;
                        }
                    }
                }
                
                return 230;
            }
        }
        else
        {
            if (_service.productList && _service)
            {
                if (_service.productList.count % 2 == 0)
                {
                    if ([self hasMore])
                    {
                        if (indexPath.row == _service.productList.count / 2)
                        {
                            return 52;
                        }
                    }
                }
                else
                {
                    if ([self hasMore])
                    {
                        if (indexPath.row == _service.productList.count / 2 + 1)
                            return 52;
                    }
                }

            }
            
            return 230;
        }

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showModel == SmallView)
    {
        if (self.service.isJianCi)
        {
            if (indexPath.section == 0)
            {
                static NSString *strJianCiTip = @"cellForTip";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strJianCiTip];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strJianCiTip];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UILabel *labelTip1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 130, 20)];
                    labelTip1.backgroundColor = [UIColor clearColor];
                    labelTip1.numberOfLines = 1;
                    labelTip1.font = [UIFont systemFontOfSize:14];
                    labelTip1.textAlignment = NSTextAlignmentRight;
                    labelTip1.textColor = RGBCOLOR(115, 115, 115);
                    labelTip1.tag = 1000;
                    
                    UILabel *labelTip11 = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 90, 20)];
                    labelTip11.backgroundColor = [UIColor clearColor];
                    labelTip11.numberOfLines = 1;
                    labelTip11.font = [UIFont systemFontOfSize:14];
                    labelTip11.textColor = RGBCOLOR(250, 85, 0);
                    labelTip11.textAlignment = NSTextAlignmentCenter;
                    labelTip11.tag = 1001;
                    
                    
                    UILabel *labelTip12 = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 100, 20)];
                    labelTip12.backgroundColor = [UIColor clearColor];
                    labelTip12.numberOfLines = 1;
                    labelTip12.font = [UIFont systemFontOfSize:14];
                    labelTip12.textAlignment = NSTextAlignmentLeft;
                    labelTip12.textColor = RGBCOLOR(115, 115, 115);
                    labelTip12.tag = 1002;
                    
                    
                    
                    UILabel *labelTip2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 110, 20)];
                    labelTip2.backgroundColor = [UIColor clearColor];
                    labelTip2.numberOfLines = 1;
                    labelTip2.font = [UIFont systemFontOfSize:12];
                    labelTip2.textAlignment = NSTextAlignmentRight;
                    labelTip2.textColor = RGBCOLOR(175, 175, 175);
                    labelTip2.tag = 2000;
                    
                    UIButton *btnKeyWord = [[UIButton alloc] initWithFrame:CGRectMake(150, 40, 60, 20)];
                    btnKeyWord.titleLabel.font = [UIFont systemFontOfSize:13.0];
                    btnKeyWord.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                    btnKeyWord.layer.borderWidth = 0.5;
                    btnKeyWord.layer.borderColor = RGBCOLOR(216, 216, 216).CGColor;
                    [btnKeyWord setTitleColor:RGBCOLOR(251, 124, 39) forState:UIControlStateNormal];
                    [btnKeyWord addTarget:self action:@selector(research:) forControlEvents:UIControlEventTouchUpInside];
                    btnKeyWord.tag = 2001;
                    
                    
                    UILabel *labelTip22 = [[UILabel alloc] initWithFrame:CGRectMake(215, 40, 110, 20)];
                    labelTip22.backgroundColor = [UIColor clearColor];
                    labelTip22.numberOfLines = 1;
                    labelTip22.font = [UIFont systemFontOfSize:12];
                    labelTip22.textAlignment = NSTextAlignmentLeft;
                    labelTip22.textColor = RGBCOLOR(175, 175, 175);
                    labelTip22.tag = 2002;
                    
                    UILabel *labelTip3 = [[UILabel alloc] initWithFrame:CGRectMake(90, 60, 320, 20)];
                    labelTip3.backgroundColor = [UIColor clearColor];
                    labelTip3.numberOfLines = 1;
                    labelTip3.font = [UIFont systemFontOfSize:12];
                    labelTip3.tag = 3000;
                    labelTip3.textColor = RGBCOLOR(175, 175, 175);
                    
                    UIImageView *sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104.5, 320, 0.5) ];
                    sepLine.image = [UIImage imageNamed:@"line"];
                    
                    [cell.contentView addSubview:labelTip1];
                    [cell.contentView addSubview:labelTip11];
                    [cell.contentView addSubview:labelTip12];
                    [cell.contentView addSubview:labelTip2];
                    [cell.contentView addSubview:btnKeyWord];
                    [cell.contentView addSubview:labelTip22];
                    [cell.contentView addSubview:labelTip3];
                    [cell.contentView addSubview:sepLine];
                }
                
                UILabel *labelTip1 = (UILabel *)[cell.contentView viewWithTag:1000];
                if (labelTip1)
                {
                    labelTip1.text = [NSString stringWithFormat:@"%@，%@\"",L(@"Constant_Sorry"),L(@"Search_NotFound")];
                }
                
                UILabel *labelTip11 = (UILabel *)[cell.contentView viewWithTag:1001];
                if (labelTip11)
                {
                    //                [labelTip11 setTitle:self.searchCondition.keyword forState:UIControlStateNormal];
//                    labelTip11.text = self.searchCondition.keyword;
                    labelTip11.text = self.jianciKeyword;
                }
                
                UILabel *labelTip12 = (UILabel *)[cell.contentView viewWithTag:1002];
                if (labelTip12)
                {
                    labelTip12.text = [NSString stringWithFormat:@"\"%@",L(@"Search_RelevantGoods")];
                }
                
                UILabel *labelTip2 = (UILabel *)[cell.contentView viewWithTag:2000];
                if (labelTip2)
                {
                    labelTip2.text = [NSString stringWithFormat:@"%@ ",L(@"Search_PartOfTheSearchWords")];
                }
                
                UIButton *btnKeyword = (UIButton *)[cell.contentView viewWithTag:2001];
                if (btnKeyword)
                {
                    [btnKeyword setTitle:self.service.strJianCiKeyWord forState:UIControlStateNormal];
                    //                btnKeyword  = [NSString stringWithFormat:@"%@", self.service.strJianCiKeyWord];
                    //
                    //                CGSize size = [labelTip21.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(100, 20)];
                    //                labelTip21.width = size.width;
                }
                
                UILabel *labelTip22 = (UILabel *)[cell.contentView viewWithTag:2002];
                if (labelTip22)
                {
                    labelTip22.text = [NSString stringWithFormat:@" %@",L(@"Search_MatchingResults")];
                    //                labelTip22.left = labelTip21.right;
                }
                
                UILabel *labelTip3 = (UILabel *)[cell.contentView viewWithTag:3000];
                if (labelTip3)
                {
                    labelTip3.text = [NSString stringWithFormat:@"%@",L(@"Search_TryToRemoveTheWordSearch")];
                }
                
                return cell;
            }
            else if (indexPath.section == 1)
            {
                if ([self hasMore] && indexPath.row == [_service.productList count]) {
                    static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
                    
                    UITableViewMoreCell *moreCell =
                    (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
                    
                    if (moreCell == nil) {
                        moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:SearchMoreIdentifier];
                        moreCell.selectionStyle = UITableViewCellSelectionStyleBlue;
                        UIView *selectedBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
                        selectedBkView.backgroundColor = RGBCOLOR(228, 225, 206);
                        moreCell.selectedBackgroundView = selectedBkView;
                        moreCell.textLabel.font = [UIFont systemFontOfSize:15.0];
                    }
                    
                    moreCell.title = L(@"Get More...");
                    
                    [moreCell setAnimating:NO];
                    
                    return moreCell;
                }
                
                static NSString *productCellIdentifier = @"productCellIdentifier";
                SearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
                if (cell == nil) {
                    cell = [[SearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                if ([_service.productList count] <= indexPath.row) {
                    return cell;
                }
                
                DataProductBasic *productDTO = [_service.productList objectAtIndex:indexPath.row];
                
                NSString *cityId = productDTO.cityCode.length > 0 ? productDTO.cityCode : [Config currentConfig].defaultCity;
                
                [cell setItem:productDTO];
                
                //判断搜索条件：商家筛选是1或不传，请求的是苏宁自营的价格，否则是最优价格
                
//                if (productDTO.isTongmaProduct)
//                {
//                    cell.priceImageView.imageURL = [ProductUtil getPriceImageUrlWithPartNumber:productDTO.productCode city:cityId];
//                }
//                else
//                {
                    if ([self.searchCondition.shopNum isEqualToString:@"1"] || [self.searchCondition.shopNum isEqualToString:@""] )
                    {
                        cell.priceImageView.imageURL = [ProductUtil priceImageUrlOfProductId:productDTO.productId city:cityId];
                    }
                    else
                    {
                        cell.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:productDTO.productId city:cityId];
                    }
//                }
                
                return cell;
                
            }
        }
        else
        {
            if ([self hasMore] && indexPath.row == [_service.productList count]) {
                static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
                
                UITableViewMoreCell *moreCell =
                (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
                
                if (moreCell == nil) {
                    moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:SearchMoreIdentifier];
                    //                moreCell.contentView.backgroundColor = [UIColor clearColor];
                    //                moreCell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    //
                    //                moreCell.backgroundView.backgroundColor = [UIColor clearColor];
                    
                    moreCell.textLabel.font = [UIFont systemFontOfSize:15.0];
                }
                //            moreCell.textLabel.backgroundColor = [UIColor clearColor];
                
                //            UIView *selectedBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
                //            selectedBkView.backgroundColor = RGBCOLOR(228, 225, 206);
                //            moreCell.selectedBackgroundView = selectedBkView;
                
                moreCell.title = L(@"Get More...");
                
                [moreCell setAnimating:NO];
                
                return moreCell;
            }
            
            static NSString *productCellIdentifier = @"productCellIdentifier";
            SearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
            if (cell == nil) {
                cell = [[SearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            if ([_service.productList count] <= indexPath.row) {
                return cell;
            }
            
            DataProductBasic *productDTO = [_service.productList objectAtIndex:indexPath.row];
            
            NSString *cityId = productDTO.cityCode.length > 0 ? productDTO.cityCode : [Config currentConfig].defaultCity;
            
            [cell setItem:productDTO];
            
            //判断搜索条件：商家筛选是1或不传，请求的是苏宁自营的价格，否则是最优价格
            
//            if (productDTO.isTongmaProduct)
//            {
//                cell.priceImageView.imageURL = [ProductUtil getPriceImageUrlWithPartNumber:productDTO.productCode city:cityId];
//            }
//            else
//            {
                if ([self.searchCondition.shopNum isEqualToString:@"1"] || [self.searchCondition.shopNum isEqualToString:@""] )
                {
                    cell.priceImageView.imageURL = [ProductUtil priceImageUrlOfProductId:productDTO.productId city:cityId];
                }
                else
                {
                    cell.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:productDTO.productId city:cityId];
                }
//            }
            
            return cell;
        }

    }
    else if (BigView == self.showModel)
    {
        if (self.service.isJianCi)
        {
            if (indexPath.section == 0)
            {
                static NSString *strJianCiTip = @"cellForTip";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strJianCiTip];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strJianCiTip];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UILabel *labelTip1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 130, 20)];
                    labelTip1.backgroundColor = [UIColor clearColor];
                    labelTip1.numberOfLines = 1;
                    labelTip1.font = [UIFont systemFontOfSize:14];
                    labelTip1.textAlignment = NSTextAlignmentRight;
                    labelTip1.textColor = RGBCOLOR(115, 115, 115);
                    labelTip1.tag = 1000;
                    
                    UILabel *labelTip11 = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 90, 20)];
                    labelTip11.backgroundColor = [UIColor clearColor];
                    labelTip11.numberOfLines = 1;
                    labelTip11.font = [UIFont systemFontOfSize:14];
                    labelTip11.textColor = RGBCOLOR(250, 85, 0);
                    labelTip11.textAlignment = NSTextAlignmentCenter;
                    labelTip11.tag = 1001;
                    
                    
                    UILabel *labelTip12 = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 100, 20)];
                    labelTip12.backgroundColor = [UIColor clearColor];
                    labelTip12.numberOfLines = 1;
                    labelTip12.font = [UIFont systemFontOfSize:14];
                    labelTip12.textAlignment = NSTextAlignmentLeft;
                    labelTip12.textColor = RGBCOLOR(115, 115, 115);
                    labelTip12.tag = 1002;
                    
                    
                    
                    UILabel *labelTip2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 110, 20)];
                    labelTip2.backgroundColor = [UIColor clearColor];
                    labelTip2.numberOfLines = 1;
                    labelTip2.font = [UIFont systemFontOfSize:12];
                    labelTip2.textAlignment = NSTextAlignmentRight;
                    labelTip2.textColor = RGBCOLOR(175, 175, 175);
                    labelTip2.tag = 2000;
                    
                    UIButton *btnKeyWord = [[UIButton alloc] initWithFrame:CGRectMake(150, 40, 60, 20)];
                    btnKeyWord.titleLabel.font = [UIFont systemFontOfSize:13.0];
                    [btnKeyWord setTitleColor:RGBCOLOR(250, 85, 0) forState:UIControlStateNormal];
                    btnKeyWord.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                    btnKeyWord.layer.borderColor = RGBCOLOR(216, 216, 216).CGColor;
                    [btnKeyWord setTitleColor:RGBCOLOR(251, 124, 39) forState:UIControlStateNormal];
                    [btnKeyWord addTarget:self action:@selector(research:) forControlEvents:UIControlEventTouchUpInside];
                    btnKeyWord.tag = 2001;
                    
                    
                    UILabel *labelTip22 = [[UILabel alloc] initWithFrame:CGRectMake(215, 40, 110, 20)];
                    labelTip22.backgroundColor = [UIColor clearColor];
                    labelTip22.numberOfLines = 1;
                    labelTip22.font = [UIFont systemFontOfSize:12];
                    labelTip22.textAlignment = NSTextAlignmentLeft;
                    labelTip22.textColor = RGBCOLOR(175, 175, 175);
                    labelTip22.tag = 2002;
                    
                    UILabel *labelTip3 = [[UILabel alloc] initWithFrame:CGRectMake(90, 60, 320, 20)];
                    labelTip3.backgroundColor = [UIColor clearColor];
                    labelTip3.numberOfLines = 1;
                    labelTip3.font = [UIFont systemFontOfSize:12];
                    labelTip3.tag = 3000;
                    labelTip3.textColor = RGBCOLOR(175, 175, 175);
                    
                    UIImageView *sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104.5, 320, 0.5) ];
                    sepLine.image = [UIImage imageNamed:@"line"];
                    
                    [cell.contentView addSubview:labelTip1];
                    [cell.contentView addSubview:labelTip11];
                    [cell.contentView addSubview:labelTip12];
                    [cell.contentView addSubview:labelTip2];
                    [cell.contentView addSubview:btnKeyWord];
                    [cell.contentView addSubview:labelTip22];
                    [cell.contentView addSubview:labelTip3];
                    [cell.contentView addSubview:sepLine];
                }
                
                UILabel *labelTip1 = (UILabel *)[cell.contentView viewWithTag:1000];
                if (labelTip1)
                {
                    labelTip1.text = [NSString stringWithFormat:@"%@，%@\"",L(@"Constant_Sorry"),L(@"Search_NotFound")];
                }
                
                UILabel *labelTip11 = (UILabel *)[cell.contentView viewWithTag:1001];
                if (labelTip11)
                {
                    //                [labelTip11 setTitle:self.searchCondition.keyword forState:UIControlStateNormal];
//                    labelTip11.text = self.searchCondition.keyword;
                    labelTip11.text = self.jianciKeyword;
                }
                
                UILabel *labelTip12 = (UILabel *)[cell.contentView viewWithTag:1002];
                if (labelTip12)
                {
                    labelTip12.text = [NSString stringWithFormat:@"\"%@",L(@"Search_RelevantGoods")];
                }
                
                UILabel *labelTip2 = (UILabel *)[cell.contentView viewWithTag:2000];
                if (labelTip2)
                {
                    labelTip2.text = [NSString stringWithFormat:@"%@ ",L(@"Search_PartOfTheSearchWords")];
                }
                
                UIButton *btnKeyword = (UIButton *)[cell.contentView viewWithTag:2001];
                if (btnKeyword)
                {
                    [btnKeyword setTitle:self.service.strJianCiKeyWord forState:UIControlStateNormal];
                    //                btnKeyword  = [NSString stringWithFormat:@"%@", self.service.strJianCiKeyWord];
                    //
                    //                CGSize size = [labelTip21.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(100, 20)];
                    //                labelTip21.width = size.width;
                }
                
                UILabel *labelTip22 = (UILabel *)[cell.contentView viewWithTag:2002];
                if (labelTip22)
                {
                    labelTip22.text = [NSString stringWithFormat:@" %@",L(@"Search_MatchingResults")];
                    //                labelTip22.left = labelTip21.right;
                }
                
                UILabel *labelTip3 = (UILabel *)[cell.contentView viewWithTag:3000];
                if (labelTip3)
                {
                    labelTip3.text = [NSString stringWithFormat:@"%@",L(@"Search_TryToRemoveTheWordSearch")];
                }
                
                return cell;

            }
            else if (indexPath.section == 1)
            {
                
                //更多cell
                if (self.service.productList.count % 2 == 0)
                {
                    if ((indexPath.row == self.service.productList.count / 2) && [self hasMore])
                    {
                        static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
                        
                        UITableViewMoreCell *moreCell =
                        (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
                        
                        if (moreCell == nil) {
                            moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:SearchMoreIdentifier];
                            
                            moreCell.textLabel.font = [UIFont systemFontOfSize:15.0];
                        }
                        
                        moreCell.title = L(@"Get More...");
                        
                        [moreCell setAnimating:NO];
                        
                        return moreCell;
                    }
                }
                else
                {
                    if ((indexPath.row == self.service.productList.count / 2 + 1) && [self hasMore])
                    {
                        static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
                        
                        UITableViewMoreCell *moreCell =
                        (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
                        
                        if (moreCell == nil) {
                            moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:SearchMoreIdentifier];
                            
                            moreCell.textLabel.font = [UIFont systemFontOfSize:15.0];
                        }
                        
                        moreCell.title = L(@"Get More...");
                        
                        [moreCell setAnimating:NO];
                        
                        return moreCell;
                    }
                }
                
                static NSString *productCellIdentifier = @"BIGVIEWCELL";
                BigViewModelCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
                if (cell == nil) {
                    cell = [[BigViewModelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                int iLeftIndex = indexPath.row * 2;
                int iRightIndex = indexPath.row * 2 + 1;
                
                if (iLeftIndex >= 0  && iLeftIndex < self.service.productList.count)
                {
                    DataProductBasic *productDTOL = [self.service.productList objectAtIndex:iLeftIndex];
                    [cell setLeftItem:productDTOL];
                    NSString *cityId = productDTOL.cityCode.length > 0 ? productDTOL.cityCode : [Config currentConfig].defaultCity;
//                    if (productDTOL.isTongmaProduct)
//                    {
//                        cell.leftView.priceImageView.imageURL = [ProductUtil getPriceImageUrlWithPartNumber:productDTOL.productCode city:cityId];
//                    }
//                    else
//                    {
                        if ([self.searchCondition.shopNum isEqualToString:@"1"] || [self.searchCondition.shopNum isEqualToString:@""] )
                        {
                            cell.leftView.priceImageView.imageURL = [ProductUtil priceImageUrlOfProductId:productDTOL.productId city:cityId];
                        }
                        else
                        {
                            cell.leftView.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:productDTOL.productId city:cityId];
                        }
//                    }

                }
                
                if (iRightIndex >= 0 && iRightIndex < self.service.productList.count)
                {
                    DataProductBasic *productDTOR = [self.service.productList objectAtIndex:iRightIndex];
                    [cell setRightItem:productDTOR];
                    NSString *cityId = productDTOR.cityCode.length > 0 ? productDTOR.cityCode : [Config currentConfig].defaultCity;
//                    if (productDTOR.isTongmaProduct)
//                    {
//                        cell.rightView.priceImageView.imageURL = [ProductUtil getPriceImageUrlWithPartNumber:productDTOR.productCode city:cityId];
//                    }
//                    else
//                    {
                        if ([self.searchCondition.shopNum isEqualToString:@"1"] || [self.searchCondition.shopNum isEqualToString:@""] )
                        {
                            cell.rightView.priceImageView.imageURL = [ProductUtil priceImageUrlOfProductId:productDTOR.productId city:cityId];
                        }
                        else
                        {
                            cell.rightView.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:productDTOR.productId city:cityId];
                        }
//                    }

                }
                
                
                
                return cell;
                
            }
        }
        else
        {
            //更多cell
            if (self.service.productList.count % 2 == 0)
            {
                if ((indexPath.row == self.service.productList.count / 2) && [self hasMore])
                {
                    static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
                    
                    UITableViewMoreCell *moreCell =
                    (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
                    
                    if (moreCell == nil) {
                        moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:SearchMoreIdentifier];
                        
                        moreCell.textLabel.font = [UIFont systemFontOfSize:15.0];
                    }
                    
                    moreCell.title = L(@"Get More...");
                    
                    [moreCell setAnimating:NO];
                    
                    return moreCell;
                }
            }
            else
            {
                if ((indexPath.row == self.service.productList.count / 2 + 1) && [self hasMore])
                {
                    static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
                    
                    UITableViewMoreCell *moreCell =
                    (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
                    
                    if (moreCell == nil) {
                        moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:SearchMoreIdentifier];
                        
                        moreCell.textLabel.font = [UIFont systemFontOfSize:15.0];
                    }
                    
                    moreCell.title = L(@"Get More...");
                    
                    [moreCell setAnimating:NO];
                    
                    return moreCell;
                }
            }
            
            static NSString *productCellIdentifier = @"BIGVIEWCELL";
            BigViewModelCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
            if (cell == nil) {
                cell = [[BigViewModelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            int iLeftIndex = indexPath.row * 2;
            int iRightIndex = indexPath.row * 2 + 1;
            
            if (iLeftIndex >= 0  && iLeftIndex < self.service.productList.count)
            {
                DataProductBasic *productDTOL = [self.service.productList objectAtIndex:iLeftIndex];
                [cell setLeftItem:productDTOL];
                NSString *cityId = productDTOL.cityCode.length > 0 ? productDTOL.cityCode : [Config currentConfig].defaultCity;
//                if (productDTOL.isTongmaProduct)
//                {
//                    cell.leftView.priceImageView.imageURL = [ProductUtil getPriceImageUrlWithPartNumber:productDTOL.productCode city:cityId];
//                }
//                else
//                {
                    if ([self.searchCondition.shopNum isEqualToString:@"1"] || [self.searchCondition.shopNum isEqualToString:@""] )
                    {
                        cell.leftView.priceImageView.imageURL = [ProductUtil priceImageUrlOfProductId:productDTOL.productId city:cityId];
                    }
                    else
                    {
                        cell.leftView.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:productDTOL.productId city:cityId];
                    }
//                }
                
            }
            else
            {
                [cell setLeftItem:nil];
            }
            
            if (iRightIndex >= 0 && iRightIndex < self.service.productList.count)
            {
                DataProductBasic *productDTOR = [self.service.productList objectAtIndex:iRightIndex];
                [cell setRightItem:productDTOR];
                NSString *cityId = productDTOR.cityCode.length > 0 ? productDTOR.cityCode : [Config currentConfig].defaultCity;
//                if (productDTOR.isTongmaProduct)
//                {
//                    cell.rightView.priceImageView.imageURL = [ProductUtil getPriceImageUrlWithPartNumber:productDTOR.productCode city:cityId];
//                }
//                else
//                {
                    if ([self.searchCondition.shopNum isEqualToString:@"1"] || [self.searchCondition.shopNum isEqualToString:@""] )
                    {
                        cell.rightView.priceImageView.imageURL = [ProductUtil priceImageUrlOfProductId:productDTOR.productId city:cityId];
                    }
                    else
                    {
                        cell.rightView.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:productDTOR.productId city:cityId];
                    }
//                }
                
            }
            else
            {
                [cell setRightItem:nil];
            }
            
            return cell;
        }
    }
    
    return nil;
}



- (void)research:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (self.service.isJianCi)
    {
        [self didSelectAssociationalWord:btn.titleLabel.text];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.showModel == SmallView)
    {
        if (indexPath.row < 30)
        {
            if (indexPath.row < 9)
            {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"82020%d",indexPath.row+1], nil]];
            }
            else
            {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"8202%d",indexPath.row+1], nil]];
            }
        }
        
        if ([self hasMore] && indexPath.row == [_service.productList count]) {
            
            [self loadMoreData];
            return;
        }
        
        if (indexPath.row >= [_service.productList count] || indexPath.row < 0) {
            return;
        }
        
        if (self.service.isJianCi)
        {
            if (indexPath.section == 0)
                return;
        }
        
        DataProductBasic *dto = [_service.productList objectAtIndex:indexPath.row];
        if (![[dto.productCode substringToIndex:9]isEqualToString:@"000000000"]) {
            dto.productCode=[NSString stringWithFormat:@"000000000%@",dto.productCode];
        }
        
        if (![self.searchCondition.shopNum isEqualToString:@"-1"])
        {
            //只搜自营
            dto.shopCode = @"";
        }
        else
        {
            dto.shopCode = nil;
        }
        sourcePageTitle = [NSString stringWithFormat:@"%@_%@",sourcePageTitle,self.pageTitle];
        ProductDetailViewController * v = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
        [self.navigationController pushViewController:v animated:YES];

    }
}

- (void)didTappedBigModelView:(DataProductBasic *)dto
{
    if (![[dto.productCode substringToIndex:9]isEqualToString:@"000000000"]) {
        dto.productCode=[NSString stringWithFormat:@"000000000%@",dto.productCode];
    }
    
    if (![self.searchCondition.shopNum isEqualToString:@"-1"])
    {
        //只搜自营
        dto.shopCode = @"";
    }
    else
    {
        dto.shopCode = nil;
    }
    
    ProductDetailViewController * v = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    
    [self.navigationController pushViewController:v animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark -
#pragma mark actions


//将segment设为默认排序，在使用了类目筛选后执行改方法
- (void)resetSearchSort
{
    [self.searchsegmentView setSelectedSort:SortTypeDefault];
}

//更改了排序方式  代理方法
- (void)searchSegmentDidChangeSortType:(SortType)sort
{
    self.searchCondition.sortType = sort;
    
    [self refreshData];
}

- (void)didSelectHotUrl:(NSString *)url bFromHomeSearchView:(BOOL)bFromHSView wordOfUrl:(NSString *)word
{
    if (url.length)
    {
        @weakify(self);
        [self routeWithUrl:url complete:^(BOOL isSuccess, NSString *errorMsg) {
            
            @strongify(self);
            if (!isSuccess) {
                [self didSelectAssociationalWord:word];
            }
        }];
    }
    else
    {
        [self didSelectAssociationalWord:word];

    }
}


//选中某项联想词, 或者更改搜索关键字之后都执行该方法
- (void)didSelectAssociationalWord:(NSString *)keyword
{
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        return;
    }
    if (keyword.length > 0) //语音键盘默认占位符 %EF%BF%BC,此时return
    {//efbfbc
        NSString *str = @"%EF%BF%BC";
        NSString *urlKeyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [urlKeyword rangeOfString:str];
        if ( range.location!= NSNotFound)
        {
            return;
        }
    }
    
    [self.searchTextField resignFirstResponder];
//    self.filterButton.hidden = NO;
//    self.searchCancelButton.hidden = YES;
//    self.zxingBtn.hidden = YES;
    if (NotNilAndNull(keyword)) {
        
        //店铺搜索走店铺逻辑
        int searchType = [[Config currentConfig].searchType intValue];
        
        if (searchType == 1)
        {
            [ShopSearchListViewController gotoShopSearchWithKeyWord:keyword fromNav:self.parentViewController.navigationController];
            
            return;
        }
        
        
        SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
        [dao addKeywordToDB:keyword];
        
        [self resetSearchSort];
        
        //判断是否是与当前搜索不同的搜索，不同的话要刷新筛选分类，相同不刷
        if (self.searchCondition.searchType == SearchTypeCategory_2 || self.searchCondition.searchType == SearchTypeCategory_3)
        {
            bSearchConditionChanged = YES;
        }
        else
        {
            if (![self.searchCondition.keyword isEqualToString:keyword])
            {
                bSearchConditionChanged = YES;
            }
        }
        
        self.searchCondition.keyword = keyword;
        self.searchCondition.cityId = [Config currentConfig].defaultCity;;
        self.searchCondition.categoryId = nil;
        self.searchCondition.currentPage = nil;
        self.searchCondition.pageSize = @"10";
        [self.searchCondition.checkedFilters removeAllObjects];
        self.searchTopView.strSelected = @"";
        self.searchCondition.brand = nil;
        if (!self.searchCondition.inventory) self.searchCondition.inventory = @"-1";
        if (!self.searchCondition.shopNum) self.searchCondition.shopNum = @"-1";
        self.searchCondition.searchType = SearchTypeKeyword;
        self.searchCondition.set = SearchSetMix;
        self.searchCondition.currentPage = @"0";
        self.searchCondition.sortType = SortTypeDefault;
        
        
        self.isKeywordSearch = YES;
        self.searchTextField.text = keyword;
        
        
        //不同的搜索，要恢复filterRoot界面，数据
        if (bSearchConditionChanged)
        {
            self.searchCondition.inventory = @"-1";
            self.searchCondition.shopNum = @"-1";

            self.searchCondition.salesPromotion = @"";
        }
        [self refreshData];
    }
}

- (void)didSelectAssociationalTypeKeyword:(NSString *)keyword andDirId:(NSString *)dirid andCore:(NSString *)core
{
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        return;
    }
    
    if (keyword.length > 0) //语音键盘默认占位符 %EF%BF%BC,此时return
    {//efbfbc
        NSString *str = @"%EF%BF%BC";
        NSString *urlKeyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [urlKeyword rangeOfString:str];
        if ( range.location!= NSNotFound)
        {
            return;
        }
    }
    
    [self.searchTextField resignFirstResponder];
//    self.filterButton.hidden = NO;
//    self.searchCancelButton.hidden = YES;
//    self.zxingBtn.hidden = YES;
    if (NotNilAndNull(keyword)) {
        SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
        [dao addKeywordToDB:keyword];
        
        [self resetSearchSort];
        
        //判断是否是与当前搜索不同的搜索，不同的话要刷新筛选分类，相同不刷
        if (self.searchCondition.searchType == SearchTypeCategory_2 || self.searchCondition.searchType == SearchTypeCategory_3)
        {
            bSearchConditionChanged = YES;
        }
        else
        {
            if (![self.searchCondition.keyword isEqualToString:keyword])
            {
                bSearchConditionChanged = YES;
            }
        }
        
        self.searchCondition.keyword = keyword;
        self.searchCondition.cityId = [Config currentConfig].defaultCity;;
        self.searchCondition.currentPage = nil;
        self.searchCondition.pageSize = @"10";
        [self.searchCondition.checkedFilters removeAllObjects];
        self.searchTopView.strSelected = @"";
        self.searchCondition.brand = nil;
        if (!self.searchCondition.inventory) self.searchCondition.inventory = @"-1";
        if (!self.searchCondition.shopNum) self.searchCondition.shopNum = @"-1";
        self.searchCondition.searchType = SearchTypeKeyword;
        self.searchCondition.set = SearchSetMix;
        self.searchCondition.currentPage = @"0";
        self.searchCondition.sortType = SortTypeDefault;
        self.searchCondition.categoryId = dirid;
        
        self.searchTextField.text = keyword;

        if (bSearchConditionChanged)
        {
            self.searchCondition.inventory = @"-1";
            self.searchCondition.shopNum = @"-1";

            self.searchCondition.salesPromotion = @"";
        }
        [self refreshData];
    }
}

#pragma mark -
#pragma mark pick ok delegate

- (void)catePickDidOk
{
    self.searchCondition.categoryId = self.FilterCtrl.selectCateId;
    [self refreshData];
}

- (void)filterPickDidOk
{
    self.searchCondition.checkedFilters = self.FilterCtrl.selectFilterMap;
    
    NSString *str = EncodeStringFromDic(self.FilterCtrl.selectFilterMap, @"bnf");
    if (str && self.searchQueryRecommendedBrandService.brandList && self.searchQueryRecommendedBrandService.brandList.count > 0)
    {
        self.searchTopView.strSelected = [NSString stringWithFormat:@"bnf:%@", [self.FilterCtrl.selectFilterMap objectForKey:@"bnf"]];
    }
    else if (!str)
    {
        self.searchTopView.strSelected = @"";
    }
    
    [self refreshData];
}

- (void)filterPickDidOkWithRefreshCompleteCallBack:(SearchFilterBlock)callBack
{
    self.searchCondition.checkedFilters = self.FilterCtrl.selectFilterMap;
    NSString *str = EncodeStringFromDic(self.FilterCtrl.selectFilterMap, @"bnf");
    if (str && self.searchQueryRecommendedBrandService.brandList && self.searchQueryRecommendedBrandService.brandList.count > 0)
    {
        self.searchTopView.strSelected = [NSString stringWithFormat:@"bnf:%@", [self.FilterCtrl.selectFilterMap objectForKey:@"bnf"]];
    }
    else if (!str)
    {
        self.searchTopView.strSelected = @"";
    }
    [self refreshDataWithCompleteBlock:callBack];
}


- (void)resetCatesAndFilters
{
    self.FilterCtrl.selectCateId = nil;
    self.searchCondition.salesPromotion = nil;

    if (self.isKeywordSearch)
        self.searchCondition.categoryId = nil;
    else
        self.searchCondition.categoryId = self.initialSearchCateID;
    self.searchCondition.inventory = @"-1";
    self.searchCondition.shopNum = @"-1";
    [self.searchCondition.checkedFilters removeAllObjects];
    self.searchTopView.strSelected = @"";
    
    [self refreshData];
}

- (void)allFilteOk
{
//    JASidePanelController *jsCtrl = (JASidePanelController *)self.parentViewController;
//    [jsCtrl showCenterPanelAnimated:YES];
}

- (void)popToCata
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark interest view delegate

- (void)didSelectIntrestProduct:(DataProductBasic *)product
{
    if (![self.searchCondition.shopNum isEqualToString:@"-1"])
    {
        //只搜自营
        product.shopCode = @"";
    }
    else
    {
        product.shopCode = nil;
    }
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark -
#pragma mark service & get data

- (SearchQueryRecommendedBrandService *)searchQueryRecommendedBrandService
{
    if (!_searchQueryRecommendedBrandService)
    {
        _searchQueryRecommendedBrandService = [[SearchQueryRecommendedBrandService alloc] init];
        _searchQueryRecommendedBrandService.delegate = self;
    }
    
    return _searchQueryRecommendedBrandService;
}

- (void)queryRecommendedBrandCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg service:(SearchQueryRecommendedBrandService *)service
{
    
    
}

- (SearchListService *)service
{
    if (!_service) {
        _service = [[SearchListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)getSearchListCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
                                  service:(SearchListService *)service
{
    
    if (service.isLoadMore) {
        [self startMoreCellAnimation:NO];
    }
    
//    bFirstTimeIn = YES;
    
    if (isSuccess) {
        
        //搜集搜索数据
        if (_searchCondition.searchType == SearchTypeKeyword &&
            service.resultNumber &&
            _searchCondition.keyword &&
            ![_lastSearchKeyword isEqualToString:_searchCondition.keyword])
        {
            if (!IsStrEmpty(_searchCondition.keyword) && !IsStrEmpty(service.resultNumber) && !IsStrEmpty(searchTitle))
            {
                NSArray *array = [NSArray arrayWithObjects:
                                  _searchCondition.keyword,
                                  service.resultNumber,searchTitle, nil];
                [[SuningMainClick sharedInstance] getSearchAndSave:array];
                self.lastSearchKeyword = self.searchCondition.keyword;
                if (KPerformance)
                {
                    if ([[PerformanceStatistics sharePerformanceStatistics].arrayData count] > 0)
                    {
                        [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                        if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [[PerformanceStatistics sharePerformanceStatistics].arrayData count])
                        {
                            PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
                            if (temp.isSearch)
                            {
                                temp.endTime = [NSDate date];
                                [[PerformanceStatistics sharePerformanceStatistics] sendData:temp];
                                temp.isSearch = NO;
                            }
                            //发送完数据立即清理数据
                            [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];

                            [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
                            [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = nil;
                            
                        }
                        
                    }
                }

            }
        }
        _footViewType = SearchResultViewNormal;
        
        //商品数量为空时
        if (!service.productList || [service.productList count] == 0) {
            //刘坤 12-11-5 如果是由类目进入，搜索不到结果时，默认将类目名称作为搜索关键字重新搜索
            if ((self.searchCondition.searchType == SearchTypeCategory_2 ||
                 self.searchCondition.searchType == SearchTypeCategory_3) &&
                [self.searchCondition.checkedFilters count] <= 1 && (IsStrEmpty(self.searchCondition.salesPromotion)) && self.isFirstIn)
            {
                NSString *keyword = self.searchCondition.title;
                [self.searchCondition resetWithSearchType:SearchTypeKeyword
                                                      set:self.searchCondition.set];
                self.searchCondition.keyword = keyword;
                self.isKeywordSearch = YES;
                
                [self refreshData];
                
                self.isFirstIn = NO;
                return;
            }
            else if ((self.searchCondition.searchType == SearchTypeCategory_2 ||
                      self.searchCondition.searchType == SearchTypeCategory_3) && !self.isFirstIn
                     && !service.productList)
            {
                self.isKeywordSearch = NO;
                _footViewType = SearchResultViewRecommend;
                self.errorMsg = L(@"Sorry, Can't find product");
                
                
                [self.service beginGetRecommendHotProductListRequestForCategoryFilter:self.searchCondition.categoryId];
                
                self.isFirstIn = NO;
                //[self clearFiltersWhenNoSearchRlt];
            }
            //关键词搜索页面，搜索结果为0
            else if (self.searchCondition.searchType == SearchTypeKeyword && !service.productList)
            {
                self.isKeywordSearch = YES;
                _footViewType = SearchResultViewRecommend;
                self.errorMsg = L(@"Sorry, Can't find product");
                
                [self.service beginGetRecommendHotProductListRequest:_searchCondition.keyword];
                //[self clearFiltersWhenNoSearchRlt];
                
                self.isFirstIn = NO;
            }
            
        }
    }
    else{
        if (IsStrEmpty(errorMsg) || [errorMsg isEqualToString:@""])
        {
            //            _footViewType = SearchResultViewRecommend;
            //            self.errorMsg = L(@"Sorry, Can't find product");
            //            if (self.footRecommendView.productList == nil ||
            //                [self.footRecommendView.productList count] == 0) {
            //                [self.service beginGetRecommendHotProductListRequest];
            //            }
            
            //分类页面，筛选结果为0
            if (((self.searchCondition.searchType == SearchTypeCategory_2 ||
                 self.searchCondition.searchType == SearchTypeCategory_3)))
            {
                self.isKeywordSearch = NO;
                _footViewType = SearchResultViewRecommend;
                self.errorMsg = L(@"Sorry, Can't find product");
                
                [self.service beginGetRecommendHotProductListRequestForCategoryFilter:self.searchCondition.categoryId];
                
                self.isFirstIn = NO;
            }
            //关键词搜索页面，搜索结果为0
            else if (self.searchCondition.searchType == SearchTypeKeyword)
            {
                self.isKeywordSearch = YES;
                _footViewType = SearchResultViewRecommend;
                self.errorMsg = L(@"Sorry, Can't find product");
                
                [self.service beginGetRecommendHotProductListRequest:_searchCondition.keyword];
                
                self.isFirstIn = NO;
                //[self clearFiltersWhenNoSearchRlt];
            }
        }
        else
        {
            //错误信息跟无结果同一页面，只是文案不同
            _footViewType = SearchResultViewLoadFail;
            
            self.isFirstIn = NO;
//            self.errorMsg = errorMsg?errorMsg:L(@"Sorry, Can't find product");
//            [self presentSheet:self.errorMsg];
        }
    }

    self.isFirstIn = NO;
    
    [self performSelector:@selector(waitForRecommendBrandlistAndDisplay) withObject:nil afterDelay:0.5];
}


//热销品牌是从mts调取，跟搜索列表同时发起，因此可能有先有后，得到搜索列表后等待热销品牌结果，1秒后再刷新
- (void)waitForRecommendBrandlistAndDisplay
{
    //根据service重新设置顶部view
    [self resetTopView];
    
    if (self.service.isJianCi)
        self.jianciKeyword = self.searchCondition.keyword;
    
    [self updateTableView];
    
    //首先请求前几个dto的促销，别的促销在cell可见时再请求
    for (int i = 0; i < self.service.productList.count; i++) {
        if (i <= 5)
        {
            DataProductBasic *dto = [self.service.productList objectAtIndex:i];
            [dto beginGetPromotionInfo];
        }
    }
    
    //回调给筛选页面
    if (self.service.context)
    {
        SearchFilterBlock block = self.service.context;
        block(self.service.filterList);
        self.service.context = nil;
    }
    
    [self removeOverFlowActivityView];
    
    //筛选界面移除loading框
    self.FilterCtrl.filterList = [self.service.filterList mutableCopy];
    self.FilterCtrl.categoryList = self.service.categoryList;
    self.FilterCtrl.isKeyWordSearch = _isKeywordSearch;
    if (!self.isKeywordSearch)
        self.FilterCtrl.selectCateName = self.searchCondition.title;
    
    //如果是新搜索，清空分类
    if (bSearchConditionChanged)
    {
        [self clearFiltersWhenNoSearchRlt];
        
        self.searchTopView.strSelected = @"";
    }
    
    self.FilterCtrl.searchCondition = self.searchCondition;
    self.FilterCtrl.itemNum = _service.showNumber;
    
    bSearchConditionChanged = NO;
    
    [self.FilterCtrl.tableView reloadData];
    
    if (self.FilterCtrl.view.superview)
    {
        [self.FilterCtrl removeOverFlowActivityView];
    }
}

- (void)clearFiltersWhenNoSearchRlt
{
    self.FilterCtrl.selectCateId = nil;
    self.FilterCtrl.selectCateName = @"";
    self.searchCondition.salesPromotion = nil;

    if (self.isKeywordSearch)
        self.searchCondition.categoryId = nil;
    else
        self.searchCondition.categoryId = self.initialSearchCateID;
    self.searchCondition.inventory = @"-1";
    self.searchCondition.shopNum = @"-1";
    [self.searchCondition.checkedFilters removeAllObjects];
    self.searchTopView.strSelected = @"";
}

- (void)getRecommentHotProductCompletionWithResult:(BOOL)isSuccess
                                          errorMsg:(NSString *)errorMsg
                                       productList:(NSArray *)list
{
    if (isSuccess && list && [list count] > 0) {
        
        self.footView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height - 64);
        CGFloat posY = self.footView.height - 200;
        self.footRecommendView.frame = CGRectMake(0, posY, 320, 200);
        
        if (self.isKeywordSearch)
        {
            [self changeFootViewStyle:_isKeywordSearch];
            [self refreshNotFoundInfo];
        }
        else
        {
            [self changeFootViewStyle:_isKeywordSearch];
        }

        [self.footView addSubview:self.footRecommendView];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:list];
        [self.footRecommendView showIntrestedProductView:array];
        NSMutableString* str = [[NSMutableString alloc] init];
        for(int i = 0;i < [array count];++i)
        {
            NewInnerProductDTO* v = array[i];
            [str appendFormat:@"%@",v.sugGoodsCode];
            if (i != [array count] - 1)
            {
                [str appendFormat:@"%@",@"_"];
            }
        }
        if ([array count]&&([self.lastSearchKeyword length]))
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"searchrec" keyArray: [NSArray arrayWithObjects:@"word",@"productid", nil]valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",self.lastSearchKeyword],[NSString stringWithFormat:@"%@",str], nil]];
        }
        
    }
    else
    {
        if (self.isKeywordSearch)
        {
            [self changeFootViewStyle:_isKeywordSearch];
            [self refreshNotFoundInfo];
        }
        else
        {
            [self changeFootViewStyle:_isKeywordSearch];
        }

        [self.footRecommendView removeFromSuperview];
    }
}

- (void)getRecommentHotProductCompletionWithResultForCategoryFilter:(BOOL)isSuccess
                                                           errorMsg:(NSString *)errorMsg
                                                        productList:(NSArray *)list
{
    if (isSuccess && list && [list count] > 0) {
        self.footView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height - 64);
        CGFloat posY = self.footView.height - 200;
        self.footRecommendView.frame = CGRectMake(0, posY, 320, 200);
        
        if (self.isKeywordSearch)
        {
            [self changeFootViewStyle:_isKeywordSearch];
            [self refreshNotFoundInfo];
        }
        else
        {
            [self changeFootViewStyle:_isKeywordSearch];
        }

        
        [self.footView addSubview:self.footRecommendView];

        NSMutableArray *array = [NSMutableArray arrayWithArray:list];
        [self.footRecommendView showIntrestedProductView:array];
    }
    else
    {
        if (self.isKeywordSearch)
        {
            [self changeFootViewStyle:_isKeywordSearch];
            [self refreshNotFoundInfo];
        }
        else
        {
            [self changeFootViewStyle:_isKeywordSearch];
        }
        [self.footRecommendView removeFromSuperview];
    }
}

#pragma mark -
#pragma mark load More methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    /*判是否加载更多*/
    CGSize contentOffset = [self.tableView contentSize];
    
    CGRect bounds = [self.tableView bounds];
    
    if (scrollView.contentOffset.y + bounds.size.height >= contentOffset.height &&
        contentOffset.height>=(self.view.frame.size.height-92)) {
        
        if([self hasMore]){
            [self loadMoreData];
        }
    }
    
    CGPoint pt = [scrollView.panGestureRecognizer velocityInView:scrollView];//判断滚动方向，弥补手指按下时间很短就滚动的时候
    if (pt.y < 0)
    {
        [self hideTopBars];
    }
    // NSLog(@"%@", [NSValue valueWithCGPoint:pt]);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    if (velocity.y >= 0)
    {
        if (self.showModel == SmallView)
        {
            NSArray *arrVisible = [self.tableView indexPathsForVisibleRows];
            NSIndexPath *indexpathLast = (NSIndexPath *)[arrVisible lastObject];
            if (self.service.isJianCi)
            {
                
                if (indexpathLast.section == 1 && indexpathLast.row >= self.service.productList.count / 2 && self.hasMore)
                {
                    if ([self.service hasMore])
                        [self loadMoreData];
                }
            }
            else
            {
                if (indexpathLast.section == 0 && indexpathLast.row >= self.service.productList.count / 2 && self.hasMore)
                {
                    if ([self.service hasMore])
                        [self loadMoreData];
                }
            }
        }
        else if (self.showModel == BigView)
        {
            NSArray *visibleCells = [self.tableView indexPathsForVisibleRows];
            NSIndexPath *indexpathLast = (NSIndexPath *)[visibleCells lastObject];
            
            if (self.service.isJianCi)
            {
                if (indexpathLast.section == 1 && indexpathLast.row >= self.service.productList.count / 4 && self.hasMore)
                {
                    if ([self.service hasMore])
                        [self loadMoreData];
                }
            }
            else
            {
                if (indexpathLast.section == 0 && indexpathLast.row >= self.service.productList.count / 4 && self.hasMore)
                {
                    if ([self.service hasMore])
                        [self loadMoreData];
                }
            }
        }

    }
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView   // called on finger up as we are moving
{
    self.tableView.showsVerticalScrollIndicator = YES;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
{
    self.tableView.showsVerticalScrollIndicator = NO;//防止突然进入滚动状态时滚动条闪烁
    if (self.showModel == SmallView)
    {
        NSString *sscxkg = [SNSwitch getSearchPromotionValue];
        if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"2"])
        {
            //非减词情况
            if (!self.service.isJianCi)
            {
                NSArray *arrVisible = [self.tableView indexPathsForVisibleRows];
                
                //可见cell发起促销请求
                for (NSIndexPath *indexpath in arrVisible)
                {
                    NSLog(@"IndexPath.row == %d", indexpath.row);
                    
                    if (indexpath.row >= 0 && indexpath.row < self.service.productList.count)
                    {
                        DataProductBasic *dto = (DataProductBasic *)[self.service.productList objectAtIndex:indexpath.row];
                        [dto beginGetPromotionInfo];
                    }
                }
            }
        }
        
//        NSArray *arrVisible = [self.tableView indexPathsForVisibleRows];
//        if (self.service.isJianCi)
//        {
//            for (NSIndexPath *indexpath in arrVisible)
//            {
//                if (indexpath.section == 1 && indexpath.row == self.service.productList.count && self.hasMore)
//                {
//                    [self loadMoreData];
//                }
//            }
//            NSIndexPath *indexpathLast = (NSIndexPath *)[arrVisible lastObject];
//            if (indexpathLast.section == 1 && indexpathLast.row >= self.service.productList.count / 2 && self.hasMore)
//            {
//                [self loadMoreData];
//            }
//        }
//        else
//        {
//            for (NSIndexPath *indexpath in arrVisible)
//            {
//                if (indexpath.section == 0 && indexpath.row == self.service.productList.count && self.hasMore)
//                {
//                    [self loadMoreData];
//                }
////            }
//            NSIndexPath *indexpathLast = (NSIndexPath *)[arrVisible lastObject];
//            if (indexpathLast.section == 0 && indexpathLast.row >= self.service.productList.count / 2 && self.hasMore)
//            {
//                [self loadMoreData];
//            }
//        }
    }
    else if (self.showModel == BigView)
    {
        NSString *sscxkg = [SNSwitch getSearchPromotionValue];
        if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"2"])
        {
            //非减词情况
            if (!self.service.isJianCi)
            {
                NSArray *arrVisible = [self.tableView indexPathsForVisibleRows];
                
                //可见cell发起促销请求
                for (NSIndexPath *indexpath in arrVisible)
                {
                    NSLog(@"IndexPath.row == %d", indexpath.row);
                    
                    if (indexpath.row * 2 >= 0 && indexpath.row * 2 < self.service.productList.count)
                    {
                        DataProductBasic *dto = (DataProductBasic *)[self.service.productList objectAtIndex:indexpath.row * 2];
                        [dto beginGetPromotionInfo];
                        
                        if ((indexpath.row * 2 + 1) >= 0 && (indexpath.row * 2 + 1) < self.service.productList.count)
                        {
                            DataProductBasic *dtoRight = (DataProductBasic *)[self.service.productList objectAtIndex:indexpath.row * 2 + 1];
                            [dtoRight beginGetPromotionInfo];
                        }
                       
                        
                    }
                }
            }
        }
        
//        NSArray *visibleCells = [self.tableView visibleCells];
//        NSIndexPath *indexpathLast = (NSIndexPath *)[visibleCells lastObject];
//        if (indexpathLast.section == 1 && indexpathLast.row <= self.service.productList.count / 4 && self.hasMore)
//        {
//            [self loadMoreData];
//        }
//        for (UITableViewCell *cell in visibleCells) {
//            if ([cell isKindOfClass:[UITableViewMoreCell class]])
//            {
//                if (self.hasMore)
//                    [self loadMoreData];
//            }
//        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
//        NSLog(@"++++++++++contentOffset %f, contentsize %f", scrollView.contentOffset.y, scrollView.contentSize.height);
//        if (scrollView.contentOffset.y >= scrollView.contentSize.height / 2)
//        {
//            [self loadMoreData];
//        }
        
        if (scrollView.isTracking && scrollView.dragging) //如果手指按下，但没抬起的状态
        {
            CGPoint ptOffset = scrollView.contentOffset;
            //            NSLog(@"scrollView.contentOffset %@", [NSValue valueWithCGPoint:ptOffset]);
            //            NSLog(@"scrollView.contentSize.height %f", scrollView.contentSize.height);
            //            NSLog(@"%f", scrollView.size.height);
            
            if (scrollView.contentSize.height >= scrollView.size.height) //内容高度大于view高度
            {
                if (ptOffset.y >= scrollView.contentSize.height - scrollView.size.height) //已经到最下方
                    return;
            }
            
            
            
            if (scrollView.contentInset.top == kTableViewInsetTopWithoutKeyWord)
            {
                if (ptOffset.y > -kTableViewInsetTopWithoutKeyWord) //下滑
                {
                    if ((ptOffset.y - ptLastOffset.y) > 0)
                    {
                        [self hideTopBars];
                        
                        ptLastOffset = ptOffset;
                        self.tableView.showsVerticalScrollIndicator = YES;
                    }
                    else
                    {
                        [self showTopBars];
                        ptLastOffset = ptOffset;
                        //self.tableView.showsVerticalScrollIndicator = YES;
                    }
                }
            }
            else if (scrollView.contentInset.top == 0)
            {
                if (ptOffset.y > 0)
                {
                    if ((ptOffset.y - ptLastOffset.y) > 0)
                    {
                        [self hideTopBars];
                        
                        ptLastOffset = ptOffset;
                    }
                    else if ((ptOffset.y - ptLastOffset.y) < 0)
                    {
                        [self showTopBars];
                        ptLastOffset = ptOffset;
                    }
                }
                else if (ptOffset.y < 0)
                {
                    [self showTopBars];
                    ptLastOffset = ptOffset;
                }
            }
        }
    }
}

- (void)hideTopBars
{
    if (isNoResult || self.tableView.contentSize.height < self.tableView.height)
        return;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.customNavigationBar.transform = CGAffineTransformMakeTranslation(0, -200);
//        if (self.sectionHeaderView.superview)
//            self.sectionHeaderView.transform = CGAffineTransformMakeTranslation(0, -200);
//        self.searchsegmentView.transform = CGAffineTransformMakeTranslation(0, -200);
        self.searchTopView.transform = CGAffineTransformMakeTranslation(0, -300);
        
    } completion:^(BOOL finished) {
    }];
}

- (void)showTopBars
{
    if (bShowItemNum)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithKeyWord, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithKeyWord, 0, 0, 0);
    }
    else
    {
        self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.customNavigationBar.transform = CGAffineTransformIdentity;
//        if (self.sectionHeaderView.superview)
//            self.sectionHeaderView.transform = CGAffineTransformIdentity;
//        self.searchsegmentView.transform = CGAffineTransformIdentity;
        self.searchTopView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (BOOL)hasMore
{
    return [self.service hasMore];
}

- (void)refreshData
{

    [self refreshDataWithCompleteBlock:nil];
}

- (UIView *)maskView
{
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    
    return _maskView;
}

- (void)displayOverFlowActivityView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
}

- (void)removeOverFlowActivityView
{
    if (self.maskView.superview)
    {
        [self.maskView removeFromSuperview];
    }
}

- (void)refreshDataWithCompleteBlock:(SearchFilterBlock)block
{
    [self displayOverFlowActivityView];
    
    if (self.FilterCtrl.view.superview)
    {
        [self.FilterCtrl displayOverFlowActivityView];
    }
    
    //筛选界面增加loading框
//    JASidePanelController *jsCtrl = (JASidePanelController *)self.parentViewController;
//    if (jsCtrl)
//    {
//        UINavigationController *nav = (UINavigationController *)jsCtrl.rightPanel;
//        if (nav)
//        {
//            [nav.view showHUDIndicatorViewAtCenter:L(@"Loading...")];
//        }
//    }
    
    
    SearchFilterBlock blockCopy = [block copy];
    self.service.context = blockCopy;
    
    [self.service refreshData:self.searchCondition];
    
    //发起热销品牌请求
    [self.searchQueryRecommendedBrandService beginQueryRecommendedBrand:self.searchCondition.keyword];
    
    [self.service.productList removeAllObjects];
    [self updateTableView];
}

- (void)loadMoreData
{
    [self startMoreCellAnimation:YES];
    
//    [self displayOverFlowActivityView];
    
//    [self setRightItemsEnable:NO];
    
    [self.service loadMoreData:self.searchCondition];
}

- (void)startMoreCellAnimation:(BOOL)animating
{
    int section = 0;
    if (self.service.isJianCi) {
        section = 1;
    }
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.service.productList count] inSection:section] ;
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[UITableViewMoreCell class]]) {
		
		UITableViewMoreCell *_cell = (UITableViewMoreCell *)cell;
        
		[_cell setAnimating: animating];
	}
	
}

//设置当搜索失败或搜索记录为空时显示
- (void)setSearchResultViewType:(SearchResultViewType)type
{
    [self.footRecommendView removeFromSuperview];
    switch (type) {
        case SearchResultViewNormal:
        {
            self.tableView.tableFooterView = nil;

            [self showButtons:NORMAL];
//            self.filterButton.hidden = NO;
//            self.searchCancelButton.hidden = YES;
//            self.zxingBtn.hidden = YES;
            
//            self.searchsegmentView.hidden = NO;
            self.searchTopView.hidden = NO;
            isNoResult = NO;
            break;
        }
        case SearchResultViewLoading:
        {
            self.tableView.tableFooterView = nil;
            
            self.searchTopView.hidden = YES;
            break;
        }
        case SearchResultView404:
        case SearchResultViewLoadFail:  //暂时不能到该步
        {
            if (self.service.productList.count > 0)
            {
                self.tableView.tableFooterView = nil;
            }
            else
            {
                self.tableView.tableFooterView = self.footView;
//                self.filterButton.hidden = YES;
//                self.zxingBtn.hidden = NO;
//                self.searchCancelButton.hidden = YES;
                
        
                [self changeFootViewStyle:YES];
                [self refreshNotFoundInfoWithErrorMsg:self.service.errorMsg];
                [self showButtons:NORESULT];
                
                self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
                self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
                self.searchTopView.hidden = YES;
                isNoResult = YES;
            }
            
            break;
        }
        case SearchResultViewRecommend:
        {
//            if (self.isKeywordSearch)
//            {
//                [self changeFootViewStyle:_isKeywordSearch];
//                [self refreshNotFoundInfo];
//            }
//            else
//            {
//                [self changeFootViewStyle:_isKeywordSearch];
//            }
//            [self.footView addSubview:self.footRecommendView];
            
            self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);

            self.tableView.tableFooterView = self.footView;
            CGFloat posY = self.footView.height - 200 + 40;
            self.footRecommendView.frame = CGRectMake(0, posY, 320, 200);
            [self.footView addSubview:self.footRecommendView];
//            self.footRecommendView.backgroundColor = [UIColor redColor];

            
//            self.filterButton.hidden = YES;
//            self.zxingBtn.hidden = NO;
//            self.searchCancelButton.hidden = YES;
            
            [self showButtons:NORESULT];
            isNoResult = YES;
            
            self.searchTopView.hidden = YES;
            
            break;
        }
        default:
            break;
    }
}

- (void)showButtons:(BTNSTATE)state
{
    NSLog(@"showButtons state = %d", state);
    if (state == NORMAL)
    {
        self.filterButton.hidden = NO;
        self.searchCancelButton.hidden = YES;
        self.zxingBtn.hidden = YES;
        
        self.searchTypeBtn.hidden = YES;
        self.navLeftBtn.hidden = NO;
        self.searchTextField.left = 42;
        self.searchTextField.width = 212 - BIGVIEW_BTN_WIDTH;
        self.searchTextField.leftView.hidden = NO;
        
        self.showModelBtn.hidden = NO;
        _searchTextField.editingRect = CGRectMake(27, 0, 140 - BIGVIEW_BTN_WIDTH, 30);
        _searchTextField.clearButtonRect = CGRectMake(187 - 20, 0, 20, 30);
        _searchTextField.borderRect = CGRectMake(0, 0, 212 - BIGVIEW_BTN_WIDTH, 30);
        _searchTextField.leftViewRect = CGRectMake(5, 6, 22, 17);
//        _searchTextField.frame = CGRectMake(42, 7, 212 - BIGVIEW_BTN_WIDTH, 30);
    }
    else if (state == NORESULT)
    {
        self.filterButton.hidden = NO;
        self.zxingBtn.hidden = YES;
        self.searchCancelButton.hidden = YES;
        
        self.searchTypeBtn.hidden = YES;
        self.navLeftBtn.hidden = NO;
        
        self.searchTextField.left = 42;
        self.searchTextField.width = 212;
        self.searchTextField.leftView.hidden = NO;
        self.showModelBtn.hidden = YES;
        self.searchTextField.editingRect = CGRectMake(27, 0, 140 , 30);
        _searchTextField.borderRect = CGRectMake(0, 0, 212  , 30);
//        _searchTextField.frame = CGRectMake(42, 7, 212 - BIGVIEW_BTN_WIDTH, 30);
    }
    else if (state == SHOWING_TEXTFIELD)
    {
        self.filterButton.hidden = YES;
        self.searchCancelButton.hidden = NO;
        self.zxingBtn.hidden = YES;
        
        self.searchTypeBtn.hidden = NO;
        self.navLeftBtn.hidden = YES;
        self.searchTextField.left = 70;
        self.searchTextField.width = 192;
        
        self.searchTextField.leftView.hidden = YES;
        
        self.showModelBtn.hidden = YES;
        self.searchTextField.editingRect = CGRectMake(7, 0, 160, 30);
        _searchTextField.borderRect = CGRectMake(0, 0, 192, 30);
//        self.searchTextField.editingRect = CGRectMake(27, 0, 140, 30);
//        _searchTextField.frame = CGRectMake(42, 7, 212 - BIGVIEW_BTN_WIDTH, 30);
    }
}

- (void)updateTableView
{
    if (self.service.isLoading) {
        _footViewType = SearchResultViewLoading;
    }
    [self setSearchResultViewType:_footViewType];
    [self.tableView reloadData];
}

//防止警告
- (void)deleteHistoryOk
{
    
}

#pragma mark ----------------------------- 跳转帮助

+ (UIViewController *)searchPageWithParamDTO:(SearchParamDTO *)paramDTO
{
    SearchListViewController *nextController = [[SearchListViewController alloc] initWithSearchCondition:paramDTO];
    nextController.needBackForePage = YES;
    
//    //chupeng 修改为新的搜索结果界面
//    FilterRootViewController *vRightRoot = [[FilterRootViewController alloc] init];
//    vRightRoot.isNeedBackItem = NO;
//    vRightRoot.delegate = nextController;
//    
//    FilterNavigationController *navRight = [[FilterNavigationController alloc] initWithRootViewController:vRightRoot];
    
    JASidePanelController *jasideController = [[JASidePanelController alloc] init];
    jasideController.shouldDelegateAutorotateToVisiblePanel = NO;
    jasideController.rightGapPercentage = 0.8;
    jasideController.shouldResizeRightPanel = YES;
    jasideController.bounceOnSidePanelOpen = NO;
    jasideController.allowLeftOverpan = NO;
    jasideController.allowRightOverpan = NO;
    jasideController.centerPanel = nextController;
//    jasideController.rightPanel = navRight;
    jasideController.rightPanel = nil;
    jasideController.leftPanel = nil;
    jasideController.hasSuspendButton = NO;
    jasideController.hidesBottomBarWhenPushed = YES;
//    [jasideController addObserver:nextController forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:"getstate"];
    return jasideController;
}

+ (void)goToSearchResultWithParamDTO:(SearchParamDTO *)paramDTO fromNav:(UINavigationController *)navController
{
    UIViewController *jasideController = [self searchPageWithParamDTO:paramDTO];
    [navController pushViewController:jasideController animated:YES];
}

+ (void)goToSearchResultWithKeyword:(NSString *)keyword fromNav:(UINavigationController *)navController
{
    SearchParamDTO *paramDTO = [[SearchParamDTO alloc] initWithSearchType:SearchTypeKeyword set:SearchSetMix];
    paramDTO.keyword = keyword;
    [self goToSearchResultWithParamDTO:paramDTO fromNav:navController];
}

@end
