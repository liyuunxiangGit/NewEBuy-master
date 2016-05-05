//
//  MobilePaymentView.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MobilePaymentView.h"
#import "ValidationService.h"
#import "MobilePayHelpViewController.h"
#import "MobilePayQueryViewController.h"
#import "NSAttributedString+Attributes.h"
#import "SNABContactsHelper.h"
#import "SNLocalWebViewController.h"
#import "SNUILabel.h"

#define PRICESELECT_TITLE_KEY  @"title"
#define PRICESELECT_PRICE_KEY  @"value"

#define KEYPATH_PHONENUM       @"phoneNum"
#define KEYPATH_CHARGEMONEY    @"chargeMoney"

#define KEYPATH_ISCANPAY               @"isGetrechargeInfoSuccess"

#define TAG_ORIGIN                      1000
#define kIOs8AlertTag                   5555  

#define kTextFieldWidth                 260
#define kTextFieldHeight                40
#define kLeftMargin                     30.0
#define kTopMargin                      15.0
#define kTextFieldFontSize              14.0

#define kPriceButton_Height             (iPhone5?45:40)
#define kPriceButton_Width              85

#define kSegmentationSymbol @"     "
#define kNotInContact L(@"VPNotInAddressBook")
#define kNotInContactNotShow @" "


#define kLeftLabelTag  11111
#define kRightLabelTag  22222




@interface MobilePaymentView(){
    
    BOOL                       isPhoneNumChanged_;
    
    BOOL                       isBackFromAddressBook_;
    
//    BOOL                       isViewDissmiss_;
    
    //上一次的号码归属地查询的号码，避免点击按钮时候的重复接口请求
    NSString                  *preSelectPhoneNum_;
    
    NSInteger                  selectedButtonTag_;
    
    payMobileOrderDTO          *payOrderData_;
    
    
}


//价格选择数据源
@property (nonatomic, strong) NSArray                   *priceSelectArr;

@property (nonatomic, strong) UILabel                   *providerNOLable;

@property (nonatomic, strong) OHAttributedLabel         *reducemoneyLable;
//@property (nonatomic, retain) UILabel                   *productInfo;

@property (nonatomic, strong) UILabel                   *reducemoneyPriceLable;

@property (nonatomic, strong) UIButton                  *addressBookBtn;

@property (nonatomic, strong) UIButton                  *settlementBtn;

@property (nonatomic, strong) UIButton                  *payHistoryBtn;

@property (nonatomic, strong) NSArray                   *selectData;

//充值金额筛选区域【包含30、50、100、300按钮】
@property (nonatomic, strong) UIView                    *priceButtonsView;

//充值信息展示区域【包含号码归属地、优惠金额、充值人姓名Label】
@property (nonatomic, strong) UIView                    *rechargeInfoAreaView;

//页面下端的view 【包含支付按钮、支付历史查询按钮】
@property (nonatomic, strong) UIView                    *bottomAreaView;
//页面最上端的view 【包含手机好吗输入框、联系人选择按钮】
@property (nonatomic, strong) UIView                    *topAreaView;

@property (nonatomic, strong) MobileRechargeNewService  *service;

@property (nonatomic, strong) SNDropDownMenuViewController *dropDownMenuViewController;

@property (nonatomic, strong) NSMutableArray  *remindPhoneNumArr;

@property (nonatomic, strong) NSString        *chargeMoney;
@property (nonatomic, strong) NSString        *phoneNum;

@property (nonatomic, assign) BOOL            isGetrechargeInfoSuccess;

@property (nonatomic, strong) UIImageView     *operatorIcon;

@property (nonatomic, strong) UILabel         *contactName;//behind phoneNum used showing name

//数据初始化
- (void)dataInit;
//- (void)naviItemsInit;
//获取手机号码的归属地、运营商以及充值金额的优惠信息。
- (void)getAllInfo;
- (NSString *)getName:(ABRecordRef) person;

- (NSArray *)getMatchedArr:(NSString *)letters;

- (BOOL)validateAll;

- (BOOL)validateMobile:(NSString *)phoneNum;

@end

@implementation MobilePaymentView
@synthesize priceSelectArr = _priceSelectArr;
@synthesize mobileNumberTextField  = _mobileNumberTextField;
@synthesize providerNOLable = _providerNOLable;
@synthesize reducemoneyLable = _reducemoneyLable;
@synthesize addressBookBtn=_addressBookBtn;
@synthesize settlementBtn=_settlementBtn;
@synthesize payHistoryBtn=_payHistoryBtn;
@synthesize selectData=_selectData;
@synthesize reducemoneyPriceLable=_reducemoneyPriceLable;
@synthesize service=_service;
@synthesize priceButtonsView = _priceButtonsView;
@synthesize bottomAreaView = _bottomAreaView;
@synthesize rechargeInfoAreaView = _rechargeInfoAreaView;
@synthesize topAreaView = _topAreaView;
@synthesize dropDownMenuViewController = _dropDownMenuViewController;
@synthesize remindPhoneNumArr = _remindPhoneNumArr;
@synthesize chargeMoney = _chargeMoney;
@synthesize phoneNum = _phoneNum;
@synthesize isGetrechargeInfoSuccess = _isGetrechargeInfoSuccess;
@synthesize isActivity = _isActivity;
@synthesize contentController=_contentController;
@synthesize operatorIcon = _operatorIcon;

//@synthesize productInfo =_productInfo;

