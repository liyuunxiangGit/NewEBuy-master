
//
//  HomeRootPageViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HomeRootPageViewController.h"
#import "AuthManagerNavViewController.h"

#import "CategoryViewController.h"
#import "SNReaderController.h"
#import "UserCenter.h"
#import "AddressInfoDAO.h"

#import "AdModel1ViewController.h"
#import "AdModel2ViewController.h"
#import "AdModel3ViewController.h"
#import "AdModel4ViewController.h"
#import "AdModel5ViewController.h"
#import "AdModel6ViewController.h"


#import "HomeScrollViewController.h"
#include "HotSaleViewController.h"
#import "LotteryHallViewController.h"
#import "ServiceStackViewController.h"

#import "PurchaseViewController.h"
#import "PurchaseProductListViewController.h"
//新团购
#import "GBListViewController.h"
//榜单
#import "SNSpecialListViewController.h"

#import "PromotionInfoViewController.h"
#import "FXLabel.h"
#import "PromotionInfoService.h"

//#import "VirtualProductViewController.h"
#import "MobileRechargeViewController.h"

#import "BusinessTravelRootViewController.h"

#import <objc/runtime.h>
#import "AuthNavigationBar.h"

#import "ServiceTrackListViewController.h"
#import "AutoLoginCommand.h"

#import "BrowsingHistoryViewController.h"
#import "SuningFamilyViewController.h"
#import "MyFavoriteViewController.h"

#import "SweepstakesViewController.h"
//#import "WaterElectricityGasViewController.h"
#import "BBSideBarViewController.h"
#import "GBCityListViewController.h"
#import "NearbySuningViewController.h"

//add by zj search
#import "SearchViewController.h"
#import "NewSearchViewController.h"
#import "SearchParamDTO.h"
#import "SearchListViewController.h"
#import "SolrSearchHistoryDAO.h"

#import "UserFeedBackPreViewController.h"
#import "DJGroupListViewController.h"

//add by wangjiaxing PaymentCenter
#import "PaymentCenterViewController.h"

//#import "WebModelViewController.h"

@interface HomeRootPageViewController()

@property (nonatomic, strong) SNReaderController *readerController;

@property (nonatomic, strong) NSArray              *topBannerList;

@property (nonatomic, strong) NSTimer              *topImageChangeTimer;


- (void)startTimer;

- (void)endTimer;

- (void)addNotifications;

- (void)sendPromotionInfoHttpRequest;

- (void)launchMailAppOnDevice;

- (void)sendMail;

- (NSString *)switchSearchwords;

@end

/*********************************************************************/

@implementation HomeRootPageViewController

@synthesize superViewController = _superViewController;
@synthesize readerController = _readerController;

@synthesize eightBannerAdService = _eightBannerAdService;
@synthesize topBannerList = _topBannerList;
@synthesize topImageChangeTimer = _topImageChangeTimer;

@synthesize promotionInfoService =_promotionInfoService;
@synthesize homeSearchView   = _homeSearchView;
@synthesize categoryService = _categoryService;

- (void)dealloc {
    TT_RELEASE_SAFELY(_homeSearchView);    
    TT_RELEASE_SAFELY(_homeView);
    
    SERVICE_RELEASE_SAFELY(_eightBannerAdService);
    SERVICE_RELEASE_SAFELY(_promotionInfoService);
    
    TT_RELEASE_SAFELY(_topBannerList);
    TT_RELEASE_SAFELY(_topImageChangeTimer);
    TT_RELEASE_SAFELY(_categoryService);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"home");
        self.pageTitle = L(@"show_homePage");
        [AppDelegate currentAppDelegate].homeViewController = self;
    }
    return self;
}
- (CategoryService *)categoryService{
    
    
    if (!_categoryService) {
        
        _categoryService = [[CategoryService alloc] init];
        
        _categoryService.delegate = self;
    }
    return _categoryService;
}

- (HomeSearchController *)homeSearchView
{
    if (!_homeSearchView) {
        _homeSearchView = [[HomeSearchController alloc] initWithContentController:self.superViewController];
        
        _homeSearchView.delegate = self;
    }
    return _homeSearchView;
}

