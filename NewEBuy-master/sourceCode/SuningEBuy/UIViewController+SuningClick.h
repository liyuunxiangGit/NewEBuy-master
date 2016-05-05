//
//  UIViewController+SuningClick.h
//  SuningEBuy
//
//  Created by liukun on 14-7-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuningPageObject.h"

/**
 *  关于页面信息采集的类别
 */
@interface UIViewController (SuningClick)

@property (nonatomic, strong) NSString *pageTitle;

- (SuningPageObject *)snclick_pageObject;

- (void)snclick_viewWillAppear;
- (void)snclick_viewWillDisappear;

/**
 *  如果在一个页面里面更改pageTitle, 认为是一个新的页面时，调用该方法
 *
 *  @param pageTitleNew 新的pageTitle
 */
- (void)snclick_switchPageWithPageTitle:(NSString *)pageTitleNew;

@end
