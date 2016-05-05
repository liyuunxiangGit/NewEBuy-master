//
//  VirtualProductViewController.m
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "VirtualProductViewController.h"

#define kTopSortViewFrame CGRectMake(0, 0, 320, 35)
#define kMainViewFrame CGRectMake(0, 35, 320, 388)
#define kRadioSortFrame CGRectMake(5, 5, 310, 42)

//手机充值
#import "ValidationService.h"
#import "MobilePayHelpViewController.h"
#import "MobilePayViewController.h"
#import "MobilePayQueryViewController.h"

//水电煤缴费
#import "PayServicePaymentViewController.h"
#import "PayServiceHelpViewController.h"
#import "PayServiceQueryViewController.h"
#import "Preferences.h"
#import "PayServiceCell.h"

//手机充值
#define PRICESELECT_TITLE_KEY  @"title"
#define PRICESELECT_PRICE_KEY  @"value"

#define KEYPATH_PHONENUM       @"phoneNum"
#define KEYPATH_CHARGEMONEY    @"chargeMoney"

#define KEYPATH_ISCANPAY       @"isGetrechargeInfoSuccess"

#define TAG_ORIGIN                      1000
#define kMobileNumberTextField          2000

#define kTextFieldWidth                 300.0f
#define kTextFieldHeight                44.0
#define kLeftMargin                     30.0
#define kTopMargin                      15.0
#define kTextFieldFontSize              17.0

#define kPriceButton_Height             35
#define kPriceButton_Width              67.5

//水电煤缴费
#define kWaterElectricityGasTag          100

#define kTextFieldWidth2                188.0
#define kTextFieldHeight2               30.0
#define kLeftMargin2                    98.0
#define kTopMargin2                     9.0

#define kNumberOfSectionsInTableView     2
#define kPaymentSection                  0
#define kQuerySection                    1

#define kHeightOfCell                    40
#define kNoticeMessageLine1              L(@"Payment time is every month 1-25")
#define kNoticeMessageLine2              L(@"You can request the bill from China Everbright Bank")

@interface VirtualProductViewController ()
{
    //手机充值
    BOOL                       isPhoneNumChanged_;
    BOOL                       isBackFromAddressBook_;
    BOOL                       isViewDissmiss_;
    
    //上一次的号码归属地查询的号码，避免点击按钮时候的重复接口请求
    NSString                  *preSelectPhoneNum_;
    NSInteger                  selectedButtonTag_;
    payMobileOrderDTO          *payOrderData_;
    
    //水电煤缴费
    //判断FeeMode调用是否成功
    BOOL        wIsGetFeeModeSuccess;
    BOOL        eIsGetFeeModeSuccess;
    BOOL        gIsGetFeeModeSuccess;
    
    //防止FeeMode调用失败后，无法自动从新进行FeeMode调用
    BOOL        wIsContinueReqAccountInfo;
    BOOL        eIsContinueReqAccountInfo;
    BOOL        gIsContinueReqAccountInfo;
    
    BOOL        wIsNeedGetAccount;
    BOOL        eIsNeedGetAccount;
    BOOL        gIsNeedGetAccount;
    
    //判断水、电、煤 是否已经初始化过
    BOOL        isWaterInit;
    BOOL        isElectricityInit;
    BOOL        isGasInit;
    
    NSInteger   waterElectricityGasIndex;
}

@property(nonatomic,strong) VirtualProductSegementView *topSortView;
@property(nonatomic,strong) WaterElectricityGasSegementView *radioSortView;
@property(nonatomic,strong) UIView  *mobileRechargeView;
@property(nonatomic,strong) UIView  *waterElectricityGasView;

//手机充值
//价格选择数据源
@property (nonatomic, strong) NSArray                   *priceSelectArr;
@property (nonatomic, strong) KBNumberPadReturnWithCustomRect *mobileNumberTextField;
@property (nonatomic, strong) UILabel                   *providerNOLable;
@property (nonatomic, strong) UILabel                   *reducemoneyLable;
@property (nonatomic, strong) UILabel                   *reducemoneyPriceLable;
@property (nonatomic, strong) UIButton                  *addressBookBtn;
@property (nonatomic, strong) UIButton                  *settlementBtn;
@property (nonatomic, strong) UIButton                  *payHistoryBtn;
@property (nonatomic, strong) UIButton                  *payHelpBtn;
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
//获取手机号码的归属地、运营商以及充值金额的优惠信息。
- (void)getAllInfo;
- (NSString *)getName:(ABRecordRef) person;
- (NSArray *)getMatchedArr:(NSString *)letters;
- (BOOL)validateAll;
- (BOOL)validateMobile:(NSString *)phoneNum;

@end

@implementation VirtualProductViewController

@synthesize topSortView = _topSortView;
@synthesize radioSortView = _radioSortView;
@synthesize mobileRechargeView = _mobileRechargeView;
@synthesize waterElectricityGasView = _waterElectricityGasView;

//手机充值
@synthesize priceSelectArr = _priceSelectArr;
@synthesize mobileNumberTextField  = _mobileNumberTextField;
@synthesize providerNOLable = _providerNOLable;
@synthesize reducemoneyLable = _reducemoneyLable;
@synthesize addressBookBtn=_addressBookBtn;
@synthesize settlementBtn=_settlementBtn;
@synthesize payHistoryBtn=_payHistoryBtn;
@synthesize payHelpBtn = _payHelpBtn;
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

//水电煤缴费
@synthesize wPayType = _wPayType;
@synthesize ePayType = _ePayType;
@synthesize gPayType = _gPayType;
@synthesize wPayRegionTextField = _wPayRegionTextField;
@synthesize ePayRegionTextField = _ePayRegionTextField;
@synthesize gPayRegionTextField = _gPayRegionTextField;
@synthesize wPayCompanyTextField = _wPayCompanyTextField;
@synthesize ePayCompanyTextField = _ePayCompanyTextField;
@synthesize gPayCompanyTextField = _gPayCompanyTextField;
@synthesize wPayAccountTextField = _wPayAccountTextField;
@synthesize ePayAccountTextField = _ePayAccountTextField;
@synthesize gPayAccountTextField = _gPayAccountTextField;
@synthesize wRegionPickerView = _wRegionPickerView;
@synthesize eRegionPickerView = _eRegionPickerView;
@synthesize gRegionPickerView = _gRegionPickerView;
@synthesize wCompanyPickerView = _wCompanyPickerView;
@synthesize eCompanyPickerView = _eCompanyPickerView;
@synthesize gCompanyPickerView = _gCompanyPickerView;
@synthesize waterElecGasService = _waterElecGasService;
@synthesize wRegionList = _wRegionList;
@synthesize eRegionList = _eRegionList;
@synthesize gRegionList = _gRegionList;
@synthesize wCompanyList = _wCompanyList;
@synthesize eCompanyList = _eCompanyList;
@synthesize gCompanyList = _gCompanyList;
@synthesize wPayServiceDTO = _wPayServiceDTO;
@synthesize ePayServiceDTO = _ePayServiceDTO;
@synthesize gPayServiceDTO = _gPayServiceDTO;
@synthesize wPayServiceList = _wPayServiceList;
@synthesize ePayServiceList = _ePayServiceList;
@synthesize gPayServiceList = _gPayServiceList;
@synthesize wPayServiceInfoList = _wPayServiceInfoList;
@synthesize ePayServiceInfoList = _ePayServiceInfoList;
@synthesize gPayServiceInfoList = _gPayServiceInfoList;
@synthesize wPayBalanceLabel = _wPayBalanceLabel;
@synthesize ePayBalanceLabel = _ePayBalanceLabel;
@synthesize gPayBalanceLabel = _gPayBalanceLabel;
@synthesize wCustomerNameLabel = _wCustomerNameLabel;
@synthesize eCustomerNameLabel = _eCustomerNameLabel;
@synthesize gCustomerNameLabel = _gCustomerNameLabel;
@synthesize wPayAccountNum = _wPayAccountNum;
@synthesize ePayAccountNum = _ePayAccountNum;
@synthesize gPayAccountNum = _gPayAccountNum;
@synthesize wGroupTableView = _wGroupTableView;
@synthesize eGroupTableView = _eGroupTableView;
@synthesize gGroupTableView = _gGroupTableView;

#pragma mark - 生命周期方法

