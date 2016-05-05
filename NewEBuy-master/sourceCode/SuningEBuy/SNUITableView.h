//
//  CommonTableView.h
//  SNFramework
//
//  Created by  liukun on 13-12-27.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (factory)

//工厂方法
+ (instancetype)tableView;
+ (instancetype)groupTableView;

//工具方法
- (void)scrollToBottom;

@end
