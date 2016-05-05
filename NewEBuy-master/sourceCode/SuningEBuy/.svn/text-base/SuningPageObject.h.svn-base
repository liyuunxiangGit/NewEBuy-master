//
//  SuningPageObject.h
//  SuningEBuy
//
//  Created by liukun on 14-7-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+SNRouter.h"
//extern NSString *sourceTitle;//来源页面的数据
@interface SuningPageObject : NSObject

@property (nonatomic, copy) NSString *pageTitle;
@property (nonatomic, assign) Class  cls;
@property (nonatomic, assign) SNRouteSource routeSource; //如果从页面路由过来的，需要来源。
@property (nonatomic, assign, getter=isSaved) BOOL saved; //是否被收集过


- (NSString *)finalColletionString;

- (void)inColletion;
- (void)outColletion:(UIViewController *)controller;

@end
