//
//  SearchViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchListViewController.h"
#import "BrowsingHistoryDAO.h"
#import "ScanHistoryProductCell.h"
#import "DataProductBasic.h"
#import "ProductDetailViewController.h"

#import "FilterRootViewController.h"
#import "JASidePanelController.h"
#import "SNWebViewController.h"
#import "FilterNavigationController.h"
@interface SearchViewController()


- (void)reloadHistoryTableViewData;
- (void)reloadScanHistoryTableViewData;
//进入搜索结果页
- (void)willGoToSearchListWithKeyword:(NSString *)keyword;

@end

/*********************************************************************/

@implementation SearchViewController

@synthesize service = _service;
@synthesize historyKeywordList = _historyKeywordList;
@synthesize keywordDisplayController = _keywordDisplayController;
@synthesize readerController = _readerController;
@synthesize homeKeyString   = _homeKeyString;
@synthesize historyList = _historyList;
@synthesize searchAdArray = _searchAdArray;

- (void)dealloc {
    TT_RELEASE_SAFELY(_homeKeyString);
    TT_RELEASE_SAFELY(_searchView);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_historyKeywordList);
    TT_RELEASE_SAFELY(_keywordDisplayController);
    TT_RELEASE_SAFELY(_readerController);
    TT_RELEASE_SAFELY(_historyList);
    TT_RELEASE_SAFELY(_searchAdArray);
}

- (id)init {
    self = [super init];
    if (self) {
        self.hasNav = NO;
        self.isNeedBackItem = NO;
        self.title = L(@"search");
        self.pageTitle = L(@"search_searchPage");
    }
    return self;
}


- (SearchService *)service
{
    if (!_service) {
        _service = [[SearchService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

#pragma mark -
#pragma mark view lify cycle

- (void)loadView
{
    _searchView = [[SearchView alloc] initWithOwner:self];
    
    self.searchAdArray = [Config currentConfig].topSearchAdList;
    
    for (UIView *view in _searchView.searchBar.subviews)
    {
        for (EGOImageViewEx *imageview in view.subviews) {
            if (imageview.tag==101) {
                if ([self.searchAdArray count] ==0) {
                    imageview.imageURL = nil;
                }
                else
                {
                    SearchAdDTO *dto = [self.searchAdArray objectAtIndex:0];
                    imageview.imageURL = [NSURL URLWithString:dto.bigImageURL];
                }
            }
        }
    }
    self.view = _searchView;
    
    if (_searchView.segment.selectIndex == 1) {
        [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
            self.historyKeywordList = list;
            [self reloadHistoryTableViewData];
        }];
    }else{
        [self.service beginGetHotKeywords];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    _searchView.searchBar.searchTextField.placeholder = [_searchView.searchBar switchSearchwords];
    
    _searchView.searchBar.searchTextField.text=@"";
    //    if (_searchView.segment.selectIndex == 1) {
    [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
        self.historyKeywordList = list;
        [self reloadHistoryTableViewData];
    }];
    //    }else{
    //        [self.service beginGetHotKeywords];
    //    }
    if (![self.homeKeyString isEqualToString:@""] && NotNilAndNull(self.homeKeyString))
    {
        //        _searchView.searchBar.text = self.homeKeyString;
        self.homeKeyString = @"";
    }
    
    if (_searchView.segment.selectIndex == 2)
    {
        [self reloadScanHistoryTableViewData];
    }
    
    self.searchAdArray = [Config currentConfig].topSearchAdList;
    
    for (UIView *view in _searchView.searchBar.subviews)
    {
        for (EGOImageViewEx *imageview in view.subviews) {
            if (imageview.tag==101) {
                if ([self.searchAdArray count] ==0) {
                    imageview.imageURL = nil;
                }
                else
                {
                    SearchAdDTO *dto = [self.searchAdArray objectAtIndex:0];
                    imageview.imageURL = [NSURL URLWithString:dto.bigImageURL];
                }
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)reloadHistoryTableViewData
{
    if (self.historyKeywordList == nil || [self.historyKeywordList count] == 0) {
        _searchView.tableView.tableFooterView = _searchView.noHistoryLabel;
        
    }else {
        _searchView.tableView.tableFooterView = _searchView.delAllButtonView;
    }
    
    [_searchView.tableView reloadData];
}

- (void)reloadScanHistoryTableViewData
{
    BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
    NSArray *products = [dao getAllBrowsingHistorysFromDB];
    NSMutableArray *list = [[NSMutableArray alloc] initWithArray:products];
    self.historyList = list;
    TT_RELEASE_SAFELY(list);
    TT_RELEASE_SAFELY(dao);
    
    if (self.historyList == nil || [self.historyList count] == 0) {
        _searchView.scanTableView.tableFooterView = _searchView.noScanHistoryLabel;
        
    }else {
        _searchView.scanTableView.tableFooterView = _searchView.delAllScanButtonView;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchView.scanTableView reloadData];
    });
}

- (void)clearSearchHistorys
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Confirm clear search history")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"confirm")];
    [alert setConfirmBlock:^{
        [self.service deleteAllKeywordsFromDBWithCompletionBlock:^(NSArray *list){
            self.historyKeywordList = list;
            [self reloadHistoryTableViewData];
        }];
        
    }];
    [alert show];
}

- (void)cleanScanHistory
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Confirm clear scan history")
                                                   delegate:self
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    
    alert.tag = 1;
    [alert show];
}

-(void)switchHotKeywords
{
    [self.service beginGetHotKeywords];
}

#pragma mark - alertView delegate
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1)
        {
            BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
            
            [dao deleteAllHistorysFromDB];
            
            TT_RELEASE_SAFELY(dao);
            
            [self reloadScanHistoryTableViewData];
        }
    }
}


