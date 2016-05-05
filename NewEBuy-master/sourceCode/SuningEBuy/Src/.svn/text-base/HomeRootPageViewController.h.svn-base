//
//  HomeRootPageViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header      HomeRootPageViewController
 @abstract    首页
 @author      刘坤
 @version     v1.0.002  12-8-28
 */

#import "PageRefreshTableViewController.h"
#import "HomeRootView.h"

#import "EightBannerADService.h"
#import "HomeTopScrollAdDTO.h"


#import "PromotionInfoViewController.h"
#import "PromotionInfoService.h"

#import <MessageUI/MessageUI.h>

#import "BBScrollViewController.h"

#import "SystemInfo.h"
#import "HomeSearchController.h"

#import "CategoryService.h"


@interface HomeRootPageViewController : PageRefreshTableViewController <EightBannerADServiceDelegate,EightBannerImagePageCellClickDelegate,PromotionInfoServiceDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate, BBScrollContentApperace,HomeSearchControllerDelegate,CategoryServiceDelegate>
{
    @private
    HomeRootView *_homeView;
    
    BOOL         isPromotionInfoLoaded;
    BOOL         isEightBannerLoaded;
    
    BOOL        sweepSwitch;
    
    BOOL         isCategoryLoaded;
    
}


@property (nonatomic, unsafe_unretained) UIViewController *superViewController;

@property (nonatomic, strong)  PromotionInfoService *promotionInfoService;
@property (nonatomic, strong) EightBannerADService *eightBannerAdService;

@property (nonatomic, strong) HomeSearchController  *homeSearchView;

@property (nonatomic, strong) CategoryService *categoryService;

- (void)goToHotSale:(id)sender;
- (void)goToDeliveryInstall:(id)sender;
- (void)goToVirtualPay:(id)sender;
- (void)goToBarCode:(id)sender;
- (void)goToCategory:(id)sender;
- (void)goLotteryHall:(id)sender;
- (void)goToUserFeedBack:(id)sender;
- (void)goToTravelAndBusiness:(id)sender;

- (void)goToBrowsingHistory:(id)sender;
- (void)goToVirtualProduct:(id)sender;
- (void)goToFavorite:(id)sender;
- (void)goToGroupBuy:(id)sender;

- (void)goCinsultationListView:(id)sender;
- (void)goGroupListView:(id)sender;
- (void)goBuyingListView:(id)sender;

- (void)goSweepstakesView:(id)sender;

//进入八联版页面
- (BOOL)jumpToBannerView:(NSInteger)index;
@end
