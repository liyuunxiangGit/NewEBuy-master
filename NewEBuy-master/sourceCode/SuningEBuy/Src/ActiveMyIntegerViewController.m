//
//  ActiveMyIntegerViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-9-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ActiveMyIntegerViewController.h"
#import "AddressInfoDAO.h"
#import "AddressInfoDTO.h"

#define kDefaultProvinceCode       [Config currentConfig].defaultProvince
#define kDefaultCityCode           [Config currentConfig].defaultCity
#define kActivateBtnTag            10000

@interface ActiveMyIntegerViewController() 

@property (nonatomic, copy)   NSString                         *myIntegral;
@property (nonatomic, copy)   NSString                         *sexType;
@property (nonatomic, copy)   NSString                         *IsBindMobile;
@property (nonatomic, strong) NSMutableArray                   *getCodeList;
@property (nonatomic, strong) NSArray                          *headTitle;
@property (nonatomic, strong) NSArray                          *certificatePickerData;
//地址
@property (nonatomic, copy) NSString                         *trimProvinceCode;
@property (nonatomic, copy) NSString                         *trimcityCode;
@property (nonatomic, copy) NSString                         *trimAreaCode;
@property (nonatomic, copy) NSString                         *trimTownCode;
@property (nonatomic, strong) AddressInfoDTO                   *addressInfoDTO;
@property (nonatomic, strong) AddressInfoDAO                   *tempAddressInfoDao;
@property (nonatomic, strong) NSArray                          *districtArray;
@property (nonatomic, strong) NSArray                          *townArray;


@property (nonatomic, strong) TPKeyboardAvoidingTableView      *tpkTableView;
@property (nonatomic, strong) UITextField                      *userNameTextField;
@property (nonatomic, strong) UITextField                      *certificateTextField;
@property (nonatomic, strong) UITextField                      *detailTextField;

@property (nonatomic, strong) AddressInfoPickerView                *userAddPickerView;
@property (nonatomic, strong) ToolBarTextField                 *userAddressTextField;
@property (nonatomic, strong) ToolBarTextField                 *certificateTypeTextField;
@property (nonatomic, strong) UIPickerView                     *certificateTypePicker;
@property (nonatomic, strong) UISegmentedControl               *sexSegmentedControl;
@property (nonatomic, strong) OHAttributedLabel                *integralBalanceLabel;
@property (nonatomic, strong) UIView                           *activateView;

@property (nonatomic, strong) MyIntegralService                *service;
@property (nonatomic, strong) ValidationService                *validateService;

@property (nonatomic, strong) UITextField    *phoneNumTextField;

@property (nonatomic, strong) UITextField    *identifyingTextField;

@property (nonatomic, strong) UIButton       *getIdentifyingBtn;

@property (nonatomic, strong) CheckCodeService           *checkCodeService; 

- (void)initialDatas;
- (void)setDiscountAttrText;
- (void)getAreaAddress;
- (void)initDefaultCertificate;
- (NSString *)returnCertificateType:(NSString *)certificateType;
- (NSString *)trimString:(NSString *)beforeString;
- (BOOL)validateAll;
- (void)navigationItemInit;

@end

@implementation ActiveMyIntegerViewController
@synthesize myIntegral = _myIntegral;
@synthesize tpkTableView = _tpkTableView;
@synthesize headTitle = _headTitle;
@synthesize userNameTextField = _userNameTextField;
@synthesize certificateTextField = _certificateTextField;
@synthesize detailTextField = _detailTextField;
@synthesize userAddressTextField = _userAddressTextField;

@synthesize userAddPickerView = _userAddPickerView;
@synthesize certificateTypePicker = _certificateTypePicker;
@synthesize certificateTypeTextField = _certificateTypeTextField;
@synthesize certificatePickerData = _certificatePickerData;

//地址
@synthesize trimAreaCode = _trimAreaCode;
@synthesize trimcityCode = _trimcityCode;
@synthesize trimTownCode = _trimTownCode;
@synthesize trimProvinceCode = _trimProvinceCode;
@synthesize addressInfoDTO = _addressInfoDTO;

@synthesize tempAddressInfoDao = _tempAddressInfoDao;
@synthesize townArray = _townArray;
@synthesize districtArray = _districtArray;
@synthesize sexSegmentedControl = _sexSegmentedControl;
@synthesize sexType = _sexType;

@synthesize integralBalanceLabel = _integralBalanceLabel;
@synthesize IsBindMobile = _IsBindMobile;

@synthesize getCodeList = _getCodeList;
@synthesize activateView = _activateView;

@synthesize service = _service;
@synthesize validateService = _validateService;

@synthesize phoneNumTextField = _phoneNumTextField;
@synthesize identifyingTextField = _identifyingTextField;
@synthesize getIdentifyingBtn = _getIdentifyingBtn;
@synthesize checkCodeService = _checkCodeService;
@synthesize calculagraph        = _calculagraph;

