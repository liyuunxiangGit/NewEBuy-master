//
//  StoreMentionViewController.m
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "StoreMentionViewController.h"
#import "AddressInfoDAO.h"
#import "PayFlowUtil.h"
#import "ToolBarCell.h"
#import "AddressInfoPickerView.h"

@interface StoreMentionViewController() <AddressInfoPickerViewDelegate>

@property (nonatomic,strong) UIPickerView     *storePicker;         // 门店picker
@property (nonatomic,strong) ToolBarButton    *storeInfoBtn;        // 门店button
@property (nonatomic,strong) UITextField      *receiptNameFld;      // 收货人名称
@property (nonatomic,strong) UITextField      *receiptPhoneFld;     // 手机号码

@property (nonatomic,strong) AddressInfoPickerView *addressPicker;


- (void)sendDistrictHttpRequest;
- (void)sendStoreHttpRequest:(NSString *)district;

- (void)reloadPickerViewComponent0;
- (void)reloadPickerViewComponent1;

@end

/*********************************************************************/

@implementation StoreMentionViewController

@synthesize storeInfoDto = _storeInfoDto;
@synthesize delegate = _delegate;
@synthesize addressInfoService = _addressInfoService;
@synthesize storeInfoService = _storeInfoService;
@synthesize districtArr = _districtArr;
@synthesize storeInfoArr = _storeInfoArr;

@synthesize storePicker = _storePicker;
@synthesize storeInfoBtn = _storeInfoBtn;
@synthesize receiptNameFld = _receiptNameFld;
@synthesize receiptPhoneFld = _receiptPhoneFld;

- (void)dealloc {
    TT_RELEASE_SAFELY(_storeInfoDto);
    SERVICE_RELEASE_SAFELY(_addressInfoService);
    SERVICE_RELEASE_SAFELY(_storeInfoService);
    TT_RELEASE_SAFELY(_districtArr);
    TT_RELEASE_SAFELY(_storeInfoArr);
    
    TT_RELEASE_SAFELY(_storePicker);
    TT_RELEASE_SAFELY(_storeInfoBtn);
    TT_RELEASE_SAFELY(_receiptNameFld);
    TT_RELEASE_SAFELY(_receiptPhoneFld);
    
    _addressPicker.addressDelegate = nil;
}

- (id)initWithStoreInfo:(StoreInfoDto *)dto
{
    self = [super init];
    if (self)
    {
        self.title = L(@"store mention");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"shopProcess_shop_storeChoice"),self.title];
        
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] 
//                                      initWithTitle:L(@"Done") 
//                                      style:UIBarButtonItemStylePlain 
//                                      target:self 
//                                      action:@selector(finishModifyMention:)];
//        self.navigationItem.rightBarButtonItem = rightItem;
//        TT_RELEASE_SAFELY(rightItem);
        
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTSave")];

        self.storeInfoDto = [dto copy];
        
        NSString *cityName = self.storeInfoDto.cityName;
        if ((!cityName || [cityName isEmptyOrWhitespace]) && [AddressInfoDAO isUpdateAddressOk]) 
        {
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            AddressInfoDTO *dto = [dao getProvinceAndCityInfoByCityCode:self.storeInfoDto.cityId];
            
            self.storeInfoDto.provinceId = dto.province;
            self.storeInfoDto.provinceName = dto.provinceContent;
            self.storeInfoDto.cityId = dto.city;
            self.storeInfoDto.cityName = dto.cityContent;
            
            TT_RELEASE_SAFELY(dao);
        }
    }
    
    return self;
}

- (void)righBarClick
{
    [self finishModifyMention:nil];
}

