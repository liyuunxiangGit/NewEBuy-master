//
//  SuningPageObject.m
//  SuningEBuy
//
//  Created by liukun on 14-7-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SuningPageObject.h"
#import "SNSwitch.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "JASidePanelController.h"

@implementation SuningPageObject

- (NSString *)finalColletionString
{
    NSString *finalPageTitle = self.pageTitle;
    if ([self routeSource] == SNRouteSourceDM) {
        finalPageTitle = [NSString stringWithFormat:@"DM_%@", finalPageTitle];
    }else if ([self routeSource] == SNRouteSourceOpenUrl) {
        finalPageTitle = [NSString stringWithFormat:@"wap引流_%@", finalPageTitle];
    }else if ([self routeSource] == SNRouteSourceRemoteNotification){
        finalPageTitle = [NSString stringWithFormat:@"推送_%@", finalPageTitle];
    }

    return finalPageTitle;
}

- (void)inColletion
{
    //如果当前页面还没有被收集，则收集
    SuningPageObject *currentObj = [SuningMainClick sharedInstance].currentPageObj;
    if (currentObj != self && !currentObj.isSaved) {
        [currentObj outColletion:nil];
    }
    
    [SuningMainClick sharedInstance].currentPageObj = self;

    if ([SNSwitch isSuningBISDKOn])
    {
        if (self.finalColletionString.length)
        {
            [SSAIOSSNDataCollection multiPagesInCollection:self.finalColletionString];
        }
        DLog(@"inColletion:%@",self.finalColletionString);
        //[SSAIOSSNDataCollection singlePageInCollection];
    }
    self.saved = NO;
}

- (void)outColletion:(UIViewController *)controller
{
    if ((([self.cls isKindOfClass:[JASidePanelController class]])||(self == [SuningMainClick sharedInstance].currentPageObj)) && !self.isSaved) {
        
        if ([SNSwitch isSuningBISDKOn])
        {
            if (IsStrEmpty(self.finalColletionString)||[self.finalColletionString isEqualToString:@"null"])
            {
                return;
            }
            if (self.finalColletionString.length)
            {
                [SSAIOSSNDataCollection multiPagesOutCollection:self.finalColletionString];
                DLog(@"outColletion:%@",self.finalColletionString);
                //[SSAIOSSNDataCollection singlePageOutCollection:self.finalColletionString];
            }
            
        }
        self.saved = YES;
                
        //如果是从页面路由来的，收集后设置为None
        if ([self routeSource] != SNRouteSourceNone) {
            [self setRouteSource:SNRouteSourceNone];
        }
        
        if ([controller routeSource] != SNRouteSourceNone) {
            [controller setRouteSource:SNRouteSourceNone];
        }
    }    
}

@end
