//
//  UIViewController+SNRouter.h
//  SuningEBuy
//
//  Created by liukun on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNRouterObject.h"

@interface UIViewController (SNRouter)

- (void)setRouteSource:(SNRouteSource)source;
- (SNRouteSource)routeSource;

- (BOOL)isFromSNRouter;  //是否从页面路由跳转过来的

@end
