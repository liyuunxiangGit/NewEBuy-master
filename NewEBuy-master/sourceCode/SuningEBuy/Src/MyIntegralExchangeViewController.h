//
//  MyIntegralExchangeViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievementExchangeDTO.h"
#import "PageRefreshTableViewController.h"
#import "UITextField+LeftPadding.h"
#import "TPKeyboardAvoidingTableView.h"
#import "MyIntegralService.h"
#import "QYaoYiYaoScoreViewCtrler.h"
#import "QYaoYiYaoViewCtrler.h"
#import "CustomSegment.h"

@interface MyIntegralExchangeViewController : PageRefreshTableViewController<MyIntegralServiceeDelegate,QYaoYiYaoViewCtrlerDelegate,CustomSegmentDelegate>

- (id)init;

- (void)initialButtonItems;


@end
