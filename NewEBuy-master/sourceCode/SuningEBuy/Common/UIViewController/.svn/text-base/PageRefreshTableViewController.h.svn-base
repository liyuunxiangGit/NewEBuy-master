//
//  PageRefreshTableViewController.h
//  SuningEBuy
//
//  Created by zhaojw on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "UITableViewMoreCell.h"

@interface PageRefreshTableViewController : CommonViewController {
    
    
    NSInteger				currentPage;
    
	NSInteger				totalPage;
    
    NSInteger				totalCount;
    
	BOOL					isLastPage;
    
    
    BOOL                    _reloading;
    
    BOOL                    _isFromHead;
    
    BOOL                    _isLoading;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    

    //兼容IOS7全屏模式
    BOOL                    _isInsetGeted;
    UIEdgeInsets            _initScrollViewInset;
}

@property(nonatomic,assign)   NSInteger				currentPage;

@property(nonatomic,assign)   NSInteger				totalPage;

@property(nonatomic,assign)   NSInteger				totalCount;

@property(nonatomic,assign)   BOOL				    isLastPage;

@property(nonatomic,assign)   BOOL				    reloading;

@property(nonatomic,assign)   BOOL				    isLoading;

@property(nonatomic,assign)   BOOL				    isFromHead;

@property(nonatomic,strong)   EGORefreshTableHeaderView *refreshHeaderView;


- (void)startRefreshLoading;

- (void)startMoreAnimation:(BOOL)animating;

- (void)dataSourceDidFinishLoadingNewData;

- (void)reloadTableViewDataSource;

- (BOOL)hasMore;


- (void)refreshData;

- (void)refreshDataComplete;

- (void)loadMoreData;

- (void)loadMoreDataComplete;

@end
