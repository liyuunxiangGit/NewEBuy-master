//
//  SNPopoverCommonViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SNPopoverCommonViewController
 @abstract    用于在SNPopoverController中展示的viewController的父类
 @author      刘坤
 @version     v1.0.002  12-9-3
 */

#import <UIKit/UIKit.h>
#import "SNPopoverController.h"

@interface SNPopoverCommonViewController : CommonViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) SNPopoverController *snpopoverController;
//@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL              isNeedBackItem;


/*!
 @abstract      消失，取消展示
 @param         animated  是否展示动画
 */
- (void)dismissPopover:(BOOL)animated;

@end
