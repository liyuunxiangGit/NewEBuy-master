//
//  MobileRechargeViewController.m
//  SuningEBuy
//  Created by shasha on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MobileRechargeViewController.h"
#import "ValidationService.h"
#import "MobilePayHelpViewController.h"
#import "MobilePayViewController.h"
#import "MobilePayQueryViewController.h"

#define PRICESELECT_TITLE_KEY  @"title"
#define PRICESELECT_PRICE_KEY  @"value"

#define KEYPATH_PHONENUM       @"phoneNum"
#define KEYPATH_CHARGEMONEY    @"chargeMoney"

#define KEYPATH_ISCANPAY               @"isGetrechargeInfoSuccess"

#define TAG_ORIGIN                      1000

#define kTextFieldWidth                 300.0f
#define kTextFieldHeight                44.0
#define kLeftMargin                     30.0
#define kTopMargin                      15.0
#define kTextFieldFontSize              17.0

#define kPriceButton_Height             35
#define kPriceButton_Width              140


@interface MobileRechargeViewController(){

    BOOL                       isPhoneNumChanged_;
        
    BOOL                       isBackFromAddressBook_;
    
    BOOL                       isViewDissmiss_;
        
    //上一次的号码归属地查询的号码，避免点击按钮时候的重复接口请求
    NSString                  *preSelectPhoneNum_;
    
    NSInteger                  selectedButtonTag_;
    
    payMobileOrderDTO          *payOrderData_;

    
}
 

//价格选择数据源
@property (nonatomic, strong) NSArray                   *priceSelectArr;

@property (nonatomic, strong) KBNumberPadReturnWithCustomRect	  *mobileNumberTextField;

@property (nonatomic, strong) UILabel                   *providerNOLable;

@property (nonatomic, strong) UILabel                   *reducemoneyLable;

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


//数据初始化
- (void)dataInit;
- (void)naviItemsInit;
//获取手机号码的归属地、运营商以及充值金额的优惠信息。
- (void)getAllInfo;
- (NSString *)getName:(ABRecordRef) person;

- (NSArray *)getMatchedArr:(NSString *)letters;

- (BOOL)validateAll;

- (BOOL)validateMobile:(NSString *)phoneNum;

@end

@implementation MobileRechargeViewController
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
    
}


#pragma mark - ViewLife Circle Methods
#pragma mark   View的生命周期方法

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"Mobile Pay");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_mobileCharge"),self.title];

        [self  dataInit];
        
        [self naviItemsInit];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMobilePayOrderList) name:QUERY_MOBILE_RECORD object:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_PHONENUM options:NSKeyValueObservingOptionOld context:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_CHARGEMONEY options:NSKeyValueObservingOptionOld context:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_ISCANPAY options:NSKeyValueObservingOptionNew context:nil];

    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{   
    if (keyPath && [keyPath isEqualToString:KEYPATH_PHONENUM]) {
        self.mobileNumberTextField.text = self.phoneNum;
        [self.mobileNumberTextField resignFirstResponder];
//        NSString *prePhoneNum = [change objectForKey:NSKeyValueChangeOldKey];
        if (self.phoneNum&&[self validateMobile:self.phoneNum]) {//  && ![self.phoneNum isEqualToString:prePhoneNum]
            [self getAllInfo];
        }
    }
    
    if (keyPath && [keyPath isEqualToString:KEYPATH_CHARGEMONEY]) {
        NSString *preChargeMoney = [change objectForKey:NSKeyValueChangeOldKey];
        if (self.chargeMoney && ![self.chargeMoney isEqualToString:preChargeMoney]) {
            [self displayOverFlowActivityView];
            [self.service beginGetCheckPreferential:self.phoneNum money:self.chargeMoney];
        }
    }
    if (keyPath && [keyPath isEqualToString:KEYPATH_ISCANPAY]) {
        BOOL isCanpay = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        self.settlementBtn.enabled = isCanpay;
        if (!isCanpay) {
            self.providerNOLable.text = L(@"VPOwnership");
            self.reducemoneyLable.text = @"--";
        }
    }
}
- (void)dataInit{
        
    _priceSelectArr = [[NSArray alloc] initWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"30 yuan"),PRICESELECT_TITLE_KEY, @"3000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"50 yuan"),   PRICESELECT_TITLE_KEY, @"5000",PRICESELECT_PRICE_KEY,nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:L(@"100 yuan"),PRICESELECT_TITLE_KEY, @"10000",PRICESELECT_PRICE_KEY,nil]
                       ,[NSDictionary dictionaryWithObjectsAndKeys:L(@"300 yuan"),PRICESELECT_TITLE_KEY, @"30000",PRICESELECT_PRICE_KEY,nil],
                       nil];
    
    _remindPhoneNumArr = [[NSMutableArray alloc] init];
    
    payOrderData_ = [[payMobileOrderDTO alloc] init];
    
    NSDictionary *dic = [self.priceSelectArr objectAtIndex:0];
    
    self.chargeMoney = [dic objectForKey:PRICESELECT_PRICE_KEY];
    
    self.phoneNum = IsNilOrNull([Config currentConfig].payMobileNum)?@"":[Config currentConfig].payMobileNum;

    selectedButtonTag_ = TAG_ORIGIN +1;
    
    _isGetrechargeInfoSuccess = NO;
    
    isBackFromAddressBook_ = NO;
}


