//
//  NBCommonViewController.m
//  suningNearby
//
//  Created by suning on 14-8-6.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBCommonViewController.h"

@interface NBCommonViewController () <UICCRefreshCommonTableViewDelegate>

@end

@implementation NBCommonViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    if (self = [self initWithNibName:NSStringFromClass(self.class) bundle:nil]) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    if ([_refreshTableView respondsToSelector:@selector(setKeyboardDismissMode:)]) {
//        _refreshTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setRefreshTableView:(UICCRefreshCommonTableView *)refreshTableView {
    _refreshTableView = refreshTableView;
    if (nil != _refreshTableView) {
        _refreshTableView.delegate          = self;
        _refreshTableView.dataSource        = self;
        _refreshTableView.triggerDelegate   = self;
    }
}

- (void)delegate_uiccHeaderRefreshTableViewDidTrigger {
    
}

- (void)delegate_uiccFooterRefreshTableViewDidTrigger {
    
}

@end
