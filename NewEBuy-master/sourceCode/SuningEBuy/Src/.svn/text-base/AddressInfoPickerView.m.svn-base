//
//  AddressInfoPickerView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AddressInfoPickerView.h"
#import "AddressInfoDAO.h"

@interface AddressInfoPickerView()
{
    BOOL   _isFirstSelect;  //用于判断是否是第一次加载
}

@property (nonatomic, strong) NSArray                           *provinceArray;
@property (nonatomic, strong) NSArray                           *cityArray;
@property (nonatomic, strong) NSArray                           *areaArray;
@property (nonatomic, strong) NSArray                           *townArray;

@property (nonatomic, strong) NSDictionary *provinceDic;
@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *districtDic;
@property (nonatomic, strong) NSDictionary *townDic;

- (void)setDefaultSelectedProvince;
- (void)setDefaultSelectedCity;
- (void)setDefaultSelectedDistrict;
- (void)setDefaultSelectedTown;

- (void)getProvinceRequest;
- (void)getCityRequest:(NSString *)provinceCode;
- (void)getDistrictRequest:(NSString *)cityCode;
- (void)getTownRequest:(NSString *)distCode;

//第一次选择城市
- (void)firstSelectDidOk;

@end

/*********************************************************************/

@implementation AddressInfoPickerView

@synthesize service = _service;
@synthesize baseAddressInfo = _baseAddressInfo;
@synthesize selectAddressInfo = _selectAddressInfo;
@synthesize addressDelegate = _addressDelegate;

@synthesize provinceArray = _provinceArray;
@synthesize cityArray = _cityArray;
@synthesize areaArray = _areaArray;
@synthesize townArray = _townArray;

- (void)dealloc {
    
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_baseAddressInfo);
    TT_RELEASE_SAFELY(_selectAddressInfo);
    
    TT_RELEASE_SAFELY(_provinceArray);
    TT_RELEASE_SAFELY(_cityArray);
    TT_RELEASE_SAFELY(_areaArray);
    TT_RELEASE_SAFELY(_townArray);
    
}

- (id)initWithBaseAddressInfo:(AddressInfoDTO *)baseAddress
                 compentCount:(AddressPickerViewCompentCount)count
{
    self = [super init];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.baseAddressInfo = baseAddress;
        NSAssert((count==2||count==3||count==4), @"compentCount error");
        _compentCount = count;
        self.showsSelectionIndicator = YES;
        [self reloadAddressData];
    }
    return self;
}

- (void)setBaseAddressInfo:(AddressInfoDTO *)baseAddressInfo
{
    if (_selectAddressInfo)
    {
        BOOL needReload = NO;
        
        if (_selectAddressInfo.province.length && ![_selectAddressInfo.province isEqualToString:baseAddressInfo.province]) {
            needReload = YES;
        }
        
        if (_compentCount >= 3 && _selectAddressInfo.city.length && ![_selectAddressInfo.city isEqualToString:baseAddressInfo.city]) {
            needReload = YES;
        }
        
        if (_compentCount >=4 && _selectAddressInfo.district.length && ![_selectAddressInfo.district isEqualToString:baseAddressInfo.district]) {
            needReload = YES;
        }
        
        if (needReload) {
            [self reloadAddressData];
        }
    }
    else
    {
        _baseAddressInfo = baseAddressInfo;
    }
}

- (void)setCompentCount:(AddressPickerViewCompentCount)compentCount
{
    if (_compentCount != compentCount) {
        _compentCount = compentCount;
        [self reloadAllComponents];
        [self reloadAddressData];
    }
}

- (void)setDelegate:(id<UIPickerViewDelegate>)delegate
{
    [super setDelegate:self];
}

- (void)setDataSource:(id<UIPickerViewDataSource>)dataSource
{
    [super setDataSource:self];
}