- (void)dealloc{   
    
    [_calculagraph stop];
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);

    TT_RELEASE_SAFELY(_myIntegral);
    TT_RELEASE_SAFELY(_tpkTableView);
    TT_RELEASE_SAFELY(_headTitle);
    
    TT_RELEASE_SAFELY(_userNameTextField);
    TT_RELEASE_SAFELY(_certificateTextField);
    TT_RELEASE_SAFELY(_detailTextField);
    TT_RELEASE_SAFELY(_userAddressTextField);
    
    TT_RELEASE_SAFELY(_userAddPickerView);
    TT_RELEASE_SAFELY(_certificateTypeTextField);
    TT_RELEASE_SAFELY(_certificateTypePicker);
    TT_RELEASE_SAFELY(_certificatePickerData);
    
    //地址
    TT_RELEASE_SAFELY(_trimAreaCode);
    TT_RELEASE_SAFELY(_trimcityCode);
    TT_RELEASE_SAFELY(_trimProvinceCode);
    TT_RELEASE_SAFELY(_trimTownCode);
    TT_RELEASE_SAFELY(_addressInfoDTO);
    
    TT_RELEASE_SAFELY(_tempAddressInfoDao);
    TT_RELEASE_SAFELY(_townArray);
    TT_RELEASE_SAFELY(_districtArray);
    TT_RELEASE_SAFELY(_sexSegmentedControl);
    TT_RELEASE_SAFELY(_sexType);
    
    TT_RELEASE_SAFELY(_integralBalanceLabel);
    TT_RELEASE_SAFELY(_IsBindMobile);
    TT_RELEASE_SAFELY(_getCodeList);
    TT_RELEASE_SAFELY(_activateView);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_validateService);
    
    _phoneNumTextField.delegate = nil;
    TT_RELEASE_SAFELY(_phoneNumTextField);
    _identifyingTextField.delegate = nil;
    TT_RELEASE_SAFELY(_identifyingTextField);
    TT_RELEASE_SAFELY(_getIdentifyingBtn);
    
    SERVICE_RELEASE_SAFELY(_checkCodeService);
    
    
}

- (id)initWithIntegral:(NSString *)integral {
    self = [super init];
    if (self) {
        
        self.title = L(@"activated_integral");
        
        self.pageTitle = L(@"member_myEbuy_activeintegral");
        
        self.myIntegral = integral;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)loadView{
    
    [super loadView];
    self.bSupportPanUI = NO;
//    [self navigationItemInit];
    
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    self.tpkTableView.frame = frame;
    [self.view addSubview:self.tpkTableView];
    [self initialDatas];  
    [self.tpkTableView reloadData];
    [self.service BeginGetPreCardInfoRequest];
}

- (void)backForePage
{
    [self goBack:nil];
}

- (void)navigationItemInit{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
    [backButton setBackgroundImage :[UIImage imageNamed:@"backToMyEbuy.png"] forState:UIControlStateNormal];
    UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 50, 28)];
    buttonTitle.text = L(@"myEbuy");
    buttonTitle.font = [UIFont boldSystemFontOfSize:12];
    buttonTitle.textColor = [UIColor whiteColor];
    buttonTitle.backgroundColor = [UIColor clearColor];
    [backButton addSubview:buttonTitle];
    TT_RELEASE_SAFELY(buttonTitle);
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:item];
    TT_RELEASE_SAFELY(backButton);
    TT_RELEASE_SAFELY(item);
}

- (void)goBack:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Event  Methods
#pragma mark   事件的相应方法。

- (void)selectSex:(id)sender
{
    if ([sender selectedSegmentIndex] ==  0)
    {
        self.sexType = @"M";
    }
    
    else
    {
        self.sexType = @"F";
    }
}

#pragma mark - ActivateIntegral Methods
#pragma mark   激活云钻方法

