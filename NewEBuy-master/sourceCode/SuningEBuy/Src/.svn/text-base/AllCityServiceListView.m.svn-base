//
//  AllCityServiceListView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityServiceListView.h"
#import "AllCityServiceListCell.h"

@implementation AllCityServiceListView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self)
    {
        self.owner = owner;
        self.groupTableView.dataSource = self;
        self.groupTableView.delegate = self;
        self.backgroundColor = [UIColor uiviewBackGroundColor];
        self.topServiceList = [[NSMutableArray alloc]init];
        self.otherServiceList = [[NSMutableArray alloc]init];
        self.tagList.hidden = NO;
        [self.tagList setAutomaticResize:YES];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_topServiceList);
    TT_RELEASE_SAFELY(_otherServiceList);    
    TT_RELEASE_SAFELY(_tagList);
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

//城市无服务，显示选择城市button
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
        label.text = L(@"NearbySuning_NoServiceGoToNearCity");
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

-(DWTagList *)tagList
{
    if (!_tagList){
        _tagList=[[DWTagList alloc] init];
        _tagList.tagDelegate = self;
        _tagList.frame = CGRectMake(10, 0, 300, 300);
        //        _tagList.switchHotKeyButtonView.frame = CGRectMake(-20, 300, 320, 36);
        [_tagList.fontArray removeAllObjects];
        [_tagList.fontArray addObject:[UIFont systemFontOfSize:12]];
        //        [_tagList.switchHotKeyButtonView removeAllSubviews];
    }
    return _tagList;
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_topServiceList count];
        
    }else if (section == 1)
    {
        return 1;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        
        return 76;
        
    }else if(indexPath.section==1)
    {

        return 300;

    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if ((section == 0) && !IsArrEmpty(_topServiceList))
    {
        
        return 45;
        
    }
    else if(section == 1)
    {
        
        return 44;
        
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!IsArrEmpty(_topServiceList) && section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(15, 12, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_HotService");
        [view addSubview:nameLabel];
        return  view;
        
    }else if (section == 1 && !IsArrEmpty(_otherServiceList)) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(15, 12, 250, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        nameLabel.text = L(@"NearbySuning_MoreServiceAndHeart");
        [view addSubview:nameLabel];
        return view;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0){
        static NSString  *allCityServiceListCell = @"allCityServiceListCell";
        AllCityServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityServiceListCell];
        if (!cell) {
            cell = [[AllCityServiceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityServiceListCell];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        cell.centerView.frame = CGRectMake(0, 0, 320, 75);
        cell.line.frame = CGRectMake(0, 76 - 1, 320, 1);
        cell.imgView.frame = CGRectMake(15, 76/2 - 22.5, 45, 45);
        cell.arrowView.frame = CGRectMake(300, 76/2 - 6, 6, 12);
        cell.serviceLbl.frame = CGRectMake(75, 76/2 - 22.5, cell.width*2/3-12, 15);
        cell.contentLbl.frame = CGRectMake(75, 24, 195, 50);
        [cell setItem:[_topServiceList objectAtIndex:indexPath.row]];
        return cell;
        
    }else if (indexPath.section==1){
        static NSString  *tagListCell = @"tagListCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagListCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagListCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:self.tagList];
        }
        [self.tagList displayWithAnimation:YES];
        for (DWTagView *subview in [_tagList subviews]){
            if ([subview isKindOfClass:[DWTagView class]]){
                subview.button.backgroundColor = [UIColor whiteColor];
                subview.layer.borderWidth = 1.0;
                subview.layer.borderColor = [UIColor colorWithRGBHex:0xDCDCDC].CGColor;
            }
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section==1)
    {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        view.backgroundColor =[UIColor clearColor];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        StoreServiceDTO *dto = [_topServiceList objectAtIndex:indexPath.row];
        
        if(_delegate && [_delegate respondsToSelector:@selector(gotoStoreService:)])
        {
            [_delegate gotoStoreService:dto];
        }
        
    }
    
}

- (void)switchHotKeywords
{
    

}

- (void)selectedTag:(NSString *)tagName
{
    if(_delegate && [_delegate respondsToSelector:@selector(gotoStoreService:)])
    {
        StoreServiceDTO *dto = [self getServiceDto:tagName];
        
        [_delegate gotoStoreService:dto];
    }
    
}

- (StoreServiceDTO *)getServiceDto:(NSString *)tagName
{
    if (!IsArrEmpty(_otherServiceList))
    {
        for (StoreServiceDTO *dto in self.otherServiceList)
        {
            if ([dto.serviceName isEqualToString:tagName])
                return dto;
        }
    }
    
    return nil;
}

@end
