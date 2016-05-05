//
//  SolrSearchHistoryDAO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-3-5.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DAO.h"

@interface SolrSearchHistoryDAO : DAO


- (BOOL)deleteAllSearchKeywordsFromDB;

- (BOOL)deleteKeywordFromDB:(NSString *)keyword;

- (BOOL)addKeywordToDB:(NSString *)keyword;

- (NSMutableArray *)getAllKeywords;

/*获取最后的二十条记录*/
- (NSMutableArray *)getLastestTwentyKeywords;

@end