- (EightBannerADService *)eightBannerAdService
{
    if(!_eightBannerAdService)
    {
        _eightBannerAdService = [[EightBannerADService alloc] init];
        _eightBannerAdService.delegate = self;
    }
    return _eightBannerAdService;
}


- (PromotionInfoService *)promotionInfoService
{
    if (!_promotionInfoService) 
    {
        _promotionInfoService = [[PromotionInfoService alloc] init];
       
        _promotionInfoService.delegate = self;
    }
    return _promotionInfoService;
}

- (NSArray *)topBannerList
{
    if(!_topBannerList)
    {
        _topBannerList = [[NSArray alloc] init];
    }
    return _topBannerList;
}


#pragma mark -
#pragma mark EightBannerADServiceDelegate

- (void)service:(EightBannerADService *)service requestEightBannerComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }
    
    if (isSuccess)
    {
        //图片预加载
        for (HomeTopScrollAdDTO *dto in service.topBannerList)
        {
            if (dto.bigImageURL) {
                NSURL *imageUrl = [NSURL URLWithString:dto.bigImageURL];
                [EGOImageLoader preloadImageURL:imageUrl];
            }
        }
        
        isEightBannerLoaded = YES;
        [_homeView.topBannerView updateTopBanner:service.topBannerList];
        
        self.topBannerList = service.topBannerList;
        //刷新完成，重启timer
        [self startTimer];
    }
    else
    {
        //在无网络或加载失败的情况下，默认展示缓存中的八联版
        NSArray *oldList = [Config currentConfig].topAdList;
        if ([oldList count] > 0 && [[oldList objectAtIndex:0] isKindOfClass:[HomeTopScrollAdDTO class]])
        {
            [_homeView.topBannerView updateTopBanner:oldList];
        }
    self.topBannerList = oldList;
    }

    self.eightBannerAdService = nil;
}

//去八联版页面
- (BOOL)jumpToBannerView:(NSInteger)index
{
    NSArray *bannerList = _homeView.topBannerView.topBannerList;
    if (!bannerList || index >= [bannerList count]) {
        
        return NO;
        
    }else{
        HomeTopScrollAdDTO *dto = [bannerList objectAtIndex:index];
        if ([dto isKindOfClass:[HomeTopScrollAdDTO class]]) {
            [self didClickAd:dto];
        }
    }
    
    return YES;
}


