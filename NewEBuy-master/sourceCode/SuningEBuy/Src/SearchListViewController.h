//
//  SearchListViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "SearchListCell.h"
#import "SearchSegmentCell.h"
#import "SearchSegmentView.h"
#import "SearchListService.h"
#import "SearchSectionHeaderView.h"
#import "SearchFilterDelegate.h"

#import "AssociationalWordDisplayController.h"
#import "AssociationalAndHistoryWordDisplayController.h"
#import "InterestProductsView.h"
#import "SNReaderController.h"
#import "ChooseSearchTypeView.h"
#import "SearchListTopView.h"
#import "BigViewModelCell.h"

#import "FilterPopupViewController.h"
#import "NextCategoryViewController.h"
#import "VoiceSearchViewController.h"
#import "VoiceSearchKeyboardView.h"

#import "SearchQueryRecommendedBrandService.h"
typedef enum {
    SearchResultViewNormal,         //正常页面
    SearchResultViewLoading,        //正在加载
    SearchResultViewLoadFail,       //请求失败
    SearchResultView404,            //404页面
    SearchResultViewRecommend,      //推荐商品页面
}SearchResultViewType;

typedef enum : NSUInteger {
    NORMAL,
    NORESULT,
    SHOWING_TEXTFIELD
} BTNSTATE;
//推荐商品视图
@interface UIFootRecommendView : UIView
@property (nonatomic, strong) InterestProductsView *recommendViewForkeywordSearch;
@property (nonatomic, strong) InterestProductsView *recommendViewForCategoryFilter;
@property (nonatomic, assign) BOOL isKeywordSearch;
@property (nonatomic, weak) id  <InterestProductsViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *productListForKeyword;
@property (nonatomic, strong) NSMutableArray *productListForCategoryFilter;


- (void)showIntrestedProductView:(NSMutableArray *)productList;
@end

typedef enum : NSUInteger {
    SmallView = 0, //普通列表模式
    BigView = 1,   //大图模式
} ShowModel;


@interface SearchListViewController : CommonViewController 
<SearchSegmentDelegate, SearchListServiceDelegate, SearchSectionTouchDelegate,
AssociationalWordDisplayDelegate, UISearchBarDelegate, SearchFilterDelegate, 
InterestProductsViewDelegate ,UITextFieldDelegate, AssociationalAndHistoryWordDisplayDelegate, SearchListTopViewDelegate, BigViewModelCellDelegate, VoiceSearchKeyboardViewDelegate, SearchQueryRecommendedBrandServiceDelegate>
{
    @private
    SearchListService       *_service;
    
    SearchParamDTO          *_searchCondition;
    
    BOOL                    bFirstTimeIn;    //第一次进入当前搜索，主动请求前5个数据的促销信息，剩余的只在可见时请求
}

@property (nonatomic, strong) SearchQueryRecommendedBrandService *searchQueryRecommendedBrandService;

@property (nonatomic, readonly, strong) SearchListService *service;
@property (nonatomic, readonly, strong) SearchParamDTO *searchCondition;
@property (nonatomic, strong) UIToolbar *statusbarBack;
@property (nonatomic, strong) SNReaderController *readerController;
@property (nonatomic, strong) NSMutableArray *lastRequestArray; //上次请求促销信息的数组
@property (nonatomic, assign) BOOL       isFirstIn;//是否从分类第一次进入搜索

//搜索类型切换按钮
@property (nonatomic, strong) UIButton *searchTypeBtn;
@property (nonatomic, strong) UIButton *showModelBtn; //大图模式切换按钮
@property (nonatomic, assign) ShowModel showModel;

@property (nonatomic, strong) UIView *maskView;  //透明的遮罩，防止用户在加载数据时进行操作导致控件显示错误

@property (nonatomic, strong) FilterPopupViewController *FilterCtrl;

@property (nonatomic, copy) NSString *jianciKeyword;
//结果列表上面包含旗舰店，常用分类，segment的视图
@property (nonatomic, strong) SearchListTopView *searchTopView;

@property (nonatomic, strong) VoiceSearchKeyboardView *keyboardView;

- (id)initWithSearchCondition:(SearchParamDTO *)condition;

+ (void)goToSearchResultWithParamDTO:(SearchParamDTO *)paramDTO fromNav:(UINavigationController *)navController;
+ (void)goToSearchResultWithKeyword:(NSString *)keyword fromNav:(UINavigationController *)navController;

+ (UIViewController *)searchPageWithParamDTO:(SearchParamDTO *)paramDTO;

- (void)setSearchResultViewType:(SearchResultViewType)type;

- (void)showButtons:(BTNSTATE)state;
@end
