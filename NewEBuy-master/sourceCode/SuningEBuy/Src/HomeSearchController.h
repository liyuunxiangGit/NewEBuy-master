//
//  HomeSearchController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssociationalWordService.h"
#import "AssociationWordDTO.h"
#import "SearchService.h"
#import "CustomSegment.h"

@protocol HomeSearchControllerDelegate;

@interface HomeSearchController : NSObject<AssociationalWordServiceDelegate,UITableViewDelegate,UITableViewDataSource, SearchServiceDelegate, CustomSegmentDelegate>
{
    UITableView     *_displayTableView;
}
@property (nonatomic, strong) UIView                            *backView;
@property (nonatomic, strong) CustomSegment                     *topSegment;
@property (nonatomic, strong) UITableView                       *displayTableView;
@property (nonatomic, strong) UITableView                       *hotwordTableView;
@property (nonatomic, weak) id<HomeSearchControllerDelegate>  delegate;
@property (nonatomic, strong) AssociationalWordService          *service;
@property (nonatomic, assign) AssociationalWordType             wordType;
@property (nonatomic, strong) NSArray                           *keywordList;

@property (nonatomic, strong) NSArray *keywordTypesList;
    
//历史记录相关
@property (nonatomic, assign) BOOL bShowingHistory;
@property (nonatomic, strong) SearchService *historyService;
@property (nonatomic, strong) NSArray *historyKeywordsList;

//热门搜索词
@property (nonatomic, strong) SearchService *hotWordsService;
@property (nonatomic, strong) NSMutableArray *hotWordsList;
@property (nonatomic, strong) NSMutableArray *hotWordDtoList;
@property (nonatomic, assign) BOOL bGetHotWordsOK;

@property (nonatomic, copy) NSString *keyWord;

//热门模式和历史模式
//@property (nonatomic, assign) SHOWMODEL showModel;

/*!
 @abstract      初始化方法
 @param         controller  所在的viewController
 */
- (id)initWithContentController:(UIViewController *)controller;


/*!
 @abstract      展示displayView
 */
- (void)displayView;


/*!
 @abstract      移除displayView
 */
- (void)removeView;


/*!
 @abstract      传入新的keyword并刷新
 */
- (void)refreshViewWithKeyword:(NSString *)keyword;

//- (void)showSearchBar;


@end

@protocol HomeSearchControllerDelegate <NSObject>


@optional
/*!
 @abstract      点击选择某一个联想词的事件传递
 @param         keyword  选择的联想词
 */
- (void)didSelectAssociationalWord:(NSString *)keyword;
- (void)didSelectAssociationalTypeKeyword:(NSString *)keyword andDirId:(NSString *)dirid andCore:(NSString *)core;
- (void)cancelSearchBar;
- (void)didSelectHotUrl:(NSString *)url;
- (void)didSelectHotUrl:(NSString *)url bFromHomeSearchView:(BOOL)bFromHSView wordOfUrl:(NSString*)word;
- (void)refreshDefaultWords;
@end
