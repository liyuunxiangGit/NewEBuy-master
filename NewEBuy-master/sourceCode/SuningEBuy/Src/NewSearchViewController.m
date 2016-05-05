//
//  NewSearchViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewSearchViewController.h"
#import "SearchListViewController.h"
#import "JASidePanelController.h"
#import "FilterRootViewController.h"
#import "SNWebViewController.h"
#import "FilterNavigationController.h"
#import "FilterNavigationController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface NewSearchViewController ()

//进入搜索结果页
- (void)willGoToSearchListWithKeyword:(NSString *)keyword;

@end

@implementation NewSearchViewController

@synthesize searchBar = _searchBar;
@synthesize service = _service;
@synthesize historyKeywordList = _historyKeywordList;
@synthesize keywordDisplayController = _keywordDisplayController;
@synthesize hotKeywordsController = _hotKeywordsController;
@synthesize historySearchController = _historySearchController;
@synthesize scanSearchController = _scanSearchController;
@synthesize readerController = _readerController;
@synthesize searchAdArray = _searchAdArray;
@synthesize segment = _segment;
@synthesize homeKeyString   = _homeKeyString;
@synthesize bgImageView = _bgImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
//    TT_RELEASE_SAFELY(_searchBar);
//    TT_RELEASE_SAFELY(_homeKeyString);
//    SERVICE_RELEASE_SAFELY(_service);
//    TT_RELEASE_SAFELY(_historyKeywordList);
//    TT_RELEASE_SAFELY(_keywordDisplayController);
//    TT_RELEASE_SAFELY(_hotKeywordsController);
//    TT_RELEASE_SAFELY(_historySearchController);
//    TT_RELEASE_SAFELY(_scanSearchController);
//    TT_RELEASE_SAFELY(_readerController);
//    TT_RELEASE_SAFELY(_searchAdArray);
//    TT_RELEASE_SAFELY(_segment);
//    TT_RELEASE_SAFELY(_bgImageView);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    self = [super init];
    if (self) {
        self.hasNav = NO;
        self.isNeedBackItem = NO;
        self.title = L(@"search");
        self.pageTitle = L(@"search_searchPage");
        self.bSupportPanUI = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceSearchByKeyWord) name:VOICE_SEARCH object:nil];
    }
    return self;
}

- (void)voiceSearchByKeyWord
{
    if ([VoiceSearchViewController sharedVoiceSearchCtrl].from == From_NewSearch)
    {
        [[VoiceSearchViewController sharedVoiceSearchCtrl] removeVoiceSearchView];
        [self didSelectAssociationalWord:[VoiceSearchViewController sharedVoiceSearchCtrl].result];
        
    }
}

