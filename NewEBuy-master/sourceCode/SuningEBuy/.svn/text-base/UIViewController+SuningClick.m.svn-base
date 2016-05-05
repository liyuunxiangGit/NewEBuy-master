//
//  UIViewController+SuningClick.m
//  SuningEBuy
//
//  Created by liukun on 14-7-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "UIViewController+SuningClick.h"

static char snclick_pageObject_key;

@implementation UIViewController (SuningClick)

@dynamic pageTitle;

- (void)setPageTitle:(NSString *)title
{
    [[self snclick_pageObject] setPageTitle:title];
}

- (NSString *)pageTitle
{
    return [[self snclick_pageObject] pageTitle];
}

- (SuningPageObject *)snclick_pageObject
{
    SuningPageObject *obj = objc_getAssociatedObject(self, &snclick_pageObject_key);
    if (!obj) {
        obj = [[SuningPageObject alloc] init];
        obj.cls = [self class];
        obj.routeSource = [self routeSource];
//        if ([self routeSource] != SNRouteSourceNone) {
//            [self setRouteSource:SNRouteSourceNone];
//        }
        objc_setAssociatedObject(self, &snclick_pageObject_key, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (NSString *)snclick_collectionTitle
{
    //NSString *pageTitle = [self pageTitle];
    return [self pageTitle];
}

- (void)snclick_viewWillAppear
{
    SuningPageObject *obj = [self snclick_pageObject];
    //NSString *collectionTitle = [self snclick_collectionTitle];
//    [obj inColletion];
    if (self.pageTitle.length || self.title.length)
    {
        [obj inColletion];
    }
}

- (void)snclick_viewWillDisappear
{
    SuningPageObject *obj = [self snclick_pageObject];
    NSString *pageTitle = [self pageTitle];
    if (!pageTitle.length && self.title.trim.length)
    {
        pageTitle = [NSString stringWithFormat:@"其他_%@", self.title.trim];
        [self setPageTitle:pageTitle];
    }

    [obj outColletion:self];
}

- (void)snclick_switchPageWithPageTitle:(NSString *)pageTitleNew
{
    if (pageTitleNew.length && ![pageTitleNew isEqualToString:[self pageTitle]])
    {
        //先收集老页面
        SuningPageObject *obj = [self snclick_pageObject];
        [obj outColletion:self];
        
        obj.pageTitle = pageTitleNew;
        [obj inColletion];
    }
}

@end