-(void)addSweepstake
{
    NSString* sweepSwitchvalue = [[[GlobalDataCenter defaultCenter] activitySwitchMap] objectForKey:@"springfestival"];
    if([sweepSwitchvalue isEqualToString:@"1"])
    {
        if (!sweepSwitch) {
            sweepSwitch = YES;
            
            NSMutableArray *insertion = [[NSMutableArray alloc] init];
            [insertion addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
            
            [_homeView.tableView beginUpdates];
            [_homeView.tableView reloadRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationFade];
            [_homeView.tableView endUpdates];
        }

    }else
    {
        if (sweepSwitch) {
            sweepSwitch = NO;
            NSMutableArray *insertion = [[NSMutableArray alloc] init];
            [insertion addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
            
            [_homeView.tableView beginUpdates];
            [_homeView.tableView reloadRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationFade];
            [_homeView.tableView endUpdates];
        }
    }
    
    _homeView.searchBar.placeholder= [self switchSearchwords];
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    _homeView = [[HomeRootView alloc] initWithOwner:self];
    self.view = _homeView;
    self.tableView = _homeView.tableView;
    [self.tableView addSubview:self.refreshHeaderView];
    
    [self addNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //更新地址
    [AddressInfoDAO isUpdateAddressOk];
    
    //自动登录
    AutoLoginCommand *loginCmd = [AutoLoginCommand command];
    [CommandManage excuteCommand:loginCmd observer:nil];
    
    [self performSelector:@selector(addSweepstake) withObject:nil afterDelay:1.2];
    
}

- (void)viewAppear
{
    [super viewWillAppear:NO];
    
    if (!isEightBannerLoaded)
    {
        [self refreshData];
    }
    
    if (!isPromotionInfoLoaded) {
        [self sendPromotionInfoHttpRequest];
    }
    
    if (!isCategoryLoaded) {
        
        [self.categoryService sendCategoryRequest:kCategoryEnmuElec];
    }
    
    _homeView.searchBar.placeholder = [self switchSearchwords];
    
    [self startTimer];
    
}

- (void)viewDisappear
{
    [super viewWillDisappear:NO];
    [self endTimer];

}


- (void)viewWillAppear:(BOOL)animated
{
    //使用其他方案进行数据收集，所以不用super了,需要保留此方法
    //[super viewWillAppear:animated];
    //do nothing
}

- (void)viewWillDisappear:(BOOL)animated
{
    //使用其他方案进行数据收集，所以不用super了, 需要保留此方法
    //[super viewWillDisappear:animated];
    //do nothing
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    _homeView.searchBar.placeholder= [self switchSearchwords];
}

#pragma mark -
#pragma mark 定时器

- (void)startTimer
{
    if (!_topImageChangeTimer || ![_topImageChangeTimer isValid])
    {
        
        self.topImageChangeTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                                    target:self 
                                                                  selector:@selector(changeTopImage) 
                                                                  userInfo:nil 
                                                                   repeats:YES];
    }
}

#pragma mark -
#pragma mark Advertise Timer Delegate
- (void)advertisementView:(EightBannerView *)advertisementView willChangeDragState:(ScrollDragState)dragState
{
    // 手动拖动图片时，停止定时器
    if (dragState == ScrollDragBegin)
    {
        TT_INVALIDATE_TIMER(_topImageChangeTimer);
    }
    else    // 释放时，重新开始计时
    {
        [self startTimer];
    }
}

- (void)endTimer
{
    TT_INVALIDATE_TIMER(_topImageChangeTimer);
}

- (void)changeTopImage
{
    [_homeView.topBannerView changePage:nil];
}

#pragma mark -
#pragma mark notification

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStateChange:) name:UIApplicationWillResignActiveNotification object:[NSNumber numberWithBool:NO]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStateChange:) name:UIApplicationDidBecomeActiveNotification object:[NSNumber numberWithBool:YES]];
    
//    //监听活动开关的值变化
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSweepstake) name:SNActivitySwitchDidChangeNotification object:nil];
}

- (void)appStateChange:(NSNotification *)notification
{
    if (!isEightBannerLoaded)
    {
        [self refreshData];
    }
    
    if (!isPromotionInfoLoaded)
    {
        [self sendPromotionInfoHttpRequest];
    }
    
    BOOL isActive = [[notification object] boolValue];
    
    if (!isActive) 
    {
        [self endTimer];
    }
    else
    {
        UITabBarController *tabBarController = [AppDelegate currentAppDelegate].tabBarViewController;
        UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
        UIViewController *visibleViewController = navigationController.visibleViewController;
        
        if (tabBarController.selectedIndex == 0 
            && [visibleViewController isKindOfClass:[HomeScrollViewController class]]
            && [(HomeScrollViewController *)visibleViewController currentPage] == 0)
        {
            [self startTimer];
        }
    }
}
#pragma mark -
#pragma mark Data Service DelegateMethods