- (AddressInfoService *)service
{
    if (!_service) {
        _service = [[AddressInfoService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (AddressInfoDTO *)selectAddressInfo
{
    if (!_selectAddressInfo) {
        _selectAddressInfo = [[AddressInfoDTO alloc] init];
    }
    return _selectAddressInfo;
}

- (BOOL)isLoadProvincesOk
{
    return _isLoadProvinceOk;
}

#pragma mark -
#pragma mark setters



#pragma mark -
#pragma mark reload data

- (void)reloadAddressData
{
    self.selectAddressInfo = nil;
    self.provinceArray = nil; self.provinceDic = nil;
    self.cityArray = nil; self.cityDic = nil;
    self.areaArray = nil; self.districtDic = nil;
    self.townArray = nil; self.townDic = nil;
    
    [self.service cancelHttpRequest];
    
    _isFirstSelect = YES;
    
    if ([AddressInfoDAO isUpdateAddressOk]) {
        
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        self.provinceArray = [dao getAllProvince];
        NSMutableDictionary *provinceDic = [[NSMutableDictionary alloc] initWithCapacity:[self.provinceArray count]];
        int index = 0;
        for (AddressInfoDTO *provinceDTO in self.provinceArray) {
            [provinceDic setObject:@{@"dto": provinceDTO,
                                     @"index": @(index)}
                            forKey:provinceDTO.province];
            index++;
        }
        self.provinceDic = [provinceDic copy];
        TT_RELEASE_SAFELY(dao);
        _isLoadProvinceOk = YES;
        [self reloadComponent:0];
        [self setDefaultSelectedProvince];
    }else{
        [self getProvinceRequest];
    }
}


#pragma mark -
#pragma mark default select

- (void)firstSelectDidOk
{
    if (_isFirstSelect)
    {
        //异步提交任务，等待主线程当前事务设置完成
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_addressDelegate &&
                [_addressDelegate respondsToSelector:@selector(addressPickerLoadDataOkWithSelectInfo:)])
            {
                [_addressDelegate addressPickerLoadDataOkWithSelectInfo:self.selectAddressInfo];
            }
        });

        _isFirstSelect = NO;
    }
}


- (void)setDefaultSelected
{
    [self setDefaultSelectedProvince];
    [self setDefaultSelectedCity];
    
    if (_compentCount >= 3)
    {
        [self setDefaultSelectedDistrict];
    }
    
    if (_compentCount >= 4)
    {
        [self setDefaultSelectedTown];
    }
}

- (void)setDefaultSelectedProvince
{
    NSString *selectProvince = self.baseAddressInfo.province;
    NSInteger selectRow = 0;
    if (selectProvince.trim.length && self.provinceDic && [self.provinceDic count] > 0)
    {
        NSDictionary *infoDic = [self.provinceDic objectForKey:selectProvince];
        selectRow = [infoDic[@"index"] integerValue];
    }
    else if (self.provinceArray && [self.provinceArray count] > 0)
    {
        self.selectAddressInfo.province = [[self.provinceArray objectAtIndex:0] province];
        self.selectAddressInfo.provinceContent = [[self.provinceArray objectAtIndex:0] provinceContent];
        selectRow = 0;
    }
    [self selectRow:selectRow inComponent:0 animated:NO];
    [self pickerView:self didSelectRow:selectRow inComponent:0];
}

- (void)setDefaultSelectedCity
{
    NSString *selectCity = self.baseAddressInfo.city;
    NSInteger selectRow = 0;
    if (selectCity.trim.length && self.cityDic && [self.cityDic count] > 0)
    {
        NSDictionary *infoDic = [self.cityDic objectForKey:selectCity];
        selectRow = [infoDic[@"index"] integerValue];
    }
    else if (self.cityArray && [self.cityArray count] > 0)
    {
        self.selectAddressInfo.city = [[self.cityArray objectAtIndex:0] city];
        self.selectAddressInfo.cityContent = [[self.cityArray objectAtIndex:0] cityContent];
        selectRow = 0;
    }
    
    [self selectRow:selectRow inComponent:1 animated:NO];
    [self pickerView:self didSelectRow:selectRow inComponent:1];
    
    if (_compentCount == 2) {
        [self firstSelectDidOk];
    }
}

- (void)setDefaultSelectedDistrict
{
    NSString *selectDistrict = self.baseAddressInfo.district;
    NSInteger selectRow = 0;
    if (selectDistrict.trim.length && self.districtDic && [self.districtDic count] > 0)
    {
        NSDictionary *infoDic = [self.districtDic objectForKey:selectDistrict];
        selectRow = [infoDic[@"index"] integerValue];
    }
    else if (self.areaArray && [self.areaArray count] > 0)
    {
        self.selectAddressInfo.district = [[self.areaArray objectAtIndex:0] district];
        self.selectAddressInfo.districtContent = [[self.areaArray objectAtIndex:0] districtContent];
        selectRow = 0;
    }
    [self selectRow:selectRow inComponent:2 animated:NO];
    [self pickerView:self didSelectRow:selectRow inComponent:2];
    
    if (_compentCount == 3)
    {
        [self firstSelectDidOk];
    }
}

- (void)setDefaultSelectedTown
{
    NSString *selectTown = self.baseAddressInfo.town;
    NSInteger selectRow = 0;
    if (selectTown.trim.length && self.townDic && [self.townDic count] > 0)
    {
        NSDictionary *infoDic = [self.townDic objectForKey:selectTown];
        selectRow = [infoDic[@"index"] integerValue];
    }
    else if (self.townArray && [self.townArray count] > 0)
    {
        self.selectAddressInfo.town = [[self.townArray objectAtIndex:0] town];
        self.selectAddressInfo.townContent = [[self.townArray objectAtIndex:0] townContent];
        selectRow = 0;
    }
    
    [self selectRow:selectRow inComponent:3 animated:NO];
    [self pickerView:self didSelectRow:selectRow inComponent:3];
    
    [self firstSelectDidOk];
}

#pragma mark -
#pragma mark request

- (void)getProvinceRequest
{
    [self.service cancelHttpRequest];
    [self.service beginGetProvinceList];
}

- (void)getCityRequest:(NSString *)provinceCode
{
    [self.service cancelHttpRequest];
    [self.service beginGetCityListByProvinceCode:provinceCode];
}

- (void)getDistrictRequest:(NSString *)cityCode
{
    [self.service cancelHttpRequest];
    [self.service beginGetDistrictListByCityCode:cityCode];
}

- (void)getTownRequest:(NSString *)distCode
{
    [self.service cancelHttpRequest];
    [self.service beginGetTownListByDistrictCode:distCode];
}

#pragma mark -
#pragma mark service delegate

- (void)getProvinceListCompletionWithResult:(BOOL)isSuccess provinceList:(NSArray *)list
{
    if (isSuccess) {
        self.provinceArray = list;
        self.provinceDic = self.service.provinceDic;
        _isLoadProvinceOk = YES;
        [self reloadComponent:0];
        [self setDefaultSelectedProvince];
    }else{
        [self getProvinceRequest];
    }
}

- (void)getCityListCompletionWithResult:(BOOL)isSuccess cityList:(NSArray *)list
{
    if (isSuccess) {
        self.cityArray = list;
        self.cityDic = self.service.cityDic;
        [self reloadComponent:1];
        [self setDefaultSelectedCity];
    }else{
        [self getCityRequest:self.selectAddressInfo.province];
    }
}

- (void)getDistrictListCompletionWithResult:(BOOL)isSuccess districtList:(NSArray *)list
{
    if (isSuccess) {
        self.areaArray = list;
        self.districtDic = self.service.districtDic;
        if (_compentCount >= 3){
            [self reloadComponent:2];
            [self setDefaultSelectedDistrict];
        }
        
    }else{
        [self getDistrictRequest:self.selectAddressInfo.city];
    }
}

- (void)getTownListCompletionWithResult:(BOOL)isSuccess townList:(NSArray *)list
{
    if (isSuccess) {
        self.townArray = list;
        self.townDic = self.service.townDic;
        [self reloadComponent:3];
        [self setDefaultSelectedTown];
    }else{
        [self getTownRequest:self.selectAddressInfo.district];
    }
}


#pragma mark -
#pragma mark picker view data source and delegate

- (CGFloat)computePickerViewComponentWidth
{
    switch (_compentCount) {
        case AddressPickerViewCompentTwo:
        {
            return 130.0f;
            break;
        }
        case AddressPickerViewCompentThree:
        {
            return 90.0f;
            break;
        }
        case AddressPickerViewCompentFour:
        {
            return 65.0f;
            break;
        }
        default:
            break;
    }
    return 65.0f;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _compentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    __block NSInteger rows = 0;
    switch (component) {
        case 0:
        {
            rows = [self.provinceArray count];
            break;
        }
        case 1:
        {
            rows = [self.cityArray count];
            break;
        }
        case 2:
        {
            rows = [self.areaArray count];
            break;
        }
        case 3:
        {
            rows = [self.townArray count];
            break;
        }
        default:
            break;
    }
    
    //ios6崩溃兼容，崩溃信息：
    //*** Assertion failure in -[UITableViewRowData rectForRow:inSection:],
    // /SourceCache/UIKit/UIKit-2372/UITableViewRowData.m:1630
    // http://stackoverflow.com/questions/12672318/assertion-failure-on-picker-view
    if (IOS6_OR_LATER) {
        return rows <= 0 ? 1 : rows;
    }
    
    return rows;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat rowWidth = 65.0;
    switch (component)
    {
        case 0:
            rowWidth = [self computePickerViewComponentWidth];
            break;
        case 1:
            rowWidth = [self computePickerViewComponentWidth];
            break;
        case 2:
            rowWidth = [self computePickerViewComponentWidth];
            break;
        case 3:
            rowWidth = 90.0;
            break;
        default:
            break;
    }
    
    return rowWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    __block NSString *titleName = nil;
    
    switch (component) {
        case 0:
        {
            if ([_provinceArray count] > row) {
                AddressInfoDTO *provinceDto = (AddressInfoDTO *)[self.provinceArray objectAtIndex:row];
                titleName = [provinceDto provinceContent];
            }
            break;
        }
        case 1:
        {
            if ([_cityArray count] > row) {
                AddressInfoDTO *cityDto = (AddressInfoDTO *)[self.cityArray objectAtIndex:row];
                titleName = [cityDto cityContent];
            }
            break;
        }
        case 2:
        {
            if ([_areaArray count] > row) {
                AddressInfoDTO *areaDto = (AddressInfoDTO *)[self.areaArray objectAtIndex:row];
                titleName = [areaDto districtContent];
            }
            break;
        }
        case 3:
        {
            if ([_townArray count] > row) {
                AddressInfoDTO *townDto = (AddressInfoDTO *)[self.townArray objectAtIndex:row];
                titleName = [townDto townContent];
            }
            break;
        }
        default:
            break;
    }
    UILabel *retval = (UILabel *)view;
    
    if (!retval)
    {
        CGRect frame = CGRectMake(0, 0, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height);
        
        retval = [[UILabel alloc] initWithFrame:frame];
        retval.adjustsFontSizeToFitWidth = YES;
        retval.backgroundColor = [UIColor clearColor];
        retval.textAlignment = UITextAlignmentCenter;
        if (_compentCount==2) {
            retval.font = [UIFont boldSystemFontOfSize:20.0];
        }
    }
    retval.text = titleName;
    return retval;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row < 0) {
        return;
    }
    
    switch (component)
    {
        case 0:
        {
            NSUInteger count = 0;
            NSString *selectedProvinceCode = nil;
            NSString *selectedProvinceContent = nil;
            count = [self.provinceArray count];
            if (row < count)
            {
                selectedProvinceCode =
                [(AddressInfoDTO *)[self.provinceArray objectAtIndex:row] province];
                selectedProvinceContent =
                [(AddressInfoDTO *)[self.provinceArray objectAtIndex:row] provinceContent];
            }
            
            if (row >= count)
            {
                return;
            }
            
            self.selectAddressInfo.province = selectedProvinceCode;
            self.selectAddressInfo.provinceContent = selectedProvinceContent;
            
            //开始清除省后面的市、区、镇的操作。
            if (_compentCount >= 2)
            {
                self.selectAddressInfo.city = nil;
                self.selectAddressInfo.cityContent = nil;
                
                //刷新新的城市列表
                if ([AddressInfoDAO isUpdateAddressOk])
                {
                    AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                    self.cityArray = [dao getCityByProvinceCode:self.selectAddressInfo.province];
                    NSMutableDictionary *cityDic = [[NSMutableDictionary alloc] initWithCapacity:[self.cityArray count]];
                    NSUInteger index = 0;
                    for (AddressInfoDTO *cityDTO in self.cityArray) {
                        [cityDic setObject:@{@"dto": cityDTO,
                                             @"index": @(index)}
                                    forKey:cityDTO.city];
                        index ++;
                    }
                    self.cityDic = [cityDic copy];
                    [self reloadComponent:1];
                    [self setDefaultSelectedCity];
                }
                else
                {
                    self.cityArray = nil;
                    self.cityDic = nil;
                    [self reloadComponent:1];
                    [self getCityRequest:selectedProvinceCode];
                }
                
            }
            
            if (_compentCount >= 3)
            {
                self.selectAddressInfo.district = nil;
                self.selectAddressInfo.districtContent = nil;
                self.areaArray = nil;
                self.districtDic = nil;
                [self reloadComponent:2];
            }
            
            if (_compentCount >= 4)
            {
                self.selectAddressInfo.town = nil;
                self.selectAddressInfo.townContent = nil;
                self.townArray = nil;
                [self reloadComponent:3];
            }
            //结束操作
            
            break;
        }
        case 1:
        {
            NSUInteger count = 0;
            NSString *selectedCityCode = nil;
            NSString *selectedCityContent = nil;
            count = [self.cityArray count];
            if (row < count) {
                selectedCityCode =
                [(AddressInfoDTO *)[self.cityArray objectAtIndex:row] city];
                selectedCityContent =
                [(AddressInfoDTO *)[self.cityArray objectAtIndex:row] cityContent];
            }
            if (row >= count)
            {
                return;
            }
            
            self.selectAddressInfo.city = selectedCityCode;
            self.selectAddressInfo.cityContent = selectedCityContent;
            
            //清空区列表和镇列表
            if (_compentCount >= 3)
            {
                self.selectAddressInfo.district = nil;
                self.selectAddressInfo.districtContent = nil;
                self.areaArray = nil;
                self.districtDic = nil;
                [self reloadComponent:2];
                //开始获取新选择的城市下区列表
                [self getDistrictRequest:selectedCityCode];
            }
            
            if (_compentCount >= 4)
            {
                self.selectAddressInfo.town = nil;
                self.selectAddressInfo.townContent = nil;
                self.townArray = nil;
                self.townDic = nil;
                [self reloadComponent:3];
            }
            //完成清除
            
            break;
        }
        case 2:
        {
            NSUInteger count = 0;
            NSString *selectedAreaCode = nil;
            NSString *selectedAreaContent = nil;
            count = [self.areaArray count];
            if (row < count) {
                selectedAreaCode =
                [(AddressInfoDTO *)[self.areaArray objectAtIndex:row] district];
                selectedAreaContent =
                [(AddressInfoDTO *)[self.areaArray objectAtIndex:row] districtContent];
            }
            if (row >= count)
            {
                return;
            }
            self.selectAddressInfo.district = selectedAreaCode;
            self.selectAddressInfo.districtContent = selectedAreaContent;
            
            //清除镇列表, 并加载新的镇列表
            if (_compentCount >= 4)
            {
                self.townArray = nil;
                self.townDic = nil;
                self.selectAddressInfo.town = nil;
                self.selectAddressInfo.townContent = nil;
                [self reloadComponent:3];
                [self getTownRequest:selectedAreaCode];
            }
            break;
        }
        case 3:
        {
            NSUInteger count = 0;
            NSString *selectedTownCode = nil;
            NSString *selectedTownName = nil;
            count = [self.townArray count];
            if (row < count) {
                selectedTownCode = [(AddressInfoDTO *)[self.townArray objectAtIndex:row] town];
                selectedTownName = [(AddressInfoDTO *)[self.townArray objectAtIndex:row] townContent];
            }
            if (row >= count)
            {
                return;
            }
            self.selectAddressInfo.town = selectedTownCode;
            self.selectAddressInfo.townContent = selectedTownName;
        }
        default:
            break;
    }
    
}

@end
