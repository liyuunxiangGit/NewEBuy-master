//
//  BBSideBarViewController.h
//  SuningEBuy
//
//  Created by shasha on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PPRevealSideViewController.h"

@interface BBSideBarViewController : PPRevealSideViewController


//去本地生活
+ (void)goToLocalLife:(NSString *)tuanGouType snProId:(NSString *)snProId;

//回ebuy
+ (void)backToEbuy;
+ (void)backToEbuyAnimated:(BOOL)animated;

@end
