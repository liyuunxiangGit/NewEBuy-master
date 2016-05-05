//
//  ProductDetailViewController.m
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductUtil.h"
#import "IWantconsultViewController.h"
#import "DJGroupDetailViewController.h"
#import "DJGroupListItemDTO.h"
#import "PanicPurchaseDTO.h"
#import "SNSwitch.h"
#import "PurchaseDetailViewController.h"
#import "BuyNowCommand.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
#import "SuNingSellDao.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "SNSwitch.h"

#import "SellerListViewController.h"
#import "ShopCartV2ViewController.h"
#import "SNWebViewController.h"

#import "OSGetStatusCommand.h"
#import "OSLeaveMessageViewController.h"

#import "imageScrollView.h"

#import "NProDetailCuCell.h"
#import "ScanHistoryDAO.h"
#import "NearbySpotViewController.h"

#define ZeroSection     0
#define FirstSection    1
#define SecondSection   2
#define ThirdSection    3
#define FourthSection   4
#define FiveSection     5
#define SixSection      6
#define SevenSection    7
#define EightSection    8
#define NineSection     9

//1：即将开始 2：已开始 3：已团完 4：已结束
#define kWillStart @"1"
#define kHaveStart @"2"
#define kNOGood @"3"
#define kHaveEnd @"4"

static NSString *firstviewCellIdetifier = @"NProDetailFirstCell";

@interface ProductDetailViewController ()
{
    NSArray *_dataSourceArray;
    BOOL    isFromScBuy;        //是否是点击的s码购买
    
    BOOL  isSpotSupported;//是否支持附近现货
}

@property (nonatomic, strong) UIImageView       *headBackView;
@property (nonatomic, strong) imageScrollView   *imageScrollView;
@property (nonatomic, strong) NSArray           *recommendListArr;  //推荐商品数组
@property (nonatomic, strong) UIButton          *onlineServiceBtn;  //在线客服按钮
@property (nonatomic, strong) NSString          *badgeChageValueStr;
@end

@implementation ProductDetailViewController

-(void)dealloc{
    
    [CommandManage cancelCommandByClass:[BuyNowCommand class]];
    [CommandManage cancelCommandByClass:[OSGetStatusCommand class]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _appraisalVC.delegate = nil;
    _headBtnsCell.delegate = nil;
    _firstView.delegate = nil;
    _chooseShareWayView.delegate = nil;
    _cuView.mydelegate = nil;
    
    SERVICE_RELEASE_SAFELY(_proDetailService);
    SERVICE_RELEASE_SAFELY(_collectService);
    SERVICE_RELEASE_SAFELY(_myFavorateService);
    SERVICE_RELEASE_SAFELY(_panicService);
    SERVICE_RELEASE_SAFELY(_groupApplyService);
    SERVICE_RELEASE_SAFELY(_groupDeatilService);
    
    [_headBackView removeObserver:self forKeyPath:@"frame"];
    
    [_calculagraph removeObserver:self forKeyPath:@"time"];    
    if (noCalculagraphAtFirst)
    {
        [_calculagraph stop];
        
    }
}

- (void)setCalculagraph:(Calculagraph *)calculagraph
{
    if (_calculagraph != calculagraph) {
        [_calculagraph removeObserver:self forKeyPath:@"time"];
        _calculagraph = calculagraph;
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        chatServiceStatus = OSShowStatusNone; //默认不展示
        self.isLoadDetail = NO;
        isFromScBuy = NO;
        isSpotSupported = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpPageTitles
{
    //商品信息收集
    NSString *pageName = nil;
    
    if (self.type == GroupProduct)
    {
        pageName = [NSString stringWithFormat:@"%@-%@",L(@"Product_Cuxiao_Tuan"),self.productBase.productCode];
    }
    else if (self.type == PurchuseProduct)
    {
        pageName = [NSString stringWithFormat:@"%@-%@",L(@"Product_Cuxiao_Qiang"),self.productBase.productCode];
    }
    else
    {
        if (self.productBase.isCShop)
        {
            pageName = [NSString stringWithFormat:@"%@-%@_%@",L(@"Product_Display_CShop"),self.productBase.productCode,self.productBase.shopCode];
        }
        else
        {
            pageName = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.productBase.productCode];
        }
    }
    
    if(([self.pageTitle length] == 0)||![pageName isEqualToString:self.pageTitle])
    {
         [SSAIOSSNDataCollection multiPagesInCollection:pageName];
    }
   
    self.pageTitle = pageName;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (KPerformance)
//    {
//        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
//        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = nil;
//        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
//    }
    [self.cuView removeFromSuperview];
    [self.imageScrollView removeFromSuperview];
    
}

-(id)initWithDataBasicDTO:(DataProductBasic *)infoDto
{
    self = [super init];
    
    if(self)
    {
        self.title = L(@"Product Details");
        if (![daoPageTitle length])
        {
            if ([erWeiMaPageTitle length])
            {//二维码的商铺
                sourceTitle = L(@"SNRouteSwitch_QRCode");
                if ([sourcePageTitle length])
                {
                    NSRange range = [sourcePageTitle rangeOfString:@"_" options:NSCaseInsensitiveSearch];
                    if ((range.location != NSNotFound)&&([sourcePageTitle length]))
                    {
                        daoPageTitle = [sourcePageTitle substringToIndex:range.location];
                        daoPageTitle = [NSString stringWithFormat:@"%@-%@",daoPageTitle,erWeiMaPageTitle];
                    }
                    else if([sourceTitle length])
                    {
                        daoPageTitle = [NSString stringWithFormat:@"%@-%@",erWeiMaPageTitle,sourcePageTitle];
                    }
                }
            }
            else if([erWeiMaDanPageTitle length])
            {//二维码的单品
                //sourceTitle = @"二维码";
                //daoPageTitle = [NSString stringWithFormat:@"%@",erWeiMaDanPageTitle];
                //erWeiMaDanPageTitle = nil;
            }
            else
            {
                if([remotePageTitle length])
                {//推送页面路由
                    sourceTitle = L(@"Product_Push");
                    remotePageTitle = nil;
                }
                //其他的都是dm和活动
                if ([sourcePageTitle length])
                {
                    NSRange range = [sourcePageTitle rangeOfString:@"_" options:NSBackwardsSearch];
                    if ((range.location != NSNotFound)&&([sourcePageTitle length]))
                    {
                        daoPageTitle = [[sourcePageTitle substringFromIndex:range.location+1]trim];
                    }
                    else if([sourcePageTitle length])
                    {
                        if (![erWeiMaPageTitle length])
                        {
                            daoPageTitle = [NSString stringWithFormat:@"%@",[sourcePageTitle trim]];
                        }
                        DLog(@"-------daoPageTitle:%@",daoPageTitle);
                    }

                }
               
            }
        }
        self.productBase = infoDto;//商品初始数据
        
        //修改城市的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(defaultCityDidChange)
                                                     name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshCarNumBtn:) name:@"changeProductDetailCarNum"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(purchaseStateDidChange:)
                                                     name:@"PanicPurchaseStateDidChangeNotification"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appointmentStateDidChange:)
                                                     name:@"AppointmentStateDidChangeNotification"
                                                   object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(commitconsultation) name:CONSULTATION
//                                                   object:nil];

        self.hidesBottomBarWhenPushed = YES;
        self.isAllLoaded = NO;
        
        chatServiceStatus = OSShowStatusNone; //默认不展示
    }
    
    return self;
}

//刷新城市 接收通知
- (void)defaultCityDidChange
{
    self.bottomNavBar.hidden = YES;

    if ((![self.productBase.cityCode isEqualToString:[Config currentConfig].defaultCity])||(![self.productBase.xsection isEqualToString:[Config currentConfig].defaultSection])) {
        
        self.productBase.cityCode = [Config currentConfig].defaultCity;
        
        self.productBase.xsection = [Config currentConfig].defaultSection;
        
        [self refreshData];
    }
}

