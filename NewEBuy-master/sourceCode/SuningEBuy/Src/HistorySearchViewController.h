//
//  HistorySearchViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "HistorySearchView.h"
#import "SearchService.h"

@protocol HistorySearchViewControDelegate;

@interface HistorySearchViewController : CommonViewController<SearchServiceDelegate>

@property (nonatomic, strong) HistorySearchView *historySearchView;

@property (nonatomic, weak) id<HistorySearchViewControDelegate> historySearchDealegate;

@property (nonatomic, strong) NSArray *historyKeywordsList;

@property (nonatomic, strong) SearchService *service;

- (void)reloadHistoryTableViewData;

@end

@protocol HistorySearchViewControDelegate <NSObject>

@optional

-(void)didSelectKeyword:(NSString *)keyName;

@end