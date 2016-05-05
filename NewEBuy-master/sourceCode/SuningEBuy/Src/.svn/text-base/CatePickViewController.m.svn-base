//
//  CatePickViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CatePickViewController.h"
#import "SearchCateDTO.h"
#import "CatePickSecondViewController.h"

@implementation CatePickViewController

@synthesize categoryList = _categoryList;
@synthesize selectCateId = _selectCateId;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_categoryList);
    TT_RELEASE_SAFELY(_selectCateId);
}

- (id)initWithCateList:(NSArray *)list
{
    self = [super init];
    
    if (self) {
        self.categoryList = list;
        self.title = L(@"Category");
        
    }
    return self;
}

//相当于重新设置了数据源
- (void)setCategoryList:(NSArray *)categoryList
{
    if (_categoryList != categoryList) {
        _categoryList = categoryList;
        
        selectedIndex = 0;
        self.selectCateId = nil;
        
        [self.snpopoverController popToRoot:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark View life cycle



#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.categoryList) {
        return [self.categoryList count]+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cateCellIdentifier = @"cateCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cateCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:cateCellIdentifier];        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor blackColor];
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
        cellSep.frame = CGRectMake(0, 35, 230,1);
        [cell.contentView addSubview:cellSep];
        
    }
    if (indexPath.row > [self.categoryList count]) {
        return cell;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = L(@"All Categorys");
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (selectedIndex == 0) {
            cell.accessoryView = self.checkMarkView;
        }
        
    }else{
        cell.accessoryView = nil;
        SearchCateDTO *cateDTO = [self.categoryList objectAtIndex:indexPath.row-1];
        
        NSString *title = [NSString stringWithFormat:@"%@(%@)", cateDTO.cateName, cateDTO.count];
        cell.textLabel.text = title;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        UITableViewCell *firstCell = [tableView cellForRowAtIndexPath:indexPath];
        selectedIndex = 0;
        self.selectCateId = nil;
        firstCell.accessoryView = self.checkMarkView;
        
        if (_delegate && [_delegate respondsToSelector:@selector(catePickDidOk)]) {
            [_delegate catePickDidOk];
        }
        [self dismissPopover:YES];
    }
    else
    {
        UITableViewCell *firstCell = [tableView cellForRowAtIndexPath:indexPath];
        selectedIndex = -1;
        firstCell.accessoryView = nil;
        SearchCateDTO *cateDTO = [self.categoryList objectAtIndex:indexPath.row-1];
        
        CatePickSecondViewController *nextController = [[CatePickSecondViewController alloc] initWithCateDTO:cateDTO];
        nextController.delegate = self.delegate;
        nextController.catePicker = self;
        
        [self.navigationController pushViewController:nextController animated:YES];
        
        TT_RELEASE_SAFELY(nextController);
    }
}

@end