-(void)keyboardWillShow{
    
    if (![self.cuView.numberTF isFirstResponder]) {
        
        return;
    }
    
    self.cuTableSize = self.cuView.productTable.frame.size;
    
    CGRect frame = self.cuView.productTable.frame;
    
    
    float frameHeight =  [[UIScreen mainScreen] bounds].size.height;
    frame.size.height = frameHeight - 133-75-216;
    
    self.cuView.productTable.frame = frame;
    
    self.cuView.productTable.scrollEnabled = NO;
    if (0 != [self.productBase.colorItemList count] &&
        0 != [self.productBase.versionItemList count]) {
        [self.cuView.productTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]
                                        atScrollPosition:UITableViewScrollPositionTop
                                                animated:NO];
    }
}
-(void)keyboardWillHide{
    
    if (![self.cuView.numberTF isFirstResponder]) {
        
        return;
    }
    
    CGRect frame = self.cuView.productTable.frame;
    
    frame.size = self.cuTableSize;
    
    self.cuView.productTable.frame = frame;
    
    self.cuView.productTable.scrollEnabled = YES;
    
    [self.cuView scrollTotop];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if((![daoPageTitle length])&&([erWeiMaDanPageTitle length]))
    {//二维码的单品
        sourceTitle = L(@"SNRouteSwitch_QRCode");
        daoPageTitle = [NSString stringWithFormat:@"%@_展示-商品详情-%@",erWeiMaDanPageTitle,self.productBase.productCode];
        erWeiMaDanPageTitle = nil;
    }
    else if(![daoPageTitle length])
    {
        if([remotePageTitle length])
        {//推送页面路由
            sourceTitle = L(@"Product_Push");
            remotePageTitle = nil;
        }
        //其他的都是dm和活动
        if ([sourcePageTitle length])
        {
            NSRange range = [sourcePageTitle rangeOfString:@"_" options:NSBackwardsSearch];
            if ((range.location != NSNotFound)&&([sourcePageTitle length]))
            {
                daoPageTitle = [[sourcePageTitle substringFromIndex:range.location+1]trim];
            }
            else if([sourcePageTitle length])
            {
                if (![erWeiMaPageTitle length])
                {
                    daoPageTitle = [NSString stringWithFormat:@"%@",[sourcePageTitle trim]];
                }
                DLog(@"-------daoPageTitle:%@",daoPageTitle);
            }
        }

    }
    if (KPerformance)
    {
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = [NSDate date];
    }
//    [self refreshTableView];
    if(!self.isLoadDetail)
    {
        [self refreshData];
        
    }
    [self refreshBtn];

    if (self.isShowingCuView)
    {
        self.cuView.productDto = self.productBase;
        
        [self.cuView showCuView];
        
        [self.navigationController.view addSubview:self.cuView];
    }
    else
    {
        [self.cuView removeFromSuperview];
    }
    
}
//刷新底部购物车数量按钮
- (void)refreshCarNumBtn:(NSNotification *)notification
{
    NSString *badgeValue = [[notification userInfo] objectForKey:@"badgeValueChaged"];
    self.badgeChageValueStr = badgeValue;
    if([badgeValue integerValue] > 0)
    {
        [self refreshButtomView:YES];
        
    }
    else
    {
        [self refreshButtomView:NO];
        
    }
    
}
- (void)refreshData
{
    [self displayOverFlowActivityView];

    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.addCarBtn.hidden = YES;
    self.buyNowBtn.hidden = YES;
    self.CarBtn.hidden = YES;
    self.CarNumBtn.hidden = YES;
    self.isAllLoaded = NO;
    if(KPerformance)
    {
        PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
        temp.startTime = [NSDate date];
        temp.functionId = @"3";
        temp.interfaceId = @"302";
        temp.taskId = @"1003";
        [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
    }
    [self.proDetailService beginGetProductDetailInfo:self.productBase];
    
    if ([UserCenter defaultCenter].isLogined) {
        if(KPerformance)
        {
            PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"3";
            temp.interfaceId = @"301";
            temp.taskId = @"1003";
            [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
        }
        [self.collectService sendDetailCollectService:self.productBase];
    }
}

- (void)reloadTableViewData
{
//    [self.tableView reloadData];
    [self reloadTableView];
    [self refreshBtn];
}


- (NProDetailSixCell*)headBtnsCell
{
    if(!_headBtnsCell)
    {
        _headBtnsCell = [[NProDetailSixCell alloc] init];
        
        _headBtnsCell.delegate = self;
        
        _headBtnsCell.backgroundColor = [UIColor clearColor];
    }
    
    return _headBtnsCell;
}

- (NProDetailLastViewController*)lastTabView
{
    if(!_lastTabView)
    {
        _lastTabView = [[NProDetailLastViewController alloc] init];
        
        _lastTabView.view.backgroundColor = RGBCOLOR(242, 242, 242);
        
        _lastTabView.type = self.type;
        
        _lastTabView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //[_lastTabView hideScrollViewHead];
        [_lastTabView.view addSubview:self.lastTabView.backScrollView];
//        _lastTabView.backScrollView.contentSize = CGSizeMake(320 * 3, self.lastTabView.view.size.height);
    }
    
    return _lastTabView;
}

- (void)loadView
{
    [super loadView];
    
    self.hasNav = YES;
    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = YES;
    self.bottomNavBar.hidden = YES;
    self.bottomNavBar.top = self.view.bounds.size.height + self.view.bounds.origin.y;
 
    [self.bottomNavBar addSubview:self.buyNowBtn];
    [self.bottomNavBar addSubview:self.addCarBtn];
    
    self.type = NormalProduct;
    
    _isFold = NO;
    
    _isProductCuView = NO;
    _isProductCuViewShow = NO;
    
//    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat initPicHeight = 164 + 40 + 40;
    CGFloat picViewHeight = self.view.frame.size.width;
    //商品图片展示
    //    self.firstView.frame = CGRectMake(0, (164 - self.view.frame.size.width)/2, self.view.frame.size.width, self.view.frame.size.width);
    self.firstView.frame = CGRectMake(0, (initPicHeight-picViewHeight)/2, picViewHeight, picViewHeight);
    
    [self refreshFirstProImagesView];
    
    //商品其他信息展示
    self.tpTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    //    self.tableView.backgroundView = self.firstView;
    
    self.tpTableView.backgroundColor = [UIColor clearColor];
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.tableView.sectionFooterHeight = 7.5;
//    self.tableView.sectionHeaderHeight = 7.5;
    self.tableView = self.tpTableView;
    [self.view addSubview:self.tableView];
    
    [self refreshButtomView:NO];
    
//    UIView *bgView = [[UIView alloc] initWithFrame:self.tableView.bounds];
//    self.tableView.backgroundView = bgView;
//    [bgView addSubview:self.firstView];
//    NSLog(@"%f",self.view.bounds.size.height);
//    self.buttomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 110, 320, 55);
    //默认选择基本信息
    //    [self.headBtnsCell btnChangeTabAction:self.headBtnsCell.baseInfoBtn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"productDetail_wifi_share.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"productDetail_wifi_share_clicked.png"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 44, 44);
    if (IOS7_OR_LATER) {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }else{
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView) {
        _chooseShareWayView = [[ChooseShareWayView alloc] init];
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}

- (void)righBarClick
{
    [self share];
}

//点击分享
- (void)share
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121404"], nil]];
    
    @weakify(self);
    SNImageLoadImage(self.productBase.productImageURL, ^(UIImage *img) {
        
        @strongify(self);
        [self.shareKit shareWithContent:[self getShareMessage] image:img
                        productImageURL:self.productBase.productImageURL];
        [self.shareKit setShareTitle:[self getProductTitle]];
        [self.shareKit setShareUrl:[self getProductUrl]];
        
        [self.shareKit shareWithProductDto:self.productBase];
        
        [self.chooseShareWayView showChooseShareWayView];
    });
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}
#pragma mark -
#pragma mark 分享数据的获取
- (NSString *)getProductUrl
{
    return [ProductUtil mobileWebSuningUrlWithProduct:self.productBase].absoluteString;
}

- (NSString *)getProductTitle{
    
    NSString *title = L(@"eBuy");
    if (NotNilAndNull(self.productBase.productName)) {
        title = self.productBase.productName;
    }
    return title;
}
//组合分享文本信息
- (NSString *)getShareMessage{
    
    NSString *url = [self getProductUrl];
    
    int count = 7+[self.productBase.productName length]+10+[url length]+10+5;
    
    DLog("%d", count);
    
    if (count > 140)
    {
        NSString *content = [NSString stringWithFormat:@"%@%@%@",
                             self.productBase.productName,
                             url,
                             L(@"Product_FromSuning")];
        return content;
    }
    else
    {
        NSString *content = [NSString stringWithFormat:@"%@\"%@\"%@%@%@",
                             L(@"Product_SuningSell"),
                             self.productBase.productName,
                             L(@"Product_Bucuo"),
                             url,
                             L(@"Product_FromSuning")];
        return content;
    }
    
}

//获取分享图片
- (UIImage *)getShareImage
{
    @weakify(self);
    SNImageLoadImage(self.productBase.productImageURL, ^(UIImage *image) {
        
        @strongify(self);
        if (image) self.navigationItem.rightBarButtonItem.enabled = YES;
    });
    return nil;
}

- (void)imageLoaderDidLoad:(NSNotification *)notification
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}

- (ProductTimeView *)timView
{
    if (!_timView) {
        _timView = [[ProductTimeView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    }
    return _timView;
}

- (BigSaleDTO *)bigsaleDto
{
    if (!_bigsaleDto) {
        _bigsaleDto = [[BigSaleDTO alloc] init];
    }
    return _bigsaleDto;
}

- (DataProductBasic*)productBase
{
    if(!_productBase)
    {
        _productBase = [[DataProductBasic alloc] init];
    }
    
    return _productBase;
    
}

- (ProductDetailService*)proDetailService
{
    if(!_proDetailService)
    {
        _proDetailService = [[ProductDetailService alloc] init];
        
        _proDetailService.delegate = self;
    }
    
    return _proDetailService;
}

- (DetailCollectService *)collectService
{
    if (!_collectService) {
        _collectService = [[DetailCollectService alloc] init];
        _collectService.delegate = self;
    }
    return _collectService;
}

- (MyFavoriteService *)myFavorateService{
    if (!_myFavorateService) {
        _myFavorateService = [[MyFavoriteService alloc] init];
        _myFavorateService.delegate = self;
    }
    return _myFavorateService;
}

- (PurchaseService *)panicService
{
    if (!_panicService) {
        _panicService = [[PurchaseService alloc] init];
        _panicService.delegate = self;
        _panicService.panicChannel = self.panicChannel;
    }
    return _panicService;
}

- (DJGroupApplyService *)groupApplyService
{
    if (!_groupApplyService) {
        _groupApplyService = [[DJGroupApplyService alloc] init];
        _groupApplyService.delegate = self;
    }
    return _groupApplyService;
}

- (DJGroupDetailService *)groupDeatilService
{
    if (!_groupDeatilService) {
        _groupDeatilService = [[DJGroupDetailService alloc] init];
        _groupDeatilService.delegate = self;
    }
    return _groupDeatilService;
}

- (DJGroupDetailDTO *)detailDto
{
    if (!_detailDto) {
        _detailDto = [[DJGroupDetailDTO alloc] init];
    }
    return _detailDto;
}
//检查是否登录，如果未登录则弹出登录界面
- (BOOL)checkLogin
{
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginDelegate = self;
        loginVC.loginDidOkSelector = loginSel;
        AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
}

//跳转分享
- (void)gotoShare
{
    [self share];
}

//加入收藏
- (void)addToFavorite
{
    NSString* str1 = [NSString stringWithFormat:@"%@",@"3"];
    NSString* str2 = [NSString stringWithFormat:@"%@",self.productBase.productCode];
    [SSAIOSSNDataCollection CustomEventCollection:@"productclick" keyArray: [NSArray arrayWithObjects:@"clickway",@"productid", nil]valueArray:[NSArray arrayWithObjects:str1,str2, nil]];
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121316"], nil]];
    loginSel = @selector(addToFavoriteLoginSuccess);
    if ([self checkLogin]) {
        
        if ([self.collectFlag isEqualToString:@"1"]) {
            self.productBase.vendorCode = self.productBase.shopCode;
            [self.myFavorateService beginDeleteMyFavoriteList:self.productBase];
        }else{
            [self.proDetailService beginAddToFavorite:self.productBase];
        }
        
    }
    
}
- (void)addToFavoriteFromlogin{
    
    [self.collectService sendDetailCollectService:self.productBase];
    
    //    self.collectService.OnlyGetCollect = YES;
}
//登录完成
- (void)addToFavoriteLoginSuccess
{
    [self addToFavorite];
}

- (imageScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        _imageScrollView = [[imageScrollView alloc] init];
        _imageScrollView.frame = self.navigationController.view.bounds;
        
    }
    return _imageScrollView;
}

-(UIImageView *)buttomView{
    
    if (!_buttomView) {
        
        _buttomView = [[UIImageView alloc] init];
        
        _buttomView.userInteractionEnabled = YES;
        
        _buttomView.backgroundColor = [UIColor clearColor];
        
        _buttomView.image = [UIImage imageNamed:@"DJ_Detail_GroupBtnBack.png"];
        
        _buttomView.frame = CGRectMake(0, self.view.bounds.size.height - 92, 320, 55);
        
//        [self.view addSubview:_buttomView];
        [_buttomView addSubview:self.buyNowBtn];
        [_buttomView addSubview:self.addCarBtn];
    }
    
    return _buttomView;
}

- (UIButton *)onlineServiceBtn
{
    if (!_onlineServiceBtn) {
        _onlineServiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(320, 100, 46, 110)];
        [_onlineServiceBtn setImage:[UIImage imageNamed:@"ProductDetail_onlineServer.png"] forState:UIControlStateNormal];
//        _onlineServiceBtn.hidden = YES;
        [self.onlineServiceBtn addTarget:self action:@selector(OnlineServiceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _onlineServiceBtn;
}

- (UIButton*)buyNowBtn
{
    if(!_buyNowBtn)
    {
        _buyNowBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 7, 120, 35)];
        [_buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        
        _buyNowBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [_buyNowBtn addTarget:self action:@selector(beginEasyBuy) forControlEvents:UIControlEventTouchUpInside];
        
        [_buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [_buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_touched.png"] forState:UIControlStateHighlighted];
        
        [_buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
//        [_buyNowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_buyNowBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        
        [_buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _buyNowBtn.enabled = YES;
        
        
    }
    
    return _buyNowBtn;
}

- (UIButton*)addCarBtn
{
    if(!_addCarBtn)
    {
        
        _addCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(185, 7, 120, 35)];
        
        [_addCarBtn setTitle:L(@"Add shopCart") forState:UIControlStateNormal];
        
        _addCarBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [_addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_addCarBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        
        [_addCarBtn addTarget:self action:@selector(addToCar) forControlEvents:UIControlEventTouchUpInside];
        
        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"button_orange_normal.png"] forState:UIControlStateNormal];
        
        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"button_orange_click.png"] forState:UIControlStateHighlighted];
        
//        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"N_GrayActivity.png"] forState:UIControlStateHighlighted];
        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        _addCarBtn.enabled = YES;
    }
    
    return _addCarBtn;
}

- (UIButton*)CarNumBtn
{
    if(!_CarNumBtn)
    {
        
        _CarNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(23, -7, 14, 14)];
        
        [_CarNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_CarNumBtn setBackgroundImage:[UIImage streImageNamed:@"productDetail_carNumber.png"] forState:UIControlStateNormal];
        
        [_CarNumBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [_CarNumBtn addTarget:self action:@selector(GoToCar) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _CarNumBtn;
}

- (UIButton*)CarBtn
{
    if(!_CarBtn)
    {
        
        _CarBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 41.5, 43.5)];
        
        [_CarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_CarBtn addTarget:self action:@selector(GoToCar) forControlEvents:UIControlEventTouchUpInside];
        
        [_CarBtn setImage:[UIImage imageNamed:@"icon_shopCart244_default.png"] forState:UIControlStateNormal];
        
    }
    
    return _CarBtn;
}

- (void)GoToCar
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121313"], nil]];
    ShopCartV2ViewController *vc = [[ShopCartV2ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isNeedBackItem = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
//    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
}

//是否显示购物车数量按钮
-(void)refreshButtomView:(BOOL)showCarNum{
    
    if (showCarNum) {
        NSString *num = [NSString stringWithFormat:@"%i", [ShopCartV2ViewController sharedShopCart].logic.allProductQuantity];
        if (!IsStrEmpty(self.badgeChageValueStr)) {
            num = self.badgeChageValueStr;
        }
        //设置购物车数量显示图片自适应大小
        CGRect rect = self.CarNumBtn.frame;
        
        if ([num intValue]>99) {
            num = [NSString stringWithFormat:@"99+"];
            self.CarNumBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            rect.size.width = 22;
        }
        else
        {
            self.CarNumBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            rect.size.width = 17;
        }
        rect.size.height = 17;
        rect.origin.x = 34 - rect.size.width/2;
        rect.origin.y = 2;

        if (self.type == NormalProduct) {
            self.buyNowBtn.frame = CGRectMake(10, 7, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 7, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 5, 44, 44);
        }
        else if (self.type == BigSaleProduct && self.isLoadBigSale)
        {
            self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.isLoadPurchase || self.isLoadGroup)
        {
            self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
//            rect.origin.y = 2;
        }
        else if (self.type == ScScodeProduct)
        {
            self.addCarBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.isLoadAppointment)
        {
            if (self.isScProduct) {
                if (self.appointmentDto.scScodeStatus == OnBuy) {
                    self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
                    self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
                else
                {
                    self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
            }else
            {
                self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
            }
        }
        
        self.CarNumBtn.frame = rect;
        
        [self.CarNumBtn setTitle:[NSString stringWithFormat:@"%@",num] forState:UIControlStateNormal];
        
        [self.bottomNavBar addSubview:self.addCarBtn];
        [self.bottomNavBar addSubview:self.buyNowBtn];
        [self.bottomNavBar addSubview:self.CarBtn];
        [self.CarBtn addSubview:self.CarNumBtn];
        
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
    }
    else{
        [self.bottomNavBar addSubview:self.addCarBtn];
        [self.bottomNavBar addSubview:self.buyNowBtn];
        [self.bottomNavBar addSubview:self.CarBtn];
        
//        self.buyNowBtn.hidden = NO;
//        self.addCarBtn.hidden = NO;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = YES;
        
        if (self.type == NormalProduct) {
            self.buyNowBtn.frame = CGRectMake(10, 7, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 7, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 3, 44, 44);
        }
        else if (self.type == BigSaleProduct && self.isLoadBigSale)
        {
            self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.type == ScScodeProduct)
        {
            self.addCarBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.isLoadGroup || self.isLoadPurchase)
        {
            self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.isLoadAppointment)
        {
            if (self.isScProduct) {
                if (self.appointmentDto.scScodeStatus == OnBuy) {
                    self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
                    self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
                else
                {
                    self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
            }else
            {
                self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
            }
        }
        
    }
    
}


-(ProductCuView *)cuView
{
    if (!_cuView) {
        
        _cuView = [[ProductCuView alloc] init];
        
        _cuView.frame = self.navigationController.view.bounds;
        
        _cuView.mydelegate = self;
        
    }
    return _cuView;
}

- (EGOImageButton*)imageViewBtn
{
    if(!_imageViewBtn)
    {
        _imageViewBtn = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        _imageViewBtn.backgroundColor = [UIColor clearColor];
        
    }
    
    return _imageViewBtn;
}

- (void)getFisrtImage:(void(^)(UIImage *image))block
{    
    NSURL *imageUrl = nil;
    
    if(self.productBase.isABook == YES)
    {
        
        imageUrl = [ProductUtil getImageUrlWithProductCode:self.productBase.productCode size:ProductImageSize400x400];
        
    }
    else
    {
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            //清晰
            
            imageUrl = [ProductUtil getImageUrlWithProductCode:self.productBase.productCode size:ProductImageSize800x800];
        }
        else{
            //一般
            
            imageUrl = [ProductUtil getImageUrlWithProductCode:self.productBase.productCode size:ProductImageSize400x400];
            
        }
    }
    
    UIImage *defaultImage = self.imageViewBtn.placeholderImage;
    SNImageLoadImage(imageUrl, ^(UIImage *image) {
        
        if (block) {
            block(image?image:defaultImage);
        }
    });
    
//    UIImage *image = [[EGOImageLoader sharedImageLoader] imageForURL:imageUrl shouldLoadWithObserver:nil];
//    
//    image = image?image:self.imageViewBtn.placeholderImage;
//    return image;
}

- (void)addToCarAnimation:(UIImage *)image
{
    //商品加入购物车动画效果
    
    //获取小图url列表
//    NSArray *imageArr = [[NSArray alloc] init];
//    
//    if(self.productBase.isABook == YES)
//    {
//        
//        imageArr = [ProductUtil getImageUrlListWithProduct:self.productBase size:ProductImageSize400x400];
//        
//    }
//    else
//    {
//        
//        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
//            //清晰
//            
//            imageArr = [ProductUtil getImageUrlListWithProduct:self.productBase size:ProductImageSize800x800];
//        }
//        else{
//            //一般
//            
//            imageArr = [ProductUtil getImageUrlListWithProduct:self.productBase size:ProductImageSize400x400];
//            
//        }
//    }
    
    
    
    self.imageViewBtn.hidden = NO;
    
//    self.imageViewBtn.imageURL = [imageArr objectAtIndex:0];
    self.imageViewBtn.imageView.image = image;
    
    transitionLayer = [[CALayer alloc] init];
    transitionLayer.bounds = CGRectMake(0, 0, 320, 320);
    transitionLayer.position = CGPointMake(160, 160);
    transitionLayer.contents = (id)_imageViewBtn.imageView.image.CGImage;
    // Add layer as a sublayer of the UIView's layer
    [self.view.layer addSublayer:transitionLayer];
   
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    
    /*    //画二元曲线，一般和moveToPoint配合使用
     - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
     参数：endPoint:曲线的终点
     controlPoint:画曲线的基准点*/
    
    [movePath addQuadCurveToPoint:CGPointMake(319, [UIScreen mainScreen].bounds.size.height - 45 - 20)
                     controlPoint:CGPointMake(0,0)];
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	scaleAnimation.toValue = [NSNumber numberWithFloat:0.025];
	scaleAnimation.duration = 0.8f;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.repeatCount = 1;
    //防止动画闪烁
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 0.8f;
	animationGroup.autoreverses = NO;
	animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
	[animationGroup setAnimations:[NSArray arrayWithObjects:positionAnimation,scaleAnimation, nil]];
    
    [transitionLayer addAnimation:animationGroup forKey:nil];
    
//    if(self.isShowingCuView == YES)
//    {
//        [self performSelector:@selector(cuViewAddCarFinished:) withObject:transitionLayer afterDelay:1.0f];
//        
//    }
//    else
//    {
        [self performSelector:@selector(addCarFinished:) withObject:transitionLayer afterDelay:0.8f];
        
//    }
    
}

- (void)cuViewAddCarFinished:(id)sender
{

//    self.cuView.CarBtn.enabled = NO;
//    self.cuView.buyNowBtn.enabled = NO;
//    self.cuView.addCarBtn.enabled = NO;
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        
        self.addCarBtn.enabled = YES;
        self.cuView.addCarBtn.enabled = YES;
        self.CarBtn.enabled = YES;
        self.buyNowBtn.enabled = YES;
        self.cuView.buyNowBtn.enabled = YES;
        self.cuView.CarBtn.enabled = YES;
        
        if (isSuccess) {
            [self.cuView hideCuView];
            [self presentSheet:L(@"Product_SuccessAddToCart")];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCuViewProductDetailCarNum" object:nil];

            //[self playAnmationAndSoundForSuckEffect];
            //                BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:@"加入购物车成功" delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:@"去购物车"];
            //                [alert show];
            //                [alert setConfirmBlock:^{
            //
            //                    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
            //                    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            //                }];
            //                [alert setCancelBlock:^{
            //
            //                    [self.cuView hideCuView];
            //
            //                    //                    [self addToCarAnimation:self.addCarBtn];
            //
            //                }];
            
        }else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    [self.shoppingCartBoard addProductToShoppingCart:self.productBase
                                     completionBlock:block];
    
    

}

- (void)addCarFinished:(id)sender
{
    
    self.imageViewBtn.hidden = YES;
    [transitionLayer removeFromSuperlayer];
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        self.addCarBtn.enabled = YES;
        self.cuView.addCarBtn.enabled = YES;
        self.CarBtn.enabled = YES;
        self.buyNowBtn.enabled = YES;
        
        if (isSuccess) {
            [self presentSheet:L(@"Product_SuccessAddToCart")];
            //[self playAnmationAndSoundForSuckEffect];
//            BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:@"加入购物车成功" delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:@"去购物车"];
//            [alert show];
//            [alert setConfirmBlock:^{
//                
//                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
//                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
//            }];
//            [alert setCancelBlock:^{
//                
//                //                [self.cuView hideCuView];
//                //
//                //                [self addToCarAnimation:self.CarBtn];
//                
//            }];
        }else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    
    [self.shoppingCartBoard addProductToShoppingCart:self.productBase
                                     completionBlock:block];
    
    
}

-(void)goToNextView:(NSInteger)carTypr{
    
    if (1 == carTypr) {
        
        [self checkLoginWithLoginedBlock:^{
            if ([self isProductEnabled])
            {
                BuyNowCommand *command = [BuyNowCommand command];
                command.product = self.productBase;
                command.sController = self;
                
                [self.cuView showHUDIndicatorViewAtCenter:L(@"Loading...")];
                [CommandManage excuteCommand:command completeBlock:^(id<Command> command){
                    
                    [self.cuView hideHUDIndicatorViewAtCenter];
                }];
            }
        } loginCancelBlock:NULL];
        
        return;
        
    }
    
    if (![self isProductEnabled])
    {
        return;
    }
    
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    self.CarBtn.enabled = NO;
    
    self.addCarBtn.enabled = NO;
    self.buyNowBtn.enabled = NO;
    
    [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateDisabled];
    
    if(self.isShowingCuView == YES)
    {
        self.cuView.CarBtn.enabled = NO;
        self.cuView.buyNowBtn.enabled = NO;
        self.cuView.addCarBtn.enabled = NO;
        
        [self.cuView.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateDisabled];

        [self getFisrtImage:^(UIImage *image) {
            
            [self.cuView displayAnimation:image.CGImage];
        }];
    }
    else
    {
        [self getFisrtImage:^(UIImage *image) {
            [self addToCarAnimation:image];
//            [self.cuView displayAnimation:image.CGImage];
        }];
        
    }
}

#pragma mark -
#pragma mark btn actions
- (void)beginEasyBuy
{
    NSString* str1 = [NSString stringWithFormat:@"%@",@"1"];
    NSString* str2 = [NSString stringWithFormat:@"%@",self.productBase.productCode];
    [SSAIOSSNDataCollection CustomEventCollection:@"productclick" keyArray: [NSArray arrayWithObjects:@"clickway",@"productid", nil]valueArray:[NSArray arrayWithObjects:str1,str2,nil]];
    if (NormalProduct == self.type) {
        if (0 == [self.productBase.colorItemList count] &&
            0 == [self.productBase.versionItemList count] &&
            0 == [self.productBase.smallPackageList count] &&
            0 == [self.productBase.allAccessoryProductList count])
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121311"], nil]];
            [self goToNextView:1];
        }
        else
        {
            if (_isProductCuViewShow == YES) {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121311"], nil]];
                [self goToNextView:1];
            }else
            {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121602"], nil]];
                [self selectColorOrSizeOrNum:1];
            }
        }
    }
    else if (PurchuseProduct == self.type)
    {
         [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121314"], nil]];
        [self checkLoginWithLoginedBlock:^{
            [self joinPanicPurchase];
        } loginCancelBlock:NULL];
        
    }
    else if (GroupProduct == self.type)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121315"], nil]];
        [self checkLoginWithLoginedBlock:^{
            [self joinGroup];
        } loginCancelBlock:NULL];
        
    }
    else if (BigSaleProduct == self.type)
    {
        [self goToNextView:1];
    }
    else if (AppointmentProduct == self.type)
    {
        [self checkLoginWithLoginedBlock:^{
            [self appointmentAction];
        } loginCancelBlock:NULL];
    }
    
}

-(void)addToCar2{
    
    if ([self isProductEnabled] && [self checkLogin])
    {
        BuyNowCommand *command = [BuyNowCommand command];
        command.product = self.productBase;
        command.sController = self;
        [CommandManage excuteCommand:command completeBlock:nil];
    }
}

-(void)addToCar{
    NSString* str1 = [NSString stringWithFormat:@"%@",@"2"];
    NSString* str2 = [NSString stringWithFormat:@"%@",self.productBase.productCode];
    [SSAIOSSNDataCollection CustomEventCollection:@"productclick" keyArray: [NSArray arrayWithObjects:@"clickway",@"productid", nil]valueArray:[NSArray arrayWithObjects:str1,str2, nil]];
    __gIsProduceCode = [NSString stringWithFormat:@"%@",self.productBase.productCode];
    if (self.type == NormalProduct) {
        if (0 == [self.productBase.colorItemList count] &&
            0 == [self.productBase.versionItemList count] &&
            0 == [self.productBase.smallPackageList count] &&
            0 == [self.productBase.allAccessoryProductList count])
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121312"], nil]];
            [self goToNextView:2];
        }
        else
        {
            if (_isProductCuViewShow == YES)
            {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121312"], nil]];
                [self goToNextView:2];
            }
            else
            {
                [self selectColorOrSizeOrNum:2];
            }
        }
    }
    else if (self.type == AppointmentProduct || self.type == ScScodeProduct)
    {
        if (self.productBase.quantity != 1) {
            [self presentSheet:L(@"Product_SCodeOnlyOne")];
            return;
        }
        isFromScBuy = YES;
        [self checkLoginWithLoginedBlock:^{
            [self scScodeProductBuy];
        } loginCancelBlock:NULL];
    }
    else
    {
        [self addToShopCart];
        
    }
    
}

- (void)addToShopCart
{
    [self checkLoginWithLoginedBlock:^{
        [self goToNextView:2];
    } loginCancelBlock:NULL];
}

- (NProDetailFirstCell*)firstView
{
    if(!_firstView)
    {
        _firstView = [[NProDetailFirstCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:firstviewCellIdetifier];
        
        _firstView.delegate = self;
        
        _firstView.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _firstView.proImagesScroll.touchImagesDelegate = self;
        
        [_firstView setNProDetailFirstCell:self.productBase WithCollectFlag:self.collectFlag WithType:self.type];
        
    }
    
    return _firstView;
}

- (void)refreshFirstProImagesView
{
    [self.firstView setNProDetailFirstCell:self.productBase WithCollectFlag:self.collectFlag WithType:self.type];
    
}


- (ConsultationViewController *)consultation
{
    if (!_consultation) {
        
        _consultation=[[ConsultationViewController alloc] init];
        
        SendConsultListDTO *senddto = [[SendConsultListDTO  alloc] init];
        senddto.suppliercode =self.productBase.shopCode;
        senddto.isbook =self.productBase.isABook;
        senddto.partnumber = self.productBase.productCode;
        senddto.modeltype =@"4";
        senddto.subcodeflag = @"1";
        _consultation.logdelegate = self;
        _consultation.sendcondto = senddto;
        //[_appraisalVC viewWillAppear:NO];
        
        _consultation.delegate =self;
        
        _consultation.view.frame = self.lastTabView.consultationView.bounds;
        
        _consultation.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        
        [self.lastTabView.consultationView addSubview:_consultation.view];
    }
    return _consultation;
}

-(void)loginViewload:(ConsultListDTO *)dto{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.loginDelegate = self;
    loginVC.isConsultation = YES;
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
    [self presentModalViewController:navController animated:YES];

    
}

-(void)commitconsultation{
    
}

- (NProDtailAppraiseViewController *)appraisalVC
{
    if (!_appraisalVC) {
        
        _appraisalVC=[[NProDtailAppraiseViewController alloc]initWithProductBasicDTO:self.productBase];
        
        //[_appraisalVC viewWillAppear:NO];
        
        _appraisalVC.delegate =self;
        
        _appraisalVC.view.frame = CGRectMake(0, 0, 320, self.lastTabView.backScrollView.frame.size.height);
        
        _appraisalVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        
        [self.lastTabView.rightPingJiaView addSubview:_appraisalVC.view];
    }
    return _appraisalVC;
}

-(void)ConsultationDelegate{
    IWantconsultViewController *iwantsonsult = [[IWantconsultViewController alloc] init];
    iwantsonsult.senddto = self.consultation.sendcondto;
    iwantsonsult.senddto.modeltype = @"5";
    if (self.productBase.isCShop) {
        iwantsonsult.iscflag =@"0";
    }
    else{
        iwantsonsult.iscflag =@"1";
    }
    if (self.productBase.shopCode == nil ||self.productBase.shopCode.length == 0 ) {
        iwantsonsult.store =L(@"Prodcut_ConsultToSuning");
    }
    else{
        NSString *string = [[NSString alloc] initWithFormat:@"%@%@%@",L(@"Product_Xiang"),self.productBase.shopName,L(@"UserFeedBack_Consult")];
        
        iwantsonsult.store = string;
    }
//    iwantsonsult.iscflag = [productBase.isCShop];
    [self.navigationController pushViewController:iwantsonsult animated:YES];
}
- (void)backRecordsDelegate:(NSString *)recordsNum
{
    self.appariseNumStr = recordsNum;
    //self.goodRate = rate;
//    [self.tableView reloadData];
    [self reloadTableView];
    [self.headBtnsCell setNProDetailSixCellInfo:self.productBase WithAppraiseNum:self.appariseNumStr];
    
}
-(void)flowStat
{//流量埋点
    if ([SNSwitch isSuningBISDKOn])
    {
        NSString *strHasStorage = [NSString stringWithFormat:@"-99"];
        if (!IsStrEmpty(self.productBase.hasStorage))
        {
            if ([self.productBase.hasStorage isEqualToString:@"N"])
            {
                strHasStorage = [NSString stringWithFormat:@"-1"];
            }
            else if([self.productBase.hasStorage isEqualToString:@"Z"])
            {
                strHasStorage = [NSString stringWithFormat:@"-2"];
            }
            else
            {
                if(!IsStrEmpty(self.productBase.shipOffset))
                {
                    if ([self.productBase.shipOffset isEqualToString:L(@"Product_Today")])
                    {
                        strHasStorage = [NSString stringWithFormat:@"0"];
                    }
                    else if ([self.productBase.shipOffset isEqualToString:L(@"Product_NextDay")])
                    {
                        strHasStorage = [NSString stringWithFormat:@"1"];
                    }
                    else if ([self.productBase.shipOffset length] > 0)
                    {
                        strHasStorage = [NSString stringWithFormat:@"%@",[self.productBase.shipOffset substringToIndex:[self.productBase.shipOffset length] - 1]];
                    }
                }
                
            }
        }
        
        NSString *code = [NSString stringWithFormat:@"0000000000"];
        if (self.productBase.isCShop)
        {
            code = [NSString stringWithFormat:@"%@",self.productBase.shopCode];
        }
        /*
         缺货统计：stock
         1. 物流送达时间：delivery
         2. 城市：city
         3. 商铺编码：storeid
         4. 商品编码：productid
         5. 推荐曝光：recproduct
         */
        NSString* str = @"null";
        if (self.productBase.productCode)
        {
            if (self.productBase.productCode.length > 9)
            {
                str = [self.productBase.productCode substringFromIndex:9];
            }
            else
            {
                str = self.productBase.productCode;
            }
        }
        NSString* strCityCode = @"null";
        if (self.productBase.cityCode)
        {
            strCityCode = self.productBase.cityCode;
        }
        
        if ([self.recommendListArr count])
        {
            NSMutableString* strRecommend = [[NSMutableString alloc] init];
            int i = 0;
            for (RecommendListDTO* temp in self.recommendListArr)
            {
                if ([temp.sugGoodsCode length] > 9)
                {
                    [strRecommend appendFormat:@"%@",[temp.sugGoodsCode substringFromIndex:9]];
                    if (i != [self.recommendListArr count]-1)
                    {
                        [strRecommend appendFormat:@"_"];
                    }
                    i += 1;

                }
                
            }
            [SSAIOSSNDataCollection CustomEventCollection:@"stock" keyArray: [NSArray arrayWithObjects:@"delivery", @"city", @"storeid",@"productid",@"recproduct", nil]valueArray: [NSArray arrayWithObjects:strHasStorage, strCityCode,code,str,strRecommend, nil]];
            TT_RELEASE_SAFELY(strRecommend);
        }
        else
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"stock" keyArray: [NSArray arrayWithObjects:@"delivery", @"city", @"storeid",@"productid",@"recproduct", nil]valueArray: [NSArray arrayWithObjects:strHasStorage, strCityCode,code,str,@"null", nil]];
        }
    }
    
}

#pragma mark ------S码Action----------

- (void)goToBangding
{
    NSString *productCode = self.productBase.productCode == nil ? @"" : self.productBase.productCode;
    //        if (productCode.length == 18) {
    //            productCode = [productCode substringFromIndex:9];
    //        }
    NSString *vendorId = self.productBase.shopCode == nil ? @"" : self.productBase.shopCode;
    if (IsStrEmpty(vendorId)) {
        vendorId = @"0000000000";
    }
    NSString *actionId = self.productBase.scScodeActivetyId == nil ? @"" : self.productBase.scScodeActivetyId;
    NSString *partName = self.productBase.productName == nil ? @"" : self.productBase.productName;
    
    NSString *str = [NSString stringWithFormat:@"%@/%@?actionId=%@&partNumber=%@&vendorId=%@&partName=%@",kEbuyWapHostURL,@"sCodeBind/private/sCodeBindGoods_1.html",actionId,productCode,vendorId,partName];
    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCommon attributes:@{@"url": str}];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickTobangding
{
    isFromScBuy = NO;
    [self checkLoginWithLoginedBlock:^{
        [self scScodeProductBuy];
    } loginCancelBlock:NULL];
}

- (void)clickToHuoqu
{
    NSString *str = [NSString stringWithFormat:@"http://sale.suning.com/images/advertise/007/appointment/fetchScApp.html"];
    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCommon attributes:@{@"url": str}];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark ------------ 判断应去哪种类型的四级页 ------------

- (void)setJuhuiView:(BigSaleDTO *)bigSaleDto
{
    self.type = BigSaleProduct;
    self.bottomNavBar.height = 75;
    [self.bottomNavBar addSubview:self.timView];
    self.isLoadBigSale = YES;
    
    //如果没有计时器，说明不是从列表页面进入，则手动创建计时器
    [_calculagraph stop];
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    _calculagraph = nil;
    if (_calculagraph == nil)//
    {
        noCalculagraphAtFirst = YES;
        self.calculagraph = [[Calculagraph alloc] init];
    }
    if (noCalculagraphAtFirst)
    {
        [self.calculagraph start];
    }
    
    self.productBase.isJuhui = YES;
    self.productBase.activityId = bigSaleDto.grppurId;
    self.productBase.limitBuyNum = bigSaleDto.limitBuyNum;
    self.lastTabView.bigsaleDto = self.bigsaleDto;
    self.cuView.bigsaleDto = self.bigsaleDto;
    self.cuView.type = self.type;
    [self.cuView refreshView:self.productBase];
    self.cuView.bigSaleCalculagraph = self.calculagraph;
    [self.cuView btnEnable:[self isProductEnabled]];
    
    self.isAllLoaded = YES;
    [self refreshTableView];
}

- (void)showScScodeProductDetail:(AppointmentDTO *)dto
{
    self.type = ScScodeProduct;
    self.bottomNavBar.height = 75;
    [self.bottomNavBar addSubview:self.timView];
    
    //如果没有计时器，说明不是从列表页面进入，则手动创建计时器
    [_calculagraph stop];
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    _calculagraph = nil;
    if (_calculagraph == nil)//
    {
        noCalculagraphAtFirst = YES;
        self.calculagraph = [[Calculagraph alloc] init];
    }
    if (noCalculagraphAtFirst)
    {
        [self.calculagraph start];
    }
    self.productBase.scScodeActivetyId = dto.scActionId;
    self.cuView.appointmentDto = self.appointmentDto;
    self.cuView.type = self.type;
    [self.cuView refreshView:self.productBase];
    self.cuView.scScodeCalculagraph = self.calculagraph;
    [self.cuView btnEnable:[self isProductEnabled]];
    
    self.isAllLoaded = YES;
    [self refreshTableView];

}

//比较有无抢团标识，若有，则比较价格大小
- (ProductDeatailType)getSpecialProductView:(BOOL)isScProduct
{
    ProductDeatailType productDetailType;
    if (isScProduct == YES && self.appointmentDto.scScodeStatus == OnBuy) {
        productDetailType = ScScodeProduct;
    }
    else
    {
        productDetailType = NormalProduct;
    }
   
    
    //抢团标识都存在，则比较价格大小，小的展示，团购优先级更高
    if ([self.productBase.qianggouFlag isEqualToString:@"1"]&&[self.productBase.tuangouFlag isEqualToString:@"1"])
    {
        if ([self.productBase.tuangouPrice intValue] > [self.productBase.qianggouPrice intValue]) {
            productDetailType = PurchuseProduct;
        }
        else
        {
            productDetailType = GroupProduct;
        }
    }
    //只有抢购标识则展示抢购页面
    else if ([self.productBase.qianggouFlag isEqualToString:@"1"]&&![self.productBase.tuangouFlag isEqualToString:@"1"])
    {
        productDetailType = PurchuseProduct;
    }
    //只有团购标识则展示团购页面
    else if ([self.productBase.tuangouFlag isEqualToString:@"1"]&&![self.productBase.qianggouFlag isEqualToString:@"1"])
    {
        productDetailType = GroupProduct;
    }
    
    return productDetailType;
}

//展示各个详情页面
- (void)goToSpecialProductView:(ProductDeatailType)detailType
{
    //去抢购
    if (detailType == PurchuseProduct) {
        NSString *cityCode=self.productBase.cityCode==nil?[Config currentConfig].defaultCity:self.productBase.cityCode;
        
        
        self.type = PurchuseProduct;
        [self.panicService beginGetPanicPurchaseDetailList:self.productBase.qianggouActId  cityId:cityCode];
    }
    //去团购
    else if (detailType == GroupProduct)
    {
        
        self.type = GroupProduct;
        [self.groupDeatilService beginSendDJListRequest:self.productBase.tuangouActId channelId:self.channelId];
    }
    //去大聚惠
    else if (detailType == BigSaleProduct)
    {
        [self setJuhuiView:self.bigsaleDto];
    }
    //展示普通详情
    else
    {
        self.type = NormalProduct;
        //刷新商品簇
        self.cuView.type = self.type;
        [self.cuView refreshView:self.productBase];
        [self.cuView btnEnable:[self isProductEnabled]];
        
        self.isAllLoaded = YES;
        [self refreshTableView];
    }
}


#pragma mark -
#pragma mark ProductDetailService Delagate
- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg
                               productDetail:(DataProductBasic *)product
{
    [self removeOverFlowActivityView];
    [self.cuView removeOverFlowActivityView];
    if(isSuccess)
    {
        if(KPerformance)
        {

            if ([[PerformanceStatistics sharePerformanceStatistics].arrayData count] > 0)
            {
                [PerformanceStatistics sharePerformanceStatistics].countStatus +=1;
                PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
                
                if (!(temp.distanceTime.length>0))
                {
                    temp.endTime = [NSDate date];
                    temp.distanceTime = [[PerformanceStatistics sharePerformanceStatistics]getTimer:[PerformanceStatistics sharePerformanceStatistics].startTimeStatus end:temp.endTime];
                    if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [[PerformanceStatistics sharePerformanceStatistics].arrayData count])
                    {
                        [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                    }
                    
                }
            }
            
        }
        //add by liukun, 如果是从扫描过来的，收集为扫描历史
        if ([self routeSource] == SNRouteSourceScan) {
            
            ScanHistoryDAO *dao = [[ScanHistoryDAO alloc] init];
            [dao writeProductToDB:product];

        }
        
        self.bottomNavBar.height = 48;
        [self.timView removeFromSuperview];

        if (IsStrEmpty(product.productName)) {
            product.productName = self.productBase.productName;
        }
        
        self.productBase = product;
        self.productBase.isJuhui = NO;
        self.lastTabView.productInfoDto = self.productBase;
        self.lastTabView.baseInfoView.baseInfoDto = self.productBase;
        
        self.isLoadDetail       = YES;
        self.isLoadBigSale      = NO;
        self.isLoadGroup        = NO;
        self.isLoadPurchase     = NO;
        self.isLoadAppointment  = NO;
        self.isScProduct        = NO;
        
        self.zixunCountStr = self.productBase.zixunCount;
        
        //当前选择颜色、型号
        NSString *colorCurrValue = nil;
        NSString *versionCurrValue = nil;
        for (NSDictionary *colorDic in self.productBase.colorItemList)
        {
            if ([self.productBase.colorCurr isEqualToString:[colorDic objectForKey:@"colorId"]]) {
                colorCurrValue = [colorDic objectForKey:@"colorNm"];
                break;
            }
        }
        for (NSDictionary *colorDic in self.productBase.versionItemList)
        {
            if ([self.productBase.versionCurr isEqualToString:[colorDic objectForKey:@"versionId"]]) {
                versionCurrValue = [colorDic objectForKey:@"versionNm"];
                break;
            }
        }
        if (IsStrEmpty(colorCurrValue) && IsStrEmpty(versionCurrValue)) {
            self.colorOrVerStr = @"";
        }else
        {
            self.colorOrVerStr = [NSString stringWithFormat:@"%@  %@ %@",L(@"Product_SelectedAlready"),IsStrEmpty(colorCurrValue)?@"":colorCurrValue, IsStrEmpty(versionCurrValue)?@"":versionCurrValue];
        }
        
                
        //刷新商品图片展示区
        [self refreshFirstProImagesView];
        
        [self getShareImage];
        
        //渠道传入
        
        if ([self.productBase.rushPurChan isEqualToString:@"1"])
        {
            self.panicService.panicChannel = PanicChannelB2C;
        }
        else if ([self.productBase.rushPurChan isEqualToString:@"2"])
        {
            self.panicService.panicChannel = PanicChannelMobile;
        }

        //若是从抢团购列表页过来则直接请求抢团购数据
        if (self.productType == FromGroupProduct)
        {
            self.productType = 0;
            
            self.type = GroupProduct;
            [self.groupDeatilService beginSendDJListRequest:self.actId channelId:self.channelId];
        }
        else if (self.productType == FromPanicProduct)
        {
            self.productType = 0;
            NSString *cityCode=self.productBase.cityCode==nil?[Config currentConfig].defaultCity:self.productBase.cityCode;
            
            
            self.type = PurchuseProduct;
            [self.panicService beginGetPanicPurchaseDetailList:self.panicDTO.rushPurId  cityId:cityCode];
        }
        else if (self.productType == FromBigSaleProduct)
        {
            
            [self.proDetailService beginGetProductBigSaleInfo:self.productBase];
        }
        else
        {
            
            [self.proDetailService beginGetProductAppointmentInfo:self.productBase];
            
        }
        
        
        if (self.type != NormalProduct)
        {
            [self flowStat];
        }
        //底部按钮位置
        if([ShopCartV2ViewController sharedShopCart].logic.allProductQuantity > 0)
        {
            [self refreshButtomView:YES];
        }
        else
        {
            [self refreshButtomView:NO];
        }
        //刷新底部按钮
        [self refreshBtn];
        
        [self reloadTableView];
    }
    else{
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:errorMsg
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        
        [alert setCancelBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert show];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)getIsSpotSupportedWithResult:(BOOL)isSucess{
    if (isSucess) {
        isSpotSupported = YES;
    }else{
        isSpotSupported = NO;
    }
    [self reloadTableViewData];
}

//预约详情回调
- (void)getAppointmentProductCompletionWithResult:(BOOL)isSuccess service:(ProductDetailService *)service errorMsg:(NSString *)errorMsg appointmentDetail:(AppointmentDTO *)dto
{
    [self removeOverFlowActivityView];
    self.isScProduct = service.isScProduct;
    //预约优先级最高，请求成功则必展示预约界面
    if (isSuccess) {
        
        self.type = AppointmentProduct;
        self.bottomNavBar.height = 75;
        [self.bottomNavBar addSubview:self.timView];
        self.isLoadAppointment = YES;
        
        //如果没有计时器，说明不是从列表页面进入，则手动创建计时器
        [_calculagraph stop];
        [_calculagraph removeObserver:self forKeyPath:@"time"];
        _calculagraph = nil;
        if (_calculagraph == nil)//
        {
            noCalculagraphAtFirst = YES;
            self.calculagraph = [[Calculagraph alloc] init];
        }
        if (noCalculagraphAtFirst)
        {
            [self.calculagraph start];
        }
        
        self.appointmentDto = dto;
//        self.productBase.isJuhui = YES;
        self.productBase.appointPrice = @([dto.productPrice doubleValue]);
        self.productBase.appointActivityId = dto.actionId;
        self.productBase.scScodeActivetyId = dto.scActionId;
        self.productBase.limitBuyNum = dto.personBuysLimit;
        self.lastTabView.appointmentDto = self.appointmentDto;
        self.cuView.appointmentDto = self.appointmentDto;
        self.cuView.type = self.type;
        self.cuView.isScProduct = self.isScProduct;
        [self.cuView refreshView:self.productBase];
        self.cuView.appointmentCalculagraph = self.calculagraph;
        [self.cuView btnEnable:[self isAppointmentProductEnabled]];
     
        self.isAllLoaded = YES;
        [self refreshTableView];
    }
    else
    {
        self.appointmentDto = dto;
        self.productBase.scScodeActivetyId = dto.scActionId;
        //若该商品不是预约而是S码则直接展示S码详情
        if (self.isScProduct == YES && dto.scScodeStatus == OnBuy) {
            [self showScScodeProductDetail:dto];
            return;
        }
        if (![SNSwitch isNeedJuhui])
        {
            //判断有无抢团标识再比较价格
            ProductDeatailType detailType = [self getSpecialProductView:self.isScProduct];
            [self goToSpecialProductView:detailType];
        }
        else
        {
            
            [self.proDetailService beginGetProductBigSaleInfo:self.productBase];
        }
    }
}

//大聚惠详情回调
- (void)getBigSaleProductCompletionWithResult:(BOOL)isSuccess service:(ProductDetailService *)service errorMsg:(NSString *)errorMsg bigSaleDetail:(BigSaleDTO *)dto
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        self.bigsaleDto = dto;
        //从大聚惠列表页过来的直接进大聚惠页面
        self.productBase.juhuiPrice =  @([dto.gbPrice doubleValue]);
        if (self.productType == FromBigSaleProduct) {
            self.productType = 0;
            [self setJuhuiView:dto];
        }
        //若是返回的大聚惠为正在活动中的，则判断价格
        else if ([service.djhActiveStatusStr isEqualToString:@"2"])
        {
            //获取商品详情type
            ProductDeatailType detailType = [self getSpecialProductView:self.isScProduct];
            //比较价格大小，展示价格低商品详情，优先级顺序为大聚惠、团购、抢购
            if (detailType == PurchuseProduct) {
                if ([self.productBase.juhuiPrice intValue] > [self.productBase.qianggouPrice intValue])
                {
                    detailType = PurchuseProduct;
                }
                else
                {
                    detailType = BigSaleProduct;
                }
            }
            else if (detailType == GroupProduct)
            {
                if ([self.productBase.juhuiPrice intValue] > [self.productBase.tuangouPrice intValue])
                {
                    detailType = GroupProduct;
                }
                else
                {
                    detailType = BigSaleProduct;
                }
            }
            else if (detailType == NormalProduct || detailType == ScScodeProduct)
            {
                detailType = BigSaleProduct;
            }
            //去各个详情
            [self goToSpecialProductView:detailType];
        }
        //大聚惠不在活动中
        else
        {
            //判断有无抢团标识再比较价格
            ProductDeatailType detailType = [self getSpecialProductView:self.isScProduct];
            [self goToSpecialProductView:detailType];
        }
    }
    else
    {
        //判断有无抢团标识再比较价格
        ProductDeatailType detailType = [self getSpecialProductView:self.isScProduct];
        [self goToSpecialProductView:detailType];
    }
}

//抢购详情回调
- (void)getPanicPurchaseDetailCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg panicPurchaseDetail:(PanicPurchaseDTO *)dto errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    if(isSuccess && errorMsg==nil)
    {
        self.bottomNavBar.height = 75;
        [self.bottomNavBar addSubview:self.timView];
        self.isLoadPurchase = YES;
        self.panicDTO = dto;
        //如果没有计时器，说明不是从列表页面进入，则手动创建计时器
        [_calculagraph stop];
        [_calculagraph removeObserver:self forKeyPath:@"time"];
        _calculagraph = nil;
        if (_calculagraph == nil)//
        {
            noCalculagraphAtFirst = YES;
            self.calculagraph = [[Calculagraph alloc] init];
        }
        
        if (noCalculagraphAtFirst)
        {
            [self.calculagraph start];
        }
        
        self.buyNowBtn.enabled = YES;

            //            [_panicDTO removeObserver:self forKeyPath:@"purchaseState"];
//            dto.rushPurId = self.panicDTO.rushPurId;
        

        self.panicDetailDto=dto;
        
        self.panicDTO.leftQty = dto.leftQty;
        self.panicDTO.isSale = dto.isSale;
        self.panicDTO.rushPurPrice = dto.rushPurPrice;
        self.panicDTO.rushPurId = dto.rushPurId;
        
        self.productBase.qianggouPrice = @([dto.rushPurPrice doubleValue]);
        
        self.productBase.quickbuyId = dto.rushPurId;
        
        self.lastTabView.type = self.type;
        self.lastTabView.panicDTO = self.panicDTO;
        self.lastTabView.panicChannel = self.panicService.panicChannel;
        self.lastTabView.isLoadPurchase = self.isLoadPurchase;
        
        self.cuView.type = self.type;
        self.cuView.panicDTO = dto;
        self.cuView.isLoadPurchase = self.isLoadPurchase;
        
        self.type = PurchuseProduct;
        
        [self.cuView refreshView:self.productBase];
        self.cuView.calculagraph = self.calculagraph;
        [self.cuView btnEnable:[self isPurchaseProductEnabled]];
        
        if([errorCode isEqualToString:@"0"])
        {
            if([dto.leftQty isEqualToString:@"0"])
            {
                [self presentSheet:L(@"panicPurchase over")];
                
                self.buyNowBtn.enabled = NO;
            }
            //            else if([dto.isSale isEqualToString:@"0"])
            //            {
            //                [self presentSheet:@"该城市暂不销售"];
            //
            //                self.buyNowBtn.enabled = NO;
            //
            //            }
            else if (IsStrEmpty(dto.partNumber)){
                
                [self removeOverFlowActivityView];
                self.buyNowBtn.enabled = NO;
                [self presentSheet:L(@"panicPurchase over")];
//                return;
            }
        }
    }
    else
    {
        self.buyNowBtn.enabled = NO;
        
        [self presentSheet:errorMsg];
    }
    self.isAllLoaded = YES;
    [self refreshTableView];
}

//团购详情回调
- (void)didSendDJDetailRequestComplete:(DJGroupDetailService *)service Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        if (!IsNilOrNull(service)) {
            self.bottomNavBar.height = 75;
            [self.bottomNavBar addSubview:self.timView];
            self.isLoadGroup = YES;
            self.groupDeatilService = service;
            if (self.groupDeatilService.detailDto) {
                self.detailDto = nil;
                self.detailDto = self.groupDeatilService.detailDto;
                self.productBase.tuangouPrice = @([self.detailDto.displayPrice doubleValue]);
                //开启计时器
                [_calculagraph stop];
                [_calculagraph removeObserver:self forKeyPath:@"time"];
                _calculagraph = nil;
                if (_calculagraph == nil)//
                {
                    noCalculagraphAtFirst = YES;
                    self.calculagraph = [[Calculagraph alloc] init];
                }
                if (noCalculagraphAtFirst) {
                    [self.calculagraph start];
                }
                
                self.lastTabView.detailDto = self.detailDto;
                self.cuView.detailDto = self.detailDto;
                self.cuView.type = self.type;
                [self.cuView refreshView:self.productBase];
                self.cuView.groupBuyCalculagraph = self.calculagraph;
                [self.cuView btnEnable:[self isProductEnabled]];
            }
            
        }else{
            [self presentSheet:L(@"Product_GroupNotEffective")];
        }
        self.type = GroupProduct;
    }else{
        
        [self presentSheet:L(@"ASI_CONNECTION_FAILURE_ERROR")];
    }
    
    self.isAllLoaded = YES;
    [self refreshTableView];
}