- (void)activateIntegral:(id)sender{
    
    BOOL isValidateSuccess = [self validateAll];
    
    if (isValidateSuccess) {
        
        [self.userNameTextField resignFirstResponder];
        [self.certificateTextField resignFirstResponder];
        [self.certificateTypeTextField resignFirstResponder];
        [self.phoneNumTextField resignFirstResponder];
        [self.detailTextField resignFirstResponder];
        [self.userAddressTextField resignFirstResponder];
        [self.identifyingTextField resignFirstResponder];
        
        NSString  *cardType = nil; 
        
        if ([self.certificateTypeTextField.text isEqualToString:L(@"001")]) {
            cardType = @"001";
        }
        if ([self.certificateTypeTextField.text isEqualToString:L(@"005")]) {
            cardType = @"005";
        }
        if ([self.certificateTypeTextField.text isEqualToString:L(@"006")]) {
            cardType = @"006";
        }
        
        ActivateIntegralDTO *postDTO = [[ActivateIntegralDTO alloc] init];
        postDTO.integralName = self.userNameTextField.text;
        postDTO.integralCardType = cardType;
        postDTO.integralGender = self.sexType;
        postDTO.integralIdCode = self.certificateTextField.text;
        postDTO.provinceName = self.trimProvinceCode;
        postDTO.cityName = self.trimcityCode;
        postDTO.integralAddressField1 = self.trimAreaCode;
        postDTO.integralAddressField2 = self.trimTownCode;
        postDTO.integralDetAdd = self.detailTextField.text;
        
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
            postDTO.integralMobile = self.phoneNumTextField.text;
            [self.service BeginActiveIntegerRequest:postDTO withCheckCode:self.identifyingTextField.text];
        }else{
            [self.service BeginActiveIntegerRequest:postDTO withCheckCode:nil];
        }
        
        [self displayOverFlowActivityView];
        TT_RELEASE_SAFELY(postDTO);
        
    }
}

- (void)didActiveIntegerRequestCompletedWithService:(MyIntegralService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self removeOverFlowActivityView];
    
    if (isSucess) {
        
        [UserCenter defaultCenter].efubaoStatus = eLoginByPhoneUnActive;
        
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"MyEBuy_YourIntegralActivateSuccess") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            
            [Config currentConfig].isBindMobile = [NSNumber numberWithBool:YES];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];      
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
    }else{
        
        //bindIntegral_5015:用户未登录； “bindIntegral_9013”：“手机不唯一”；
        //bindIntegral_9012：验证码错误或手机号已被注册；  "bindIntegral_1020"：“证件号码输入不正确”；
        //bindIntegral_9011：手机绑定失败；  "bindIntegral_6016"：“该证件号已经在数据库中存在”；bindIntegral_2030：更改用户信息失败        
        [self presentSheet:errorCode posY:50];
        
    }
    
}


#pragma mark - CheckCode Methods
#pragma mark   验证码方法

- (void)getIdentifying:(id)sender{
    //验证手机号码是否合法
    NSError *error = [ValidationService phoneNumChecking:self.phoneNumTextField.text];
    if (error.code == kValidationFail ) {
//        [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        NSString *errorDesc = [NSString stringWithFormat:@"PhoneNum_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        [self.phoneNumTextField becomeFirstResponder];
        [self presentSheet:L(errorDesc) posY:50];
        return;
    }      
    
    if ([self.getCodeList count] != 0) {
        for (NSString *CountString in self.getCodeList) {
            NSArray *CountList = [CountString componentsSeparatedByString:@","];
            if ([[CountList objectAtIndex:0] isEqualToString:self.phoneNumTextField.text]) {
                if ([[CountList objectAtIndex:2] intValue] == 3) {
                    [self presentSheet:L(@"Sorry,you can get only three times everyDay") posY:80];
                    return;
                }
            }
        }
    }
    [self.checkCodeService beginGetCheckCode:self.phoneNumTextField.text checkCodeState:eIntegralCheckCode];
}


- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        [self.calculagraph start];
        self.getIdentifyingBtn.userInteractionEnabled = NO;
        self.getCodeList = [Config currentConfig].getCodeList;
        if ([self.getCodeList count] == 0) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSString stringWithFormat:@"%@,%@,%@",self.phoneNumTextField.text,[Preferences yearMonthDay],@"1"]];
            [Config currentConfig].getCodeList = array;
            TT_RELEASE_SAFELY(array);
            [self presentSheet:L(@"Code is sending,please enclosed") posY:80];
        }
        else{
            for (NSString *CountString in self.getCodeList) {
                NSArray *CountList = [CountString componentsSeparatedByString:@","];
                if ([[CountList objectAtIndex:0] isEqualToString:self.phoneNumTextField.text]) {
                    if ([[CountList objectAtIndex:2] intValue] <= 3) {
                        [self.getCodeList removeObject:CountString];
                        int count = [[CountList objectAtIndex:2] intValue] +1;                    
                        [self.getCodeList addObject:[NSString stringWithFormat:@"%@,%@,%d",self.phoneNumTextField.text,[Preferences yearMonthDay],count]];
                        [Config currentConfig].getCodeList = self.getCodeList;
                        DLog(@"%@",[[Config currentConfig].getCodeList description]);
                        [self presentSheet:L(@"Code is sending,please enclosed") posY:80];
                        return;
                    }
                }
            }
            [self.getCodeList addObject:[NSString stringWithFormat:@"%@,%@,%@",self.phoneNumTextField.text,[Preferences yearMonthDay],@"1"]];
            [Config currentConfig].getCodeList = self.getCodeList;
            DLog(@"%@",[[Config currentConfig].getCodeList description]); 
        }
    }else{
        [self presentSheet:L(errorDesc) posY:50];
    }
    
}

