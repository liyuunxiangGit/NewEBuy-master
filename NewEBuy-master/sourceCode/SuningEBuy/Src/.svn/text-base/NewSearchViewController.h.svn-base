//
//  NewSearchViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "NUSearchBar.h"
#import "SNReaderController.h"
#import "SearchService.h"
#import "AssociationalWordDisplayController.h"
#import "SearchAdDTO.h"
#import "AdModel2ViewController.h"
#import "AdModel3ViewController.h"
#import "AdModel4ViewController.h"
#import "AdModel5ViewController.h"
#import "AdModel6ViewController.h"
#import "NUSearchSegment.h"
#import "HotKeywordsViewController.h"
#import "HistorySearchViewController.h"
#import "ScanSearchViewController.h"

#import "AssociationalAndHistoryWordDisplayController.h"
#import "CustomSegment.h"
#import "ShopSearchListViewController.h"

@interface NewSearchViewController : CommonViewController<NUSearchBarDelegate,UINavigationControllerDelegate,SearchServiceDelegate,AssociationalWordDisplayDelegate,/*NUSearchSegmentDelegate,*/HotKeywordsViewControDelegate,HistorySearchViewControDelegate,EGOImageViewExDelegate, AssociationalAndHistoryWordDisplayDelegate,CustomSegmentDelegate>
{
    SearchService  *_service;
    SNReaderController *_readerController;
}

@property (nonatomic, strong) NUSearchBar *searchBar;

@property (nonatomic, strong) CustomSegment *segment;

@property (nonatomic, strong) SearchService *service;

@property (nonatomic, strong) NSArray *historyKeywordList;     //历史热词Array

@property (nonatomic, strong) AssociationalAndHistoryWordDisplayController *keywordDisplayController; //联想词
@property (nonatomic, strong) HotKeywordsViewController   *hotKeywordsController;    //热门搜索

@property (nonatomic, strong) AssociationalAndHistoryWordDisplayController  *historySearchController; //最近搜索
@property (nonatomic, strong) UIButton *deleteAllHistoryBtn;

@property (nonatomic, strong) ScanSearchViewController    *scanSearchController;     //最近浏览

@property (nonatomic, strong) SNReaderController *readerController; //条码扫描控制器

@property (nonatomic, strong) NSArray        *searchAdArray;//搜索广告图片数组

@property (nonatomic, copy)   NSString          *homeKeyString;

@property (nonatomic, strong) EGOImageViewEx    *bgImageView;


-(id)initWithDictionary:(NSDictionary*)dic;

@end