- (void)willGoToSearchListWithKeyword:(NSString *)keyword
{
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        return;
    }
    
    [_searchView.searchBar resignFirstResponder];
    
    __weak SearchViewController *weakSelf = self;
    [self.service addKeywordToDB:keyword completionBlock:^(NSArray *list){
        weakSelf.historyKeywordList = list;
        [weakSelf reloadHistoryTableViewData];
    }];
    
    SearchParamDTO *solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeKeyword set:SearchSetMix];
    solrParam.keyword = keyword;
    
    [self goToSeachResultWithSearchParam:solrParam];
}

- (void)goToSeachResultWithSearchParam:(SearchParamDTO *)paramDTO
{
    [SearchListViewController goToSearchResultWithParamDTO:paramDTO fromNav:self.navigationController];
}

#pragma mark -
#pragma mark AssociationalWordDisplayController method and delegate

- (AssociationalWordDisplayController *)keywordDisplayController
{
    if (!_keywordDisplayController) {
        _keywordDisplayController = [[AssociationalWordDisplayController alloc] initWithContentController:self];
        _keywordDisplayController.delegate = self;
    }
    return _keywordDisplayController;
}

- (void)didSelectAssociationalWord:(NSString *)keyword
{
    [self willGoToSearchListWithKeyword:keyword];
}

#pragma mark -
#pragma mark zbar reader

- (SNReaderController *)readerController
{
    if (!_readerController) {
        _readerController = [[SNReaderController alloc] initWithContentController:self];
    }
    return _readerController;
}

#pragma mark -
#pragma mark search bar delegate

- (void)beginReaderZBar
{
    [self.readerController beginReader];
}

