//
//  TicketOrderFilterViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "TicketOrderFilterViewController.h"

@interface TicketOrderFilterViewController()
{
    NSArray *_filterArray;
    
    NSInteger _index;
}

@property (nonatomic, strong) UIImageView *checkMarkView;

@end

/*********************************************************************/

@implementation TicketOrderFilterViewController

@synthesize checkMarkView = _checkMarkView;
@synthesize delegate = _delegate;

- (void)dealloc {
    TT_RELEASE_SAFELY(_filterArray);
    TT_RELEASE_SAFELY(_checkMarkView);
}

- (id)initWithFilterIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.titleLabel.text = L(@"Filter");
        self.pageTitle = L(@"virtual_business_myFlightFilter");
        _index = index;
        _filterArray = [[NSArray alloc] initWithObjects:
                        L(@"All"),
                        L(@"PVWaitForPay"),
                        L(@"BTIssuingTicket"),
                        L(@"PVCanceled"),
                        L(@"BTHaveREfunded"),
                        L(@"BTIssueTicketSuccess"),
                        L(@"BTChanging"), nil];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 230, 250);
    
    self.tableView.frame = self.view.bounds;
    
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier= @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    cell.textLabel.text = [_filterArray objectAtIndex:indexPath.row];
    if (_index == indexPath.row) {
        cell.accessoryView = self.checkMarkView;
    }else{
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (_index != indexPath.row) {
//        NSIndexPath *oldPath = [NSIndexPath indexPathForRow:_index inSection:0];
//        NSIndexPath *newPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//        
//        _index = indexPath.row;
//        
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:oldPath, newPath, nil] 
//                         withRowAnimation:UITableViewRowAnimationNone];
//    }
    
    [self dismissPopover:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectOrderStatus:)]) {
        [_delegate didSelectOrderStatus:indexPath.row];
    }
}

- (UIImageView *)checkMarkView
{
    if (!_checkMarkView) {
        _checkMarkView = 
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_tablePicker_checkMark.png"]];
        
    }
    return _checkMarkView;
}

@end