- (BOOL)validateAll{
    
    NSError *error = nil;
    
    NSString *errorType = nil;
    
    NSString *errorDesc = nil;
    
    int errorRow = 0;
    
    int startRow = 0;
    
    //手机号码验证
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        startRow = 0;
        error = [ValidationService phoneNumChecking:self.phoneNumTextField.text];
        if (error.code ==kValidationFail) {
            
            errorType = @"PhoneNum";
            errorRow = 0;
            [self.phoneNumTextField becomeFirstResponder];
            goto finally;
            
        }
        
        //验证码验证
        error = [ValidationService NumOrCharacterChecking:self.identifyingTextField.text];
        if (error.code ==kValidationFail) {
            errorType = @"CodeNum";
            errorRow = 1;
            [self.identifyingTextField becomeFirstResponder];
            goto finally;
        }else{
            if ([self.identifyingTextField.text length]!=6) {
                [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:errorRow inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                errorDesc = @"CodeNum_Error_Length";
                [self presentSheet:L(errorDesc) posY:50];
                return NO;
            }           
        }
    }else{    
        startRow = 2;
    }
    
    //姓名验证
    error = [ValidationService chineseChecking:[self trimString:self.userNameTextField.text] Frome:2 To:7];
    
    if (error.code ==kValidationFail) {
        
        errorType = @"Name_27";
        
        errorRow = 2 - startRow;
        
        [self.userNameTextField becomeFirstResponder];
        
        goto finally;
        
    }
    
    //证件类型
    if (IsStrEmpty(self.certificateTypeTextField.text)) {
        
        [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:        errorRow = (4 - startRow) inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self.certificateTypeTextField becomeFirstResponder];
        
        [self presentSheet:L(@"identifyType_Error_Null") posY:50];
        
        return NO;
    }
    
    //证件号
    if ( IsStrEmpty(self.certificateTextField.text)) {
        
        [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:        errorRow = 5 - startRow inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self.certificateTextField becomeFirstResponder];
        
        [self presentSheet:L(@"Identify_Error_Null") posY:50];
        
        return NO;
    }
    
    if ([self.certificateTypeTextField.text isEqualToString:L(@"001")]) {
        
        error = [ValidationService valideIdentifyCard:self.certificateTextField.text];
        
        if (error.code ==kValidationFail) {
            
            errorType = @"Identify";
            
            errorRow  = 5 - startRow;
            
            [self.certificateTextField becomeFirstResponder];
            
            goto finally;
            
        }
        
    }
    
    if ([self.certificateTypeTextField.text isEqualToString:L(@"005")] || [self.certificateTypeTextField.text isEqualToString:L(@"006")]) {
        
        error = [ValidationService NumOrCharacterChecking:self.certificateTextField.text];
        
        if (error.code ==kValidationFail) {
            
            errorType = @"Identify";
            
            errorRow  = 5 - startRow;
            
            [self.certificateTextField becomeFirstResponder];
            
            goto finally;
            
        }
        
    }
    
    if (IsStrEmpty(self.userAddressTextField.text)) {
        
        [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:errorRow  = 6 - startRow inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self.userAddressTextField becomeFirstResponder];
        
        [self presentSheet:L(@"Please select province and city") posY:50];
        
        return NO;
    }
    
    if (IsStrEmpty(self.detailTextField.text)) {
        
        [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:errorRow  = 7 - startRow inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self.detailTextField becomeFirstResponder];
        
        [self presentSheet:L(@"Detail_Address_Null") posY:50];
        
        return NO;
    }
    
    return YES;
    
finally:
    
    if (error.code == kValidationFail ) {
        
        [self.tpkTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:errorRow inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        errorDesc = [NSString stringWithFormat:@"%@_%@",errorType,[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        
        [self presentSheet:L(errorDesc) posY:50];
        
        return NO;
        
    }else{
        
        return YES;
    }
    
}


#pragma mark -  Methods
#pragma mark    声明的方法实现

- (NSString *)returnCertificateType:(NSString *)certificateType{
    
    NSString *certificateTypeString = nil;
    
    if ([self.service.activateIntegralDto.integralCardType isEqualToString:@"001"]) {
        certificateTypeString = L(@"001");
    }
    if ([self.service.activateIntegralDto.integralCardType isEqualToString:@"005"]) {
        certificateTypeString = L(@"005");
    }
    if ([self.service.activateIntegralDto.integralCardType isEqualToString:@"006"]) {
        certificateTypeString = L(@"006");
    }
    return certificateTypeString;
}

#pragma mark - Initial Data Methods
#pragma mark   Data的初始化方法

- (void)initialDatas{
    
    self.getCodeList = [Config currentConfig].getCodeList;
    
    if (!_certificatePickerData) {
        
        _certificatePickerData = [[NSArray alloc] initWithObjects:L(@"001"),L(@"005"),L(@"006"),nil];
    }
    
    self.sexType = @"M";
    
    [self setDiscountAttrText];    
}

-(void)didGetPreCardInfoRequestCompletedWithService:(MyIntegralService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self removeOverFlowActivityView];
    
    if (isSucess) {
        
        self.sexType = IsStrEmpty(self.service.activateIntegralDto.integralGender)?@"M":self.service.activateIntegralDto.integralGender;
        
        if ( !IsStrEmpty(self.service.activateIntegralDto.integralCardType)) {
            self.certificateTypeTextField.userInteractionEnabled = NO;
            self.certificateTypeTextField.textColor = [UIColor grayColor];
        }
        if (!IsStrEmpty(self.service.activateIntegralDto.integralIdCode)) {
            self.certificateTextField.userInteractionEnabled = NO;
            self.certificateTextField.textColor = [UIColor grayColor];
        }
        
        self.userNameTextField.text = self.service.activateIntegralDto.integralName;
        self.phoneNumTextField.text = self.service.activateIntegralDto.integralMobile;
        self.certificateTextField.text = self.service.activateIntegralDto.integralIdCode;
        self.detailTextField.text = self.service.activateIntegralDto.integralDetAdd;
        [self getAreaAddress];
        
        if ([self.sexType isEqualToString:@"M"])
        {
            [self.sexSegmentedControl setSelectedSegmentIndex:0];
        }
        if ([self.sexType isEqualToString:@"F"])
        {
            [self.sexSegmentedControl setSelectedSegmentIndex:1];
        }
        self.certificateTypeTextField.text = L(self.service.activateIntegralDto.integralCardType);
        
        [self initDefaultCertificate];
        
        [self.tpkTableView reloadData];
    }  
    
}

- (void)initDefaultCertificate{
    
    if ([self.service.activateIntegralDto.integralCardType isEqualToString:L(@"005")]) {
        [self.certificateTypePicker selectRow:1 inComponent:0 animated:YES];
    }
    if ([self.service.activateIntegralDto.integralCardType isEqualToString:L(@"006")]) {
        [self.certificateTypePicker selectRow:2 inComponent:0 animated:YES];
    }
    [self.certificateTypePicker selectRow:0 inComponent:0 animated:YES];
    
}

- (void)setDiscountAttrText{
    NSString *string = [NSString stringWithFormat:@"%@ %@",self.myIntegral,@"分"];
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutaString setFont:[UIFont boldSystemFontOfSize:15.0]];
    [mutaString setTextColor:[UIColor lightGrayColor]];
    [mutaString setTextColor:[UIColor redColor] range:[string rangeOfString:self.myIntegral]];
    self.integralBalanceLabel.attributedText = mutaString;
    TT_RELEASE_SAFELY(mutaString);
}

//根据省市区镇id获取中文的省市区信息
- (void)getAreaAddress
{
    NSString *provinceName = self.service.activateIntegralDto.provinceName ? self.service.activateIntegralDto.provinceName :@"";
    NSString *cityName = self.service.activateIntegralDto.cityName ? self.service.activateIntegralDto.cityName : @"";
    NSString *areaName = self.service.activateIntegralDto.districtName ? self.service.activateIntegralDto.districtName : @"";
    NSString *townName = self.service.activateIntegralDto.townName ? self.service.activateIntegralDto.townName : @"";
    
    NSString *addressMain = [NSString stringWithFormat:@"%@%@%@%@",provinceName,cityName,areaName,townName];
    self.userAddressTextField.text = [addressMain stringByReplacingOccurrencesOfString:@"null" withString:@""];
    
    self.trimProvinceCode = IsStrEmpty(self.service.activateIntegralDto.integralState)? kDefaultProvinceCode :self.service.activateIntegralDto.integralState;
    
    self.trimcityCode = IsStrEmpty(self.service.activateIntegralDto.integralCity)?kDefaultCityCode: self.service.activateIntegralDto.integralCity;
    
    self.trimAreaCode = IsStrEmpty(self.service.activateIntegralDto.integralAddressField1) ?@"": self.service.activateIntegralDto.integralAddressField1;
    
    self.trimTownCode = IsStrEmpty(self.service.activateIntegralDto.integralAddressField2)?@"":self.service.activateIntegralDto.integralAddressField2;
    
    AddressInfoDTO *defaultAddress = [[AddressInfoDTO alloc] init];
    defaultAddress.province = _trimProvinceCode;
    defaultAddress.city = _trimcityCode;
    defaultAddress.district = _trimAreaCode;
    defaultAddress.town = _trimTownCode;
    
    self.userAddPickerView.baseAddressInfo=defaultAddress;
    
}

#pragma mark - ToolBarTextField Delegate Methods
#pragma mark   ToolBarTextField的代理方法的实现

- (void)doneButtonClicked:(id)sender{
    
    if ([self.userAddressTextField isFirstResponder]) {
        AddressInfoDTO *selectAddress = self.userAddPickerView.selectAddressInfo;
        if (selectAddress.province == nil ||
            selectAddress.city == nil ||
            selectAddress.district == nil ||
            selectAddress.town == nil) {
            return;
        }
        NSString *AddressContent = [NSString stringWithFormat:@"%@ %@ %@ %@", selectAddress.provinceContent, selectAddress.cityContent, selectAddress.districtContent, selectAddress.townContent];
        //在pickerview里组装
        self.userAddressTextField.text = AddressContent;
        
        //把pickview中的id值再传回给全局变量，保证二次进入pickview也是第一次从pickview返回的id
        self.trimProvinceCode = [self trimString:selectAddress.province];
        self.trimcityCode = [self trimString:selectAddress.city];
        self.trimAreaCode = [self trimString:selectAddress.district];
        self.trimTownCode = [self trimString:selectAddress.town];
        
        [self.userAddressTextField resignFirstResponder];
    }else{
        NSInteger certificateTypeRow = [self.certificateTypePicker selectedRowInComponent:0];
        _certificateTypeTextField.text = [self.certificatePickerData objectAtIndex:certificateTypeRow];
        [self.certificateTypeTextField resignFirstResponder];
    }
}

//接口返回id有空格，去除空格
- (NSString *)trimString:(NSString *)beforeString{
    
    NSString *endString = [beforeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return endString;
    
}

- (void)cancelButtonClicked:(id)sender
{
    [self.userAddressTextField resignFirstResponder];
    [self.certificateTypeTextField resignFirstResponder];
}

#pragma mark - Picker Data Source Methods
#pragma mark   PickerView 的代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.certificatePickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.certificatePickerData objectAtIndex:row];
}


#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
            return 8;
        }
        return 6;
        
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 60;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return self.activateView;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return L(@"activated_integral");
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *activateIntegralIdentifier = @"activateIntegralIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activateIntegralIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:activateIntegralIdentifier];
        cell.backgroundColor = [UIColor cellBackViewColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = L(@"Integral balance");
            [cell.contentView addSubview:self.integralBalanceLabel];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        
        NSInteger row = indexPath.row;
        
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
            if (row == 0) {
                cell.textLabel.text = L(@"PhoneNum");
                [cell.contentView addSubview:self.phoneNumTextField];
                return cell;
            }else if(row == 1){
                cell.textLabel.text = L(@"Identifying");
                [cell.contentView addSubview:self.identifyingTextField];
                [cell.contentView addSubview:self.getIdentifyingBtn];
                return cell;
            }else{
                row = row -2;
            }
        }
        
        switch (row) {
            case 0:
            {
                cell.textLabel.text = L(@"Name");
                [cell.contentView addSubview:self.userNameTextField];
                break;
            }
            case 1:
            {
                cell.textLabel.text = L(@"Select sex");
                [cell.contentView addSubview:self.sexSegmentedControl];
                break;
            }
                
            case 2:
            {
                cell.textLabel.text = L(@"CertificateType");
                [cell.contentView addSubview:self.certificateTypeTextField];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case 3:
            {
                cell.textLabel.text = L(@"CertificateNum");
                [cell.contentView addSubview:self.certificateTextField];
                break;
            }
            case 4:
            {
                cell.textLabel.text = L(@"Address");
                [cell.contentView addSubview:self.userAddressTextField];
                break;
            }
            case 5:
            {
                cell.textLabel.text = nil;
                [cell.contentView addSubview:self.detailTextField];
                break;
            }
        }
    }
    
    return cell;
}

