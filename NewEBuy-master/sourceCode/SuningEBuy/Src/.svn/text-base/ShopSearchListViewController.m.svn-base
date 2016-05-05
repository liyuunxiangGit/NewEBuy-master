//
//  ShopSearchListViewController.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopSearchListViewController.h"
#import "UITableViewMoreCell.h"
#import "JASidePanelController.h"

#define kTableViewInsetTopWithKeyWord      (44 + 65)
#define kTableViewInsetTopWithKeyWordIOS7  (64 + 65)
#define kTableViewInsetTopWithoutKeyWord  [self getReasonableTabelViewContentInsetTop]

@interface ShopSearchListViewController ()
//刷新相关操作
- (BOOL)hasMore;
- (void)refreshData;
- (void)loadMoreData;
- (void)startMoreCellAnimation:(BOOL)animating;
@end

@implementation ShopSearchListViewController

+ (void)gotoShopSearchWithKeyWord:(NSString *)keyword fromNav:(UINavigationController *)nav
{
    ShopSearchListParamDTO *param = [[ShopSearchListParamDTO alloc] init];
    param.keyWord = keyword;
    ShopSearchListViewController *v = [[ShopSearchListViewController alloc] initWithSearchCondition:param];
    
    JASidePanelController *jasideController = [[JASidePanelController alloc] init];
    jasideController.shouldDelegateAutorotateToVisiblePanel = NO;
    jasideController.rightGapPercentage = 0.8;
    jasideController.shouldResizeRightPanel = YES;
    jasideController.bounceOnSidePanelOpen = NO;
    jasideController.allowLeftOverpan = NO;
    jasideController.allowRightOverpan = NO;
    jasideController.centerPanel = v;
    jasideController.rightPanel = nil;
    jasideController.leftPanel = nil;
    jasideController.hasSuspendButton = NO;
    jasideController.hidesBottomBarWhenPushed = YES;
    
    [nav pushViewController:jasideController animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.hasSuspendButton = NO;
    
    //tableview 属性初始化
    self.tableView.frame = self.view.bounds;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
    
    //加入所有组件
    self.customNavigationBar.searchTextField.text = self.shopSearchCondition.keyWord;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.statusbarBack];
    [self.view addSubview:self.customNavigationBar];
    [self.view addSubview:self.segmentView];
    
    //发送请求
    [self refreshData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceSearchByKeyWord) name:VOICE_SEARCH object:nil];
}

- (void)voiceSearchByKeyWord
{
    if ([VoiceSearchViewController sharedVoiceSearchCtrl].from == From_ShopSearch)
    {
        [[VoiceSearchViewController sharedVoiceSearchCtrl] removeVoiceSearchView];
//        [SearchListViewController goToSearchResultWithKeyword:[VoiceSearchViewController sharedVoiceSearchCtrl].result fromNav:self.navigationController];
        [self didSelectAssociationalWord:[VoiceSearchViewController sharedVoiceSearchCtrl].result];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithSearchCondition:(ShopSearchListParamDTO *)condition
{
    if (self = [super init])
    {
        self.shopSearchCondition = condition;
    }
    
    return self;
}

#pragma mark - 界面组件

- (SearchNavigationBar *)customNavigationBar
{
    if (!_customNavigationBar)
    {
        int y = 0;
        if (IOS7_OR_LATER)
        {
            y = 20;
        }
        
        _customNavigationBar = [[SearchNavigationBar alloc] initWithFrame:CGRectMake(0, y, 320, 44)];
        _customNavigationBar.customSearchNavBarDelegate = self;
    }

    return _customNavigationBar;
}

- (UIToolbar *)statusbarBack
{
    if (!_statusbarBack)
    {
        if (IOS7_OR_LATER)
        {
            _statusbarBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            _statusbarBack.translucent = YES;
            [_statusbarBack setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(320, 20)] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }
        else
        {
            _statusbarBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
    }
    
    return _statusbarBack;
}

- (ShopSearchSegmentView *)segmentView
{
    if (!_segmentView)
    {
        int y = 44;
        if (IOS7_OR_LATER)
        {
            y = 64;
        }
        
        _segmentView = [[ShopSearchSegmentView alloc] initWithFrame:CGRectMake(0, y, 320, 40)];
        
        _segmentView.delegate = self;
    }
    
    return _segmentView;
}

- (void)searchSegmentDidChangeSortType:(int)sort
{
    self.shopSearchCondition.st = [NSString stringWithFormat:@"%d", sort];
    
    [self refreshData];
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

- (SNReaderController *)readerController
{
    if (!_readerController) {
        _readerController = [[SNReaderController alloc] initWithContentController:self];
        //        _readerController.rootControl = SEARCH_PAGE_TYPE;
    }
    return _readerController;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] init];
        
        _footView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height - kTableViewInsetTopWithoutKeyWord);
        _footView.backgroundColor = [UIColor clearColor];
    }
    return _footView;
}

#pragma mark - service 初始化和请求结果

-(ShopSearchListService *)shopSearchListService
{
    if (!_shopSearchListService)
    {
        _shopSearchListService = [[ShopSearchListService alloc] init];
        _shopSearchListService.delegate = self;
    }
    
    return _shopSearchListService;
}