- (void)dealloc {
    [self removeObserver:self forKeyPath:KEYPATH_CHARGEMONEY];
    [self removeObserver:self forKeyPath:KEYPATH_ISCANPAY];
    [self removeObserver:self forKeyPath:KEYPATH_PHONENUM];
    
    TT_RELEASE_SAFELY(_priceSelectArr);
    TT_RELEASE_SAFELY(_mobileNumberTextField);
    TT_RELEASE_SAFELY(_providerNOLable);
    TT_RELEASE_SAFELY(_reducemoneyLable);
    TT_RELEASE_SAFELY(_addressBookBtn);
    TT_RELEASE_SAFELY(_settlementBtn);
    TT_RELEASE_SAFELY(_payHistoryBtn);
    TT_RELEASE_SAFELY(_selectData);
    TT_RELEASE_SAFELY(_reducemoneyPriceLable);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_priceButtonsView);
    TT_RELEASE_SAFELY(_bottomAreaView);
    TT_RELEASE_SAFELY(_rechargeInfoAreaView);
    TT_RELEASE_SAFELY(_topAreaView);
    TT_RELEASE_SAFELY(_dropDownMenuViewController);
    TT_RELEASE_SAFELY(_remindPhoneNumArr);
    TT_RELEASE_SAFELY(_chargeMoney);
    TT_RELEASE_SAFELY(_phoneNum);
    TT_RELEASE_SAFELY(_contentController);
    TT_RELEASE_SAFELY(_operatorIcon);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

- (void)setIsActivity:(BOOL)isActivity
{
    _isActivity = isActivity;
    
    if (!_isActivity)
    {
        [self.mobileNumberTextField resignFirstResponder];
    }
}

#pragma mark - ViewLife Circle Methods
#pragma mark   View的生命周期方法

- (id)initWithContentController:(CommonViewController *)controller
{
    self = [super init];
    if (self) {
        self.contentController = controller;
        
        [self  dataInit];
                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMobilePayOrderList) name:QUERY_MOBILE_RECORD object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMobilePayment) name:PAY_MOBILE_AGAIN object:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_PHONENUM options:NSKeyValueObservingOptionOld context:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_CHARGEMONEY options:NSKeyValueObservingOptionOld context:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_ISCANPAY options:NSKeyValueObservingOptionNew context:nil];
        
        self.isActivity = YES;
        
        isChangePhoneNum = NO;
        
        //如果手机号码为空
        if (IsStrEmpty(self.phoneNum)) {
            self.isGetrechargeInfoSuccess = NO;
            
            //[self.mobileNumberTextField becomeFirstResponder];
        }else{
            if (!self.isGetrechargeInfoSuccess && [self validateMobileAndHint:self.phoneNum]) {
                self.mobileNumberTextField.text = self.phoneNum;
                
                if (ABAddressBookGetAuthorizationStatus()!=kABAuthorizationStatusAuthorized) {
                    self.contactName.text = kNotInContactNotShow;
                }else{
                    [self checkNumberWhetherInAB:self.mobileNumberTextField.text];//显示通讯录中对应的姓名
                }
                
                isFisrt = YES;
                [self getAllInfo];
            }
        }
    }
    return self;
}

-(void)showKeyboard
{
    [self.mobileNumberTextField becomeFirstResponder];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (keyPath && [keyPath isEqualToString:KEYPATH_PHONENUM]) {
        self.mobileNumberTextField.text = self.phoneNum;
        [self.mobileNumberTextField resignFirstResponder];
        //        NSString *prePhoneNum = [change objectForKey:NSKeyValueChangeOldKey];
        if (self.isActivity) {
            if ([self validateMobileAndHint:self.phoneNum]) {//  && ![self.phoneNum isEqualToString:prePhoneNum]
                [self.contentController displayOverFlowActivityView];
                
                [self getAllInfo];
            }
            else
            {
                self.isGetrechargeInfoSuccess=NO;
            }
        }
        
    }
    
    if (keyPath && [keyPath isEqualToString:KEYPATH_CHARGEMONEY]) {
        NSString *preChargeMoney = [change objectForKey:NSKeyValueChangeOldKey];
        if ([self validateMobile:_mobileNumberTextField.text] && self.chargeMoney && ![self.chargeMoney isEqualToString:preChargeMoney]) {
            [self.contentController displayOverFlowActivityView];
            //修复11位
            if (![self.phoneNum isEqualToString:self.mobileNumberTextField.text])
            {
                self.phoneNum = self.mobileNumberTextField.text;
            }
            if (IsStrEmpty(_providerNOLable.text)) {
                [self getAllInfo];
            }else{
                [self.service beginGetCheckPreferential:self.phoneNum money:self.chargeMoney];
            }
        }
    }
    if (keyPath && [keyPath isEqualToString:KEYPATH_ISCANPAY]) {
        BOOL isCanpay = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        self.settlementBtn.enabled = isCanpay;
        if (!isCanpay) {
            _rechargeInfoAreaView.hidden = YES;
            _providerNOLable.text = @"";
            _bottomAreaView.frame = CGRectMake(0, iPhone5?262:242, 320, 140);
        }
    }
}
- (void)dataInit{
    
    _priceSelectArr = [[NSArray alloc] initWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"10 yuan"),PRICESELECT_TITLE_KEY, @"1000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"20 yuan"),PRICESELECT_TITLE_KEY, @"2000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"30 yuan"),PRICESELECT_TITLE_KEY, @"3000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"50 yuan"),   PRICESELECT_TITLE_KEY, @"5000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"100 yuan"),PRICESELECT_TITLE_KEY, @"10000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"200 yuan"),PRICESELECT_TITLE_KEY, @"20000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"300 yuan"),PRICESELECT_TITLE_KEY, @"30000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"500 yuan"),PRICESELECT_TITLE_KEY, @"50000",PRICESELECT_PRICE_KEY,nil],
                       nil];
    
    _remindPhoneNumArr = [[NSMutableArray alloc] init];
    
    payOrderData_ = [[payMobileOrderDTO alloc] init];
    
    NSDictionary *dic = [self.priceSelectArr objectAtIndex:3];
    
    self.chargeMoney = [dic objectForKey:PRICESELECT_PRICE_KEY];
    
    self.phoneNum = IsNilOrNull([Config currentConfig].payMobileNum)?@"":[Config currentConfig].payMobileNum;
    
    selectedButtonTag_ = TAG_ORIGIN + 4;
    
    _isGetrechargeInfoSuccess = NO;
    
    isBackFromAddressBook_ = NO;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (isFisrt) {
        [self.contentController displayOverFlowActivityView];
        isFisrt=NO;
    }
    
    [self topAreaView];
    
    self.priceButtonsView.frame = CGRectMake(0, self.topAreaView.bottom + 13, self.priceButtonsView.width, self.priceButtonsView.height);
  
    UIButton *button = (UIButton *)[self.priceButtonsView viewWithTag:selectedButtonTag_];
    
    [button setSelected:YES];

    [self addSubview:self.bottomAreaView];
    
    if (![self regExpPhoneNum:_mobileNumberTextField.text]&&!isChangePhoneNum)
    {
        _bottomAreaView.frame = CGRectMake(0, iPhone5?262:242
, 320, 140);
        
    }

    if (isBackFromAddressBook_) {
        
        isBackFromAddressBook_ = NO;
        
        return;
    }
}