- (void)dealloc
{
    TT_RELEASE_SAFELY(_mobileRechargeView);
    TT_RELEASE_SAFELY(_waterElectricityGasView);
    TT_RELEASE_SAFELY(_topSortView);
    TT_RELEASE_SAFELY(_radioSortView);
    
    //手机充值
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
    TT_RELEASE_SAFELY(_payHelpBtn);
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
    
    //水电煤缴费
    TT_RELEASE_SAFELY(_wPayRegionTextField);
    TT_RELEASE_SAFELY(_ePayRegionTextField);
    TT_RELEASE_SAFELY(_gPayRegionTextField);
    TT_RELEASE_SAFELY(_wPayCompanyTextField);
    TT_RELEASE_SAFELY(_ePayCompanyTextField);
    TT_RELEASE_SAFELY(_gPayCompanyTextField);
    TT_RELEASE_SAFELY(_wPayAccountTextField);
    TT_RELEASE_SAFELY(_ePayAccountTextField);
    TT_RELEASE_SAFELY(_gPayAccountTextField);
    TT_RELEASE_SAFELY(_wRegionPickerView);
    TT_RELEASE_SAFELY(_eRegionPickerView);
    TT_RELEASE_SAFELY(_gRegionPickerView);
    TT_RELEASE_SAFELY(_wCompanyPickerView);
    TT_RELEASE_SAFELY(_eCompanyPickerView);
    TT_RELEASE_SAFELY(_gCompanyPickerView);
    
    SERVICE_RELEASE_SAFELY(_waterElecGasService);
    
    TT_RELEASE_SAFELY(_wRegionList);
    TT_RELEASE_SAFELY(_eRegionList);
    TT_RELEASE_SAFELY(_gRegionList);
    TT_RELEASE_SAFELY(_wCompanyList);
    TT_RELEASE_SAFELY(_eCompanyList);
    TT_RELEASE_SAFELY(_gCompanyList);
    TT_RELEASE_SAFELY(_wPayServiceDTO);
    TT_RELEASE_SAFELY(_ePayServiceDTO);
    TT_RELEASE_SAFELY(_gPayServiceDTO);
    TT_RELEASE_SAFELY(_wPayServiceList);
    TT_RELEASE_SAFELY(_ePayServiceList);
    TT_RELEASE_SAFELY(_gPayServiceList);
    TT_RELEASE_SAFELY(_wCustomerNameLabel);
    TT_RELEASE_SAFELY(_eCustomerNameLabel);
    TT_RELEASE_SAFELY(_gCustomerNameLabel);
    TT_RELEASE_SAFELY(_wPayBalanceLabel);
    TT_RELEASE_SAFELY(_ePayBalanceLabel);
    TT_RELEASE_SAFELY(_gPayBalanceLabel);
    TT_RELEASE_SAFELY(_wPayAccountNum);
    TT_RELEASE_SAFELY(_ePayAccountNum);
    TT_RELEASE_SAFELY(_gPayAccountNum);
    
    _wGroupTableView.dataSource = nil;
    _wGroupTableView.delegate = nil;
    TT_RELEASE_SAFELY(_wGroupTableView);
    _eGroupTableView.dataSource = nil;
    _eGroupTableView.delegate = nil;
    TT_RELEASE_SAFELY(_eGroupTableView);
    _gGroupTableView.dataSource = nil;
    _gGroupTableView.delegate = nil;
    TT_RELEASE_SAFELY(_gGroupTableView);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isPaySuccess" object:nil];
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"rechargePayment");
        
        self.pageTitle = L(@"finance_chargeCenter");//[NSString stringWithFormat:@"%@-%@",@"",self.title];
        //手机充值
        [self dataInit];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMobilePayOrderList) name:QUERY_MOBILE_RECORD object:nil];
        
        [self addObserver:self forKeyPath:KEYPATH_PHONENUM options:NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:KEYPATH_CHARGEMONEY options:NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:KEYPATH_ISCANPAY options:NSKeyValueObservingOptionNew context:nil];
        
        //水电煤缴费
        waterElectricityGasIndex = kWaterElectricityGasTag + payWater;
    }
        
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.topSortView];
    
    [self.view addSubview:self.mobileRechargeView];
    [self.view addSubview:self.waterElectricityGasView];
    
    [self.waterElectricityGasView addSubview:self.radioSortView];
    
    //手机充值
    [self topAreaView];
    
    self.priceButtonsView.frame = CGRectMake(0, self.topAreaView.bottom + 20, self.priceButtonsView.width, self.priceButtonsView.height);
    self.rechargeInfoAreaView.frame = CGRectMake(0, self.priceButtonsView.bottom+20, self.rechargeInfoAreaView.width, self.rechargeInfoAreaView.height);
    self.bottomAreaView.frame = CGRectMake(0, self.rechargeInfoAreaView.bottom+20, self.bottomAreaView.width, self.bottomAreaView.height);
    
    UIButton *button = (UIButton *)[self.priceButtonsView viewWithTag:selectedButtonTag_];
    [button setBackgroundImage:[UIImage streImageNamed:@"public_roundRect_yellow_button.png"] forState:UIControlStateNormal];
    
    
    //水电煤缴费
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 42;
    frame.size.height = contentView.bounds.size.height - 92 - 42 -20;
    self.wGroupTableView.frame = frame;
    self.eGroupTableView.frame = frame;
    self.gGroupTableView.frame = frame;
    
    UIButton *wPayHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wPayHelpButton.frame = CGRectMake(275, 325, 30, 30);
    [wPayHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
    [wPayHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateHighlighted];
    [wPayHelpButton addTarget:self action:@selector(WEGhelpButtonHeadler:) forControlEvents:UIControlEventTouchUpInside];
    [self.wGroupTableView addSubview:wPayHelpButton];
    
    UIButton *ePayHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ePayHelpButton.frame = CGRectMake(275, 325, 30, 30);
    [ePayHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
    [ePayHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateHighlighted];
    [ePayHelpButton addTarget:self action:@selector(WEGhelpButtonHeadler:) forControlEvents:UIControlEventTouchUpInside];
    [self.wGroupTableView addSubview:ePayHelpButton];
    
    UIButton *gPayHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gPayHelpButton.frame = CGRectMake(275, 325, 30, 30);
    [gPayHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
    [gPayHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateHighlighted];
    [gPayHelpButton addTarget:self action:@selector(WEGhelpButtonHeadler:) forControlEvents:UIControlEventTouchUpInside];
    [self.wGroupTableView addSubview:gPayHelpButton];
    
    [self.waterElectricityGasView addSubview:self.wGroupTableView];
    [self.waterElectricityGasView addSubview:self.eGroupTableView];
    [self.waterElectricityGasView addSubview:self.gGroupTableView];
    
//    UIBarButtonItem *payButton = [[UIBarButtonItem alloc]
//                                  initWithTitle:L(@"Next Step")
//                                  style:UIBarButtonItemStylePlain
//                                  target:self
//                                  action:@selector(payNextHeadler)];
//    self.navigationItem.rightBarButtonItem = payButton;
//    TT_RELEASE_SAFELY(payButton);

    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Next Step")];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump2PayQueue) name:@"isPaySuccess" object:nil];
}

- (void)righBarClick
{
    [self payNextHeadler];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //手机充值
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

- (void)viewWillDisappear:(BOOL)animated
{
	//手机充值
    isViewDissmiss_ = YES;
	[super viewWillDisappear:animated];
}

#pragma mark - 数据初始化

- (void)dataInit
{
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

#pragma mark - 页面跳转方法

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
    [self.navigationController pushViewController:nextController animated:YES];
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
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 点击事件处理方法
//充值金额选择事件的处理方法
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

//手机充值 水电煤 选项切换
- (void)sortBtnPressed:(ButtonSort)btnIndex
{
    if (btnIndex == sortMobileRecharge) {
        self.waterElectricityGasView.hidden = YES;
        self.mobileRechargeView.hidden = NO;
    }
    else
    {
        self.mobileRechargeView.hidden = YES;
        self.waterElectricityGasView.hidden = NO;
    }
}

//水电煤类型选择
- (void)radioBtnPressed:(id)sender
{
    UIButton *radioBtn = (UIButton *)sender;
    
    if (radioBtn.tag == kWaterElectricityGasTag+payWater) {
        self.wPayType = payWater;
        
        waterElectricityGasIndex = kWaterElectricityGasTag+payWater;
        
        if (!isWaterInit) {
            wIsManual = NO;
            wIsFirst = YES;
            wIsGetAccountInfo = NO;
            wIsNeedGetAccount = YES;
            
            isWaterInit = YES;
        }
        
        _wPayServiceDTO = [[PayServiceDTO alloc] init];
        _wPayServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.wPayType + 1];
        
        self.wPayServiceList = [Config currentConfig].payServiceList;
        
        self.wGroupTableView.hidden = NO;
        self.eGroupTableView.hidden = YES;
        self.gGroupTableView.hidden = YES;
    }
    else if (radioBtn.tag == kWaterElectricityGasTag+payElectricity) {
        self.ePayType = payElectricity;
        
        waterElectricityGasIndex = kWaterElectricityGasTag+payElectricity;
        
        if (!isElectricityInit) {
            eIsManual = NO;
            eIsFirst = YES;
            eIsGetAccountInfo = NO;
            eIsNeedGetAccount = YES;
            
            isElectricityInit = YES;
        }
        
        _ePayServiceDTO = [[PayServiceDTO alloc] init];
        _ePayServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.ePayType + 1];
        
        self.ePayServiceList = [Config currentConfig].payServiceList;
        
        self.wGroupTableView.hidden = YES;
        self.eGroupTableView.hidden = NO;
        self.gGroupTableView.hidden = YES;
    }
    else if (radioBtn.tag == kWaterElectricityGasTag+payGas) {
        self.gPayType = payGas;
        
        waterElectricityGasIndex = kWaterElectricityGasTag+payGas;
        
        if (!isGasInit) {
            gIsManual = NO;
            gIsFirst = YES;
            gIsGetAccountInfo = NO;
            gIsNeedGetAccount = YES;
            
            isGasInit = YES;
        }
        
        _gPayServiceDTO = [[PayServiceDTO alloc] init];
        _gPayServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.gPayType + 1];
        
        self.gPayServiceList = [Config currentConfig].payServiceList;
        
        self.wGroupTableView.hidden = YES;
        self.eGroupTableView.hidden = YES;
        self.gGroupTableView.hidden = NO;
    }
    
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+0) {
        if (!wIsGetAccountInfo) {
            
            if ([self.wPayServiceList count] != 0) {
                
                for (NSString *payServiceList in self.wPayServiceList) {
                    
                    if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.wPayType]]) {
                        
                        self.wPayServiceInfoList = [payServiceList componentsSeparatedByString:@","];
                        
                        self.wPayServiceDTO.areaCode = [self.wPayServiceInfoList objectAtIndex:1];
                        self.wPayServiceDTO.areaName = [self.wPayServiceInfoList objectAtIndex:2];
                        self.wPayServiceDTO.companyId = [self.wPayServiceInfoList objectAtIndex:3];
                        self.wPayServiceDTO.companyCode = [self.wPayServiceInfoList objectAtIndex:4];
                        self.wPayServiceDTO.companyName = [self.wPayServiceInfoList objectAtIndex:5];
                        self.wPayServiceDTO.chargeAccount = [self.wPayServiceInfoList objectAtIndex:6];
                        if ([self.wPayServiceInfoList count] == 8) {
                            self.wPayServiceDTO.customerName = [self.wPayServiceInfoList objectAtIndex:7];
                        }
                        
                        wIsFirst = NO;
                    }
                }
            }
            
            [self getRegionInfoRequest];
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+1) {
        if (!eIsGetAccountInfo) {
            
            if ([self.ePayServiceList count] != 0) {
                
                for (NSString *payServiceList in self.ePayServiceList) {
                    
                    if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.ePayType]]) {
                        
                        self.ePayServiceInfoList = [payServiceList componentsSeparatedByString:@","];
                        
                        self.ePayServiceDTO.areaCode = [self.ePayServiceInfoList objectAtIndex:1];
                        self.ePayServiceDTO.areaName = [self.ePayServiceInfoList objectAtIndex:2];
                        self.ePayServiceDTO.companyId = [self.ePayServiceInfoList objectAtIndex:3];
                        self.ePayServiceDTO.companyCode = [self.ePayServiceInfoList objectAtIndex:4];
                        self.ePayServiceDTO.companyName = [self.ePayServiceInfoList objectAtIndex:5];
                        self.ePayServiceDTO.chargeAccount = [self.ePayServiceInfoList objectAtIndex:6];
                        if ([self.ePayServiceInfoList count] == 8) {
                            self.ePayServiceDTO.customerName = [self.ePayServiceInfoList objectAtIndex:7];
                        }
                        
                        eIsFirst = NO;
                    }
                }
            }
            
            [self getRegionInfoRequest];
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+2) {
        if (!gIsGetAccountInfo) {
            
            if ([self.gPayServiceList count] != 0) {
                
                for (NSString *payServiceList in self.gPayServiceList) {
                    
                    if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.gPayType]]) {
                        
                        self.gPayServiceInfoList = [payServiceList componentsSeparatedByString:@","];
                        
                        self.gPayServiceDTO.areaCode = [self.gPayServiceInfoList objectAtIndex:1];
                        self.gPayServiceDTO.areaName = [self.gPayServiceInfoList objectAtIndex:2];
                        self.gPayServiceDTO.companyId = [self.gPayServiceInfoList objectAtIndex:3];
                        self.gPayServiceDTO.companyCode = [self.gPayServiceInfoList objectAtIndex:4];
                        self.gPayServiceDTO.companyName = [self.gPayServiceInfoList objectAtIndex:5];
                        self.gPayServiceDTO.chargeAccount = [self.gPayServiceInfoList objectAtIndex:6];
                        if ([self.gPayServiceInfoList count] == 8) {
                            self.gPayServiceDTO.customerName = [self.gPayServiceInfoList objectAtIndex:7];
                        }
                        
                        gIsFirst = NO;
                    }
                }
            }
            
            [self getRegionInfoRequest];
        }
    }
}

