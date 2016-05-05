//
//  AddressNewViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  Modifyed by liukun

#import "AddressNewViewController.h"
#import "RegexKitLite.h"
#import "UITableViewCell+BgView.h"

@interface AddressNewViewController()

- (void)sendNewAddressRequest;

@end

/*********************************************************************/

@implementation AddressNewViewController
@synthesize service = _service;
@synthesize addressInfoDTO = _addressInfoDTO;
@synthesize addrPickerView = _addrPickerView;
@synthesize delegate = _delegate;
@synthesize isFromEasilyBuy;

@synthesize defaultAddressTextField = _defaultAddressTextField;
@synthesize personTextField = _personTextField;
@synthesize phoneTextField = _phoneTextField;
@synthesize addressTextField = _addressTextField;

- (void)dealloc {
    TT_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_addressInfoDTO);
    _addrPickerView.addressDelegate = nil;
    TT_RELEASE_SAFELY(_addrPickerView);

    TT_RELEASE_SAFELY(_defaultAddressTextField);
    TT_RELEASE_SAFELY(_personTextField);
    TT_RELEASE_SAFELY(_phoneTextField);
    TT_RELEASE_SAFELY(_addressTextField);
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"add address");
        
        self.pageTitle = L(@"shopProcess_shop_addAddress");
        
//        UIBarButtonItem *newButton = [[UIBarButtonItem alloc]
//                                      initWithTitle:L(@"save address")
//                                      style:UIBarButtonItemStylePlain
//                                      target:self
//                                      action:@selector(saveNewAddress)];
//        
//        self.navigationItem.rightBarButtonItem = newButton;
//        
//        TT_RELEASE_SAFELY(newButton);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:L(@"save address") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(righBarClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(20, 6, 44, 44);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = item;
    }
    return self;
}

- (void)righBarClick
{
    [self saveNewAddress];
}

- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 44 ;
    
    self.tpTableView.frame = frame;
    
    [self.footerView addSubview:self.checkBtn];
    [self.footerView addSubview:self.checkLbl];
//    self.tpTableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.tpTableView];
    
    self.isCheckPrefer = NO;
    
    self.hasSuspendButton = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

#pragma mark -
#pragma mark table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // int rows[2] = {1,3};
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //上下2个section，上1个section
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    SNUITableViewCell *cell = (SNUITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        
        cell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor cellBackViewColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor light_Black_Color];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
//    int rows[2] = {1,3};
//    int rowCount = rows[indexPath.section];
//    [cell setCoolBgViewWithCellPosition:CellPositionMake(rowCount, indexPath.row)];
//    
//    if (indexPath.section == 0) {
//        cell.textLabel.text = nil;
//        [cell addSubview:self.defaultAddressTextField];
//    }else{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text =  L(@"AddressPerson");//
                    [cell.contentView addSubview:self.personTextField];
                    [cell.contentView addSubview:self.tongxunBtn];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = L(@"AddressTel");//L(@"AddressPerson");
                    [cell.contentView addSubview:self.phoneTextField];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
                case 2:
                {
                    cell.textLabel.text = nil;
                    [cell addSubview:self.defaultAddressTextField];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    break;
                }
                case 3:
                {
                    cell.textLabel.text = L(@"AddressXiangxi");
                    [cell.contentView addSubview:self.addressTextField];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            [cell.contentView addSubview:self.checkBtn];
            [cell.contentView addSubview:self.checkLbl];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
        default:
            break;
    }
    
  //  }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 50;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    footView.backgroundColor = [UIColor clearColor];
//    
//    [footView addSubview:self.checkBtn];
//    [footView addSubview:self.checkLbl];
//    
//    return footView;
//}
////给section添加标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        
//        return L(@"AddressArea");
//        
//    }else {
//        
//        return L(@"Detail_Delivery_Address");
//    }
//}


#pragma mark -
#pragma mark action

