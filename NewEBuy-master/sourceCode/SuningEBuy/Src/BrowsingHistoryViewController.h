//
//  BrowsingHistoryViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"

@interface BrowsingHistoryViewController : CommonViewController<UIGestureRecognizerDelegate>
{
    NSMutableArray *historyList_;
}
@property (nonatomic, strong) UISwipeGestureRecognizer  *swipeRight;

@property (nonatomic, strong) NSMutableArray *historyList;

- (void)initData;

@end
