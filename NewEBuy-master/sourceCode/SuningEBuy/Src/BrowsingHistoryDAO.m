//
//  BrowsingHistoryDAO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BrowsingHistoryDAO.h"

@implementation BrowsingHistoryDAO


- (void)deleteAllHistorysFromDB
{
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from %@", @"browsing_history_n"];
        
        [db executeUpdate:sql];
    }];
}

- (NSArray *)getAllBrowsingHistorysFromDB
{
    __block NSMutableArray *array = nil;
	[self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from browsing_history_n order by julianday(add_dttm) desc limit 50"];
        
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] init];	
        while ([rs next]) {			
            DataProductBasic *dto = [[DataProductBasic alloc] init];
            dto.productCode = [rs stringForColumn:@"product_code"];
            dto.productId = [rs stringForColumn:@"product_id"];
            dto.productName = [rs stringForColumn:@"product_name"];
            dto.shopCode = [rs stringForColumn:@"shop_code"];
            dto.price = [NSNumber numberWithFloat:[[rs stringForColumn:@"price"] doubleValue]];
            dto.evaluation = [rs stringForColumn:@"evaluation"];
            dto.cityCode = [rs stringForColumn:@"city_code"];
            dto.special = [rs stringForColumn:@"aux_description"];
            dto.productImageURL = [NSURL URLWithString:[rs stringForColumn:@"product_imageurl"]];
            [array addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }	
        [rs close]; 
    }];
	return array;
}

- (BOOL)writeProductToDB:(DataProductBasic *)data
{
    if (data == nil || data.productId.trim.length == 0 || data.productName.trim.length == 0)
    {
        return NO;
    }
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        
        NSString *sql = [NSString stringWithFormat:@"replace into browsing_history_n(product_code,product_id,shop_code,product_name,price,evaluation,city_code,aux_description,product_imageurl,add_dttm)values(?,?,?,?,?,?,?,?,?,?);"];
                
        [db executeUpdate:sql,data.productCode,data.productId,data.shopCode,data.productName,[data.price stringValue],data.evaluation,data.cityCode,data.special,[data.productImageURL absoluteString],[NSDate date]];
    }];
    
    
    return YES;
}

- (BOOL)deleteProductByData:(DataProductBasic *)data
{
    if (data == nil)
    {
        return NO;
    }
    
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from browsing_history_n where product_id = ?"];
        
        [db executeUpdate:sql,data.productId];
        
    }];
    
    
    return YES;
}

@end