#pragma mark - UITextField Delegate Methods
#pragma mark   UITextField 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{ 
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法

- (MyIntegralService *)service{
    
    if (!_service) {
        _service = [[MyIntegralService alloc] init];
        _service.delegate = self;
    }
    
    return _service;
    
}


- (TPKeyboardAvoidingTableView *)tpkTableView{
    
    if (!_tpkTableView) {
		_tpkTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                     style:UITableViewStyleGrouped];    
		[_tpkTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_tpkTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_tpkTableView.scrollEnabled = YES;
		_tpkTableView.delegate =self;
		_tpkTableView.dataSource =self;
		_tpkTableView.backgroundColor =[UIColor clearColor];
        _tpkTableView.backgroundView = nil;
    }
    return  _tpkTableView;
}

//云钻余额输入框
- (OHAttributedLabel *)integralBalanceLabel{
    
    if (!_integralBalanceLabel) {
        _integralBalanceLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        _integralBalanceLabel.backgroundColor = [UIColor clearColor];
        _integralBalanceLabel.textAlignment = UITextAlignmentLeft;
    }
    return _integralBalanceLabel;
}

//姓名输入框
- (UITextField *)userNameTextField{
    
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, 200, 30)];
        _userNameTextField.placeholder = L(@"required");
        _userNameTextField.backgroundColor = [UIColor clearColor];
        _userNameTextField.delegate = self;
        _userNameTextField.returnKeyType = UIReturnKeyDone;
        _userNameTextField.borderStyle = UITextBorderStyleNone;
        _userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTextField.keyboardType = UIKeyboardTypeDefault;
        NSString *str = self.service.activateIntegralDto.integralName;
        
        _userNameTextField.text = str;
    }
    return _userNameTextField;
}