#pragma mark -
#pragma mark    页面跳转方法

- (void)helpButtonHeadler:(id)sender{
    
    [self.mobileNumberTextField resignFirstResponder];
    
    MobilePayHelpViewController *controller = [[MobilePayHelpViewController alloc] init];
    
    [self.contentController.navigationController pushViewController:controller animated:YES];
    
    
}

- (void)gotoMobilePayOrderList{
    
    [self.contentController.navigationController popToViewController:self.contentController animated:NO];
    MobilePayQueryViewController *_mobilePayQueryViewController = [[MobilePayQueryViewController alloc] init];
    [self.contentController.navigationController pushViewController:_mobilePayQueryViewController animated:YES];
    TT_RELEASE_SAFELY(_mobilePayQueryViewController);
}

-(void)gotoMobilePayment{
    [self.contentController.navigationController popToViewController:self.contentController animated:NO];
}

- (void)payNextHeadler:(id)sender{
    
    if (![self validateAll]) {
        return;
    }
        
    MobilePayViewController *nextController = [[MobilePayViewController alloc] init];
    
    nextController.paySource = payOrderData_;
    
    [self.contentController.navigationController pushViewController: nextController animated:YES];
    
    TT_RELEASE_SAFELY(nextController);
    
}

- (void)gotoPayHistory:(id)sender{
    MobilePayQueryViewController *_mobilePayQueryViewController = [[MobilePayQueryViewController alloc] init];
    [self.contentController.navigationController pushViewController:_mobilePayQueryViewController animated:YES];
}


#pragma mark -  Validate Data Methods
#pragma mark    数据有效性验证

- (BOOL)validateAll{
    
    if (!self.isGetrechargeInfoSuccess) {
        //"No_chargeInfo"="充值信息获取失败，请刷新页面重新获取";
        [self.contentController presentSheet:L(@"No_chargeInfo") posY:50];
        return NO;
    }
    
    if (![self validateMobileAndHint:payOrderData_.mobileNumber]) {
        return NO;
    }
    
    //add by wangjiaxing 
    if (![self validateMobileAndHint:self.mobileNumberTextField.text]) {
        return NO;
    }
    
    if (IsStrEmpty(payOrderData_.mobilequo)) {
        //"No_mobileQuo"="未查询到您的号码归属地，请刷新页面重新获取";
        [self.contentController presentSheet:L(@"No_mobileQuo") posY:50];
        return NO;
    }
    
    if (IsStrEmpty(payOrderData_.payPrice)){
        //"No_payPrice"="充值金额获取失败，请重新选择";
        [self.contentController presentSheet:L(@"No_payPrice") posY:50];
        return NO;
    }
    
    if (IsStrEmpty(payOrderData_.factPayPrice)) {
        //"No_factPayPrice"="优惠金额获取失败，请刷新页面重新获取";
        [self.contentController presentSheet:L(@"No_factPayPrice") posY:50];

        return NO;
    }
    
    return YES;
    
}