-(id)initWithDictionary:(NSDictionary*)dic
{
    self = [self init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    
    //[self.view addSubview:self.bgImageView];

    [self.view addSubview:self.searchBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *statusBarBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
    statusBarBackView.backgroundColor = RGBCOLOR(247, 247, 248);
    [self.view addSubview:statusBarBackView];
    [self.view addSubview:self.keywordDisplayController.backView];
    [self.view addSubview:self.keywordDisplayController.hotwordTableView];
    [self.view addSubview:self.keywordDisplayController.displayTableView];
    [self.view bringSubviewToFront:statusBarBackView];
//    self.segment.delegate = self;
//    self.segment.frame = CGRectMake(0, _searchBar.bottom, _segment.width, _segment.height);
//    [self.view addSubview:self.segment];
//    
//    self.searchAdArray = [Config currentConfig].topSearchAdList;
//    //添加广告图片
//    if ([self.searchAdArray count] ==0) {
//        self.bgImageView.imageURL = nil;
//    }
//    else
//    {
//        SearchAdDTO *dto = [self.searchAdArray objectAtIndex:0];
//        self.bgImageView.imageURL = [NSURL URLWithString:dto.bigImageURL];
//    }
//    
//    //添加热门搜索、最近搜索、最近浏览
//    //[self addChildViewController:self.historySearchController];
//    CGRect rc = self.hotKeywordsController.view.frame;
//    rc.size = CGSizeMake(rc.size.width, rc.size.height - 36);
//    self.historySearchController.displayTableView.frame = rc;
//    self.deleteAllHistoryBtn.frame = CGRectMake(0, rc.origin.y + rc.size.height, 320, 36);
//    self.deleteAllHistoryBtn.hidden = YES;
//    [self.view addSubview:self.deleteAllHistoryBtn];
//    
//    [self.view addSubview:self.historySearchController.displayTableView];
//    [self addChildViewController:self.scanSearchController];
//    //self.scanSearchController.view.frame = rc;
//    [self.view addSubview:self.scanSearchController.view];
//    [self addChildViewController:self.hotKeywordsController];
//    [self.view addSubview:self.hotKeywordsController.view];
//    self.historySearchController.displayTableView.hidden = YES;
//    self.scanSearchController.view.hidden = YES;
//    
//    
//    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)self.navigationController;
//    for (UIGestureRecognizer *ges in self.scanSearchController.scanSearchView.scanTableView.gestureRecognizers) {
//        [nav.panGes requireGestureRecognizerToFail:ges];
//    }
//
//    for (UIGestureRecognizer *ges in self.historySearchController.displayTableView.gestureRecognizers) {
//        [nav.panGes requireGestureRecognizerToFail:ges];
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
        self.historyKeywordList = list;
    }];
    
    [self.keywordDisplayController displayViewWithHistoryWords:self.historyKeywordList];
    
    self.searchBar.frame = CGRectMake(0, 0, 320, 44);
    
    self.keywordDisplayController.backView.frame = CGRectMake(0, 44, 320, self.view.bounds.size.height - 64);
    self.keywordDisplayController.displayTableView.frame = CGRectMake(0, 44 + 35, 320, self.view.bounds.size.height - 64 - 35);
    self.keywordDisplayController.hotwordTableView.frame = CGRectMake(0, 44 + 35, 320, self.view.bounds.size.height - 64 - 35);

    self.searchBar.searchTextField.placeholder = [self.searchBar switchSearchwords];
    
    self.searchBar.searchTextField.text=@"";

//    [self.searchBar.searchTextField becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (KPerformance)
//    {
//        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
//        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
//        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = nil;
//    }
}

- (SearchService *)service
{
    if (!_service) {
        _service = [[SearchService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (NUSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[NUSearchBar alloc] init];
        _searchBar.readerDelegate = self;
    }
    return _searchBar;
}

- (CustomSegment *)segment
{
    if (!_segment) {
        _segment = [[CustomSegment alloc] init];
        
        [_segment setItems:[NSArray arrayWithObjects:L(@"Hot_Search"),L(@"Search_History"),L(@"Scan_History"), nil]];
        
    }
    return _segment;
}

- (EGOImageViewEx *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0, 320, 172)];
        _bgImageView.hidden = NO;
        _bgImageView.exDelegate = self;
    }
    return _bgImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willGoToSearchListWithKeyword:(NSString *)keyword
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
    
    //点击搜索后搜索栏回复原状
    [self.searchBar hideSearchBar:nil];
    
    //reload最近搜索
    
    __weak NewSearchViewController *weakSelf = self;

    [self.service addKeywordToDB:keyword completionBlock:^(NSArray *list){
        weakSelf.historyKeywordList = list;
        [weakSelf.historySearchController.displayTableView reloadData];
    }];
    
    int searchType = [[Config currentConfig].searchType intValue];
    if (searchType == 0)
    {
        [SearchListViewController goToSearchResultWithKeyword:keyword fromNav:self.navigationController];
    }
    else if (searchType == 1)
    {
        [ShopSearchListViewController gotoShopSearchWithKeyWord:keyword fromNav:self.navigationController];
    }
}

#pragma mark -
#pragma mark AssociationalWordDisplayController method and delegate

- (AssociationalAndHistoryWordDisplayController *)keywordDisplayController
{
    if (!_keywordDisplayController) {
        _keywordDisplayController = [[AssociationalAndHistoryWordDisplayController alloc] initWithContentController:self];
        _keywordDisplayController.delegate = self;
    }
    return _keywordDisplayController;
}

- (void)refreshDefaultWords
{
    self.searchBar.searchTextField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
}