//性别类型选择框
- (UISegmentedControl *)sexSegmentedControl
{
    if (!_sexSegmentedControl)
    {
        _sexSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:L(@"Male"), L(@"Female"), nil]];
//        [_sexSegmentedControl.layer setImage:[UIImage imageNamed: @"yellowButton.png"]];
//        [_sexSegmentedControl.layer setImage:[UIImage imageNamed: @"yellowButton.png"] forSegmentAtIndex:1];
        
//        [_sexSegmentedControl setBackgroundImage:[UIImage imageNamed: @"yellowButton.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        if ([self.sexType isEqualToString:@"M"])
        {
            [_sexSegmentedControl setSelectedSegmentIndex:0];
        }
        if ([self.sexType isEqualToString:@"F"])  
        {
            [_sexSegmentedControl setSelectedSegmentIndex:1];
        }
        _sexSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        _sexSegmentedControl.frame = CGRectMake(180, 5, 100, 30);
//        _sexSegmentedControl.tintColor = RGBCOLOR(48, 178, 236);
        _sexSegmentedControl.tintColor = RGBCOLOR(236, 184, 0);

        [_sexSegmentedControl addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventValueChanged];
    }
    return _sexSegmentedControl;
}
//证件号码输入框
- (UITextField *)certificateTextField{
    
    if (!_certificateTextField) {
        _certificateTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, 220, 30)];
        _certificateTextField.placeholder = L(@"required");
        _certificateTextField.backgroundColor = [UIColor clearColor];
        _certificateTextField.delegate = self;
        _certificateTextField.borderStyle = UITextBorderStyleNone;
        _certificateTextField.returnKeyType = UIReturnKeyDone;
        _certificateTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _certificateTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _certificateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _certificateTextField.text = self.service.activateIntegralDto.integralIdCode;
    }
    return _certificateTextField;
}

