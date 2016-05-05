//
//  HomePageViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeFloorDTO.h"
#import "SNWebViewController.h"
#import "PruductList244ViewController.h"
#import "SalePromotionViewController.h"
#import "AutoLoginCommand.h"
#import "ServiceTrackListViewController.h"
#import "NewGetRedPackViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GuessYouLikeCell.h"


@interface HomePageViewController () {
    NSMutableArray  *tableStructureDictArray;
    int index;
    NSString            *getredpackstr;
    //是否请求推荐数据
    BOOL                willRequestRecommendData;
}

@property (nonatomic,strong) ZhuanTiDTO         *cuXiaoDto;
@property (nonatomic,strong) UIImageView        *recommendImageView;
@property (nonatomic,strong) UITableView        *guessYouLikeTableView;
@property (nonatomic,strong) UIImageView        *guessRefreshHeaderView;
@property (nonatomic,strong) UIButton           *goToTopButton;
@property (nonatomic,strong) UIImageView        *recommendIconUpImageView;
@property (nonatomic,strong) UIImageView        *recommendIconDownImageView;
@property (nonatomic,strong) UIImageView        *recommendScanEndImageView;

@end

@implementation HomePageViewController

@synthesize homeSearchView              = _homeSearchView;
@synthesize readerController            = _readerController;
@synthesize recommendImageView          = _recommendImageView;
@synthesize guessYouLikeTableView       = _guessYouLikeTableView;
@synthesize guessRefreshHeaderView      = _guessRefreshHeaderView;
@synthesize goToTopButton               = _goToTopButton;
@synthesize recommendIconDownImageView  = _recommendIconDownImageView;
@synthesize recommendIconUpImageView    = _recommendIconUpImageView;
@synthesize recommendScanEndImageView   = _recommendScanEndImageView;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"PageTitleFirstPage");
        self.pageTitle = L(@"PageTitleFirstPageShow");
        self.hasNav = NO;
        self.isNeedBackItem = NO;
        self.iOS7FullScreenLayout = YES;
        self.isLastPage = YES;
        
        
        //为了实现在首页调整状态栏的文字颜色，取消了导航栏，使用了一个UIView
        if (IOS7_OR_LATER) {
            navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        }
        else {
            navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        }

        navigationView.backgroundColor = [UIColor colorWithRGBHex:0xFF7700];
        [self.view addSubview:navigationView];
        
        
        /*
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(firstLoaded) name:HOME_FIRST_LOADED_MESSAGE
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshHomeData)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
         */
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceSearchByKeyWord) name:VOICE_SEARCH object:nil];
        
        self.bSupportPanUI = NO;
        
        self.iOS7FullScreenLayout = YES;
        
        index = 1;
        
        tableStructureDictArray = [[NSMutableArray alloc] init];
        
        floorDataArray = [[NSMutableArray alloc] init];
//        edit by gjf，刷新页面
        [self refreshData];

        
    }
    return self;
}


/*
- (void)firstLoaded
{
    
}


- (void)refreshHomeData
{
    
}
*/


/**
 *  获取首页楼层数据
 */
