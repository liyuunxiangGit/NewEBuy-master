//
//  NearbySuningShopListView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-1.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityStoreListView.h"

@implementation AllCityStoreListView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self)
    {
        self.owner = owner;
        
        self.groupTableView.dataSource = self;
        
        self.groupTableView.delegate = self;
        
        self.goodStoreList = [[NSMutableArray alloc]init];
        
        self.otherStoreList = [[NSMutableArray alloc]init];
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    return self;
}

- (void)dealloc
{    
    TT_RELEASE_SAFELY(_goodStoreList);
    TT_RELEASE_SAFELY(_otherStoreList);
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
        
        return [_goodStoreList count];
        
    }else if (section == 1)
    {

        return [_otherStoreList count];
    
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
        SuningStoreDTO *dto = [_goodStoreList objectAtIndex:indexPath.row];
        
        return [AllCityStoreListCell heightOfCell:dto];
        
    }else if (indexPath.section == 1)
    {
        SuningStoreDTO *dto = [_otherStoreList objectAtIndex:indexPath.row];
        
        return [AllCityStoreListCell heightOfCell:dto];
        
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if ((section == 0) && !IsArrEmpty(_goodStoreList))
    {
        
        return 48;
        
    }else if((section == 1) && !IsArrEmpty(_otherStoreList))
    {
        
        return 40;
    
    }
    
    return 1;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!IsArrEmpty(_goodStoreList) && section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(16, 14, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_GoodStoreRecommend");
        [view addSubview:nameLabel];
        return  view;
        
    }else if (!IsArrEmpty(_otherStoreList) && section == 1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(16, 10, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_AllCityStore");
        [view addSubview:nameLabel];
        return view;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString  *allCityStoreListCellIdentifier = @"allCityStoreListCellIdentifier";
        
    AllCityStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityStoreListCellIdentifier];
        
    if (!cell) {
        cell = [[AllCityStoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityStoreListCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.delegate = self.owner;
    }
    if (indexPath.section == 0){
        cell.backView.image = [UIImage imageNamed:@"suning_bg_tjmendian.png"];
        cell.collectHeart.image = [UIImage imageNamed:@"icon-like-orange.png"];
        [cell setItem:[_goodStoreList objectAtIndex:indexPath.row]];
    }
    else if (indexPath.section == 1){
        cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
        cell.collectHeart.image = [UIImage imageNamed:@"icon-like-blue.png"];
        [cell setItem:[_otherStoreList objectAtIndex:indexPath.row]];
    }
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
        
    SuningStoreDTO *dto = [[SuningStoreDTO alloc]init];
    
    if (indexPath.section == 0)
    {
        
        dto = [_goodStoreList objectAtIndex:indexPath.row];
        
    }
    else if (indexPath.section == 1)
    {
        
        dto = [_otherStoreList objectAtIndex:indexPath.row];
        
    }
        
    if(_delegate && [_delegate respondsToSelector:@selector(gotoDetailSuningStore:)])
    {
        
        [_delegate gotoDetailSuningStore:dto];
        
    }
    
}


@end