- (void)service:(CategoryService *)service loadCateComplete:(BOOL)isSuccess
{
        
    isCategoryLoaded = YES;
}
#pragma mark -
#pragma mark  EightBannerImagePageCellClickDelegate
- (void)cycleScrollViewDelegate:(EightBannerView *)cycleScrollView didSelectImageView:(int)index
{    
    if (![self.topBannerList count] || !self.topBannerList)
    {
        return;
    }
    
    HomeTopScrollAdDTO *dto = [self.topBannerList objectAtIndex:index-1];
    
    int modelType = [dto.model intValue];
    
    if (dto.backgroundURL !=nil && ![dto.backgroundURL isEqualToString:@""]) {
        
        AdModel1ViewController *recommendViewController = [[AdModel1ViewController alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dto.backgroundURL]]];
        
        recommendViewController.activeName = dto.activeName;
        
        [self.navigationController pushViewController:recommendViewController animated:YES];
        TT_RELEASE_SAFELY(recommendViewController);
    }
    else
    {
        switch (modelType) {
                
            case 1:{
                
                AdModel1ViewController *recommendViewController = [[AdModel1ViewController alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dto.innerImageURL]]];                
                recommendViewController.activeName = dto.activeName;
                
                [self.navigationController pushViewController:recommendViewController animated:YES];
                TT_RELEASE_SAFELY(recommendViewController);
                
            }
                break;
                
                
            case 2:{
                
                AdModel2ViewController *controller = [[AdModel2ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                
                controller.activeName = dto.activeName;
                
                controller.activeRule = dto.activeRule;
                
//                if(IsStrEmpty(dto.innerImageURL)){
//
//                    controller.activeInnerImageUrl = dto.bigImageURL;
//                    
//                }else{
                    
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
//                }
                
                [self.navigationController pushViewController:controller animated:YES];
                
                TT_RELEASE_SAFELY(controller);
                
            }
                break;
                
                
            case 3:{
                
                AdModel3ViewController *controller = [[AdModel3ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                controller.activeName = dto.activeName;
                controller.activeRule = dto.activeRule;
//                if(IsStrEmpty(dto.innerImageURL)){
//                    
//                    controller.activeInnerImageUrl = dto.bigImageURL;
//                    
//                }else{
                
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
//                }

                [self.navigationController pushViewController:controller animated:YES];
                TT_RELEASE_SAFELY(controller);
                
            }
                break;
                
            case 4:{
                
                AdModel4ViewController *controller = [[AdModel4ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                controller.activeName = dto.activeName;
                controller.activeRule = dto.activeRule;
                controller.activeInnerImageUrl = dto.innerImageURL;
                [self.navigationController pushViewController:controller animated:YES];
                TT_RELEASE_SAFELY(controller);
                
            }
                break;
                
            case 5:{
                
                AdModel5ViewController *controller = [[AdModel5ViewController alloc] init];
                
                controller.define = dto.define;
                controller.activeName = dto.activeName;
                
                [self.navigationController pushViewController:controller animated:YES];
                
                TT_RELEASE_SAFELY(controller);
                
            }
                break;
                
            case 6:{
                
                AdModel6ViewController *controller = [[AdModel6ViewController alloc] initWithAdvertiseId:dto.advertiseId];
                
//                if(IsStrEmpty(dto.innerImageURL)){
//                    
//                    controller.activeInnerImageUrl = dto.bigImageURL;
//                    
//                }else{
                
                    controller.activeInnerImageUrl = dto.innerImageURL;
                    
//                }
                
                controller.activeName = dto.activeName;
                controller.activeRule = dto.activeRule;

                [self.navigationController pushViewController:controller animated:YES];
                
                TT_RELEASE_SAFELY(controller);
            }
                break;

                
            default:
                
                break;
                
        }

    }
}

- (void)didClickAd:(HomeTopScrollAdDTO *)dto
{
    int modelType = [dto.model intValue];
    
    switch (modelType) {
            
        case 1:{
            
            AdModel1ViewController *recommendViewController = [[AdModel1ViewController alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dto.innerImageURL]]];
            
            recommendViewController.activeName = dto.activeName;
            
            [self.navigationController pushViewController:recommendViewController animated:YES];
            TT_RELEASE_SAFELY(recommendViewController);
            
        }
            break;
            
            
        case 2:{
            
            AdModel2ViewController *controller = [[AdModel2ViewController alloc] initWithAdvertiseId:dto.advertiseId];
            
            controller.activeName = dto.activeName;
            
            controller.activeRule = dto.activeRule;
            
//            if(IsStrEmpty(dto.innerImageURL)){
//                
//                controller.activeInnerImageUrl = dto.bigImageURL;
//                
//            }else{
            
                controller.activeInnerImageUrl = dto.innerImageURL;
                
//            }
            
            [self.navigationController pushViewController:controller animated:YES];
            
            TT_RELEASE_SAFELY(controller);
            
        }
            break;
            
            
        case 3:{
            
            AdModel3ViewController *controller = [[AdModel3ViewController alloc] initWithAdvertiseId:dto.advertiseId];
            controller.activeName = dto.activeName;
            controller.activeRule = dto.activeRule;
            controller.activeInnerImageUrl = dto.innerImageURL;
            [self.navigationController pushViewController:controller animated:YES];
            TT_RELEASE_SAFELY(controller);
            
        }
            break;
            
        case 4:{
            
            AdModel4ViewController *controller = [[AdModel4ViewController alloc] initWithAdvertiseId:dto.advertiseId];
            controller.activeName = dto.activeName;
            controller.activeRule = dto.activeRule;
            controller.activeInnerImageUrl = dto.innerImageURL;
            [self.navigationController pushViewController:controller animated:YES];
            TT_RELEASE_SAFELY(controller);
            
        }
            break;
            
        case 5:{
            
//            AdModel5ViewController *controller = [[AdModel5ViewController alloc] init];
            
            AdModel5ViewController *controller = [[AdModel5ViewController alloc] initWithAdvertiseId:dto.advertiseId];
            controller.define = dto.define;
            controller.activeName = dto.activeName;
            
            [self.navigationController pushViewController:controller animated:YES];
            
            TT_RELEASE_SAFELY(controller);
            
        }
            break;
            
        case 6:{
            
            AdModel6ViewController *controller = [[AdModel6ViewController alloc] initWithAdvertiseId:dto.advertiseId];
            
//            if(IsStrEmpty(dto.innerImageURL)){
//                
//                controller.activeInnerImageUrl = dto.bigImageURL;
//                
//            }else{
            
                controller.activeInnerImageUrl = dto.innerImageURL;
                
//            }
            controller.activeRule = dto.activeRule;

            controller.activeName = dto.activeName;
            
            [self.navigationController pushViewController:controller animated:YES];
            
            TT_RELEASE_SAFELY(controller);
        }
            break;


        default:
            
            break;
            
    }
}

#pragma mark -
#pragma mark property getters

- (SNReaderController *)readerController
{
    if (!_readerController) {
        _readerController = [[SNReaderController alloc] initWithContentController:self.superViewController];
    }
    return _readerController;
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            
            return _homeView.topBannerView.height;
        }
            break;
            
            
        case 1:{
            
            if (sweepSwitch) {
                return _homeView.consultationView.height+_homeView.sweepstackesView.height;
            }else{
                return _homeView.consultationView.height;
            }
            
        }
            break;
            
        case 2:{
            
            return _homeView.groupBuyingView.height;
            
        }
            break;
            
        case 3:{
            
            return _homeView.bottomItemView.height;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:{
            
            UITableViewCell *topCell = nil;
            
            static NSString *TopCellIdentifier = @"TopCellIdentifier";
            
            topCell = [tableView dequeueReusableCellWithIdentifier:TopCellIdentifier];
            
            if (!topCell)
            {
                topCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopCellIdentifier];
                
                topCell.selectionStyle = UITableViewCellSelectionStyleNone;

                
                [topCell addSubview:_homeView.topBannerView];
            }
            
            return topCell;
            
        }
            break;
            
        case 1:{
            
            //促销专栏
            static NSString *consultationCellIdentifier = @"consultationCellIdentifier";
            
            UITableViewCell *centerCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:consultationCellIdentifier];
            
            if (!centerCell)
            {
                centerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:consultationCellIdentifier];
                
                centerCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                
            }
            else
            {
                [centerCell.contentView removeAllSubviews];
            }
            
            if (sweepSwitch) {
                [centerCell addSubview:_homeView.consultationView];
                _homeView.sweepstackesView.top = _homeView.consultationView.bottom;
                [centerCell addSubview:_homeView.sweepstackesView];
            }else{
                [centerCell addSubview:_homeView.consultationView];
            }
            
            return centerCell;
            
        }
            
            break;
            
        case 2:{
            
            //抢购团购入口
            static NSString *groupBuyingCellIdentifier = @"groupBuyingCellIdentifier";
            
            UITableViewCell *centerCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:groupBuyingCellIdentifier];
            
            if (!centerCell)
            {
                centerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupBuyingCellIdentifier];
                
                centerCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [centerCell addSubview:_homeView.groupBuyingView];
                
            }
            
            return centerCell;
            
        }
            break;
            
        case 3:{
            
            static NSString *cellIdentifier = @"cellIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            [cell.contentView addSubview:_homeView.bottomItemView];
            
            return cell;
            
        }
            break;
            
            
        case 4:{
            
            static NSString *cellIdentifier = @"cellIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            
            [cell.contentView addSubview:_homeView.bottomItemView];
            
            return cell;
            
        }
            
            break;
            
        default:
            break;
    }
    
    return nil;
    
    
}



