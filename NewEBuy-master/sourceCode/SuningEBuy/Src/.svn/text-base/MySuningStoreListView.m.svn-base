//
//  MySuningStoreListView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "MySuningStoreListView.h"

@implementation MySuningStoreListView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self){
        _favouriteStoreList = [[NSMutableArray alloc]init];
        _goodStoreList = [[NSMutableArray alloc]init];
        _allStoreList = [[NSMutableArray alloc]init];
        self.owner = owner;
        self.groupTableView.dataSource = self;
        self.groupTableView.delegate = self;
        self.backgroundColor = [UIColor uiviewBackGroundColor];        
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_goodStoreList);
    TT_RELEASE_SAFELY(_favouriteStoreList);
    TT_RELEASE_SAFELY(_allStoreList);
    TT_RELEASE_SAFELY(_cityPickerView);
    TT_RELEASE_SAFELY(_selectCityButton);
    TT_RELEASE_SAFELY(_noDataView);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.groupTableView.frame =self.frame;
    [self addSubview:self.groupTableView];
    [self addSubview:self.noDataView];
}

//城市无门店，显示选择城市button
- (ToolBarButton *)selectCityButton
{
    if (!_selectCityButton){
        _selectCityButton = [[ToolBarButton alloc] init];
        _selectCityButton.delegate = self;
        _selectCityButton.frame = CGRectMake(50, 275, 220, 40);
        [_selectCityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectCityButton.backgroundColor = [UIColor clearColor];
        _selectCityButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_selectCityButton setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_default.png"] forState:UIControlStateNormal];
        [_selectCityButton setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_pressed.png"] forState:UIControlStateHighlighted];
        [_selectCityButton setTitle:L(@"NearbySuning_SelectNearbyCity") forState:UIControlStateNormal];
        [_selectCityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectCityButton.inputView = self.cityPickerView;
    }
    return _selectCityButton;
}

- (AddressInfoPickerView *)cityPickerView
{
    if (!_cityPickerView){
        AddressInfoDTO *address = [[AddressInfoDTO alloc] init];
        address.province = [Config currentConfig].defaultProvince;
        address.city = [Config currentConfig].defaultCity;
        _cityPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        _cityPickerView.showsSelectionIndicator = YES;
        _cityPickerView.addressDelegate = self;
    }
    return _cityPickerView;
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
        label.text = L(@"NearbySuning_GoToNearCity");
        label.textAlignment = UITextAlignmentCenter;
        [_noDataView addSubview:label];
        [_noDataView addSubview:self.selectCityButton];
        [_noDataView setHidden:YES];
    }
    return _noDataView;
}

#pragma mark -
#pragma mark tool bar cell delegate

- (void)doneButtonClicked:(id)sender
{
    AddressInfoDTO *selectInfo = self.cityPickerView.selectAddressInfo;
    if (selectInfo.province == nil || selectInfo.city == nil){
        return;
    }
    [Config currentConfig].nearByCityName = self.cityPickerView.selectAddressInfo.cityContent;
    [Config currentConfig].nearByCityId = selectInfo.city;
    
    if(_delegate && [_delegate respondsToSelector:@selector(showCityList)]){
        [_delegate showCityList];
    }
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        if (!IsArrEmpty(_favouriteStoreList))
        {
        
            return _favouriteStoreList.count;
        
        }
        else if (!IsArrEmpty(_goodStoreList))
        {
        
            return _goodStoreList.count;
        
        }
        else
        {
        
            return _allStoreList.count;
        
        }
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
        if (IsArrEmpty(_favouriteStoreList))
        {
            return 203;
        }
        else
        {
            return 1;
        }
    }
    else if (indexPath.section == 1)
    {
        SuningStoreDTO *dto = [[SuningStoreDTO alloc]init];
    
        if (!IsArrEmpty(_favouriteStoreList))
        {
            dto = [_favouriteStoreList objectAtIndex:indexPath.row];
        
        }
        else if (!IsArrEmpty(_goodStoreList))
        {
        
            dto = [_goodStoreList objectAtIndex:indexPath.row];
        
        }
        else
        {
        
            dto = [_allStoreList objectAtIndex:indexPath.row];
        
        }
    
        return [AllCityStoreListCell heightOfCell:dto];
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        if (!IsArrEmpty(_favouriteStoreList))
        {
            return 15;
        }
        else
        {
            return 1;
        }
    }
    else if (section == 1)
    {
        if (!IsArrEmpty(_favouriteStoreList))
        {
            return 1;
        }
        else
        {
            return 45;
        }
    }
    
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (IsArrEmpty(_favouriteStoreList) && section == 1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        
        nameLabel.backgroundColor = [UIColor clearColor];
        
        nameLabel.frame = CGRectMake(15, 45 - 28, 200, 20);
        
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        
        nameLabel.text = L(@"NearbySuning_GoodStoreRecommend");
        
        [view addSubview:nameLabel];
        
        return view;
        
    }
    else if (!IsArrEmpty(_favouriteStoreList) && section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 16)];
        
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
        return view;
    }
    else if (IsArrEmpty(_favouriteStoreList) && section == 0)
    {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
        return view;
        
    }
    else if (!IsArrEmpty(_favouriteStoreList) && section == 1)
    {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
        return view;
        
    }
    
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        if (IsArrEmpty(_favouriteStoreList)){
            static NSString  *headerCellIdentifier = @"headerCellIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 203)];
            view.backgroundColor = [UIColor uiviewBackGroundColor];
            
            UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suning_image_tixing.png"]];
            imgView.frame = CGRectMake(81, 15, 150, 135);
            [view addSubview:imgView];
        
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont boldSystemFontOfSize:15];
            label.backgroundColor = [UIColor clearColor];
            label.frame = CGRectMake(64, 165, 260, 20);
            label.numberOfLines = 0;
            label.textColor = [UIColor colorWithRGBHex:0x707070];
            label.text = L(@"NearbySuning_CollectStoreYouLike");
            label.textAlignment = UITextAlignmentLeft;
            [view addSubview:label];
            
            [cell.contentView removeAllSubviews];
            [cell.contentView addSubview:view];
            return cell;
            
        }else{
            static NSString  *headerCellIdentifier = @"headerCellIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
            view.backgroundColor = [UIColor uiviewBackGroundColor];
            
            [cell.contentView removeAllSubviews];
            [cell.contentView addSubview:view];
            return cell;
        }
    }else if (indexPath.section == 1){
        static NSString  *allCityStoreListCellIdentifier = @"allCityStoreListCellIdentifier";    
        AllCityStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityStoreListCellIdentifier];
        if (!cell) {
            cell = [[AllCityStoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityStoreListCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.delegate = self.owner;
        }
    
        if (!IsArrEmpty(_favouriteStoreList))        {
            cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
            cell.collectHeart.image = [UIImage imageNamed:@"icon-like-blue.png"];
            [cell setItem:[_favouriteStoreList objectAtIndex:indexPath.row]];
            [cell.positionImage setHidden:YES];
            [cell.distanceLbl setHidden:YES];
            
        }else if (!IsArrEmpty(_goodStoreList)){
            cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
            cell.collectHeart.image = [UIImage imageNamed:@"icon-like-blue.png"];
            [cell setItem:[_goodStoreList objectAtIndex:indexPath.row]];
            [cell.positionImage setHidden:YES];
            [cell.distanceLbl setHidden:YES];
            
        }else{
            cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
            cell.collectHeart.image = [UIImage imageNamed:@"icon-like-blue.png"];
            [cell setItem:[_allStoreList objectAtIndex:indexPath.row]];
            [cell.positionImage setHidden:YES];
            [cell.distanceLbl setHidden:YES];
        }
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
    
    if (indexPath.section == 1)
    {
    
        SuningStoreDTO *dto = [[SuningStoreDTO alloc]init];
    
        if (!IsArrEmpty(_favouriteStoreList))
        {
        
            dto = [_favouriteStoreList objectAtIndex:indexPath.row];
        
        }
        else if (!IsArrEmpty(_goodStoreList))
        {
        
            dto = [_goodStoreList objectAtIndex:indexPath.row];
        
        }
        else
        {
        
            dto = [_allStoreList objectAtIndex:indexPath.row];
        
        }
    
        if(_delegate && [_delegate respondsToSelector:@selector(gotoDetailSuningStore:)])
        {
        
            [_delegate gotoDetailSuningStore:dto];
        
        }
    
    }
}


@end
