//
//  LoadMore.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-31.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      LoadMore
 @abstract    加载更多的协议
 @author      刘坤
 @version     v1.0.001  12-8-31
 */

#import <Foundation/Foundation.h>

/*!
 @protocol       LoadMore
 @abstract       加载更多的协议
 @discussion     需要实现：
 @synthesize isLoadMore;
 @synthesize currentPage;
 @synthesize totalPage;
 @synthesize isLastPage;
 @synthesize isLoading;
 - (BOOL)hasMore;
 
 - (void)refreshData:(id)postData;
 
 - (void)loadMoreData:(id)postData;
 */
@protocol LoadMore <NSObject>

@required
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) int totalPage;
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, assign) BOOL isLoading;

- (BOOL)hasMore;

- (void)refreshData:(id)postData;

- (void)loadMoreData:(id)postData;


@end
