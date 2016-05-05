//
//  SearchView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

@synthesize scanTableView = _scanTableView;
@synthesize searchBar = _searchBar;
@synthesize segment = _segment;
@synthesize hotKeywordsView = _hotKeywordsView;
@synthesize tagList=_tagList;
@synthesize noHistoryLabel = _noHistoryLabel;
@synthesize noScanHistoryLabel=_noScanHistoryLabel;
@synthesize delAllButtonView = _delAllButtonView;
@synthesize delAllScanButtonView=_delAllScanButtonView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_scanTableView);
    TT_RELEASE_SAFELY(_searchBar);
    TT_RELEASE_SAFELY(_segment);
    TT_RELEASE_SAFELY(_hotKeywordsView);
    TT_RELEASE_SAFELY(_noHistoryLabel);
    TT_RELEASE_SAFELY(_noScanHistoryLabel);
    TT_RELEASE_SAFELY(_delAllButtonView);
    TT_RELEASE_SAFELY(_delAllScanButtonView);
    TT_RELEASE_SAFELY(_tagList);
}

- (id)initWithOwner:(id)owner {
    self = [super initWithOwner:owner];
    if (self) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;
                
//        self.searchBar.delegate = self;
        self.searchBar.readerDelegate = self.owner;
        [self addSubview:self.searchBar];
        
        self.segment.delegate = self.owner;
        self.segment.frame = CGRectMake(0, _searchBar.bottom, _segment.width, _segment.height);
        [self addSubview:self.segment];
        
        CGFloat height = frame.size.height - _searchBar.height - _segment.height - kUITabBarFrameHeight - kStatusBarHeight;
        frame = CGRectMake(0, self.segment.bottom, 320, height);
        //最近搜索
        self.tableView.delegate = self.owner;
        self.tableView.frame = frame;
        self.tableView.hidden = YES;
        [self addSubview:self.tableView];
        
        //最近浏览
        self.scanTableView.delegate = self.owner;
        self.scanTableView.frame = frame;
        self.scanTableView.hidden = YES;
        [self addSubview:self.scanTableView];
        
        //热门搜索
//        self.hotKeywordsView.frame = frame;
//        self.hotKeywordsView.delegate = self.owner;
//        self.hotKeywordsView.hidden = NO;
//        [self addSubview:self.hotKeywordsView];
        
        self.tagList.hidden=NO;
        self.tagList.frame = CGRectMake(20, self.segment.bottom+10, 280, height);;
        [self.tagList setAutomaticResize:YES];
//        [self.tagList setTagDelegate:self.owner];
        [self addSubview:self.tagList];
    }
    return self;
}

- (NUSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[NUSearchBar alloc] init];
    }
    return _searchBar;
}

- (NUSearchSegment *)segment
{
    if (!_segment) {
        _segment = [[NUSearchSegment alloc] init];
    }
    return _segment;
}

- (NUHotKeywordsView *)hotKeywordsView
{
    if (!_hotKeywordsView) {
        _hotKeywordsView = [[NUHotKeywordsView alloc] initWithKeywords:nil];
    }
    return _hotKeywordsView;
}

-(DWTagList *)tagList
{
    if (!_tagList) {
        _tagList=[[DWTagList alloc] init];
        _tagList.tagDelegate=self;
    }
    return _tagList;
}

- (UILabel *)noHistoryLabel
{
    if (!_noHistoryLabel) {
        _noHistoryLabel = [[UILabel alloc] init];
        _noHistoryLabel.frame = CGRectMake(0, 0, 320, 200);
        _noHistoryLabel.textAlignment = UITextAlignmentCenter;
        _noHistoryLabel.backgroundColor = [UIColor clearColor];
        _noHistoryLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _noHistoryLabel.textColor = [UIColor darkGrayColor];
        _noHistoryLabel.text = L(@"No history keywords");
        _noHistoryLabel.shadowColor = [UIColor whiteColor];
        _noHistoryLabel.shadowOffset = CGSizeMake(1, 1);
    }
    return _noHistoryLabel;
}

- (UILabel *)noScanHistoryLabel
{
    if (!_noScanHistoryLabel) {
        _noScanHistoryLabel = [[UILabel alloc] init];
        _noScanHistoryLabel.frame = CGRectMake(0, 0, 320, 200);
        _noScanHistoryLabel.textAlignment = UITextAlignmentCenter;
        _noScanHistoryLabel.backgroundColor = [UIColor clearColor];
        _noScanHistoryLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _noScanHistoryLabel.textColor = [UIColor darkGrayColor];
        _noScanHistoryLabel.text = L(@"No scan history keywords");
        _noScanHistoryLabel.shadowColor = [UIColor whiteColor];
        _noScanHistoryLabel.shadowOffset = CGSizeMake(1, 1);
    }
    return _noScanHistoryLabel;
}