- (void)hideKeyboard
{
    [self.defaultAddressTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
	[self.personTextField resignFirstResponder];
	[self.phoneTextField resignFirstResponder];
}

- (BOOL) validateChineseName: (NSString *) shouhuoren {
    
    if (!shouhuoren || [shouhuoren isEmptyOrWhitespace]) 
    {
        return NO;
    }
    
    NSString *shouhuorenRegex = @"[\\u4e00-\\u9fa5]{2,6}";
    
    NSPredicate *shouhuorenTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", shouhuorenRegex];
    
    return [shouhuorenTest evaluateWithObject:shouhuoren];  
}

- (BOOL) validateMobileNo: (NSString *) mobileNo {
    
    NSString *mobileNoRegex = @"1\\d{10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex]; 
    return [mobileNoTest evaluateWithObject:mobileNo];
}

- (BOOL)isContains4byteChar:(NSString *)string
{
    __block BOOL is4Byte = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
    {
        if ([substring lengthOfBytesUsingEncoding:NSUTF8StringEncoding] >= 4)
        {
            is4Byte = YES;
            *stop = YES;
        }
    }];
    
    return is4Byte;
}

- (BOOL)validateAddressDetail:(NSString *)addressDetail error:(NSString **)error
{
    NSString *errorRegex = @"[`~!$%^&*+=|':;',\"\\[\\].<>/?~！￥%……&*——+|【】‘；：”“’。，、？\\\\]";
    if ([addressDetail isMatchedByRegex:errorRegex])
    {
        *error = L(@"ADDetailAddressCantContainIllegalCharacters");
        return NO;
    }
    
    if ([self isContains4byteChar:addressDetail])
    {
        *error = L(@"ADDetailAddressCantContainEmoticons");
        return NO;
    }
    
    if ([addressDetail length] > 30) {
        *error = L(@"ADDetailAddressLessThanThirtyWords");
        return NO;
    }
    return YES;
    
}

- (void)saveNewAddress
{
    [self hideKeyboard];
    
    if((self.personTextField.text == nil) || [self.personTextField.text isEqualToString:@""]){
        [self presentSheet:L(@"Please input your real name") posY:50];
        return;
    }
    
    //验证收货人为中文
    if ([self validateChineseName:self.personTextField.text] == NO)
    {
        [self presentSheet: L(@"Please input chinese name")];
        
        return;
    }
    
    if((self.phoneTextField.text == nil) || [self.phoneTextField.text isEqualToString:@""]){
        [self presentSheet:L(@"Please input receive phone") posY:50];
        return;
    }
    if (![self validateMobileNo:self.phoneTextField.text]) {
        [self presentSheet:L(@"please input your real number") posY:50];
        return;
    }
    
    if (self.addressInfoDTO.province == nil || [self.addressInfoDTO.province isEqualToString:@""] || 
        self.addressInfoDTO.city == nil || [self.addressInfoDTO.city isEqualToString:@""] ||
        self.addressInfoDTO.district == nil || [self.addressInfoDTO.district isEqualToString:@""] ||
        self.addressInfoDTO.town == nil || [self.addressInfoDTO.town isEqualToString:@""]){
        
        [self presentSheet:L(@"Please input area address") posY:50];
        
        return;
    }
    
    if((self.addressTextField.text == nil) || [self.addressTextField.text isEqualToString:@""]){
        [self presentSheet:L(@"Please input detail address") posY:50];
		return;
	}   
    
    
    
//    if ([self.addressTextField.text length] > 20) {
//        [self presentSheet:L(@"Detail_Address_Should_Under_20") posY:50];
//        return;
//    }
    NSString *addressDetailError = nil;
    if (![self validateAddressDetail:self.addressTextField.text error:&addressDetailError])
    {
        [self presentSheet:addressDetailError posY:50];
        return;
    }
    
    self.addressInfoDTO.recipient = self.personTextField.text;
    self.addressInfoDTO.tel = self.phoneTextField.text;
    self.addressInfoDTO.addressContent = self.addressTextField.text;
    
    [self sendNewAddressRequest];
}

