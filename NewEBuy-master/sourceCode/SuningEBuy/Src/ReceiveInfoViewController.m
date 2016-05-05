//
//  ReceiveInfoViewController.m
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReceiveInfoViewController.h"
#import "PayFlowUtil.h"
#import "ShopCartV2ViewController.h"
#import "PaymentModeViewController.h"//确认购买
#import "MemberOrderNamesDTO.h"
#import "MemberOrderDetailsDTO.h"
#import "AddressInfoDAO.h"
#import "BoundPhoneViewController.h"
#import "UITableViewCell+BgView.h"
#import "ChooseCouponViewController.h"//用券页面
#import "NCouponFinalCell.h"
#import "TotalPriceView.h"
#import "PayUserAndAddressView.h"
#import "SuNingSellDao.h"
#import "SuNingSellData.h"
#import "PaySuccessViewController.h"
#import "PaymentChooseViewController.h"//支付方式选择页面
#import "InvoiceSelectViewController.h"

#import "ReceiveInfoProductHeaderCell.h"
#import "ReceiveInfoTotalPriceCell.h"

#import "ReceiveZiyingInfoCell.h"
#import "ReceiveProductInfoViewController.h"
#import "ReceiveInsendTimeViewController.h"

#import "SNSwitch.h"

#import "ShipModeSelectView.h"

#define kAddCodAddressAlertTag      1
#define kPaymentFinishAlertTag      2
#define kPayForPointCouponAlertTag  3

#define TextLabelFont15               [UIFont boldSystemFontOfSize:15]
#define TextDetailLabelFont13           [UIFont boldSystemFontOfSize:13]


@interface ReceiveInfoViewController() <ChooseCouponDelegate,ShipModeSelectViewDelegate>
{
    BOOL    isCouponLoading;
    BOOL    isLastShipInfoLoading;
    BOOL    isGift;
    BOOL    isChangeInvoice;
    BOOL    isFirstSavePaymentType;
    BOOL    isSaveDeliveryOK;               //检查配送方式及地址是否成功
    BOOL    isGetDelTimeOK;                 //获取送货时间是否成功
    
    BOOL    isCloudDiamUse;                 //是否已使用云钻抵现
    BOOL    isFromGetCloudDiamDetail;       //是否是查询云钻详情
    
    BOOL    canTake;                        //是否可自提
    
    BOOL    isSwitchValueChanged;                //运钻switch是否改变
    
    //数据容器
    NSArray *_dataSourceArray;
}

//views
@property (nonatomic, strong) UIButton *shipModeButton;
@property (nonatomic, strong) UILabel   *shipModeDesc;
@property (nonatomic, strong) TotalPriceView *totalPriceView;

@property (nonatomic, strong) ShipModeSelectView    *shipModeSelectView;

@property (nonatomic, assign) BOOL  isCommitLoading;
@property (nonatomic, assign) BOOL  isStat;
@property (nonatomic, strong) NSMutableArray *selectCouponList;
@property (nonatomic, strong) NSString *captcha;   //验证码
@property (nonatomic, strong) NSString *allianceName;   //联盟推荐名称
@property (nonatomic, strong) NSString *allianceDiscount;   //联盟推荐金额
@property (nonatomic, strong) ChooseCouponViewController  *chooseCouponVC;

@property (nonatomic, strong) PayUserAndAddressView *payUserAndAddressView;//用户配送信息

@property (nonatomic, strong) UISwitch *cloudDiamSwitch;

@property (nonatomic, assign) InsendTimeType    insendTimeType;
@property (nonatomic, strong) InsendTimeDTO     *insendTimeDto;
@property (nonatomic, strong) NSArray           *insendList;
@property (nonatomic, strong) NSString          *changeDateStr;
@property (nonatomic, strong) NSString          *changeTimeStr;

//actions
//- (void)sendCouponListRequest;
- (void)sendLastShipInfoReqeust;
- (void)sendSubmitOrderHttpRequest;

@end

/*********************************************************************/

@implementation ReceiveInfoViewController

@synthesize powerFlag = _powerFlag;
@synthesize deliveryCityCode = _deliveryCityCode;
@synthesize productList = _productList;
@synthesize payFlowService = _payFlowService;
//@synthesize giftCouponService = _giftCouponService;
//@synthesize checkCodeService = _checkCodeService;

@synthesize shipMode = _shipMode;
@synthesize addressInfo = _addressInfo;
@synthesize storeInfo = _storeInfo;
@synthesize shipModeButton = _shipModeButton;
@synthesize invoiceStr = _invoiceStr;
@synthesize isCommitLoading = _isCommitLoading;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_powerFlag);
    TT_RELEASE_SAFELY(_deliveryCityCode);
    TT_RELEASE_SAFELY(_productList);
    
    SERVICE_RELEASE_SAFELY(_payFlowService);
    
    TT_RELEASE_SAFELY(_addressInfo);
    TT_RELEASE_SAFELY(_storeInfo);
    TT_RELEASE_SAFELY(_shipModeButton);
    
    [self removeObserver:self forKeyPath:@"isCommitLoading"];
    
    //移除去结算的监听
    [[ShopCartV2ViewController sharedShopCart] removeObserverForOrderCheckOut];
}