- (void)jump2PayQueue
{
    [self.navigationController popToViewController:self animated:NO];
    
    PayServiceQueryViewController *_queryViewController = [[PayServiceQueryViewController alloc] init];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater) {
        _queryViewController.typeCode = self.wPayServiceDTO.typeCode;
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity) {
        _queryViewController.typeCode = self.ePayServiceDTO.typeCode;
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payGas) {
        _queryViewController.typeCode = self.gPayServiceDTO.typeCode;
    }
    
    [self.navigationController pushViewController:_queryViewController animated:YES];
    
    TT_RELEASE_SAFELY(_queryViewController);
}

- (void)getRegionInfoRequest
{
    [self displayOverFlowActivityView];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater) {
        wIsLoading = YES;
        self.wGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetRegionInfo:self.wPayServiceDTO];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity) {
        eIsLoading = YES;
        self.eGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetRegionInfo:self.ePayServiceDTO];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payGas) {
        gIsLoading = YES;
        self.gGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetRegionInfo:self.gPayServiceDTO];
    }
}

#pragma mark -  DropDownMenu 下拉列表的方法实现

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

#pragma mark - ABPeoplePickerNavigationController 地址簿相关方法

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
	NSString *phone = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneProperty,identifier));
    TT_RELEASE_SAFELY(phoneProperty);
    
    NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    TT_RELEASE_SAFELY(phone);
    
	self.phoneNum = phoneStr;
    
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

#pragma mark - TextField的代理方法实现

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag != kMobileNumberTextField) {
        if (textField == self.wPayAccountTextField && !wIsManual)
        {
            wIsNeedGetAccount = NO;
            
            [textField resignFirstResponder];
            
            NSString *platform = [Preferences platform];
            
            /*iPad1 以及模拟器，直接调出手动输入界面*/
            if ([platform isEqualToString:@"iPad1"] || [platform isEqualToString:@"iPhone Simulator"] || [platform hasPrefix:@"iPod"])
            {
                wIsManual = YES;
                [self.wPayAccountTextField becomeFirstResponder];
            }
            else
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:nil
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:L(@"VPBarCodeScan"), L(@"Manual_Input"), nil];
                [actionSheet showInView:self.view.superview.superview.superview];
                TT_RELEASE_SAFELY(actionSheet);
            }
        }
        else if (textField == self.ePayAccountTextField && !eIsManual)
        {
            eIsNeedGetAccount = NO;
            
            [textField resignFirstResponder];
            
            NSString *platform = [Preferences platform];
            
            /*iPad1 以及模拟器，直接调出手动输入界面*/
            if ([platform isEqualToString:@"iPad1"] || [platform isEqualToString:@"iPhone Simulator"] || [platform hasPrefix:@"iPod"])
            {
                eIsManual = YES;
                [self.ePayAccountTextField becomeFirstResponder];
            }
            else
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:nil
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:L(@"VPBarCodeScan"), L(@"Manual_Input"), nil];
                [actionSheet showInView:self.view.superview.superview.superview];
                TT_RELEASE_SAFELY(actionSheet);
            }
        }
        else if (textField == self.gPayAccountTextField && !gIsManual)
        {
            gIsNeedGetAccount = NO;
            
            [textField resignFirstResponder];
            
            NSString *platform = [Preferences platform];
            
            /*iPad1 以及模拟器，直接调出手动输入界面*/
            if ([platform isEqualToString:@"iPad1"] || [platform isEqualToString:@"iPhone Simulator"] || [platform hasPrefix:@"iPod"])
            {
                gIsManual = YES;
                [self.gPayAccountTextField becomeFirstResponder];
            }
            else
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:nil
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:L(@"VPBarCodeScan"), L(@"Manual_Input"), nil];
                [actionSheet showInView:self.view.superview.superview.superview];
                TT_RELEASE_SAFELY(actionSheet);
            }
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag != kMobileNumberTextField) {
        if (textField == self.wPayAccountTextField)
        {
            self.wPayServiceDTO.chargeAccount = textField.text;
            
            wIsManual = NO;
            
            //查询账户字段不为空时
            if (self.wPayAccountTextField.text != nil && ![self.wPayAccountTextField.text isEqualToString:@""] && wIsNeedGetAccount)
            {
                if (wIsGetFeeModeSuccess) {
                    [self getAccountInfoRequest];
                }
                else
                {
                    [self getFeeModeRequest];
                    wIsContinueReqAccountInfo = YES;
                }
            }
            wIsNeedGetAccount = YES;
         }
        else if (textField == self.ePayAccountTextField)
        {
            self.ePayServiceDTO.chargeAccount = textField.text;
            
            eIsManual = NO;
            
            //查询账户字段不为空时
            if (self.ePayAccountTextField.text != nil && ![self.ePayAccountTextField.text isEqualToString:@""] && eIsNeedGetAccount)
            {
                if (eIsGetFeeModeSuccess) {
                    [self getAccountInfoRequest];
                }
                else
                {
                    [self getFeeModeRequest];
                    eIsContinueReqAccountInfo = YES;
                }
            }
            eIsNeedGetAccount = YES;
        }
        else if (textField == self.gPayAccountTextField)
        {
            self.gPayServiceDTO.chargeAccount = textField.text;
            
            gIsManual = NO;
            
            //查询账户字段不为空时
            if (self.gPayAccountTextField.text != nil && ![self.gPayAccountTextField.text isEqualToString:@""] && gIsNeedGetAccount)
            {
                if (gIsGetFeeModeSuccess) {
                    [self getAccountInfoRequest];
                }
                else
                {
                    [self getFeeModeRequest];
                    gIsContinueReqAccountInfo = YES;
                }
            }
            gIsNeedGetAccount = YES;
        }
    }
    else
    {
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
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag != kMobileNumberTextField) {
        if (textField == self.wPayRegionTextField)
        {
            [self.wPayAccountTextField resignFirstResponder];
            
            if (self.wRegionList == nil)
            {
                [self presentSheet:L(@"Please check your network") posY:50];
                return NO;
            }
        }
        
        else if (textField == self.ePayRegionTextField)
        {
            [self.ePayAccountTextField resignFirstResponder];
            
            if (self.eRegionList == nil)
            {
                [self presentSheet:L(@"Please check your network") posY:50];
                return NO;
            }
        }
        
        else if (textField == self.gPayRegionTextField)
        {
            [self.gPayAccountTextField resignFirstResponder];
            
            if (self.gRegionList == nil)
            {
                [self presentSheet:L(@"Please check your network") posY:50];
                return NO;
            }
        }
        
        else if (textField == self.wPayCompanyTextField)
        {
            [self.wPayAccountTextField resignFirstResponder];
            
            if ([self.wPayServiceDTO.areaCode isEqualToString:@""] || [self.wPayRegionTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay region") posY:50];
                return NO;
            }
            if (self.wCompanyList == nil)
            {
                [self presentSheet:L(@"Please check your network") posY:50];
                return NO;
            }
        }
        
        else if (textField == self.ePayCompanyTextField)
        {
            [self.ePayAccountTextField resignFirstResponder];
            
            if ([self.ePayServiceDTO.areaCode isEqualToString:@""] || [self.ePayRegionTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay region") posY:50];
                return NO;
            }
            if (self.eCompanyList == nil)
            {
                [self presentSheet:L(@"Please check your network") posY:50];
                return NO;
            }
        }
        
        else if (textField == self.gPayCompanyTextField)
        {
            [self.gPayAccountTextField resignFirstResponder];
            
            if ([self.gPayServiceDTO.areaCode isEqualToString:@""] || [self.gPayRegionTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay region") posY:50];
                return NO;
            }
            if (self.gCompanyList == nil)
            {
                [self presentSheet:L(@"Please check your network") posY:50];
                return NO;
            }
        }
        
        else if (textField == self.wPayAccountTextField)
        {
            if ([self.wPayServiceDTO.areaCode isEqualToString:@""] || [self.wPayRegionTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay region") posY:50];
                [textField resignFirstResponder];
                return NO;
            }
            if ([self.wPayServiceDTO.companyCode isEqualToString:@""] || [self.wPayCompanyTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay company") posY:50];
                [textField resignFirstResponder];
                return NO;
            }
        }
        
        else if (textField == self.ePayAccountTextField)
        {
            if ([self.ePayServiceDTO.areaCode isEqualToString:@""] || [self.ePayRegionTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay region") posY:50];
                [textField resignFirstResponder];
                return NO;
            }
            if ([self.ePayServiceDTO.companyCode isEqualToString:@""] || [self.ePayCompanyTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay company") posY:50];
                [textField resignFirstResponder];
                return NO;
            }
        }
        
        else if (textField == self.gPayAccountTextField)
        {
            if ([self.gPayServiceDTO.areaCode isEqualToString:@""] || [self.gPayRegionTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay region") posY:50];
                [textField resignFirstResponder];
                return NO;
            }
            if ([self.gPayServiceDTO.companyCode isEqualToString:@""] || [self.gPayCompanyTextField.text isEqualToString:@""])
            {
                [self presentSheet:L(@"Please select pay company") posY:50];
                [textField resignFirstResponder];
                return NO;
            }
        }
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag != kMobileNumberTextField) {
        return YES;
    }
    
    if (textField.text.length >=11 && range.location >= 11) {
        return NO;
    }
    if (textField.text.length + string.length - range.length > 11) {
        
        return NO;
    }

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
        [self.mobileRechargeView bringSubviewToFront:self.topAreaView];
        
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

#pragma mark -
#pragma mark Action Sheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        SNReaderViewController *readerViewController = [[SNReaderViewController alloc] init];
        readerViewController.snDelegate = self;
        readerViewController.isServicePay = YES;
        [self presentModalViewController:readerViewController animated:YES];
        
        TT_RELEASE_SAFELY(readerViewController);
    }
    else
    {
        if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater) {
            wIsManual = YES;
            [self.wPayAccountTextField becomeFirstResponder];
        }
        else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity) {
            eIsManual = YES;
            [self.ePayAccountTextField becomeFirstResponder];
        }
        else if (waterElectricityGasIndex == kWaterElectricityGasTag+payGas) {
            gIsManual = YES;
            [self.gPayAccountTextField becomeFirstResponder];
        }
    }
}

#pragma mark -
#pragma mark SNReaderDelegate Methods
- (void)readerView:(ZBarReaderView *)view
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for (symbol in symbols)
    {
        break;
    }
    
    NSString *zbarString = symbol.data;
    
    [self dismissModalViewControllerAnimated: YES];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        self.wPayAccountTextField.text = zbarString;
        wIsNeedGetAccount = YES;
        
        [self textFieldDidEndEditing:self.wPayAccountTextField];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        self.ePayAccountTextField.text = zbarString;
        eIsNeedGetAccount = YES;
        
        [self textFieldDidEndEditing:self.ePayAccountTextField];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payGas)
    {
        self.gPayAccountTextField.text = zbarString;
        gIsNeedGetAccount = YES;
        
        [self textFieldDidEndEditing:self.gPayAccountTextField];
    }
}

- (void)manualInput
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsManual = YES;
        
        [self.wPayAccountTextField becomeFirstResponder];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsManual = YES;
        
        [self.ePayAccountTextField becomeFirstResponder];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payGas)
    {
        gIsManual = YES;
        
        [self.gPayAccountTextField becomeFirstResponder];
    }
}