//是否已收藏回调
- (void)getDetailCollectServiceInfo:(BOOL)isSuccess WithStr:(NSString *)str
{
    //    [self removeOverFlowActivityView];
    
    if(isSuccess)
    {
        self.collectFlag = str;
        
        if(KPerformance)
        {
            NSLog(@"%d",[[PerformanceStatistics sharePerformanceStatistics].arrayData count]);
            if ([[PerformanceStatistics sharePerformanceStatistics].arrayData count] > 0)
            {
                
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                if ([[PerformanceStatistics sharePerformanceStatistics].arrayData count] == [PerformanceStatistics sharePerformanceStatistics].countStatus)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:1];
                    temp.endTime = [NSDate date];
                    temp.distanceTime = [[PerformanceStatistics sharePerformanceStatistics]getTimer:[PerformanceStatistics sharePerformanceStatistics].startTimeStatus end:temp.endTime];
                    if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [[PerformanceStatistics sharePerformanceStatistics].arrayData count])
                    {
                        [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                    }
                    
                }
            }
            
        }
        [self refreshFirstProImagesView];
        
    }
    else
    {
        
    }
    
//    [self.tableView reloadData];
    
}

//取消收藏回调
- (void)getDeleteMyFavoriteCompletionWith:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    //    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        self.collectService.bookFlag = @"0";
        
        self.collectFlag = @"0";
        
        [self presentSheet:L(@"Product_CancelMarkSuccess") posY:100];
        
    }else{
        [self presentSheet:L(@"Product_CancelMarkFailed")];
    }
    
    [self refreshFirstProImagesView];