- (id)init {
    self = [super init];
    if (self) {
        
        self.title                  = L(@"reciverInfo");
        self.pageTitle              = L(@"shopProcess_shop_billInfo");
        isUpfold                    = NO;
        isUpNum                     = NO;
        isChangeInvoice             = NO;
        isFirstSavePaymentType      = YES;
        self.totalFareStr           = @"199.00";
        self.isCOrder               = NO;
        isCloudDiamUse              = NO;
        isFromGetCloudDiamDetail    = NO;
        canTake                     = NO;
        isSwitchValueChanged        = self.cloudDiamSwitch.on;
        self.orderRemarkStr         = @"";
        self.isSubmitOrders         = NO;
        if (!_orderRemarkDic) {
            _orderRemarkDic = [[NSMutableDictionary alloc] init];
        }
        if (!_insendTimeDic)
        {
            _insendTimeDic = [[NSMutableDictionary alloc] init];
        }
        [self addObserver:self
               forKeyPath:@"isCommitLoading"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
        //初始为苏宁配送
        self.shipMode = ShipModeSuningSend;
        
        
    }
    return self;
}

- (void)righBarClick
{
    [self nextHeadler:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (keyPath && [keyPath isEqualToString:@"isCommitLoading"]) {
        
        BOOL isLoading = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        
        if (isLoading) {
//            self.submitBtn.enabled = NO;
//            self.navigationItem.rightBarButtonItem.enabled = NO;
        }else{
//            self.submitBtn.enabled = YES;
//            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
    
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    [super loadView];
    
    if (!IOS7_OR_LATER) {
        self.tpGroupTableView = self.tpTableView;
    }
    
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];
    self.tpGroupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    frame.size.height = frame.size.height  - 48;
    self.tpGroupTableView.frame = frame;
    [self.view addSubview:self.tpGroupTableView];
    self.tpGroupTableView.backgroundColor = [UIColor view_Back_Color];
//    self.tpGroupTableView.tableFooterView = self.totalPriceView;
    self.groupTableView = self.tpGroupTableView;
    
    [self useBottomNavBar];
    self.submitBtn.frame = CGRectMake(175, 6, 130, 36);
    self.bottomNavBar.backButton.hidden = YES;
    self.totalPriceView.userInteractionEnabled = NO;
    [self.bottomNavBar addSubview:self.submitBtn];
    [self.bottomNavBar addSubview:self.totalPriceView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (KPerformance)
    {
        _isStat = NO;
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = [NSDate date];
    }
    //初始发票抬头输入框的文本
    /* FIX ME */
    //2.5.X第一个小版本修改，第二个大版本启用被注释的
    if (self.canUseEleInvoice) {
        if (self.eleInvoiceIsDefault) {
            invoiceType = 2;
        }else
            invoiceType = 0;
    }
//    if (self.canUseEleInvoice) {
//        if (self.eleInvoiceIsDefault) {
//            invoiceType = 2;
//        }else
//            invoiceType = 5;
//    }
//    else
//    {
//        invoiceType = 0;
//    }
    
    if (self.powerFlag&&[self.powerFlag isEqualToString:@"true"]) {
        self.invoiceStr = @"";
    }else{
        self.invoiceStr = L(@"individual");
    }
    if ([UserCenter defaultCenter].isLogined) {
        if (IsArrEmpty([UserCenter defaultCenter].userInfoDTO.addressArray))
        {
            
            //如果地址信息还没有，说明用户无地址信息，提示新增
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips")
                                                            message:L(@"addCodAdrress")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"Cancel")
                                                  otherButtonTitles:L(@"Ok")];
            alert.tag = kAddCodAddressAlertTag;
            [alert show];
        }
        else
        {
            
            if (KPerformance)
            {
                PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"6";
                temp.interfaceId = @"601";
                temp.taskId = @"1006";
                [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
            }
            [self sendLastShipInfoReqeust];
            
        }
    }
    self.submitBtn.enabled = NO;
    isFromGetCloudDiamDetail = YES;
    //获取用户可用云钻
    if (KPerformance)
    {
        PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
        temp.startTime = [NSDate date];
        temp.functionId = @"6";
        temp.interfaceId = @"602";
        temp.taskId = @"1006";
        [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
    }
    [self.payFlowService beginGetCloudDiamond:@"2"];
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:L(@"BTSubmitOrders") forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [_submitBtn addTarget:self action:@selector(righBarClick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self reloadTableView];
    
    
    //    [self checkCityChange];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (KPerformance)
    {
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = nil;
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
    }

}

- (void)calculateProduct:(NSArray *)array
{
    if (!IsArrEmpty(array)) {
        for (ShopCartShopDTO *shopDto in array) {
            NSArray *list = [shopDto itemList];
            NSMutableArray *v2DtoList = [[NSMutableArray alloc] init];
            if (!IsArrEmpty(list)) {
                for (ShopCartV2DTO *dto in list) {
                    [v2DtoList addObject:dto];
                    if (!IsArrEmpty(dto.accessoryPackageList)) {
                        [v2DtoList addObjectsFromArray:dto.accessoryPackageList];
                    }
                    else if (!IsArrEmpty(dto.xnPackageList)){
                        [v2DtoList addObjectsFromArray:dto.xnPackageList];
                    }
//                    else if (!IsArrEmpty(dto.smallPackageList)){
//                        [v2DtoList addObjectsFromArray:dto.smallPackageList];
//                    }
                }
            }
            shopDto.itemList = v2DtoList;
        }
    }
    self.productList = array;
}

#pragma mark -
#pragma mark propertys getters

- (PayFlowService *)payFlowService
{
    if (!_payFlowService) {
        _payFlowService = [[PayFlowService alloc] init];
        _payFlowService.delegate = self;
    }
    return _payFlowService;
}

- (InsendTimeDTO *)insendTimeDto
{
    if (!_insendTimeDto) {
        _insendTimeDto = [[InsendTimeDTO alloc] init];
    }
    return _insendTimeDto;
}

- (ShipModeSelectView *)shipModeSelectView
{
    if (!_shipModeSelectView) {
        _shipModeSelectView = [[ShipModeSelectView alloc] init];
        _shipModeSelectView.delegate = self;
        _shipModeSelectView.backgroundColor = [UIColor clearColor];
    }
    return _shipModeSelectView;
}

//初始自提城市与下单城市一致
- (StoreInfoDto *)storeInfo
{
    if (!_storeInfo) {
        _storeInfo = [[StoreInfoDto alloc] init];
        
        _storeInfo.receiptName = self.addressInfo.recipient;
        _storeInfo.receiptPhone = self.addressInfo.tel;
        
        _storeInfo.cityId = self.deliveryCityCode;
        
        if ([AddressInfoDAO isUpdateAddressOk])
        {
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            AddressInfoDTO *dto = [dao getProvinceAndCityInfoByCityCode:self.deliveryCityCode];
            _storeInfo.cityName = dto.cityContent;
            _storeInfo.provinceId = dto.province;
            _storeInfo.provinceName = dto.provinceContent;
        }
        else if (self.deliveryCityName.length > 0)
        {
            _storeInfo.cityName = self.deliveryCityName;
        }
    }
    return _storeInfo;
}

//默认的地址信息
- (AddressInfoDTO *)addressInfo
{
    if (!_addressInfo) {
        _addressInfo = [[AddressInfoDTO alloc] init];
    }
    return _addressInfo;
}

- (payFlowDTO *)savePayFlowDto
{
    if (!_savePayFlowDto) {
        _savePayFlowDto = [[payFlowDTO alloc] init];
        _savePayFlowDto.policyId = @"11613";
        _savePayFlowDto.subpolicyid = @"";
        _savePayFlowDto.subCodpolicyId = @"";
        _savePayFlowDto.payMode = PayModeCard2OnLine;
        _savePayFlowDto.cashPayMode = 0;
    }
    return _savePayFlowDto;
}

- (TotalPriceView *)totalPriceView
{
    if (!_totalPriceView) {
        _totalPriceView = [[TotalPriceView alloc] init];
        _totalPriceView.frame = CGRectMake(0, 0, 320, 48);
        _totalPriceView.backgroundColor = [UIColor clearColor];
    }
    return _totalPriceView;
}

- (UILabel *)shipModeDesc
{
    if (!_shipModeDesc) {
        _shipModeDesc = [[UILabel alloc] init];
        _shipModeDesc.backgroundColor = [UIColor clearColor];
        _shipModeDesc.frame = CGRectMake(100, 7, 180, 30);
        _shipModeDesc.text = L(@"PFHomeDelivery");
        _shipModeDesc.textAlignment = NSTextAlignmentLeft;
        _shipModeDesc.textColor = [UIColor light_Black_Color];
        _shipModeDesc.font = TextLabelFont15;
    }
    return _shipModeDesc;
}

- (UIButton *)shipModeButton
{
    if (!_shipModeButton)
    {
//        NSArray *array = [NSArray arrayWithObjects:L(@"suning delivey"),L(@"store mention"), nil];
        _shipModeButton = [[UIButton alloc] init];
        _shipModeButton.frame = CGRectMake(95, 8, 104, 30);
        [_shipModeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -32, 0, 0)];
        //        [_shipModeButton setBackgroundImage:[UIImage imageNamed:@"payment_ship_mode_btn.png"] forState:UIControlStateNormal];
        [_shipModeButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        [_shipModeButton setBackgroundImage:[UIImage imageNamed:@"ShopCart_kuang.png"] forState:UIControlStateNormal];
        _shipModeButton.titleLabel.font = TextLabelFont15;
        
        UIImage *selectImg = [UIImage imageNamed:@"ShopCart_ShipMode_Select.png"];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(82, 13, 9, 7)];
        img.image = selectImg;
//        img.transform = CGAffineTransformMakeRotation(M_PI);
        [_shipModeButton addSubview:img];
        [_shipModeButton addTarget:self action:@selector(changeShipMode) forControlEvents:UIControlEventTouchUpInside];
//        _shipModeButton.delegate = self;
//        _shipModeButton.isShowSelectItemOnButton = YES;
    }
    return _shipModeButton;
}

- (UISwitch *)cloudDiamSwitch
{
    if (!_cloudDiamSwitch) {
        _cloudDiamSwitch = [[UISwitch alloc] init];
        if (IOS7_OR_LATER) {
            _cloudDiamSwitch.frame = CGRectMake(255, 7, 40, 40);
        }
        else
        {
            _cloudDiamSwitch.frame = CGRectMake(230, 8, 30, 30);
        }
        _cloudDiamSwitch.on = NO;
        [_cloudDiamSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _cloudDiamSwitch;
}

- (PayUserAndAddressView *)payUserAndAddressView
{
    if (!_payUserAndAddressView) {
        _payUserAndAddressView = [[PayUserAndAddressView alloc] init];
    }
    return _payUserAndAddressView;
}

#pragma mark ----------------------------- tableview reload

- (void)reloadTableViewData
{
    [self prepareTableViewDatasource];
    [self.groupTableView reloadData];
}

- (void)prepareTableViewDatasource
{
    NSMutableArray *array = [NSMutableArray array];
    
    //第一个section，展示配送方式及地址
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //配送方式
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"DiliveryMode_Cell",
                                      kTableViewCellHeightKey: @44.0f
                                      };
            [cellList addObject:cellDic];
        }
        //配送地址
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Address_Cell",
                                      kTableViewCellHeightKey: @([self heightOfShipModeCell])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@10.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    //第二个section，展示支付方式
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //支付方式
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"PayType_Cell",
                                      kTableViewCellHeightKey: @([self heightOfPayTypeCell])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    //第三个section，展示发票信息
    {
        /* FIX ME */
        //2.5.X第一个小版本修改，第二个大版本启用被注释的
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //发票信息title
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"InvoiceType_Cell",
                                      kTableViewCellHeightKey: @44.0f
                                      };
            [cellList addObject:cellDic];
        }
        //发票信息detail
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"InvoiceTypeDetail_Cell",
                                      kTableViewCellHeightKey: @85.0f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
        //        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //        //添加数据
        //        NSMutableArray *cellList = [NSMutableArray array];
        //        //发票信息title
        //        {
        //            NSDictionary *cellDic = @{
        //                                      kTableViewCellTypeKey: @"InvoiceType_Cell",
        //                                      kTableViewCellHeightKey: @44.0f
        //                                      };
        //            [cellList addObject:cellDic];
        //        }
        //        //发票信息detail
        //        if (invoiceType != 5)
        //        {
        //            NSDictionary *cellDic = @{
        //                                      kTableViewCellTypeKey: @"InvoiceTypeDetail_Cell",
        //                                      kTableViewCellHeightKey: @85.0f
        //                                      };
        //            [cellList addObject:cellDic];
        //        }
        //
        //        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        //        [dic setObject:cellList forKey:kTableViewCellListKey];
        //
        //        [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
        //        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        //        
        //        [array addObject:dic];
    }
    //第四个section，展示云钻抵现
    if (!IsStrEmpty(self.cloudDiamQty)
        && ![self.cloudDiamQty isEqualToString:@"0"]
        && !IsStrEmpty(self.cloudDiamAmt)
        && [self.cloudDiamAmt doubleValue] >= 0.01)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //支付方式
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"CloudDiam_Cell",
                                      kTableViewCellHeightKey: @44.f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    //第五个section，展示券
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //选择券title
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"CouponTypeSelect_Cell",
                                      kTableViewCellHeightKey: @44.0f
                                      };
            [cellList addObject:cellDic];
        }
        //已选择的优惠券或礼品卡
        {
            if (self.selectCouponList.count > 0) {
                for (GiftCouponDTO *dto in self.selectCouponList) {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"CouponTypeDetail_Cell",
                                              kTableViewCellDataKey: dto,
                                              kTableViewCellHeightKey: @([NCouponFinalCell height])
                                              };
                    [cellList addObject:cellDic];
                }
            }
            if ([self hasAlliance])
            {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"CouponTypeAllianceDetail_Cell",
                                          kTableViewCellDataKey: [NSNull null],
                                          kTableViewCellHeightKey: @([NCouponFinalCell height])
                                          };
                [cellList addObject:cellDic];
            }
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    //第六个section，展示商品信息
    {
        if (self.productList.count > 0) {
            for (ShopCartShopDTO *shop in self.productList) {
                //店家
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                NSMutableArray *cellList = [NSMutableArray array];
                
                //第一行展示店家信息
                {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"Shop_Cell",
                                              kTableViewCellDataKey: shop,
                                              kTableViewCellHeightKey: @44.0f
                                              };
                    [cellList addObject:cellDic];
                }
                //商品信息
                /* FIX ME */
                //2.5.X第一个小版本修改，第二个大版本启用被注释的
                for (ShopCartV2DTO *dto in shop.itemList) {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"Item_Cell",
                                              kTableViewCellDataKey: dto,
                                              kTableViewCellHeightKey : @80.0f
                                              };
                    [cellList addObject:cellDic];
                }
                //供应商展示备注信息
                if (NO == [shop isSuning]) {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"Remark_Cell",
                                              kTableViewCellDataKey: shop,
                                              kTableViewCellHeightKey: @44.0f
                                              };
                    [cellList addObject:cellDic];
                }
                //                //自营商品展示送达时间
                //                if ([shop isSuning] == YES)
                //                {
                //                    if (isSaveDeliveryOK == NO || isGetDelTimeOK == NO)
                //                    {
                //                        if (shop.itemList.count == 1) {
                //                            ShopCartV2DTO *dto = [shop.itemList objectAtIndex:0];
                //                            NSDictionary *cellDic = @{
                //                                                      kTableViewCellTypeKey: @"Item_Cell",
                //                                                      kTableViewCellDataKey: dto,
                //                                                      kTableViewCellHeightKey : @78.0f
                //                                                      };
                //                            [cellList addObject:cellDic];
                //                        }
                //                        else
                //                        {
                //                            NSDictionary *cellDic = @{
                //                                                      kTableViewCellTypeKey: @"SuningItem_Cell",
                //                                                      kTableViewCellDataKey: shop.itemList,
                //                                                      kTableViewCellHeightKey: @78.0f
                //                                                      };
                //                            [cellList addObject:cellDic];
                //                        }
                //                    }else
                //                    {
                //                        //如果自营商品只有一件，则展示详细信息
                //                        //自营商品超过1件，展示缩略图
                //                        //送货时间为默认时，即不可拆分，接口返回多少个数据则展示多少个
                //                        if (self.insendTimeType == InsendTimeDefault) {
                //                            for (MergeDataOptionDTO *mergeDataDto in self.insendList) {
                //                                if (mergeDataDto.itemsVoList.count == 1) {
                //                                    ItemsVoDTO *itemDto = [mergeDataDto.itemsVoList objectAtIndex:0];
                //                                    ShopCartV2DTO *dto  = [[ShopCartV2DTO alloc] init];
                //                                    dto.partNumber      = itemDto.partNumber;
                //                                    dto.itemPrice       = @([itemDto.itemPrice doubleValue]);
                //                                    dto.quantity        = itemDto.quantity;
                //                                    dto.productName     = itemDto.productName;
                //                                    NSDictionary *cellDic = @{
                //                                                              kTableViewCellTypeKey: @"Item_Cell",
                //                                                              kTableViewCellDataKey: dto,
                //                                                              kTableViewCellHeightKey : @78.0f
                //                                                              };
                //                                    [cellList addObject:cellDic];
                //                                }
                //                                else
                //                                {
                //                                    NSMutableArray *itemsVoList = [[NSMutableArray alloc] init];
                //                                    for (ItemsVoDTO *itemDto in mergeDataDto.itemsVoList) {
                //                                        ShopCartV2DTO *shopCartDto = nil;
                //                                        shopCartDto = itemDto.transformToShopCartV2DTO;
                //                                        [itemsVoList addObject:shopCartDto];
                //                                    }
                //                                    NSDictionary *cellDic = @{
                //                                                              kTableViewCellTypeKey: @"SuningItem_Cell",
                //                                                              kTableViewCellDataKey: itemsVoList,
                //                                                              kTableViewCellHeightKey: @78.0f
                //                                                              };
                //                                    [cellList addObject:cellDic];
                //                                }
                //                                //自营商品送达时间展示
                //                                {
                //                                    NSDictionary *cellDic = @{
                //                                                              kTableViewCellTypeKey: @"SendTimeItem_Cell",
                //                                                              kTableViewCellDataKey: mergeDataDto,
                //                                                              kTableViewCellHeightKey: @([ReceiveInsendTimeCell height:self.insendTimeType isFromReceiveView:YES])
                //                                                              };
                //                                    [cellList addObject:cellDic];
                //                                }
                //                            }
                //                        }
                //                        //可拆分与合并，所有自营商品全写在一个cell里
                //                        else
                //                        {
                //                            if (shop.itemList.count == 1) {
                //                                ShopCartV2DTO *dto = [shop.itemList objectAtIndex:0];
                //                                NSDictionary *cellDic = @{
                //                                                          kTableViewCellTypeKey: @"Item_Cell",
                //                                                          kTableViewCellDataKey: dto,
                //                                                          kTableViewCellHeightKey : @78.0f
                //                                                          };
                //                                [cellList addObject:cellDic];
                //                            }
                //                            else
                //                            {
                //                                NSDictionary *cellDic = @{
                //                                                          kTableViewCellTypeKey: @"SuningItem_Cell",
                //                                                          kTableViewCellDataKey: shop.itemList,
                //                                                          kTableViewCellHeightKey: @78.0f
                //                                                          };
                //                                [cellList addObject:cellDic];
                //                            }
                //                            //自营商品送达时间展示
                //                            {
                //                                MergeDataOptionDTO *mergeDataDto = [self.insendList objectAtIndex:0];
                //                                NSDictionary *cellDic = @{
                //                                                          kTableViewCellTypeKey: @"SendTimeItem_Cell",
                //                                                          kTableViewCellDataKey: mergeDataDto,
                //                                                          kTableViewCellHeightKey: @([ReceiveInsendTimeCell height:self.insendTimeType isFromReceiveView:YES])
                //                                                          };
                //                                [cellList addObject:cellDic];
                //                            }
                //                        }
                //                    }
                //                    
                //                }
                //                else
                //                {
                //                    for (ShopCartV2DTO *dto in shop.itemList) {
                //                        NSDictionary *cellDic = @{
                //                                                  kTableViewCellTypeKey: @"Item_Cell",
                //                                                  kTableViewCellDataKey: dto,
                //                                                  kTableViewCellHeightKey : @80.0f
                //                                                  };
                //                        [cellList addObject:cellDic];
                //                    }
                //                    
                //                    //供应商展示备注信息
                //                    {
                //                        NSDictionary *cellDic = @{
                //                                                  kTableViewCellTypeKey: @"Remark_Cell",
                //                                                  kTableViewCellDataKey: shop,
                //                                                  kTableViewCellHeightKey: @44.0f
                //                                                  };
                //                        [cellList addObject:cellDic];
                //                    }
                //                }

                
                [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
                [dic setObject:cellList forKey:kTableViewCellListKey];
                
                [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
                [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
                
                [array addObject:dic];
            }
        }
    }
    //金额展示section
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品总金额
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductPrice_Cell",
                                      kTableViewCellHeightKey: @([ReceiveInfoTotalPriceCell height:self.totalDiscount])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@5.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@0.0f forKey:kTableViewSectionFooterHeightKey];
