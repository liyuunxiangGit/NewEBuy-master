//
//  UICCRefreshCommonTableView.m
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-15.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#import "UICCRefreshCommonTableView.h"

#import "UICCRefreshTableHeaderView.h"
#import "UICCRefreshTableFooterView.h"


@interface UICCRefreshCommonTableView () <UICCRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UICCRefreshTableHeaderView *tbRefreshHeaderView;
@property (nonatomic,strong) UICCRefreshTableFooterView *tbRefreshFooterView;
@end

@implementation UICCRefreshCommonTableView

- (void)cc_initializeUI {
    CGSize sz = self.bounds.size;
    
    // create refresh header view
    if (nil != _tbRefreshHeaderView
        && nil != [_tbRefreshHeaderView superview]) {
        [_tbRefreshHeaderView removeFromSuperview];
    }
    
    self.tbRefreshHeaderView = [UICCRefreshTableHeaderView refreshTableHeaderView];
    _tbRefreshHeaderView.frame = CGRectMake(.0f,-sz.height,sz.width,sz.height);
    _tbRefreshHeaderView.delegate = self;
    [self addSubview:_tbRefreshHeaderView];
    
    // create refresh footer view
    if (nil != _tbRefreshFooterView
        && nil != [_tbRefreshFooterView superview]) {
        [_tbRefreshFooterView removeFromSuperview];
    }
    
    CGFloat y = MAX(self.contentSize.height,self.frame.size.height);
    self.tbRefreshFooterView = [UICCRefreshTableFooterView refreshTableFooterView];
    _tbRefreshFooterView.frame = CGRectMake(.0f,y,sz.width,sz.height);
    _tbRefreshFooterView.delegate = self;
    _tbRefreshFooterView.hidden = YES;
    [self addSubview:_tbRefreshFooterView];
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.delegate   = self;
    self.dataSource = self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self cc_initializeUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self cc_initializeUI];
    }
    
    return self;
}

- (void)setIsCloseLoadMore:(BOOL)isCloseLoadMore {
    _isCloseLoadMore = isCloseLoadMore;
    
    self.tbRefreshFooterView.isCloseLoadMore = _isCloseLoadMore;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <.0f) {
        [_tbRefreshHeaderView uiccActionRefreshScrollViewDidScroll:scrollView];
    }else {
        [_tbRefreshFooterView uiccActionRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < .0f) {
        [_tbRefreshHeaderView uiccActionRefreshScrollViewDidEndDragging:scrollView];
    }else {
         [_tbRefreshFooterView uiccActionRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark - UICCRefreshCommonViewDelegate

- (void)delegate_uiccRefreshTableView_didTriggerRefresh:(UIView *)view {
    
    if (view == _tbRefreshHeaderView) {
        // 向上刷新
        _tbRefreshHeaderView.isLoading = YES;
        if (nil != _triggerDelegate
            && [_triggerDelegate respondsToSelector:@selector(delegate_uiccHeaderRefreshTableViewDidTrigger)]) {
            [_triggerDelegate delegate_uiccHeaderRefreshTableViewDidTrigger];
        }else {
            [self uicc_actionHeaderRefreshTableViewDidTrigger];
        }
        
    }else if (view == _tbRefreshFooterView) {
        // 向下刷新
        _tbRefreshFooterView.isLoading = YES;
        if (nil != _triggerDelegate
            && [_triggerDelegate respondsToSelector:@selector(delegate_uiccFooterRefreshTableViewDidTrigger)]) {
            
            [_triggerDelegate delegate_uiccFooterRefreshTableViewDidTrigger];
        }else {
            [self uicc_actionFooterRefreshTableViewDidTrigger];
        }
    }
}

- (BOOL)delegate_uiccRefreshTableView_dataSourceIsLoading:(UIView *)view {
    if (view == _tbRefreshHeaderView) {
        return _tbRefreshHeaderView.isLoading;
    }else {
        return _tbRefreshFooterView.isLoading;
    }
}

#pragma mark - action

- (void)uicc_actionScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y <.0f) {
        [_tbRefreshHeaderView uiccActionRefreshScrollViewDidScroll:scrollView];
    }else {
        
        if (!_isCloseLoadMore) {
            if (_tbRefreshFooterView.state != kUICC_EGOPullRefreshNormal) {
                _tbRefreshFooterView.state = kUICC_EGOPullRefreshNormal;
            }
            [_tbRefreshFooterView uiccActionRefreshScrollViewDidScroll:scrollView];
        }else {
            if (_tbRefreshFooterView.state != kUICC_EGOPullLoadMoreClose) {
                _tbRefreshFooterView.state = kUICC_EGOPullLoadMoreClose;
            }
        }
    }
}

- (void)uicc_actionScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < .0f) {
        [_tbRefreshHeaderView uiccActionRefreshScrollViewDidEndDragging:scrollView];
    }else {
        if (!_isCloseLoadMore) {
            [_tbRefreshFooterView uiccActionRefreshScrollViewDidEndDragging:scrollView];
        }else {
            [_tbRefreshFooterView setState:kUICC_EGOPullLoadMoreClose];
        }
    }
}

- (void)uicc_actionHeaderRefreshTableViewDidTrigger {
    
}

- (void)uicc_actionFooterRefreshTableViewDidTrigger {
}

- (void)setIsLoadingOfRefreshHeader:(BOOL)isLoadingOfRefreshHeader {
    _tbRefreshHeaderView.isLoading = isLoadingOfRefreshHeader;
}

- (void)setIsLoadingOfRefreshFooter:(BOOL)isLoadingOfRefreshFooter {
    _tbRefreshFooterView.isLoading = isLoadingOfRefreshFooter;
}

#pragma mark - refresh view color 

- (void)setRefreshHeaderColor:(UIColor *)refreshHeaderColor {
    _refreshHeaderColor = refreshHeaderColor;
    _tbRefreshHeaderView.backgroundColor = _refreshHeaderColor;
}

- (void)setRefreshFooterColor:(UIColor *)refreshFooterColor {
    _refreshFooterColor = refreshFooterColor;
    _tbRefreshFooterView.backgroundColor = _refreshFooterColor;
}

#pragma - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - 

// 0 header refresh finished，else footer load finished
- (void)uicc_setLoadFinishedWithFlag:(NSUInteger)flag {
    if (0 == flag) {
        self.isLoadingOfRefreshHeader = NO;
    }else {
        self.isLoadingOfRefreshFooter = NO;
    }
}

@end
