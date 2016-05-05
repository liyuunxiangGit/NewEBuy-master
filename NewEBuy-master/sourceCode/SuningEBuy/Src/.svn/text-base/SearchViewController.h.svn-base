//
//  SearchViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SearchViewController
 @abstract    搜索页面
 @author      刘坤
 @version     v1.0.002  12-8-27
 */

//已废弃

#import "CommonViewController.h"
#import "SearchService.h"
#import "SearchView.h"
#import "AssociationalWordDisplayController.h"
#import "SNReaderController.h"
#import "SearchAdDTO.h"
#import "AdModel2ViewController.h"
#import "AdModel3ViewController.h"
#import "AdModel4ViewController.h"
#import "AdModel5ViewController.h"
#import "AdModel6ViewController.h"


@interface SearchViewController : CommonViewController <SearchServiceDelegate, NUSearchBarDelegate, UISearchBarDelegate, NUSearchSegmentDelegate, NUHotKeywordsViewDelegate, AssociationalWordDisplayDelegate, UINavigationControllerDelegate>
{
    SearchView    *_searchView;
    SearchService *_service;
    SNReaderController *_readerController; 
}

@property (nonatomic, strong) SearchService *service;
@property (nonatomic, strong) NSArray *historyKeywordList;
@property (nonatomic, strong) NSMutableArray *historyList; //浏览历史 add by wangjiaxing 20130516
@property (nonatomic, strong) NSArray        *searchAdArray;//搜索广告图片数组 add by wangjiaxing 20130521
@property (nonatomic, strong) AssociationalWordDisplayController *keywordDisplayController; //联想词
@property (nonatomic, strong) SNReaderController *readerController; //条码扫描控制器
@property (nonatomic, copy)   NSString          *homeKeyString;
//清空搜索历史
- (void)clearSearchHistorys;

- (void)goToSeachResultWithSearchParam:(SearchParamDTO *)paramDTO;

@end