//    [self.tableView reloadData];
}

//收藏回调
- (void)addToFavoriteCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg errorCode:(NSString *)errorCode
{
    if (isSuccess) {
        
        self.collectFlag = @"1";
        errorMsg = L(@"addToFavorite success");
        self.collectService.bookFlag = @"1";
    }
    else{
        
        self.collectFlag = @"0";
        self.collectService.bookFlag = @"0";
    }
    
    [self presentSheet:errorMsg posY:100];
    if ([errorCode isEqualToString:@"D"]) {
        self.collectFlag = @"1";
        self.collectService.bookFlag = @"1";
    }
    
    [self refreshFirstProImagesView];
    
//    [self.tableView reloadData];
}

- (void)GetConsultCountDelegate:(NSString *)consultnum error:(NSString *)error{
    if (!error) {
//        [self presentSheet:error];
    }
    else{
        
    }
}

//推荐商品回调
- (void)getRecommendListCompletionWithResult:(BOOL)isSuccess errorCode:(NSString *)errorMsg list:(NSArray *)array
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        self.recommendListArr = array;
        if (self.recommendListArr.count)
        {
            [self flowStat];
        }
    }
    else
    {
//        [self presentSheet:errorMsg];
    }
//    [self.tableView reloadData];
    [self reloadTableView];
}

