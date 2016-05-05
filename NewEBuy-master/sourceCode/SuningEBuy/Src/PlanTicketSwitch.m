//
//  PlanTicketSwitch.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PlanTicketSwitch.h"
#import "GlobalDataCenter.h"
#import "QueryPlaneViewController.h"

#define PlanTicketSwitch_Key        @"iPhonefly"
#define PlanTicketSwitch_Value_On   @"on"
#define PlanTicketSwitch_Value_Off  @"off"

@implementation PlanTicketSwitch

+ (BOOL)canUserNewServer
{
    
//    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
//    
//    NSString *switchValue = [dic objectForKey:PlanTicketSwitch_Key];
//    if (!IsStrEmpty(switchValue)&&[switchValue isEqualToString:PlanTicketSwitch_Value_On]) {
//        return YES;
//    }else{
//        return NO;
//    }
    
    //机票去除开关
    return YES;
}

+ (void)jumpToQueryPlaneView:(UINavigationController *)controller
{
    NSArray *viewControllers = controller.viewControllers;
    QueryPlaneViewController *queryPlanVC = nil;
    for (UIViewController *vc in viewControllers)
    {
        if ([vc isKindOfClass:[QueryPlaneViewController class]])
        {
            queryPlanVC = (QueryPlaneViewController *)vc;
            break;
        }
    }
    
    if (queryPlanVC) {
        [controller popToViewController:queryPlanVC animated:YES];
    }else{
        queryPlanVC = [[QueryPlaneViewController alloc] init];
        [controller popToRootViewControllerAnimated:NO];
        
        [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 0;
        UINavigationController *navC =
        [[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:0];
        [navC popToRootViewControllerAnimated:NO];
        [navC pushViewController:queryPlanVC animated:YES];
    }
    
}

+ (BOOL)isEncodeParam
{
    return YES;
}

@end
