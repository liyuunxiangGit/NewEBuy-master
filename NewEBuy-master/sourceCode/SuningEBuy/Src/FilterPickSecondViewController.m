//
//  FilterPickSecondViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FilterPickSecondViewController.h"
//#define TXTCOLOR_GRAY          RGBCOLOR(91, 90, 89)
#define TXTCOLOR_GRAY          RGBCOLOR(49, 49, 49)

@implementation FilterPickSecondViewController

@synthesize filter = _filter;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_filter);
       
}

- (id)init
{
    if (self = [super init])
    {
        if (IOS7_OR_LATER) {
            self.edgesForExtendedLayout = UIRectEdgeBottom;
        }
    }
    
    return self;
}

- (id)initWithFitler:(SearchFilterDTO *)fil
{
    self = [super init];
    if (self) {
        self.filter = fil;
        self.titleLabel.text = self.filter.filterName;
       // self.title = self.filter.filterName;
        self.isNeedBackItem = YES;
        
        if (IOS7_OR_LATER)
            self.edgesForExtendedLayout = UIRectEdgeBottom;
        
        self.pageTitle =L(@"search_searchPage_Filter");
    }
    return self;
}


#pragma mark -
#pragma mark View life cycle

- (void)loadView
{
    [super loadView];
    
    self.tableView.frame = self.view.bounds;
    if (IOS7_OR_LATER)
        self.tableView.backgroundColor = [UIColor uiviewBackGroundColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.tableView];
    
   // self.titleLabel.numberOfLines = 1;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.filter && self.filter.valueList) 
    {
        return [self.filter.valueList count]+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleLabelString;
    if (indexPath.row == 0) {
        titleLabelString = L(@"Select_All");
    }else{
        SearchFilterValueDTO *valueDTO = [self.filter.valueList objectAtIndex:indexPath.row-1];
        
        titleLabelString = valueDTO.valueDesc;
    }
    if (titleLabelString) {
        CGSize stringSize = [titleLabelString sizeWithFont:[UIFont boldSystemFontOfSize:14.0] 
                                         constrainedToSize:CGSizeMake(200, 500) 
                                             lineBreakMode:UILineBreakModeCharacterWrap];
        return (stringSize.height+5 > 36) ? (stringSize.height+5) : 36;
    }
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *filterCellIdentifier = @"filterCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:filterCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:filterCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        cell.textLabel.textColor = TXTCOLOR_GRAY;
        

    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = L(@"Select_All");
        if (self.filter.currentValue == nil) {
            cell.accessoryView = self.checkMarkView;
        }else{
            cell.accessoryView = nil;
        }
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 35.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
    }else{
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 35.5, 320,0.5);
        [cell.contentView addSubview:cellSep];

        SearchFilterValueDTO *dto = [self.filter.valueList objectAtIndex:indexPath.row-1];
        
        cell.textLabel.text = dto.valueDesc;
        
        if (dto.checked) {
            cell.accessoryView = self.checkMarkView;
        }else{
            cell.accessoryView = nil;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView 
  willDisplayCell:(UITableViewCell *)cell 
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    CGSize size = CGSizeMake(180, 300);
    CGSize finalSize = [cell.textLabel.text sizeWithFont:font 
                                       constrainedToSize:size 
                                           lineBreakMode:UILineBreakModeCharacterWrap];
    cell.textLabel.size = finalSize;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //选中全部
        [self.filter setSelectAll];
    }else{
        //选择对应的value
        [self.filter setSelectValueAtIndex:indexPath.row-1];
    }
    //[self.tableView reloadData];
        
    //[self pickFinish];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    if (_selectFilterBlock)
    {
        _selectFilterBlock();
    }
}

//- (void)pickFinish
//{
//    [self dismissPopover:YES];
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
//        [_delegate filterPickDidOk];
//    }
//}

@end