//        [dic setObject:@"TotalPrice_View" forKey:kTableViewSectionFooterTypeKey];
        
        [array addObject:dic];
    }
    
    _dataSourceArray = array;
}

- (CGFloat)heightOfShipModeCell
{
    NSString *desc = nil;
    if (self.shipMode == ShipModeSelfTake)//自提
    {
        desc = [PayFlowUtil generateStoreMentionInfo:self.storeInfo];
    }
    else
    {
        desc = [PayFlowUtil generateUserFullAddressInfo:self.addressInfo];
    }
    
    CGSize size = [desc sizeWithFont:[UIFont systemFontOfSize:13.0]
                   constrainedToSize:CGSizeMake(260, 50)];
    
    return size.height + 50 > 70 ? size.height + 50 : 70;
}

- (CGFloat)heightOfPayTypeCell
{
    if (NO == self.isCOrder) {
        if ([SNSwitch isShowPayTypeAlert]) {
            return 72;
        }
        return 44;
    }
    else
    {
        return 44;
    }
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionHeaderHeightKey] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionFooterHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
//    NSString *type = [sectionDic objectForKey:kTableViewSectionFooterTypeKey];
//    
//    if ([type isEqualToString:@"TotalPrice_View"])
//    {
//        
////        UIView *view = [[UIView alloc] init];
////        view.frame = CGRectMake(0, 0, 320, 50);
////        view.backgroundColor = [UIColor greenColor];
////
////        self.totalPriceView.backgroundColor = [UIColor greenColor];
//        [self.totalPriceView setTotalPrice:self.shouldPayPrice farPrice:self.totalFareStr];
//        return self.totalPriceView;
//    }
//    else
    {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"DiliveryMode_Cell"]) //配送方式
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.textLabel.font = TextLabelFont15;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = L(@"DiliveryMode");
        if (self.isCOrder) {
            cell.accessoryView = nil;
            [cell.contentView addSubview:self.shipModeDesc];
        }else{
            if (self.shipMode == ShipModeSuningSend) {
                [self.shipModeButton setTitle:L(@"suning delivey") forState:UIControlStateNormal];
            }
            else
            {
                [self.shipModeButton setTitle:L(@"store mention") forState:UIControlStateNormal];
            }
            [cell.contentView addSubview:self.shipModeButton];
        }
        return cell;
    }
    else if ([cellType isEqualToString:@"Address_Cell"])  //配送地址
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        }
        if (self.shipMode == ShipModeSelfTake)//自提
        {
            self.payUserAndAddressView.frame = CGRectMake(0, 0, 320, [PayUserAndAddressView height:[PayFlowUtil generateStoreMentionInfo:self.storeInfo]]);
            
            [self.payUserAndAddressView setShipMode:self.shipMode UserName:self.storeInfo.receiptName phoneNum:self.storeInfo.receiptPhone addressInfo:[PayFlowUtil generateStoreMentionInfo:self.storeInfo]];
            
        }else{
            self.payUserAndAddressView.frame = CGRectMake(0, 0, 320, [PayUserAndAddressView height:[PayFlowUtil generateUserFullAddressInfo:self.addressInfo]]);
            
            [self.payUserAndAddressView setShipMode:self.shipMode UserName:self.addressInfo.recipient phoneNum:self.addressInfo.tel addressInfo:[PayFlowUtil generateUserFullAddressInfo:self.addressInfo]];
        }
        
        [cell.contentView addSubview:self.payUserAndAddressView];
        
        return cell;
    }
    else if ([cellType isEqualToString:@"PayType_Cell"])    //支付方式
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            
            cell.textLabel.font = TextLabelFont15;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.detailTextLabel.numberOfLines = 0;
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            cell.detailTextLabel.textColor = [UIColor orange_Light_Color];
        }
        cell.textLabel.text = [self payTypeDesc];
        
        UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
        imageArrow.frame = CGRectMake(270, 17, 6, 11);
        cell.accessoryView = imageArrow;
        if (NO == self.isCOrder) {
            if ([SNSwitch isShowPayTypeAlert]) {
                NSString *payTypeStr = [SNSwitch showPayTypeAlertString];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"\n%@",payTypeStr];
            }
        }
        
        return cell;
        
    }
    else if ([cellType isEqualToString:@"InvoiceType_Cell"])    //发票信息
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.textLabel.font = TextLabelFont15;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        /* FIX ME */
        //2.5.X第一个小版本修改，第二个大版本启用被注释的
        cell.textLabel.text = L(@"PFInvoiceInformation");
