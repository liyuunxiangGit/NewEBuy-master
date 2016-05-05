//
//  SuNingSellDao.m
//  SuningEBuy
//
//  Created by zl on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SuNingSellDao.h"
#import "SuNingSellData.h"

#define KSourceChannel @"source_channel"
#define KChannelDetail @"channel_detail"
#define KProduceCode   @"produce_code"
#define KProducePrice  @"produce_price"

NSString* __gIsProduceCode;
@implementation SuNingSellDao
- (BOOL)deleteSuNingSellDAOFromDB:(NSString*)produceCode isSearch:(BOOL)isSearch
{
    __block  BOOL isDelete = NO;
    if (IsStrEmpty(produceCode))
    {
        return isDelete;
    }
    if (isSearch)
    {
        NSString* resultStr = [self searchSuNingSellDAOToDB:produceCode];
        NSUInteger length = [resultStr length];
        if (!length)
        {//数据库中已经存在
            return isDelete;
        }
    }
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from dic_sell where produce_code = ?"];
        
        isDelete = [db executeUpdate:sql,produceCode];
    }];

    return isDelete;
}
- (BOOL)insertSuNingSellDAOFromDB:(NSString*)sourceChannel channelDetail:(NSString*)channelDetail produceCode:(NSString*)produceCode producePrice:(NSString*)producePrice
{
    __block BOOL isInsearch = NO;
    
    if (IsStrEmpty(sourceChannel)&&IsStrEmpty(channelDetail)&&IsStrEmpty(produceCode)&&IsStrEmpty(producePrice))
    {
        return isInsearch;
    }
    
    NSString* resultStr = [self searchSuNingSellDAOToDB:produceCode];
    NSUInteger length = [resultStr length];
    if (length)
    {//数据库中已经存在
        return isInsearch;
    }
    
    NSString* tempSourceChannel = sourceChannel;
    NSString* tempChannelDetail = channelDetail;
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *insertSql = @"insert into dic_sell(source_channel,channel_detail,produce_code,produce_price)values(?,?,?,?)";
        if (![db executeUpdate:insertSql,tempSourceChannel,tempChannelDetail,produceCode,producePrice])
        {
            *rollback = YES;
            return;
        }
        isInsearch = YES;
    }];
    return isInsearch;
}
- (NSString*)searchSuNingSellDAOToDB:(NSString*)produceCode
{
    __block NSString* resultStr = nil;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from dic_sell where produce_code = ?"];
        
        FMResultSet *rs = [db executeQuery:sql, produceCode];
        if(!rs)
        {
            [rs close];
            return;
        }
        while ([rs next])
        {
            resultStr = [NSString stringWithFormat:@"%@_%@_%@_%@",[rs stringForColumn:@"source_channel"],[rs stringForColumn:@"channel_detail"],[rs stringForColumn:@"produce_code"],[rs stringForColumn:@"produce_price"]];
        }
        
        [rs close];
    }];
    return resultStr;
}

- (NSMutableArray *)getAllSuNingSellDAOFromDB
{//目前没有使用，后期使用
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from dic_sell"];
        FMResultSet *rs = [db executeQuery:sql];
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:50];
        while ([rs next]) {
            SuNingSellData *dto = [[SuNingSellData alloc] init];
            dto.ourceChannel = [rs stringForColumn:KSourceChannel];
            dto.channelDetail = [rs stringForColumn:KChannelDetail];
            dto.produceCode = [rs stringForColumn:KProduceCode];
            dto.producePrice = [rs stringForColumn:KProducePrice];
            [array addObject:dto];
        }
        [rs close];
    }];
    return array;

}

- (BOOL)deleteAllSuNingSellDAOFromDB
{
    __block  BOOL isDelete = NO;

    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from dic_sell"];
        
        isDelete = [db executeUpdate:sql];
    }];
    
    return isDelete;
}
@end