- (void)didSelectAssociationalWord:(NSString *)keyword
{
    self.keywordDisplayController.keyWord = nil;
    [self.searchBar hideSearchBar:nil];
    
    int searchType = [[Config currentConfig].searchType intValue];
    if (searchType == 0)
    {
        [self willGoToSearchListWithKeyword:keyword];
    }
    else
    {
        __weak NewSearchViewController *weakSelf = self;
        
        [self.service addKeywordToDB:keyword completionBlock:^(NSArray *list){
            weakSelf.historyKeywordList = list;
            [weakSelf.historySearchController.displayTableView reloadData];
        }];
        [ShopSearchListViewController gotoShopSearchWithKeyWord:keyword fromNav:self.navigationController];
    }
}
//
//- (void)didselectHotUrl:(NSString *)url
//{
//    [self routeWithUrl:url complete:NULL];
//}

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
    
    //点击搜索后搜索栏回复原状
    [self.searchBar hideSearchBar:nil];
    
    //reload最近搜索
    
    __weak NewSearchViewController *weakSelf = self;
    
    [self.service addKeywordToDB:keyword completionBlock:^(NSArray *list){
        weakSelf.historyKeywordList = list;
        [weakSelf.historySearchController.displayTableView reloadData];
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
    [SearchListViewController goToSearchResultWithParamDTO:solrParam fromNav:self.navigationController];
}

#pragma mark -
#pragma mark  Three part Controller delegate and method

- (HotKeywordsViewController *)hotKeywordsController{
    if (!_hotKeywordsController) {
        _hotKeywordsController = [[HotKeywordsViewController alloc] init];
        _hotKeywordsController.hotKeywordsDelegate = self;
        
    }
    return _hotKeywordsController;
}

- (AssociationalAndHistoryWordDisplayController *)historySearchController{
    if (!_historySearchController) {
        _historySearchController = [[AssociationalAndHistoryWordDisplayController alloc] init];
        _historySearchController.bShowingInNewSearch = YES;
        [_historySearchController refreshViewWithKeyword:nil];
        _historySearchController.delegate = self;
    }
    return _historySearchController;
}

- (UIButton *)deleteAllHistoryBtn
{
    if (!_deleteAllHistoryBtn)
    {
        _deleteAllHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteAllHistoryBtn.frame = CGRectZero;        [_deleteAllHistoryBtn addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
//        [_deleteAllHistoryBtn setBackgroundImage:[UIImage streImageNamed:@"search_searchlist_clearHistoryWords" capX:10 capY:5] forState:UIControlStateNormal];
        _deleteAllHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
//        _deleteAllHistoryBtn.layer.borderWidth = 1;
//        _deleteAllHistoryBtn.layer.borderColor = RGBCOLOR(120, 120, 120).CGColor;
        [_deleteAllHistoryBtn setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [_deleteAllHistoryBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        _deleteAllHistoryBtn.backgroundColor = RGBCOLOR(242, 242, 242);
//        [_deleteAllHistoryBtn setTitleColor:RGBCOLOR(119, 119, 119) forState:UIControlStateNormal];
//        _deleteAllHistoryBtn.layer.cornerRadius = 4.0;
        //[_deleteAllHistoryBtn setTintColor:RGBCOLOR(250, 248, 240)];
        [_deleteAllHistoryBtn setTitle:L(@"Search_CleanSearchRecord") forState:UIControlStateNormal];
        _deleteAllHistoryBtn.tag = 100;
        
    }
    return _deleteAllHistoryBtn;
}

- (void)clearHistory:(id)sender
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Confirm clear search history")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"confirm")];
    [alert setConfirmBlock:^{
        [self.historySearchController.historyService deleteAllKeywordsFromDBWithCompletionBlock:^(NSArray *list){
            self.historySearchController.historyKeywordsList = list;
            [self.historySearchController.displayTableView reloadData];
            
            BOOL bShowBtn = self.historySearchController.historyKeywordsList.count > 0 ? YES : NO;
            self.deleteAllHistoryBtn.hidden = !bShowBtn;
            
        }];
    }];
    [alert show];
}

- (void)deleteHistoryOk
{
    BOOL bShowBtn = self.historySearchController.historyKeywordsList.count > 0 ? YES : NO;
    self.deleteAllHistoryBtn.hidden = !bShowBtn;
}

- (ScanSearchViewController *)scanSearchController{
    if (!_scanSearchController) {
        _scanSearchController = [[ScanSearchViewController alloc] init];
    }
    return _scanSearchController;
}

-(void)didSelectKeyword:(NSString *)keyName
{
    [self willGoToSearchListWithKeyword:keyName];
}
//
//- (void)didSelectUrl:(NSString *)url
//{
////    [SNApi handleDMURL:url delegate:self];
//    
//}

- (void)didSelectHotUrl:(NSString *)url bFromSearchView:(BOOL)bFromHSView wordOfUrl:(NSString *)word
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

#pragma mark -
#pragma mark EGOImage delegate

//点击搜索背景图片跳转到活动页面
- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"840101"], nil]];
    DLog(@"JumpTo AD");
    if ([self.searchAdArray count] ==0) {
        return;
    }
    else
    {
        SearchAdDTO *dto = [self.searchAdArray objectAtIndex:0];
        if (!dto.backgroundURL || [dto.backgroundURL isEqualToString:@""]) {
            int modelType = [dto.model intValue];
            
            switch (modelType) {
                    
                case 1:{
                    
                    NSString *url = dto.innerImageURL;
                    if (url.length)
                    {
                        SNWebViewController *vc =
                        [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": url, @"activeName": dto.activeName?dto.activeName:@""}];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
                    break;
                    
                    
                case 2:{
                    
                    AdModel2ViewController *controller = [[AdModel2ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    
                    controller.activeName = dto.activeName;
                    
                    controller.activeRule = dto.activeRule;
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    
                    TT_RELEASE_SAFELY(controller);
                    
                }
                    break;
                    
                case 3:{
                    
                    AdModel3ViewController *controller = [[AdModel3ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    controller.activeName = dto.activeName;
                    controller.activeRule = dto.activeRule;
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    TT_RELEASE_SAFELY(controller);
                    
                }
                    break;
                    
                case 4:{
                    
                    AdModel4ViewController *controller = [[AdModel4ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    controller.activeName = dto.activeName;
                    controller.activeRule = dto.activeRule;
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    TT_RELEASE_SAFELY(controller);
                    
                }
                    break;
                    
                case 5:{
                    
                    AdModel5ViewController *controller = [[AdModel5ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    controller.define = dto.define;
                    controller.activeName = dto.activeName;
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    
                    TT_RELEASE_SAFELY(controller);
                    
                }
                    break;
                    
                case 6:{
                    
                    AdModel6ViewController *controller = [[AdModel6ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    controller.activeName = dto.activeName;
                    controller.activeRule = dto.activeRule;
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    
                    TT_RELEASE_SAFELY(controller);
                }
                    break;
                    
                default:
                    
                    break;
            }
        }
        else
        {
            NSString *url = dto.backgroundURL.trim;
            if (url.length)
            {
                SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel
                 attributes:@{@"url": url, @"activeName": dto.activeName?dto.activeName:@""}];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}


#pragma mark -
#pragma mark zbar reader

- (SNReaderController *)readerController
{
    if (!_readerController) {
        _readerController = [[SNReaderController alloc] initWithContentController:self];
//        _readerController.rootControl = SEARCH_PAGE_TYPE;
    }
    return _readerController;
}


#pragma mark -
#pragma mark search bar delegate

- (void)beginReaderZBar
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"840603"], nil]];
    //开始读码
    [self.readerController beginReader];
}

- (BOOL)searchFieldShouldBeginEditing:(UITextField *)textField
{
    
//    if (![textField.placeholder isEqualToString:L(@"Search Product")]) {
//        self.searchBar.searchTextField.text=textField.placeholder;
//    }
    
    
    [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
        self.historyKeywordList = list;
        //展示最近搜索table

    }];

    [self.keywordDisplayController displayViewWithHistoryWords:self.historyKeywordList];
    
    [self.searchBar showSearchBar];
//    [self.view bringSubviewToFront:self.searchBar];
    
    return YES;
}

- (void)searchBar:(UITextField *)searchField textDidChange:(NSString *)searchText
{
    
    if ([searchText isEqualToString:@""]) {
        searchField.placeholder = [self.searchBar switchSearchwords];
        [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
            self.historyKeywordList = list;
        }];
        self.keywordDisplayController.keyWord = nil;
        [self.keywordDisplayController displayViewWithHistoryWords:self.historyKeywordList];
    }
    else
    {
        self.keywordDisplayController.keyWord = searchText;
        [self.keywordDisplayController refreshViewWithKeyword:searchText];
    }
}

- (BOOL)searchFieldShouldEndEditing:(UITextField *)textField
{
//    [UIView animateWithDuration:0.5 animations:^{
//
//        [self.keywordDisplayController removeView];
//        
//    }];

    [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
        self.historyKeywordList = list;
    }];
    self.keywordDisplayController.keyWord = nil;
    [self.keywordDisplayController displayViewWithHistoryWords:self.historyKeywordList];
    [self.keywordDisplayController hideViewsInNewSearchControl];
    return YES;
}

- (void)searchFieldSearchButtonClicked:(UITextField *)searchField
{
    [ChooseSearchTypeView hide];
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"840601"], nil]];
    NSString *keyword = searchField.text;
  
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        
//        if ([self.searchBar.searchTextField.placeholder isEqualToString:@"搜索商品"]) {
//            keyword = nil;
//            return;
//        }
//        else
//        {
//            keyword = self.searchBar.searchTextField.placeholder;
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

//    NSString *url = [[DefaultKeyWordManager defaultManager] findUrlWithWord:keyword];
//    if (url && url.length > 0)
//    {
//        @weakify(self);
//        [self routeWithUrl:url complete:^(BOOL isSuccess) {
//            @strongify(self);
//            if (!isSuccess) {
//                
//                [self willGoToSearchListWithKeyword:keyword];
//            }
//        }];
//    }
//    else
//    {
    if (KPerformance)
    {
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = [NSDate date];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
        PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
        temp.startTime = [NSDate date];
        temp.functionId = @"7";
        temp.interfaceId = @"701";
        temp.taskId = @"1007";
        temp.isSearch = YES;
        [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
        
    }
        [self willGoToSearchListWithKeyword:keyword];
//    }
}

#pragma mark -
#pragma mark SearchSegment delegate
//
//- (void)didSelectSegmentAtIndex:(NSInteger)index
//{
//    if (index == 1)//最近搜索
//    {
//        self.hotKeywordsController.view.hidden = YES;
//        self.historySearchController.displayTableView.hidden = NO;
//        [self.historySearchController refreshViewWithKeyword:nil];
//        BOOL bShowBtn = self.historySearchController.historyKeywordsList.count > 0 ? YES : NO;
//        self.deleteAllHistoryBtn.hidden = !bShowBtn;
//        self.scanSearchController.view.hidden = YES;
//    }
//    else if (index == 0)//热门搜索
//    {
//        self.hotKeywordsController.view.hidden = NO;
//        self.historySearchController.displayTableView.hidden = YES;
//        self.deleteAllHistoryBtn.hidden = YES;
//        self.scanSearchController.view.hidden = YES;
//    }
//    else   //最近浏览
//    {
//        self.hotKeywordsController.view.hidden = YES;
//        self.historySearchController.displayTableView.hidden = YES;
//        self.deleteAllHistoryBtn.hidden = YES;
//        self.scanSearchController.view.hidden = NO;
//    }
//}
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    NSString* str = nil;
    if (index == 1)//最近搜索
    {
        str = @"840301";
        self.hotKeywordsController.view.hidden = YES;
        self.historySearchController.displayTableView.hidden = NO;
        [self.historySearchController refreshViewWithKeyword:nil];
        BOOL bShowBtn = self.historySearchController.historyKeywordsList.count > 0 ? YES : NO;
        self.deleteAllHistoryBtn.hidden = !bShowBtn;
        self.scanSearchController.view.hidden = YES;
    }
    else if (index == 0)//热门搜索
    {
        str = @"840201";
        self.hotKeywordsController.view.hidden = NO;
        self.historySearchController.displayTableView.hidden = YES;
        self.deleteAllHistoryBtn.hidden = YES;
        self.scanSearchController.view.hidden = YES;
    }
    else   //最近浏览
    {
        str = @"840401";
        self.hotKeywordsController.view.hidden = YES;
        self.historySearchController.displayTableView.hidden = YES;
        self.deleteAllHistoryBtn.hidden = YES;
        self.scanSearchController.view.hidden = NO;
    }
    if (str)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",str], nil]];
    }
    
}
#pragma mark -
#pragma mark navigation delegate methods




@end