- (void)getShopListCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg service:(ShopSearchListService *)service
{
    if (self.shopSearchListService.isLoadMore)
    {
        [self startMoreCellAnimation:NO];
    }
    
    if (isSuccess)
    {
        _footViewType = SearchResultViewNormal;
    }
    else
    {
        _footViewType = SearchResultViewRecommend;
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
                }
                
            }
        }

    }
    
    
    
    [self removeOverFlowActivityView];
    
    [self updateTableView];
}

#pragma mark - 刷新相关操作
- (BOOL)hasMore
{
    return [self.shopSearchListService hasMore];
}

- (void)refreshData
{
    [self displayOverFlowActivityView];
    
    [self.shopSearchListService refreshData:self.shopSearchCondition];
    
    [self.shopSearchListService.shopList removeAllObjects];
 
    [self updateTableView];
}

- (void)loadMoreData
{
    [self startMoreCellAnimation:YES];
    
    [self displayOverFlowActivityView];
    
    [self.shopSearchListService loadMoreData:self.shopSearchCondition];
}

- (void)startMoreCellAnimation:(BOOL)animating
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.shopSearchListService.shopList count] + 1 inSection:0] ;
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[UITableViewMoreCell class]]) {
		
		UITableViewMoreCell *_cell = (UITableViewMoreCell *)cell;
        
		[_cell setAnimating: animating];
	}
}

#pragma mark - tableview 状态

- (int)getReasonableTabelViewContentInsetTop
{
    if (IOS7_OR_LATER)
        return 64 + 40;
    else
        return 44 + 40;
}

- (void)updateTableView
{
    if (self.shopSearchListService.isLoading) {
        _footViewType = SearchResultViewLoading;
    }
    [self setSearchResultViewType:_footViewType];
    [self.tableView reloadData];
}

- (void)setSearchResultViewType:(SearchResultViewType)type
{
    switch (type) {
        case SearchResultViewNormal:
        {
            self.tableView.tableFooterView = nil;
            
            [self.customNavigationBar showButtons:SearchResultState];
            
            self.segmentView.hidden = NO;
            
            isNoResult = NO;
            break;
        }
        case SearchResultViewLoading:
        {
            self.tableView.tableFooterView = nil;
            
            self.segmentView.hidden = NO;
            break;
        }
        case SearchResultView404:
        case SearchResultViewLoadFail:  //暂时不能到该步
        {
            self.tableView.tableFooterView = nil;
            
            self.segmentView.hidden = NO;
            break;
        }
        case SearchResultViewRecommend:
        {
            [self changeFootViewStyle];
            self.tableView.tableFooterView = self.footView;
            
            [self.customNavigationBar showButtons:SearchNoResultState];
            
            isNoResult = YES;
            
            self.segmentView.hidden = YES;
            break;
        }
        default:
            break;
    }
}

- (void)changeFootViewStyle
{
    [self.footView removeAllSubviews];
    
    UIImageView *notFoundImgView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 83.5) / 2, 115, 167 / 2, 188 / 2)];
    notFoundImgView.image = [UIImage imageNamed:@"shopSearch_notFound.png"];
    
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 220, 320, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.automaticallyAddLinksForType = 0;
    label.underlineLinks = NO;
    label.tag = 100;
    NSString *keyword = self.shopSearchCondition.keyWord;
    
    NSString *str;
    if (keyword)
    {
        if (keyword.length > 8)
        {
            keyword = [keyword substringToIndex:8];
            keyword = [keyword stringByAppendingString:@"..."];
        }
        str = [NSString stringWithFormat:@"%@，%@%@%@", L(@"Constant_Sorry"),L(@"Search_NotFound"),keyword,L(@"Search_RelevantShop")];
    }
    else
    {
        str = [NSString stringWithFormat:@"%@，%@%@",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_RelevantShop")];
    }
    NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muteStr setFont:[UIFont systemFontOfSize:14.0]];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0x707070]];
    
    if (keyword)
    {
        [muteStr setTextColor:[UIColor colorWithRGBHex:0xfc7c26] range:[str rangeOfString:keyword]];
    }
    [muteStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByTruncatingTail];
    label.attributedText = muteStr;
    
    [_footView addSubview:label];
    [_footView addSubview:notFoundImgView];
}