//        else{
//            [cell.contentView removeAllSubviews];
//        }
//        
//        if (invoiceType == 5) {
//            cell.textLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"PFInvoiceInformation"),L(@"PFNoInvoice")];
//            
//            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
//            imageArrow.frame = CGRectMake(298, 17, 6, 11);
//            [cell.contentView addSubview:imageArrow];
//        }else
//        {
//            cell.textLabel.text = L(@"PFInvoiceInformation");
//        }
        
        return cell;
    }
    else if ([cellType isEqualToString:@"InvoiceTypeDetail_Cell"])    //发票详细信息
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.textLabel.font = TextLabelFont15;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        }
        else{
            [cell.contentView removeAllSubviews];
        }
        
        UILabel *leixinLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 290, 15)];
        leixinLbl.font = [UIFont systemFontOfSize:14];
        leixinLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        leixinLbl.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:leixinLbl];
        
        UILabel *taitouLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 290, 15)];
        taitouLbl.font = [UIFont systemFontOfSize:14];
        taitouLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        taitouLbl.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:taitouLbl];
        
        UILabel *zhuyiLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 290, 15)];
        zhuyiLbl.font = [UIFont systemFontOfSize:14];
        zhuyiLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        zhuyiLbl.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:zhuyiLbl];
        
        if (!isChangeInvoice) {
            if (self.shipMode == ShipModeSelfTake)//自提
            {
                self.invoiceStr = self.storeInfo.receiptName;
            }else{
                self.invoiceStr = self.addressInfo.recipient;
            }
            [self checkBtnEnabledOrNot];
        }
        taitouLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"PFInvoiceHeader"),self.invoiceStr?self.invoiceStr:L(@"PFCustomer")];
        
        if (YES == self.canUseEleInvoice && invoiceType == 2 && (YES == self.eleInvoiceIsDefault || isChangeInvoice)) {
            leixinLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"PFInvoiceType"),L(@"PFElectronicInvoice")];
            zhuyiLbl.text = L(@"PFEnvironmentalShoppingToChoiceEleInvoice");
        }
        else
        {
            leixinLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"PFInvoiceType"),L(@"PFOrdinaryInvoice")];
            if (self.isCOrder) {
                zhuyiLbl.text = L(@"PFNoSuningGoodsInvoiceBySupplier");
            }else if([self.powerFlag isEqualToString:@"true"]){
                zhuyiLbl.text = [NSString stringWithFormat:@"%@",L(@"Power_Flag_Notice_Message")];
            }else{
                zhuyiLbl.text = L(@"PFOrdinaryInvoiceBySuningEBuy");
            }
        }
        
        
        return cell;
    }
    else if ([cellType isEqualToString:@"CouponTypeSelect_Cell"]) //优惠券选择
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.textLabel.font = TextLabelFont15;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        }
        cell.textLabel.text = L(@"PFUseCouponOrRecommendationNumber");
        return cell;
    }
    else if ([cellType isEqualToString:@"CouponTypeDetail_Cell"]) //已选择的优惠券
    {
        NCouponFinalCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[NCouponFinalCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:cellType];
        }
        
//        if (self.selectCouponList.count>indexPath.row-1)
//        {
        GiftCouponDTO *dto = (GiftCouponDTO *)item;
        [cell setBalance:dto.balance name:dto.formatedName];