#pragma mark -
#pragma mark actions

- (UINavigationController *)navigationController
{
    return self.superViewController.navigationController;
}

- (void)goToHotSale:(id)sender
{
    
    HotSaleViewController *hotSaleVC = [[HotSaleViewController alloc] init];
    
    [self.navigationController pushViewController:hotSaleVC animated:YES];
    
    TT_RELEASE_SAFELY(hotSaleVC);

    
}

- (void)goToDeliveryInstall:(id)sender
{
    /*
    ServiceStackViewController *serviceVC = [[ServiceStackViewController alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
    [serviceVC release];
     */
    ServiceTrackListViewController *nextViewController = [[ServiceTrackListViewController alloc] init];
    [self.navigationController pushViewController:nextViewController animated:YES];
    TT_RELEASE_SAFELY(nextViewController);
}

- (void)goToVirtualPay:(id)sender
{
//    MobileRechargeViewController *_mobileRechargeNewViewController = [[MobileRechargeViewController alloc] init];
//    [self.navigationController pushViewController:_mobileRechargeNewViewController animated:YES];
//    
//    TT_RELEASE_SAFELY(_mobileRechargeNewViewController);
    
    PaymentCenterViewController *paymentCenterViewController = [[PaymentCenterViewController alloc] init];
    [self.navigationController pushViewController:paymentCenterViewController animated:YES];
    
    TT_RELEASE_SAFELY(paymentCenterViewController);
}