- (BOOL)validateMobileAndHint:(NSString *)phoneNum{
    NSError *error = [ValidationService phoneNumChecking:phoneNum];
    if (error.code == kValidationFail) {
        NSString *errorDesc = [NSString stringWithFormat:@"PhoneNum_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        [self.contentController presentSheet:L(errorDesc) posY:50];
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)validateMobile:(NSString *)phoneNum{
    NSError *error = [ValidationService phoneNumChecking:phoneNum];
    if (error.code == kValidationFail) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark -  DropDownMenu Methods
#pragma mark    下拉列表的方法实现

- (CGFloat)dropDownMenu:(UITableView *)dropDownMenuView heghtForRowAtIndextPath:(NSIndexPath *)indextPath{
    
    return 34;
}


- (UITableViewCell *)dropDownMenu:(UITableView *)dropDownMenuView cellForRowAtIndextPath:(NSIndexPath *)indextPath{
    
    static NSString *identify = @"SNDropDownCell";
    UITableViewCell *cell = [dropDownMenuView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
        [self addLabelsToCell:cell];
    }
    if (!IsNilOrNull(self.remindPhoneNumArr)&&!([self.remindPhoneNumArr count]-1<indextPath.row)) {
        NSString *showStrs = [self.remindPhoneNumArr objectAtIndex:indextPath.row];
        
        SNUILabel *label1 =(SNUILabel *)[cell.contentView  viewWithTag:kLeftLabelTag];
        NSArray *arr = [showStrs componentsSeparatedByString:kSegmentationSymbol];
        if (arr)
        {
            if ([arr safeObjectAtIndex:1])
                label1.text = [arr safeObjectAtIndex:1];
            else
                label1.text = kNotInContactNotShow;
        }
        else
            label1.text = kNotInContactNotShow;
        
        if ([label1.text isEqualToString:kNotInContactNotShow]) {
            label1.textColor = [UIColor colorWithHexString:@"#A2A2A2"];
            label1.text = kNotInContact;
        }else{
            label1.textColor = [UIColor colorWithHexString:@"#313131"];
        }
        
        
        SNUILabel *label2 =(SNUILabel *)[cell.contentView  viewWithTag:kRightLabelTag];
        label2.text = [[showStrs componentsSeparatedByString:kSegmentationSymbol] objectAtIndex:0];
    }
    return cell;
    
}

- (void)addLabelsToCell:(UITableViewCell *)cell
{
    SNUILabel *label1 = [[SNUILabel alloc]initWithColor:[UIColor colorWithHexString:@"#313131"] font:[UIFont systemFontOfSize:13]];
    label1.frame = CGRectMake(20, 0, kScreenWidth/2.0-20, 34);
    label1.tag  = kLeftLabelTag;
    [cell.contentView addSubview:label1];
    
    SNUILabel *label2 = [[SNUILabel alloc]initWithColor:[UIColor colorWithHexString:@"#707070"] font:[UIFont systemFontOfSize:14]];
    label2.frame = CGRectMake(kScreenWidth/2.0, 0, kScreenWidth/2-20, 34);
    label2.textAlignment = NSTextAlignmentRight;
    label2.tag = kRightLabelTag;
    [cell.contentView addSubview:label2];
}

- (void)dropDownMenu:(UITableView *)dropDownMenuView didSelectRowAtIndextPath:(NSIndexPath *)indextPath{
    
    if (!IsNilOrNull(self.remindPhoneNumArr)&&!([self.remindPhoneNumArr count]-1<indextPath.row)) {
        NSArray *array = [[self.remindPhoneNumArr objectAtIndex:indextPath.row] componentsSeparatedByString:kSegmentationSymbol];
        self.phoneNum = [array objectAtIndex:0];
    }
    
    [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
}


#pragma mark -   ABPeoplePickerNavigationController Method
#pragma mark     地址簿相关方法

- (void)gotoAddressBook:(id)sender{
    
    if (_dropDownMenuViewController) {
        
        [_dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];

    }
    
    isBackFromAddressBook_ = YES;
    
    
    if (!IOS6_OR_LATER && [[Config currentConfig].isFirstUseAddress isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:L(@"system-error")
                                                        message:L(@"VPEbuyWantToVisitYourAddressBook")
                                                       delegate:(id)self
                                              cancelButtonTitle:L(@"VPNoPermission")
                                              otherButtonTitles:L(@"BTOk"),nil];
        alert.tag = kIOs8AlertTag-1;
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
                                                                 
                                                                 [wself.contentController presentSheet:L(@"VPPleaseOpenThePermissionOfAddressBook") posY:50];
                                                                 
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
    
    [self.contentController presentModalViewController:picker animated:YES];
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kIOs8AlertTag-1) {
        if (buttonIndex == 1)
        {
            [Config currentConfig].isFirstUseAddress = @"1";
            [self gotoAddressBook:nil];
        }
    }
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self.contentController dismissModalViewControllerAnimated:YES];
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
    
    self.contactName.text = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName(person));
    if (self.contactName.text.length>5) {
        self.contactName.text = [self.contactName.text substringToIndex:5];
    }
    self.contactName.hidden = NO;

	self.phoneNum = phoneStr;
    
    [self.contentController dismissModalViewControllerAnimated:YES];
    
    [self.mobileNumberTextField resignFirstResponder];
    
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
    
    self.contactName.text = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName(person));
    if (self.contactName.text.length>5) {
        self.contactName.text = [self.contactName.text substringToIndex:5];
    }

    self.contactName.hidden = NO;
    
    self.phoneNum = phoneStr;
    
    [self.contentController dismissModalViewControllerAnimated:YES];
    
    [self.mobileNumberTextField resignFirstResponder];

}

#endif

- (NSString *)getName:(ABRecordRef) person
{
	NSString *firstNameValue = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
	NSString *lastNameValue = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
	NSString *bizValue = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonOrganizationProperty));
	
    NSString *firstName = [NSString stringWithFormat:@"%@", firstNameValue];
    NSString *lastName = [NSString stringWithFormat:@"%@", lastNameValue];
    NSString *biz = [NSString stringWithFormat:@"%@", bizValue];
    
	
	if ((!firstName) && !(lastName))
	{
		if (biz) return biz;
		return @"No name supplied";
	}
	
	if (!lastName) lastName = @"";
    if (!firstName) firstName = @"";
    
    return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}
#pragma mark -  PriceButton Tap Methods
#pragma mark    充值金额选择事件的处理方法

- (void)selectPrice:(id)sender{
    
//    if (![self validateMobile:self.mobileNumberTextField.text]) {
//        return;
//    }
    
    [self.mobileNumberTextField resignFirstResponder];
    
    UIButton *tapedButton = sender;
    
    if (tapedButton.tag == selectedButtonTag_ && self.isGetrechargeInfoSuccess) {
        return;
    }else{
        
        NSDictionary *dic = [self.priceSelectArr objectAtIndex:tapedButton.tag - TAG_ORIGIN -1];
        UIButton *button = (UIButton *)[self.priceButtonsView viewWithTag:selectedButtonTag_];
        [button setSelected:NO];
        selectedButtonTag_ = tapedButton.tag;
        [tapedButton setSelected:YES];
        
        self.chargeMoney = [dic objectForKey:PRICESELECT_PRICE_KEY];
    }
}

