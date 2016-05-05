//
//  UICCRefreshCommonHeader.h
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-15.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#ifndef CCRefreshCommonTableView_UICCRefreshCommonHeader_h
#define CCRefreshCommonTableView_UICCRefreshCommonHeader_h


typedef enum{
    kUICC_EGOPullRefreshNormal = 0,
	kUICC_EGOPullRefreshPulling,
	kUICC_EGOPullRefreshLoading,
    kUICC_EGOPullRefreshLoaded,
    kUICC_EGOPullLoadMoreClose, // 不可以向下 获取更多数据
}kUICC_EGOPullRefreshState;

#define kUICC_REFRESH_REGION_HEIGHT     65.0f

#define kUICC_FLIP_ANIMATION_DURATION   0.18f

@protocol UICCRefreshTableViewDelegate <NSObject>
@optional

// trigger
- (void)delegate_uiccRefreshTableView_didTriggerRefresh:(UIView *)view;

// state
- (BOOL)delegate_uiccRefreshTableView_dataSourceIsLoading:(UIView *)view;

@end


#endif