#pragma mark -
#pragma mark property getters

- (AddressInfoDTO *)addressInfoDTO
{
    if (!_addressInfoDTO) {
        _addressInfoDTO = [[AddressInfoDTO alloc] init];
        _addressInfoDTO.province = [Config currentConfig].defaultProvince;
        _addressInfoDTO.city = [Config currentConfig].defaultCity;
    }
    return _addressInfoDTO;
}

- (UserAddressService *)service
{
    if (!_service) {
        _service = [[UserAddressService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (ToolBarTextField *)defaultAddressTextField
{
    if (_defaultAddressTextField == nil)
    {
        _defaultAddressTextField = [[ToolBarTextField alloc] init];
        _defaultAddressTextField.frame = CGRectMake(20, 0, 260, 48);
        _defaultAddressTextField.backgroundColor = [UIColor clearColor];
        _defaultAddressTextField.borderStyle = UITextBorderStyleNone;
        _defaultAddressTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _defaultAddressTextField.inputView = self.addrPickerView;
        _defaultAddressTextField.delegate = self;
        _defaultAddressTextField.tag = 9;
        _defaultAddressTextField.textColor = [UIColor light_Black_Color];
        _defaultAddressTextField.toolBarDelegate = self;
        _defaultAddressTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _defaultAddressTextField.placeholder = L(@"Click_To_Select_Address_Area");
    }
    return _defaultAddressTextField;
}


- (UITextField *)addressTextField
{
    if (_addressTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _addressTextField = [[UITextField alloc] initWithFrame:frame];
        _addressTextField.placeholder = L(@"Please input detail address");
        _addressTextField.borderStyle = UITextBorderStyleNone;
        _addressTextField.textColor = [UIColor light_Black_Color];
        _addressTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _addressTextField.backgroundColor = [UIColor clearColor];
        _addressTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _addressTextField.autocorrectionType = UITextAutocorrectionTypeNo;     
        _addressTextField.keyboardType = UIKeyboardTypeDefault;
        _addressTextField.returnKeyType = UIReturnKeyDone;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressTextField.delegate =self;
    }
    
    return _addressTextField;
}

- (UITextField *)personTextField
{
    if (_personTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth - 10, kTextFieldHeight);
        _personTextField = [[UITextField alloc] initWithFrame:frame];
        _personTextField.placeholder = L(@"Please input your name");
        _personTextField.borderStyle = UITextBorderStyleNone;
        _personTextField.textColor = [UIColor light_Black_Color];
        _personTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _personTextField.backgroundColor = [UIColor clearColor];
        _personTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _personTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _personTextField.keyboardType = UIKeyboardTypeDefault;
        _personTextField.returnKeyType = UIReturnKeyDone;
        _personTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _personTextField.delegate =self;
    }
    
    return _personTextField;
}

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _phoneTextField = [[UITextField alloc] initWithFrame:frame];
        [_phoneTextField  setTag:1001];
        _phoneTextField.placeholder = L(@"Please input receive phone");
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.textColor = [UIColor light_Black_Color];
        _phoneTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _phoneTextField.backgroundColor = [UIColor clearColor];
        _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate =self;
    }
    
    return _phoneTextField;
}

- (AddressInfoPickerView *) addrPickerView
{
    if (!_addrPickerView)
    {
        _addrPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:self.addressInfoDTO compentCount:AddressPickerViewCompentFour];
        _addrPickerView.addressDelegate = self;
    }
    return _addrPickerView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    return _footerView;
}

