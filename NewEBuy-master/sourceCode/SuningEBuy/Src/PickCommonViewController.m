//
//  PickCommonViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"

@implementation PickCommonViewController

@synthesize delegate = _delegate;
@synthesize checkMarkView = _checkMarkView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_checkMarkView);
}

- (UIImageView *)checkMarkView
{
    if (!_checkMarkView) {
        _checkMarkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
        
    }
    return _checkMarkView;
}

- (void)loadView
{    
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 230, 250);
    
    self.tableView.frame = CGRectMake(0, 0, 230, 250);
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:self.tableView];
}

@end