#pragma mark -
#pragma mark Picker View Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        if (pickerView == self.wRegionPickerView)
        {
            return [self.wRegionList count];
        }
        return [self.wCompanyList count];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        if (pickerView == self.eRegionPickerView)
        {
            return [self.eRegionList count];
        }
        return [self.eCompanyList count];
    }
    else 
    {
        if (pickerView == self.gRegionPickerView)
        {
            return [self.gRegionList count];
        }
        return [self.gCompanyList count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        if (pickerView == self.wRegionPickerView)
        {
            PayServiceDTO *_region = [self.wRegionList objectAtIndex:row];
            return _region.areaName;
        }
        else
        {
            PayServiceDTO *_company = [self.wCompanyList objectAtIndex:row];
            return _company.companyName;
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        if (pickerView == self.eRegionPickerView)
        {
            PayServiceDTO *_region = [self.eRegionList objectAtIndex:row];
            return _region.areaName;
        }
        else
        {
            PayServiceDTO *_company = [self.eCompanyList objectAtIndex:row];
            return _company.companyName;
        }
    }
    else
    {
        if (pickerView == self.gRegionPickerView)
        {
            PayServiceDTO *_region = [self.gRegionList objectAtIndex:row];
            return _region.areaName;
        }
        else
        {
            PayServiceDTO *_company = [self.gCompanyList objectAtIndex:row];
            return _company.companyName;
        }
    }
}

#pragma mark -
#pragma mark actions
- (void)payNextHeadler
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        [self.wPayRegionTextField resignFirstResponder];
        [self.wPayCompanyTextField resignFirstResponder];
        [self.wPayAccountTextField resignFirstResponder];
        
        if (wIsLoading) {
            return;
        }
        
        if (self.wPayRegionTextField.text == nil ||[self.wPayRegionTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please select pay region") posY:50];
            return;
        }
        if (self.wPayCompanyTextField.text == nil ||[self.wPayCompanyTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please select pay company") posY:50];
            return;
        }
        if (self.wPayAccountTextField.text == nil ||[self.wPayAccountTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please input your pay account") posY:50];
            return;
        }
        if (self.wPayBalanceLabel.text == nil ||[self.wPayBalanceLabel.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please makesure your pay account") posY:50];
            return;
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        [self.ePayRegionTextField resignFirstResponder];
        [self.ePayCompanyTextField resignFirstResponder];
        [self.ePayAccountTextField resignFirstResponder];
        
        if (eIsLoading) {
            return;
        }
        
        if (self.ePayRegionTextField.text == nil ||[self.ePayRegionTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please select pay region") posY:50];
            return;
        }
        if (self.ePayCompanyTextField.text == nil ||[self.ePayCompanyTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please select pay company") posY:50];
            return;
        }
        if (self.ePayAccountTextField.text == nil ||[self.ePayAccountTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please input your pay account") posY:50];
            return;
        }
        if (self.ePayBalanceLabel.text == nil ||[self.ePayBalanceLabel.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please makesure your pay account") posY:50];
            return;
        }
    }
    else
    {
        [self.gPayRegionTextField resignFirstResponder];
        [self.gPayCompanyTextField resignFirstResponder];
        [self.gPayAccountTextField resignFirstResponder];
        
        if (gIsLoading) {
            return;
        }
        
        if (self.gPayRegionTextField.text == nil ||[self.gPayRegionTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please select pay region") posY:50];
            return;
        }
        if (self.gPayCompanyTextField.text == nil ||[self.gPayCompanyTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please select pay company") posY:50];
            return;
        }
        if (self.gPayAccountTextField.text == nil ||[self.gPayAccountTextField.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please input your pay account") posY:50];
            return;
        }
        if (self.gPayBalanceLabel.text == nil ||[self.gPayBalanceLabel.text isEqualToString:@""])
        {
            [self presentSheet:L(@"Please makesure your pay account") posY:50];
            return;
        }
    }
    
    [self goToNextController];
}

- (void)goToNextController
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        if ([self.wPayServiceDTO.payAmount floatValue] == 0.0)
        {
            [self presentSheet:L(@"Account don't need pay") posY:60];
            return;
        }
        
        PayServicePaymentViewController *nextViewController = [[PayServicePaymentViewController alloc] init];
        nextViewController.payDataSource = self.wPayServiceDTO;
        [self.navigationController pushViewController:nextViewController animated:YES];
        TT_RELEASE_SAFELY(nextViewController);
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        if ([self.ePayServiceDTO.payAmount floatValue] == 0.0)
        {
            [self presentSheet:L(@"Account don't need pay") posY:60];
            return;
        }
        
        PayServicePaymentViewController *nextViewController = [[PayServicePaymentViewController alloc] init];
        nextViewController.payDataSource = self.ePayServiceDTO;
        [self.navigationController pushViewController:nextViewController animated:YES];
        TT_RELEASE_SAFELY(nextViewController);
    }
    else
    {
        if ([self.gPayServiceDTO.payAmount floatValue] == 0.0)
        {
            [self presentSheet:L(@"Account don't need pay") posY:60];
            return;
        }
        
        PayServicePaymentViewController *nextViewController = [[PayServicePaymentViewController alloc] init];
        nextViewController.payDataSource = self.gPayServiceDTO;
        [self.navigationController pushViewController:nextViewController animated:YES];
        TT_RELEASE_SAFELY(nextViewController);
    }
}

- (void)doneButtonClicked:(id)sender
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        if ([self.wPayRegionTextField isFirstResponder])
        {
            wIsFirst = YES;
            
            NSInteger selectedRow = [self.wRegionPickerView selectedRowInComponent:0];
            PayServiceDTO *selectedRegion = [self.wRegionList objectAtIndex:selectedRow];
            self.wPayServiceDTO.areaCode = selectedRegion.areaCode;
            self.wPayServiceDTO.areaName = selectedRegion.areaName;
            [self.wPayRegionTextField setText:self.wPayServiceDTO.areaName];
            
            if (![self.wPayCompanyTextField.text isEqualToString:@""])
            {
                [self.wPayCompanyTextField setText:@""];
            }
            if (![self.wPayAccountTextField.text isEqualToString:@""])
            {
                [self.wPayAccountTextField setText:@""];
            }
            if (![self.wCustomerNameLabel.text isEqualToString:@""])
            {
                [self.wCustomerNameLabel setText:@""];
            }
            if (![self.wPayBalanceLabel.text isEqualToString:@""])
            {
                [self.wPayBalanceLabel setText:@""];
            }
            
            [self getCompanyListRequest];
        }
        else
        {
            wIsFirst = YES;
            NSInteger selectedRow = [self.wCompanyPickerView selectedRowInComponent:0];
            PayServiceDTO *selectedCompany = [self.wCompanyList objectAtIndex:selectedRow];
            self.wPayServiceDTO.companyCode = selectedCompany.companyCode;
            self.wPayServiceDTO.companyId = selectedCompany.companyId;
            self.wPayServiceDTO.companyName = selectedCompany.companyName;
            [self.wPayCompanyTextField setText:self.wPayServiceDTO.companyName];
            
            if (![self.wPayAccountTextField.text isEqualToString:@""])
            {
                [self.wPayAccountTextField setText:@""];
            }
            if (![self.wCustomerNameLabel.text isEqualToString:@""])
            {
                [self.wCustomerNameLabel setText:@""];
            }
            if (![self.wPayBalanceLabel.text isEqualToString:@""])
            {
                [self.wPayBalanceLabel setText:@""];
            }
            
            [self getFeeModeRequest];
        }
        
        [self.wPayRegionTextField resignFirstResponder];
        [self.wPayCompanyTextField resignFirstResponder];
        [self.wPayAccountTextField resignFirstResponder];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        if ([self.ePayRegionTextField isFirstResponder])
        {
            eIsFirst = YES;
            
            NSInteger selectedRow = [self.eRegionPickerView selectedRowInComponent:0];
            PayServiceDTO *selectedRegion = [self.eRegionList objectAtIndex:selectedRow];
            self.ePayServiceDTO.areaCode = selectedRegion.areaCode;
            self.ePayServiceDTO.areaName = selectedRegion.areaName;
            [self.ePayRegionTextField setText:self.ePayServiceDTO.areaName];
            
            if (![self.ePayCompanyTextField.text isEqualToString:@""])
            {
                [self.ePayCompanyTextField setText:@""];
            }
            if (![self.ePayAccountTextField.text isEqualToString:@""])
            {
                [self.ePayAccountTextField setText:@""];
            }
            if (![self.eCustomerNameLabel.text isEqualToString:@""])
            {
                [self.eCustomerNameLabel setText:@""];
            }
            if (![self.ePayBalanceLabel.text isEqualToString:@""])
            {
                [self.ePayBalanceLabel setText:@""];
            }
            
            [self getCompanyListRequest];
        }
        else
        {
            eIsFirst = YES;
            NSInteger selectedRow = [self.eCompanyPickerView selectedRowInComponent:0];
            PayServiceDTO *selectedCompany = [self.eCompanyList objectAtIndex:selectedRow];
            self.ePayServiceDTO.companyCode = selectedCompany.companyCode;
            self.ePayServiceDTO.companyId = selectedCompany.companyId;
            self.ePayServiceDTO.companyName = selectedCompany.companyName;
            [self.ePayCompanyTextField setText:self.ePayServiceDTO.companyName];
            
            if (![self.ePayAccountTextField.text isEqualToString:@""])
            {
                [self.ePayAccountTextField setText:@""];
            }
            if (![self.eCustomerNameLabel.text isEqualToString:@""])
            {
                [self.eCustomerNameLabel setText:@""];
            }
            if (![self.ePayBalanceLabel.text isEqualToString:@""])
            {
                [self.ePayBalanceLabel setText:@""];
            }
            
            [self getFeeModeRequest];
        }
        
        [self.ePayRegionTextField resignFirstResponder];
        [self.ePayCompanyTextField resignFirstResponder];
        [self.ePayAccountTextField resignFirstResponder];
    }
    else
    {
        if ([self.gPayRegionTextField isFirstResponder])
        {
            gIsFirst = YES;
            
            NSInteger selectedRow = [self.gRegionPickerView selectedRowInComponent:0];
            PayServiceDTO *selectedRegion = [self.gRegionList objectAtIndex:selectedRow];
            self.gPayServiceDTO.areaCode = selectedRegion.areaCode;
            self.gPayServiceDTO.areaName = selectedRegion.areaName;
            [self.gPayRegionTextField setText:self.gPayServiceDTO.areaName];
            
            if (![self.gPayCompanyTextField.text isEqualToString:@""])
            {
                [self.gPayCompanyTextField setText:@""];
            }
            if (![self.gPayAccountTextField.text isEqualToString:@""])
            {
                [self.gPayAccountTextField setText:@""];
            }
            if (![self.gCustomerNameLabel.text isEqualToString:@""])
            {
                [self.gCustomerNameLabel setText:@""];
            }
            if (![self.gPayBalanceLabel.text isEqualToString:@""])
            {
                [self.gPayBalanceLabel setText:@""];
            }
            
            [self getCompanyListRequest];
        }
        else
        {
            gIsFirst = YES;
            NSInteger selectedRow = [self.gCompanyPickerView selectedRowInComponent:0];
            PayServiceDTO *selectedCompany = [self.gCompanyList objectAtIndex:selectedRow];
            self.gPayServiceDTO.companyCode = selectedCompany.companyCode;
            self.gPayServiceDTO.companyId = selectedCompany.companyId;
            self.gPayServiceDTO.companyName = selectedCompany.companyName;
            [self.gPayCompanyTextField setText:self.wPayServiceDTO.companyName];
            
            if (![self.gPayAccountTextField.text isEqualToString:@""])
            {
                [self.gPayAccountTextField setText:@""];
            }
            if (![self.gCustomerNameLabel.text isEqualToString:@""])
            {
                [self.gCustomerNameLabel setText:@""];
            }
            if (![self.gPayBalanceLabel.text isEqualToString:@""])
            {
                [self.gPayBalanceLabel setText:@""];
            }
            
            [self getFeeModeRequest];
        }
        
        [self.gPayRegionTextField resignFirstResponder];
        [self.gPayCompanyTextField resignFirstResponder];
        [self.gPayAccountTextField resignFirstResponder];
    }
}

- (void)cancelButtonClicked:(id)sender
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        [self.wPayRegionTextField resignFirstResponder];
        [self.wPayCompanyTextField resignFirstResponder];
        [self.wPayAccountTextField resignFirstResponder];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        [self.ePayRegionTextField resignFirstResponder];
        [self.ePayCompanyTextField resignFirstResponder];
        [self.ePayAccountTextField resignFirstResponder];
    }
    else
    {
        [self.gPayRegionTextField resignFirstResponder];
        [self.gPayCompanyTextField resignFirstResponder];
        [self.gPayAccountTextField resignFirstResponder];
    }
}

- (void)WEGhelpButtonHeadler:(id)sender
{
    [UIView beginAnimations:@"preferenceSettingsAnimations" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    
    PayServiceHelpViewController *controller = [[PayServiceHelpViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
    TT_RELEASE_SAFELY(controller);
    
    [UIView commitAnimations];
}

- (void)requestFail:(NSString *)errorCode
{
    if (errorCode == nil)
    {
        [self presentSheet:L(@"Request Failed") posY:50];
    }
    else
    {
        [self presentSheet:errorCode posY:50];
    }
}

- (void)saveInfoToConfig
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        if ([self.wPayServiceList count] == 0)
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.wPayType,self.wPayServiceDTO.areaCode,self.wPayServiceDTO.areaName,self.wPayServiceDTO.companyId,self.wPayServiceDTO.companyCode,self.wPayServiceDTO.companyName,self.wPayAccountTextField.text,self.wCustomerNameLabel.text]];
            
            [Config currentConfig].payServiceList = array;
            TT_RELEASE_SAFELY(array);
        }
        else
        {
            for (NSString *payServiceString in self.wPayServiceList)
            {
                if ([payServiceString hasPrefix:[NSString stringWithFormat:@"%d",self.wPayType]])
                {
                    [self.wPayServiceList removeObject:payServiceString];
                    [self.wPayServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.wPayType,self.wPayServiceDTO.areaCode,self.wPayServiceDTO.areaName,self.wPayServiceDTO.companyId,self.wPayServiceDTO.companyCode,self.wPayServiceDTO.companyName,self.wPayAccountTextField.text,self.wCustomerNameLabel.text]];
                    [Config currentConfig].payServiceList = self.wPayServiceList;
                    return;
                }
            }
            
            [self.wPayServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.wPayType,self.wPayServiceDTO.areaCode,self.wPayServiceDTO.areaName,self.wPayServiceDTO.companyId,self.wPayServiceDTO.companyCode,self.wPayServiceDTO.companyName,self.wPayAccountTextField.text,self.wCustomerNameLabel.text]];
            [Config currentConfig].payServiceList = self.wPayServiceList;
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        if ([self.ePayServiceList count] == 0)
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.ePayType,self.ePayServiceDTO.areaCode,self.ePayServiceDTO.areaName,self.ePayServiceDTO.companyId,self.ePayServiceDTO.companyCode,self.ePayServiceDTO.companyName,self.ePayAccountTextField.text,self.eCustomerNameLabel.text]];
            
            [Config currentConfig].payServiceList = array;
            TT_RELEASE_SAFELY(array);
        }
        else
        {
            for (NSString *payServiceString in self.ePayServiceList)
            {
                if ([payServiceString hasPrefix:[NSString stringWithFormat:@"%d",self.ePayType]])
                {
                    [self.ePayServiceList removeObject:payServiceString];
                    [self.ePayServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.ePayType,self.ePayServiceDTO.areaCode,self.ePayServiceDTO.areaName,self.ePayServiceDTO.companyId,self.ePayServiceDTO.companyCode,self.ePayServiceDTO.companyName,self.ePayAccountTextField.text,self.eCustomerNameLabel.text]];
                    [Config currentConfig].payServiceList = self.ePayServiceList;
                    return;
                }
            }
            
            [self.ePayServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.ePayType,self.ePayServiceDTO.areaCode,self.ePayServiceDTO.areaName,self.ePayServiceDTO.companyId,self.ePayServiceDTO.companyCode,self.ePayServiceDTO.companyName,self.ePayAccountTextField.text,self.eCustomerNameLabel.text]];
            [Config currentConfig].payServiceList = self.ePayServiceList;
        }
    }
    else
    {
        if ([self.gPayServiceList count] == 0)
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.gPayType,self.gPayServiceDTO.areaCode,self.gPayServiceDTO.areaName,self.gPayServiceDTO.companyId,self.gPayServiceDTO.companyCode,self.gPayServiceDTO.companyName,self.gPayAccountTextField.text,self.gCustomerNameLabel.text]];
            
            [Config currentConfig].payServiceList = array;
            TT_RELEASE_SAFELY(array);
        }
        else
        {
            for (NSString *payServiceString in self.gPayServiceList)
            {
                if ([payServiceString hasPrefix:[NSString stringWithFormat:@"%d",self.gPayType]])
                {
                    [self.gPayServiceList removeObject:payServiceString];
                    [self.gPayServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.gPayType,self.gPayServiceDTO.areaCode,self.gPayServiceDTO.areaName,self.gPayServiceDTO.companyId,self.gPayServiceDTO.companyCode,self.gPayServiceDTO.companyName,self.gPayAccountTextField.text,self.gCustomerNameLabel.text]];
                    [Config currentConfig].payServiceList = self.gPayServiceList;
                    return;
                }
            }
            
            [self.gPayServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.gPayType,self.gPayServiceDTO.areaCode,self.gPayServiceDTO.areaName,self.gPayServiceDTO.companyId,self.gPayServiceDTO.companyCode,self.gPayServiceDTO.companyName,self.gPayAccountTextField.text,self.gCustomerNameLabel.text]];
            [Config currentConfig].payServiceList = self.gPayServiceList;
        }
    }
}