- (UIButton *)checkBtn
{
    if (!_checkBtn) {
        _checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 54, 44)];
        _checkBtn.backgroundColor = [UIColor clearColor];
        [_checkBtn setImage:[UIImage imageNamed:@"singleCheck_unselect.png"] forState:UIControlStateNormal];
        [_checkBtn setImage:[UIImage imageNamed:@"singleCheck_selected.png"] forState:UIControlStateSelected];
        [_checkBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

- (UILabel *)checkLbl
{
    if (!_checkLbl) {
        _checkLbl = [[UILabel alloc] initWithFrame:CGRectMake(44, 12, 150, 20)];
        _checkLbl.backgroundColor = [UIColor clearColor];
        _checkLbl.font = [UIFont systemFontOfSize:15];
        _checkLbl.textColor = [UIColor grayColor];
        _checkLbl.text = L(@"ADSetAsDefaultAddress");
    }
    return _checkLbl;
}

- (void)checkBtnAction
{
    self.isCheckPrefer = !self.isCheckPrefer;
    self.checkBtn.selected = self.isCheckPrefer;
    self.addressInfoDTO.preferFlag = self.isCheckPrefer;
}

- (UIButton *)tongxunBtn
{
    if (!_tongxunBtn) {
        _tongxunBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.personTextField.right, 0, 36, 48)];
        _tongxunBtn.backgroundColor = [UIColor clearColor];
        [_tongxunBtn setImage:[UIImage imageNamed:@"Address_tongxunlu_icon.png"] forState:UIControlStateNormal];
        [_tongxunBtn addTarget:self action:@selector(goToTongxunlu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tongxunBtn;
}


#pragma mark - ABPeoplePickerNavigationController 地址簿相关方法

- (void)goToTongxunlu
{
    if (!IOS6_OR_LATER && [[Config currentConfig].isFirstUseAddress isEqualToString:@"0"])
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                        message:L(@"VPEbuyWantToVisitYourAddressBook")
                                                       delegate:(id)self
                                              cancelButtonTitle:L(@"VPNoPermission")
                                              otherButtonTitles:L(@"BTOk")];
        [alert setConfirmBlock:^{
            [Config currentConfig].isFirstUseAddress = @"1";
            [self goToTongxunlu];
        }];
        [alert show];
        return;
    }
    
    ABAddressBookRef addressBook = nil;
    if (IOS6_OR_LATER)
    {
        __weak typeof(self) wself = self;
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     if (granted) {
                                                         
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             [wself goToABPeoplePickerView];
                                                         });
                                                         
                                                         dispatch_semaphore_signal(sema);
                                                         
                                                     }else{
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             if (ABAddressBookGetAuthorizationStatus()!= kABAuthorizationStatusAuthorized ) {
                                                                 
                                                                 [wself presentSheet:L(@"VPPleaseOpenThePermissionOfAddressBook") posY:50];
                                                                 
                                                             }
                                                             
                                                         });
                                                         
                                                         dispatch_semaphore_signal(sema);
                                                         
                                                     }
                                                     
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
        
    }else{
        [self goToABPeoplePickerView];
    }
    
    if (addressBook) {
        CFRelease(addressBook);
    }
}

- (void)goToABPeoplePickerView
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],nil];
    
    picker.displayedProperties = displayedItems;
    
    [self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
    NSString *phone = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneProperty,identifier));
    TT_RELEASE_SAFELY(phoneProperty);
    
    NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (phoneStr.length==12&&[[phoneStr substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"] ) {
        phoneStr = [phoneStr substringFromIndex:1];
    }
    TT_RELEASE_SAFELY(phone);
    
    self.personTextField.text = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName(person));
    if (self.personTextField.text.length>5) {
        self.personTextField.text = [self.personTextField.text substringToIndex:5];
    }
    
    self.phoneTextField.text = phoneStr;
    
    [self dismissModalViewControllerAnimated:YES];
        
    return NO;
}

#ifdef __IPHONE_8_0