#pragma mark ----------------------------- tableview reload

- (void)refreshTableView
{
    //底部按钮位置
    if([ShopCartV2ViewController sharedShopCart].logic.allProductQuantity > 0)
    {
        [self refreshButtomView:YES];
    }
    else
    {
        [self refreshButtomView:NO];
    }
    //刷新底部按钮
    [self refreshBtn];
    
    [self reloadTableView];
    
    
    self.bottomNavBar.hidden = NO;
    self.bottomNavBar.top = self.view.bounds.size.height + self.view.bounds.origin.y;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomNavBar.bottom = self.view.bounds.size.height + self.view.bounds.origin.y;
    }];
    
    
    
    //加载客服状态
    [self getOnlineServiceStatus];
    //发送商品评价请求
    self.appraisalVC.productBasic = self.productBase;
    self.appraisalVC.reviewType = 1;
    //[self.appraisalVC sendLabelHttpRequest];
    [self.appraisalVC sendHttpRequest];
    //推荐商品请求
    [self.proDetailService beginGetProductRecommendList:self.productBase];
    //附近现货入口
//    [self.proDetailService beginGetProductIsSpotSupported:self.productBase];
}

- (void)reloadTableView
{
    [self setUpPageTitles]; //刷新pageTitle，用于数据收集

    [self prepareTableViewDatasource];
    
    [self.tableView reloadData];
}

- (void)prepareTableViewDatasource
{
    
    NSMutableArray *array = [NSMutableArray array];
    
//    if (self.type!=NormalProduct) {//非普通商品不展示附近现货
//        isSpotSupported = NO;
//    }
    
    
    //商品图片行
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品图片行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductImage_Cell",
                                      kTableViewCellHeightKey : @240.0f};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }
    
    //商品卖点行
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品特点行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductSpecial_Cell",
                                      kTableViewCellHeightKey : @([NDetailSecondCell NDetailSecondCellHeight:self.productBase WithBool:_isFold])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }
    
    //商品价格行
    if (self.isAllLoaded) {
        if (self.type == NormalProduct || self.type == AppointmentProduct || self.type == ScScodeProduct)
        {
            if (self.isLoadDetail)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                //添加数据
                NSMutableArray *cellList = [NSMutableArray array];
                //商品价格行
                {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"ProductPrice_Cell",
                                              kTableViewCellHeightKey : @([NProDetailThirdCell NProDetailThirdCellHeight:self.productBase])
                                              };
                    [cellList addObject:cellDic];
                }
                
                [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
                [dic setObject:cellList forKey:kTableViewCellListKey];
                [array addObject:dic];
            }
        }
        else
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            //添加数据
            NSMutableArray *cellList = [NSMutableArray array];
            //商品价格行
            {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"ProductQiangTuanPrice_Cell",
                                          kTableViewCellHeightKey : @([NQiangGouThridCell NSpecialThirdCellHeight:self.productBase withType:self.type])
                                          };
                [cellList addObject:cellDic];
            }
            
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];
            [array addObject:dic];
        }
    }
    //S码介绍行
    if (self.isAllLoaded)
    {
        if ((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop)
        {
            if (self.isScProduct == YES && self.appointmentDto.scScodeStatus != BuyOver) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                //添加数据
                NSMutableArray *cellList = [NSMutableArray array];
                //S码介绍行
                {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"ProductScScode_Cell",
                                              kTableViewCellHeightKey : @([self heightOfScScodeProductCell])
                                              };
                    [cellList addObject:cellDic];
                }
                
                [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
                [dic setObject:cellList forKey:kTableViewCellListKey];
                
                [array addObject:dic];
            }
        }
    }
    
    //商品地址行
    if ((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品地址行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductAddress_Cell",
                                      kTableViewCellHeightKey : @([NProDetailFourthCell NProDetailFourCellHeight:self.productBase  WithType:self.type])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        [array addObject:dic];
    }
    
    //附近现货行
    if (isSpotSupported)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"SpotSupported_Cell",
                                      kTableViewCellHeightKey : @([NProDetailSpotSupportCell getCellHeight])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    //服务行
    if ((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //服务行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductServiceCu_Cell",
                                      kTableViewCellHeightKey : @([NProDetailServerCell NProDetailFourCellHeight:self.productBase])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    //商品簇及商品数量编辑行
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品簇
        if (0 == [self.productBase.colorItemList count] &&
            0 == [self.productBase.versionItemList count] &&
            0 == [self.productBase.smallPackageList count] &&
            0 == [self.productBase.allAccessoryProductList count])
        {
            
        }
        else
        {
            if (self.type != NormalProduct) {
                if (0 == [self.productBase.colorItemList count] &&
                    0 == [self.productBase.versionItemList count]) {
                    
                }
                else
                {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"ProductCu_Cell",
                                              kTableViewCellHeightKey: @40.0f
                                              };
                    [cellList addObject:cellDic];
                }
            }
            else{
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"ProductCu_Cell",
                                          kTableViewCellHeightKey: @40.0f
                                          };
                [cellList addObject:cellDic];
            }
        }
        //数量编辑行
        if (((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop) && self.type != PurchuseProduct && self.type != ScScodeProduct)
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductNum_Cell",
                                      kTableViewCellHeightKey: @50.0f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@0.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@15.0f forKey:kTableViewSectionFooterHeightKey];
        
        if ([cellList count] > 0) {
            [array addObject:dic];
        }
    }

    
    //商品基本信息行
    if ((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品基本信息行
        {
            for (int i = 0; i< 4; i ++) {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"ProductBasicInfo_Cell",
                                          kTableViewCellHeightKey: @(40.0f)
                                          };
                [cellList addObject:cellDic];
            }
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }
    
    //卖家评价行
    if ((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //卖家评价行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductSellerEvaluation_Cell",
                                      kTableViewCellHeightKey : @([self heightOfProductSellerCell])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@15.0f forKey:kTableViewSectionHeaderHeightKey];
        
        [array addObject:dic];
    }
    
    //卖家列表行
    if ((self.productBase.isPublished && !self.productBase.isCShop) || self.productBase.isCShop)
    {
        if([self.productBase.shopSize intValue] > 1)
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            //添加数据
            NSMutableArray *cellList = [NSMutableArray array];
            //卖家列表行
            {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"ProductSeller_Cell",
                                          kTableViewCellHeightKey : @55.0f
                                          };
                [cellList addObject:cellDic];
            }
            
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];
            
            [array addObject:dic];
        }

    }
        //推荐商品行
    if ([self.recommendListArr count] > 0)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //推荐商品行
        NSUInteger count = [self.recommendListArr count];
        
        NSUInteger cellCount = (count%3==0) ? count/3 : count/3+1;
        for (int i =0; i < cellCount; i++)
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductRecomm_Cell",
                                      kTableViewCellHeightKey : @150.0f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@45.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@0.0f forKey:kTableViewSectionFooterHeightKey];
        [dic setObject:@"Recomm_View" forKey:kTableViewSectionHeaderTypeKey];
        
        [array addObject:dic];
    }
    
    
    //若商品下架的话,在最后一层section下方添加一个透明section,防止section过少上滑tableView时露出商品图片
    if ([array count] < 5) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //透明section
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductSection_Cell",
                                      kTableViewCellHeightKey : @85.0f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }

    _dataSourceArray = array;
}

- (CGFloat)heightOfProductSellerCell
{
    if([self.productBase.shopSize intValue] > 1)
    {
        return [NProDetailFiveCell NProDetailFiveCellheight:self.productBase WithChatStatus:chatServiceStatus]-10;
        
    }
    else
    {
        return [NProDetailFiveCell NProDetailFiveCellheight:self.productBase WithChatStatus:chatServiceStatus] - 15;
        
    }
}