- (void)goToBarCode:(id)sender
{
    [self readerBegin];
//    [self.readerController beginReader];
}

- (void)goToCategory:(id)sender
{
    //获取分类的导航栏
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:2];
    [nav popToRootViewControllerAnimated:NO];
    
    [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 2;
    
    
}

- (void)goLotteryHall:(id)sender
{
    LotteryHallViewController *ctrl = [[LotteryHallViewController alloc]init];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

- (void)goToSearchView:(id)sender
{
    self.homeSearchView.keywordList = nil; //add by wangjiaxing 20130603
    [self.homeSearchView displayView];
    
    [self endTimer];
}

- (void)cancelSearchBar
{
    [self startTimer];
}

-(void)readerBegin
{
//    [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 1;
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:1];
    [nav popToRootViewControllerAnimated:NO];
    NewSearchViewController *search = (NewSearchViewController *)[nav.viewControllers objectAtIndex:0];

    [search beginReaderZBar];
    
    //    search.searchView.searchBar.text = keyword;
    
    [self startTimer];
}

- (void)didSelectAssociationalWord:(NSString *)keyword
{
    [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 1;
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:1];
    [nav popToRootViewControllerAnimated:NO];
    NewSearchViewController *search = (NewSearchViewController *)[nav.viewControllers objectAtIndex:0];
    [search didSelectAssociationalWord:keyword];
    search.homeKeyString = keyword;
    _homeView.searchBar.text = nil;
    self.homeSearchView.keywordList = nil;
    
    [self.homeSearchView removeView];
    
    [_homeView hideSearchBar];
//    search.searchView.searchBar.text = keyword;
    
    [self startTimer];
}

- (void)goToUserFeedBack:(id)sender
{
//    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
//    
//    if (mailClass != nil)
//    {
//        if ([mailClass canSendMail])
//        {
//            [self sendMail];
//        }
//        else
//        {
//            [self launchMailAppOnDevice];
//        }
//    }
//    else
//    {
//        [self launchMailAppOnDevice];
//    }
    
    
    UserFeedBackPreViewController *userFeedBackViewController = [[UserFeedBackPreViewController alloc] init];
    [self.navigationController pushViewController:userFeedBackViewController animated:YES];
    TT_RELEASE_SAFELY(userFeedBackViewController);
}

