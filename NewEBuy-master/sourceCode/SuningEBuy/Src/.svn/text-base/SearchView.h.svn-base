//
//  SearchView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

//已废弃

#import "CommonView.h"
#import "NUSearchBar.h"
#import "NUSearchSegment.h"
#import "NUHotKeywordsView.h"
#import "DWTagList.h"

@interface SearchView : CommonView<DWTagListDelegate,NUSearchBarDelegate>

@property (nonatomic, strong) UITableView       *scanTableView;

@property (nonatomic, strong) NUSearchBar *searchBar;

@property (nonatomic, strong) NUSearchSegment *segment;

@property (nonatomic, strong) NUHotKeywordsView *hotKeywordsView;

@property (nonatomic, strong) DWTagList *tagList;

@property (nonatomic, strong) UILabel *noHistoryLabel;

@property (nonatomic, strong) UILabel *noScanHistoryLabel;

@property (nonatomic, strong) UIView *delAllButtonView; //target: clearSearchHistorys

@property (nonatomic, strong) UIView *delAllScanButtonView; //add by wangjiaxing 20130517


//- (void)showSearchBar;
//- (void)hideSearchBar;
@end