- (void)naviItemsInit{
    
    UIButton *payHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payHelpButton.frame=CGRectMake(0, 0, 30, 30);
    payHelpButton.userInteractionEnabled=YES;
    [payHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
    [payHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateHighlighted];
    [payHelpButton addTarget:self action:@selector(helpButtonHeadler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:payHelpButton];
    
}


- (void)loadView{

    [super loadView];  
    
    [self topAreaView];
    
    self.priceButtonsView.frame = CGRectMake(0, self.topAreaView.bottom + 20, self.priceButtonsView.width, self.priceButtonsView.height);

    self.rechargeInfoAreaView.frame = CGRectMake(0, self.priceButtonsView.bottom+20, self.rechargeInfoAreaView.width, self.rechargeInfoAreaView.height);
    
    self.bottomAreaView.frame = CGRectMake(0, self.rechargeInfoAreaView.bottom+20, self.bottomAreaView.width, self.bottomAreaView.height);
  
    UIButton *button = (UIButton *)[self.priceButtonsView viewWithTag:selectedButtonTag_];
    
    [button setBackgroundImage:[UIImage streImageNamed:@"public_roundRect_yellow_button.png"] forState:UIControlStateNormal];
    //[self.topAreaView addSubview:self.addressBookBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isViewDissmiss_ = NO;
    
    if (isBackFromAddressBook_) {
      
        isBackFromAddressBook_ = NO;
        
        return;
    }
    
    //如果手机号码为空
    if (IsStrEmpty(self.phoneNum)) {
        self.isGetrechargeInfoSuccess = NO;
        [self.mobileNumberTextField becomeFirstResponder];        
    }else{
        if (!self.isGetrechargeInfoSuccess) {
            self.mobileNumberTextField.text = self.phoneNum;
            [self getAllInfo];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
	
    isViewDissmiss_ = YES;
	[super viewWillDisappear:animated];
}

#pragma mark - 
#pragma mark    页面跳转方法

- (void)helpButtonHeadler:(id)sender{
    
    [self.mobileNumberTextField resignFirstResponder];
    
    MobilePayHelpViewController *controller = [[MobilePayHelpViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
   
}

- (void)gotoMobilePayOrderList{
    
    [self.navigationController popToViewController:self animated:NO];
    MobilePayQueryViewController *_mobilePayQueryViewController = [[MobilePayQueryViewController alloc] init];
    [self.navigationController pushViewController:_mobilePayQueryViewController animated:YES];
    TT_RELEASE_SAFELY(_mobilePayQueryViewController);

}


- (void)payNextHeadler:(id)sender{
    
    if (![self validateAll]) {
        return;
    }
    
    MobilePayViewController *nextController = [[MobilePayViewController alloc] init];
    
    nextController.paySource = payOrderData_;
    
    [self.navigationController pushViewController: nextController animated:YES];
    
    TT_RELEASE_SAFELY(nextController);
    
}

- (void)gotoPayHistory:(id)sender{
    MobilePayQueryViewController *_mobilePayQueryViewController = [[MobilePayQueryViewController alloc] init];
    [self.navigationController pushViewController:_mobilePayQueryViewController animated:YES];
    TT_RELEASE_SAFELY(_mobilePayQueryViewController);
}


#pragma mark -  Validate Data Methods
#pragma mark    数据有效性验证

- (BOOL)validateAll{
    
    if (!self.isGetrechargeInfoSuccess) {
        //"No_chargeInfo"="充值信息获取失败，请刷新页面重新获取";
        [self presentSheet:L(@"No_chargeInfo") posY:50];
        return NO;
    }

    if (![self validateMobile:payOrderData_.mobileNumber]) {
        return NO;
    }
    
    if (IsStrEmpty(payOrderData_.mobilequo)) {
        //"No_mobileQuo"="未查询到您的号码归属地，请刷新页面重新获取";
        [self presentSheet:L(@"No_mobileQuo") posY:50];
        return NO;
    }
    
    if (IsStrEmpty(payOrderData_.payPrice)){
        //"No_payPrice"="充值金额获取失败，请重新选择";
        [self presentSheet:L(@"No_payPrice") posY:50];
        return NO;    
    }
    
    if (IsStrEmpty(payOrderData_.factPayPrice)) {
        //"No_factPayPrice"="优惠金额获取失败，请刷新页面重新获取";
        [self presentSheet:L(@"No_factPayPrice") posY:50];
        return NO; 
    }
    
    return YES;
    
}

- (BOOL)validateMobile:(NSString *)phoneNum{
    
    NSError *error = [ValidationService phoneNumChecking:phoneNum];
    if (error.code == kValidationFail) {
        NSString *errorDesc = [NSString stringWithFormat:@"PhoneNum_%@",[error.userInfo objectForKey:kValidationErrorDesc_Key]];
        [self presentSheet:L(errorDesc) posY:50];
        //[self.mobileNumberTextField becomeFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark -  DropDownMenu Methods
#pragma mark    下拉列表的方法实现

- (CGFloat)dropDownMenu:(UITableView *)dropDownMenuView heghtForRowAtIndextPath:(NSIndexPath *)indextPath{

    if (indextPath.row == 0) {
        return 50;
    }else{
        return 40;        
    }
}


- (UITableViewCell *)dropDownMenu:(UITableView *)dropDownMenuView cellForRowAtIndextPath:(NSIndexPath *)indextPath{

    static NSString *identify = @"SNDropDownCell";
    UITableViewCell *cell = [dropDownMenuView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = RGBCOLOR(237, 237, 237);
    }
    if (!IsNilOrNull(self.remindPhoneNumArr)&&!([self.remindPhoneNumArr count]-1<indextPath.row)) {
        cell.textLabel.text = [self.remindPhoneNumArr objectAtIndex:indextPath.row];
    }
    return cell;
    
}

- (void)dropDownMenu:(UITableView *)dropDownMenuView didSelectRowAtIndextPath:(NSIndexPath *)indextPath{

    if (!IsNilOrNull(self.remindPhoneNumArr)&&!([self.remindPhoneNumArr count]-1<indextPath.row)) {
        self.phoneNum = [self.remindPhoneNumArr objectAtIndex:indextPath.row];
    }
     
    [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
}


#pragma mark -   ABPeoplePickerNavigationController Method
#pragma mark     地址簿相关方法

- (void)gotoAddressBook:(id)sender{
    
    if (!IOS6_OR_LATER && [[Config currentConfig].isFirstUseAddress isEqualToString:@"0"])
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                        message:L(@"VPEbuyWantToVisitYourAddressBook")
                                                       delegate:self
                                              cancelButtonTitle:L(@"VPNoPermission")
                                              otherButtonTitles:L(@"Okey")];
        [alert show];
        return;
    }
    
    isBackFromAddressBook_ = YES;

    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],nil];
    
    picker.displayedProperties = displayedItems;
    
    [self presentModalViewController:picker animated:YES];
    
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [Config currentConfig].isFirstUseAddress = @"1";
        [self gotoAddressBook:nil];
    }
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
	ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
    CFIndex index =  ABMultiValueGetIndexForIdentifier(phoneProperty, identifier);
	NSString *phone = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneProperty,index));
    TT_RELEASE_SAFELY(phoneProperty);
    
    NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];


    TT_RELEASE_SAFELY(phone);
    
    NSString *name =CFBridgingRelease(ABRecordCopyCompositeName(person));

    //    NSString *phoneStr1 = [phoneStr stringByReplacingOccurrencesOfString:@" (" withString:@""];
    //    NSString *phoneStr2 = [phoneStr1 stringByReplacingOccurrencesOfString:@") " withString:@""];
    
 //   NSString *personName=[self getName:person];
    
	self.phoneNum = [NSString stringWithFormat:@"%@ %@",phoneStr,name];

            
	[self dismissModalViewControllerAnimated:YES];
    
    [self.mobileNumberTextField resignFirstResponder];
    
	return NO;
}

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
    
    if (![self validateMobile:self.mobileNumberTextField.text]) {
        return;
    }
    
    [self.mobileNumberTextField resignFirstResponder];

    UIButton *tapedButton = sender; 
    
    if (tapedButton.tag == selectedButtonTag_ && self.isGetrechargeInfoSuccess) {
        return;
    }else{
        
        NSDictionary *dic = [self.priceSelectArr objectAtIndex:tapedButton.tag - TAG_ORIGIN -1];
        UIButton *button = (UIButton *)[self.priceButtonsView viewWithTag:selectedButtonTag_];
        [button setBackgroundImage:[UIImage streImageNamed:@"grayButton1.png"] forState:UIControlStateNormal];
        selectedButtonTag_ = tapedButton.tag;
        [tapedButton setBackgroundImage:[UIImage streImageNamed:@"public_roundRect_yellow_button.png"] forState:UIControlStateNormal];
        self.chargeMoney = [dic objectForKey:PRICESELECT_PRICE_KEY];
    }    
}

