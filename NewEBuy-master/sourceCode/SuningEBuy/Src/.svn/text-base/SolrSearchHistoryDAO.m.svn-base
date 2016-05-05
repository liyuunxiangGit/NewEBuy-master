//
//  SolrSearchHistoryDAO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-3-5.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SolrSearchHistoryDAO.h"

@implementation SolrSearchHistoryDAO

- (BOOL)deleteAllSearchKeywordsFromDB
{
    __block BOOL isSuccess;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from %@", @"search_history"];
        
        isSuccess = [db executeUpdate:sql]; 
    }];
    return isSuccess;
}

- (NSMutableArray *)getAllKeywords
{
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select keywords from search_history order by keyword_id desc"];
        
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:1000];	
        while ([rs next]) {			
            
            NSString *keyword = [rs stringForColumn:@"keywords"];
            
            if (NotNilAndNull(keyword)) {
                [array addObject:keyword];
            }
            
            if ([array count] >= 1000)
            {
                break;
            }
        }	
        [rs close];	
    }];
    return array;
    
}

- (NSMutableArray *)getLastestTwentyKeywords
{
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select keywords from search_history order by keyword_id desc"];
        
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:20];	
        while ([rs next]) {			
            
            NSString *keyword = [rs stringForColumn:@"keywords"];
            
            if (NotNilAndNull(keyword)) {
                [array addObject:keyword];
            }
            
            //243搜索要求改为10条，之前是20条 chupeng 2014-8-28
            if ([array count] >= 10)
            {
                break;
            }
        }	
        [rs close];	
        
    }];
    return array; 
}

- (BOOL)deleteKeywordFromDB:(NSString *)keyword
{
    if (IsNilOrNull(keyword)) {
        return NO;
    }    
    
    __block BOOL isSuccess;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from search_history where keywords = ?"];
        
        isSuccess = [db executeUpdate:sql,keyword]; 
    }];
    
    return isSuccess;
}

- (BOOL)isContainKeyword:(NSString *)keyword
{
    __block BOOL isContain = NO;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from search_history where keywords = ?"];
        
        FMResultSet *rs = [db executeQuery:sql, keyword];	
        
        if (!rs) {
            [rs close];
            return;
        }
        while ([rs next]) {
            [rs close];
            isContain = YES;
        }
        [rs close];
    }];
    return isContain;
}

- (BOOL)addKeywordToDB:(NSString *)keyword
{
    if (IsNilOrNull(keyword)) {
        return NO;
    }
    
    if ([self isContainKeyword:keyword]) {
        [self deleteKeywordFromDB:keyword];
    }
    
    __block BOOL isSuccess;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"insert into search_history (keywords)values(?)"];
        
        isSuccess = [db executeUpdate:sql, keyword]; 
    }];
    return isSuccess;
}


@end
