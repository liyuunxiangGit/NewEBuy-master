//
//  StoreServiceAndCampaignListView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreServiceAndCampaignListView.h"
#import "AllCityServiceListCell.h"
#import "AllCityCampaignListCell.h"

@implementation StoreServiceAndCampaignListView

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
    TT_RELEASE_SAFELY(_serviceList);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.groupTableView.frame =self.frame;
    [self addSubview:self.groupTableView];
    [self addSubview:self.noDataView];
}

- (UIView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        _noDataView.backgroundColor = [UIColor uiviewBackGroundColor];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suning_image_tixing.png"]];
        imgView.frame = CGRectMake(85, 70, 150, 135);
        [_noDataView addSubview:imgView];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(30, 215, 260, 40);
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithRGBHex:0x707070];
        label.text = L(@"NearbySuning_NoServiceActivityThisStore");
        label.textAlignment = UITextAlignmentCenter;
        [_noDataView addSubview:label];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 275, 220, 40)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_default.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_pressed.png"] forState:UIControlStateHighlighted];
        [btn setTitle:L(@"NearbySuning_SeeOtherStores") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoStoreList) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_noDataView addSubview:btn];
        [_noDataView setHidden:YES];
    }
    return _noDataView;
}

- (void)gotoStoreList
{
    if(_delegate && [_delegate respondsToSelector:@selector(goBackToStoreList)])
    {
        [_delegate goBackToStoreList];
    }
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        
        return [_campaignList count];
        
    }else if (section == 1)
    {
        
        return [_serviceList count];
        
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        
        return 106;
        
    }else if (indexPath.section == 1)
    {
        
        return 80;
        
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if ((section == 0) && !IsArrEmpty(_campaignList))
    {
        
        return 91;
        
    }else if((section == 1) && !IsArrEmpty(_serviceList))
    {
        
        return 34;
        
    }
    
    return 60;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!IsArrEmpty(_campaignList) && section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 91)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(10, 63, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_ActivityIng");
        [view addSubview:nameLabel];
        return  view;
        
    }else if (!IsArrEmpty(_serviceList) && section == 1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 34)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(10, 3, 250, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_ThisStoreProvidesService");
        [view addSubview:nameLabel];
        return view;
        
    }else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        return view;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
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
    else if (indexPath.section == 1)
    {
        
        static NSString  *allCityServiceListCell = @"allCityServiceListCell";
        
        AllCityServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityServiceListCell];
        
        if (!cell) {
            
            cell = [[AllCityServiceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityServiceListCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.topView.frame = CGRectMake(10, 0, 300, 1);
        
        cell.bottomView.frame = CGRectMake(10, 70 - 3, 300, 3);
        
        cell.centerView.frame = CGRectMake(10, 1, 300, 70 - 3);
        
        cell.imgView.frame = CGRectMake(20, 70/2 - 22.5, 45, 45);
        
        cell.serviceLbl.frame = CGRectMake(80, 70/2 - 22.5, cell.width*2/3-12, 15);
        
        cell.contentLbl.frame = CGRectMake(80, 20, 220, 50);
        
        [cell setItem:[_serviceList objectAtIndex:indexPath.row]];
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(gotoCampaignView:)])
        {
            StoreCampaignDTO *dto = [_campaignList objectAtIndex:indexPath.row];
            
            [_delegate gotoCampaignView:dto];
        }
        
    }

}

@end
