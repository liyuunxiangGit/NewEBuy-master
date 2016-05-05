//
//  UICCRefreshTableFooterView.h
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-15.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#import "UICCRefreshCommonHeader.h"

@interface UICCRefreshTableFooterView : UIView

@property (nonatomic,weak) id<UICCRefreshTableViewDelegate> delegate;
@property (nonatomic,assign) BOOL isLoading;// 是否正在加载 default NO

@property (nonatomic,assign) kUICC_EGOPullRefreshState state;

@property (nonatomic,assign) BOOL isCloseLoadMore; // default NO

+ (UICCRefreshTableFooterView *)refreshTableFooterView;

- (void)uiccActionRefreshScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)uiccActionRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;

@end