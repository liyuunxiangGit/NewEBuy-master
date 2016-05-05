//
//  HotKeywordsViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "DWTagList.h"
#import "SearchService.h"

@protocol HotKeywordsViewControDelegate;

@interface HotKeywordsViewController : CommonViewController<SearchServiceDelegate,DWTagListDelegate>

@property (nonatomic, strong) DWTagList *tagList;

@property (nonatomic, strong) SearchService *service;

@property (nonatomic, weak) id<HotKeywordsViewControDelegate>  hotKeywordsDelegate;


@end

@protocol HotKeywordsViewControDelegate <NSObject>

@optional
- (void)didSelectHotUrl:(NSString *)url bFromSearchView:(BOOL)bFromHSView wordOfUrl:(NSString*)word;
-(void)didSelectKeyword:(NSString *)keyName;
- (void)didSelectUrl:(NSString *)url;


@end
