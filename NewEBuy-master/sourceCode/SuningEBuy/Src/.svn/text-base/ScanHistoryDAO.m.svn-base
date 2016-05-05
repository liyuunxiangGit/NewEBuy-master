//
//  ScanHistoryDAO.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ScanHistoryDAO.h"

@implementation ScanHistoryDAO

- (void)deleteAllHistorysFromDB
{
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from %@", @"scan_history"];
        
        [db executeUpdate:sql];
    }];
}

- (NSArray *)getAllScanHistorysFromDB
{
    __block NSMutableArray *array = nil;
	[self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select product_code,product_id,product_name,price,evaluation,city_code,aux_description,product_imageurl from scan_history order by julianday(add_dttm) desc limit 50"];
        
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
            dto.price = [NSNumber numberWithFloat:[[rs stringForColumn:@"price"] floatValue]];
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
    
    if (data.isCShop) {
        
        //如果有marketPrice，默认取marketPrice
        if (data.marketPrice.doubleValue > 0) {
            data.price = data.marketPrice;
        }else if (data.suningPrice.doubleValue > 0){
            data.price = data.suningPrice;
        }
    }
    else
    {
        data.price = data.suningPrice;
    }
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        
        NSString *sql = [NSString stringWithFormat:@"replace into scan_history(product_code,product_id,product_name,price,evaluation,city_code,aux_description,product_imageurl,add_dttm)values(?,?,?,?,?,?,?,?,?);"];
        
        [db executeUpdate:sql,data.productCode,data.productId,data.productName,[data.price stringValue],data.evaluation,data.cityCode,data.special,[data.productImageURL absoluteString],[NSDate date]];
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
        NSString *sql = [NSString stringWithFormat:@"delete from scan_history where product_code = ?"];
        
        [db executeUpdate:sql,data.productCode];
        
    }];
    
    
    return YES;
}

@end
