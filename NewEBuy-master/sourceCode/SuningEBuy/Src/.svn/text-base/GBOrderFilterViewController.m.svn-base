//
//  GBOrderFilterViewController.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderFilterViewController.h"

@implementation GBOrderFilterViewController

@synthesize orderStatusList = _orderStatusList;
@synthesize selectedStatusId = _selectedStatusId;
@synthesize delegate = _delegate;

- (void)dealloc{
    TT_RELEASE_SAFELY(_orderStatusList);
    TT_RELEASE_SAFELY(_selectedStatusId);
    
    
}

-(id)initWithStatusList:(NSArray *)list{
    self=[super init];
    if (self) {
        self.orderStatusList = list;
        self.title = L(@"Filter");
        self.hasNav = NO;
    }
    
    return  self;
}

- (void)setOrderStatusList:(NSArray *)orderStatusList{
    
    if (_orderStatusList != orderStatusList) {
        
        
        _orderStatusList = orderStatusList;
        
        selectedIndex = 0;
        
        self.selectedStatusId = nil;
        
        [self.snpopoverController popToRoot:NO];
    }
        
}

- (void)loadView{
    
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 230, 240);
    
    self.tableView.frame = CGRectMake(0, 0, 230, 240);
    
    [self.view addSubview:self.tableView];
    
}
- (void) viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([_delegate conformsToProtocol:@protocol(OrderStatusFilterDlegate)]) {
        if ([_delegate respondsToSelector:@selector(initRightBarButton)]) {
            [_delegate initRightBarButton];
        }
    }
}


#pragma mark -
#pragma mark Table View Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.orderStatusList) {
        
        return [self.orderStatusList count]+1;
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString  *statusCellIdentifier = @"statusCellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:statusCellIdentifier];
    
    if (cell  == nil) {
        
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:statusCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
   
    if (indexPath.row == selectedIndex) {
        cell.textLabel.textColor = RGBCOLOR(0, 204, 255);
    }else{
        
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if (indexPath.row > [self.orderStatusList count]) {
        return cell;
    }
     if (indexPath.row == 0) {
         
         cell.textLabel.text = L(@"GBAllState");
         cell.accessoryType = UITableViewCellAccessoryNone;
     }else{
         
         NSString *statusTitle = [self.orderStatusList objectAtIndex:indexPath.row-1];
         
         cell.textLabel.text = statusTitle;
     }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedIndex = indexPath.row ;
    NSInteger  selectIndex_ = selectedIndex;
    if (selectIndex_ >2) {
        selectIndex_ = selectIndex_+1;
    }
    [self.tableView reloadData];

    
    if (_delegate && [_delegate respondsToSelector:@selector(filterSelectOk:)]) {
        
        [_delegate filterSelectOk:selectIndex_];
        
    }
    
    [self dismissPopover:YES];
    
}
@end
