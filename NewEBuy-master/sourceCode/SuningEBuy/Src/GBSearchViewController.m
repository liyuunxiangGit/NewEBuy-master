//
//  GBSearchViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBSearchViewController.h"
#import "GBListGoodsCell.h"
#import "GBSearchListGoodsDTO.h"
#import "GBDetailViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "TPKeyboardAvoidingTableView.h"

@interface GBSearchViewController ()
{
    dispatch_queue_t    _ioQueue;
    
    UITapGestureRecognizer *tapGesture;
}

@property (nonatomic, strong) GBListPrametersDTO  *paramDTO;
@property (nonatomic, strong) NSMutableArray  *historyArray;
@property (nonatomic, strong) NSString        *keyWord;
@property (nonatomic, assign) BOOL             isHasResult;
@property (nonatomic, strong) GBListService  *service;
@property (nonatomic,assign)   NSInteger			nowCount;
@property (nonatomic,assign)   NSInteger			allCount;
@property (nonatomic, strong) UIButton        *clearHistoryBtn;
@property (nonatomic, strong) TPKeyboardAvoidingTableView *pktableView;

@end

@implementation GBSearchViewController

@synthesize paramDTO = _paramDTO;
@synthesize searchBar = _searchBar;
@synthesize searchList = _searchList;
@synthesize cityId = _cityId;
@synthesize categoryId = _categoryId;
@synthesize historyArray = _historyArray;
@synthesize service = _service;
@synthesize nowCount = _nowCount;
@synthesize allCount = _allCount;

@synthesize keyWord = _keyWord;
@synthesize isHasResult = _isHasResult;
@synthesize clearHistoryBtn = _clearHistoryBtn;
@synthesize pktableView = _pktableView;

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
    [self removeObserver:self forKeyPath:@"keyWord"];
    _searchBar.delegate = nil;
    _searchBarView.delegate = nil;
    
    TT_RELEASE_SAFELY(_cityId);
    TT_RELEASE_SAFELY(_categoryId);
    TT_RELEASE_SAFELY(_historyArray);
    TT_RELEASE_SAFELY(_keyWord);
    
    TT_RELEASE_SAFELY(_clearHistoryBtn);
    TT_RELEASE_SAFELY(_pktableView);
    
    dispatch_release(_ioQueue);
    
    [self.view removeGestureRecognizer:tapGesture];
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"GB_Search_Title");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        [self addObserver:self forKeyPath:@"keyWord" options:NSKeyValueObservingOptionNew context:nil];
        //创建串行queue
        _ioQueue = dispatch_queue_create("com.suning.GBSearchHistory", DISPATCH_QUEUE_SERIAL);
        
        _paramDTO = [[GBListPrametersDTO alloc] init];
        _paramDTO.cityId = @"11";
        _paramDTO.categoryId = nil;
        _paramDTO.areaId = nil;
        _paramDTO.indexId = nil;
        _paramDTO.keyWord = nil;
        _paramDTO.sortType = 0;
        _paramDTO.pageNumber = @"1";
        _paramDTO.pageSize = @"12";
        
        self.hasNav = NO;
    }
    return self;
}

- (void)dismissKeybord
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (TPKeyboardAvoidingTableView *)tpTableView
{
	if(!_tpTableView)
    {
		
        if (IOS7_OR_LATER) {
            _tpTableView = [TPKeyboardAvoidingTableView tableView];
        }else{
            _tpTableView = [TPKeyboardAvoidingTableView tableView];
        }
        
		_tpTableView.delegate =self;
		
		_tpTableView.dataSource =self;
        
        if ([_tpTableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        {
            if ([_tpTableView.dataSource isKindOfClass:[UIViewController class]])
            {
                UIViewController *v = (UIViewController *)_tpTableView.dataSource;
                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
                {
                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
                    for (UIGestureRecognizer *ges in _tpTableView.gestureRecognizers) {
                        [nav.panGes requireGestureRecognizerToFail:ges];
                    }
                }
            }
        }
	}
	return _tpTableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self useBottomNavBar];
    self.bottomNavBar.ebuyBtn.hidden = NO;
    
    CGRect frame = self.view.bounds;
    frame.origin.y+=44;
    frame.size.height-=(44+48);
    
    self.tableView.frame = frame;
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];
    
    self.tpTableView.frame = frame;
    self.tpTableView.hidden = YES;
    [self.view addSubview:self.tpTableView];
    
//    [self.view addSubview:self.searchBar];
//    
//    [self.searchBar becomeFirstResponder];
    
    [self.view addSubview:self.searchBarView];
    [self.searchBarView.searchTextField becomeFirstResponder];
     
    self.paramDTO.cityId = self.cityId;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeybord)];
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
}

