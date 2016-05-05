//
//  NearbySuningShopListView.m
//  SuningEBuy
//
//  Created by Kristopher on 14-8-1.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearbySpotStoreListView.h"

@implementation NearbySpotStoreListView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self)
    {
        self.owner = owner;
        
        self.groupTableView.dataSource = self;
        
        self.groupTableView.delegate = self;
        
        self.storeList = nil;
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    return self;
}

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_storeList);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.groupTableView.frame =self.frame;
    
    [self addSubview:self.groupTableView];
    
}

- (void)setStoreList:(NSMutableArray *)storeList{
    if (!(storeList&&[storeList count]>0)) {
        _storeList = [[NSMutableArray alloc] initWithCapacity:0];
    }else{
        _storeList = storeList;
    }
    [self.groupTableView reloadData];
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_storeList count];
        
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearbySpotStoreDTO *dto = [_storeList objectAtIndex:indexPath.row];
        
    return [NearbySpotStoreCell heightOfCell:dto.storeAddress];
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString  *allCityStoreListCellIdentifier = @"nearbySpotStoreListCellIdentifier";
        
    NearbySpotStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityStoreListCellIdentifier];
        
    if (!cell) {
            
        cell = [[NearbySpotStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityStoreListCellIdentifier];
            
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self.owner;
            
    }
    
    cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
    
    [cell setItem:[_storeList objectAtIndex:indexPath.row]];
    
    return cell;
    
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
        
    NearbySpotStoreDTO *dto = [_storeList objectAtIndex:indexPath.row];
        
    if(_delegate && [_delegate respondsToSelector:@selector(gotoShopCartWithPickupStoreInfo:)])
    {
        [_delegate gotoShopCartWithPickupStoreInfo:dto];
        
    }
    
}


@end
