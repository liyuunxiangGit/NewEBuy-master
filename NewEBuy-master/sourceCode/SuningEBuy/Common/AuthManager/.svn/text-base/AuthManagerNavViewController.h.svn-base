//
//  AuthManagerNavViewController.h
//  
//
//  Created by Hubert Ryan on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#if kPanUISwitch
#import "ScreenShotNavViewController.h"
@interface AuthManagerNavViewController : ScreenShotNavViewController <UINavigationControllerDelegate>
{
    BOOL isLastStatus;
}
#else
@interface AuthManagerNavViewController : UINavigationController <UINavigationControllerDelegate>
{
    BOOL isLastStatus;
}

#endif

@property (nonatomic,strong) UIView *backgroundView;

- (BOOL)needLogonAuth:(UIViewController *)viewController;

- (BOOL)isLotteryController:(UIViewController *)viewController;

- (void)setNavigationBackground:(BOOL)isLottery;

- (void)setNavBarBackgoundWithColor:(UIColor *)color;

- (id)initWithRootViewController:(UIViewController *)rootViewController hasTopRoundCorner:(BOOL)isTopRound;

@end