#pragma mark -  HTTP Methods
#pragma mark    数据请求的方法实现

- (void)getAllInfo{
        
    [Config currentConfig].payMobileNum = self.phoneNum;
    
    [self displayOverFlowActivityView];
    
    [self.service beginGetCheckMobileNumber:self.phoneNum];
   
    if (!IsNilOrNull([Config currentConfig].phoneNumData)) {
        
        if ([[Config currentConfig].phoneNumData containsObject:self.phoneNum]) {
            return;
        }else{
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObjectsFromArray:[Config currentConfig].phoneNumData];
            [arr addObject:self.phoneNum];
            [Config currentConfig].phoneNumData = arr;
            TT_RELEASE_SAFELY(arr);
        }
    }
}

- (void)getCheckMobileNumberHttpRequestCompletedWithService:(MobileRechargeNewService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
      
    [self removeOverFlowActivityView];

    if (isSucess) {
                
        [self.service beginGetCheckPreferential:self.phoneNum money:self.chargeMoney];
        
        self.settlementBtn.enabled = YES;
        
        self.providerNOLable.text = [NSString stringWithFormat:@"%@%@  %@",L(@"VPOwnership1"),service.provinceName,service.ispName];
        
        if ([self.rechargeInfoAreaView superview]==nil) {
            
            [self.view addSubview:self.rechargeInfoAreaView];

        }

        payOrderData_.mobileNumber = self.phoneNum;
                
        payOrderData_.mobilequo = service.numberInfo;
        
        payOrderData_.yifubaoMoney =[UserCenter defaultCenter].userInfoDTO.yifubaoBalance; 
        
        payOrderData_.ispType = service.ispType;
        
        payOrderData_.provinceId = service.provinceId;
        
        payOrderData_.provinceName = service.provinceName;
                
    }else{

        [self presentSheet:L(errorCode) posY:50];
        
        self.isGetrechargeInfoSuccess = NO;
        
    }

}

