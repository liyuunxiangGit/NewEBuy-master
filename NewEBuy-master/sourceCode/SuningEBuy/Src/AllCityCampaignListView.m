//
//  AllCityCampaignListView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityCampaignListView.h"

@implementation AllCityCampaignListView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self)
    {
        self.owner = owner;
        self.groupTableView.dataSource = self;
        self.groupTableView.delegate = self;
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
    }
    return self;
}

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_campaignList);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.groupTableView.frame =self.frame;
    
    [self addSubview:self.groupTableView];
    
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_campaignList count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StoreCampaignDTO *dto = [_campaignList objectAtIndex:indexPath.row];
    
    return [AllCityCampaignListCell heightOfCell:dto.campDescription];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 45;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    view.backgroundColor = [UIColor uiviewBackGroundColor];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.frame = CGRectMake(15, 12, 250, 20);
    nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
    nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
    nameLabel.text = L(@"NearbySuning_OnOrOffLine");
    [view addSubview:nameLabel];
    return  view;
        
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString  *allCityCampaignListCellIdentifier = @"allCityCampaignListCellIdentifier";
    
    AllCityCampaignListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityCampaignListCellIdentifier];
    
    if (!cell)
    {
        
        cell = [[AllCityCampaignListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityCampaignListCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    [cell setItem:[_campaignList objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(_delegate && [_delegate respondsToSelector:@selector(gotoCampaignView:)])
    {
        StoreCampaignDTO *dto = [_campaignList objectAtIndex:indexPath.row];
        
        [_delegate gotoCampaignView:dto];
    }
    
}

@end