- (void)refreshHomePageData {
    
    [self.homePageService queryHomePageData];
    if (KHomePage)
    {
        if ([PerformanceStatistics sharePerformanceStatistics].countStatus > 0)
        {
            return;
        }
        PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
        temp.startTime = [NSDate date];
        temp.functionId = @"2";
        temp.interfaceId = @"101";
        temp.taskId = @"1001";
        temp.count = 1;
        [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
    }

}

- (void)voiceSearchByKeyWord
{
    if ([VoiceSearchViewController sharedVoiceSearchCtrl].from == From_NewHome)
    {
        [[VoiceSearchViewController sharedVoiceSearchCtrl] removeVoiceSearchView];
        [self didSelectAssociationalWord:[VoiceSearchViewController sharedVoiceSearchCtrl].result];
    }
}

- (void)didSelectAssociationalWord:(NSString *)keyword
{
    //    [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 1;
    //    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:1];
    //    [nav popToRootViewControllerAnimated:NO];
    //    NewSearchViewController *search = (NewSearchViewController *)[nav.viewControllers objectAtIndex:0];
    //    [search didSelectAssociationalWord:keyword];
    //    search.homeKeyString = keyword;
    [_homeView.searchBarView.searchTextField resignFirstResponder];
    _homeView.searchBarView.searchTextField.text = nil;
    self.homeSearchView.keywordList = nil;
    
    [self.homeSearchView removeView];
    
    [_homeView hideSearchBar:nil];
    
//    [self startTimer];
    
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
    
    //reload最近搜索
    
    __weak HomePageViewController *weakSelf = self;
    
    [self.searchService addKeywordToDB:keyword completionBlock:^(NSArray *list){
        weakSelf.homeSearchView.historyKeywordsList = list;
        [weakSelf.homeSearchView.displayTableView reloadData];
    }];
    
    self.homeSearchView.keyWord = nil;
    
    int searchType = [[Config currentConfig].searchType intValue];
    if (searchType == 0) {
        [SearchListViewController goToSearchResultWithKeyword:keyword fromNav:self.navigationController];
    }
    else if (searchType == 1)
    {
        [ShopSearchListViewController gotoShopSearchWithKeyWord:keyword fromNav:self.navigationController];
    }
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120002"], nil]];
}


- (SNReaderController *)readerController
{
    if (!_readerController) {
        _readerController = [[SNReaderController alloc] initWithContentController:self];
    }
    return _readerController;
}

- (HomeSearchController *)homeSearchView
{
    if (!_homeSearchView) {
        _homeSearchView = [[HomeSearchController alloc] initWithContentController:self];
        
        _homeSearchView.delegate = self;
    }
    return _homeSearchView;
}

- (HomePageService244 *)homePageService {
    if (!_homePageService) {
        _homePageService = [[HomePageService244 alloc] init];
        _homePageService.delegate = self;
    }
    
    return _homePageService;
}

- (SearchService *)searchService
{
    if (!_searchService) {
        _searchService = [[SearchService alloc] init];
        _searchService.delegate = self;
    }
    return _searchService;
}


- (SearchService *)hotWordsService
{
    if (!_hotWordsService) {
        _hotWordsService = [[SearchService alloc] init];
        _hotWordsService.delegate = self;
    }
    return _hotWordsService;
}

- (GuessYouLikeService *)guessYouLikeService
{
    if(!_guessYouLikeService){
        _guessYouLikeService = [[GuessYouLikeService alloc] init];
        _guessYouLikeService.delegate = self;
    }
    return _guessYouLikeService;
}

-(InvitationService *)invita
{
    if (!_invita) {
        _invita=[[InvitationService alloc]init];
        _invita.delegate=self;
    }
    return _invita;
}

- (void)getHotKeywordsCompleteWithService:(SearchService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    if (isSuccess)
    {
        _homeView.searchBarView.searchTextField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    }
    else
    {
        
    }
}

- (ZhuanTiService244 *)zhuanTiService {
    if (!_zhuanTiService) {
        _zhuanTiService = [[ZhuanTiService244 alloc] init];
        _zhuanTiService.delegate = self;
    }
    
    return _zhuanTiService;
}

#pragma mark -
#pragma mark GuessYouLike

//added by gyj 猜你喜欢模块tableview
- (UITableView *)guessYouLikeTableView
{
    if(!_guessYouLikeTableView){
        _guessYouLikeTableView = [UITableView tableView];
        [_guessYouLikeTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_guessYouLikeTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _guessYouLikeTableView.scrollEnabled = YES;
        _guessYouLikeTableView.userInteractionEnabled = YES;
        _guessYouLikeTableView.delegate =self;
        _guessYouLikeTableView.dataSource =self;
        _guessYouLikeTableView.backgroundColor =[UIColor clearColor];
    }
    return _guessYouLikeTableView;
}

//猜你喜欢模块头部刷新
- (UIImageView *)guessRefreshHeaderView
{
    if(!_guessRefreshHeaderView){
        _guessRefreshHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -30, kScreenWidth, 30)];
        _guessRefreshHeaderView.backgroundColor = [UIColor clearColor];
        self.guessYouLikeTableView.showsVerticalScrollIndicator = YES;
        
        UIImageView *lineImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 21, 112, 0.5)];
        lineImgView1.backgroundColor = [UIColor colorWithRGBHex:0xcecece];
        [_guessRefreshHeaderView addSubview:lineImgView1];
        
        UIImageView *lineImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(199, 21, 112, 0.5)];
        lineImgView2.backgroundColor = [UIColor colorWithRGBHex:0xcecece];
        [_guessRefreshHeaderView addSubview:lineImgView2];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(143, 15, 50, 14)];
        label.textAlignment = UITextAlignmentCenter;
        label.text = L(@"PushAndReturn");
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRGBHex:0x707070];
        [_guessRefreshHeaderView addSubview:label];
        
        [_guessRefreshHeaderView addSubview:self.recommendIconDownImageView];
    }
    return _guessRefreshHeaderView;
}

//首页底部展示一行推荐文字
- (UIImageView *)recommendImageView
{
    if(!_recommendImageView){
        _recommendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _recommendImageView.backgroundColor = [UIColor clearColor];
        _recommendImageView.layer.masksToBounds = YES;
        
        UIImageView *lineImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 21, 83, 0.5)];
        lineImgView1.backgroundColor = [UIColor colorWithRGBHex:0xcecece];
        [_recommendImageView addSubview:lineImgView1];
        
        UIImageView *lineImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(232, 21, 78, 0.5)];
        lineImgView2.backgroundColor = [UIColor colorWithRGBHex:0xcecece];
        [_recommendImageView addSubview:lineImgView2];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(117, 15, 110, 14)];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = L(@"GiveYouLikeGoods");
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithRGBHex:0x707070];
        [_recommendImageView addSubview:label];
        
        [_recommendImageView addSubview:self.recommendIconUpImageView];
    }
    return _recommendImageView;
}

- (UIImageView *)recommendScanEndImageView
{
    if(!_recommendScanEndImageView){
        _recommendScanEndImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _recommendScanEndImageView.backgroundColor = [UIColor clearColor];
        _recommendScanEndImageView.layer.masksToBounds = YES;
        
        UIImageView *lineImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 90, 0.5)];
        lineImgView1.backgroundColor = [UIColor colorWithRGBHex:0xcecece];
        [_recommendScanEndImageView addSubview:lineImgView1];
        
        UIImageView *lineImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(223, 20, 87, 0.5)];
        lineImgView2.backgroundColor = [UIColor colorWithRGBHex:0xcecece];
        [_recommendScanEndImageView addSubview:lineImgView2];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(107, 15, 115, 14)];
        label.backgroundColor = [UIColor clearColor];
        label.text = L(@"DoneSeeLater");
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithRGBHex:0x707070];
        [_recommendScanEndImageView addSubview:label];
    }
    return _recommendScanEndImageView;
}