- (void)getCheckPreferentialHttpRequestCompletedWithService:(MobileRechargeNewService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self removeOverFlowActivityView];
    
    if (isSucess) {
        
        if ([self.rechargeInfoAreaView superview]==nil) {
            
            [self.view addSubview:self.rechargeInfoAreaView];
        }
        
        self.isGetrechargeInfoSuccess = YES;
        
        if ([self.providerNOLable.text hasSuffix:@"--"]) {
            self.isGetrechargeInfoSuccess = NO;
        }
        
        self.settlementBtn.enabled = YES;
        
        self.reducemoneyLable.text = [NSString stringWithFormat:@"%.2f%@",[service.preferentPrice floatValue]/100,L(@"Money Unit")];
        
        self.providerNOLable.text = [NSString stringWithFormat:@"%@%@  %@",L(@"VPOwnership1"),service.provinceName,service.ispName];
        
        payOrderData_.factPayPrice = service.preferentPrice;
        payOrderData_.providerNO = service.providerNO;
        payOrderData_.payPrice = self.chargeMoney;
        
    }else{
        
        [self presentSheet:L(errorCode) posY:50];
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
    
    if (isBackFromAddressBook_ || isViewDissmiss_) {
        
        [textField resignFirstResponder];
        return;
    }
    
    [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
     
    if (![self validateMobile:self.mobileNumberTextField.text]) {
        return;
    }
    
    self.phoneNum = self.mobileNumberTextField.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
 
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
    
    [self.remindPhoneNumArr removeAllObjects];
    
    if (IsNilOrNull(matchedArr)||[matchedArr count]==0) {
        
        [self.dropDownMenuViewController dismissMenuWithAnimation:eNoneAnimation];
        
        TT_RELEASE_SAFELY(matchedArr);
        
        return YES;
        
    }else{
        
        [self.remindPhoneNumArr addObjectsFromArray:matchedArr];
    
        NSString *rowCount = [NSString stringWithFormat:@"%d",[matchedArr count]];
        NSArray *arr = [[NSArray alloc] initWithObjects:rowCount,nil];
        [self.dropDownMenuViewController reloadDataWithNumberOfRowAndSection:arr];
        TT_RELEASE_SAFELY(arr);
        CGRect frame = self.topAreaView.frame;
        frame.origin.y = self.topAreaView.bottom;
        [self.dropDownMenuViewController displayMenuAtFrame:frame Animation:eNoneAnimation];
        [self.view bringSubviewToFront:self.topAreaView];
    
    }
    
    TT_RELEASE_SAFELY(matchedArr);
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
    return YES;
}


#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法

- (UIView *)priceButtonsView{

    if (!_priceButtonsView) {
        
        _priceButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 2*kPriceButton_Height + 10)];
                    
        for (int i = 1 ; i<=4; i++) {
            
            CGRect frame = CGRectMake (10 ,0 ,140 ,kPriceButton_Height);

            NSDictionary *dic = [self.priceSelectArr objectAtIndex:i-1];

            NSString *title = [dic objectForKey:PRICESELECT_TITLE_KEY];  
            
            if (i%2 == 0) {
                frame.origin.x = frame.origin.x + kPriceButton_Width + 20;
            }
            if (i > 2) {
                frame.origin.y = frame.origin.y + kPriceButton_Height + 10 ;
            }   
            
            UIButton *button = [[UIButton alloc] init];
            
            button.frame = frame;
            
            [button setTitle:title forState:UIControlStateNormal];
            
            button.tag = TAG_ORIGIN + i;
            
            [button addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [button setBackgroundImage:[UIImage streImageNamed:@"grayButton1.png"] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button setHighlighted:NO];
            
            [_priceButtonsView addSubview:button];
            
            TT_RELEASE_SAFELY(button);
            
        }
        
        [self.view addSubview:_priceButtonsView];
        
    }
    return _priceButtonsView;

}