//        }
        return cell;
     
    }
    else if ([cellType isEqualToString:@"CouponTypeAllianceDetail_Cell"]) //已选择的联盟优惠券
    {
        NCouponFinalCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[NCouponFinalCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:cellType];
        }
        
        [cell setBalance:self.allianceDiscount name:self.allianceName];
        return cell;
        
    }
    else if ([cellType isEqualToString:@"CloudDiam_Cell"])          //用户云钻总额
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.textLabel.font = TextLabelFont15;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.contentView addSubview:self.cloudDiamSwitch];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",L(@"PFCanUse"),self.cloudDiamQty,L(@"PFCloudDiamondFor"),self.cloudDiamAmt,L(@"Constant_RMB")];
        return cell;
    }
    
    else if ([cellType isEqualToString:@"Shop_Cell"])   //供应商名称及运费
    {
        ReceiveInfoProductHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInfoProductHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        ShopCartShopDTO *dto = (ShopCartShopDTO *)item;
        cell.shopDTO = dto;
        return cell;
    }
    else if ([cellType isEqualToString:@"SuningItem_Cell"]) //自营信息
    {
        ReceiveZiyingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveZiyingInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        }
        NSArray *productLst = (NSArray *)item;
        [cell setProductList:productLst];
        return cell;
    }
    else if ([cellType isEqualToString:@"SendTimeItem_Cell"]) //送货时间信息
    {
        ReceiveInsendTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInsendTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        MergeDataOptionDTO *mergeDto = (MergeDataOptionDTO *)item;
        [cell setBaseDto:mergeDto WithType:self.insendTimeType WithShipMode:self.shipMode isFromReceiveView:YES];

        return cell;
    }
    else if ([cellType isEqualToString:@"Item_Cell"])   //商品信息
    {
        ReceiveInfoProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInfoProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        ShopCartV2DTO *dto = (ShopCartV2DTO *)item;
        cell.shopCartDto = dto;
        return cell;
    }
    else if ([cellType isEqualToString:@"Remark_Cell"])     //供应商备注
    {
        ReceiveInfoShopRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInfoShopRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        ShopCartShopDTO *dto = (ShopCartShopDTO *)item;
        [cell setRemarkTextWithShopCode:dto.shopCode];
        
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductPrice_Cell"])   //商品总额
    {
        ReceiveInfoTotalPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInfoTotalPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setProductPrice:self.totalPriceStr fare:self.totalFareStr discount:self.totalDiscount];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"Address_Cell"])     //选择送货地址
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1020402"], nil]];
        if (self.shipMode == ShipModeSelfTake)
        {
            StoreMentionViewController *storeMentionViewController =
            [[StoreMentionViewController alloc] initWithStoreInfo:self.storeInfo];
            storeMentionViewController.delegate = self;
            [self.navigationController pushViewController:storeMentionViewController
                                                 animated:YES];
            
            TT_RELEASE_SAFELY(storeMentionViewController);
        }
        else if (self.shipMode == ShipModeSuningSend)
        {
            if (IsArrEmpty([UserCenter defaultCenter].userInfoDTO.addressArray)) {
                AddressNewViewController  *nextController = [[AddressNewViewController alloc] init];
                nextController.delegate = self;
                [self.navigationController pushViewController: nextController animated:YES];
                TT_RELEASE_SAFELY(nextController);
                //                AddressEditViewController *addressEditViewController =
                //                [[AddressEditViewController alloc] initWithBaseAddress:self.addressInfo];
                //                addressEditViewController.delegate = self;
                //                [addressEditViewController setStatusEdit];  //设置为可编辑状态
                //                [self.navigationController pushViewController:addressEditViewController
                //                                                     animated:YES];
                //                TT_RELEASE_SAFELY(addressEditViewController);
            }
            else
            {
                AddressInfoListViewController *addressListViewController =
                [[AddressInfoListViewController alloc] initWith:self];
                addressListViewController.delegate = self;
                addressListViewController.cellType = FromShop;
                [Config currentConfig].defaultAddressId = self.addressInfo.addressNo;
                [self.navigationController pushViewController:addressListViewController animated:YES];
                TT_RELEASE_SAFELY(addressListViewController);
            }
        }
        
    }
    else if ([cellType isEqualToString:@"PayType_Cell"])    //选择支付方式
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1020501"], nil]];
        if (!isSaveDeliveryOK) {
            [self presentSheet:L(@"PFPleaseSelectAddressFirst")];
            return;
        }
        PaymentChooseViewController *choose = [[PaymentChooseViewController alloc] initWithPayFlowDTO:self.savePayFlowDto andShipMode:self.shipMode];
        choose.delegate = self;
        [self.navigationController pushViewController:choose animated:YES];
    }
    else if ([cellType isEqualToString:@"InvoiceType_Cell"] && invoiceType == 5)    //更改发票信息（不开发票）
    {
        InvoiceSelectViewController *vc = [[InvoiceSelectViewController alloc] initWith:self withType:invoiceType];
        vc.canUseEleInvoice = self.canUseEleInvoice;
        /* FIX ME */
        //2.5.X第一个小版本修改，第二个大版本启用被注释的
        //        vc.isDefaultEleInvoice = self.eleInvoiceIsDefault;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cellType isEqualToString:@"InvoiceTypeDetail_Cell"])  //更改发票信息
    {
        InvoiceSelectViewController *vc = [[InvoiceSelectViewController alloc] initWith:self withType:invoiceType];
        vc.canUseEleInvoice = self.canUseEleInvoice;
        /* FIX ME */
        //2.5.X第一个小版本修改，第二个大版本启用被注释的
//        vc.isDefaultEleInvoice = self.eleInvoiceIsDefault;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cellType isEqualToString:@"CouponTypeSelect_Cell"])   //选择优惠券
    {
        if (!_chooseCouponVC)
        {
            self.chooseCouponVC = [[ChooseCouponViewController alloc] init];
            self.chooseCouponVC.delegate = self;
            self.chooseCouponVC.isCOrder = self.isCOrder;
            self.chooseCouponVC.isAllCOrder = self.isAllCOrder;
        }
        [self.navigationController pushViewController:_chooseCouponVC animated:YES];
    }
    else if ([cellType isEqualToString:@"SuningItem_Cell"])   //自营商品信息
    {
        NSArray *productLst = (NSArray *)item;
        
        ReceiveProductInfoViewController *vc = [[ReceiveProductInfoViewController alloc] init];
        vc.productList = productLst;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cellType isEqualToString:@"SendTimeItem_Cell"] && self.insendTimeType != InsendTimeDefault)   //配送时间编辑
    {
        ReceiveInsendTimeViewController *vc = [[ReceiveInsendTimeViewController alloc] initWith:self withType:self.insendTimeType withDto:self.insendTimeDto];
        vc.shipMode = self.shipMode;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ----------------------------- 送货时间选择
- (void)selectSendTimeFinished:(InsendTimeType)type withDictionary:(NSMutableDictionary *)dic
{
    self.insendTimeType = type;
    self.insendTimeDic = dic;
    [self reloadTableViewData];
}

#pragma mark ----------------------------- 发票选择
- (void)chooseInvoiceType:(NSUInteger)type with:(NSString *)invoiceStr
{
    isChangeInvoice = YES;
    self.invoiceStr = invoiceStr;
    invoiceType = type;
    /* FIX ME */
    //2.5.X第一个小版本修改，第二个大版本启用被注释的
    [self.groupTableView reloadData];
//    [self reloadTableViewData];
}

#pragma mark ----------------------------- choose Address

- (void)saveAddressResult:(BOOL)isSuccess service:(PayFlowService *)service payDTO:(payFlowDTO *)dto errorCode:(NSString *)errorCode
{

    isSaveDeliveryOK = YES;
    isChangeInvoice = NO;
    self.canUseEleInvoice    = service.canUseEleInvoice;
    self.eleInvoiceIsDefault = service.eleInvoiceIsDefault;
    /* FIX ME */
    //2.5.X第一个小版本修改，第二个大版本启用被注释的
    if (self.eleInvoiceIsDefault) {
        invoiceType = 2;
    }else
        invoiceType = 0;
//    if (self.canUseEleInvoice) {
//        if (self.eleInvoiceIsDefault) {
//            invoiceType = 2;
//        }else
//            invoiceType = 5;
//    }
//    else
//    {
//        invoiceType = 0;
//    }
    
    self.payFlowService.shopCartItemList = service.shopCartItemList;
    self.payFlowService.productAllPrice = service.productAllPrice;
    self.payFlowService.userPayAllPrice = service.userPayAllPrice;
    self.payFlowService.totalShipPrice = service.totalShipPrice;
    self.payFlowService.totalDiscount = service.totalDiscount;
    self.payFlowService.addressInfoDto = service.addressInfoDto;
    self.payFlowService.storeInfoDto = service.storeInfoDto;
    // 导航到去结算页面
    [self calculateProduct:self.payFlowService.shopCartItemList];
    if (self.shipMode == ShipModeSuningSend) {
        self.addressInfo = self.payFlowService.addressInfoDto;
        if (![self.addressInfo.city isEqualToString:self.currentCityCode]) {
            self.currentCityCode = self.addressInfo.city;
            [self.selectCouponList removeAllObjects];
            self.cloudDiamSwitch.on = NO;
            isCloudDiamUse = NO;
        }
    }else{
        self.storeInfo = self.payFlowService.storeInfoDto;
        if (![self.storeInfo.cityId isEqualToString:self.currentCityCode]) {
            self.currentCityCode = self.storeInfo.cityId;
            [self.selectCouponList removeAllObjects];
            self.cloudDiamSwitch.on = NO;
            isCloudDiamUse = NO;
        }
    }
    /* FIX ME */
    //2.5.X第一个小版本修改，第二个大版本启用被注释的
//    [self.payFlowService beginGetDelAndInsTime];
    [self refreshOrderPrice];
    //2.5.X第二个版本不用reload列表
    [self reloadTableView];
    
}

#pragma mark ----------------------------- choose paymentType delegate
- (void)choosePaymentOK:(payFlowDTO *)dto
{
    self.savePayFlowDto.policyId = dto.policyId;
    self.savePayFlowDto.subpolicyid = dto.subpolicyid;
    self.savePayFlowDto.subCodpolicyId = dto.subCodpolicyId;
    self.savePayFlowDto.payMode = dto.payMode;
    self.savePayFlowDto.cashPayMode = dto.cashPayMode;
    isFirstSavePaymentType = NO;
    [self.groupTableView reloadData];
}


#pragma mark ----------------------------- choose coupon delegate

- (void)chooseCouponDidOk:(ChooseCouponViewController *)vc
{
    self.captcha = vc.captcha;
    self.allianceName = vc.allianceName;
    self.allianceDiscount = vc.allianceDiscount;
    
    self.totalPriceStr = vc.totalPriceStr;
    self.shouldPayPrice = vc.shouldPayPrice;
    self.totalDiscount = vc.totalDiscount;
    self.totalFareStr   = vc.totalFareStr;
    
    if (!IsArrEmpty(vc.selectCouponList))
    {
        self.selectCouponList = [NSMutableArray arrayWithArray:vc.selectCouponList];
        [self reloadTableView];
    }
    else
    {
        [self.selectCouponList removeAllObjects];
        [self reloadTableView];
    }
}

- (BOOL)hasAlliance
{
    if (self.allianceDiscount.doubleValue > 0) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -
#pragma mark service and data source
- (void)sendLastShipInfoReqeust
{
    self.isCommitLoading = YES;
    isLastShipInfoLoading  = YES;
    [self.payFlowService beginGetLastShipInfoRequest];
}

- (void)getLastShipInfoCompletionWithResult:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg
                               lastShipMode:(ShipMode)shipMode
                             lastPickUpInfo:(StoreInfoDto *)pickUpInfo
                               lastShipInfo:(AddressInfoDTO *)shipInfo
{
    isLastShipInfoLoading = NO;
    isLastShipInfoLoaded = YES;
    self.isCommitLoading = (isCouponLoading || isLastShipInfoLoading);
    
    self.addressIterimDto = [[AddressInfoDTO alloc] init];
    self.storeIterimDto = [[StoreInfoDto alloc] init];
    if (KPerformance)
    {
        //NSLog(@"%d",[PerformanceStatistics sharePerformanceStatistics].arrayData.count);
        if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
        {
            
            PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
            if ([temp.interfaceId isEqualToString:@"601"]&&(![temp.distanceTime length]))
            {
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                temp.startTimeStr = [[PerformanceStatistics sharePerformanceStatistics]getStartTimer:temp.startTime];
                temp.endTime = [NSDate date];
                temp.distanceTime = [[PerformanceStatistics sharePerformanceStatistics]getTimer:temp.startTime end:temp.endTime];
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    [[PerformanceStatistics sharePerformanceStatistics] sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                    [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
                }
            }
        }

    }
    if (isSuccess) {
        canTake = self.payFlowService.canTake;
        self.addressIterimDto = shipInfo;
        self.storeIterimDto = pickUpInfo;
        self.storeInfo      = self.storeIterimDto;
        //判断上次购买地址与购物车一地址是否一致,若不一致则在地址列表里去与购物车一地址一致的第一条地址
        if (![self.addressIterimDto.city isEqualToString:self.deliveryCityCode]) {
            self.addressIterimDto = [[UserCenter defaultCenter] getAddressInfoByCity:self.deliveryCityCode];
        }
    }else{
        //如果获取失败，那么从userInfoDTO里面取
        self.addressIterimDto = [[UserCenter defaultCenter] getAddressInfoByCity:self.deliveryCityCode];
    }
    
    BOOL isHasPrefer = NO;
    /*更新userInfo中的地址信息*/
    NSMutableArray *addressInfoArray = [UserCenter defaultCenter].userInfoDTO.addressArray;
    for (AddressInfoDTO *addressDTO in addressInfoArray)
    {
        if (addressDTO.preferFlag) {
            isHasPrefer = YES;
            self.addressInfo = addressDTO;
            break;
        }
    }
    //add by 孔斌
    //判断是否有默认地址,有则取(即使默认地址与购物车一地址不一致),无则请求上次购买地址
    if (KPerformance)
    {
        if (!_isStat)
        {
            PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"6";
            temp.interfaceId = @"603";
            temp.taskId = @"1006";
            [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
            _isStat = YES;
        }
         else if (_isStat)
         {
             if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
             {
                 
                 PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:2];
                 if ([temp.interfaceId isEqualToString:@"603"])
                 {
                     [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                     temp.endTime = [NSDate date];
                     if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                     {
                         [[PerformanceStatistics sharePerformanceStatistics] sendData:temp];
                         [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                         [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
                     }

                 }
             }

         }

    }
    if (isHasPrefer == YES) {
        
        [self confirmDeliveryAddress:self.addressInfo storeInfo:self.storeInfo];
    }
    else
    {
        self.addressInfo    = self.addressIterimDto;
        self.storeInfo      = self.storeIterimDto;
        
        [self confirmDeliveryAddress:self.addressInfo storeInfo:self.storeInfo];
    }
}

- (void)sendSubmitOrderHttpRequest
{
    
    [self displayOverFlowActivityView:L(@"Commit_Order...")];
    self.isCommitLoading = YES;
    self.submitBtn.enabled = NO;
    /*
     NSMutableArray *ecouponList = [[NSMutableArray alloc] init];
     
     for (GiftCouponDTO *dto in self.giftCouponService.cashCardList) {
     if (dto.isSelected) {
     [ecouponList addObject:dto];
     }
     }
     for (GiftCouponDTO *dto in self.giftCouponService.normalCouponList) {
     if (dto.isSelected) {
     [ecouponList addObject:dto];
     }
     }
     */
    //商家留言
    NSArray *keyArr = [self.orderRemarkDic allKeys];
    if ([keyArr count] > 0) {
        for (int i = 0; i < [keyArr count]; i++) {
            NSString *supplierCode = [keyArr objectAtIndex:i];
            NSString *remarkStr = [self.orderRemarkDic objectForKey:supplierCode];
            if (!IsStrEmpty(remarkStr)) {
                if (IsStrEmpty(self.orderRemarkStr)) {
                    self.orderRemarkStr = [NSString stringWithFormat:@"%@<<<%@>>>",supplierCode,remarkStr];
                }
                else
                {
                    self.orderRemarkStr = [NSString stringWithFormat:@"%@%@<<<%@>>>",self.orderRemarkStr,supplierCode,remarkStr];
                }
                
            }
            
        }
    }
    /* FIX ME */
    //2.5.X第一个小版本修改，第二个大版本启用被注释的
    //不开发票抬头传空
//    if (invoiceType == 5) {
//        self.invoiceStr = @"";
//    }
//    //送货时间传参
//    NSArray *insendkeyArr = [self.insendTimeDic allKeys];
//    NSString *appointTimeStr = @"";
//    if ([insendkeyArr count] > 0) {
//        for (int i = 0; i < [insendkeyArr count]; i++) {
//            NSString *orderId = [insendkeyArr objectAtIndex:i];
//            insendTimeSubmitDTO *submitDto = [self.insendTimeDic objectForKey:orderId];
//
//            appointTimeStr = [NSString stringWithFormat:@"%@delTime%@_undefined_%@ %@_%@_@",appointTimeStr,submitDto.orderitemsId,submitDto.delDate,submitDto.delTime,submitDto.delInstallDate];
//        }
//    }
    
    [self.payFlowService beginSubmitOrderRequest:self.shipMode
                                     addressInfo:self.addressInfo
                                       storeInfo:self.storeInfo
                                         invoice:[self.invoiceStr trim]
                                     invoiceType:[NSString stringWithFormat:@"%d",invoiceType]
                                         ecoupon:self.selectCouponList
                                      codeString:self.captcha
                                  orderRemarkStr:self.orderRemarkStr];
    
}

- (void)submitOrderCompletionWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg
                                 payDTO:(payFlowDTO *)dto
{
    //self.productList
    [self removeOverFlowActivityView];
    self.isCommitLoading = NO;
    if (isSuccess) {
        
        //如果不是从立即购买过来的，清除购物车中已勾选的商品
        if (!self.isFromBuyNow)
        {
            NSNotification *notification = [NSNotification notificationWithName:CART_CLEAN_MESSAGE
                                                                         object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        //>
        if (!self.isFromBuyNow)
        {
            SuNingSellDao* tempDao = [[SuNingSellDao alloc] init];
            NSString* str1 = nil;
            NSString* str3 = nil;
            NSString* str4 = nil;
            NSString* str5 = nil;
            for (ShopCartShopDTO* temp1 in self.productList)
            {
                for (ShopCartV2DTO* temp2 in temp1.itemList)
                {
                    NSString *str2 = [tempDao searchSuNingSellDAOToDB:temp2.partNumber];
                    if ([str2 length])
                    {
                        NSArray* array = [str2 componentsSeparatedByString:@"_"];
                        str1 = [NSString stringWithFormat:@"%@",array[0]];
                        str3 = [NSString stringWithFormat:@"%@",array[1]];
                        str4 = [NSString stringWithFormat:@"%@",array[2]];
                        str5 = [NSString stringWithFormat:@"%@",array[3]];
                        [tempDao deleteSuNingSellDAOFromDB:temp2.partNumber isSearch:NO];
                        //                        if (![str1 length])
                        //                        {
                        //                            str1 = [NSString stringWithFormat:@"%@",array[0]];
                        //                        }
                        //                        else if([str1 length])
                        //                        {
                        //                            str1 = [NSString stringWithFormat:@"%@&%@&%@",str1,@"%",array[0]];
                        //                        }
                        //
                        //                        if (![str3 length])
                        //                        {
                        //                            str3 = [NSString stringWithFormat:@"%@",array[1]];
                        //                        }
                        //                        else if([str3 length])
                        //                        {
                        //                            str3 = [NSString stringWithFormat:@"%@&%@&%@",str3,@"%",array[1]];
                        //                        }
                        //
                        //                        if (![str4 length])
                        //                        {
                        //                            str4 = [NSString stringWithFormat:@"%@",array[2]];
                        //                        }
                        //                        else if([str4 length])
                        //                        {
                        //                            str4 = [NSString stringWithFormat:@"%@&%@&%@",str4,@"%",array[2]];
                        //                        }
                        //
                        //                        if (![str5 length])
                        //                        {
                        //                            str5 = [NSString stringWithFormat:@"%@",array[3]];
                        //                        }
                        //                        else if([str5 length])
                        //                        {
                        //                            str5 = [NSString stringWithFormat:@"%@&%@&%@",str5,@"%",array[3]];
                        //                        }
                        
                    }
                    else
                    {
                        str1 = [NSString stringWithFormat:@"%@",L(@"Others")];
                        str3 = [NSString stringWithFormat:@"%@",L(@"Others")];
                        str4 = [NSString stringWithFormat:@"%@",temp2.partNumber];
                        str5 = [NSString stringWithFormat:@"%@",temp2.itemPrice];
                        //                        if (![str1 length])
                        //                        {
                        //                            str1 = [NSString stringWithFormat:@"%@",@"其他"];
                        //                        }
                        //                        else if([str1 length])
                        //                        {
                        //                            str1 = [NSString stringWithFormat:@"%@&%@&%@",str1,@"%",@"其他"];
                        //                        }
                        //
                        //                        if (![str3 length])
                        //                        {
                        //                            str3 = [NSString stringWithFormat:@"%@",@"其他"];
                        //                        }
                        //                        else if([str3 length])
                        //                        {
                        //                            str3 = [NSString stringWithFormat:@"%@&%@&%@",str3,@"%",@"其他"];
                        //                        }
                        //
                        //                        if (![str4 length])
                        //                        {
                        //                            str4 = [NSString stringWithFormat:@"%@",temp2.partNumber];
                        //                        }
                        //                        else if([str4 length])
                        //                        {
                        //                            str4 = [NSString stringWithFormat:@"%@&%@&%@",str4,@"%",temp2.partNumber];
                        //                        }
                        //                        
                        //                        if (![str5 length])
                        //                        {
                        //                            str5 = [NSString stringWithFormat:@"%@",temp2.itemPrice];
                        //                        }
                        //                        else if([str5 length])
                        //                        {
                        //                            str5 = [NSString stringWithFormat:@"%@&%@&%@",str5,@"%",temp2.itemPrice];
                        //                        }
                        
                    }
                    [SSAIOSSNDataCollection CustomEventCollection:@"salesource" keyArray: [NSArray arrayWithObjects:@"sourceid",@"sourceinfo",@"productid",@"price",@"orderid", nil]valueArray: [NSArray arrayWithObjects:str1,str3,str4,str5,dto.orderId, nil]];
                }
            }
            
        }
        else
        {
            for (ShopCartShopDTO* temp1 in self.productList)
            {
                for (ShopCartV2DTO* temp2 in temp1.itemList)
                {
                    [SSAIOSSNDataCollection CustomEventCollection:@"salesource" keyArray: [NSArray arrayWithObjects:@"sourceid",@"sourceinfo",@"productid",@"price",@"orderid", nil]valueArray: [NSArray arrayWithObjects:sourceTitle,daoPageTitle,temp2.partNumber,[NSString stringWithFormat:@"%@",temp2.itemPrice],dto.orderId, nil]];
                }
            }
            
        }
        //<

        //如果dto为空，意为直接支付成功
        if ([dto.prepay floatValue] < 0.000001) {
            
            PaySuccessViewController *success = [[PaySuccessViewController alloc] init];
            success.paymodeType = PayModeByCoupons;
            success.orderId = dto.orderId;
            success.totalPrice = self.shouldPayPrice;
            [self.navigationController pushViewController:success animated:YES];
            return;
        }else if (self.savePayFlowDto.payMode == PayModeCard2CashOnDelivery || self.savePayFlowDto.payMode == PayModeCard2OnStore) {
            PaySuccessViewController *success = [[PaySuccessViewController alloc] init];
            if (self.savePayFlowDto.payMode == PayModeCard2CashOnDelivery) {
                if (self.savePayFlowDto.cashPayMode == CashOnDeliveryCashPay) {
                    success.paymodeType = PayModeByCash;
                }else if (self.savePayFlowDto.cashPayMode == CashOnDeliveryPOSPay){
                    success.paymodeType = PayModeByPOS;
                }
            }else if (self.savePayFlowDto.payMode == PayModeCard2OnStore){
                if (self.shipMode == ShipModeSuningSend) {
                    success.paymodeType = PayModeByStore;
                }else if (self.shipMode == ShipModeSelfTake){
                    success.paymodeType = PayModeByMention;
                }
//                success.paymodeType = PayModeByStore;
            }
            success.orderId = dto.orderId;
            success.totalPrice = dto.prepay;
            [self.navigationController pushViewController:success animated:YES];
            return;
        }
        
        dto.isCOrder = self.isCOrder;
        PaymentModeViewController *paymentModeViewController = [[PaymentModeViewController alloc] initWithPayFlowDTO:dto andShipMode:self.shipMode allPaytype:NO];
        [self.navigationController pushViewController:paymentModeViewController animated:YES];
        
        TT_RELEASE_SAFELY(paymentModeViewController);
        
    }else{
        if ([errorMsg isEqualToString:L(@"BigPreferenceJoinedActivityEnded")] || [errorMsg isEqualToString:L(@"OrderForBigPreferenceNumberOverQuota")] || [errorMsg isEqualToString:L(@"BigPreferenceGoodMargineLack")]) {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil message:errorMsg delegate:self cancelButtonTitle:L(@"Confirmation") otherButtonTitles:nil];
            [alert setCancelBlock:^{
                [self backForePage];
            }];
            [alert show];
        }
        else
        {
            [self presentSheet:errorMsg?errorMsg:L(@"PFSorrySubmitOrderFailAndTryAgainLater")];
        }
    }
    self.submitBtn.enabled = YES;
}

//保存配送方式及地址信息
- (void)saveDeliveryAndAddressCompletionWithResult:(BOOL)isSuccess service:(PayFlowService *)service payDTO:(payFlowDTO *)dto errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    
   
    if (isSuccess) {
        if (KPerformance)
        {
            if (([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)&&([PerformanceStatistics sharePerformanceStatistics].arrayData.count < 4))
            {
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:2];
                    temp.endTime = [NSDate date];
                    [[PerformanceStatistics sharePerformanceStatistics] sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                    [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
                }

            }

        }
        
        isSaveDeliveryOK = YES;
        self.canUseEleInvoice    = service.canUseEleInvoice;
        self.eleInvoiceIsDefault = service.eleInvoiceIsDefault;
        /* FIX ME */
        //2.5.X第一个小版本修改，第二个大版本启用被注释的
        if (self.eleInvoiceIsDefault) {
            invoiceType = 2;
        }else
            invoiceType = 0;
//        if (self.canUseEleInvoice) {
//            if (self.eleInvoiceIsDefault) {
//                invoiceType = 2;
//            }else
//                invoiceType = 5;
//        }else
//        {
//            invoiceType = 0;
//        }
        
        // 导航到去结算页面
        [self calculateProduct:self.payFlowService.shopCartItemList];
        if (self.shipMode == ShipModeSuningSend) {
            self.addressInfo = self.payFlowService.addressInfoDto;
            if (![self.addressInfo.city isEqualToString:self.currentCityCode]) {
                self.currentCityCode = self.addressInfo.city;
                [self.selectCouponList removeAllObjects];
                self.cloudDiamSwitch.on = NO;
                isCloudDiamUse = NO;
            }
        }else{
            self.storeInfo = self.payFlowService.storeInfoDto;
            if (![self.storeInfo.cityId isEqualToString:self.currentCityCode]) {
                self.currentCityCode = self.storeInfo.cityId;
                [self.selectCouponList removeAllObjects];
                self.cloudDiamSwitch.on = NO;
                isCloudDiamUse = NO;
            }
        }
        
        /* FIX ME */
        //2.5.X第一个小版本修改，第二个大版本启用被注释的
//        [self.payFlowService beginGetDelAndInsTime];
        [self refreshOrderPrice];
        //2.5.X第二个版本不需要reload列表
        [self reloadTableView];
        
        [Config currentConfig].defaultProvince = self.payFlowService.addressInfoDto.province;
        [Config currentConfig].defaultCity = self.payFlowService.addressInfoDto.city;
        [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
    }
    else
    {
        if ([errorCode isEqualToString:@"priceChange"]) {
            if (self.shipMode == ShipModeSuningSend) {
                self.addressInfo = self.payFlowService.addressInfoDto;
            }
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertTips") message:L(@"PFSorryGoodsPriceChange") delegate:self cancelButtonTitle:L(@"AlertBack") otherButtonTitles:L(@"AlertContinueToBuy")];
            [alert setCancelBlock:^{
                [self backForePage];
            }];
            [alert setConfirmBlock:^{
                if (self.shipMode == ShipModeSuningSend) {
                    self.addressInfo = self.payFlowService.addressInfoDto;
                }else{
                    self.storeInfo = self.payFlowService.storeInfoDto;
                }
//                [self didSelectAddress:self.addressInfo];
                [self displayOverFlowActivityView];
                [self.payFlowService beginConfirmDeliveryAddressRequest:self.shipMode addressInfo:self.addressInfo storeInfo:self.storeInfo];
                [self reloadTableView];
            }];
            [alert show];
            isSaveDeliveryOK = NO;
            return;
            
        }
        else if ([errorCode isEqualToString:@"updateAddressFail"])
        {
            isSaveDeliveryOK = NO;
            [self reloadTableView];
            [self presentSheet:service.errorMsg];
            return;
        }
        else if ([errorCode isEqualToString:@"cannotTake"])
        {
            isSaveDeliveryOK = NO;
            self.shipMode = ShipModeSuningSend;
            self.storeInfo = nil;
            [self reloadTableView];
            [self presentSheet:service.errorMsg];
            return;
        }
        else if ([errorCode isEqualToString:@"wrongParams"])
        {
            isSaveDeliveryOK = NO;
            [self reloadTableView];
            [self presentSheet:L(@"PFPleaseSelectDeliveryAddress")];
            return;
        }
        else if ([errorCode isEqualToString:@"cantsale"])
        {
            isSaveDeliveryOK = NO;
            self.storeInfo = nil;
            self.addressInfo = nil;
            [self reloadTableView];
            [self presentSheet:service.errorMsg];
            return;
        }
        else if ([errorCode isEqualToString:@"hasErrCode"])
        {
            isSaveDeliveryOK = NO;
            self.storeInfo = nil;
            self.addressInfo = nil;
            [self reloadTableView];
            [self presentSheet:service.errorMsg];
            return;
        }
        self.storeInfo = nil;
        self.addressInfo = nil;
        isSaveDeliveryOK = NO;
        
        [self reloadTableView];
//        [self presentSheet:service.errorMsg];
    }
    
}

//获取送货时间
- (void)getDelAndTimeCompletionWithResult:(BOOL)isSuccess insendTimeDto:(InsendTimeDTO *)dto errorMsg:(NSString *)errorMsg
{
    if (isSuccess) {
        isGetDelTimeOK      = YES;
        self.insendTimeDto  = dto;
        self.insendList     = dto.defaultMergeList;
        self.insendTimeType = dto.insendTimeType;
        
        for (MergeDataOptionDTO *mergeDto in self.insendList) {
            for (ItemsVoDTO *itemDto in mergeDto.itemsVoList) {
                insendTimeSubmitDTO *insendSubmitDto = [[insendTimeSubmitDTO alloc] init];
                insendSubmitDto.orderitemsId    = itemDto.orderitemsId;
                insendSubmitDto.delInstallDate  = itemDto.defInstallDate;
                insendSubmitDto.delDate         = mergeDto.defDelDate;
                insendSubmitDto.delTime         = [self timeWithStr:mergeDto.defDelTime];
                [self.insendTimeDic setObject:insendSubmitDto forKey:itemDto.orderitemsId];
            }
        }
    }
    else{
        isGetDelTimeOK      = NO;
    }
    [self reloadTableView];
}

//保存券信息
- (void)saveCardAndCouponCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg payDTO:(payFlowDTO *)dto
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [self refreshOrderPrice];
        [self reloadTableView];
    }else{
        [self presentSheet:errorMsg];
    }
}


//确认支付方式
- (void)savePayMethodCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg payDTO:(payFlowDTO *)dto
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        isFirstSavePaymentType = NO;
        [self reloadTableView];
        if (self.isSubmitOrders == YES)
        {
            [self checkSubmitOrder];
        }
    }
    else
    {
        if (self.isSubmitOrders == YES)
        {
            self.submitBtn.enabled = YES;
        }
        isFirstSavePaymentType = YES;
        [self presentSheet:errorMsg];
    }
}

//云钻抵现使用
- (void)getCloudDiamondCompletionWithResult:(BOOL)isSuccess service:(PayFlowService *)service cloudDiamond:(NSString *)cloudDiamond cloudDiamondPay:(NSString *)cloudDiamondPay errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (KPerformance)
        {
            //NSLog(@"%d",[PerformanceStatistics sharePerformanceStatistics].arrayData.count);
            if (([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)&&([PerformanceStatistics sharePerformanceStatistics].arrayData.count < 4))
            {
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:1];
                    temp.endTime = [NSDate date];
                    [[PerformanceStatistics sharePerformanceStatistics] sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                }

            }
           
        }
        if (YES == isFromGetCloudDiamDetail) {
            self.cloudDiamAmt = cloudDiamondPay;
            self.cloudDiamQty = cloudDiamond;
            isFromGetCloudDiamDetail = NO;
            return;
        }
        [self refreshOrderPrice];
        [self reloadTableView];
    }
    else
    {
        if (NO == isFromGetCloudDiamDetail) {
            self.cloudDiamSwitch.on = !self.cloudDiamSwitch.on;
            isCloudDiamUse          = !isCloudDiamUse;
            [self reloadTableView];
            [self presentSheet:errorMsg];
        }
    }
}

- (void)getInstallDateCompletionWithResult:(BOOL)isSuccess installDateArr:(NSArray *)installDateArr errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        for (InstallDateDTO *dto in installDateArr) {
            insendTimeSubmitDTO *submitDto = [self.insendTimeDic objectForKey:dto.orderitemsId];
            submitDto.delInstallDate = dto.defInstallDate;
            submitDto.delDate = self.changeDateStr;
            submitDto.delTime = self.changeTimeStr;
            [self.insendTimeDic setObject:submitDto forKey:dto.orderitemsId];
        }
    }
    else
    {
//        [self presentSheet:errorMsg];
    }
}

#pragma mark - tableview refresh

- (void)reloadTableView
{
    
    [self reloadTableViewData];
    [self checkBtnEnabledOrNot];
    [self.totalPriceView setTotalPrice:self.shouldPayPrice farPrice:self.totalFareStr];
}

- (void)refreshOrderPrice
{
    double price = [self.payFlowService.productAllPrice doubleValue];
    self.totalPriceStr = [NSString stringWithFormat:@"￥%0.2f",price];
    double shouldPay = [self.payFlowService.userPayAllPrice doubleValue];
    self.shouldPayPrice = [NSString stringWithFormat:@"￥%0.2f",shouldPay];
    double fare = [self.payFlowService.totalShipPrice doubleValue];
    self.totalFareStr = [NSString stringWithFormat:@"￥%0.2f",fare];
    double discount = [self.payFlowService.totalDiscount doubleValue];
    if (discount<0) {
        discount=-discount;
    }
    self.totalDiscount = [NSString stringWithFormat:@"￥%0.2f",discount];
    
}


#pragma mark -
#pragma mark ------------ ReceiveInfoShopRemarkCellDelegate Method ------------
- (void)getRemarkWithText:(NSString *)remarkText supplierCode:(NSString *)supplierCode
{
    [self.orderRemarkDic setObject:remarkText forKey:supplierCode];
    
}

- (void)showLimitAlertView
{
    [self presentSheet:L(@"PFMerchantsLeaveMessage")];
}

#pragma mark - ReceiveInsendTimeCellDelegate Method 更改安装时间

- (void)takeSelfAlertShow
{
    [self presentSheet:@"商品送达门店后请您前往下单时选择的自提门店提货，准确送达时间将短信通知您"];
}

- (void)selectSendTimeWith:(NSString *)orderitemsId dateStr:(NSString *)dateStr timeStr:(NSString *)timeStr
{
    self.changeTimeStr = [self timeWithStr:timeStr];
    self.changeDateStr = dateStr;
    [self displayOverFlowActivityView];
    [self.payFlowService beginGetInstallDateWithdeliverTime:dateStr dayTime:self.changeTimeStr orderItemIds:orderitemsId];
}

- (NSString *)timeWithStr:(NSString *)changeTimeStr
{
    NSString *timeStr = @"";
    if ([changeTimeStr isEqualToString:@"09:00-18:00"]) {
        timeStr = @"18:00:00";
    }else if ([changeTimeStr isEqualToString:@"09:00-14:00"])
    {
        timeStr = @"09:00:00";
    }
    else if ([changeTimeStr isEqualToString:@"14:00-18:00"])
    {
        timeStr = @"15:00:00";
    }
    else if ([changeTimeStr isEqualToString:@"18:00-22:00"])
    {
        timeStr = @"20:00:00";
    }
    
    return timeStr;
}

#pragma mark -
#pragma mark Text Fields Delegate Method
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    [self.tpTableView adjustOffsetToIdealIfNeeded];
    [self checkBtnEnabledOrNot];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self checkBtnEnabledOrNot];
    isChangeInvoice = YES;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self checkBtnEnabledOrNot];
    return YES;
}