//回到顶部
- (UIButton *)goToTopButton
{
    if(!_goToTopButton)
    {
        _goToTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _goToTopButton.backgroundColor = [UIColor clearColor];
        _goToTopButton.frame = CGRectMake(kScreenWidth-60, kScreenHeight-(IOS7_OR_LATER?0:20)-100, 50, 50);
        _goToTopButton.alpha = 0;
        [_goToTopButton setImage:[UIImage imageNamed:@"home_gototop.png"] forState:UIControlStateNormal];
        [_goToTopButton addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goToTopButton;
}

- (UIImageView *)recommendIconUpImageView
{
    if(!_recommendIconDownImageView)
    {
        _recommendIconDownImageView = [[UIImageView alloc] init];
        _recommendIconDownImageView.backgroundColor = [UIColor clearColor];
        _recommendIconDownImageView.frame = CGRectMake(100, 16, 12, 12);
        _recommendIconDownImageView.image = [UIImage imageNamed:@"home_recommend_up.png"];
    }
    return _recommendIconDownImageView;
}

- (UIImageView *)recommendIconDownImageView
{
    if(!_recommendIconUpImageView)
    {
        _recommendIconUpImageView = [[UIImageView alloc] init];
        _recommendIconUpImageView.backgroundColor = [UIColor clearColor];
        _recommendIconUpImageView.frame = CGRectMake(127, 16, 12, 12);
        _recommendIconUpImageView.image = [UIImage imageNamed:@"home_recommend_down.png"];
    }
    return _recommendIconUpImageView;
}

//回到顶部
- (void)goToTop
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-(IOS7_OR_LATER?44:(64+49)));
        self.tableView.frame = frame;
        self.guessYouLikeTableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-(IOS7_OR_LATER?64:44));
    }completion:^(BOOL finished){
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    [self.guessYouLikeTableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}


#pragma mark -ViewLifeCycle

- (void)loadView
{
    [super loadView];
    
    _homeView = [[NewHomeTopView alloc] initWithOwner:self];
//    self.navigationItem.titleView = _homeView.searchBarView;
    
//    _homeView.searchBarView.backgroundColor = [UIColor colorWithRGBHex:0xFF9233];
    if (IOS7_OR_LATER) {
        _homeView.searchBarView.frame = CGRectMake(12, 20, kScreenWidth, 44);
    }
    else {
        _homeView.searchBarView.frame = CGRectMake(12, 0, kScreenWidth, 44);
    }

    _homeView.searchBarView.searchImgView.backgroundColor = [UIColor colorWithRGBHex:0xFF9233];
    _homeView.searchBarView.searchImgView.layer.cornerRadius = 5.0f;
    [_homeView.searchBarView.searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_homeView.searchBarView.searchTextField setValue:[UIFont fontWithName:@"Arial" size:14.0] forKeyPath:@"_placeholderLabel.font"];
    
    
    [navigationView addSubview:_homeView.searchBarView];

    //需要区分table的位置
    if (IOS7_OR_LATER) {
        self.tableView.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
    }
    else {
        self.tableView.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-64-49);
    }

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.multipleTouchEnabled = NO;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    //added by gyj 用tag区分首页和推荐模块（猜你喜欢）两个tableview
    self.tableView.tag = 0;
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];
    
    //猜你喜欢模块
    CGRect frame = CGRectMake(0, IOS7_OR_LATER?64:44, kScreenWidth, kScreenHeight-(IOS7_OR_LATER?64:44));
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
    self.guessYouLikeTableView.frame = frame;
    self.guessYouLikeTableView.backgroundColor = [UIColor clearColor];
    self.guessYouLikeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.guessYouLikeTableView.tag = 1;
    [self.view addSubview:self.guessYouLikeTableView];
    [self.guessYouLikeTableView addSubview:self.guessRefreshHeaderView];
    
    [self.view addSubview:self.goToTopButton];
    //第一次进首页标志置为YES，表示可以请求推荐数据
    willRequestRecommendData = YES;
    willLoadRecommendLabel = NO;
    
    //快速注册楼层
    quickRegistView = [[QuickRegistFloatingView alloc] initWithOwner:self];
    quickRegistView.frame = CGRectMake(0, kScreenHeight-49-50, kScreenWidth, 50);
    quickRegistView.hidden = YES;
    [self.view addSubview:quickRegistView];
    
    //初始化位XXXX防止推荐－四级页－推荐时souceTitle变为"活动"
    sourceTitle = @"XXXX";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //更新地址
    [AddressInfoDAO isUpdateAddressOk];
    
    //自动登录
    AutoLoginCommand *loginCmd = [AutoLoginCommand command];
    [CommandManage excuteCommand:loginCmd observer:nil];
    //快速注册浮层也暂时注释掉
//    [CommandManage excuteCommand:loginCmd completeBlock:^(id<Command> cmd) {
//        [self showFloatingView];
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([sourceTitle isEqualToString:@"XXXX"]){
        sourceTitle = @"活动";
    }
    if (IOS7_OR_LATER) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    _homeView.searchBarView.searchTextField.placeholder = [self switchSearchwords];
}