#pragma mark -
#pragma mark view life

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
    frame.size.height = contentView.bounds.size.height - 44;
	
	self.groupTableView.frame = frame;
	   
	[self.view addSubview:self.groupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isDistrictListLoadOk) {
        [self sendDistrictHttpRequest];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark getters

- (AddressInfoService *)addressInfoService
{
    if (!_addressInfoService) {
        _addressInfoService = [[AddressInfoService alloc] init];
        _addressInfoService.delegate = self;
    }
    return _addressInfoService;
}

- (StoreInfoService *)storeInfoService
{
    if (!_storeInfoService) {
        _storeInfoService = [[StoreInfoService alloc] init];
        _storeInfoService.delegate = self;
    }
    return _storeInfoService;
}

- (UIPickerView *)storePicker
{
    if (!_storePicker)
    {
        _storePicker = [[UIPickerView alloc] init];
        _storePicker.delegate = self;
        _storePicker.dataSource = self;
        _storePicker.showsSelectionIndicator = YES;
    }
    return _storePicker;
}

- (UITextField *)receiptNameFld
{
    if (!_receiptNameFld)
    {
        _receiptNameFld = [[UITextField alloc] init];
        _receiptNameFld.frame = CGRectMake(80, 0, 180, 43);
        _receiptNameFld.borderStyle = UITextBorderStyleNone;
        _receiptNameFld.backgroundColor = [UIColor clearColor];
        _receiptNameFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _receiptNameFld.autocorrectionType = UITextAutocorrectionTypeNo;
        _receiptNameFld.keyboardType = UIKeyboardTypeDefault;
        _receiptNameFld.returnKeyType = UIReturnKeyDone;
        _receiptNameFld.textAlignment = UITextAlignmentLeft;
        _receiptNameFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        _receiptNameFld.font = [UIFont systemFontOfSize:17.0f];
        _receiptNameFld.delegate = self;
        _receiptNameFld.placeholder = L(@"required");
    }
    return _receiptNameFld;
}

- (UITextField *)receiptPhoneFld
{
    if (!_receiptPhoneFld)
    {
        _receiptPhoneFld = [[UITextField alloc] init];
        _receiptPhoneFld.frame = CGRectMake(80, 0, 180, 43);
        _receiptPhoneFld.borderStyle = UITextBorderStyleNone;
        _receiptPhoneFld.backgroundColor = [UIColor clearColor];
        _receiptPhoneFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _receiptPhoneFld.autocorrectionType = UITextAutocorrectionTypeNo;
        _receiptPhoneFld.keyboardType = UIKeyboardTypeNumberPad;
        _receiptPhoneFld.returnKeyType = UIReturnKeyDone;
        _receiptPhoneFld.textAlignment = UITextAlignmentLeft;
        _receiptPhoneFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        _receiptPhoneFld.font = [UIFont systemFontOfSize:17.0f];
        _receiptPhoneFld.delegate = self;
        _receiptPhoneFld.placeholder = L(@"eleven phone number");
    }
    return _receiptPhoneFld;
}

- (ToolBarButton *)storeInfoBtn
{
    if (!_storeInfoBtn) 
    {
        _storeInfoBtn = [[ToolBarButton alloc] init];
        _storeInfoBtn.frame = CGRectMake(18, 5, 320 - 18, 33);
//        _storeInfoBtn.nomalBgColor = RGBCOLOR(239, 239, 239);
//        _storeInfoBtn.activeBgColor = RGBCOLOR(254, 244, 156);
//        [_storeInfoBtn setBackgroundImage:[UIImage imageNamed:@"payment_ship_mode_btn.png"] forState:UIControlStateNormal];
//        [_storeInfoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -160, 0, 0)];
        [_storeInfoBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//        _storeInfoBtn.layer.borderWidth = 0.5f;
//        _storeInfoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _storeInfoBtn.layer.cornerRadius = 9;
//        _storeInfoBtn.layer.masksToBounds = YES;
        _storeInfoBtn.titleLabel.textAlignment = UITextAlignmentLeft;
        _storeInfoBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _storeInfoBtn.inputView = self.storePicker;
        _storeInfoBtn.delegate = self;
    }
    return _storeInfoBtn;
}

- (AddressInfoPickerView *)addressPicker
{
    if (!_addressPicker)
    {
        AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
        dto.province = self.storeInfoDto.provinceId;
        dto.city = self.storeInfoDto.cityId;
        _addressPicker = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:dto
                                                                   compentCount:AddressPickerViewCompentTwo];
        _addressPicker.addressDelegate = self;
    }
    return _addressPicker;
}

#pragma mark -
#pragma mark tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 3) {
        static NSString *toolbarIdentifier = @"toolbarIdentifier";
        
        ToolBarCell *cell = [tableView dequeueReusableCellWithIdentifier:toolbarIdentifier];
        if (cell == nil) {
            cell = [[ToolBarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:toolbarIdentifier inputView:self.storePicker];
            cell.toolBarDelegate = self;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (!self.storeInfoDto.storeName || !self.storeInfoDto.storeCode)
        {
            cell.textLabel.text = L(@"please choose store");
        }
        else
        {
            cell.textLabel.text = self.storeInfoDto.storeName;
        }
        return cell;
    }
    else if (row == 2) {
        static NSString *toolbarIdentifier = @"cityCell";
        
        ToolBarCell *cell = [tableView dequeueReusableCellWithIdentifier:toolbarIdentifier];
        if (cell == nil) {
            cell = [[ToolBarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:toolbarIdentifier inputView:self.addressPicker];
            cell.toolBarDelegate = self;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [PayFlowUtil generateStoreAreaInfo:self.storeInfoDto];
        
        return cell;
    }
    
    static NSString *SettlementIdentifier = @"CellIdentifier";
    UITableViewCell *cell = nil;
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:SettlementIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (row)
    {
        case 0:
        {    // 收货人
            cell.textLabel.text = [NSString stringWithFormat:@"%@:",L(@"LBName")];
            self.receiptNameFld.text = self.storeInfoDto.receiptName;
            [cell.contentView addSubview:self.receiptNameFld];
            break;
        }
        case 1:
        {    // 手机号码
            cell.textLabel.text = [NSString stringWithFormat:@"%@:",L(@"LBMobilePhone")];
            self.receiptPhoneFld.text = self.storeInfoDto.receiptPhone;
            [cell.contentView addSubview:self.receiptPhoneFld];
            
            break;
        }
        case 2:{    // 自提门店
                UILabel *_rightTextLbl = [[UILabel alloc] init];
                _rightTextLbl.frame = CGRectMake(18, 0, 180, 43);
                _rightTextLbl.backgroundColor = [UIColor clearColor];
                _rightTextLbl.textAlignment = UITextAlignmentLeft;
                _rightTextLbl.font = [UIFont systemFontOfSize:17];
                _rightTextLbl.text = [PayFlowUtil generateStoreAreaInfo:self.storeInfoDto];
                [cell.contentView addSubview:_rightTextLbl];
                TT_RELEASE_SAFELY(_rightTextLbl);
            break;
        }
        case 3:{
            if (!self.storeInfoDto.storeName || !self.storeInfoDto.storeCode)
            {
                [self.storeInfoBtn setTitle:L(@"please choose store")
                                   forState:UIControlStateNormal];
            }
            else
            {
                [self.storeInfoBtn setTitle:self.storeInfoDto.storeName
                                   forState:UIControlStateNormal];
            }
            [cell.contentView addSubview:self.storeInfoBtn];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



#pragma mark -
#pragma mark UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger number = 0;
    
    if (component == 0)
    {
        number = [self.districtArr count];
    }
    else
    {
        number = [self.storeInfoArr count];
    }
    
    //ios6崩溃兼容，崩溃信息：
    //*** Assertion failure in -[UITableViewRowData rectForRow:inSection:],
    // /SourceCache/UIKit/UIKit-2372/UITableViewRowData.m:1630
    // http://stackoverflow.com/questions/12672318/assertion-failure-on-picker-view
    if (IOS6_OR_LATER) {
        return number <= 0 ? 1 : number;
    }

    return number;
}

#pragma mark -
#pragma mark UIPickerView Delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = 100.0f;
    
    if (component == 1) 
    {
        width = 200.0f;
    }
    
    return width;
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
             titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component
{
    NSString *title = nil;
    
    if (component == 0) 
    {
        if ([self.districtArr count] > row)
        {
            title = [(AddressInfoDTO *)[self.districtArr objectAtIndex:row] districtContent];
        }
    }
    else
    {
        if ([self.storeInfoArr count] > row)
        {
            title = [(StoreInfoDto *)[self.storeInfoArr objectAtIndex:row] storeName];
        }
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView 
      didSelectRow:(NSInteger)row 
       inComponent:(NSInteger)component
{
    NSString *districtCode = nil;
    
    if (component == 0)
    {
        districtCode = [(AddressInfoDTO *)[self.districtArr objectAtIndex:row] district];
        
        [self sendStoreHttpRequest:districtCode];
        
        self.storeInfoArr = nil;
        
        [self reloadPickerViewComponent1];
    }
    
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == self.receiptNameFld) 
    {
        self.storeInfoDto.receiptName = textField.text;
    }
    else if (textField == self.receiptPhoneFld)
    {
        self.storeInfoDto.receiptPhone = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField 
    shouldChangeCharactersInRange:(NSRange)range 
    replacementString:(NSString *)string
{
    if (range.location > 10 || (range.location == 0 && [string isEqualToString:@"0"])) 
    {
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark cell tool bar button delegate
- (void)doneClicked:(UITableViewCell *)cell
{
    if ([cell.reuseIdentifier isEqualToString:@"cityCell"])
    {
        AddressInfoDTO *selectCity = self.addressPicker.selectAddressInfo;
        
        if (![self.storeInfoDto.provinceId isEqualToString:selectCity.province]||
            ![self.storeInfoDto.cityId isEqualToString:selectCity.city])
        {
            self.storeInfoDto.provinceId = selectCity.province;
            self.storeInfoDto.provinceName = selectCity.provinceContent;
            
            self.storeInfoDto.cityId = selectCity.city;
            self.storeInfoDto.cityName = selectCity.cityContent;
            
            self.storeInfoDto.districtId = nil;
            self.storeInfoDto.districtName = nil;
            
            self.storeInfoDto.storeName = nil;
            self.storeInfoDto.storeCode = nil;
            self.storeInfoDto.storeAddress = nil;
            
            [self.groupTableView reloadData];
            
            //刷新区列表
            [self sendDistrictHttpRequest];
        }else{
            [cell resignFirstResponder];
        }
    }
    else
    {
        NSInteger selectDistrictRow = 0;
        
        NSInteger selectStoreRow = 0;
        
        AddressInfoDTO *addressInfoDto = nil;
        
        StoreInfoDto *storeInfoDto = nil;
        
        selectDistrictRow = [self.storePicker selectedRowInComponent:0];
        
        selectStoreRow = [self.storePicker selectedRowInComponent:1];
        
        addressInfoDto = [self.districtArr objectAtIndex:selectDistrictRow];
        
        storeInfoDto = [self.storeInfoArr objectAtIndex:selectStoreRow];
        
        self.storeInfoDto.districtId = addressInfoDto.district;
        self.storeInfoDto.districtName = addressInfoDto.districtContent;
        
        self.storeInfoDto.storeName = storeInfoDto.storeName;
        self.storeInfoDto.storeCode = storeInfoDto.storeCode;
        self.storeInfoDto.storeAddress = storeInfoDto.storeAddress;
        
        if (IsStrEmpty(self.storeInfoDto.storeName)) {
            [self presentSheet:L(@"CannotTakeSelf")];
        }
        
        [self.groupTableView reloadData];
    }
}

#pragma mark -
#pragma mark tool bar button delegate

// button tap event
- (void)singleClickButton:(id)sender
{
    if (!isDistrictListLoadOk) {
        return;
    }
    
    ToolBarButton *button = (ToolBarButton *)sender;
    
    [button becomeFirstResponder];
}

// toolbar buton ok event
- (void)doneButtonClicked:(id)sender
{
    NSInteger selectDistrictRow = 0;
    
    NSInteger selectStoreRow = 0;
        
    AddressInfoDTO *addressInfoDto = nil;
    
    StoreInfoDto *storeInfoDto = nil;
    
    selectDistrictRow = [self.storePicker selectedRowInComponent:0];
    
    selectStoreRow = [self.storePicker selectedRowInComponent:1];
    
    addressInfoDto = [self.districtArr objectAtIndex:selectDistrictRow];
    
    storeInfoDto = [self.storeInfoArr objectAtIndex:selectStoreRow];
    
    self.storeInfoDto.districtId = addressInfoDto.district;
    self.storeInfoDto.districtName = addressInfoDto.districtContent;
    
    self.storeInfoDto.storeName = storeInfoDto.storeName;
    self.storeInfoDto.storeCode = storeInfoDto.storeCode;
    self.storeInfoDto.storeAddress = storeInfoDto.storeAddress;
    
    [self.groupTableView reloadData];
}

- (void)reloadPickerViewComponent0
{
    [self.storePicker reloadComponent:0];
    
    NSString *selectDistrict = self.storeInfoDto.districtId;
    if (selectDistrict && _districtArr && [_districtArr count] > 0) 
    {
        for (int i = 0; i < [self.districtArr count]; i++) {
            AddressInfoDTO *dto = [self.districtArr objectAtIndex:i];
            if ([self.storeInfoDto.districtId isEqualToString:dto.district]) {
                [self.storePicker selectRow:i inComponent:0 animated:NO];
                [self pickerView:self.storePicker didSelectRow:i inComponent:0];
                return;
            }
        }
    }
    if (_districtArr && [_districtArr count] > 0) {
        [self pickerView:self.storePicker didSelectRow:0 inComponent:0];
    }
}

- (void)reloadPickerViewComponent1
{
    [self.storePicker reloadComponent:1];
    
    if (self.storeInfoDto.storeCode) {
        for (int i = 0; i < [self.storeInfoArr count]; i++) {
            StoreInfoDto *dto = [self.storeInfoArr objectAtIndex:i];
            if ([self.storeInfoDto.storeCode isEqualToString:dto.storeCode]) {
                [self.storePicker selectRow:i inComponent:1 animated:NO];
            }
        }
    }
}

#pragma mark -
#pragma mark get data

- (void)sendDistrictHttpRequest
{
    [self displayOverFlowActivityView];
    
    [self.addressInfoService beginGetDistrictListByCityCode:self.storeInfoDto.cityId];
}

- (void)getDistrictListCompletionWithResult:(BOOL)isSuccess districtList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        isDistrictListLoadOk = YES;
        self.districtArr = list;
        [self reloadPickerViewComponent0];
    }else{
        [self presentSheet:L(@"PFObtainListFailedAndTryAgainLater")];
    }
}

- (void)sendStoreHttpRequest:(NSString *)district
{
    [self.storeInfoService beginGetShopListRequest:self.storeInfoDto.cityId distrist:district];
}

- (void)getShopListCompletionWithResult:(BOOL)isSuccess 
                               errorMsg:(NSString *)errorMsg
                               shopList:(NSArray *)list
{
    if (isSuccess) {
        self.storeInfoArr = list;
        [self reloadPickerViewComponent1];
    }
}

#pragma mark -
#pragma mark action

- (BOOL)storeMentionCheck
{
    NSString *errorMessage = nil;
    
    if (![PayFlowUtil validateChineseChar2_6:self.receiptNameFld.text]) {
        
        errorMessage = L(@"Name_Not_valid");
        [self presentSheet:errorMessage posY:50];
        [self.receiptNameFld becomeFirstResponder];
        
        return  NO;
    }
    
    
    if (![PayFlowUtil validateChinaMobileNo:self.receiptPhoneFld.text])
    {
        errorMessage = L(@"InputMobileNumber");
        [self presentSheet:errorMessage posY:50];
        [self.receiptPhoneFld becomeFirstResponder];
        
        return NO;
    }
    
    if (!self.storeInfoDto.storeCode || [self.storeInfoDto.storeCode isEmptyOrWhitespace])
    {
        errorMessage = L(@"please choose store");
        [self presentSheet:errorMessage posY:50];
        [self singleClickButton:self.storeInfoBtn];
        
        return NO;
    }
    
    return YES;
}

- (void)finishModifyMention:(id)sender
{
    [self.receiptNameFld resignFirstResponder];
    [self.receiptPhoneFld resignFirstResponder];

    if (![self storeMentionCheck])
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectStoreInfo:)])
    {
        [self.delegate didSelectStoreInfo:self.storeInfoDto];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