//详细地址输入框
- (UITextField *)detailTextField{
    
    if (!_detailTextField) {
        _detailTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 280, 30)];
        _detailTextField.placeholder = L(@"Please enter detail address");
        _detailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _detailTextField.backgroundColor = [UIColor clearColor];
        _detailTextField.delegate = self;
        _detailTextField.textAlignment = UITextAlignmentCenter;
        _detailTextField.borderStyle = UITextBorderStyleNone;
        _detailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _detailTextField.keyboardType = UIKeyboardTypeDefault;
        _detailTextField.returnKeyType = UIReturnKeyDone;
//        _detailTextField.text = self.service.activateIntegralDto.integralDetAdd;
    }
    return _detailTextField;
}

//用户地址选择框
- (ToolBarTextField *)userAddressTextField{
    
    if (!_userAddressTextField) {
        _userAddressTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(80, 5, 220, 30)];
        _userAddressTextField.backgroundColor = [UIColor clearColor];
        _userAddressTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userAddressTextField.inputView = self.userAddPickerView;
        _userAddressTextField.placeholder = L(@"Please select province and city");
        _userAddressTextField.delegate = self;
        _userAddressTextField.toolBarDelegate = self;
        _userAddressTextField.font = [UIFont fontWithName:@"Heiti k" size:16.0];
    }
    return _userAddressTextField;
}

- (AddressInfoPickerView *) userAddPickerView
{
    if (!_userAddPickerView)
    {
        AddressInfoDTO *defaultAddress = [[AddressInfoDTO alloc] init];
        defaultAddress.province = _trimProvinceCode;
        defaultAddress.city = _trimcityCode;
        defaultAddress.district = _trimAreaCode;
        defaultAddress.town = _trimTownCode;
        
        _userAddPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:defaultAddress compentCount:4];
        
    }
    return _userAddPickerView;
}