- (void)viewDidAppear:(BOOL)animated
{
    if (KHomePage)
    {
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = [NSDate date];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
    }
    //解决从其他也页面跳回箭头角度变化的问题
//    if(willLoadRecommendLabel){
//        self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(0.0);
//    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark SearchBarView Delegate

- (BOOL)searchFieldShouldBeginEditing:(UITextField *)textField{
    
    textField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    [_homeView showSearchBar];
    
//    //    if (![textField.placeholder isEqualToString:L(@"Search Product")]) {
    //        textField.text=textField.placeholder;
    //    }
    
    [self goToSearchView:nil];
    
    return YES;
}

- (void)searchBar:(UITextField *)searchField textDidChange:(NSString *)searchText{
    
    self.homeSearchView.keyWord = searchText;
    [self.homeSearchView refreshViewWithKeyword:searchText];
    
    if ([searchText isEqualToString:@""]) {
        searchField.placeholder = [self switchSearchwords];
    }
    
}

- (BOOL)searchFieldShouldEndEditing:(UITextField *)textField{
    [self cancelSearchBar];
    return YES;
}

- (void)searchFieldSearchButtonClicked:(UITextField *)searchField
{
    [ChooseSearchTypeView hide];
    NSString *keyword = searchField.text;
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        //        if ([_homeView.searchBarView.searchTextField.placeholder isEqualToString:@"搜索商品"]) {
        //            keyword = nil;
        //            return;
        //        }
        //        else
        //        {
        //            keyword = _homeView.searchBarView.searchTextField.placeholder;
        //        }
        
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
    [searchField resignFirstResponder];
    
    //    NSString *url = [[DefaultKeyWordManager defaultManager] findUrlWithWord:keyword];
    //
    //    if (url && url.length > 0)
    //    {
    
    //        @weakify(self);
    //        [self routeWithUrl:url complete:^(BOOL isSuccess) {
    //
    //            @strongify(self);
    //            if (!isSuccess) {
    //
    //                [self didSelectAssociationalWord:keyword];
    //            }
    
    //        }];
    //    }
    //    else
    //    {
    [self didSelectAssociationalWord:keyword];
    //    }
    
}


#pragma mark - Switch Hot Keywords
-(NSString *)switchSearchwords
{
    //    NSString *str = [SNSwitch randomSearchPlaceholder];
    //    NSLog(@"++++++++++++++++++++++%@", str);
    //    return str;
    //    return [SNSwitch randomSearchPlaceholder];
    return [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
}


- (void)goToSearchView:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"111302"], nil]];
    self.homeSearchView.keywordList = nil; //add by wangjiaxing 20130603
    self.homeSearchView.keywordTypesList = nil;
    [self.homeSearchView displayView];
    
    self.homeSearchView.keyWord = _homeView.searchBarView.searchTextField.text;
    [self.homeSearchView refreshViewWithKeyword:_homeView.searchBarView.searchTextField.text];
}

- (void)cancelSearchBar
{
    [self.homeSearchView removeView];
    [_homeView hideSearchBar:nil];
}

- (void)goToBarCode:(id)sender
{
    [self readerBegin];
}

-(void)readerBegin
{
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:1];
    [nav popToRootViewControllerAnimated:NO];
    NewSearchViewController *search = (NewSearchViewController *)[nav.viewControllers objectAtIndex:0];
    
    [search beginReaderZBar];
    //点击扫码埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", @"1120003"], nil]];
}


#pragma -mark ButtonMethod
- (void)showFloatingView {
    if (![GlobalDataCenter defaultCenter].hasShownFloatingView && IsArrEmpty([Config currentConfig].loginHistoryList)) {
        //展示快速注册浮层
        quickRegistView.hidden = NO;
        [GlobalDataCenter defaultCenter].hasShownFloatingView = YES;
    }
}

- (void)leftDescButtonClick {
    NSLog(@"description++++");
    
    //点击埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120016"], nil]];
}

- (void)quickRegistButtonClick {
    NewRegisterViewController *registViewController = [[NewRegisterViewController alloc] init];
    registViewController.registerDelegate = self;
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:registViewController];
    TT_RELEASE_SAFELY(registViewController);
    [self presentModalViewController:navController animated:YES];
    TT_RELEASE_SAFELY(navController);
    
    //点击埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120017"], nil]];
}

#pragma -mark
#pragma HomeSearchControllerdelegate

- (void)cancelSearch
{
    [_homeView hideSearchBar:_homeView.cancelButton];
    [_homeSearchView removeView];
}