//S码促销信息行高度
- (CGFloat)heightOfScScodeProductCell
{
    CGSize size = [self.appointmentDto.promotionLabel sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(202, 60) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 50;
}

#pragma mark -
#pragma UITableViewDataSource And Delegate
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
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    NSString *type = [sectionDic objectForKey:kTableViewSectionHeaderTypeKey];
    
    if ([type isEqualToString:@"Recomm_View"])
    {
        UIView *backView = [[UIView alloc] init];
        backView.frame = CGRectMake(0, 0, 320, 45);
        backView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *separetaLine = [[UIImageView alloc] init];
        separetaLine.frame = CGRectMake(0, 0, 320, 0.5);
        separetaLine.image = [UIImage imageNamed:@"line.png"];
        [backView addSubview:separetaLine];
        
        UIImageView *separetaLine1 = [[UIImageView alloc] init];
        separetaLine1.frame = CGRectMake(0, 44.5, 320, 0.5);
        separetaLine1.image = [UIImage imageNamed:@"line.png"];
        [backView addSubview:separetaLine1];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(15, 15, 100, 15);
        title.text = L(@"Product_RecommendForYou");
        title.font = [UIFont systemFontOfSize:15];
        title.backgroundColor = [UIColor clearColor];
        [backView addSubview:title];
        
        return backView;

    }
    else
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
//    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"ProductImage_Cell"]) //商品图片
    {
        NProDetailFirstCell *cell = (NProDetailFirstCell *)[tableView dequeueReusableCellWithIdentifier:firstviewCellIdetifier];
        
        if (cell == nil) {
            cell = self.firstView;
            //            cell = [[NProDetailFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            cell.delegate = self;
            //            cell.proImagesScroll.touchImagesDelegate = self;
            
            cell.layer.zPosition = -1;
            if (IOS7_OR_LATER) {
                for (UIView *subview in cell.subviews) {
                    subview.clipsToBounds = NO;
                }
            }
            cell.clipsToBounds = NO;
        }
        if (self.isAllLoaded) {
            if (NormalProduct == self.type) {
                cell.collectBtn.hidden = NO;
            }else
            {
                cell.collectBtn.hidden = YES;
            }
        }
        else
        {
            cell.collectBtn.hidden = YES;
        }
        [cell setNProDetailFirstCell:self.productBase WithCollectFlag:self.collectFlag WithType:self.type];
        
        
        return cell;

    }
    else if ([cellType isEqualToString:@"ProductSpecial_Cell"])     //商品卖点
    {
        NDetailSecondCell *cell = (NDetailSecondCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NDetailSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
            
            UIView *backView = [[UIView alloc] init];
            backView.frame = cell.bounds;
            backView.backgroundColor = RGBCOLOR(242, 242, 242);
            
            cell.backgroundView = backView;
            
        }
        
        [cell setNDetailSeconfCellInfo:self.productBase];
        
        cell.clipsToBounds = YES;
        
        return cell;

    }
    else if ([cellType isEqualToString:@"ProductPrice_Cell"])     //普通商品价格、预约商品价格、S码商品价格
    {
        NProDetailThirdCell *cell = (NProDetailThirdCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NProDetailThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        [cell setNProDetailThirdCellInfo:self.productBase];
        
        if (!self.isLoadDetail)
        {
            cell.sellPointLab.text = @"";
        }

        return cell;

    }
    else if ([cellType isEqualToString:@"ProductQiangTuanPrice_Cell"])     //抢团购商品价格
    {
        NQiangGouThridCell *cell = (NQiangGouThridCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (nil == cell)
        {
            cell = [[NQiangGouThridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        if(!self.isLoadDetail)
        {
            cell.sellPointLab.text = @"";
        }
        
        if (self.type == PurchuseProduct) {
            [cell setNQiangGouThridCellInfo:self.panicDTO WithDetail:self.productBase];
//            cell.downPrice.text = @"抢购价: ";
            cell.saveLbl.text = [NSString stringWithFormat:@"%@：%@%@",L(@"leftCount"),self.panicDTO.leftQty?self.panicDTO.leftQty:@"",L(@"Purchase_Jian")];
        }
        else if (self.type == GroupProduct)
        {
            [cell setNTuanGouThridCellInfo:self.detailDto WithDetail:self.productBase];
//            cell.downPrice.text = @"团购价: ";
            cell.saveLbl.text =
            [NSString stringWithFormat:@"%@：%@%@",L(@"Already buy"), self.detailDto.totalQty?self.detailDto.totalQty:@"",L(@"Purchase_Jian")];
        }
        else if (self.type == BigSaleProduct)
        {
//            float save = [self.productBase.netPrice floatValue] - [self.bigsaleDto.gbPrice floatValue];
//            NSInteger lostNum = [self.bigsaleDto.gbCommNum integerValue] - [self.bigsaleDto.saleNum integerValue];
            NSString *lostNumStr = [NSString stringWithFormat:@"%d",[self.bigsaleDto.saleNum integerValue]];
            
            [cell setBigSaleThirdCellInfo:self.bigsaleDto WithDetail:self.productBase];
//            cell.downPrice.text = @"促销价: ";
            cell.saveLbl.text = [NSString stringWithFormat:@"%@：%@%@",L(@"Already buy"),lostNumStr,L(@"Purchase_Jian")];
        }
//        else if (self.type == AppointmentProduct)
//        {
//            [cell setAppointmentThirdCellInfo:self.appointmentDto WithDetail:self.productBase];
//        }
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductScScode_Cell"])     //S码介绍
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 305, 0.5)];
            lineImg.backgroundColor = [UIColor clearColor];
            lineImg.image = [UIImage imageNamed:@"line.png"];
            [cell.contentView addSubview:lineImg];
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 20, 20)];
            img.backgroundColor = [UIColor clearColor];
            img.image = [UIImage imageNamed:@"productDetail_ScScode.png"];
            [cell.contentView addSubview:img];
            
            CGSize size = [self.appointmentDto.promotionLabel sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(202, 60) lineBreakMode:NSLineBreakByWordWrapping];
            UILabel *priceLbl = [[UILabel alloc] init];
            priceLbl.frame = CGRectMake(img.right + 5, 13, 202, size.height + 5);
            priceLbl.backgroundColor = [UIColor clearColor];
            priceLbl.font = [UIFont systemFontOfSize:14];
            priceLbl.numberOfLines = 0;
            priceLbl.text = self.appointmentDto.promotionLabel;
            priceLbl.lineBreakMode = NSLineBreakByWordWrapping;
//            priceLbl.text = [NSString stringWithFormat:@"绑定S码享受%@元优惠价购买!",self.appointmentDto.scScodePrice];
//            priceLbl.adjustsFontSizeToFitWidth = YES;
            [cell.contentView addSubview:priceLbl];
            
            UIButton *bangdingBtn = [[UIButton alloc] initWithFrame:CGRectMake(priceLbl.right + 5, 15, 60, 20)];
            bangdingBtn.backgroundColor = [UIColor clearColor];
            [bangdingBtn setImage:[UIImage imageNamed:@"productDetail_Sc_bangding.png"] forState:UIControlStateNormal];
            [bangdingBtn addTarget:self action:@selector(clickTobangding) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:bangdingBtn];
            
            UILabel *huoquLbl = [[UILabel alloc] initWithFrame:CGRectMake(priceLbl.left, priceLbl.bottom + 5, 70, 20)];
            huoquLbl.backgroundColor = [UIColor clearColor];
            huoquLbl.font = [UIFont systemFontOfSize:14];
            huoquLbl.text = @"没有S码？";
            [cell.contentView addSubview:huoquLbl];
            
            UIButton *huoquBtn = [[UIButton alloc] initWithFrame:CGRectMake(huoquLbl.right , huoquLbl.top, 60, 20)];
            huoquBtn.backgroundColor = [UIColor clearColor];
            [huoquBtn setImage:[UIImage imageNamed:@"productDetail_Sc_huoqu.png"] forState:UIControlStateNormal];
            [huoquBtn addTarget:self action:@selector(clickToHuoqu) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:huoquBtn];
        }
        
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductAddress_Cell"])     //送货地址
    {
        NProDetailFourthCell *cell = (NProDetailFourthCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NProDetailFourthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.type = NormalProduct;//self.type;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        if(self.isLoadDetail)
        {
            [cell setNProDetailFourCellInfo:self.productBase WithType:self.type coloStr:self.colorOrVerStr];
            
        }
        if (self.type == PurchuseProduct || self.type == GroupProduct) {
            cell.deliveryFeeLbl.hidden = YES;
        }
        if (self.isAllLoaded) {
            cell.defaultAddressButton.enabled = YES;
        }else
        {
            cell.defaultAddressButton.enabled = NO;
        }
        cell.clipsToBounds = NO;
        
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductServiceCu_Cell"])     //服务
    {
        NProDetailServerCell *cell = (NProDetailServerCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[NProDetailServerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        [cell setServiceDto:self.productBase coloStr:self.colorOrVerStr];
        [cell.arrowImageV addTarget:self action:@selector(selectColorOrSizeOrNum:) forControlEvents:UIControlEventTouchUpInside];
        cell.clipsToBounds = YES;
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductCu_Cell"])      //商品簇
    {
        NProDetailCuCell *cell = (NProDetailCuCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[NProDetailCuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        [cell setColorStr:self.colorOrVerStr withType:self.type];
        cell.clipsToBounds = YES;
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductNum_Cell"])         //数量编辑行
    {
        ProductNumberCell *cell = (ProductNumberCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (nil == cell)
        {
            cell = [[ProductNumberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
//        self.numberTF = cell.numberTF;
        cell.numberLab.frame = CGRectMake(15, 15, 40, 20);
        cell.numberLab.font = [UIFont systemFontOfSize:14];
        cell.numberLab.text = L(@"Product_AmoUnts");
        cell.numberLab.textColor = [UIColor blackColor];
        cell.limitLbl.frame = CGRectMake(190, 15, 120, 20);
        cell.btnAdd.frame = CGRectMake(124, 0, 44, 50);
        cell.btnDelete.frame = CGRectMake(55, 0, 44, 50);
        cell.numberTF.frame = CGRectMake(94, 14, 35,22);
        cell.numberTF.text = [NSString stringWithFormat:@"%d",self.productBase.quantity];
        if (self.productBase.quantity == 1) {
            cell.btnDelete.enabled = NO;
            cell.btnAdd.enabled = YES;
        } else if (self.productBase.quantity == 99)
        {
            cell.btnAdd.enabled = NO;
            cell.btnDelete.enabled = YES;
        }
        else
        {
            cell.btnDelete.enabled = YES;
            cell.btnAdd.enabled = YES;
        }
        cell.mydelegate = self;
        [cell setProductInfo:self.productBase];
        return cell;

    }
    else if ([cellType isEqualToString:@"SpotSupported_Cell"])     //附近现货
    {
        NProDetailSpotSupportCell *cell = (NProDetailSpotSupportCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NProDetailSpotSupportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        cell.contentLabel.text = L(@"Product_CheckNearShop");
        
        return cell;
        
    }
    else if ([cellType isEqualToString:@"ProductBasicInfo_Cell"])     //商品基本信息
    {
        UITableViewCell *cell = (NProDetailFourthCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        else
        {
            [cell.contentView removeAllSubviews];
        }
        
        UIImageView *line = [[UIImageView alloc] init];
//        line.frame = CGRectMake(0, ((indexPath.row == 2)?239.5:39.5), 320, 0.5); cjw
        line.frame = CGRectMake(0, 39.5, 320, 0.5);
        line.image = [UIImage imageNamed:@"line.png"];
        [cell.contentView addSubview:line];
        
        
        
        UIImageView *accessoryImg = [[UIImageView alloc] init];
        accessoryImg.frame = CGRectMake(295, 12, 15/2, 24/2);
        accessoryImg.image = [UIImage imageNamed:@"arrow_right_gray.png"];
        [cell.contentView addSubview:accessoryImg];

        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.row == 0) {
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
            imageView.image = [UIImage imageNamed:@"line.png"];
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = L(@"Product_TextImageDetail");
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = L(@"DJ_Good_BaseInfo");
        }
        else if (indexPath.row == 3)
        {
            if (IsStrEmpty(self.zixunCountStr)) {
                cell.textLabel.text = L(@"UserFeedBack_Consult");
            }else
                cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",L(@"UserFeedBack_Consult"),self.zixunCountStr];
            
        }
        else
        {
            //评价数量
            if (IsStrEmpty(self.appariseNumStr)) {
                cell.textLabel.text = L(@"Product_Comment");
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",L(@"Evaluate"),self.appariseNumStr];//@"评价";
            }
//            //好评率
//            if (IsStrEmpty(self.goodRate)) {
//                UILabel *goodAppariseLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 3, 85, 30)];
//                goodAppariseLabel.textAlignment = UITextAlignmentRight;
//                goodAppariseLabel.font = [UIFont systemFontOfSize:12];
//                goodAppariseLabel.textColor = [UIColor orange_Light_Color];
//                goodAppariseLabel.text = [NSString stringWithFormat:@"%@:0%%",L(@"Product_GoodCommentsRate")];
//                [cell.contentView addSubview:goodAppariseLabel];
//            }
//            else
//            {
//                UILabel *goodAppariseLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 3, 85, 30)];
//                goodAppariseLabel.textAlignment = UITextAlignmentRight;
//                goodAppariseLabel.font = [UIFont systemFontOfSize:12];
//                goodAppariseLabel.textColor = [UIColor orange_Light_Color];
//                goodAppariseLabel.text = [NSString stringWithFormat:@"%@:%@%%",L(@"Product_GoodCommentsRate"),self.goodRate];
//                [cell.contentView addSubview:goodAppariseLabel];
//            }
        }
        
        return cell;

    }
    else if ([cellType isEqualToString:@"ProductSellerEvaluation_Cell"])     //卖家评价
    {
        NProDetailFiveCell *cell = (NProDetailFiveCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NProDetailFiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
            
            [cell.OnlineServiceBtn addTarget:self action:@selector(OnlineServiceAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.GoToShopBtn addTarget:self action:@selector(GoToShopBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        [cell setNProDetailFiveCellInfo:self.productBase WithChatStatus:chatServiceStatus];
        
        if(!self.isLoadDetail)
        {
            cell.shopView.image = nil;
            cell.sellerSpeedView.image = nil;
            cell.serviceSatisfyView.image = nil;
            
            cell.serviceSatisfyDetailLbl.text = @"";
            cell.sellerSpeedDetailLbl.text = @"";
            cell.shopDetailLbl.text = @"";
        }
        cell.clipsToBounds = YES;
        
        return cell;

    }
    else if ([cellType isEqualToString:@"ProductSeller_Cell"])     //卖家列表入口
    {
        NProDetailShopExitCell *cell = (NProDetailShopExitCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NProDetailShopExitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        }
        [cell setNProDetailShopExitCellInfo:self.productBase];
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductRecomm_Cell"])     //推荐商品
    {
        NProDetailRecommendCell *cell = (NProDetailRecommendCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if(cell == nil)
        {
            cell = [[NProDetailRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            UIView *backView = [[UIView alloc] init];
            backView.frame = cell.bounds;
            backView.backgroundColor = RGBCOLOR(242, 242, 242);
            
            cell.backgroundView = backView;
            
        }
        
        int row = indexPath.row;
        int count;
        
        RecommendListDTO *leftDto = nil;
        RecommendListDTO *centerDto = nil;
        RecommendListDTO *rightDto = nil;
        
        if (!IsArrEmpty(self.recommendListArr)) {
            count = [self.recommendListArr count];
            
            if (row*3 < count) {
                leftDto = [self.recommendListArr objectAtIndex:row*3];
            }
            
            if (row*3+1 < count) {
                centerDto = [self.recommendListArr objectAtIndex:row*3+1];
            }
            
            if (row*3+2 < count) {
                rightDto = [self.recommendListArr objectAtIndex:row*3+2];
            }
        }
        
        [cell setItem:leftDto centerItem:centerDto rightItem:rightDto withTag:row];
        
        cell.clipsToBounds = YES;
        
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductSection_Cell"])     //透明section
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        }
        
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
    
    
    [self consultation];
    if ([cellType isEqualToString:@"ProductSeller_Cell"])     //供应商列表入口
    {
        SellerListViewController *vc = [[SellerListViewController alloc] init];
        vc.productDTO = self.productBase;
        
        __weak ProductDetailViewController *weakSelf = self;
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121309"], nil]];
        vc.selectedBlock = ^(NSString *shopCode){
            
            weakSelf.productBase.shopCode = shopCode;
            
            [weakSelf refreshData];
            self.bottomNavBar.hidden = YES;
            self.bottomNavBar.top = self.view.bounds.size.height + self.view.bounds.origin.y;
            [weakSelf reloadTableView];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cellType isEqualToString:@"ProductCu_Cell"])      //商品簇
    {
        if (self.isAllLoaded)
        {
            //1:从立即购买进商品簇;2:从加入购物车进商品簇;3:点击商品簇进入
            [self selectColorOrSizeOrNum:3];
        }
    }
    else if ([cellType isEqualToString:@"ProductBasicInfo_Cell"])   //商品基本信息
    {
        self.lastTabView.type = self.type;
        if (self.type == NormalProduct) {
            self.lastTabView.appariseNumStr = self.appariseNumStr;
            self.lastTabView.selectTye = indexPath.row;
            
            [self.navigationController pushViewController:self.lastTabView animated:YES];
        }
//        else if (self.type == PurchuseProduct || self.type == GroupProduct || self.type == BigSaleProduct || self.type == AppointmentProduct)
        else
        {
            self.lastTabView.appariseNumStr = self.appariseNumStr;
            self.lastTabView.selectTye = indexPath.row;
//            if (self.type == PurchuseProduct) {
//                self.lastTabView.calculagraph = self.calculagraph;
//            }else if(self.type == GroupProduct){
//                
//                self.lastTabView.groupBuyCalculagraph = self.calculagraph;
//            }else if(self.type == BigSaleProduct)
//            {
//                self.lastTabView.bigSaleCalculagraph = self.calculagraph;
//            }else
//            {
//                self.lastTabView.appointmentCalculagraph = self.calculagraph;
//            }
            [self.navigationController pushViewController:self.lastTabView animated:YES];
        }
        if (indexPath.row == 0)
        {
            //[self.lastTabView changeTitle:L(@"Product_TextImageDetail")];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121304"], nil]];
        }
        else if (indexPath.row == 1) {
            //[self.lastTabView changeTitle:L(@"DJ_Good_BaseInfo")];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121305"], nil]];
        }
        else if (indexPath.row == 2)
        {
            //[self.lastTabView changeTitle:L(@"Product_EvaluateAndDisOrder")];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121307"], nil]];
        }
        else if (indexPath.row == 3)
        {
            //[self.lastTabView changeTitle:L(@"UserFeedBack_Consult")];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121306"], nil]];
        }
        
    }
    else if ([cellType isEqualToString:@"SpotSupported_Cell"])   //附近现货
    {
        NearbySpotViewController *vc = [[NearbySpotViewController alloc] init];
        vc.productBase = self.productBase;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[NProDetailFirstCell class]])
    {
        [[cell superview] sendSubviewToBack:cell];
    }
    else
    {
        [[cell superview] bringSubviewToFront:cell];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        CGFloat offSetY = scrollView.contentOffset.y;
        CGFloat picViewHeight = self.firstView.proImagesScroll.height;
        CGFloat visiblePicHeight = self.firstView.frame.size.height - self.tableView.contentOffset.y;
        if (visiblePicHeight > 0)
        {
            //商品图片展示
            self.firstView.proImagesScroll.frame = CGRectMake(0, (visiblePicHeight-picViewHeight)/2 + offSetY, picViewHeight, picViewHeight);
            
            if (visiblePicHeight < 230) {
                self.firstView.clipsToBounds = YES;
            }else{
                self.firstView.clipsToBounds = NO;
            }
        }
        //展示固定在线客服按钮
        if (offSetY > 200) {
            [UIView animateWithDuration:0.5 animations:^{
                self.onlineServiceBtn.transform = CGAffineTransformMakeTranslation(-self.onlineServiceBtn.width, 0);
            }];
//            self.onlineServiceBtn.hidden = NO;
        }
        else{
//            self.onlineServiceBtn.hidden = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.onlineServiceBtn.transform = CGAffineTransformIdentity;
            }];
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (CGFloat)labelHeight:(NSString*)str WithFont:(UIFont*)font WithWidth:(float)width
{
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    CGSize sizeOneLine = [@"1" sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(291, MAXFLOAT)];
    
    
    if(size.height >= sizeOneLine.height)
    {
        return size.height + sizeOneLine.height;
    }
    else
    {//一行
        return 15;
    }
    
}

#pragma mark cells 卖点回调
- (void)foldBtnActionDetagete:(BOOL)isFold
{
    _isFold = YES;
    
//    [self.tableView reloadData];
    [self reloadTableView];
}

//在线客服入口
- (void)OnlineServiceAction:(id)sender
{
    DLog(@"在线客服入口 OnlineServiceAction");
    if (self.productBase.isCShop)
    {
        [self contactCShop];
    }
    else
    {
        [self contactSNShop];
    }
}

//进入店铺入口
- (void)GoToShopBtnAction:(id)sender
{
    //    DLog(@"进入店铺入口 GoToShopBtnAction");
    
    //    NSString *str = [NSString stringWithFormat:@"%@/%@",kMHostAddressForHttp,self.productBase.shopCode?self.productBase.shopCode:@""];
    
    //    NSString *str = [NSString stringWithFormat:@"%@/%@?storeId=%@&shopId=%@",@"http://mpre.cnsuning.com/webapp/wcs/stores/servlet",@"SNMWCshopInfoView",@"10052",@"70055307"];
    
    
    
    
    NSString *mutableStr = self.productBase.shopCode;
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121308"], nil]];
    
//    if(self.productBase.shopCode.length != 10)
//    {
//        mutableStr = [NSString stringWithFormat:@"00%@",mutableStr];
//    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@.html?client=app",kMHostAddressForHttp,mutableStr?mutableStr:@""];
//    url = @"http://shop.mpre.cnsuning.com/70055338.html?client=app";
    NSString *shopCode = self.productBase.shopCode?self.productBase.shopCode:@"";
    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCShop attributes:@{@"url": url, @"shopId": shopCode}];
    [self.navigationController pushViewController:vc animated:YES];
}

//弹出商品簇
-(void)selectColorOrSizeOrNum:(NSInteger)toCarType
{
    if (toCarType != 1)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121303"], nil]];
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIApplication sharedApplication].appDelegate.window.size.width, [UIApplication sharedApplication].appDelegate.window.size.height), YES, 0);
    [[UIApplication sharedApplication].appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    [self.arrayScreenshot addObject:viewImage];
    
    self.cuView.applicationImageView.image = viewImage;
    
    if (!toCarType) {
        toCarType = 0;
    }
    self.cuView.addToCarType = toCarType;
    self.cuView.type = self.type;
    if (self.type == PurchuseProduct) {
        self.cuView.panicDTO = self.panicDTO;
        self.cuView.isLoadPurchase = self.isLoadPurchase;
        self.cuView.calculagraph = self.calculagraph;
    }else if (self.type == GroupProduct)
    {
        self.cuView.detailDto = self.detailDto;
        self.cuView.groupBuyCalculagraph = self.calculagraph;
    }
    [self.cuView refreshView:self.productBase];
    [self.cuView showCuView];
    [self.navigationController.view addSubview:self.cuView];
    
    self.isShowingCuView = YES;
    _isProductCuViewShow = YES;
    
}

//选择推荐商品
- (void)cellImageDidClicked:(DataProductBasic *)dto RecommendListDTO:(RecommendListDTO *)aRecommendListDTO
{
    DLog(@"here clicked");
    if ([SNSwitch isSuningBISDKOn]&&[self.recommendListArr count])
    {
        int i = 0;
        NSString* tempI = nil;
        for (;i < [self.recommendListArr count];++i)
        {
            RecommendListDTO *tempDto = (RecommendListDTO *)[self.recommendListArr objectAtIndex:i];
            if ([tempDto.sugGoodsId  isEqualToString:aRecommendListDTO.sugGoodsId])
            {
                tempI = [NSString stringWithFormat:@"1-%d",i+1];
                break;
            }
        }
        /*
         推荐商品：recommendation
         1. 页面类型：pagetype
         2. 主商品编码：productid
         3. 模块名称：module
         4. 位置名称：position
         5. 图片/文字：picortext
         6. 供应商编码：recstoreid
         7. 推荐商品编码：recproductid
         8. 数据来源：recsource
         */
        NSString* str = @"null";
        if (self.productBase.productCode)
        {
            str = [self.productBase.productCode substringFromIndex:9];
        }
        
        NSString* strGoodsCode = @"null";
        if (aRecommendListDTO.sugGoodsCode)
        {
            strGoodsCode = [aRecommendListDTO.sugGoodsCode substringFromIndex:9];
        }
        
        NSString* strVendorId = @"null";
        if (aRecommendListDTO.vendorId)
        {
            strVendorId = aRecommendListDTO.vendorId;
        }
        
        NSString* strHandwork = @"null";
        if (aRecommendListDTO.handwork)
        {
            strHandwork = aRecommendListDTO.handwork;
        }
        [SSAIOSSNDataCollection CustomEventCollection:@"recommendation" keyArray: [NSArray arrayWithObjects:@"pagetype", @"productid", @"module",@"position",@"picortext",@"recstoreid",@"recproductid",@"recsource", nil]valueArray: [NSArray arrayWithObjects:@"prd", str,@"recbuybuy",tempI,@"p",strVendorId,strGoodsCode,strHandwork, nil]];
    }
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    controller.productType = RecommendListProduct;
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
}

#pragma mark -
#pragma mark 数量选择
-(void)valueChange:(NSUInteger)number
{
    self.productBase.quantity = number;
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121601"], nil]];
    //    proNum = number;
}

-(void)overSide{
    
    [self presentSheetOnNav:L(@"product_AmountOverFlow")];
    
}
#pragma mark -
#pragma mark 商品簇代理方法

-(void)removeProductCuview
{
    self.isShowingCuView = NO;
    
    //    [self.tableView reloadData];
    [self reloadTableView];
}

//商品簇选择通子码
-(void)selectCu:(DataProductBasic *)productDto{
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.bottomNavBar.hidden = YES;
    
    productDto.shopCode = nil;
    
    [self.proDetailService beginGetProductDetailInfo:productDto];
    
    if ([UserCenter defaultCenter].isLogined) {
        [self.collectService sendDetailCollectService:productDto];
    }
}

//商品簇跳购物车
- (void)goToShopCart
{
    ShopCartV2ViewController *vc = [[ShopCartV2ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isNeedBackItem = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//商品簇跳加入购物车
-(void)addtoCar:(BOOL)isSelectColor
{
    _isProductCuView = YES;
    
    [self addToCar];
}

//商品簇跳立即购买、我要抢、我要团
-(void)buyNow{
    [self.cuView hideCuView];
    if (NormalProduct == self.type || BigSaleProduct == self.type) {
        
        [self goToNextView:1];
    }
    else if (PurchuseProduct == self.type)
    {
        [self checkLoginWithLoginedBlock:^{
            [self joinPanicPurchase];
        } loginCancelBlock:NULL];
    }
    else if (GroupProduct == self.type)
    {
        [self checkLoginWithLoginedBlock:^{
            [self joinGroup];
        } loginCancelBlock:NULL];
        
    }
    else if (AppointmentProduct == self.type)
    {
        [self checkLoginWithLoginedBlock:^{
            [self appointmentAction];
        } loginCancelBlock:NULL];
    }
}

//点击商品图片查看大图
- (void)didTouchNDetailHeadImageAtIndex:(NSInteger)index
                        withSmallImages:(NSArray *)imageUrls
                           andBigImages:(NSArray *)bigImageUrls
{
    NSMutableArray *sourceArr = [[NSMutableArray alloc] initWithCapacity:[bigImageUrls count]];
    for (NSURL *url in bigImageUrls)
    {
//        MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:url];
//        [sourceArr addObject:photo];
        [sourceArr addObject:url];
    }
    
    self.imageScrollView.imageSourceArr = sourceArr;
    self.imageScrollView.myPageControl.currentPage = index;
    
    [self.imageScrollView showBigImage];
    
    [self.imageScrollView.imageScrollView scrollRectToVisible:CGRectMake(320*index, 0, 320, 320) animated:NO];
    
    [self.navigationController.view addSubview:self.imageScrollView];
}


#pragma mark ----------------------------- 在线客服

- (void)getOnlineServiceStatus
{
    //重置状态为不展示
    chatServiceStatus = OSShowStatusNone;
    
    __weak ProductDetailViewController *weakSelf = self;
    
    OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initWithDataProduct:self.productBase];
    
    [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
        
        ProductDetailViewController *self = weakSelf;
        OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
        if (__cmd.onlineStatus >= -1)
        {
            self->chatServiceStatus = [OSGetStatusCommand getShowStatusFromStatus:__cmd.onlineStatus ShopType:__cmd.shopType IsPreSale:YES];
            
            //四级页展示固定在线客服按钮
            if (chatServiceStatus != OSShowStatusNone) {
                [self.view addSubview:self.onlineServiceBtn];
            }
            [self reloadTableView];
        }
        
    }];
    
    
}

- (void)contactSNShop
{
    //b2c客服
    [self checkLoginWithLoginedBlock:^{
        /**
         *  厂送商品判断，通过factorySendFlag和vendorCode综合判断
         *  @author liukun
         *  @since 2.4.1
         */
        if (self.productBase.factorySendFlag && self.productBase.vendorCode.length)
        {
            if (chatServiceStatus == 1)
            {
                OSChatViewController *vc = [[OSChatViewController alloc] initAsAShop:self.productBase.thirdCategoryId GroupMember:self.productBase.vendorCode ClassCode:self.productBase.catentryIds productName:self.productBase.productName productCode:self.productBase.productCode];
                vc.vendorName = self.productBase.vendorName;
                AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
                [self presentModalViewController:nav animated:YES];
            }
            else
            {
                OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithAGroupMember:self.productBase.vendorCode vendorName:self.productBase.vendorName classCode:self.productBase.catentryIds ProductCode:self.productBase.productCode ProductName:self.productBase.productName OrderId:nil];
                AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
                [self presentModalViewController:nav animated:YES];
            }
        }
        else
        {
            OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CShop:self.productBase.thirdCategoryId productName:self.productBase.productName productCode:self.productBase.productCode];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
    } loginCancelBlock:nil];
}

- (void)contactCShop
{
    [self checkLoginWithLoginedBlock:^{
        if (chatServiceStatus == 1)
        {
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:self.productBase.shopCode ProductName:self.productBase.productName ProductCode:self.productBase.productCode OrderNo:nil];
            vc.vendorName = self.productBase.shopName;
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
        else
        {
            OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithShopCode:self.productBase.shopCode ShopName:self.productBase.shopName ProductCode:self.productBase.productCode ProductName:self.productBase.productName OrderId:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
            
        }
    } loginCancelBlock:nil];
}

#pragma mark - Method not implemented in protocol

- (void)touchImages {}
- (void)viewChangeWithType:(BtnSelectTypeCell)type {}
- (void)didChooseShareWay:(SNShareType)shareWay {}
- (void)activetyBtnAction {}


#pragma mark -
#pragma mark ------------ 抢团购 ------------

-(void)setStateStr:(NSString *)stateStr{
    
    _stateStr = stateStr;
    
    if (self.buyNowBtn.enabled) {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateNormal];
    }else {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateDisabled];
    }
    
}

-(void)setTimeStr:(NSString *)timeStr{
    
    _timeStr = timeStr;
    
    if (self.buyNowBtn.enabled) {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateNormal];
    }else {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateDisabled];
    }
}

-(void)refreshBtn
{
    self.addCarBtn.hidden = YES;
    self.buyNowBtn.hidden = YES;
    if(self.type == NormalProduct && self.isLoadDetail){
        self.addCarBtn.hidden = NO;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        if ([self isProductEnabled] || !self.isLoadDetail) {
            self.addCarBtn.enabled = YES;
            self.buyNowBtn.enabled = YES;
            
            [self.cuView btnEnable:YES];
        }
        else{
            self.addCarBtn.enabled = NO;
            self.buyNowBtn.enabled = NO;
            
            [self.cuView btnEnable:NO];
        }
        
        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateDisabled];
        }
    }
    if (self.type == BigSaleProduct && self.isLoadBigSale)
    {
        self.addCarBtn.hidden = NO;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        if ([self isBigsaleProductEnabled]) {
            self.addCarBtn.enabled = YES;
            self.buyNowBtn.enabled = YES;
            
            [self.cuView btnEnable:YES];
        }
        else{
            self.addCarBtn.enabled = NO;
            self.buyNowBtn.enabled = NO;
            
            [self.cuView btnEnable:NO];
        }
        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateDisabled];
        }
    }
    else if(self.type == ScScodeProduct)
    {
        self.addCarBtn.hidden = NO;
        self.buyNowBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        [self.addCarBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.addCarBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.addCarBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.bottomNavBar addSubview:self.addCarBtn];
        
        [self.addCarBtn setTitle:L(@"Product_BuySCode") forState:UIControlStateNormal];
        
        if (self.appointmentDto.scScodeStatus == BuyOver) {
            [self.addCarBtn setTitle:L(@"Product_BuySCode") forState:UIControlStateDisabled];
            self.addCarBtn.enabled = NO;
        }
        if ([self isProductEnabled] == NO) {
            self.addCarBtn.enabled = NO;
        }
        
    }
    else if(self.type == PurchuseProduct && self.isLoadPurchase)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.bottomNavBar addSubview:self.buyNowBtn];
        
        if (self.panicDTO.purchaseState == ReadyForSale) {
            
            self.stateStr = L(@"readyForSaleState");
            [self.buyNowBtn setTitle:L(@"readyForSaleState") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if (self.panicDTO.purchaseState == SaleOut){
            
            self.stateStr = L(@"SK without ant piece");
            [self.buyNowBtn setTitle:L(@"SK without ant piece") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
        }
        else if(self.panicDTO.purchaseState == OnSale){
            
            
            if (self.panicDTO.leftQty && 0 == [self.panicDTO.leftQty intValue]) {
                
                self.stateStr = L(@"SK without ant piece");
                [self.buyNowBtn setTitle:L(@"SK without ant piece") forState:UIControlStateDisabled];
                self.buyNowBtn.enabled = NO;
            }
            //        else if(self.panicDTO.isSale && [self.panicDTO.isSale isEqualToString:@"0"]){
            //
            //            self.stateStr = @"我要抢";
            //            self.buyNowBtn.enabled = NO;
            //        }
            else{
                
                self.stateStr = L(@"Add QuickBuy");
                [self.buyNowBtn setTitle:L(@"Add QuickBuy") forState:UIControlStateNormal];
                self.buyNowBtn.enabled = YES;
                if ([self isPurchaseProductEnabled] == NO)
                {
                    [self.buyNowBtn setTitle:L(@"Add QuickBuy") forState:UIControlStateDisabled];
                    self.buyNowBtn.enabled = NO;
                }
            }
        }
        else{
            
            self.stateStr = L(@"Product_Over");
            [self.buyNowBtn setTitle:L(@"Product_Over") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
        }
        
    }
    else if (GroupProduct == self.type && self.isLoadGroup)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.bottomNavBar addSubview:self.buyNowBtn];
        
        if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
            
            self.stateStr = L(@"Product_LeftToBegin");
            self.buyNowBtn.enabled = NO;
            
        } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
            
            self.stateStr = L(@"Add GroupBuy");
            
            self.buyNowBtn.enabled = YES;
            
        }
        else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
            
            self.stateStr = L(@"Group buy is over");
            
            self.buyNowBtn.enabled = NO;
        }
        
        if ([self isProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
        }
    }
    else if (AppointmentProduct == self.type && self.isLoadAppointment)
    {
        self.addCarBtn.hidden = YES;
        //该商品是S码商品且在购买阶段中，展示通道入口
        if (self.isScProduct == YES && self.appointmentDto.scScodeStatus == OnBuy) {
            self.addCarBtn.hidden = NO;
            self.addCarBtn.enabled = [self isProductEnabled];
        }
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.addCarBtn setTitle:L(@"Product_BuySCode") forState:UIControlStateNormal];
        [self.addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.bottomNavBar addSubview:self.buyNowBtn];
        
        if (self.appointmentDto.status == ReadyForAppointment) {
            
            self.stateStr = L(@"Product_WaitForPreOrder");
            [self.buyNowBtn setTitle:L(@"Product_WaitForPreOrder") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if (self.appointmentDto.status == OnAppointment){
            
            self.stateStr = L(@"Product_PreOrderNow");
            [self.buyNowBtn setTitle:L(@"Product_PreOrderNow") forState:UIControlStateNormal];
            self.buyNowBtn.enabled = YES;
        }
        else if(self.appointmentDto.status == ReadyForPurchase || self.appointmentDto.status == WaitPurchase){
            self.stateStr = L(@"Product_WaitForPurchase");
            [self.buyNowBtn setTitle:L(@"Product_WaitForPurchase") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if(self.appointmentDto.status == OnPurchase)
        {
            self.stateStr = L(@"Product_PurchaseNow");
            [self.buyNowBtn setTitle:L(@"Product_PurchaseNow") forState:UIControlStateNormal];
            self.buyNowBtn.enabled = YES;
        }
        else{
            
            self.stateStr = L(@"SK without ant piece");
            [self.buyNowBtn setTitle:L(@"SK without ant piece") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
        }
        
        if ([self isAppointmentProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            return;
        }

    }
}

//普通及团购商品是否可买
- (BOOL)isProductEnabled
{
    /*
     * liukun modify  12-12-06  如果商品价格小于等于0，默认也是不可买的
     */
    if (self.productBase.isCShop)
    {
        if ([self.productBase.hasStorage isEqualToString:@"Z"]) {
            return NO;
        }
        else
        {
            if (self.productBase.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    else
    {
        if ([self.productBase.hasStorage isEqualToString:@"Y"] &&
            ![self.productBase.cityCode isEqualToString:@""] &&
            [self.productBase.suningPrice doubleValue] > 0 &&
            self.productBase.isPublished)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

- (BOOL)isBigsaleProductEnabled
{
    if (self.bigsaleDto.bigSaleState == BsReadyForSale
        || self.bigsaleDto.bigSaleState == BsTimeOver
        || self.bigsaleDto.bigSaleState == BsSaleOut)
    {
        return NO;
    }
    else
    {
        return [self isProductEnabled];
    }
}

- (BOOL)isAppointmentProductEnabled
{
    if (self.appointmentDto.status == ReadyForAppointment
        || self.appointmentDto.status == ReadyForPurchase
        || self.appointmentDto.status == PurchaseTimeOver) {
        return NO;
    }
    else
    {
        if (self.appointmentDto.status == OnAppointment) {
            return YES;
        }
        else
        {
            return [self isProductEnabled];
        }
        
    }
}

//是否能抢购
- (BOOL)isPurchaseProductEnabled
{
    if(self.panicDTO.purchaseState ==  SaleOut
       || self.panicDTO.purchaseState == TimeOver)
    {
        return NO;
    }
    else
    {
        if (self.productBase.isCShop)
        {
            if (self.productBase.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            if ([self.productBase.hasStorage isEqualToString:@"Y"] &&
                ![self.productBase.cityCode isEqualToString:@""] &&
                [self.productBase.suningPrice doubleValue] > 0 &&
                self.productBase.isPublished)
            {
                BOOL isEnabled;
                
                if (self.panicDTO.purchaseState == SaleOut) {
                    isEnabled = NO;
                }else{
                    isEnabled = YES;
                }
                return isEnabled;
                
            }
            else
            {
                return NO;
            }
        }
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        if (PurchuseProduct == self.type) {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.panicDTO.purchaseState) {
                case ReadyForSale:
                {
                    leavingTime = (double)self.panicDTO.startTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case OnSale:
                {
                    leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case SaleOut:
                {
                    leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case TimeOver:
                {
                    [self setTime:leavingTime];
                    break;
                }
                default:
                    break;
            }
        }
        else if (GroupProduct == self.type)
        {
            if ([self.detailDto.startFlag isEqualToString:kNOGood] || [self.detailDto.startFlag isEqualToString:kHaveEnd]) {
                [self setTimer:0];
                return;
            }
            
            NSTimeInterval leavingTime = 0;
            
            if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                leavingTime = self.detailDto.startTimeSeconds - self.calculagraph.seconds;
                [self setTimer:leavingTime];
                
            } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                leavingTime = self.detailDto.endTimeSeconds - self.calculagraph.seconds;
                [self setTimer:leavingTime];
                
            }else if ([self.detailDto.startFlag isEqualToString:kNOGood]){
                leavingTime = self.detailDto.endTimeSeconds - self.calculagraph.seconds;
                [self setTimer:leavingTime];
                
            } else {
                [self setTimer:0];
                
                [self setTimer:leavingTime];
                
                return;
            }
            
            if (leavingTime < 1) {
                if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                    self.detailDto.startFlag = kHaveStart;
                }else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                    self.detailDto.startFlag = kHaveEnd;
                }
                
                [self setTimer:leavingTime];
                
                return;
            }
            
            [self setTimer:leavingTime];
        }
        else if (self.type == BigSaleProduct)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.bigsaleDto.bigSaleState) {
                case BsReadyForSale:
                {
                    leavingTime = (double)self.bigsaleDto.startTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsOnSale:
                {
                    leavingTime = (double)self.bigsaleDto.endTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsSaleOut:
                {
                    leavingTime = (double)self.bigsaleDto.endTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsTimeOver:
                {
                    [self setBigSaleTime:0];
                    break;
                }
                default:
                    break;
            }
        }
        else if (AppointmentProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.appointmentDto.status) {
                case ReadyForAppointment:
                {
                    leavingTime = (double)self.appointmentDto.scheduleStartTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case OnAppointment:
                {
                    leavingTime = (double)self.appointmentDto.scheduleEndTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case ReadyForPurchase:
                {
                    leavingTime = (double)self.appointmentDto.startTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case OnPurchase:
                {
                    leavingTime = (double)self.appointmentDto.endTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case PurchaseTimeOver:
                {
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case WaitPurchase:
                {
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                default:
                    break;
            }

        }
        else if (ScScodeProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            leavingTime = (double)self.appointmentDto.scEndTimeSeconds - seconds;
            [self setScScodeTime:leavingTime];
        }
    }
    else if ([keyPath isEqualToString:@"purchaseState"])
    {
        [self refreshBtn];
        
    }
}

//预约计算时间
- (void)setAppointmentTime:(double)seconds
{
    if (self.appointmentDto.status == PurchaseTimeOver) {
        [self.timView calculagraphTime:0];
        [self.timView hiddenTimeLabel:L(@"SK without ant piece")];
        return;
    }
    
    if (self.appointmentDto.status == WaitPurchase) {
        [self.timView calculagraphTime:0];
        [self.timView hiddenTimeLabel:L(@"Product_PurchaseTimeNotDecided")];
        return;
    }
    if (seconds < 1 ) {
        if (self.appointmentDto.status == ReadyForAppointment) {
            self.appointmentDto.status = OnAppointment;
            [self.timView setState:2];
            [self refreshBtn];
            return;
        }
        else if (self.appointmentDto.status == ReadyForPurchase)
        {
            self.appointmentDto.status = OnPurchase;
            [self.timView setState:4];
            [self refreshBtn];
        }
        else if (self.appointmentDto.status == OnAppointment){
            
            if (IsStrEmpty(self.appointmentDto.purchaseStarttime) || IsStrEmpty(self.appointmentDto.purchaseEndtime)) {
                self.appointmentDto.status = WaitPurchase;
                [self.timView hiddenTimeLabel:L(@"Product_PurchaseTimeNotDecided")];
                return;
            }
            self.appointmentDto.status = ReadyForPurchase;
            [self.timView setState:3];
            [self refreshBtn];
            return;
        }
        else if (self.appointmentDto.status == OnPurchase)
        {
            self.appointmentDto.status = PurchaseTimeOver;
            [self.timView hiddenTimeLabel:L(@"SK without ant piece")];
            [self refreshBtn];
            return;
        }
    }
    
    if (self.appointmentDto.status == ReadyForAppointment) {
        [self.timView calculagraphTime:seconds];
        [self.timView setState:1];
    }
    else if (self.appointmentDto.status == OnAppointment)
    {
        [self.timView calculagraphTime:seconds];
        [self.timView setState:2];
    }
    else
    {
        if(self.appointmentDto.status == ReadyForPurchase || self.appointmentDto.status == OnPurchase)
        {
            if (self.appointmentDto.status == ReadyForPurchase) {
                [self.timView setState:3];
            }else if (self.appointmentDto.status == OnPurchase)
            {
                [self.timView setState:4];
            }
            
            if (self.productBase.isCShop) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                if (self.productBase.isPublished && [[self.productBase hasStorage] isEqualToString:@"Y"]) {
                    [self.timView calculagraphTime:seconds];
                }
                else
                {
                    [self.timView calculagraphTime:0];
                    return;
                }
            }
            
        }
    }

}

//大聚惠计算时间
- (void)setBigSaleTime:(double)seconds
{
    if (self.bigsaleDto.bigSaleState == BsTimeOver) {
        [self.timView calculagraphTime:0];
        return;
    }
    
    if (seconds < 1 ) {
        if (self.bigsaleDto.bigSaleState == BsReadyForSale) {
            self.bigsaleDto.bigSaleState = BsOnSale;
            [self refreshBtn];
        }
        else if (self.bigsaleDto.bigSaleState == BsOnSale|| self.bigsaleDto.bigSaleState == BsSaleOut){
            self.bigsaleDto.bigSaleState = BsTimeOver;
            [self refreshBtn];
        }
    }
    
    if(self.bigsaleDto.bigSaleState == BsOnSale|| self.bigsaleDto.bigSaleState == BsSaleOut
        || self.bigsaleDto.bigSaleState == BsReadyForSale)
    {
        if (self.productBase.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productBase.isPublished && [[self.productBase hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
                return;
            }
        }
        
    }else{
        [self.timView calculagraphTime:0];
    }
}

- (void)appointmentStateDidChange:(NSNotification *)notification
{
    AppointmentDTO *appointmentDto = [[notification userInfo] objectForKey:@"appointmentDTO"];
    if ([appointmentDto.actionId isEqualToString:self.appointmentDto.actionId]) {
        [self refreshBtn];
    }
}

- (void)purchaseStateDidChange:(NSNotification *)notification
{
    PanicPurchaseDTO *purchaseDTO = [[notification userInfo] objectForKey:@"purchaseDTO"];
    if ([purchaseDTO.rushPurId isEqualToString:self.panicDTO.rushPurId]) {
        
        [self refreshBtn];
    }
}

//s码商品计算时间
- (void)setScScodeTime:(double)seconds
{
    if (seconds < 1) {
        if (self.appointmentDto.scScodeStatus == OnBuy || self.appointmentDto.scScodeStatus == BuyOver){
            self.appointmentDto.scScodeStatus = BuyOver;
            [self refreshBtn];
        }
    }
    
    if (self.appointmentDto.scScodeStatus == OnBuy) {
        if (self.productBase.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productBase.isPublished && [[self.productBase hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
            }
        }
    }else
    {
        [self.timView calculagraphTime:0];
    }
    
}

//抢购计算时间
- (void)setTime:(double)seconds
{
    if (self.panicDTO.purchaseState == TimeOver) {
        [self.timView calculagraphTime:seconds];
        return;
    }
    
    if (seconds < 1 && self.isLoadPurchase) {
        if (self.panicDTO.purchaseState == ReadyForSale) {
            self.panicDTO.purchaseState = OnSale;
            [self refreshBtn];
        }
        else if (self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut){
            self.panicDTO.purchaseState = TimeOver;
            self.stateStr = L(@"Product_Over");
            self.buyNowBtn.enabled = NO;
            [self.buyNowBtn setTitle:L(@"Product_Over") forState:UIControlStateDisabled];
        }
    }
    
//    NSString *timeString = nil;
    
    if(self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut
       || self.panicDTO.purchaseState == ReadyForSale)
    {
        if (self.productBase.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productBase.isPublished && [[self.productBase hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
            }
        }
    }else{
        [self.timView calculagraphTime:0];
        
    }
    
}

//团购计算时间
- (void)setTimer:(NSTimeInterval)seconds
{
    if ([self.detailDto.startFlag isEqualToString:@"3"] || [self.detailDto.startFlag isEqualToString:@"4"] || (seconds == 0)){
        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateDisabled];
        }
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.buyNowBtn.enabled = NO;
        [self.timView calculagraphTime:seconds];
        return;
    }
    
    if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
        self.stateStr = L(@"readyForSaleState");
        self.buyNowBtn.enabled = NO;
        [self.timView calculagraphTime:seconds];
        
    } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
        self.stateStr = L(@"Add GroupBuy");
        [self.timView calculagraphTime:seconds];
        self.buyNowBtn.enabled = YES;
        if ([self isProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
        }
    }
    else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
        
        self.stateStr = L(@"Group buy is over");
        [self.timView calculagraphTime:0];
        self.buyNowBtn.enabled = NO;
    }
}

#pragma mark -
#pragma mark 抢团购预约事件交互

- (void)joinPanicPurchase
{
    
    if([self isPurchaseProductEnabled] == NO)
    {
        return;
    }
    
    self.buyNowBtn.enabled = NO;
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    NSString *errorMsg = nil;
    
    BOOL canAddToShopCart = [self.shoppingCartBoard checkProductCanAddToShopCart:self.productBase
                                                                        errorMsg:&errorMsg];
    if (canAddToShopCart)
    {
        [self displayOverFlowActivityView];
        
        NSString *userId=[UserCenter defaultCenter].userInfoDTO.userId;
        
        NSString *cityCode=self.productBase.cityCode==nil?self.productBase.cityCode:[Config currentConfig].defaultCity;
        
        self.productBase.quickbuyId = self.panicDTO.rushPurId;
        
        [self.panicService beginGetPanicPurchaseLimitList:self.panicDTO.rushPurId
                                                   userId:userId
                                                   cityId:cityCode];
    }
    else
    {
        [self presentCustomDlg:errorMsg];
        self.buyNowBtn.enabled = YES;
    }
    
}

- (void)joinGroup
{
    
    if ([self.productBase.hasStorage isEqualToString:@"N"]){
        [self presentSheet:L(@"Product_ProductNotEnough")];
        self.buyNowBtn.enabled = NO;
        return;
    }else if ([self.productBase.hasStorage isEqualToString:@"Z"]){
        [self presentSheet:L(@"DJGroup_NotOnSale")];
        self.buyNowBtn.enabled = NO;
        return;
    }
    
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    self.productBase.danjiaGroupId = self.detailDto.grpPurId;
    self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
    
    NSString *errorMsg = nil;
    
    BOOL canAddToShopCart = [self.shoppingCartBoard checkProductCanAddToShopCart:self.productBase
                                                                        errorMsg:&errorMsg];
    if (canAddToShopCart)
    {
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByPhoneUnBound) {
            [self presentCustomDlg:L(@"Product_BindMobilePhoneAndBuy")];
            return;
        }
        
        [self displayOverFlowActivityView];
        DJGroupApplyDTO *applyDto = [[DJGroupApplyDTO alloc] init];
        applyDto.storeId = @"10052";
        applyDto.catalogId = @"10051";
        applyDto.groupId = self.detailDto.grpPurId;
        applyDto.catentryId = self.detailDto.catentryId;
        applyDto.amount = @"1";
        
        [self.groupApplyService beginSendDJGroupApplyRequest:applyDto];
    }
    else
    {
        [self presentCustomDlg:errorMsg];
    }
    
}

- (void)appointmentAction
{
    if (self.appointmentDto.status == OnAppointment)
    {
        NSString *productCode = self.productBase.productCode == nil ? @"" : self.productBase.productCode;
//        if (productCode.length == 18) {
//            productCode = [productCode substringFromIndex:9];
//        }
        NSString *vendorId = self.productBase.shopCode == nil ? @"" : self.productBase.shopCode;
        if (IsStrEmpty(vendorId)) {
            vendorId = @"0000000000";
        }

        NSString *str;
#ifdef kReleaseH
        str = [NSString stringWithFormat:@"%@/%@?partNumber=%@&vendorId=%@&terminal=1",kEbuyWapHostURL,@"appointment/private/toAppoint.html",productCode,vendorId];
        
#else
        str = [NSString stringWithFormat:@"%@/%@?partNumber=%@&vendorId=%@&terminal=1",kEbuyWapHostURL,@"mts-web/appointment/private/toAppoint.html",productCode,vendorId];
        
#endif
        
        SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeCommon attributes:@{@"url": str}];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (self.appointmentDto.status == OnPurchase)
    {
        [self displayOverFlowActivityView];
        [self.proDetailService beginAppointmentAction:self.productBase];
    }
}

- (void)scScodeProductBuy
{
    [self displayOverFlowActivityView];
    [self.proDetailService beginScScodeProductBuyAction:self.productBase];
}

#pragma mark -
#pragma mark ------------ 抢团购预约抢购点击事件回调 ------------

- (void)scScodeActionCompletionWithResult:(BOOL)isSuccess redirectStatus:(NSString *)redirectStatus errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (isFromScBuy == YES) {
            if ([redirectStatus isEqualToString:@"1"]) {
                [self goToNextView:1];
                return;
            }
            else if ([redirectStatus isEqualToString:@"0"])
            {
                errorMsg = L(@"Product_CheckSCodeTime");
                
            }
            else if ([redirectStatus isEqualToString:@"2"] || [redirectStatus isEqualToString:@"4"])
            {
                errorMsg = L(@"Product_SCodeIsEnd");
            }
            else if ([redirectStatus isEqualToString:@"3"])
            {
                [self goToBangding];
                return;
            }
            [self presentSheet:errorMsg];
        }
        else
        {
            if ([redirectStatus isEqualToString:@"3"])
            {
                [self goToBangding];
                return;
            }
            else if ([redirectStatus isEqualToString:@"4"])
            {
                errorMsg = L(@"Product_SCodeIsEnd");
            }
            else if ([redirectStatus isEqualToString:@"0"]||[redirectStatus isEqualToString:@"1"]||[redirectStatus isEqualToString:@"2"])
            {
                errorMsg = L(@"Product_NoRepeatBindSCode");
            }
            [self presentSheet:errorMsg];
        }
    }
    else
    {
        [self presentSheet:errorMsg];
    }
    [self reloadTableView];
}

- (void)appointmentActionCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [self goToNextView:1];
    }
    else
    {
        [self presentSheet:errorMsg];
    }
    [self reloadTableView];
}

- (void)getPanicPurchaseLimitCompletionWithResult:(BOOL)isSuccess errorCode:(NSString *)errorCode  errorMsg:(NSString*)errorMsg flag:(NSString *)flag rushProcessId:(NSString *)rushProcessId
{
    [self removeOverFlowActivityView];
    self.buyNowBtn.enabled = YES;
    if(isSuccess)
    {
        if([flag isEqualToString:@"0"])
        {
            self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.panicDTO.rushPurPrice doubleValue]];
            self.productBase.rushProcessId = rushProcessId;
            [self addtoShoppingCart2];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"joinPanicPurchase" object:nil];
            
            [self refreshBtn];
        }else{
            
            if([errorCode isEqualToString:@"2"]||[errorCode isEqualToString:@"3"]||[errorCode isEqualToString:@"5"])
            {
                [self presentSheet:L(@"panicPurchase over")];
                
            }else if([errorCode isEqualToString:@"4"])
            {
                [self presentSheet:L(@"user had panic")];
                
            }else if([errorCode isEqualToString:@"6"])
            {
                [self presentSheet:L(@"city not sale")];
                
            }else if([errorCode isEqualToString:@"1"]||[errorCode isEqualToString:@"7"]||[errorCode isEqualToString:@"8"])
            {
                [self presentSheet:L(@"sorry panic failed")];
            }
            else if([errorCode isEqualToString:@"9"]){
                
                [self presentSheet:L(@"panicPurchase not start")];
            }else if([errorCode isEqualToString:@"10"]){
                
                [self presentSheet:L(@"userId failed")];
            }else if([errorCode isEqualToString:@"11"]){
                
                [self presentSheet:L(@"panicPurchase not support client")];
            }else if([errorCode isEqualToString:@"12"]){
                
                [self presentSheet:L(@"panicPurchase not support mobile")];
            }else {
                
                if (IsNilOrNull(errorMsg)) {
                    errorMsg = L(@"sorry panic failed");
                }
                [self presentSheet:errorMsg];
            }
        }
    }else {
        
        [self presentSheet:errorMsg];
        
    }
    
    [self reloadTableView];
    
}

//点击我要团按钮后返回的数据
- (void)didSendDJGroupApplyRequestComplete:(DJGroupApplyService *)service  Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if(isSuccess)
    {
        NSString *flag = service.result;
        
        if([flag isEqualToString:@"1"])
        {
            self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
            [self addtoShoppingCart];
            
        }else {
            if([flag isEqualToString:@"2"]){
                [self presentSheet:L(@"Product_NotLogin")];
            }else if([flag isEqualToString:@"3"]){
                [self presentSheet:L(@"Product_BindMobilePhoneAndBuy")];
            }else if([flag isEqualToString:@"4"]){
                [self presentSheet:L(@"Product_NotFoundActivity")];
            }else if([flag isEqualToString:@"5"]){
                [self presentSheet:L(@"Product_GroupNotEffective")];
            }else if([flag isEqualToString:@"6"]){
                [self presentSheet:L(@"Product_BeyondTheLimit")];
            }else if([flag isEqualToString:@"7"]){
                [self presentSheet:L(@"Product_GroupNumNotEnough")];
            }else {
                [self presentSheet:L(@"Product_GroupFailed")];
            }
        }
    }else {
        
        [self presentSheet:L(@"Product_GroupFailed")];
        
    }
    [self.tableView reloadData];
}

//“我要抢”按钮
- (void)addtoShoppingCart2
{

    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121314"], nil]];
    if([self isPurchaseProductEnabled] == NO)
    {
        return;
    }
    
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        if (isSuccess) {
            
            BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:L(@"Product_PurchasePayInThirtyMinute") delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                ShopCartV2ViewController *vc = [[ShopCartV2ViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.isNeedBackItem = YES;
                [self.navigationController pushViewController:vc animated:YES];
//                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
//                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                
                [self refreshBtn];
                
            }];
        }
        else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    [self.shoppingCartBoard addProductToShoppingCart:self.productBase
                                     completionBlock:block];
    [self reloadTableView];
}

- (void)addtoShoppingCart
{
    if (nil == self.productBase || [self.productBase.hasStorage isEqualToString:@"N"])
    {
        return;
    }
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        if (isSuccess) {
            BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                              Title:L(@"system-info")
                                                            message:L(@"Product_AlreadyAddedToShopCart")
                                                         customView:nil
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Confirm")
                                                  otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                ShopCartV2ViewController *vc = [[ShopCartV2ViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.isNeedBackItem = YES;
                [self.navigationController pushViewController:vc animated:YES];
//                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
//                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                [self refreshBtn];
            }];
            
        }else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    if (self.productBase.danjiaGroupId.length == 0)
    {
        self.productBase.danjiaGroupId = self.detailDto.grpPurId;
    }
    
    if (self.productBase.danjiaGroupId.length)
    {
        [self.shoppingCartBoard addProductToShoppingCart:self.productBase
                                         completionBlock:block];
    }
    [self reloadTableView];
}

@end