//点击搜索背景图片跳转到活动页面
- (void)jumpToAdDetail
{
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
                    
                    NSString *url = dto.innerImageURL.trim;
                    if (url.length)
                    {
                        SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel
                         attributes:@{@"url": url, @"activeName": dto.activeName?dto.activeName:@""}];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }
                    break;
                    
                    
                case 2:{
                    
                    AdModel2ViewController *controller = [[AdModel2ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    
                    controller.activeName = dto.activeName;
                    
                    controller.activeRule = dto.activeRule;
                    
                    //                    if(IsStrEmpty(dto.innerImageURL)){
                    //
                    //                        controller.activeInnerImageUrl = dto.bigImageURL;
                    //
                    //                    }else{
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    //                    }
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    
                    TT_RELEASE_SAFELY(controller);
                    
                }
                    break;
                    
                    
                case 3:{
                    
                    AdModel3ViewController *controller = [[AdModel3ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    controller.activeName = dto.activeName;
                    controller.activeRule = dto.activeRule;
                    
                    //                    if(IsStrEmpty(dto.innerImageURL)){
                    //
                    //                        controller.activeInnerImageUrl = dto.bigImageURL;
                    //
                    //                    }else{
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    //                    }
                    
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
                    
                    //                    AdModel5ViewController *controller = [[AdModel5ViewController alloc] init];
                    
                    AdModel5ViewController *controller = [[AdModel5ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    controller.define = dto.define;
                    controller.activeName = dto.activeName;
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    
                    TT_RELEASE_SAFELY(controller);
                    
                }
                    break;
                    
                case 6:{
                    
                    AdModel6ViewController *controller = [[AdModel6ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                    
                    //                    if(IsStrEmpty(dto.innerImageURL)){
                    //
                    //                        controller.activeInnerImageUrl = dto.bigImageURL;
                    //
                    //                    }else{
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
                    //                    }
                    
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
                SNWebViewController *vc = [[SNWebViewController alloc]
                 initWithType:SNWebViewTypeAdModel attributes:@{@"url": url, @"activeName": dto.activeName?dto.activeName:@""}];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    [_searchView showSearchBar];
    if (![searchBar.placeholder isEqualToString:L(@"Search Product")]) {
        _searchView.searchBar.searchTextField.text=searchBar.placeholder;
    }
    
    UIView *searchField = [searchBar.subviews objectAtIndex:1];
    searchField.frame = CGRectMake(5 ,82 ,310, 31);
    [UIView animateWithDuration:0.5 animations:^{
        searchField.frame = CGRectMake(5, 6, 252, 31);
        searchBar.frame = CGRectMake(0, 0, 320, 44);
        for (UIView *view in _searchView.searchBar.subviews)
        {
            for (UIImageView *imageview in view.subviews) {
                if (imageview.tag==101) {
                    imageview.alpha=0;
                    imageview.frame=CGRectMake(0, 0, 320, 44);
                }
                if (imageview.tag==100) {
                    imageview.alpha=1;
                    imageview.frame=CGRectMake(0, 0, 320, 44);
                }
            }
            
            for (UIButton *button in view.subviews) {
                if (button.tag==102) {
                    button.enabled=NO;
                }
            }
        }
    }];
    
    //    [self.keywordDisplayController displayView];
    [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
        self.historyKeywordList = list;
    }];
    [self.keywordDisplayController displayView:self.historyKeywordList];
    //    [(NUSearchBar *)searchBar showCancelButton];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText isEqualToString:@""]) {
        searchBar.placeholder = L(@"Search Product");
        [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
            self.historyKeywordList = list;
        }];
        [self.keywordDisplayController displayView:self.historyKeywordList];
    }
    else
    {
        [self.keywordDisplayController refreshViewWithKeyword:searchText];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
//    [_searchView hideSearchBar];
    UIView *searchField = [searchBar.subviews objectAtIndex:1];
    searchField.frame = CGRectMake(5, 6, 252, 31);
    for (UIView *view in _searchView.searchBar.subviews)
    {
        for (UIImageView *imageview in view.subviews) {
            if (imageview.tag==101) {
                imageview.alpha=1;
                imageview.frame=CGRectMake(0, 0, 320, 191);
            }
            if (imageview.tag==100) {
                imageview.alpha=0;
            }
        }
        for (UIButton *button in view.subviews) {
            if (button.tag==102) {
                button.enabled=YES;
            }
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        searchField.frame = CGRectMake(5, 82, 310, 31);
        searchBar.frame=CGRectMake(0, 0, 320, 191);
        
        //        for (UIView *view in _searchView.searchBar.subviews)
        //        {
        //            for (UIImageView *imageview in view.subviews) {
        //                if (imageview.tag==101) {
        //                    imageview.alpha=1;
        //                    imageview.frame=CGRectMake(0, 0, 320, 120);
        //                }
        //                if (imageview.tag==100) {
        //                    imageview.alpha=0;
        //                }
        //            }
        //
        //            for (UIButton *button in view.subviews) {
        //                if (button.tag==102) {
        //                    button.enabled=YES;
        //                }
        //            }
        //        }
    }];
    
    [self.keywordDisplayController removeView];
    //    [(NUSearchBar *)searchBar showReaderButton];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
//    UIView *segment = [searchBar.subviews objectAtIndex:1];
//    DLog(@"%@",[segment description]);
    
    if ([searchBar.placeholder isEqualToString: L(@"Search Product")]) {
        searchBar.placeholder = [_searchView.searchBar switchSearchwords];
    }
    
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self willGoToSearchListWithKeyword:searchBar.text];
}


#pragma mark -
#pragma mark segment delegate

- (void)didSelectSegmentAtIndex:(NSInteger)index
{
    if (index == 1)
    {
        _searchView.tableView.hidden = NO;
        //        _searchView.hotKeywordsView.hidden = YES; //modi by wangjiaxing 20130520
        _searchView.tagList.hidden=YES; // add by wangjiaxing 20130520
        _searchView.scanTableView.hidden = YES;
        [self.service getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list){
            self.historyKeywordList = list;
            [self reloadHistoryTableViewData];
        }];
    }
    else if (index == 0)
    {
        _searchView.tableView.hidden = YES;
        //        _searchView.hotKeywordsView.hidden = NO; //modi by wangjiaxing 20130520
        _searchView.tagList.hidden=NO;// add by wangjiaxing 20130520
        _searchView.scanTableView.hidden = YES;
        //        [self.service beginGetHotKeywords];
    }
    else
    {
        _searchView.tableView.hidden = YES;
        //        _searchView.hotKeywordsView.hidden = YES; //modi by wangjiaxing 20130520
        _searchView.tagList.hidden=YES;// add by wangjiaxing 20130520s
        _searchView.scanTableView.hidden = NO;
        [self reloadScanHistoryTableViewData];
        
    }
}

#pragma mark -
#pragma mark hot keyword view delegate

- (void)didSelectKeyword:(NSString *)keyword
{
    [self willGoToSearchListWithKeyword:keyword];
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_searchView.scanTableView) {
        return 80;
    }
    else
    {
        return 40;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_searchView.scanTableView) {
        return self.historyList?[self.historyList count]:0;
    }
    else
    {
        return self.historyKeywordList?[self.historyKeywordList count]:0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_searchView.scanTableView) {
        static NSString *BrowsingCellIdentifier = @"BrowsingCellIdentifier";
        
        ScanHistoryProductCell *cell = (ScanHistoryProductCell *)[tableView dequeueReusableCellWithIdentifier:BrowsingCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[ScanHistoryProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BrowsingCellIdentifier];
            UIImageView *line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
            line.frame=CGRectMake(0, 79, 320, 1);
            [cell.contentView addSubview:line];
            TT_RELEASE_SAFELY(line);
        }
        
        DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
        
        [cell setItem:data];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"cellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        }
        
        for (UIView *view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"    %@",[self.historyKeywordList objectAtIndex:indexPath.row] ];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor colorWithRGBHex:0x444444];
        
        UIImageView *line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
        line.frame=CGRectMake(0, 39, 320, 1);
        [cell.contentView addSubview:line];
        TT_RELEASE_SAFELY(line);
        
        cell.backgroundColor=[UIColor clearColor];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_searchView.scanTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
        
        ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:data];
        
        [self.navigationController pushViewController:productViewController animated:YES];
        
        TT_RELEASE_SAFELY(productViewController);
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSString *keyword = [self.historyKeywordList objectAtIndex:indexPath.row];
        
        [self willGoToSearchListWithKeyword:keyword];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_searchView.scanTableView) {
        DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
        
        BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
        
        [dao deleteProductByData:data];
        
        TT_RELEASE_SAFELY(dao);
        
        [self reloadScanHistoryTableViewData];
    }
    else
    {
        NSString *keyword = [self.historyKeywordList objectAtIndex:indexPath.row];
        
        [self.service deleteKeywordFromDB:keyword completionBlock:^(NSArray *list){
            self.historyKeywordList = list;
            [self reloadHistoryTableViewData];
        }];
    }
}

#pragma mark -
#pragma mark service delegate

- (void)getHotKeywordsCompleteWithService:(SearchService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    if (isSuccess) {
        /* modi by wangjiaxing
         _searchView.hotKeywordsView.keywordArray = service.hotKeywordList;
         [_searchView.hotKeywordsView beginDisplay];
         */
        //add by wangjiaxing 20130520 for new type of hot keywords
        _searchView.tagList.textArray = service.hotKeywordList;
        [_searchView.tagList display];
        
    }else{
        //[self presentSheet:errorMsg];
    }
}

#pragma mark -
#pragma mark navigation delegate methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

@end
