//
//  FilterPickViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FilterPickViewController.h"
#import "SNFilterPickCell.h"
#import "FilterPickSecondViewController.h"
#import "SearchListService.h"

@interface FilterPickViewController()

@property (nonatomic, strong) UISwitch *searchHasStockSwitch;

@property (nonatomic, strong) UIButton *switchBtn;

@property (nonatomic, strong) UIButton *radiusBtn;

@end

/*********************************************************************/

@implementation FilterPickViewController

@synthesize filterList = _filterList;
@synthesize selectFilterMap = _selectFilterMap;
@synthesize switchBtn=_switchBtn;

- (void)dealloc
{
    self.filterList = nil;
    TT_RELEASE_SAFELY(_selectFilterMap);
    TT_RELEASE_SAFELY(_searchHasStockSwitch);
    TT_RELEASE_SAFELY(_searchCondition);
    TT_RELEASE_SAFELY(_switchBtn);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Done")
//                                                                 style:UIBarButtonItemStyleDone
//                                                                target:self
//                                                                action:@selector(done:)];
//    self.navigationItem.rightBarButtonItem = doneItem;
//    [doneItem release];
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Done")];
}

- (void)righBarClick
{
    [self done:nil];
}

- (void)done:(id)sender
{
    [self dismissPopover:YES];
}


- (NSMutableDictionary *)selectFilterMap
{
    if (!_selectFilterMap) {
        _selectFilterMap = [[NSMutableDictionary alloc] init];
    }
    return _selectFilterMap;
}

- (void)setSearchHasStockOn:(id)sender
{
    if (![self.searchCondition.inventory isEqualToString:@"1"]) {
        self.searchCondition.inventory = @"1";
    }else{
        self.searchCondition.inventory = @"-1";
    }
    
    [self pickFinishWithCallBack];
}

- (void)setSearchShopNum:(id)sender
{
    if (![self.searchCondition.shopNum isEqualToString:@"1"]&&![self.searchCondition.shopNum isEqualToString:@""]) {
        self.searchCondition.shopNum = @"1";
    }
    else
    {
        self.searchCondition.shopNum = @"-1";
    }
    
    [self pickFinishWithCallBack];

}