- (void)goToTravelAndBusiness:(id)sender
{
    BusinessTravelRootViewController *queryPlaneViewController = [[BusinessTravelRootViewController alloc]init];
    [self.navigationController pushViewController:queryPlaneViewController animated:YES];
    TT_RELEASE_SAFELY(queryPlaneViewController);
}

- (void)goToNearbySuning:(id)sender
{
    NearbySuningViewController *VC = [[NearbySuningViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    TT_RELEASE_SAFELY(VC);
}

- (void)goToBrowsingHistory:(id)sender
{
    BrowsingHistoryViewController *vc = [BrowsingHistoryViewController controller];
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)goToSuningFamily:(id)sender
//{
//    SuningFamilyViewController *vc = [SuningFamilyViewController controller];
//    [self.navigationController pushViewController:vc animated:YES];
//}


//-(void)goToVirtualProduct:(id)sender
//{
//    WaterElectricityGasViewController *vc = [[WaterElectricityGasViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)goToFavorite:(id)sender
{
    MyFavoriteViewController *vc = [MyFavoriteViewController controller];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goGroupListView:(id)sender{
    
//    PurchaseViewController *purchaseVC = [[PurchaseViewController alloc] initWithPurchaseType:GroupPurchase];
//    purchaseVC.currentPage = 0;
//    [self.navigationController pushViewController:purchaseVC animated:YES];
//    [purchaseVC release];

    //xiewei --------------以下注销--------------------------- 
    SNSpecialListViewController *special = [[SNSpecialListViewController alloc] init];
    [self.navigationController pushViewController:special animated:YES];
    //xiewei --------------以上注销---------------------------

    
}

- (void)goToGroupBuy:(id)sender
{
    [BBSideBarViewController goToLocalLife:@"" snProId:@""];
}

- (void)goSweepstakesView:(id)sender
{
    SweepstakesViewController *nextVC = [[SweepstakesViewController alloc] init];
    
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)goBuyingListView:(id)sender{
    
    PurchaseProductListViewController   *purchaseVC = [[PurchaseProductListViewController  alloc] init];
//    purchaseVC.currentPage = 0;
    [self.navigationController pushViewController:purchaseVC animated:YES];
}

// 进入资讯页面
- (void)goCinsultationListView:(id)sender
{
    
    PromotionInfoViewController *promotionInfoViewController = [[PromotionInfoViewController alloc] init];
    
    [self.navigationController pushViewController:promotionInfoViewController animated:YES];
    
    TT_RELEASE_SAFELY(promotionInfoViewController);
    
}

#pragma mark -
#pragma mark refresh data

- (void)refreshData
{
    [super refreshData];
    
    //在刷新八联版时停掉定时器, 极限场景会引起崩溃
    [self endTimer];
    
    [self displayOverFlowActivityView];
    [self.eightBannerAdService requestBannerListWithAdType:eHomeEightBannerType];
}

#pragma mark -  UserFadeBack Methods
#pragma mark    用户反馈的方法实现

- (void)sendMail{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self;
    
    NSString *appVersion =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *iosVersion = [SystemInfo osVersion];
    
    NSString *platformString = [SystemInfo platformString];
    
   NSString *subject  = [[NSString alloc ]initWithFormat:@"苏宁易购%@(%@: %@)",appVersion,platformString,iosVersion ];

    [picker setSubject:subject];
    
    TT_RELEASE_SAFELY(subject);
    
    [picker setToRecipients:[NSArray arrayWithObject:@"suningios@cnsuning.com"]];
    
    if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) 
    {
        [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"system_nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        object_setClass(picker.navigationBar, [AuthNavigationBar class]);
    }
    
    picker.navigationBar.tintColor = [UIColor navTintColor];
    
    [self.superViewController presentModalViewController:picker animated:YES];
    
    TT_RELEASE_SAFELY(picker);

}

- (void)launchMailAppOnDevice
{
    UIActionSheet *action = [[UIActionSheet alloc] 
                             initWithTitle:L(@"Please Go to Mail App Config your Mail account") 
                             delegate:self
                             cancelButtonTitle:L(@"Cancel")
                             destructiveButtonTitle:L(@"Now go to Mail")
                             otherButtonTitles:nil];
    
    [action showInView:self.view.superview];
    
    TT_RELEASE_SAFELY(action);
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        NSString *appVersion =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        NSString *iosVersion = [SystemInfo osVersion];
        
        NSString *platformString = [SystemInfo platformString];
        
        NSString *subject  = [[NSString alloc ]initWithFormat:@"苏宁易购%@(%@: %@)",appVersion,platformString,iosVersion ];
        
        NSString *recipients = [NSString stringWithFormat:@"mailto:suningios@cnsuning.com?subject=%@", subject];
        NSString *email = [NSString stringWithFormat:@"%@", recipients];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        
        TT_RELEASE_SAFELY(subject);
    }
}

- (void) mailComposeController: (MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
            [self presentCustomDlg:L(@"Save success")];
			break;
		case MFMailComposeResultSent:
            [self presentCustomDlg:L(@"Send success, thank for your feedback")];
			break;
		case MFMailComposeResultFailed:
            [self presentCustomDlg:L(@"Send failed")];
			break;
		default:
		{
			[self presentCustomDlg:@"Sending Failed – Unknown Error  "];
			break;
        }
	}
	
	[self.superViewController dismissModalViewControllerAnimated:YES];
	
}
#pragma mark -  SuningActivityInfo Methods
#pragma mark    苏宁资讯
- (void)promotionWillUpdateInfo:(NSString *)lastestInfo
{
    
    UILabel *promotionInfoLbl = (UILabel *)[_homeView.consultationView viewWithTag:102];
    
    promotionInfoLbl.text = lastestInfo;
    
}

- (void)sendPromotionInfoHttpRequest
{
   [self.promotionInfoService beginGetPromotionInfoListWithPageNum:@"1" PageSize:@"1"];
}


- (void)getPromotionInfoListWithSuccess:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg 
                      PromotionInfoList:(NSMutableArray *)list 
                              totalPage:(NSInteger)totalPage 
                            currentPage:(NSInteger)currPage
{
    if (isSuccess) {
        
        isPromotionInfoLoaded = YES;
        NSInteger count = [list count];
        
        if (count > 0) {
            NSString *promotionInfo = [[list objectAtIndex:0] elementName];
                        
            [self promotionWillUpdateInfo:promotionInfo];
        }
    }
    
    self.promotionInfoService = nil;
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [_homeView showSearchBar];
        
    if (![searchBar.placeholder isEqualToString:L(@"Search Product")]) {
        searchBar.text=searchBar.placeholder;
    }
    [self.homeBoard.scrollView changeScrollViewEnable:NO];
    
    [self goToSearchView:nil];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.homeSearchView refreshViewWithKeyword:searchText];
    
    if ([searchText isEqualToString:@""]) {
        searchBar.placeholder = L(@"Search Product");
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    [_homeView hideSearchBar];
    
    [self.homeBoard.scrollView changeScrollViewEnable:YES];
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_homeView.searchBar resignFirstResponder];

    searchBar.text=@"";
    
    if ([searchBar.placeholder isEqualToString: L(@"Search Product")]) {
        searchBar.placeholder = [self switchSearchwords];
    }
    
    [self cancelSearchBar];

    [self.homeBoard.scrollView changeScrollViewEnable:YES];
    
    [self.homeSearchView removeView];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
      NSString *keyword = searchBar.text;
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
      return;
    }
    [searchBar resignFirstResponder];
    [self.homeBoard.scrollView changeScrollViewEnable:YES];

    [self didSelectAssociationalWord:keyword];
}

#pragma mark - Switch Hot Keywords
-(NSString *)switchSearchwords
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *searchStr= [switchMap objectForKey:@"SearchTextField"];
    
    if (searchStr !=nil) {
        NSArray *searchFieldArr =[searchStr componentsSeparatedByString:NSLocalizedString(@";", nil)];
        NSString *hotKeywords = [searchFieldArr objectAtIndex:arc4random()%[searchFieldArr count]];
        return hotKeywords;
    }
    else
    {
        return L(@"Search Product");
    }
}
@end
