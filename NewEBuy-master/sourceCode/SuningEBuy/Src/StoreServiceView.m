//
//  StoreServiceView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreServiceView.h"
#import "AllCityStoreListCell.h"
#import "AllCityServiceListCell.h"

@implementation StoreServiceView

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
    
    TT_RELEASE_SAFELY(_serviceDto);
    TT_RELEASE_SAFELY(_storeList);
    
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
    if (section == 0)
    {
        
        return 1;
        
    }else if (section == 1)
    {
        
        return [_storeList count];
        
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
        
        return 76;
        
    }else if (indexPath.section == 1)
    {
        
        SuningStoreDTO *dto = [_storeList objectAtIndex:indexPath.row];
        return [AllCityStoreListCell heightOfCell:dto];;
        
    }
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        
        return 43;
        
    }else if((section == 1)&&!IsArrEmpty(_storeList))
    {
        
        return 40;
        
    }
    
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 47)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(15, 12, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_ServiceInfo");
        [view addSubview:nameLabel];
        return  view;
        
    }else if (!IsArrEmpty(_storeList) && section == 1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 47)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(15, 12, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_YouCanEnjoyService");
        [view addSubview:nameLabel];
        return view;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        
        static NSString  *allCityServiceListCell = @"allCityServiceListCell";
        
        AllCityServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityServiceListCell];
        
        if (!cell) {
            
            cell = [[AllCityServiceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityServiceListCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.topView.frame = CGRectMake(10, 0, 300, 1);
        
        cell.bottomView.frame = CGRectMake(10, 76 - 3, 300, 3);
        
        cell.centerView.frame = CGRectMake(10, 1, 300, 76 - 3);
        
        cell.imgView.frame = CGRectMake(20, 76/2 - 22.5, 45, 45);
        
        cell.serviceLbl.frame = CGRectMake(80, 76/2 - 22.5, cell.width*2/3-12, 15);
        
        cell.contentLbl.frame = CGRectMake(80, 22, 220, 50);
        
        [cell setItem:self.serviceDto];
        
        return cell;
        
    }
    else if (indexPath.section == 1)
    {
        
        static NSString  *allCityStoreListCellIdentifier = @"allCityStoreListCellIdentifier";
        
        AllCityStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityStoreListCellIdentifier];
        
        if (!cell) {
            
            cell = [[AllCityStoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityStoreListCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
        
        [cell setItem:[_storeList objectAtIndex:indexPath.row]];
        
//        [cell.collectBtn setHidden:YES];
        
        return cell;

    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SuningStoreDTO *dto = [[SuningStoreDTO alloc]init];
    
    if (indexPath.section == 0)
    {
        
        
    }
    else if (indexPath.section == 1)
    {
        
        dto = [_storeList objectAtIndex:indexPath.row];
        
        if(_delegate && [_delegate respondsToSelector:@selector(gotoDetailSuningStore:)])
        {
        
            [_delegate gotoDetailSuningStore:dto];
        
        }
    }
    
}


@end