- (BOOL)isSearchHasStockOn
{
    if ([self.searchCondition.inventory isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (UISwitch *)searchHasStockSwitch
{
    if (!_searchHasStockSwitch) {
        _searchHasStockSwitch = [[UISwitch alloc] init];
        _searchHasStockSwitch.on = [self isSearchHasStockOn];
        [_searchHasStockSwitch addTarget:self
                                  action:@selector(setSearchHasStockOn:)
                        forControlEvents:UIControlEventValueChanged];
    }
    return _searchHasStockSwitch;
}

- (UIButton *)switchBtn
{
    if (!_switchBtn) {
        _switchBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_off.png"] forState:UIControlStateNormal];
        
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_on.png"] forState:UIControlStateSelected];
        
        [_switchBtn addTarget:self action:@selector(switchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchBtn;
}

- (UIButton *)radiusBtn
{
    if (!_radiusBtn) {
        _radiusBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
        [_radiusBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_off.png"] forState:UIControlStateNormal];
        
        [_radiusBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_on.png"] forState:UIControlStateSelected];
        
        [_radiusBtn addTarget:self action:@selector(radiusBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _radiusBtn;
}

- (void)switchBtnClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    
    [self setSearchHasStockOn:nil];
}

- (void)radiusBtnCliked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    
    [self setSearchShopNum:nil];
}


//相当于重新设置数据源
- (void)setFilterList:(NSArray *)filterList
{
    if (filterList != _filterList) {
        
        if (_filterList && [_filterList count] > 0) {
            for (SearchFilterDTO *valueDTO in _filterList)
            {
                [valueDTO removeObserver:self forKeyPath:@"currentValue"];
            }
        }
        [self.selectFilterMap removeAllObjects];
        
        _filterList = filterList;
        
        if (_filterList) {
            for (SearchFilterDTO *valueDTO in _filterList)
            {
                if (valueDTO.currentValue) {
                    [self.selectFilterMap setObject:valueDTO.currentValue 
                                             forKey:valueDTO.filterKey];
                }
                
                [valueDTO addObserver:self
                           forKeyPath:@"currentValue"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"currentValue"] && 
        [object isKindOfClass:[SearchFilterDTO class]]) {
        
        SearchFilterDTO *dto = (SearchFilterDTO *)object;
        
        if (dto.currentValue) {
            [self.selectFilterMap setObject:dto.currentValue forKey:dto.filterKey];
        }else{
            [self.selectFilterMap removeObjectForKey:dto.filterKey];
        }
    }
}

- (id)initWithFitlerList:(NSArray *)filList
{
    self = [super init];
    
    if (self) {
        self.filterList = filList;
        self.title = L(@"Filter");
        self.pageTitle = L(@"search_searchPage_Filter");
    }
    return self;
}

- (void)pickFinish
{
    [self dismissPopover:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
        [_delegate filterPickDidOk];
    }
}

- (void)pickFinishWithCallBack
{
    [self displayOverFlowActivityView];
    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
        [_delegate filterPickDidOkWithRefreshCompleteCallBack:^(NSArray *filterList){
            
            [self removeOverFlowActivityView];
            self.filterList = filterList;
            [self.tableView reloadData];
            
        }];
    }
    [self.tableView reloadData];

}

#pragma mark -
#pragma mark View life cycle

- (void)loadView
{
    [super loadView];
    
}

//当关键词图书筛选时，判断已选项
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.frame = self.view.bounds;
    [self.tableView reloadData];
    
}


#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchCondition.set == SearchSetBook)
    {
        return [_filterList count]+1;
    }
    else
    {
        return [_filterList count]+3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *filterCellIdentifier = @"filterCellIdentifier";
    
    SNFilterPickCell *cell = 
    (SNFilterPickCell *)[tableView dequeueReusableCellWithIdentifier:filterCellIdentifier];
    if (cell == nil) {
        cell = [[SNFilterPickCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                        reuseIdentifier:filterCellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
        cellSep.frame = CGRectMake(0, 35, 230,1);
        [cell.contentView addSubview:cellSep];

    }
    
    cell.accessoryView = nil;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = L(@"Search_ResetFilterConditions");
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryLabel.text = nil;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    else if (indexPath.row == 2 && self.searchCondition.set != SearchSetBook)
    {
        cell.textLabel.text = L(@"Search_JustSearchInStockGoods");
        cell.accessoryLabel.text=nil;
        cell.accessoryView = self.switchBtn;
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = L(@"MyEBuy_SuningSelf");
        cell.accessoryLabel.text=nil;
        cell.accessoryView = self.radiusBtn;
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
        NSInteger index = indexPath.row - 3;
        if (self.searchCondition.set == SearchSetBook)
        {
            index = indexPath.row - 1;
        }
        SearchFilterDTO *filter = [self.filterList objectAtIndex:index];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = filter.filterName;
        if (filter.currentValue && filter.currentValueDesc) {
            cell.accessoryLabel.text = filter.currentValueDesc;
        }else{
            cell.accessoryLabel.text = nil;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {   //重置筛选项

        [self.selectFilterMap removeAllObjects];
        
        [self.tableView reloadData];
        
        [self pickFinish];
    }
    else if (indexPath.row == 2 && self.searchCondition.set != SearchSetBook)
    {
        
    }
    else if (indexPath.row == 1)
    {
        
    }
    else
    {
        UITableViewCell *firstCell = [tableView cellForRowAtIndexPath:indexPath];
        firstCell.accessoryView = nil;
        NSInteger index = indexPath.row - 3;
        if (self.searchCondition.set == SearchSetBook)
        {
            index = indexPath.row - 1;
        }
        SearchFilterDTO *filterCurr = [self.filterList objectAtIndex:index];
        FilterPickSecondViewController *nextController = 
        [[FilterPickSecondViewController alloc] initWithFitler:filterCurr];
        nextController.delegate = self.delegate;
        
        nextController.selectFilterBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
            [self pickFinishWithCallBack];
        };
        
        [self.navigationController pushViewController:nextController animated:YES];
        TT_RELEASE_SAFELY(nextController);
    }
}


@end