- (void)didSelectHotUrl:(NSString *)url bFromHomeSearchView:(BOOL)bFromHSView wordOfUrl:(NSString *)word
{
    if (url && url.length > 0)
        
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

- (void)didSelectAssociationalTypeKeyword:(NSString *)keyword andDirId:(NSString *)dirid andCore:(NSString *)core
{
    //    [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 1;
    //    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:1];
    //    [nav popToRootViewControllerAnimated:NO];
    //    NewSearchViewController *search = (NewSearchViewController *)[nav.viewControllers objectAtIndex:0];
    //    [search didSelectAssociationalTypeKeyword:keyword andDirId:dirid andCore:core];
    //    search.homeKeyString = keyword;
    [_homeView.searchBarView.searchTextField resignFirstResponder];
    _homeView.searchBarView.searchTextField.text = nil;
    self.homeSearchView.keywordList = nil;
    
    [self.homeSearchView removeView];
    
    [_homeView hideSearchBar:nil];
    
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
    
    __weak HomePageViewController *weakSelf = self;
    
    [self.searchService addKeywordToDB:keyword completionBlock:^(NSArray *list){
        weakSelf.homeSearchView.historyKeywordsList = list;
        [weakSelf.homeSearchView.displayTableView reloadData];
    }];
    
    SearchParamDTO *solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeKeyword set:SearchSetMix];
    //    if ([core isEqualToString:@"electric"])
    //    {
    //        [solrParam resetWithSearchType:SearchTypeKeyword
    //                                              set:SearchSetElec];
    //    }
    //    else if ([core isEqualToString:@"book"])
    //    {
    //        [solrParam resetWithSearchType:SearchTypeKeyword
    //                                              set:SearchSetBook];
    //    }
    //    else
    //        [solrParam resetWithSearchType:SearchTypeKeyword
    //                                              set:SearchSetMix];
    solrParam.categoryId = dirid;
    solrParam.keyword = keyword;
    SearchListViewController *nextController = [[SearchListViewController alloc] initWithSearchCondition:solrParam];
    TT_RELEASE_SAFELY(solrParam);
    
    //chupeng 修改为新的搜索结果界面
    FilterRootViewController *vRightRoot = [[FilterRootViewController alloc] init];
    vRightRoot.isNeedBackItem = NO;
    vRightRoot.delegate = nextController;
    
    FilterNavigationController *navRight = [[FilterNavigationController alloc] initWithRootViewController:vRightRoot];
    //    navRight.view.backgroundColor = [UIColor clearColor];
    //    [navRight.navigationBar setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    
    JASidePanelController *jasideController = [[JASidePanelController alloc] init];
    jasideController.shouldDelegateAutorotateToVisiblePanel = NO;
    jasideController.rightGapPercentage = 0.8;
    jasideController.shouldResizeRightPanel = YES;
    jasideController.bounceOnSidePanelOpen = NO;
    jasideController.allowLeftOverpan = NO;
    jasideController.allowRightOverpan = NO;
    jasideController.centerPanel = nextController;
    jasideController.rightPanel = navRight;
    jasideController.leftPanel = nil;
    jasideController.hidesBottomBarWhenPushed = YES;
    
    //    [jasideController addObserver:nextController forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:"getstate"];
    
    [self.navigationController pushViewController:jasideController animated:YES];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if (KHomePage)
    {
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = nil;
    }
}


#pragma mark -HomePageServiceDelegate
- (void) homePageServiceComplete:(HomePageService244 *)service isSuccess:(BOOL) isSuccess {
    [self refreshDataComplete];
    if (isSuccess) {
        if (KHomePage)
        {
            if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
            {
                
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
                    temp.endTime = [NSDate date];
                    [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                }
            }
            
        }

        [floorDataArray removeAllObjects];
        if (!IsArrEmpty(service.floorArray)) {
            [floorDataArray addObjectsFromArray:service.floorArray];
        }
        //为了防止首页数据没加载时显示底部推荐标签的情况
        willLoadRecommendLabel = NO;
        [self.tableView reloadData];
    }
    else {
        [GlobalDataCenter defaultCenter].homeDataVersion = @"-1";
        [self presentSheet:service.errorMsg];
    }
}