#pragma mark -
#pragma mark picker button delegate 切换配送方式

- (void)changeShipMode
{
    [self.shipModeSelectView showInSuperView:self.appDelegate.window withShipMode:self.shipMode];
}

- (void)shipModeSelectAction:(ShipMode)shipMode
{
    if (shipMode == ShipModeSelfTake) {
        if (isLastShipInfoLoaded) {
            if (!canTake) {
                [self presentSheet:L(@"PFOnlySupportSuningDelivery")];
                return ;
            }
        }else
        {
            self.shipMode = shipMode;
            [self sendLastShipInfoReqeust];
            return;
        }
    }
    self.shipMode = shipMode;
    [self confirmDeliveryAddress:self.addressInfo storeInfo:self.storeInfo];
    [self reloadTableView];
    
}

- (BOOL)pickerButton:(PickerButton *)button
      canSelectIndex:(NSInteger)index
{
    if (index == 0) {
        return YES;
    }else{
        if (!canTake) {
            [self presentSheet:L(@"PFOnlySupportSuningDelivery")];
            return NO;
        }
        return YES;
    }
}

- (void)pickerButton:(PickerButton *)button
      didSelectIndex:(NSInteger)index
             andItem:(NSString *)item
{
    if (index == 0) {
        self.shipMode = ShipModeSuningSend;
    }else{
        self.shipMode = ShipModeSelfTake;
    }
    [self.view hideTipView];
    
    [self confirmDeliveryAddress:self.addressInfo storeInfo:self.storeInfo];
    [self reloadTableView];
}