#pragma mark -  HTTP Methods
#pragma mark    数据请求的方法实现

- (void)getAllInfo{
    
    [Config currentConfig].payMobileNum = self.phoneNum;
    
    [self.service beginGetCheckMobileNumber:self.phoneNum];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObjectsFromArray:[Config currentConfig].phoneNumData];
    
    
    if (!IsNilOrNull([Config currentConfig].phoneNumData)) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",self.phoneNum];
        NSArray *filterArray = [arr filteredArrayUsingPredicate:predicate];
        if (filterArray.count){
            [arr removeObjectsInArray:filterArray];
            
        }

        NSString *numberAndName = nil;
        if (self.contactName.text.length>0) {
            numberAndName = [NSString stringWithFormat:@"%@%@%@",self.phoneNum,kSegmentationSymbol,self.contactName.text];
        }else{
            numberAndName = self.phoneNum;
        }
        [arr insertObject:numberAndName atIndex:0];
        [Config currentConfig].phoneNumData = arr;
            TT_RELEASE_SAFELY(arr);
    }
}

- (void)getCheckMobileNumberHttpRequestCompletedWithService:(MobileRechargeNewService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self.contentController removeOverFlowActivityView];
    
    if (isSucess) {
        
        [self.service beginGetCheckPreferential:self.phoneNum money:self.chargeMoney];
        
        self.settlementBtn.enabled = YES;
        
        NSString *provinceName = NotNilAndNull(service.provinceName)?service.provinceName:@"";
        
        NSString *ispName = NotNilAndNull(service.ispName)?service.ispName:@"";
        
        if ([self.rechargeInfoAreaView superview]==nil) {
            
            [self addSubview:self.rechargeInfoAreaView];
            
        }
        _rechargeInfoAreaView.hidden = NO;
        
        _bottomAreaView.frame = CGRectMake(0, iPhone5?320:270, 320, 140);
       
        _providerNOLable.text = [NSString stringWithFormat:@"%@%@",provinceName,ispName];
        
        if ([ispName isEqualToString:L(@"Telecom")]) {
            _operatorIcon.image = [UIImage imageNamed:@"Telecom_new"];
            _providerNOLable.left = 52;
        }else if ([ispName isEqualToString:L(@"Mobile")]){
            _operatorIcon.image = [UIImage imageNamed:@"Mobile_new"];
            _providerNOLable.left = 52;
        }else if ([ispName isEqualToString:L(@"Unicom")]){
            _operatorIcon.image = [UIImage imageNamed:@"Unicom_new"];
            _providerNOLable.left = 52;
        }else{
            _operatorIcon.image = [UIImage imageNamed:@""];
            _providerNOLable.left = 15;
        }
        
        payOrderData_.mobileNumber = self.phoneNum;
        
        payOrderData_.mobilequo = service.numberInfo;
        
        payOrderData_.yifubaoMoney =[UserCenter defaultCenter].userInfoDTO.yifubaoBalance;
        
        payOrderData_.ispType = service.ispType;
        
        payOrderData_.provinceId = service.provinceId;
        
        payOrderData_.provinceName = service.provinceName;
        
    }else{
        
        [self.contentController presentSheet:L(errorCode) posY:50];
        self.isGetrechargeInfoSuccess = NO;
        
    }
    
}

- (void)getCheckPreferentialHttpRequestCompletedWithService:(MobileRechargeNewService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self.contentController removeOverFlowActivityView];

    if (isSucess) {
        
        if ([self.rechargeInfoAreaView superview]==nil) {
            
            [self addSubview:self.rechargeInfoAreaView];
        }
        
        self.isGetrechargeInfoSuccess = YES;
        
        if (IsStrEmpty(_providerNOLable.text)) {
            self.isGetrechargeInfoSuccess = NO;
        }
        
        self.settlementBtn.enabled = YES;
        
        _rechargeInfoAreaView.hidden = NO;
        
        _bottomAreaView.frame = CGRectMake(0, iPhone5?320:270, 320, 140);
        
        NSString *str =[NSString stringWithFormat:@"%.2f%@",[service.preferentPrice floatValue]/100,L(@"Money Unit")];
        NSMutableAttributedString *priceStr1 = [[NSMutableAttributedString alloc] initWithString:str];
        [priceStr1 setFont:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0,[str length]-1 )];
        [priceStr1 setFont:[UIFont systemFontOfSize:14.0f] range:NSMakeRange([str length]-1,1 )];
        [priceStr1 setTextColor:[UIColor orange_Red_Color] range:NSMakeRange(0, [str length]-1)];
        [priceStr1 setTextColor:[UIColor orange_Red_Color] range:NSMakeRange([str length]-1, 1)];
        self.reducemoneyLable.attributedText = priceStr1;
        
        
        self.providerNOLable.text = [NSString stringWithFormat:@"%@%@",service.provinceName,service.ispName];
        
        if ([service.ispName isEqualToString:L(@"Telecom")]) {
            _operatorIcon.image = [UIImage imageNamed:@"Telecom_new"];
            _providerNOLable.left = 52;
        }else if ([service.ispName isEqualToString:L(@"Mobile")]){
            _operatorIcon.image = [UIImage imageNamed:@"Mobile_new"];
            _providerNOLable.left = 52;
        }else if ([service.ispName isEqualToString:L(@"Unicom")]){
            _operatorIcon.image = [UIImage imageNamed:@"Unicom_new"];
            _providerNOLable.left = 52;
        }else{
            _operatorIcon.image = [UIImage imageNamed:@""];
            _providerNOLable.left = 15;
        }
        
        payOrderData_.factPayPrice = service.preferentPrice;
        payOrderData_.providerNO = service.providerNO;
        payOrderData_.payPrice = self.chargeMoney;
        
    }else{
        
        [self.contentController presentSheet:L(errorCode) posY:50];
        self.isGetrechargeInfoSuccess = NO;
    }
    
}

