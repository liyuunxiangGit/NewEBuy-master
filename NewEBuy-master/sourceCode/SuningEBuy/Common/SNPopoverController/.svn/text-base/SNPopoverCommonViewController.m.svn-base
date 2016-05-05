//
//  SNPopoverCommonViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNPopoverCommonViewController.h"
#import "SNPopoverController.h"

@implementation SNPopoverCommonViewController

@synthesize snpopoverController = _snpopoverController;
//@synthesize tableView = _tableView;
@synthesize titleLabel = _titleLabel;
@synthesize isNeedBackItem = _isNeedBackItem;

- (void)dealloc {
    //    _tableView.delegate = nil; _tableView.dataSource = nil;
    //    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_titleLabel);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isNeedBackItem = NO;
        
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 230, 250);
}

- (void)viewWillAppear:(BOOL)animated
{
//    if (self.isNeedBackItem) {
//        UIBarButtonItem *item = [UIBarButtonItem initWithImage:@"home_back_btn.png"];// wihtSel:nil];
//        if (item.customView) {
//            UIButton *btn = (UIButton *)item.customView;
//            [btn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
//        }
//        self.navigationItem.leftBarButtonItem = item;
//    }
    if (self.isNeedBackItem)
    {
        SNUIBarButtonItem *item = [SNUIBarButtonItem itemWithTitle:nil
                                                             Style:SNNavItemStyleBack
                                                            target:self
                                                            action:@selector(backForePage)];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)backForePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)dismissPopover:(BOOL)animated
{
    if (_snpopoverController && [_snpopoverController isKindOfClass:[SNPopoverController class]]) {
        if ([_snpopoverController isVisible]) {
            [_snpopoverController dismissAnimated:animated];
        }
    }
}

- (UITableView *)tableView
{
	if(!_tableView){
		
		_tableView = [UITableView tableView];
        
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.delegate =self;
		
		_tableView.dataSource =self;
		
		//_tableView.backgroundColor =[UIColor navTintColor];
        _tableView.backgroundColor =[UIColor clearColor];
	}
	
	return _tableView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        self.navigationItem.titleView = _titleLabel;
    }
    return _titleLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

@end