#pragma mark -
#pragma mark service

- (void)getCompanyListRequest
{
    [self displayOverFlowActivityView];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsLoading = YES;
        self.wGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetCompanyList:self.wPayServiceDTO];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsLoading = YES;
        self.eGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetCompanyList:self.ePayServiceDTO];
    }
    else
    {
        gIsLoading = YES;
        self.gGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetCompanyList:self.gPayServiceDTO];
    }
}

- (void)getAccountInfoRequest
{
    [self displayOverFlowActivityView];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsGetAccountInfo = YES;
        wIsLoading = YES;
        self.wGroupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetAccountInfo:self.wPayServiceDTO];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsGetAccountInfo = YES;
        eIsLoading = YES;
        self.groupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetAccountInfo:self.ePayServiceDTO];
    }
    else
    {
        gIsGetAccountInfo = YES;
        gIsLoading = YES;
        self.groupTableView.userInteractionEnabled = NO;
        [self.waterElecGasService beginGetAccountInfo:self.gPayServiceDTO];
    }
}

- (void)getFeeModeRequest
{
    [self displayOverFlowActivityView];
    
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsLoading = YES;
        self.wGroupTableView.userInteractionEnabled = NO;
        wIsGetFeeModeSuccess = NO;
        [self.waterElecGasService beginGetFeeMode:self.wPayServiceDTO];
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsLoading = YES;
        self.eGroupTableView.userInteractionEnabled = NO;
        eIsGetFeeModeSuccess = NO;
        [self.waterElecGasService beginGetFeeMode:self.ePayServiceDTO];
    }
    else
    {
        gIsLoading = YES;
        self.gGroupTableView.userInteractionEnabled = NO;
        gIsGetFeeModeSuccess = NO;
        [self.waterElecGasService beginGetFeeMode:self.gPayServiceDTO];
    }
}

