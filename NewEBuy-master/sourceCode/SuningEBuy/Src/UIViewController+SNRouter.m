//
//  UIViewController+SNRouter.m
//  SuningEBuy
//
//  Created by liukun on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "UIViewController+SNRouter.h"
#import "JASidePanelController.h"

static char routerSourceKey;

@implementation UIViewController (SNRouter)

- (void)setRouteSource:(SNRouteSource)source
{
    if (source == SNRouteSourceNone) {
        objc_setAssociatedObject(self, &routerSourceKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else{
        objc_setAssociatedObject(self, &routerSourceKey, @(source), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (SNRouteSource)routeSource
{
    NSNumber *numObj = objc_getAssociatedObject(self, &routerSourceKey);
    SNRouteSource source = [numObj integerValue];
    return source;
}

- (BOOL)isFromSNRouter
{
    return ([self routeSource] == SNRouteSourceNone) ? NO : YES;
}


@end

//一些特殊controller的兼容方案
@implementation JASidePanelController (SNRouter)

- (void)setRouteSource:(SNRouteSource)source
{
    if (source == SNRouteSourceNone) {
        objc_setAssociatedObject(self, &routerSourceKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else{
        objc_setAssociatedObject(self, &routerSourceKey, @(source), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if ([self centerPanel]) {
        [[self centerPanel] setRouteSource:source];
    }
    if ([self leftPanel]) {
        [[self leftPanel] setRouteSource:source];
    }
    if ([self rightPanel]) {
        [[self rightPanel] setRouteSource:source];
    }
}

@end