- (UIView *)topAreaView{

    if (!_topAreaView) {
        
        _topAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kTextFieldHeight+10)];
        
        [_topAreaView addSubview:self.mobileNumberTextField];
                
        [self.view addSubview:_topAreaView];
        
    }
    return _topAreaView;

}

- (KBNumberPadReturnWithCustomRect *)mobileNumberTextField{
    
    if (_mobileNumberTextField == nil)
    {
        CGRect frame = CGRectMake(10, 10, kTextFieldWidth, kTextFieldHeight);
        _mobileNumberTextField = [[KBNumberPadReturnWithCustomRect alloc] initWithFrame:frame];
        
        _mobileNumberTextField.placeholderRect = CGRectMake(10, 10, 210, 20);
        _mobileNumberTextField.textRect = CGRectMake(10, 10, 210, 20);
        _mobileNumberTextField.editingRect = CGRectMake(10, 10, 210, 20);
        _mobileNumberTextField.clearButtonRect = CGRectMake(210, 12, 20, 20);

        _mobileNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileNumberTextField.placeholder = L(@"Please input phone number");
        _mobileNumberTextField.borderStyle = UITextBorderStyleLine;
        _mobileNumberTextField.backgroundColor = [UIColor whiteColor];
        _mobileNumberTextField.layer.cornerRadius = 10.0;
        _mobileNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _mobileNumberTextField.layer.borderWidth = 1.0f;
        _mobileNumberTextField.clipsToBounds = YES;
        _mobileNumberTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        
        //_mobileNumberTextField.backgroundColor =[UIColor clearColor];
        _mobileNumberTextField.returnKeyType = UIReturnKeyDone;
         _mobileNumberTextField.delegate =self;
        [_mobileNumberTextField addSubview:self.addressBookBtn];
    }
    
    return _mobileNumberTextField;
    
}