#pragma mark -
#pragma mark 代理方法
- (void)getRegionInfoCompleteWithService:(WaterElectricityGasService *)service
                                  Result:(BOOL)isSuccess
                                errorMsg:(NSString *)errorMsg
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsLoading = NO;
        
        self.wGroupTableView.userInteractionEnabled = YES;
        
        if (wIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            
            self.wRegionList = service.regionList;
            
            if (!wIsFirst) {
                [self.waterElecGasService beginGetCompanyList:self.wPayServiceDTO];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsLoading = NO;
        
        self.eGroupTableView.userInteractionEnabled = YES;
        
        if (eIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            
            self.eRegionList = service.regionList;
            
            if (!eIsFirst) {
                [self.waterElecGasService beginGetCompanyList:self.ePayServiceDTO];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
    else
    {
        gIsLoading = NO;
        
        self.gGroupTableView.userInteractionEnabled = YES;
        
        if (gIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            
            self.gRegionList = service.regionList;
            
            if (!gIsFirst) {
                [self.waterElecGasService beginGetCompanyList:self.gPayServiceDTO];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
}

- (void)getCompanyListCompleteWithService:(WaterElectricityGasService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsLoading = NO;
        
        self.wGroupTableView.userInteractionEnabled = YES;
        
        if (wIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            
            self.wCompanyList = service.companyList;
            [self.wCompanyPickerView reloadAllComponents];
            
            
            
            if (!wIsFirst) {
                [self getFeeModeRequest];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsLoading = NO;
        
        self.eGroupTableView.userInteractionEnabled = YES;
        
        if (eIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            
            self.eCompanyList = service.companyList;
            [self.eCompanyPickerView reloadAllComponents];
            
            
            
            if (!eIsFirst) {
                [self getFeeModeRequest];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
    else
    {
        gIsLoading = NO;
        
        self.gGroupTableView.userInteractionEnabled = YES;
        
        if (gIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            
            self.gCompanyList = service.companyList;
            [self.gCompanyPickerView reloadAllComponents];
            
            
            
            if (!gIsFirst) {
                [self getFeeModeRequest];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
}

- (void)getFeeModeCompleteWithService:(WaterElectricityGasService *)service
                               Result:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsLoading = NO;
        
        self.wGroupTableView.userInteractionEnabled = YES;
        
        if (wIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            wIsGetFeeModeSuccess = YES;
            
            self.wPayServiceDTO = service.payServiceDTO;
            
            if (!wIsFirst) {
                [self.waterElecGasService beginGetAccountInfo:self.wPayServiceDTO];
            }
            
            if (wIsContinueReqAccountInfo) {
                [self.waterElecGasService beginGetAccountInfo:self.wPayServiceDTO];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsLoading = NO;
        
        self.eGroupTableView.userInteractionEnabled = YES;
        
        if (eIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            eIsGetFeeModeSuccess = YES;
            
            self.ePayServiceDTO = service.payServiceDTO;
            
            if (!eIsFirst) {
                [self.waterElecGasService beginGetAccountInfo:self.ePayServiceDTO];
            }
            
            if (eIsContinueReqAccountInfo) {
                [self.waterElecGasService beginGetAccountInfo:self.ePayServiceDTO];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
    else
    {
        gIsLoading = NO;
        
        self.gGroupTableView.userInteractionEnabled = YES;
        
        if (gIsFirst) {
            [self removeOverFlowActivityView];
        }
        
        if (isSuccess) {
            gIsGetFeeModeSuccess = YES;
            
            self.gPayServiceDTO = service.payServiceDTO;
            
            if (!gIsFirst) {
                [self.waterElecGasService beginGetAccountInfo:self.gPayServiceDTO];
            }
            
            if (gIsContinueReqAccountInfo) {
                [self.waterElecGasService beginGetAccountInfo:self.gPayServiceDTO];
            }
        }
        else
        {
            [self removeOverFlowActivityView];
            
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
        }
    }
}

- (void)getAccountInfoCompleteWithService:(WaterElectricityGasService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    if (waterElectricityGasIndex == kWaterElectricityGasTag+payWater)
    {
        wIsLoading = NO;
        
        [self removeOverFlowActivityView];
        self.wGroupTableView.userInteractionEnabled = YES;
        
        self.wPayAccountNum = service.payAccountNum;
        
        if (isSuccess) {
            self.wPayServiceDTO = service.payServiceDTO;
            self.wCustomerNameLabel.text = service.customerName;
            self.wPayBalanceLabel.text = service.payBalance;
            wIsGetAccountInfo = service.isGetAccount;
            
            [self saveInfoToConfig];
        }
        else
        {
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
            
            if (![self.wCustomerNameLabel.text isEqualToString:@""])
            {
                [self.wCustomerNameLabel setText:@""];
            }
            
            if (![self.wPayBalanceLabel.text isEqualToString:@""])
            {
                [self.wPayBalanceLabel setText:@""];
            }
        }
    }
    else if (waterElectricityGasIndex == kWaterElectricityGasTag+payElectricity)
    {
        eIsLoading = NO;
        
        [self removeOverFlowActivityView];
        self.eGroupTableView.userInteractionEnabled = YES;
        
        self.ePayAccountNum = service.payAccountNum;
        
        if (isSuccess) {
            self.ePayServiceDTO = service.payServiceDTO;
            self.eCustomerNameLabel.text = service.customerName;
            self.ePayBalanceLabel.text = service.payBalance;
            eIsGetAccountInfo = service.isGetAccount;
            
            [self saveInfoToConfig];
        }
        else
        {
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
            
            if (![self.eCustomerNameLabel.text isEqualToString:@""])
            {
                [self.eCustomerNameLabel setText:@""];
            }
            
            if (![self.ePayBalanceLabel.text isEqualToString:@""])
            {
                [self.ePayBalanceLabel setText:@""];
            }
        }
    }
    else
    {
        gIsLoading = NO;
        
        [self removeOverFlowActivityView];
        self.gGroupTableView.userInteractionEnabled = YES;
        
        self.gPayAccountNum = service.payAccountNum;
        
        if (isSuccess) {
            self.gPayServiceDTO = service.payServiceDTO;
            self.gCustomerNameLabel.text = service.customerName;
            self.gPayBalanceLabel.text = service.payBalance;
            gIsGetAccountInfo = service.isGetAccount;
            
            [self saveInfoToConfig];
        }
        else
        {
            if (!service.requestFail) {
                
                [self presentSheet:L(@"Request Failed") posY:60];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
            }
            
            if (![self.gCustomerNameLabel.text isEqualToString:@""])
            {
                [self.gCustomerNameLabel setText:@""];
            }
            
            if (![self.gPayBalanceLabel.text isEqualToString:@""])
            {
                [self.gPayBalanceLabel setText:@""];
            }
        }
    }
}

#pragma mark - KVO
//手机充值
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

//水电煤缴费
#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kNumberOfSectionsInTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kPaymentSection)
    {
        return 5;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (tableView == self.wGroupTableView)
        {
            static NSString *wPayServiceCellIdentifier = @"wPayServiceCellIdentifier";
            
            PayServiceCell *cell = (PayServiceCell *)[tableView dequeueReusableCellWithIdentifier:wPayServiceCellIdentifier];
            
            if (cell == nil)
            {
                cell = [[PayServiceCell alloc] initWithReuseIdentifier:wPayServiceCellIdentifier];
                
                switch (indexPath.row)
                {
                    case 0:
                        cell.textLabel.text = L(@"Pay region");
                        [cell.contentView addSubview:self.wPayRegionTextField];
                        break;
                    case 1:
                    {
                        cell.textLabel.text = L(@"Pay company");
                        [cell.contentView addSubview:self.wPayCompanyTextField];
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = L(@"Pay account");
                        [cell.contentView addSubview:self.wPayAccountTextField];
                        break;
                    }
                    case 3:
                    {
                        cell.textLabel.text = L(@"Customer name");
                        [cell addSubview: self.wCustomerNameLabel];
                        break;
                    }
                    case 4:
                    {
                        cell.textLabel.text = L(@"Pay amount");
                        [cell addSubview: self.wPayBalanceLabel];
                        break;
                    }
                        
                    default:
                        break;
                }
            }
            return cell;
        }
        else if (tableView == self.eGroupTableView)
        {
            static NSString *ePayServiceCellIdentifier = @"ePayServiceCellIdentifier";
            
            PayServiceCell *cell = (PayServiceCell *)[tableView dequeueReusableCellWithIdentifier:ePayServiceCellIdentifier];
            
            if (cell == nil)
            {
                cell = [[PayServiceCell alloc] initWithReuseIdentifier:ePayServiceCellIdentifier];
                
                switch (indexPath.row)
                {
                    case 0:
                        cell.textLabel.text = L(@"Pay region");
                        [cell.contentView addSubview:self.ePayRegionTextField];
                        break;
                    case 1:
                    {
                        cell.textLabel.text = L(@"Pay company");
                        [cell.contentView addSubview:self.ePayCompanyTextField];
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = L(@"Pay account");
                        [cell.contentView addSubview:self.ePayAccountTextField];
                        break;
                    }
                    case 3:
                    {
                        cell.textLabel.text = L(@"Customer name");
                        [cell addSubview: self.eCustomerNameLabel];
                        break;
                    }
                    case 4:
                    {
                        cell.textLabel.text = L(@"Pay amount");
                        [cell addSubview: self.ePayBalanceLabel];
                        break;
                    }
                        
                    default:
                        break;
                }
            }
            return cell;
        }
        else
        {
            static NSString *gPayServiceCellIdentifier = @"gPayServiceCellIdentifier";
            
            PayServiceCell *cell = (PayServiceCell *)[tableView dequeueReusableCellWithIdentifier:gPayServiceCellIdentifier];
            
            if (cell == nil)
            {
                cell = [[PayServiceCell alloc] initWithReuseIdentifier:gPayServiceCellIdentifier];
                
                switch (indexPath.row)
                {
                    case 0:
                        cell.textLabel.text = L(@"Pay region");
                        [cell.contentView addSubview:self.gPayRegionTextField];
                        break;
                    case 1:
                    {
                        cell.textLabel.text = L(@"Pay company");
                        [cell.contentView addSubview:self.gPayCompanyTextField];
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = L(@"Pay account");
                        [cell.contentView addSubview:self.gPayAccountTextField];
                        break;
                    }
                    case 3:
                    {
                        cell.textLabel.text = L(@"Customer name");
                        [cell addSubview: self.gCustomerNameLabel];
                        break;
                    }
                    case 4:
                    {
                        cell.textLabel.text = L(@"Pay amount");
                        [cell addSubview: self.gPayBalanceLabel];
                        break;
                    }
                        
                    default:
                        break;
                }
            }
            return cell;
        }
    }
    else
    {
        static NSString *PayServiceQueryCellIdentifier = @"PayServiceQueryCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PayServiceQueryCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayServiceQueryCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = L(@"Pay service history");
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Arial" size:18.0];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightOfCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == kPaymentSection) {
        return 60;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == kPaymentSection)
    {
        NSString *noticeMessage = [NSString stringWithFormat:@"%@ \n%@",kNoticeMessageLine1, kNoticeMessageLine2];
        return noticeMessage;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([indexPath section] == kPaymentSection)
    {
        if (tableView == self.wGroupTableView)
        {
            [self.wPayAccountTextField resignFirstResponder];
            return;
        }
        else if (tableView == self.eGroupTableView)
        {
            [self.ePayAccountTextField resignFirstResponder];
            return;
        }
        else
        {
            [self.gPayAccountTextField resignFirstResponder];
            return;
        }
    }
    
    if ([indexPath section] == kQuerySection)
    {
        PayServiceQueryViewController *_queryViewController =
        [[PayServiceQueryViewController alloc] init];
        
        if (tableView == self.wGroupTableView)
        {
             _queryViewController.typeCode = self.wPayServiceDTO.typeCode;
        }
        else if (tableView == self.eGroupTableView)
        {
             _queryViewController.typeCode = self.ePayServiceDTO.typeCode;
        }
        else
        {
             _queryViewController.typeCode = self.gPayServiceDTO.typeCode;
        }
       
        [self.navigationController pushViewController:_queryViewController animated:YES];
        TT_RELEASE_SAFELY(_queryViewController);
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
        
        self.providerNOLable.text = [NSString stringWithFormat:@"%@%@  %@",L(@"VPOwnership1"),service.provinceName,service.ispName];
        
        if ([self.rechargeInfoAreaView superview]==nil) {
            
            [self.mobileRechargeView addSubview:self.rechargeInfoAreaView];
            
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
            
            [self.mobileRechargeView addSubview:self.rechargeInfoAreaView];
        }
        
        self.isGetrechargeInfoSuccess = YES;
        
        if ([self.providerNOLable.text hasSuffix:@"--"]) {
            self.isGetrechargeInfoSuccess = NO;
        }
        
        self.reducemoneyLable.text = [NSString stringWithFormat:@"%.2f%@",[service.preferentPrice floatValue]/100,L(@"Money Unit")];
        payOrderData_.factPayPrice = service.preferentPrice;
        payOrderData_.providerNO = service.providerNO;
        payOrderData_.payPrice = self.chargeMoney;
        
    }else{
        
        [self presentSheet:L(errorCode) posY:50];
        self.isGetrechargeInfoSuccess = NO;
    }
}

#pragma mark - 属性的初始化方法

- (UIView *)mobileRechargeView
{
    if (!_mobileRechargeView) {
        _mobileRechargeView = [[UIView alloc] initWithFrame:kMainViewFrame];
        _mobileRechargeView.backgroundColor = [UIColor clearColor];
    }
    return _mobileRechargeView;
}

- (UIView *)waterElectricityGasView
{
    if (!_waterElectricityGasView) {
        _waterElectricityGasView = [[UIView alloc] initWithFrame:kMainViewFrame];
        _waterElectricityGasView.backgroundColor = [UIColor clearColor];
        _waterElectricityGasView.hidden = YES;
    }
    return _waterElectricityGasView;
}

- (VirtualProductSegementView *)topSortView
{
    if (!_topSortView) {
        _topSortView = [[VirtualProductSegementView alloc] initWithFrame:kTopSortViewFrame];
        _topSortView.delegate = self;
    }
    return _topSortView;
}

- (WaterElectricityGasSegementView *)radioSortView
{
    if (!_radioSortView) {
        _radioSortView = [[WaterElectricityGasSegementView alloc] initWithFrame:kRadioSortFrame];
        _radioSortView.delegate = self;
    }
    return _radioSortView;
}

//手机充值
- (UIView *)priceButtonsView{
    
    if (!_priceButtonsView) {
        
        _priceButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kPriceButton_Height + 10)];
        
        for (int i = 1 ; i<=4; i++) {
            
            CGRect frame = CGRectMake (i*10+kPriceButton_Width*(i-1), 0, kPriceButton_Width, kPriceButton_Height);
            
            NSDictionary *dic = [self.priceSelectArr objectAtIndex:i-1];
            
            NSString *title = [dic objectForKey:PRICESELECT_TITLE_KEY];

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
        
        [self.mobileRechargeView addSubview:_priceButtonsView];
        
    }
    return _priceButtonsView;
}

- (UIView *)topAreaView{
    
    if (!_topAreaView) {
        
        _topAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kTextFieldHeight+10)];
        
        [_topAreaView addSubview:self.mobileNumberTextField];
        
        [self.mobileRechargeView addSubview:_topAreaView];
        
    }
    return _topAreaView;
    
}

- (KBNumberPadReturnWithCustomRect *)mobileNumberTextField{
    
    if (_mobileNumberTextField == nil)
    {
        CGRect frame = CGRectMake(10, 10, kTextFieldWidth, kTextFieldHeight);
        _mobileNumberTextField = [[KBNumberPadReturnWithCustomRect alloc] initWithFrame:frame];
        
        _mobileNumberTextField.tag = kMobileNumberTextField;
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
        
        [self.mobileRechargeView addSubview:_rechargeInfoAreaView];
        
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
        
        _bottomAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
        
        [_bottomAreaView addSubview:self.settlementBtn];
        [_bottomAreaView addSubview:self.payHistoryBtn];
        [_bottomAreaView addSubview:self.payHelpBtn];
        
        [self.mobileRechargeView addSubview:_bottomAreaView];
        
    }
    return _bottomAreaView;
}

//支付按钮
- (UIButton *)settlementBtn
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
- (UIButton *)payHistoryBtn
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

//帮助按钮
- (UIButton *)payHelpBtn
{
    if (!_payHelpBtn) {
         _payHelpBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 30, 30)];
        [_payHelpBtn setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
        [_payHelpBtn setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateHighlighted];
        [_payHelpBtn addTarget:self action:@selector(helpButtonHeadler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payHelpBtn;
}

- (MobileRechargeNewService *)service
{
    if (!_service) {
        _service=[[MobileRechargeNewService alloc] init];
        _service.delegate=self;
    }
    return _service;
}

- (SNDropDownMenuViewController *)dropDownMenuViewController{
    
    if (!_dropDownMenuViewController) {
        
        _dropDownMenuViewController =[[SNDropDownMenuViewController alloc] initWithSuperView:self.mobileRechargeView withFrame:CGRectMake(10, 40, kTextFieldWidth, 170)];
        _dropDownMenuViewController.delegate = self;
        _dropDownMenuViewController.menuTableViewOffset = UIEdgeInsetsMake(-10, 0, 10, 0);
    }
    return _dropDownMenuViewController;
}

//水电煤缴费
- (WaterElectricityGasService *)waterElecGasService
{
    if (!_waterElecGasService) {
        _waterElecGasService = [[WaterElectricityGasService alloc] init];
        _waterElecGasService.delegate = self;
    }
    
    return _waterElecGasService;
}

- (UITableView *)wGroupTableView{
	
	if(!_wGroupTableView){
		
        _wGroupTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStyleGrouped];
		[_wGroupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_wGroupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_wGroupTableView.scrollEnabled = YES;
		_wGroupTableView.userInteractionEnabled = YES;
		_wGroupTableView.delegate =self;
		_wGroupTableView.dataSource =self;
		_wGroupTableView.backgroundColor =[UIColor clearColor];
        _wGroupTableView.backgroundView = nil;
        _wGroupTableView.tableFooterView = nil;
	}
	
	return _wGroupTableView;
}

- (UITableView *)eGroupTableView{
	
	if(!_eGroupTableView){
		
        _eGroupTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                        style:UITableViewStyleGrouped];
		[_eGroupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_eGroupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_eGroupTableView.scrollEnabled = YES;
		_eGroupTableView.userInteractionEnabled = YES;
		_eGroupTableView.delegate =self;
		_eGroupTableView.dataSource =self;
		_eGroupTableView.backgroundColor =[UIColor clearColor];
        _eGroupTableView.backgroundView = nil;
        _eGroupTableView.tableFooterView = nil;
        _eGroupTableView.hidden = YES;
	}
	
	return _eGroupTableView;
}

- (UITableView *)gGroupTableView{
	
	if(!_gGroupTableView){
		
        _gGroupTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                        style:UITableViewStyleGrouped];
		[_gGroupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_gGroupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_gGroupTableView.scrollEnabled = YES;
		_gGroupTableView.userInteractionEnabled = YES;
		_gGroupTableView.delegate =self;
		_gGroupTableView.dataSource =self;
		_gGroupTableView.backgroundColor =[UIColor clearColor];
        _gGroupTableView.backgroundView = nil;
        _gGroupTableView.tableFooterView = nil;
        _gGroupTableView.hidden = YES;
	}
	
	return _gGroupTableView;
}

- (ToolBarTextField *)wPayRegionTextField
{
    if (_wPayRegionTextField == nil)
    {
        _wPayRegionTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _wPayRegionTextField.placeholder = L(@"Please click to select region");
        _wPayRegionTextField.borderStyle = UITextBorderStyleNone;
        _wPayRegionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _wPayRegionTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _wPayRegionTextField.delegate = self;
        _wPayRegionTextField.toolBarDelegate = self;
        if ([self.wPayServiceInfoList count] != 0) {
            
            _wPayRegionTextField.text = [self.wPayServiceInfoList objectAtIndex:2];
        }
        _wPayRegionTextField.inputView = self.wRegionPickerView;
    }
    return _wPayRegionTextField;
}

- (ToolBarTextField *)ePayRegionTextField
{
    if (_ePayRegionTextField == nil)
    {
        _ePayRegionTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _ePayRegionTextField.placeholder = L(@"Please click to select region");
        _ePayRegionTextField.borderStyle = UITextBorderStyleNone;
        _ePayRegionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _ePayRegionTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _ePayRegionTextField.delegate = self;
        _ePayRegionTextField.toolBarDelegate = self;
        if ([self.ePayServiceInfoList count] != 0) {
            
            _ePayRegionTextField.text = [self.ePayServiceInfoList objectAtIndex:2];
        }
        _ePayRegionTextField.inputView = self.eRegionPickerView;
    }
    return _ePayRegionTextField;
}

- (ToolBarTextField *)gPayRegionTextField
{
    if (_gPayRegionTextField == nil)
    {
        _gPayRegionTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _gPayRegionTextField.placeholder = L(@"Please click to select region");
        _gPayRegionTextField.borderStyle = UITextBorderStyleNone;
        _gPayRegionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _gPayRegionTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _gPayRegionTextField.delegate = self;
        _gPayRegionTextField.toolBarDelegate = self;
        if ([self.gPayServiceInfoList count] != 0) {
            
            _gPayRegionTextField.text = [self.gPayServiceInfoList objectAtIndex:2];
        }
        _gPayRegionTextField.inputView = self.gRegionPickerView;
    }
    return _gPayRegionTextField;
}

- (ToolBarTextField *)wPayCompanyTextField
{
    if (_wPayCompanyTextField == nil)
    {
        _wPayCompanyTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _wPayCompanyTextField.placeholder = L(@"Please click to select company");
        _wPayCompanyTextField.borderStyle = UITextBorderStyleNone;
        _wPayCompanyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _wPayCompanyTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _wPayCompanyTextField.delegate =self;
        _wPayCompanyTextField.toolBarDelegate = self;
        if ([self.wPayServiceInfoList count] != 0) {
            
            _wPayCompanyTextField.text = [self.wPayServiceInfoList objectAtIndex:5];
            
        }
        _wPayCompanyTextField.inputView = self.wCompanyPickerView;
    }
    return _wPayCompanyTextField;
}

- (ToolBarTextField *)ePayCompanyTextField
{
    if (_ePayCompanyTextField == nil)
    {
        _ePayCompanyTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _ePayCompanyTextField.placeholder = L(@"Please click to select company");
        _ePayCompanyTextField.borderStyle = UITextBorderStyleNone;
        _ePayCompanyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _ePayCompanyTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _ePayCompanyTextField.delegate =self;
        _ePayCompanyTextField.toolBarDelegate = self;
        if ([self.ePayServiceInfoList count] != 0) {
            
            _ePayCompanyTextField.text = [self.ePayServiceInfoList objectAtIndex:5];
            
        }
        _ePayCompanyTextField.inputView = self.eCompanyPickerView;
    }
    return _ePayCompanyTextField;
}

- (ToolBarTextField *)gPayCompanyTextField
{
    if (_gPayCompanyTextField == nil)
    {
        _gPayCompanyTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _gPayCompanyTextField.placeholder = L(@"Please click to select company");
        _gPayCompanyTextField.borderStyle = UITextBorderStyleNone;
        _gPayCompanyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _gPayCompanyTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _gPayCompanyTextField.delegate =self;
        _gPayCompanyTextField.toolBarDelegate = self;
        if ([self.gPayServiceInfoList count] != 0) {
            
            _gPayCompanyTextField.text = [self.gPayServiceInfoList objectAtIndex:5];
            
        }
        _gPayCompanyTextField.inputView = self.gCompanyPickerView;
    }
    return _gPayCompanyTextField;
}

- (keyboardNumberPadReturnTextField *)wPayAccountTextField
{
    if (_wPayAccountTextField == nil)
    {
        _wPayAccountTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _wPayAccountTextField.placeholder = L(@"Please input your pay account");
        _wPayAccountTextField.borderStyle = UITextBorderStyleNone;
        _wPayAccountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _wPayAccountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _wPayAccountTextField.returnKeyType = UIReturnKeyDone;
        _wPayAccountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _wPayAccountTextField.delegate = self;
        if ([self.wPayServiceInfoList count] != 0) {
            
            _wPayAccountTextField.text = [self.wPayServiceInfoList objectAtIndex:6];
        }
    }
    return _wPayAccountTextField;
}

- (keyboardNumberPadReturnTextField *)ePayAccountTextField
{
    if (_ePayAccountTextField == nil)
    {
        _ePayAccountTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _ePayAccountTextField.placeholder = L(@"Please input your pay account");
        _ePayAccountTextField.borderStyle = UITextBorderStyleNone;
        _ePayAccountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _ePayAccountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _ePayAccountTextField.returnKeyType = UIReturnKeyDone;
        _ePayAccountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _ePayAccountTextField.delegate = self;
        if ([self.ePayServiceInfoList count] != 0) {
            
            _ePayAccountTextField.text = [self.ePayServiceInfoList objectAtIndex:6];
        }
    }
    return _ePayAccountTextField;
}

- (keyboardNumberPadReturnTextField *)gPayAccountTextField
{
    if (_gPayAccountTextField == nil)
    {
        _gPayAccountTextField = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(kLeftMargin2, kTopMargin2, kTextFieldWidth2, kTextFieldHeight2)];
        _gPayAccountTextField.placeholder = L(@"Please input your pay account");
        _gPayAccountTextField.borderStyle = UITextBorderStyleNone;
        _gPayAccountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _gPayAccountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _gPayAccountTextField.returnKeyType = UIReturnKeyDone;
        _gPayAccountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _gPayAccountTextField.delegate = self;
        if ([self.gPayServiceInfoList count] != 0) {
            
            _gPayAccountTextField.text = [self.gPayServiceInfoList objectAtIndex:6];
        }
    }
    return _gPayAccountTextField;
}

- (UILabel *)wCustomerNameLabel
{
    if (_wCustomerNameLabel == nil)
    {
        CGRect frame = CGRectMake(110, 5, 185, 40);
        _wCustomerNameLabel = [[UILabel alloc] initWithFrame:frame];
        _wCustomerNameLabel.textColor = [UIColor blackColor];
        _wCustomerNameLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _wCustomerNameLabel.textAlignment = UITextAlignmentLeft;
        _wCustomerNameLabel.backgroundColor = [UIColor clearColor];
        if ([self.wPayServiceInfoList count] == 8) {
            
            _wCustomerNameLabel.text = [self.wPayServiceInfoList objectAtIndex:7];
        }
    }
    
    return _wCustomerNameLabel;
}

- (UILabel *)eCustomerNameLabel
{
    if (_eCustomerNameLabel == nil)
    {
        CGRect frame = CGRectMake(110, 5, 185, 40);
        _eCustomerNameLabel = [[UILabel alloc] initWithFrame:frame];
        _eCustomerNameLabel.textColor = [UIColor blackColor];
        _eCustomerNameLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _eCustomerNameLabel.textAlignment = UITextAlignmentLeft;
        _eCustomerNameLabel.backgroundColor = [UIColor clearColor];
        if ([self.ePayServiceInfoList count] == 8) {
            
            _eCustomerNameLabel.text = [self.ePayServiceInfoList objectAtIndex:7];
        }
    }
    
    return _eCustomerNameLabel;
}

- (UILabel *)gCustomerNameLabel
{
    if (_gCustomerNameLabel == nil)
    {
        CGRect frame = CGRectMake(110, 5, 185, 40);
        _gCustomerNameLabel = [[UILabel alloc] initWithFrame:frame];
        _gCustomerNameLabel.textColor = [UIColor blackColor];
        _gCustomerNameLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _gCustomerNameLabel.textAlignment = UITextAlignmentLeft;
        _gCustomerNameLabel.backgroundColor = [UIColor clearColor];
        if ([self.gPayServiceInfoList count] == 8) {
            
            _gCustomerNameLabel.text = [self.gPayServiceInfoList objectAtIndex:7];
        }
    }
    
    return _gCustomerNameLabel;
}

- (UILabel *)wPayBalanceLabel
{
    if (_wPayBalanceLabel == nil)
    {
        CGRect frame = CGRectMake(110, 5, 185, 40);
        _wPayBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _wPayBalanceLabel.textColor = [UIColor redColor];
        _wPayBalanceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _wPayBalanceLabel.textAlignment = UITextAlignmentLeft;
        _wPayBalanceLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _wPayBalanceLabel;
}

- (UILabel *)ePayBalanceLabel
{
    if (_ePayBalanceLabel == nil)
    {
        CGRect frame = CGRectMake(110, 5, 185, 40);
        _ePayBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _ePayBalanceLabel.textColor = [UIColor redColor];
        _ePayBalanceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _ePayBalanceLabel.textAlignment = UITextAlignmentLeft;
        _ePayBalanceLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _ePayBalanceLabel;
}

- (UILabel *)gPayBalanceLabel
{
    if (_gPayBalanceLabel == nil)
    {
        CGRect frame = CGRectMake(110, 5, 185, 40);
        _gPayBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _gPayBalanceLabel.textColor = [UIColor redColor];
        _gPayBalanceLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _gPayBalanceLabel.textAlignment = UITextAlignmentLeft;
        _gPayBalanceLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _gPayBalanceLabel;
}

#pragma mark -
#pragma mark Picker Views and Tool bar view
- (UIPickerView *)wRegionPickerView
{
    if (_wRegionPickerView == nil)
    {
        _wRegionPickerView = [[UIPickerView alloc] init];
        [_wRegionPickerView setDelegate:self];
        [_wRegionPickerView setDataSource:self];
        [_wRegionPickerView setShowsSelectionIndicator:YES];
    }
    return _wRegionPickerView;
}

- (UIPickerView *)eRegionPickerView
{
    if (_eRegionPickerView == nil)
    {
        _eRegionPickerView = [[UIPickerView alloc] init];
        [_eRegionPickerView setDelegate:self];
        [_eRegionPickerView setDataSource:self];
        [_eRegionPickerView setShowsSelectionIndicator:YES];
    }
    return _eRegionPickerView;
}

- (UIPickerView *)gRegionPickerView
{
    if (_gRegionPickerView == nil)
    {
        _gRegionPickerView = [[UIPickerView alloc] init];
        [_gRegionPickerView setDelegate:self];
        [_gRegionPickerView setDataSource:self];
        [_gRegionPickerView setShowsSelectionIndicator:YES];
    }
    return _gRegionPickerView;
}

- (UIPickerView *)wCompanyPickerView
{
    if (_wCompanyPickerView == nil)
    {
        _wCompanyPickerView = [[UIPickerView alloc] init];
        [_wCompanyPickerView setDelegate:self];
        [_wCompanyPickerView setDataSource:self];
        [_wCompanyPickerView setShowsSelectionIndicator:YES];
    }
    return _wCompanyPickerView;
}

- (UIPickerView *)eCompanyPickerView
{
    if (_eCompanyPickerView == nil)
    {
        _eCompanyPickerView = [[UIPickerView alloc] init];
        [_eCompanyPickerView setDelegate:self];
        [_eCompanyPickerView setDataSource:self];
        [_eCompanyPickerView setShowsSelectionIndicator:YES];
    }
    return _eCompanyPickerView;
}

- (UIPickerView *)gCompanyPickerView
{
    if (_gCompanyPickerView == nil)
    {
        _gCompanyPickerView = [[UIPickerView alloc] init];
        [_gCompanyPickerView setDelegate:self];
        [_gCompanyPickerView setDataSource:self];
        [_gCompanyPickerView setShowsSelectionIndicator:YES];
    }
    return _gCompanyPickerView;
}

@end
