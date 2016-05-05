//
//  HomePageViewController.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "EightBannerView244.h"
#import "ShopRecommend244.h"
#import "BrandRecommend244.h"
#import "LianBanZhuanTiViewController.h"
#import "HomePageService244.h"
#import "ZhuanTiService244.h"
#import "HomeFloorTableViewCell.h"
#import "NewHomeTopView.h"
#import "InvitationService.h"
#import "SearchService.h"
#import "SearchbarView.h"
#import "HomeSearchController.h"
#import "SearchListViewController.h"
#import "NewSearchViewController.h"
#import "ShopSearchListViewController.h"
#import "FilterRootViewController.h"
#import "FilterNavigationController.h"
#import "JASidePanelController.h"
#import "Floor12View.h"
#import "SecondPageViewController.h"
#import "SNReaderController.h"
#import "SFHFKeychainUtils.h"
#import "GuessYouLikeService.h"
#import "GuessYouLikeCell.h"
#import "QuickRegistFloatingView.h"
#import "NewRegisterViewController.h"


@interface HomePageViewController : PageRefreshTableViewController <EightBannerViewDelegate, HomePageService244Delegate, ZhuanTiServiceDelegate, HomeFloorTableViewCellDelegate, InvitationServiceDelegate, SearchServiceDelegate, SearchbarViewDelegate, HomeSearchControllerDelegate,GuessYouLikeServiceDelegate,GuessYouLikeCellDelegate> {

    BOOL                isCanGetRedPack;
    
    //存放楼层数据
    NSMutableArray *floorDataArray;
    
    //存放推荐模块数据(猜你喜欢模块)
    NSMutableArray      *recommendDataArray;
    
    //是否加载底部推荐标签
    BOOL                willLoadRecommendLabel;
    //推荐模块cell行数
    int                 recommendCellCount;
    
@private
    NewHomeTopView *_homeView;
    
    //鉴于首页的导航栏和二级页面的导航栏背景色不一样，所以在首页使用了一个UIView来当导航栏
    UIView *navigationView;
    
    QuickRegistFloatingView     *quickRegistView;
}

//首页service
@property (nonatomic, strong) HomePageService244     *homePageService;

//专题service
@property (nonatomic, strong) ZhuanTiService244      *zhuanTiService;

@property (strong,nonatomic)  InvitationService *invita;

@property (nonatomic, strong) SearchService                 *searchService;
@property (nonatomic, strong) SearchService                *hotWordsService;

//首页底部的猜你喜欢service
@property (nonatomic, strong) GuessYouLikeService           *guessYouLikeService;

@property (nonatomic, strong) HomeSearchController  *homeSearchView;

@property (nonatomic, strong) SNReaderController            *readerController;
- (id)init;
@end