//联系人按钮
- (UIButton *)addressBookBtn
{
    if (_addressBookBtn==nil) {
        
        CGRect frame = CGRectMake(240, 0, 61, 46);
        _addressBookBtn=[[UIButton alloc] initWithFrame:frame];
        [_addressBookBtn setImage:[UIImage imageNamed:@"mobile_addressbook.png"]
                         forState:UIControlStateNormal];
        [_addressBookBtn addTarget:self action:@selector(gotoAddressBook:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addressBookBtn;
}

- (UIView *)rechargeInfoAreaView{

    if (!_rechargeInfoAreaView) {
        
        _rechargeInfoAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        
         [self.view addSubview:_rechargeInfoAreaView];
        
        [_rechargeInfoAreaView addSubview:self.reducemoneyPriceLable];
        
        [_rechargeInfoAreaView addSubview:self.providerNOLable];
        
        [_rechargeInfoAreaView addSubview:self.reducemoneyLable];
        
    }
    return _rechargeInfoAreaView;
}

//归属地label
- (UILabel *)providerNOLable
{
    if (_providerNOLable == nil) {
        
        _providerNOLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 32, 320, 16)];
        _providerNOLable.textColor = [UIColor blackColor];
        _providerNOLable.font = [UIFont boldSystemFontOfSize:16.0];
        _providerNOLable.textAlignment = UITextAlignmentLeft;
        _providerNOLable.backgroundColor = [UIColor clearColor]; 
        _providerNOLable.text = L(@"VPOwnership");
        
    }
    return _providerNOLable;
}

//优惠价格
- (UILabel *)reducemoneyLable
{
    if (_reducemoneyLable == nil) {
        
        _reducemoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(84,16,320-84,16)];
        _reducemoneyLable.textColor = [UIColor darkRedColor];
        _reducemoneyLable.font = [UIFont boldSystemFontOfSize:16.0];
        _reducemoneyLable.textAlignment = UITextAlignmentLeft;
        _reducemoneyLable.backgroundColor = [UIColor clearColor];
        _reducemoneyLable.text = @"--";
        
    }
    return _reducemoneyLable;
}

//充值金额label
- (UILabel *)reducemoneyPriceLable
{
    if (_reducemoneyPriceLable == nil) {
        
        _reducemoneyPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, 64, 16)];
        _reducemoneyPriceLable.textColor = [UIColor blackColor];
        _reducemoneyPriceLable.font = [UIFont boldSystemFontOfSize:16.0];
        _reducemoneyPriceLable.textAlignment = UITextAlignmentLeft;
        _reducemoneyPriceLable.backgroundColor = [UIColor clearColor];
        _reducemoneyPriceLable.text = L(@"VPyigouPrice");

    }
    return _reducemoneyPriceLable;
}

- (UIView *)bottomAreaView{
    
    if (!_bottomAreaView ) {
        
        _bottomAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        
        [_bottomAreaView addSubview:self.settlementBtn];
        
        [_bottomAreaView addSubview:self.payHistoryBtn];
        
        [self.view addSubview:_bottomAreaView];
        
    }
    return _bottomAreaView;
}


//支付按钮
-(UIButton *)settlementBtn
{
    if (_settlementBtn==nil) {
        CGRect frame=CGRectMake(20, 0, 280, 40);
        _settlementBtn=[[UIButton alloc] initWithFrame:frame];
        [_settlementBtn setBackgroundImage:[UIImage streImageNamed:@"public_roundRect_yellow_button.png" ] forState:UIControlStateNormal];
        [_settlementBtn addTarget:self action:@selector(payNextHeadler:) forControlEvents:UIControlEventTouchUpInside];
        [_settlementBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_settlementBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settlementBtn setTitle:L(@"gotoPay:") forState:UIControlStateNormal];
       
    }
    return _settlementBtn;
}

//查询历史按钮
-(UIButton *)payHistoryBtn
{
    if (_payHistoryBtn==nil) {
        CGRect frame=CGRectMake(20, 45, 280, 40);
        _payHistoryBtn=[[UIButton alloc] initWithFrame:frame];
        [_payHistoryBtn setTitle:L(@"Recharge history") forState:UIControlStateNormal];
        [_payHistoryBtn setTitleColor:RGBCOLOR(254, 151, 0) forState:UIControlStateNormal];
        [_payHistoryBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 160)];
        [_payHistoryBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 140)];
        [_payHistoryBtn setImage:[UIImage imageNamed:@"CheckPayHistory.png"] forState:UIControlStateNormal];
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
     
        _dropDownMenuViewController =[[SNDropDownMenuViewController alloc] initWithSuperView:self.view withFrame:CGRectMake(10, 40, kTextFieldWidth, 170)];
        _dropDownMenuViewController.delegate = self;
        _dropDownMenuViewController.menuTableViewOffset = UIEdgeInsetsMake(-10, 0, 10, 0);
    }
        return _dropDownMenuViewController;
}


@end