- (void)homeVersionServiceComplete:(HomePageService244 *)service needReGetData:(BOOL )flag {
    if (flag) {
        //需要重新获取首页数据
        [self refreshHomePageData];
    }
    else
    {
        //
        if (KHomePage)
        {
            [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
            [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
            
        }

        [self refreshDataComplete];
        
    }
}


/**
 *  代理返回，是否刷新首页数据
 *
 *  @param service    service
 *  @param dataFlag   是否需要请求楼层数据
 *  @param switchFlag 是否需要请求开关数据
 */
- (void)homeVersionServiceComplete:(HomePageService244 *)service homeDataFlag:(BOOL )dataFlag homeSwitchFlag:(BOOL )switchFlag {
    if (dataFlag) {
        //调用接口，获取首页楼层数据
        [self refreshHomePageData];
    }
    
    if (switchFlag) {
        //调用接口，获取开关数据
        [SNSwitch updateWithCallBack:^{
            if([SNSwitch shouyexinren244]!=nil || [SNSwitch lingquhongbao244]!= nil){
                [self.invita beginGetRedPackEntryHttpRequest];
            }
            
            _homeView.searchBarView.searchTextField.placeholder = [self switchSearchwords];
            
            //如果有启动页DM，则延迟更新版本，让版本更新的提示不显示在启动页
            NSDictionary *dmDict = [[AppDelegate currentAppDelegate] hasDownloadDm];
            if (dmDict) {
                [self performSelector:@selector(checkUpdate) withObject:nil afterDelay:3.0f];
            }
            else {
                [self checkUpdate];
            }
        }];
    }
    
    if (dataFlag == NO) {
        [self refreshDataComplete];
    }
}


/**
 *  检查版本更新
 */
- (void)checkUpdate {
    [[AppDelegate currentAppDelegate] checkVersionUpdate];
}


#pragma mark -
#pragma mark GuessYouLikeDelegate
//猜你喜欢模块请求数据回调
- (void)homeGuessYouLikeServiceComplete:(GuessYouLikeService *)service isSuccess:(BOOL)isSuccess withDto:(GuessYouLikeDTO *)dto withPreLoad:(NSMutableArray *)array
{
    if (isSuccess) {
        willLoadRecommendLabel = YES;
        [recommendDataArray removeAllObjects];
        recommendDataArray = dto.dataArray;
        //获取推荐模块cell行数
        //两个一排+最后一行提醒文字cell
        int cellCount = [recommendDataArray count];
        recommendCellCount = cellCount%2 == 0 ? (cellCount/2+1) : (cellCount/2+2);
        
        [self.guessYouLikeTableView reloadData];
        [self.tableView reloadData];
        //预加载
//        SNImageCachePreloadImages(array);
    }else{
        willLoadRecommendLabel = NO;
    }
}

//猜你喜欢模块cell点击跳转
- (void)didSelectGuessYouLikeList:(GuessDataDTO *)dto
{
    DataProductBasic *detailDto = [[DataProductBasic alloc] init];
    detailDto.productCode = dto.productCode;
    detailDto.productId = dto.productId;
    detailDto.productName = dto.productName;
    detailDto.shopCode = dto.supplierId;
    if([dto.supplierId isEqualToString:@"0000000000"]){
        detailDto.shopCode = @"";
    }
    ProductDetailViewController * v = [[ProductDetailViewController alloc] initWithDataBasicDTO:detailDto];
    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark - UITableViewDataSource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.guessYouLikeTableView) {
        return recommendCellCount;
    }
    else {
        //加载首页底部猜你喜欢（推荐）标签
        if (willLoadRecommendLabel) {
            return [floorDataArray count]+1;
        }
        else {
            return [floorDataArray count];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //猜你喜欢模块
    if(tableView == self.guessYouLikeTableView)
    {
        NSString *identifier = [NSString stringWithFormat:@"GuessYouLike_View_%d",indexPath.row];
        GuessYouLikeCell *guessYouLikeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!guessYouLikeCell)
        {
            guessYouLikeCell = [[GuessYouLikeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            guessYouLikeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            guessYouLikeCell.backgroundColor = [UIColor clearColor];
            guessYouLikeCell.delegate = self;
            guessYouLikeCell.tag = indexPath.row;
        }
        //最后一行文字提示cell
        if(indexPath.row == recommendCellCount-1){
            [guessYouLikeCell.contentView addSubview:self.recommendScanEndImageView];
            return guessYouLikeCell;
        }
        int row = indexPath.row;
        GuessDataDTO *leftDto = nil;
        GuessDataDTO *rightDto = nil;
        int count = [recommendDataArray count];
        if(row*2<count)
        {
            leftDto = [recommendDataArray safeObjectAtIndex:row*2];
        }
        if(row*2+1<count)
        {
            rightDto = [recommendDataArray safeObjectAtIndex:row*2+1];
        }
        [guessYouLikeCell setViewWithleftDto:(GuessDataDTO *)leftDto rightDto:(GuessDataDTO *)rightDto];
        return guessYouLikeCell;
    }
    

    //首页数据楼层
    int row = indexPath.row;
    HomeFloorDTO *homeFloorDTO = [floorDataArray safeObjectAtIndex:row];
    
    static NSString *cellReuseIdentifier = @"HomeFloorCellIdentifier";
    NSString *floorIDString = [[GlobalDataCenter defaultCenter].floorID_TypeDict objectForKey:homeFloorDTO.templateID];
    int flootType = -1;
    if (NotNilAndNull(floorIDString)) {
        flootType = [floorIDString intValue];
    } else {
        //如果为nil，可能是真的数据为空，也有可能是为了添加推荐标签label强行多出一行cell，
          //而templateID是接口返回，为固定的几个值，所以数据源[GlobalDataCenter defaultCenter].floorID_TypeDict是固定的
          //如果要添加一行cell，index.row必然多出一个，此时的从floorDataArray中取数组越界的那一项则返回nil，
          //然后floorIDString则为nil，我们不能改变接口返回值，
          //所以只能在从数据源取值为空的判断中手动添加flootType = 100以达到添加一个cell的目的
        if (willLoadRecommendLabel) {
            flootType = 100;
        }
    }
    
    NSString *cellFullIdentifier = [NSString stringWithFormat:@"HomeFloorCellIdentifier_%@", homeFloorDTO.templateID];
    
    HomeFloorTableViewCell *cell = nil;
    switch (flootType) {
        case 1: {
            
            //八连版
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                EightBannerView244 *bannerView = [[EightBannerView244 alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
                bannerView.tag = 77001;
                bannerView.delegate = self;

                [cell.contentView addSubview:bannerView];
                TT_RELEASE_SAFELY(bannerView);
            }
            
            EightBannerView244 *view = (EightBannerView244 *)[cell.contentView viewWithTag:77001];
            [view updateViewWithDTO:homeFloorDTO];
            break;
        }
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 13:
        case 14:
        case 15:
        case 18:
        case 19:
        case 20:
        case 21:
        case 22: {
            
            //普通楼层
            cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
                cell.delegate = self;
            }
            cell.selectionStyle
            = UITableViewCellSelectionStyleNone;
            if ([cell respondsToSelector:@selector(updateViewWithFloorDTO:)]) {
                [cell performSelector:@selector(updateViewWithFloorDTO:) withObject:homeFloorDTO];
            }
            break;
        }
        case 12: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                
                Floor12View *tempView = [[Floor12View alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
                tempView.delegate = self;
                tempView.tag = 77010;
                [cell.contentView addSubview:tempView];
                TT_RELEASE_SAFELY(tempView);
                
            }
            
            cell.selectionStyle
            = UITableViewCellSelectionStyleNone;
            Floor12View *shopView = (Floor12View *)[cell.contentView viewWithTag:77010];
            [shopView updateViewWithFloorDTO:homeFloorDTO];
            break;
        }
        case 16: {
            
            //店铺推荐
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];

                NSString *tempStr = [NSString stringWithFormat:@"app_%02d",flootType];
                float height = [[[GlobalDataCenter defaultCenter].homeCellHeightDict objectForKey:tempStr] floatValue];
                
                ShopRecommend244 *tempShop = [[ShopRecommend244 alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
                tempShop.delegate = self;
                tempShop.tag = 77002;
                [cell.contentView addSubview:tempShop];
                TT_RELEASE_SAFELY(tempShop);
                
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ShopRecommend244 *shopView = (ShopRecommend244 *)[cell.contentView viewWithTag:77002];
            [shopView updateViewWithFloorDTO:homeFloorDTO];
            break;
        }
        case 17: {
            
            //品牌推荐
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                NSString *tempStr = [NSString stringWithFormat:@"app_%02d",flootType];
                float height = [[[GlobalDataCenter defaultCenter].homeCellHeightDict objectForKey:tempStr] floatValue];
                BrandRecommend244 *tempBrand = [[BrandRecommend244 alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
                tempBrand.delegate = self;
                tempBrand.tag = 77003;
                [cell.contentView addSubview:tempBrand];
                TT_RELEASE_SAFELY(tempBrand);
            }
            
            BrandRecommend244 *brandView = (BrandRecommend244 *)[cell.contentView viewWithTag:77003];
            [brandView updateViewWithFloorDTO:homeFloorDTO];
            
            break;
        }
        case 100:{
            
            //猜你喜欢
            UITableViewCell *guessYouLikeCell = [tableView dequeueReusableCellWithIdentifier:@"GuessYouLike_Label"];
            if(!guessYouLikeCell)
            {
                guessYouLikeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GuessYouLike_Label"];
                guessYouLikeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                guessYouLikeCell.backgroundColor = [UIColor clearColor];
                [guessYouLikeCell.contentView addSubview:self.recommendImageView];
            }
            return guessYouLikeCell;
        }
        default: {
            
            //其它异常情况
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
            }
        }
            break;
    }
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    int currentCellIndex = indexPath.row;
//    if (!self.isLoading && ([tableStructureDictArray count] - currentCellIndex) < 7) {
//        //加载更多
//        NSLog(@"willDisplayCell 加载更多");
//        [self loadMoreData];
//
//    }
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //added by gyj 猜你喜欢模块cell高度
    if (tableView == self.guessYouLikeTableView) {
        //最后一行提醒文字cell高度
        if(indexPath.row == recommendCellCount-1){
            return 44+49;
        }
        return 220;
    }
    else {
        
        //楼层table
        HomeFloorDTO *homeFloorDTO = [floorDataArray safeObjectAtIndex:indexPath.row];
        
        NSString *floorIDString = [[GlobalDataCenter defaultCenter].floorID_TypeDict objectForKey:homeFloorDTO.templateID];
        int flootType = -1;
        if (NotNilAndNull(floorIDString)) {
            flootType = [floorIDString intValue];
        }else{
            //加载首页底部推荐标签
            if(willLoadRecommendLabel){
                flootType = 100;
            }
        }
        
        NSString *tempStr = [NSString stringWithFormat:@"app_%02d",flootType];
        if ([[GlobalDataCenter defaultCenter].homeCellHeightDict objectForKey:tempStr]) {
            return [[[GlobalDataCenter defaultCenter].homeCellHeightDict objectForKey:tempStr] floatValue];
        }
        else {
            //不识别的楼层模板，高度设置为0
            return 0.0;
        }
    }
}


#pragma mark - EGORegreshHeader&FooterDelegate
- (void)refreshData
{
    [super refreshData];
    
    //下拉刷新，请求版本号接口
    [self queryHomeVersion];
    //added by gyj 首页刷新时，就置标志为YES表示可以请求推荐数据
    willRequestRecommendData = YES;
}

- (void)refreshDataComplete{
    [super refreshDataComplete];
}

//- (void)loadMoreData {
//    [super loadMoreData];
//
//    NSLog(@"loadMoreData 加载更多");
//    
//    [self performSelector:@selector(loadMoreDataComplete) withObject:nil afterDelay:1.0f];
//}

//- (void)loadMoreDataComplete {
//    [super loadMoreDataComplete];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EightBannerViewDelegate
- (void)eightBannerSelectedDTO:(HomeModuleDTO *)moduleDTO {
    //基类里处理
    [self handleTargetType:moduleDTO.targetType targetURLString:moduleDTO.targetURL];
}

- (void)selectModuleDTO:(HomeModuleDTO *)dto {
    [self eightBannerSelectedDTO:dto];
}


/**
 *  客户端首页初始化时调用全局版本数据接口
 */
- (void)queryHomeVersion {
    
    [self.homePageService queryHomeVersion];
}


- (void)goToDeliveryInstall:(id)sender
{
    ServiceTrackListViewController *nextViewController = [[ServiceTrackListViewController alloc] init];
    NSString *userName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    NSString *passwd = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginPasswdKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    
    NSString *password = [PasswdUtil decryptString:passwd
                                            forKey:kLoginPasswdParamEncodeKey
                                              salt:kPBEDefaultSalt];
    
    if (![UserCenter defaultCenter].isLogined && !IsStrEmpty(userName) && !IsStrEmpty(passwd) && !IsStrEmpty(password))
    {
        //自动登录
        AutoLoginCommand *loginCmd = [AutoLoginCommand command];
        [CommandManage excuteCommand:loginCmd observer:nil];
    }
    
    [self.navigationController pushViewController:nextViewController animated:YES];
    TT_RELEASE_SAFELY(nextViewController);
}


#pragma mark getredpackServiceDelegate
- (void) GetRedPackServiceEntryComplete:(GetRedPackEntryDTO *)service isSuccess:(BOOL) isSuccess{
    if (isSuccess) {
        if ([service.canGetRedPack isEqualToString:@"1"]) {
            [UserCenter defaultCenter].actverule = service.redPackRule;
            [UserCenter defaultCenter].ticketRuleUrl = service.ticketRuleUrl;
            
            if ([SNSwitch lingquhongbao244]) {
                [UserCenter defaultCenter].isGetRedPack = YES;
            }
            getredpackstr = [[SNSwitch shouyexinren244] copy];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSString *name = [defaults objectForKey:@"getredpack"];
            
            
            if (name) {
                if ([SNSwitch Isneedupdate]&&![name isEqualToString:@"0"]) {
                    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(getredpackstr)?L(@"GetYourRedPacketQuick"):getredpackstr
                                                                        message:getredpackstr
                                                                       delegate:nil
                                                              cancelButtonTitle:L(@"GetNextTime")
                                                              otherButtonTitles:L(@"GetNow")];
                    [alertView setCancelBlock:^{
                        //下次领取
                        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                        NSString *name =@"getredpack";
                        [defaults setObject:@"0" forKey:name];
                    } ];
                    [alertView setConfirmBlock:^{
                        //                if ([UserCenter defaultCenter].isLogined) {
                        [self loginOK];
                    }];
                    if (getredpackstr) {
                        [alertView show];
                    }
                    isCanGetRedPack = YES;
                }
            }
            else{
                if ([SNSwitch Isneedupdate]) {
                    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(getredpackstr)?L(@"GetYourRedPacketQuick"):getredpackstr
                                                                        message:getredpackstr
                                                                       delegate:nil
                                                              cancelButtonTitle:L(@"GetNextTime")
                                                              otherButtonTitles:L(@"GetNow")];
                    [alertView setCancelBlock:^{
                        //下次领取
                        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                        NSString *name =@"getredpack";
                        [defaults setObject:@"0" forKey:name];
                    } ];
                    [alertView setConfirmBlock:^{
                        //                if ([UserCenter defaultCenter].isLogined) {
                        [self loginOK];
                    }];
                    
                    if (getredpackstr) {
                        [alertView show];
                    }
                    isCanGetRedPack = YES;
                }
            }
        }
    }
}

-(void)loginOK{
    NewGetRedPackViewController *getredpack = [[NewGetRedPackViewController alloc] init];
    getredpack.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:getredpack animated:YES];
}

#pragma mark -
#pragma mark scroll delagate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //gjf 
    [super scrollViewDidScroll:scrollView];
    
    float contentHeight = scrollView.contentSize.height;
    float tableViewHeight = scrollView.bounds.size.height;
    float originY = MAX(contentHeight, tableViewHeight);
    CGFloat showHeight = scrollView.contentOffset.y + scrollView.size.height - originY - _initScrollViewInset.bottom;
    

    //箭头方向改变
    if (scrollView.tag == 0) {
        if(showHeight >= 30){
            self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else if(showHeight < 30 && showHeight > 0){
            CGFloat radians = showHeight * M_PI / 30.0;
            self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(radians);
        }else if(showHeight <= 0){
            self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(0.0);
        }
    }
    if(scrollView.tag == 1){
        if(scrollView.contentOffset.y <= -30){
            self.recommendIconDownImageView.transform = CGAffineTransformMakeRotation(-M_PI);
        }else if(scrollView.contentOffset.y<0 && scrollView.contentOffset.y>-30){
            CGFloat radians = scrollView.contentOffset.y * M_PI / 30.0;
            self.recommendIconDownImageView.transform = CGAffineTransformMakeRotation(radians);
        }else if(scrollView.contentOffset.y >= 0){
            self.recommendIconDownImageView.transform = CGAffineTransformMakeRotation(0.0);
        }
    }
    
    //下面tableview移到大概16个cell时显示向上按钮
    if (scrollView.tag == 1 && scrollView.contentOffset.y > 1100) {
        self.goToTopButton.alpha = 1;
    } else {
        self.goToTopButton.alpha = 0;
    }
    
    NSInteger cellCount = [self.tableView numberOfRowsInSection:0];
    //倒数第二个楼层
    NSInteger destCell = cellCount>3 ? (cellCount-3) : 0;
    //可见cell数组
    NSArray *indexes = [self.tableView indexPathsForVisibleRows];
    if ([indexes count]>0) {
        NSIndexPath *visibleIndex = [indexes objectAtIndex:([indexes count]-1)];
        //当可见cell达到倒数第二个楼层时可以请求
        if (scrollView.tag == 0 && visibleIndex.row >= destCell) {
            if (willRequestRecommendData) {
                [self.guessYouLikeService beginGetHomeGuessYouLikeHttpRequest];
                willRequestRecommendData = NO;
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    float contentHeight = scrollView.contentSize.height;
    float tableViewHeight = scrollView.bounds.size.height;
    float originY = MAX(contentHeight, tableViewHeight);
    CGFloat showHeight = scrollView.contentOffset.y + scrollView.size.height - originY-_initScrollViewInset.bottom;
    CGRect guessFrame = CGRectMake(0, IOS7_OR_LATER?64:44, kScreenWidth, kScreenHeight-64);
    CGRect tableFrame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-(IOS7_OR_LATER?44:(64+49)));
    
    if (willLoadRecommendLabel) {
        if (scrollView.tag == 0 && showHeight>30) {
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, -tableFrame.size.height, tableFrame.size.width, tableFrame.size.height);
                self.guessYouLikeTableView.frame = guessFrame;
            }completion:^(BOOL finished){
                sourceTitle = @"首页推荐";
            }];
        }
        
        if (scrollView.tag == 1 && scrollView.contentOffset.y < -30) {
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = tableFrame;
                self.guessYouLikeTableView.frame = CGRectMake(0, kScreenHeight, guessFrame.size.width, guessFrame.size.height);
            }completion:^(BOOL finished){
                sourceTitle = @"活动";
            }];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