// Called after a property has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
    NSString *phone = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneProperty,identifier));
    TT_RELEASE_SAFELY(phoneProperty);
    
    
    NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (phoneStr.length==12&&[[phoneStr substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"] ) {
        phoneStr = [phoneStr substringFromIndex:1];
    }
    
    TT_RELEASE_SAFELY(phone);
    
    self.personTextField.text = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName(person));
    if (self.personTextField.text.length>5) {
        self.personTextField.text = [self.personTextField.text substringToIndex:5];
    }
    
    
    self.phoneTextField.text = phoneStr;
    
    [self dismissModalViewControllerAnimated:YES];
    
}
#endif

#pragma mark -
#pragma mark text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1001 && (textField.text.length+string.length) >11) {
        return NO;
    }
    return YES;
}

- (void)doneButtonClicked:(id)sender
{
    AddressInfoDTO *selectAddress = self.addrPickerView.selectAddressInfo;
    if (selectAddress.province == nil ||
        selectAddress.city == nil ||
        selectAddress.district == nil ||
        selectAddress.town == nil) {
        return;
    }
    NSString *AddressContent = [NSString stringWithFormat:@"%@ %@ %@ %@", selectAddress.provinceContent, selectAddress.cityContent, selectAddress.districtContent, selectAddress.townContent];
    //在pickerview里组装
    self.defaultAddressTextField.text = AddressContent;
    
    //把pickview中的id值再传回给全局变量，保证二次进入pickview也是第一次从pickview返回的id
    [self.addressInfoDTO copySimpleAddressInfoFromAnotherAddress:selectAddress];
    
    [self.defaultAddressTextField resignFirstResponder];
}

- (void)cancelButtonClicked:(id)sender
{
    [self.defaultAddressTextField resignFirstResponder];
}

/*deprecated by liukun, 2014/1/2
- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    if (addressInfo) {
        NSString *AddressContent = [NSString stringWithFormat:@"%@ %@ %@ %@", 
                                    addressInfo.provinceContent, 
                                    addressInfo.cityContent, 
                                    addressInfo.districtContent,
                                    addressInfo.townContent];
        
        self.defaultAddressTextField.text = AddressContent;
        
        [self.addressInfoDTO copySimpleAddressInfoFromAnotherAddress:addressInfo];
    }
}
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark action

- (void)sendNewAddressRequest
{
    [self displayOverFlowActivityView];
    
    [self.service beginAddAddressRequest:self.addressInfoDTO];
}

- (void)addAddressCompletionWithResult:(BOOL)isSuccess 
                              errorMsg:(NSString *)errorMsg 
                               address:(AddressInfoDTO *)dto
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        self.addressInfoDTO = dto;
        if (!isFromEasilyBuy) {
            //增加因新账户新增地址二次购物不能及时获取新增地址的bug---结束
            //在非一键购地址新增中才执行改操作
            AddressInfoDTO *addrInfoDto = [dto copy];
            [[UserCenter defaultCenter].userInfoDTO.addressArray addObject:addrInfoDto];
            TT_RELEASE_SAFELY(addrInfoDto);
            //将新增的地址设置为默认地址
            [Config currentConfig].defaultAddressId = dto.addressNo;
        }
        
        DLog(@"addressInfoDTO.addressNo after update  =%@ \n",self.addressInfoDTO.addressNo);
        
        [self presentCustomDlg:L(@"address add success")];
                
    }else{
        [self presentSheet:errorMsg];
    }
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.isFromEasilyBuy) {
        //刷新新增一键购页面
        NSNotification *notification = [NSNotification notificationWithName:EASILY_BUY_UPDATE_ADDRESS object:_addressInfoDTO];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        if ([_delegate conformsToProtocol:@protocol(AddressChangeDelegate)]) {
            if ([_delegate respondsToSelector:@selector(addressListNeedRefresh)]) {
                [_delegate addressListNeedRefresh];
            }
            if ([_delegate respondsToSelector:@selector(didSelectAddress:)]) {
                [_delegate didSelectAddress:self.addressInfoDTO];
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
