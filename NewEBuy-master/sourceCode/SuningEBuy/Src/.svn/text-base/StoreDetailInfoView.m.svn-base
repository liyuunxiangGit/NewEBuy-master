//
//  StoreDetailInfoView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreDetailInfoView.h"
#import "StoreDetailInfoCell.h"

@implementation StoreDetailInfoView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    
    if (self) {
        self.owner = owner;
        self.groupTableView.dataSource = self;
        self.groupTableView.delegate = self;
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    return self;
}

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_infoDTO);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.groupTableView.frame =self.frame;
    
    [self addSubview:self.groupTableView];
    
}

#pragma mark
#pragma mark - tableview datasource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [StoreDetailInfoCell height:self.infoDTO withRow:indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 60;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *storeDetailInfoCellIdentifier =@"storeDetailInfoCellIdentifier";
    
    StoreDetailInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:storeDetailInfoCellIdentifier];
    
    if (infoCell == nil)
    {
        infoCell = [[StoreDetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeDetailInfoCellIdentifier];
        infoCell.backgroundColor =[UIColor cellBackViewColor];
        infoCell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    [infoCell setItem:self.infoDTO withRow:indexPath.row];
    
    return infoCell;
    
}


@end