#pragma mark -  TextField Delegate Methods
#pragma mark    TextField的代理方法实现

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (isBackFromAddressBook_) {
        
        [textField resignFirstResponder];
        return;
    }
    
    [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
    
    if (self.isActivity) {
        if (![self validateMobileAndHint:self.mobileNumberTextField.text]) {
            self.settlementBtn.enabled = NO;
            _rechargeInfoAreaView.hidden = YES;
            _providerNOLable.text = @"";
            _bottomAreaView.frame = CGRectMake(0, iPhone5?262:242, 320, 140);
            
            return;
        }
        else
        {
            self.payHistoryBtn.enabled = YES;
        }
    }
    
    
    //self.phoneNum = self.mobileNumberTextField.text;
    // XZoscar 2014-06-03 modify
    if ([self regExpPhoneNum:textField.text]) {
        //match addressBook contact's name
        self.contactName.hidden = NO;
        
        if (ABAddressBookGetAuthorizationStatus()!=kABAuthorizationStatusAuthorized) {
           self.contactName.text = kNotInContactNotShow;
        }else{
           [self checkNumberWhetherInAB:textField.text];
        }
        
        self.phoneNum = textField.text;
    }
}

//check whether number is in addressbook
- (void)checkNumberWhetherInAB:(NSString *)number
{
    NSArray *names = [SNABContactsHelper namesMatchingPhone:number];
    
    NSArray *sortArr = [self orderByPhoneticize:names];
    
    if (!sortArr.count) {
        self.contactName.text = kNotInContactNotShow;
    }else{
        self.contactName.text = [sortArr firstObject];
        if (self.contactName.text.length>5) {
           self.contactName.text = [self.contactName.text substringToIndex:5];
        }
    }
    
}

- (NSArray *)orderByPhoneticize:(NSArray *)array
{
    if (!array.count>1) {
        return  array;
    }
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSMutableArray      *muArr = [NSMutableArray arrayWithCapacity:1];
    
    for (NSString *str in array) {
        NSMutableString *muStr = [NSMutableString stringWithString:str];
        CFMutableStringRef cfStr =(CFMutableStringRef)CFBridgingRetain(muStr);
        if (CFStringTransform(cfStr, 0, kCFStringTransformMandarinLatin, NO)) {
            NSString *string = (NSString *)CFBridgingRelease(cfStr);
            [muDic setObject:str forKey:string];
            [muArr addObject:string];
        }else{
            [muArr addObject:str];
        }
    }
    
    NSArray *sortArray = [muArr sortedArrayUsingSelector:@selector(compare:)];
    [muArr removeAllObjects];
    for (int i =0; i<sortArray.count; i++) {
        NSString * dicStr = [muDic objectForKey:[sortArray objectAtIndex:i]];
        [muArr addObject:dicStr];
    }
    
    return [NSArray arrayWithArray:muArr];
}

// XZoscar 2014-06-03 add
- (BOOL)regExpPhoneNum:(NSString *)phoneNum {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"1\\d{10}"];
    return [predicate evaluateWithObject:phoneNum];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.contactName.hidden = YES;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //王漫
    //判断手机号码长度不能超过11
    //
    if (textField.text.length >=11 && range.location >= 11) {
        return NO;
    }
    if (textField.text.length + string.length - range.length > 11) {
        
        return NO;
    }
    //
    
    NSMutableString *matchStr = [NSMutableString stringWithString:self.mobileNumberTextField.text];
    
    [matchStr replaceCharactersInRange:range withString:string];
    
    DLog(@"%@", matchStr);
    
    if (IsStrEmpty(matchStr)) {
        
        [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
        
        return YES;
    }
    
    NSArray *matchedArr = [self getMatchedArr:matchStr];
    
    if (matchedArr.count>5) {
        NSMutableArray *mutArray = [NSMutableArray arrayWithArray:matchedArr];
        [mutArray removeObjectsInRange:NSMakeRange(5, matchedArr.count-5)];
        matchedArr = [NSArray arrayWithArray:mutArray];
    }//控制只显示最近充值的5个

    
    [self.remindPhoneNumArr removeAllObjects];
    
    if (IsNilOrNull(matchedArr)||[matchedArr count]==0) {
        
        [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
        
        TT_RELEASE_SAFELY(matchedArr);
        
        //return YES;
        
    }else{
        isChangePhoneNum = YES;
        
        [self.remindPhoneNumArr addObjectsFromArray:matchedArr];
        
        NSString *rowCount = [NSString stringWithFormat:@"%d",[matchedArr count]];
        NSArray *arr = [[NSArray alloc] initWithObjects:rowCount,nil];
        [self.dropDownMenuViewController reloadDataWithNumberOfRowAndSection:arr];
        TT_RELEASE_SAFELY(arr);
        CGRect frame = self.topAreaView.frame;
        frame.origin.y = self.topAreaView.bottom;
        [self.dropDownMenuViewController displayMenuAtFrame:frame Animation:eNoneAnimation];
        [self bringSubviewToFront:self.topAreaView];
        
    }
    
    TT_RELEASE_SAFELY(matchedArr);
    
    if (range.location != 0 &&
        range.length == 0) {
        
        NSMutableString *mStr = [NSMutableString stringWithString:textField.text];
        [mStr insertString:string atIndex:range.location];
        
        if (mStr.length==11&&![self regExpPhoneNum:mStr]) {
            [self.contentController presentSheet:L(@"InputMobileNumber") posY:50];
            return YES;
        }
        
        if ([self regExpPhoneNum:mStr]) {
            textField.text = mStr;
             return [textField resignFirstResponder];
        }
    }
    
    return YES;
}

- (NSArray *)getMatchedArr:(NSString *)letters{
    
    NSMutableArray *phoneNumDataArr = [Config currentConfig].phoneNumData;
    
    NSArray *matchedArr = nil;
    
    if (IsNilOrNull(phoneNumDataArr)) {
        
        return nil;
    }
    
    matchedArr = [phoneNumDataArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self beginswith[cd] %@",letters]];
    
    return matchedArr;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];

    return YES;
}


#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法
//-(CommonViewController *)contentController
//{
//    if (!_contentController) {
//        _contentController=[[CommonViewController alloc] init];
//    }
//    return _contentController;
//}

- (UIView *)priceButtonsView{
    
    if (!_priceButtonsView) {
        
        _priceButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, iPhone5?170:140)];
        
        for (int i = 1 ; i<=8; i++) {
            
            NSDictionary *dic = [self.priceSelectArr objectAtIndex:i-1];
            
            NSString *title = [dic objectForKey:PRICESELECT_TITLE_KEY];
            

            UIButton *button = [[UIButton alloc] init];
            
            button.frame = CGRectMake(15 +(i-1)%3*(kPriceButton_Width+17.5), ((i-1)/3)*((iPhone5?15:10)+kPriceButton_Height), kPriceButton_Width, kPriceButton_Height);
            
            [button setTitle:title forState:UIControlStateNormal];
            
            button.tag = TAG_ORIGIN + i;
            
            [button addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [button setBackgroundImage:[UIImage streImageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage streImageNamed:@"canshu_select_clicked.png"] forState:UIControlStateSelected];
            
            [button setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateSelected];
           
            //button.titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
            button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            
            [button setSelected:NO];
            
            [_priceButtonsView addSubview:button];
            
            TT_RELEASE_SAFELY(button);
            
        }
        
        [self addSubview:_priceButtonsView];
        
    }
    return _priceButtonsView;
    
}