#pragma mark -
#pragma mark address change delegate 更改配送地址

- (void)didSelectAddress:(AddressInfoDTO *)address
{
    //    self.addressInfo = address;
    
    [self confirmDeliveryAddress:address storeInfo:nil];
    
    [self reloadTableView];
}

#pragma mark -
#pragma mark store mention delegate 更改门店信息

- (void)didSelectStoreInfo:(StoreInfoDto *)storeInfo
{
    self.storeInfo = storeInfo;
    
    [self confirmDeliveryAddress:nil storeInfo:storeInfo];
    
    [self reloadTableView];
}

- (void)confirmDeliveryAddress:(AddressInfoDTO *)addressInfo storeInfo:(StoreInfoDto *)storeInfo
{
//    if (self.shipMode == ShipModeSuningSend) {
//        if (addressInfo == nil || IsStrEmpty(addressInfo.addressNo)) {
//            return;
//        }
//    }else{
//        if (storeInfo == nil || IsStrEmpty(storeInfo.storeCode)) {
//            return;
//        }
//    }
    [self displayOverFlowActivityView];
    [self.payFlowService beginConfirmDeliveryAddressRequest:self.shipMode addressInfo:addressInfo storeInfo:storeInfo];
}

#pragma mark -
#pragma mark ------------ 是否使用云钻抵现 ------------

