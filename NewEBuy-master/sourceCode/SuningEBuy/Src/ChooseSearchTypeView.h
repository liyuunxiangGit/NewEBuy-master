//
//  ChooseSearchTypeView.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSearchTypeView : UIView<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;

+ (void)showOnWindow;
+ (void)hide;
@end