- (UIView *)topAreaView{
    
    if (!_topAreaView) {
        
        _topAreaView = [[UIView alloc]initWithFrame:CGRectMake(0, kTopMargin, 320, 40)];
        UIImageView *separatorLineTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine"]];
        separatorLineTop.frame = CGRectMake(0, 0, _topAreaView.width, 0.5);
        
        UIImageView *separatorLineBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine"]];
        separatorLineBottom.frame = CGRectMake(0, _topAreaView.height-0.5, _topAreaView.width, 0.5);
        
        
        
        [_topAreaView addSubview:self.mobileNumberTextField];
        [_topAreaView addSubview:self.contactName];
        [_topAreaView addSubview:self.addressBookBtn];
        _topAreaView.backgroundColor =[UIColor whiteColor];
        [_topAreaView addSubview:separatorLineTop];
        [_topAreaView addSubview:separatorLineBottom];
        [self addSubview:_topAreaView];
        
    }
    return _topAreaView;
    
}

- (KBNumberPadReturnWithCustomRect *)mobileNumberTextField{
    
    if (_mobileNumberTextField == nil)
    {
        CGRect frame = CGRectMake(15, 0, kTextFieldWidth, kTextFieldHeight);
        _mobileNumberTextField = [[KBNumberPadReturnWithCustomRect alloc] initWithFrame:frame];
        
//        if (!IOS7_OR_LATER) {
//            _mobileNumberTextField.placeholderRect = CGRectMake(15, 10, 210, 20);
//            _mobileNumberTextField.textRect = CGRectMake(15, 10, 210, 20);
//            _mobileNumberTextField.editingRect = CGRectMake(15, 10, 210, 20);
//        }
        
        _mobileNumberTextField.clearButtonRect = CGRectMake(230, 10, 20, 20);
        

        _mobileNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileNumberTextField.placeholder = L(@"VPInputMobileNumber");
        _mobileNumberTextField.textColor =[UIColor dark_Gray_Color];

        _mobileNumberTextField.backgroundColor = [UIColor whiteColor];

        _mobileNumberTextField.clipsToBounds = YES;
        _mobileNumberTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        
        _mobileNumberTextField.returnKeyType = UIReturnKeyDone;
        _mobileNumberTextField.delegate =self;
    }
    
    return _mobileNumberTextField;
    
}

//contact's name
- (UILabel *)contactName
{
    if (!_contactName) {
        _contactName               = [UILabel new];
        _contactName.frame         = CGRectMake(self.mobileNumberTextField.right-100, self.mobileNumberTextField.origin.y, 100, self.mobileNumberTextField.height);
        
        _contactName.textColor     = [UIColor colorWithHexString:@"#707070"];
        _contactName.font          = [UIFont systemFontOfSize:13];
        _contactName.textAlignment = UITextAlignmentRight;
        
        _contactName.text          = @"";
    }
    return _contactName;
}