- (UIView *)delAllButtonView
{
    if (!_delAllButtonView) {
        _delAllButtonView = [[UIView alloc] init];
        _delAllButtonView.backgroundColor = [UIColor clearColor];
        _delAllButtonView.frame = CGRectMake(0, 0, 320, 46);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 5, 260, 36);
        UIImage *image = [UIImage imageNamed:@"yellowButton_new.png"];
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:0];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [button setBackgroundImage:streImage forState:UIControlStateNormal];
        [button setTitle:L(@"Delete all history keywords") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clearSearchHistorys) forControlEvents:UIControlEventTouchUpInside];
        [_delAllButtonView addSubview:button];
        
    }
    return _delAllButtonView;
}

- (UIView *)delAllScanButtonView
{
    if (!_delAllScanButtonView) {
        _delAllScanButtonView = [[UIView alloc] init];
        _delAllScanButtonView.backgroundColor = [UIColor clearColor];
        _delAllScanButtonView.frame = CGRectMake(0, 0, 320, 46);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 5, 260, 36);
        UIImage *image = [UIImage imageNamed:@"yellowButton_new.png"];
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:0];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [button setBackgroundImage:streImage forState:UIControlStateNormal];
        [button setTitle:L(@"Delete all scan history keywords") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cleanScanHistory) forControlEvents:UIControlEventTouchUpInside];
        [_delAllScanButtonView addSubview:button];
        
    }
    return _delAllScanButtonView;
}

- (UITableView *)scanTableView{
	
	
	if(!_scanTableView){
		
        _scanTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStylePlain];
		
		
		[_scanTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_scanTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_scanTableView.scrollEnabled = YES;
		
		_scanTableView.userInteractionEnabled = YES;
		
		_scanTableView.backgroundColor = [UIColor clearColor];
        
        _scanTableView.backgroundView = nil;
        
        _scanTableView.delegate = self.owner;
        
        _scanTableView.dataSource = self.owner;
	}
	
	return _scanTableView;
}
#pragma mark -
#pragma mark actions

- (void)clearSearchHistorys
{
    if ([self.owner respondsToSelector:@selector(clearSearchHistorys)]) {
        [self.owner clearSearchHistorys];
    }
}

- (void)cleanScanHistory
{
    if ([self.owner respondsToSelector:@selector(cleanScanHistory)]) {
        [self.owner cleanScanHistory];
    }
}

- (void)switchHotKeywords
{
    if ([self.owner respondsToSelector:@selector(switchHotKeywords)]) {
        [self.owner switchHotKeywords];
    }
}

- (void)selectedTag:(NSString *)tagName
{
    if ([self.owner respondsToSelector:@selector(didSelectKeyword:)]) {
        [self.owner didSelectKeyword:[NSString stringWithString:tagName]];
    }
}
//显示搜索框
//- (void)showSearchBar
//{
//    self.searchBar.readerButton.alpha = 0.0f;
//    self.searchBar.showsCancelButton=YES;
//    self.searchBar.cancelButton.frame=CGRectMake(262, 5, 53, 31);
//    [self.searchBar bringSubviewToFront:self.searchBar.cancelButton];
//    [self.searchBar cancelBtnSetting];
//
//    [UIView animateWithDuration: 0.5
//                     animations:^{
//                         
////                         self.searchBar.frame = CGRectMake(0, 0, 320, 44);
//                         
//                         self.searchBar.showsCancelButton  = YES;
//                         
//                                                                           
//                     }completion:^(BOOL finished) {
//                         
//                     }];
//    
//    
//}

//-(void)hideSearchBar
//{
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        CGRect frame = self.searchBar.frame;
//        
//        frame.size.width = 200;
//        
//        self.searchBar.frame = frame;
//        
////        self.searchBar.text = nil;
//        
//        self.searchBar.frame =CGRectMake(0, 0, 320, 44);
//        
//        self.searchBar.showsCancelButton = NO;
//        [self.searchBar showReaderButton];
//        
//    }completion:^(BOOL finished){
//        [self.searchBar resignFirstResponder];
//        
//    }];
//    
//    [UIView animateWithDuration:1.0 animations:^{
//        self.searchBar.readerButton.alpha = 1.0;
//        
//        self.searchBar.readerButton.frame = CGRectMake(270, 152, 35, 35);
//        
//        [self.searchBar addSubview:self.searchBar.readerButton];
//    }];
//    
//    
//}

@end
