//
//  UICCRefreshCommonTableView.h
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-15.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPKeyboardAvoidingTableView.h"

@protocol UICCRefreshCommonTableViewDelegate <NSObject>
@optional
- (void)delegate_uiccHeaderRefreshTableViewDidTrigger;
- (void)delegate_uiccFooterRefreshTableViewDidTrigger;
@end

@interface UICCRefreshCommonTableView : TPKeyboardAvoidingTableView

@property (nonatomic,assign) BOOL showRefreshHeaderView; // default YES
@property (nonatomic,assign) BOOL showRefreshFooterView; // default YES

@property (nonatomic,strong) UIColor *refreshHeaderColor;
@property (nonatomic,strong) UIColor *refreshFooterColor;

@property (nonatomic,weak) IBOutlet id<UICCRefreshCommonTableViewDelegate> triggerDelegate;

@property (nonatomic,assign) BOOL isLoadingOfRefreshHeader;
@property (nonatomic,assign) BOOL isLoadingOfRefreshFooter;

@property (nonatomic,assign) BOOL isCloseLoadMore; // default NO

// 0 header refresh finished，else footer load finished
- (void)uicc_setLoadFinishedWithFlag:(NSUInteger)flag;

- (void)uicc_actionScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)uicc_actionScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


- (void)uicc_actionHeaderRefreshTableViewDidTrigger;

- (void)uicc_actionFooterRefreshTableViewDidTrigger;

@end