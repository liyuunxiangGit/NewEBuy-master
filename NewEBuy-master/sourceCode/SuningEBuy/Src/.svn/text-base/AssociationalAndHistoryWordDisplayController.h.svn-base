//
//  AssociationalAndHistoryWordDisplayController.h
//  SuningEBuy
//
//  Created by chupeng on 13-12-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
#import "AssociationalWordDisplayController.h"
#import "SearchService.h"
#import "AssociationalWordService.h"
#import <UIKit/UIKit.h>
#import "AssociationWordDTO.h"
#import "CustomSegment.h"

@protocol AssociationalAndHistoryWordDisplayDelegate <NSObject>

- (void)didSelectAssociationalWord:(NSString *)keyword;
- (void)didSelectAssociationalTypeKeyword:(NSString *)keyword andDirId:(NSString *)dirid andCore:(NSString *)core;
- (void)deleteHistoryOk;

- (void)didselectHotUrl:(NSString *)url;

- (void)didSelectHotUrl:(NSString *)url bFromSearchView:(BOOL)bFromHSView wordOfUrl:(NSString*)word;
- (void)refreshDefaultWords;
@end

@interface AssociationalAndHistoryWordDisplayController : NSObject<SearchServiceDelegate, AssociationalWordServiceDelegate,UITableViewDelegate, UITableViewDataSource, CustomSegmentDelegate>

{
    UITableView  *_displayTableView;
    
    CGFloat     _tableTopPosY;          //view顶部的positionY
    CGFloat     _distanceToTop;         //view顶部到屏幕顶端的距离
    AssociationalWordType  _wordType;   //联想词类型，混合，图书
    CGFloat height;
}

@property (nonatomic, strong) CustomSegment                     *topSegment;

@property (nonatomic, strong) UIView                            *backView;
@property (nonatomic, strong) UITableView *displayTableView;
@property (nonatomic, strong) UITableView                       *hotwordTableView;
@property (nonatomic, strong) AssociationalWordService *service;



@property (nonatomic, weak) id<AssociationalAndHistoryWordDisplayDelegate> delegate;
@property (nonatomic, assign) CGFloat tableTopPosY;
@property (nonatomic, assign) CGFloat distanceToTop;
@property (nonatomic, assign) AssociationalWordType wordType;
@property (nonatomic, assign) BOOL bShowingHistory;    //无词或者店铺搜索，都只展示历史词
@property (nonatomic, assign) BOOL bShowingInNewSearch;//在newsearch界面，“清空搜索记录”按钮是固定的，所以不加在此tableview上
@property (nonatomic, copy)  NSString *keyWord;

//历史记录
@property (nonatomic, strong) SearchService *historyService;
@property (nonatomic, strong) NSArray *historyKeywordsList;

//热门搜索词
@property (nonatomic, strong) SearchService *hotWordsService;
@property (nonatomic, strong) NSMutableArray *hotWordsList;
@property (nonatomic, strong) NSMutableArray *hotWordsDtoList;
@property (nonatomic, assign) BOOL bGetHotWordsOK;

- (id)initWithContentController:(UIViewController *)controller;
- (void)displayView:(NSArray *)assicoateKeywords;
- (void)displayViewWithHistoryWords:(NSArray *)historyWords;
- (void)removeView;
- (void)refreshViewWithKeyword:(NSString *)keyword;
- (void)hideViewsInNewSearchControl;
@end