//证件类型选择框
- (ToolBarTextField *)certificateTypeTextField{
    
    if (!_certificateTypeTextField) {
        _certificateTypeTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(80, 5, 220, 30)];
        _certificateTypeTextField.backgroundColor = [UIColor clearColor];
        _certificateTypeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _certificateTypeTextField.inputView = self.certificateTypePicker;
        _certificateTypeTextField.delegate = self;
        _certificateTypeTextField.tag = 9;
        _certificateTypeTextField.toolBarDelegate = self;
        _certificateTypeTextField.text = IsStrEmpty(self.service.activateIntegralDto.integralCardType)?L(@"001"):[self returnCertificateType:self.service.activateIntegralDto.integralCardType ];
        _certificateTypeTextField.placeholder = L(@"Please select certificateType");
        _certificateTypeTextField.font = [UIFont fontWithName:@"Heiti k" size:16.0];
    }
    return _certificateTypeTextField;
}


- (UIPickerView *)certificateTypePicker{
    
    if (!_certificateTypePicker) {
        _certificateTypePicker = [[UIPickerView alloc] init];
        _certificateTypePicker.delegate = self;
        _certificateTypePicker.dataSource = self;
        _certificateTypePicker.showsSelectionIndicator = YES;
    }
    return _certificateTypePicker;
}

- (UIView *)activateView{
    if (!_activateView) {
        _activateView = [[UIView alloc] initWithFrame:CGRectZero];
        UIButton *activateBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
        [activateBtn addTarget:self action:@selector(activateIntegral:) forControlEvents:UIControlEventTouchDown];
        [activateBtn setBackgroundImage:[UIImage imageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
        [activateBtn setBackgroundImage:[UIImage imageNamed:@"orange_button.png"] forState:UIControlStateNormal];

        [activateBtn setTitle:L(@"activated_integral") forState:UIControlStateNormal];
        [activateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        activateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        //activateBtn.titleLabel.textAlignment = UITextAlignmentCenter;
       // activateBtn.layer.cornerRadius = 5;
        activateBtn.tag = kActivateBtnTag;
        [_activateView addSubview:activateBtn];
        TT_RELEASE_SAFELY(activateBtn);
    }
    return _activateView;
}

#pragma mark -  CheckCode
#pragma mark    验证码

- (CheckCodeService *)checkCodeService{
    if (!_checkCodeService) {
        _checkCodeService = [[CheckCodeService alloc] init];
        _checkCodeService.delegate = self;
    }
    return _checkCodeService;
}


//手机号码输入框
- (UITextField *)phoneNumTextField{
    
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, 200, 30)];
        _phoneNumTextField.placeholder = L(@"required");
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.backgroundColor = [UIColor clearColor];
        _phoneNumTextField.delegate = self;
        _phoneNumTextField.borderStyle = UITextBorderStyleNone;
        _phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneNumTextField;
}
//验证码输入框
- (UITextField *)identifyingTextField{
    
    if (!_identifyingTextField) {
        _identifyingTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, 100, 30)];
        _identifyingTextField.placeholder = L(@"required");
        _identifyingTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _identifyingTextField.backgroundColor = [UIColor clearColor];
        _identifyingTextField.delegate = self;
        _identifyingTextField.returnKeyType = UIReturnKeyDone;
        _identifyingTextField.borderStyle = UITextBorderStyleNone;
        _identifyingTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _identifyingTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return _identifyingTextField;
}

//获取验证码按钮
- (UIButton *)getIdentifyingBtn{
    
    if (!_getIdentifyingBtn) {
        _getIdentifyingBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 5, 100, 30)];
        [_getIdentifyingBtn setTitle:L(@"Get indentify") forState:UIControlStateNormal];
        [_getIdentifyingBtn setTitleColor:RGBCOLOR(82, 92, 137) forState:UIControlStateNormal];
        [_getIdentifyingBtn setBackgroundImage:[UIImage imageNamed:kProductDetailAddToShoppingCarWithNoStore] forState:UIControlStateNormal];
        _getIdentifyingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _getIdentifyingBtn.backgroundColor = [UIColor clearColor];
        _getIdentifyingBtn.layer.cornerRadius = 5;
        [_getIdentifyingBtn addTarget:self action:@selector(getIdentifying:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getIdentifyingBtn;
}

- (Calculagraph *)calculagraph
{
    if (!_calculagraph) {
        _calculagraph = [[Calculagraph alloc] init];
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
    return _calculagraph;
}



#pragma mark -
#pragma mark calculagraph delegate methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        NSInteger seconds = [[change objectForKey:@"new"] integerValue];

        if (120 - seconds == 0) {
            [self.calculagraph stop];
            [self.getIdentifyingBtn setTitle:L(@"Get indentify") forState:UIControlStateNormal];
            self.getIdentifyingBtn.userInteractionEnabled = YES;
        }else{
            [self.getIdentifyingBtn setTitle:[NSString stringWithFormat:@"%d%@",120 - seconds,L(@"Seconds")] forState:UIControlStateNormal];
        }
    }
}


@end
