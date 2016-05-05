//
//  UICCRefreshTableHeaderView.h
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-16.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#import "UICCRefreshCommonHeader.h"


@interface UICCRefreshTableHeaderView : UIView

@property (nonatomic,weak) id<UICCRefreshTableViewDelegate> delegate;
@property (nonatomic,assign) BOOL isLoading; // 是否正在加载 default NO

+ (UICCRefreshTableHeaderView *)refreshTableHeaderView;

- (void)uiccActionRefreshScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)uiccActionRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;

@end
