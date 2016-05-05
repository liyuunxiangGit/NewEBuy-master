//
//  CatePickSecondViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CatePickSecondViewController.h"
#import "CatePickViewController.h"

@implementation CatePickSecondViewController

@synthesize cateDTO = _cateDTO;
@synthesize catePicker = _catePicker;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_cateDTO);
    
}

- (id)initWithCateDTO:(SearchCateDTO *)cate
{
    self = [super init];
    
    if (self) {
        self.isNeedBackItem = YES;
        self.cateDTO = cate;        
        self.title = self.cateDTO.cateName;
        
    }
    return self;
}

#pragma mark -
#pragma mark View life cycle

- (void)loadView
{
    [super loadView];
    
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cateDTO.subCateList) {
        return [self.cateDTO.subCateList count];
    }
    return 0;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cateCellIdentifier];        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
        cellSep.frame = CGRectMake(0, 35, 230,1);
        [cell.contentView addSubview:cellSep];

    }
    if (indexPath.row > [self.cateDTO.subCateList count]) {
        return cell;
    }
    
    SearchCateDTO *cateDTO = [self.cateDTO.subCateList objectAtIndex:indexPath.row];
    
    NSString *title = [NSString stringWithFormat:@"%@(%@)", cateDTO.cateName, cateDTO.count];
    cell.textLabel.text = title;
    
    if (self.catePicker.selectCateId && 
        [self.catePicker.selectCateId isEqualToString:cateDTO.cateId]) {
        cell.accessoryView = self.checkMarkView;
    }
    else
    {
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    SearchCateDTO *currentCateDTO = [self.cateDTO.subCateList objectAtIndex:indexPath.row];
    self.catePicker.selectCateId = currentCateDTO.cateId;
    [self.tableView reloadData];
 
    [self dismissPopover:YES];

    if (_delegate && [_delegate respondsToSelector:@selector(catePickDidOk)]) {
        [_delegate catePickDidOk];
    }
}


@end