//联系人按钮
- (UIButton *)addressBookBtn
{
    if (_addressBookBtn==nil) {
        
        CGRect frame = CGRectMake(280, 7.5, 25, 25);
        
        _addressBookBtn=[[UIButton alloc] initWithFrame:frame];
        [_addressBookBtn setImage:[UIImage imageNamed:@"login_user_highLight.png"]
                         forState:UIControlStateNormal];
        [_addressBookBtn addTarget:self action:@selector(gotoAddressBook:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressBookBtn;
}

- (UIView *)rechargeInfoAreaView{
    
    if (!_rechargeInfoAreaView) {
        
        _rechargeInfoAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhone5?257:222, 320, 35)];
        
        
        [self addSubview:_rechargeInfoAreaView];
        
        [_rechargeInfoAreaView addSubview:self.operatorIcon];
        
        [_rechargeInfoAreaView addSubview:self.providerNOLable];
        
        [_rechargeInfoAreaView addSubview:self.reducemoneyPriceLable];
        
        [_rechargeInfoAreaView addSubview:self.reducemoneyLable];
        
        
    }
    return _rechargeInfoAreaView;
}

//归属地label
- (UILabel *)providerNOLable
{
    if (_providerNOLable == nil) {
        
        _providerNOLable = [[UILabel alloc] initWithFrame:CGRectMake(52, 3, 100, 26)];
        _providerNOLable.textColor = [UIColor dark_Gray_Color];
        _providerNOLable.font = [UIFont systemFontOfSize:14.0];
        _providerNOLable.textAlignment = UITextAlignmentLeft;
        _providerNOLable.backgroundColor = [UIColor clearColor];
        
    }
    return _providerNOLable;
}

//运营商图标
-(UIImageView*)operatorIcon
{
    if (!_operatorIcon)
    {
        _operatorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 1, 30.5, 30)];
    }
    return _operatorIcon;
}

//优惠价格
- (OHAttributedLabel *)reducemoneyLable
{
    if (_reducemoneyLable == nil) {
        
        _reducemoneyLable = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(_reducemoneyPriceLable.right+5,_providerNOLable.top+5,60,30)];
        _reducemoneyLable.font = [UIFont systemFontOfSize:14.0];
        _reducemoneyLable.textAlignment = UITextAlignmentLeft;
        _reducemoneyLable.backgroundColor = [UIColor clearColor];
        
    }
    return _reducemoneyLable;
}

//充值金额label
- (UILabel *)reducemoneyPriceLable
{
    if (_reducemoneyPriceLable == nil) {
        
        _reducemoneyPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(168, _providerNOLable.top, 80, 26)];
        _reducemoneyPriceLable.textColor = [UIColor orange_Red_Color];
        _reducemoneyPriceLable.font = [UIFont systemFontOfSize:14.0];
        _reducemoneyPriceLable.textAlignment = UITextAlignmentRight;
        _reducemoneyPriceLable.backgroundColor = [UIColor clearColor];
        _reducemoneyPriceLable.text = L(@"VPSale");
        
    }
    return _reducemoneyPriceLable;
}

- (UIView *)bottomAreaView{
    
    if (!_bottomAreaView ) {
        
        _bottomAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhone5?320:270, 320, 140)];

        [_bottomAreaView addSubview:self.settlementBtn];
        
        [_bottomAreaView addSubview:self.payHistoryBtn];
        
        UIImageView *separatorLineTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine"]];
        separatorLineTop.frame = CGRectMake(_payHistoryBtn.left, _payHistoryBtn.top, _payHistoryBtn.width, 0.5);
        
        UIImageView *separatorLineBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine"]];
        separatorLineBottom.frame = CGRectMake(_payHistoryBtn.left, _payHistoryBtn.bottom-0.5, _payHistoryBtn.width, 0.5);
        
        [_bottomAreaView addSubview:separatorLineTop];
        [_bottomAreaView addSubview:separatorLineBottom];
        
    }
    return _bottomAreaView;
}


//支付按钮
-(UIButton *)settlementBtn
{
    if (_settlementBtn==nil) {

        _settlementBtn =[[UIButton alloc]initWithFrame:CGRectMake(15, 0, 290, 35)];
        [_settlementBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_normal.png" ] forState:UIControlStateNormal];
        [_settlementBtn addTarget:self action:@selector(payNextHeadler:) forControlEvents:UIControlEventTouchUpInside];

        [_settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settlementBtn setTitle:L(@"VPPayNow") forState:UIControlStateNormal];
        _settlementBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];

        
    }
    return _settlementBtn;
}

//查询历史按钮
-(UIButton *)payHistoryBtn
{
    if (_payHistoryBtn==nil) {
        _payHistoryBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _settlementBtn.bottom+20, 320, 40)];
        [_payHistoryBtn setTitle:L(@"Recharge history") forState:UIControlStateNormal];
        [_payHistoryBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        _payHistoryBtn.backgroundColor=[UIColor whiteColor];
         _payHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_payHistoryBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 160)];
        [_payHistoryBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 295, 0, 19)];
        [_payHistoryBtn setImage:[UIImage imageNamed:@"cellDetail.png"] forState:UIControlStateNormal];
        [_payHistoryBtn addTarget:self action:@selector(gotoPayHistory:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _payHistoryBtn;
}

-(MobileRechargeNewService *)service
{
    if (!_service) {
        _service=[[MobileRechargeNewService alloc] init];
        _service.delegate=self;
    }
    return _service;
}


- (SNDropDownMenuViewController *)dropDownMenuViewController{
    
    if (!_dropDownMenuViewController) {
        
        if ([SystemInfo is_iPhone_5]) {
            _dropDownMenuViewController =[[SNDropDownMenuViewController alloc] initWithSuperView:self withFrame:CGRectMake(0, self.topAreaView.bottom, 320, 200)];
        }
        else
        {
            _dropDownMenuViewController =[[SNDropDownMenuViewController alloc] initWithSuperView:self withFrame:CGRectMake(0, self.topAreaView.bottom, 320, 140)];
        }
        _dropDownMenuViewController.delegate = self;
        _dropDownMenuViewController.menuTableViewOffset = UIEdgeInsetsMake(-0.1, 0, 0, 0);
        
    }
    return _dropDownMenuViewController;
}

@end