- (void)refreshNotFoundInfo
{
    if (self.footView)
    {
        OHAttributedLabel *label = (OHAttributedLabel *)[self.footView viewWithTag:100];
        NSString *keyword = self.shopSearchCondition.keyWord;
        
        NSString *str;
        if (keyword)
        {
            if (keyword.length > 8)
            {
                keyword = [keyword substringToIndex:8];
                keyword = [keyword stringByAppendingString:@"..."];
            }
            str = [NSString stringWithFormat:@"%@，%@%@%@", L(@"Constant_Sorry"),L(@"Search_NotFound"),keyword,L(@"Search_RelevantShop")];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@，%@%@",L(@"Constant_Sorry"),L(@"Search_NotFound"),L(@"Search_RelevantShop")];
        }
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.shopSearchListService.shopList && self.shopSearchListService.shopList.count > 0)
    {
        if ([self hasMore])
        {
            return self.shopSearchListService.shopList.count + 1;
        }
        return self.shopSearchListService.shopList.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopSearchListService.shopList && self.shopSearchListService.shopList.count > 0)
    {
        //加载更多cell
        if (indexPath.row == self.shopSearchListService.shopList.count)
            return 52;
    }
    
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //加载更多cell
    if ([self hasMore] && indexPath.row == [self.shopSearchListService.shopList count])
    {
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
    
    //店铺cell
    static NSString *shopCellIdentifier = @"shopCellIdentifier";
    ShopSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCellIdentifier];
    if (cell == nil) {
        cell = [[ShopSearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.shopSearchListService.shopList.count <= indexPath.row)
    {
        return cell;
    }
    
    ShopSearchListDTO *dto = [self.shopSearchListService.shopList objectAtIndex:indexPath.row];
    
    [cell setItem:dto];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self hasMore] && indexPath.row == [self.shopSearchListService.shopList count]) {
        
        [self loadMoreData];
        return;
    }
    if (indexPath.row < self.shopSearchListService.shopList.count && indexPath.row >= 0)
    {
        ShopSearchListDTO *dto = (ShopSearchListDTO *)[self.shopSearchListService.shopList objectAtIndex:indexPath.row];
        NSString *strUrl = dto.shopId;
        
        //店铺搜索url
        if (NotNilAndNull(strUrl))
        {
            //added by gyj 251店铺链接更换，且不需要强行10位编码，8位10位都可以
            NSString *jumpUrl = [NSString stringWithFormat:@"%@/%@.html?client=app",kMHostAddressForHttp,strUrl?strUrl:@""];
            
            SNWebViewController *webv = [[SNWebViewController alloc] initWithRequestUrl:jumpUrl];
            [self.navigationController pushViewController:webv animated:YES];
        }
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
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView   // called on finger up as we are moving
{
    self.tableView.showsVerticalScrollIndicator = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
{
    self.tableView.showsVerticalScrollIndicator = NO;//防止突然进入滚动状态时滚动条闪烁
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
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
        self.segmentView.transform = CGAffineTransformMakeTranslation(0, -300);
        
    } completion:^(BOOL finished) {
    }];
}

- (void)showTopBars
{

    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithoutKeyWord, 0, 0, 0);

    
    [UIView animateWithDuration:0.5 animations:^{
        self.customNavigationBar.transform = CGAffineTransformIdentity;
        self.segmentView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

#pragma mark -  Delegate Methods

- (void)backForePage
{
    NSArray *viewCtrls = self.parentViewController.navigationController.viewControllers;
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

- (void)showFilterView:(id)sender
{
    
}

- (void)cancelSearch:(id)sender
{
    [self.customNavigationBar.searchTextField resignFirstResponder];
    self.customNavigationBar.searchTextField.text = self.shopSearchCondition.keyWord;
    
    if (!self.tableView.tableFooterView)
    {
        [self.customNavigationBar showButtons:SearchResultState];
    }
    else
    {
        [self.customNavigationBar showButtons:SearchNoResultState];
    }
    
}

- (void)readerBegin
{
     [self.readerController beginReader];
}

#pragma mark - Search Textfiled Delegate Methods

- (void)beginSearch:(id)sender
{
    [ChooseSearchTypeView hide];
    [self didSelectAssociationalWord:self.customNavigationBar.searchTextField.text];
}

- (void)textChanged:(id)sender
{
    [self.keywordDisplayController refreshViewWithKeyword:self.customNavigationBar.searchTextField.text];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.keywordDisplayController displayView:nil];
    
    [self.customNavigationBar showButtons:SearchShowingSearchTypeState];
    
    if (self.shopSearchCondition.keyWord)
        self.customNavigationBar.searchTextField.text = self.shopSearchCondition.keyWord;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keywordDisplayController refreshViewWithKeyword:self.shopSearchCondition.keyWord];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.customNavigationBar showButtons:SearchResultState];
    
    [self.keywordDisplayController removeView];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
   
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        return YES;
}

- (void)resetSearchSort
{
    //    [_segmentCell setSelectedSort:SortTypeDefault];
    
    [self.segmentView setSelectedSort:SortTypeDefault];
    //    [self.searchsegmentView ]
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
    
    [self.customNavigationBar.searchTextField resignFirstResponder];
    [self.customNavigationBar showButtons:SearchResultState];
    
    if (NotNilAndNull(keyword)) {
        //加入数据库
        SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
        [dao addKeywordToDB:keyword];

        int searchType = [[Config currentConfig].searchType intValue];
        
        if (searchType == 0)
        {
            [SearchListViewController goToSearchResultWithKeyword:keyword fromNav:self.navigationController];
        }
        else if(searchType == 1)
        {
            [self resetSearchSort];
            self.shopSearchCondition.keyWord = keyword;
            self.customNavigationBar.searchTextField.text = keyword;
            [self refreshData];
        }
    }
}

//防止警告
- (void)deleteHistoryOk
{
    
}
@end