- (void)switchAction:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performSwitch) object:nil];
    [self performSelector:@selector(performSwitch) withObject:nil afterDelay:0.5];
}

- (void)performSwitch
{
    if (self.cloudDiamSwitch.on)
    {
        isCloudDiamUse = YES;
    }
    else
    {
        isCloudDiamUse = NO;
    }
    if (isSwitchValueChanged != self.cloudDiamSwitch.on) {
        [self displayOverFlowActivityView];
        isSwitchValueChanged = self.cloudDiamSwitch.on;
        if (isCloudDiamUse) {
            [self.payFlowService beginGetCloudDiamond:@"1"];
        }
        else
        {
            [self.payFlowService beginGetCloudDiamond:@"0"];
        }
    }
}

#pragma mark -
#pragma mark alert view delegate

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kAddCodAddressAlertTag) {
        if (buttonIndex == 1)
        {
            [self reloadTableView];
            AddressNewViewController  *nextController = [[AddressNewViewController alloc] init];
            nextController.delegate = self;
            [self.navigationController pushViewController: nextController animated:YES];
            TT_RELEASE_SAFELY(nextController);
        }
        else
        {
            [self reloadTableView];
        }
        
    }
    else if (alertView.tag == kPaymentFinishAlertTag)
    {
        //清空购物车
        NSNotification *notification=[NSNotification notificationWithName:CART_CLEAN_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self jumpToOrderCenterBoard];
    }else if (alertView.tag == kPayForPointCouponAlertTag && buttonIndex == 1)
    {
        [self checkSubmitOrder];
    }
}

#pragma mark -
#pragma mark custom action methods

//提交订单
- (void)nextHeadler:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1020701"], nil]];
    //校验发票抬头
    NSString *errorMsg = nil;
    if (![PayFlowUtil validateInvoice:self.invoiceStr error:&errorMsg])
    {
        [self presentSheet:errorMsg posY:50];
        return;
    }
    
    if (self.shipMode == ShipModeSuningSend)    //苏宁配送
    {
        //检查配送地址
        if (!_addressInfo) {
            
            [self presentSheet:L(@"PFPleaseSetDeliveryAddress")];
            return;
        }
        
        if ([self.addressInfo isThrowNULLError]) {
            //因城镇切换，导致地址城镇为null的异常
            [self presentSheet: L(@"PFDeliveryAddressContainIllegalCharacters")];
            return;
        }
        
        //        if (![self.addressInfo.city isEqualToString:self.deliveryCityCode] && self.addressInfo.city.length) {
        ////            [self presentSheet: L(@"modifiedSendCity")];
        ////             [self mobileOrderCheckOutASIHTTPRequest];
        //            [self checkCityChange];
        //            return;
        //        }
    }
    else if (self.shipMode == ShipModeSelfTake)     //门店自提
    {
        //当查询门店时，检查门店信息
        if (!self.storeInfo
            || !self.storeInfo.receiptName
            || !self.storeInfo.receiptPhone
            || !self.storeInfo.storeCode)
        {
            [self presentSheet:L(@"PFPleaseSelectStore2")];
            return;
        }
        //        else if (self.storeInfo.cityId.length && ![self.storeInfo.cityId isEqualToString:self.deliveryCityCode]){
        //            [self checkCityChange];
        //            return;
        //        }
    }
    self.submitBtn.enabled = NO;
    [self.payFlowService beginSavePayMethodRequest:self.savePayFlowDto.policyId subPayMethod:self.savePayFlowDto.subCodpolicyId];
    self.isSubmitOrders = YES;
    //    [self checkSubmitOrder];
}

- (void)checkSubmitOrder
{
    [self sendSubmitOrderHttpRequest];//提交订单接口
}

#pragma mark ----------------------------- 检查城市是否更改

- (void)checkCityChange
{
    if ((self.shipMode == ShipModeSuningSend && self.addressInfo.city.length && ![self.addressInfo.city isEqualToString:self.deliveryCityCode]) ||
        (self.shipMode == ShipModeSelfTake && self.storeInfo.cityId.length && ![self.storeInfo.cityId isEqualToString:self.deliveryCityCode]))
    {
        ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.submitBtn.enabled = NO;
        __weak ReceiveInfoViewController *weakSelf = self;
        [self displayOverFlowActivityView];
        NSString *city = self.shipMode==ShipModeSuningSend?self.addressInfo.city:self.storeInfo.cityId;
        NSString *cityName = self.shipMode==ShipModeSuningSend?self.addressInfo.cityContent:self.storeInfo.cityName;
        
        [shopCart reOrderCheckOutWithCity:city cityName:cityName logic:self.buyNowLogic complete:^(BOOL isSuccess, ShopCartV2Service *service, ShopCartLogic *logic) {
            
            ReceiveInfoViewController *self = weakSelf;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            self.submitBtn.enabled = YES;
            [self removeOverFlowActivityView];
            if (isSuccess)
            {
                if ([self.shouldPayPrice doubleValue] != [service.userPayAllPrice doubleValue])
                {
                    [self presentSheet:L(@"PFSwitchCityAndOrderPriceChange")];
                }
                
                self.powerFlag = service.powerFlag;
                //        receiveViewController.productList = service.shopCartItemList;  // 产品列表
                [self calculateProduct:service.shopCartItemList];
                
                NSString *cityCode = nil, *cityName = nil;
                [logic getDeliveryCityCode:&cityCode cityName:&cityName];
                self.deliveryCityCode = cityCode;
                self.deliveryCityName = cityName;
                
                self.isCOrder = service.isCOrder;
                self.isAllCOrder = service.isallCorder;
                [self refreshOrderPrice];
                
                [self reloadTableView];
            }
            else
            {
                [self calculateProduct:logic.checkedShopList];
                NSString *cityCode = nil, *cityName = nil;
                [logic getDeliveryCityCode:&cityCode cityName:&cityName];
                self.deliveryCityCode = cityCode;
                self.deliveryCityName = cityName;
                [self reloadTableView];
                
                ShopCartV2DTO *errorItem = service.errorItem;
                
                if (errorItem)
                {
                    //抢购商品
                    if (errorItem.special == ShopCartSpecialRush &&
                        [errorItem.errorDesc isEqualToString:L(@"PFPanicBuyingQualificationHasExpired")])
                    {
                        [self presentSheet:errorItem.errorDesc];
                    }
                    //单价团商品
                    else if (errorItem.special == ShopCartSpecialSimpleGroup &&
                             [errorItem.errorDesc isEqualToString:L(@"PFGroupPurchaseHasExpired")])
                    {
                        [self presentSheet:errorItem.errorDesc];
                    }
                    else
                    {
                        NSString *errorDesc = [NSString stringWithFormat:L(@"ShopCart_OrderCheck_Product_Error%@%@"),
                                               errorItem.productName, errorItem.errorDesc];
                        [self presentSheet:errorDesc];
                    }
                }
                else
                {
                    NSString *error = service.errorMsg ? service.errorMsg : L(@"System_Abnomal_Try_later");
                    [self presentSheet:error];
                }
            }
        }];
    }
}

- (void)checkBtnEnabledOrNot
{
    if (self.shipMode == ShipModeSuningSend)    //苏宁配送
    {
        //检查配送地址
        if (!self.addressInfo) {
            self.submitBtn.enabled = NO;
        }else{
            self.submitBtn.enabled = YES;
        }
    }
    else if (self.shipMode == ShipModeSelfTake)     //门店自提
    {
        //当查询门店时，检查门店信息
        if (!self.storeInfo
            || !self.storeInfo.receiptName
            || !self.storeInfo.receiptPhone
            || !self.storeInfo.storeCode)
        {
            self.submitBtn.enabled = NO;
        }else
        {
            self.submitBtn.enabled = YES;
        }
    }
    
    if (IsStrEmpty(self.invoiceStr)) {
        self.submitBtn.enabled = NO;
    }else{
        self.submitBtn.enabled = YES;
    }
    
}

- (NSString *)payTypeDesc
{
    switch (self.savePayFlowDto.payMode) {
        case PayModeCard2CashOnDelivery:
            if (self.savePayFlowDto.cashPayMode == CashOnDeliveryPOSPay) {
                return [NSString stringWithFormat:@"%@：%@--%@",L(@"PFPaymentWay"),L(@"PFCashOnDelivery"),L(@"PFPayByCard")];
            }else{
                return [NSString stringWithFormat:@"%@：%@--%@",L(@"PFPaymentWay"),L(@"PFCashOnDelivery"),L(@"PFCash")];
            }
            break;
        case PayModeCard2OnStore:{
            return [NSString stringWithFormat:@"%@：%@",L(@"PFPaymentWay"),L(@"PFStorePayment")];
        }
            break;
        case PayModeCard2OnLine:{
            return [NSString stringWithFormat:@"%@：%@",L(@"PFPaymentWay"),L(@"PFOnlinePayment")];
        }
            break;
        default:
            break;
    }
    return L(@"PFPleaseSelectPaymentWay");
}

#pragma mark - unimplement method in protocol

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc {}
- (void)giftButtonAction:(int)tag {}
- (void)readerView:(ZBarReaderView *)view didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image {}
- (void)recommendButtonAction:(int)tag {}

@end
