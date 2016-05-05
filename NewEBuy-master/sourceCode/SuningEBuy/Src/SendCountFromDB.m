//
//  SendCountFromDB.m
//  SuningEBuy
//
//  Created by shasha on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SendCountFromDB.h"

@implementation SendCountFromDB

- (void)deleteSendCountFromDB:(NSString *)phoneNum{
    //后台执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            [self.databaseQueue inDatabase:^(FMDatabase *db){
                NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ? ",kDataBaseSendCountTableName,@"phoneNum"];
                DLog(@"getShelfArray SQL:%@",sql);
                [db executeUpdate:sql,phoneNum]; 
            }];
        }
    });
}

- (int)getSendCountFromDB:(NSString *)todayDate withPhoneNum:(NSString *)phoneNum{
    
    __block int count = 0;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"SELECT count FROM %@ where %@=? AND %@=?",kDataBaseSendCountTableName,@"phonenum",@"todaydate"];
        DLog(@"getShelfArray SQL:%@",sql);
        //CREATE TABLE IF NOT EXISTS dic_sendCount (count text,phonenum text PRIMARY KEY,todaydate text)
        
        FMResultSet *rs = [db executeQuery:sql,phoneNum,todayDate];	
        
        if(!rs){
            [rs close];
            count = -2;
            return;
        }
        
        count = -1;
        
        while ([rs next]) {	
            
            NSString *countString = [rs stringForColumn:@"count"];
            
            count = [countString intValue];
            
            break;
        }	
        //DLog(@"Province -- the size of the array :%d",array.count);
        [rs close];	
    }];
    
	return count;
    
}

- (void)updateSendCountToDB:(NSString *)phoneNum date:(NSString *)todayDate count:(int)sendCount{
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(count,phonenum,todaydate) VALUES(?,?,?)",kDataBaseSendCountTableName];
        
        NSString *count = [NSString stringWithFormat:@"%d",sendCount];
        
        [db executeUpdate:sql,count,phoneNum,todayDate]; 
    }];
    
}

@end