- (void)searchHistoryInit
{
    self.historyArray = [NSMutableArray arrayWithArray:[Config currentConfig].gbHistoryArray];
    [self.tpTableView reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *newKeyWord = [change objectForKey:NSKeyValueChangeNewKey];
    [self addToHistoryList:newKeyWord];
    
    self.searchBar.text = self.keyWord;
    
    [self searchGoodList];
}

- (void)searchGoodList
{
    //清除数据
    if ([self.searchList count] > 0) {
        self.searchList = nil;
        self.tableView.tableHeaderView = [self getNoResultTableHeaderView];
        [self.tableView reloadData];
    }
    
    self.paramDTO.pageNumber = @"1";
    [self getGBGoodsList];
}

- (void)addToHistoryList:(NSString *)newKeyWord
{
    dispatch_async(_ioQueue, ^
    {
        NSMutableArray *filterArray = [NSMutableArray arrayWithArray:[Config currentConfig].gbHistoryArray];
        
        if ([filterArray count] > 0){
            for (NSString *historyKey in filterArray)
            {
                if (historyKey.trim.length == 0) {
                    continue;
                }
                if ([historyKey isEqualToString:newKeyWord]) {
                    return;
                }else{
                    continue;
                }
            }
            [filterArray insertObject:newKeyWord atIndex:0];
        }else{
            [filterArray insertObject:newKeyWord atIndex:0];
        }
        
        if ([filterArray count] > 10) {
            [filterArray removeLastObject];
        }
        
        [Config currentConfig].gbHistoryArray = filterArray;
    });
}

- (void)filterHistoryList:(NSString *)searchText
{
    NSMutableArray *filterArr =[NSMutableArray arrayWithArray:[Config currentConfig].gbHistoryArray] ;
    if (searchText.trim.length == 0)
    {
        self.historyArray = nil;
    }
    else
    {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSString *historyKey in filterArr) {
            if (historyKey.trim.length > 0 &&
                [historyKey rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound)
            {
                [tempArr addObject:historyKey];
            }
        }
        self.historyArray = tempArr;
        TT_RELEASE_SAFELY(tempArr);
    }
    [self.tpTableView reloadData];
}

#pragma mark - searchBarView delegate
#pragma mark   搜索框 代理方法

- (BOOL)searchFieldShouldBeginEditing:(UITextField *)textField{
    
    [self showSearchBar];
    
    //    if (![textField.placeholder isEqualToString:L(@"Search Product")]) {
    //        textField.text=textField.placeholder;
    //    }
    
    self.searchBarView.searchTextField.placeholder = L(@"TFSearchForProduct");
    [self filterHistoryList:self.keyWord];
    
    self.tpTableView.hidden = NO;
    self.tableView.hidden = YES;
    
    [self searchHistoryInit];
    
    return YES;
}

- (void)searchBar:(UITextField *)searchField textDidChange:(NSString *)searchText{
    
    if (IsStrEmpty(searchText)) {
        [self searchHistoryInit];
    }
    else
    {
        [self filterHistoryList:searchText];
    }
    
}

- (BOOL)searchFieldShouldEndEditing:(UITextField *)textField{
    if (self.keyWord.trim.length == 0) {
        self.searchBar.placeholder = L(@"TFSearchForProduct");
    }else{
        self.searchBar.placeholder = self.keyWord;
    }
    [self hideSearchBar:nil];
    return YES;
}

- (void)searchFieldSearchButtonClicked:(UITextField *)searchField
{
    if (searchField.text.trim.length > 0)
    {
        self.keyWord = searchField.text;
        
        self.tpTableView.hidden = YES;
        self.tableView.hidden = NO;
        
        [self.searchBarView.searchTextField resignFirstResponder];
    }}


#pragma mark - search bar delegate


//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
////    self.searchBar.text = self.keyWord;
//    self.searchBar.placeholder = @"搜索商品";
//    [self filterHistoryList:self.keyWord];
//    
//    self.tpTableView.hidden = NO;
//    self.tableView.hidden = YES;
//    
//    [self searchHistoryInit];
//    
//    return YES;
//}
//
////- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
////{
////    if (IsStrEmpty(searchText)) {
////        [self searchHistoryInit];
////    }
////    else
////    {
////        [self filterHistoryList:searchText];
////    }
////}
//
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    if (self.keyWord.trim.length == 0) {
//        self.searchBar.placeholder = @"搜索商品";
//    }else{
//        self.searchBar.placeholder = self.keyWord;
//    }
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    if (searchBar.text.trim.length > 0)
//    {
//        self.keyWord = searchBar.text;
//        
//        self.tpTableView.hidden = YES;
//        self.tableView.hidden = NO;
//        
//        [self.searchBar resignFirstResponder];
//    }
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
//{
//    if (searchBar.text.trim.length > 0)
//    {
//        self.keyWord = searchBar.text;
//        
//        self.tpTableView.hidden = YES;
//        self.tableView.hidden = NO;
//        
//        [self.searchBar resignFirstResponder];
//    }
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//}

#pragma mark -  HTTP Request Methods
#pragma mark    数据请求的方法实现

- (void)getGBGoodsList{
    [self displayOverFlowActivityView];
    
    self.paramDTO.keyWord = self.keyWord;
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
        
        self.allCount = [service.numberFound integerValue];
        self.isHasResult = ([service.flag integerValue]==0 ? YES : NO);
        
        if (self.isFromHead || self.searchList == nil) {
            self.searchList = [NSMutableArray arrayWithArray:service.searchResultsList];
        }else{
            [self.searchList addObjectsFromArray:service.searchResultsList];
        }
        
        //推荐结果
        if (!self.isHasResult) {
            self.searchList = [NSMutableArray arrayWithArray:service.searchResultsList];
        }
        
        self.nowCount = [self.searchList count];
        
        if (self.nowCount == self.allCount) {
            self.isLastPage = YES;
        }else{
            self.isLastPage = NO;
        }
        
        //推荐结果
        if (self.allCount == 0) {
            self.isLastPage = YES;
        }
        
        self.tableView.tableHeaderView = [self getNoResultTableHeaderView];
        [self.tableView reloadData];
        
//        if (self.allCount == 0) {
//            [self presentSheet:@"没有找到相关团购，请重新搜索"];
//        }
        
    }else{
        [self presentSheet:service.errorMsg];
    }
    
    self.service = nil;
}

#pragma mark -  Refresh LoadMore Methods
#pragma mark    加载更多下拉刷新 方法实现

- (void)refreshData
{
    if (self.tpTableView.isHidden) {
        [super refreshData];
        
//        //清除数据
//        if ([self.searchList count] > 0) {
//            self.searchList = nil;
//            self.tableView.tableHeaderView = [self getNoResultTableHeaderView];
//            [self.tableView reloadData];
//        }
        
        self.paramDTO.pageNumber = @"1";
        [self getGBGoodsList];
    }
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    NSInteger pageNumber = [self.paramDTO.pageNumber integerValue];
    self.paramDTO.pageNumber = [NSString stringWithFormat:@"%d",++pageNumber];
    
    [self getGBGoodsList];
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。

- (UIView *)getNoResultTableHeaderView
{
    UIView *headerView = nil;
    if (!self.isHasResult && [self.searchList count] > 0)
    {
        headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, 320, 80);
        
        UIView  *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        firstView.backgroundColor = RGBCOLOR(239, 239, 239);
        [headerView addSubview:firstView];
        
        UILabel *alertLbl = [[UILabel alloc] init];
        alertLbl.frame = CGRectMake(0, 10, 320, 15);
        alertLbl.backgroundColor = [UIColor clearColor];
        alertLbl.font = [UIFont systemFontOfSize:15];
        alertLbl.text = L(@"LBSorryForNotFoundResult");
        alertLbl.textAlignment = UITextAlignmentCenter;
        alertLbl.textColor = RGBCOLOR(96, 96, 96);
        [firstView addSubview:alertLbl];
        
        UILabel *attrLbl = [[UILabel alloc] initWithFrame:CGRectMake(13, 50, 120, 20)];
        attrLbl.text = L(@"GBHotGroupBuyInThisWeek");
        attrLbl.backgroundColor = [UIColor clearColor];
        attrLbl.textColor = [UIColor blackColor];
        attrLbl.font = [UIFont systemFontOfSize:17];
        [headerView addSubview:attrLbl];
        
        
//        OHAttributedLabel *titleLabel = [[OHAttributedLabel alloc] init];
//        titleLabel.frame = CGRectMake(0, 10, 320, 24);
//        NSMutableAttributedString *attrStr = [[NSMutableAttributedString  alloc] initWithString:@"对不起，暂无搜索结果，本周热门团购："];
//        [attrStr setFont:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 11)];
//        [attrStr setTextColor:[UIColor lightGrayColor] range:NSMakeRange(0, 11)];
//        [attrStr setFont:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(11, attrStr.length - 11)];
//        [attrStr setTextColor:RGBCOLOR(255, 102, 0) range:NSMakeRange(11, attrStr.length - 11)];
//        titleLabel.attributedText = attrStr;
//        [titleLabel setShadowColor:[UIColor whiteColor]];
//        [titleLabel setShadowOffset:CGSizeMake(1, 1)];
//        [headerView addSubview:titleLabel];
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.textAlignment = UITextAlignmentCenter;
        
        UIImageView *seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80-1, 320, 0.5)];
        seperateLine.image = [UIImage imageNamed:@"line.png"];
        [headerView addSubview:seperateLine];

    }
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.tableView) {
        if (IsArrEmpty(self.searchList)) {
            return 0;
        }else{
            if ([self hasMore])
            {
                return  [self.searchList count] + 1;
            }else{
                return [self.searchList count];
            }
        }
    }
    else
    {
        return [self.historyArray count];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.tableView != tableView && !IsArrEmpty(self.historyArray)){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
        contentView.backgroundColor = [UIColor clearColor];
        [contentView setUserInteractionEnabled:YES];
        [contentView addSubview:self.clearHistoryBtn];
        return contentView;
    }else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.tableView != tableView && !IsArrEmpty(self.historyArray)){
        return 70;
    }else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tableView == tableView) {
        if ([self hasMore] && self.nowCount == indexPath.row)
        {
            return 48;
        }else{
            return [GBListGoodsCell height];
        }
    }else{
        return 44;
    }   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    
    if (tableView == self.tableView) {
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
        
        GBListGoodsDTO *goodsDTO = [self.searchList objectAtIndex:row];
        if (!IsNilOrNull(goodsDTO)) {
            static NSString *GBLitGoodsCellIdentifier = @"GBLitGoodsCellIdentifier";
            
            GBListGoodsCell *cell = (GBListGoodsCell *)[tableView dequeueReusableCellWithIdentifier:GBLitGoodsCellIdentifier];
            
            if (!cell) {
                cell = [[GBListGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBLitGoodsCellIdentifier];
                cell.backgroundColor = [UIColor whiteColor];
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
//            UIImageView *seperateLine = (UIImageView *)[cell viewWithTag:101];
//            if (!seperateLine) {
//                seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110-2, 320, 2)];
//                seperateLine.image = [UIImage imageNamed:@"GB_seperatLine.png"];
//                seperateLine.tag = 101;
//                [cell.contentView addSubview:seperateLine];
//            }
            
            [cell setItem:goodsDTO];
            
            return cell;
            
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            return cell;
        }
    }
    else
    {
                
        static NSString *HistoryCellIdentifier = @"HistoryCellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryCellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
//        if (!IsArrEmpty(self.historyArray) && [self.historyArray count] > indexPath.row)
        if (!IsArrEmpty(self.historyArray))
        {
            NSString *historyKey = [self.historyArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = historyKey;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.textColor = [UIColor blackColor];
        }
        else
        {
            if (indexPath.row == 1)
            {
                cell.textLabel.text = L(@"LBNoSearchHistoryYet");
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.textColor = [UIColor lightGrayColor];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
            else
            {
                cell.textLabel.text = nil;
            }
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        NSInteger row = [indexPath row];
        if ([self hasMore]&&self.nowCount == row) {
            return;
        }
        GBListGoodsDTO *dto = [self.searchList objectAtIndex:row];
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
    }else{
        if ([self.historyArray count] > indexPath.row)
        {
            NSString *historyKey = [self.historyArray objectAtIndex:indexPath.row];
            self.keyWord = historyKey;
            
            self.tpTableView.hidden = YES;
            self.tableView.hidden = NO;
            
            [self.searchBar resignFirstResponder];
        }
    }
}

#pragma mark -  Property Methods
#pragma mark    属性的方法实现
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.tintColor = RGBCOLOR(229, 229, 229);
//        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder = L(@"GB_Search_Bar_Placeholder");
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(0, 0, 320, 44);
        
        for (id button in _searchBar.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                UIButton *cancelButton=(UIButton*)button;
                cancelButton.tintColor = RGBCOLOR(30, 195, 236);
                [cancelButton setTitle:L(@"BTSearch") forState:UIControlStateNormal];
            }
        }
    }
    return _searchBar;
}

- (SearchbarView *)searchBarView
{
    if (!_searchBarView) {
        _searchBarView = [[SearchbarView alloc] init];
        _searchBarView.backgroundColor = RGBCOLOR(242, 242, 242);
        _searchBarView.delegate = self;
        _searchBarView.frame = CGRectMake(0, 0, 320, 44);
        [_searchBarView addSubview:self.cancelBtn];
        
        _searchBarView.lineView.hidden = YES;
        _searchBarView.searchImgView.frame = CGRectMake(10, 8, 245, 28);
        _searchBarView.searchImgBtn.frame = CGRectMake(16, 13, 20, 20);
        _searchBarView.searchTextField.frame = CGRectMake(42, 13, 205, 20);
        _searchBarView.searchTextField.font = [UIFont systemFontOfSize:15];
    }
    return _searchBarView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 7, 50, 30)];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:L(@"Clear") forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.hidden = YES;
        [_cancelBtn addTarget:self action:@selector(hideSearchBarView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelBtn;
}

- (GBListService *)service{
    if (!_service) {
        _service = [[GBListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (UIButton *)clearHistoryBtn
{
    if (!_clearHistoryBtn) {
        _clearHistoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 17, 274, 43)];
        _clearHistoryBtn.backgroundColor = [UIColor clearColor];
        [_clearHistoryBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
        [_clearHistoryBtn setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
        [_clearHistoryBtn setTitle:L(@"BTClearHistory") forState:UIControlStateNormal];
        [_clearHistoryBtn addTarget:self action:@selector(clearHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearHistoryBtn;
}

- (void)clearHistoryBtnClick
{
    [Config currentConfig].gbHistoryArray = nil;
    [self.historyArray removeAllObjects];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tpTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (TPKeyboardAvoidingTableView *)pktableView
{
	if(!_pktableView){
		
		_pktableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStylePlain];
		
		[_pktableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_pktableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_pktableView.scrollEnabled = YES;
		
		_pktableView.userInteractionEnabled = YES;
		
		_pktableView.delegate = self;
		
		_pktableView.dataSource = self;
		
		_pktableView.backgroundColor = [UIColor clearColor];
        
        _pktableView.backgroundView = nil;
	}
	
	return _pktableView;
}

- (void)hideSearchBarView
{
    [self hideSearchBar:nil];
    
    self.tpTableView.hidden = YES;
    self.tableView.hidden = NO;
    
}

//显示搜索框
- (void)showSearchBar
{
//    self.tableView.scrollEnabled = NO;
    self.cancelBtn.hidden = NO;
    self.searchBarView.wholeImageView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.3 animations:^{
    
    self.searchBarView.searchImgView.frame = CGRectMake(10, 8, 245, 28);
    self.searchBarView.searchTextField.frame = CGRectMake(42, 13, 205, 20);
    
    }completion:^(BOOL finished) {
        
    }];
}

- (void)hideSearchBar:(UIButton *)btn
{
    
//    if (btn.tag == 1001) {
//        [self.searchBarView.searchTextField resignFirstResponder];
//        self.searchBarView.searchTextField.text = @"";
//    }
//    self.tableView.scrollEnabled = YES;
    self.cancelBtn.hidden = YES;
    self.searchBarView.wholeImageView.alpha = 0.0f;
    [self.searchBarView.searchTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
    
    
    self.searchBarView.searchImgView.frame = CGRectMake(10, 8, 300, 28);
    self.searchBarView.searchTextField.frame = CGRectMake(42, 13, 260, 20);
    //self.searchBarView.searchTextField.text = nil;
    
    
    }completion:^(BOOL finished){
    //
    }];
}

@end
