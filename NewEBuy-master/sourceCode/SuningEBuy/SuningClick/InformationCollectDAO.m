//
//  InformationCollectDAO.m
//  SuningEBuy
//
//  Created by wangrui on 12/27/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import "InformationCollectDAO.h"

// 信息收集语句
#define SystemInfoSql       @"insert into info_system(app_version, sys_kind, os_version, platform, user_ip, unique_id, session_id, app_down_way, field1, field2) values (?,?,?,?,?,?,?,?,?,?);"

#define IphoneUseSql        @"insert into info_useinfo(is_login, login_name,app_start_time, app_stop_time) values(?,?,?,?);"
#define ProductSearchSql    @"insert into info_search(is_login, login_name,search_key,search_result) values(?,?,?,?);"
#define PageAccessingSql    @"insert into info_page(is_login, login_name,page_key,page_name,page_in_time,page_out_time) values(?,?,?,?,?,?);"
#define SystemCrashDownSql  @"insert into info_crash(is_login, login_name,crash_info) values(?,?,?);"

@implementation InformationCollectDAO

// Query
- (NSArray *)clientInformationsWithType:(ClientInfoMark)infoType
{
    __block NSMutableArray *resultArray = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = nil;
        
        NSString *tableName = nil;
        
        resultArray = [[NSMutableArray alloc] init];
        
        switch (infoType) 
        {
            case SystemInfoStat:
                
                tableName = SystemInfoTbl;
                
                break;
            case IphoneUsingStat:
                
                tableName = IphoneUseTbl;
                
                break;
            case ProductSearchStat:
                
                tableName = ProductSearchTbl;
                
                break;
            case PageAccessingStat:
                
                tableName = PageAccessingTbl;
                
                break;
            case SystemCrashDownStat:
                
                tableName = SystemCrashDownTbl;
                
                break;
            default:
                break;
        }
        
        sql = [NSString stringWithFormat:@"select * from %@", tableName];
        
        FMResultSet *rs = [db executeQuery:sql];
        
        if (rs == nil)
        {
            [rs close];
            
            return;
        }
        
        while ([rs next]) 
        {
            InformetionCollectDTO *dto = [[InformetionCollectDTO alloc] init];
            
            switch (infoType) 
            {
                case SystemInfoStat:
                    
                    dto.appVersion = [rs stringForColumn:kHttpRequestAppVersion];
                    
                    dto.sysKind = [rs stringForColumn:kHttpRequestSysKind];
                    
                    dto.osVersion = [rs stringForColumn:kHttpRequestOsVersion];
                    
                    dto.platform = [rs stringForColumn:kHttpRequestPlatform];
                    
                    dto.userIP = [rs stringForColumn:kHttpRequestUserIP];
                    
                    dto.uniqueId = [rs stringForColumn:kHttpRequestUniqueId];
                    
                    dto.sessionId = [rs stringForColumn:kHttpRequestSessionId];
                    
                    dto.appDownWay = [rs stringForColumn:kHttpRequestAppDownWay];
                    
                    dto.field1 = [rs stringForColumn:kHttpRequestField1];
                    
                    dto.field2 = [rs stringForColumn:kHttpRequestField2];
                    
                    [resultArray addObject:dto];
                    
                    TT_RELEASE_SAFELY(dto);
                    
                    [rs close];
                    
                    return;
                    
                    break;
                case IphoneUsingStat:
                    
                    dto.isLogin = [rs stringForColumn:kHttpRequestIsLogin];
                    
                    dto.loginName = [rs stringForColumn:kHttpRequestLoginName];
                    
                    dto.appStartTime = [rs stringForColumn:kHttpRequestAppStartTime];
                    
                    dto.appStopTime = [rs stringForColumn:kHttpRequestAppStopTime];
                    
                    break;
                case ProductSearchStat:
                    
                    dto.isLogin = [rs stringForColumn:kHttpRequestIsLogin];
                    
                    dto.loginName = [rs stringForColumn:kHttpRequestLoginName];
                    
                    dto.searchKey = [rs stringForColumn:kHttpRequestSearchKey];
                    
                    dto.searchResult = [rs stringForColumn:kHttpRequestSearchResult];
                    
                    break;
                case PageAccessingStat:
                    
                    dto.isLogin = [rs stringForColumn:kHttpRequestIsLogin];
                    
                    dto.loginName = [rs stringForColumn:kHttpRequestLoginName];
                    
                    dto.pageName = [rs stringForColumn:kHttpRequestPageName];
                    
                    dto.pageKey = [rs stringForColumn:kHttpRequestPageKey];
                    
                    dto.pageInTime = [rs stringForColumn:kHttpRequestPageInTime];
                    
                    dto.pageOutTime = [rs stringForColumn:kHttpRequestPageOutTime];
                    
                    break;
                case SystemCrashDownStat:
                    
                    dto.isLogin = [rs stringForColumn:kHttpRequestIsLogin];
                    
                    dto.loginName = [rs stringForColumn:kHttpRequestLoginName];
                    
                    dto.crashInfo = [rs stringForColumn:kHttpRequestCrashInfo];
                    
                    break;
                default:
                    break;
            }
            
            [resultArray addObject:dto];
            
            TT_RELEASE_SAFELY(dto);
        }
        
        [rs close];
        
    }];
    
    return resultArray;
}

// Insert
- (void)insertCollectedInfoWithType:(ClientInfoMark)infoType infoData:(InformetionCollectDTO *)infoDto
{
    if (infoDto == nil)
    {
        return;
    }
    
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = nil;
        
        switch (infoType) 
        {
            case SystemInfoStat:
                
                sql = [NSString stringWithFormat:SystemInfoSql];
                
                [db executeUpdate:sql, infoDto.appVersion,infoDto.sysKind,infoDto.osVersion,
                 infoDto.platform,infoDto.userIP,infoDto.uniqueId,
                 infoDto.sessionId,infoDto.appDownWay,infoDto.field1,infoDto.field2
                 ];
                
                if (db.hadError)
                {
                    DLog(@"Error occurred when execute sql: %@, and the error message is %@", sql, db.lastErrorMessage);
                }
                
                break;
            case IphoneUsingStat:
                
                sql = [NSString stringWithFormat:IphoneUseSql];
                
                [db executeUpdate:sql, infoDto.isLogin,infoDto.loginName,infoDto.appStartTime,infoDto.appStopTime];
                
                if (db.hadError)
                {
                    DLog(@"Error occurred when execute sql: %@, and the error message is %@", sql, db.lastErrorMessage);
                }
                
                break;
            case ProductSearchStat:
                
                sql = [NSString stringWithFormat:ProductSearchSql];
                
                [db executeUpdate:sql, infoDto.isLogin,infoDto.loginName,infoDto.searchKey,infoDto.searchResult];
                
                if (db.hadError)
                {
                    DLog(@"Error occurred when execute sql: %@, and the error message is %@", sql, db.lastErrorMessage);
                }
                
                break;
            case PageAccessingStat:
                
                sql = [NSString stringWithFormat:PageAccessingSql];
                
                [db executeUpdate:sql, infoDto.isLogin,infoDto.loginName,infoDto.pageKey,infoDto.pageName,infoDto.pageInTime,
                 infoDto.pageOutTime];
                
                if (db.hadError)
                {
                    DLog(@"Error occurred when execute sql: %@, and the error message is %@", sql, db.lastErrorMessage);
                }
                
                break;
            case SystemCrashDownStat:
                
                sql = [NSString stringWithFormat:SystemCrashDownSql];
                
                [db executeUpdate:sql, infoDto.isLogin,infoDto.loginName,infoDto.crashInfo];
                
                if (db.hadError)
                {
                    DLog(@"Error occurred when execute sql: %@, and the error message is %@", sql, db.lastErrorMessage);
                }
                
                break;
            default:
                break;
        }
        
    }];
    
    
}

// Delete
- (BOOL)clearCollectedInformationData
{
    __block BOOL success = NO;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSArray *dataTables = [NSArray arrayWithObjects:SystemInfoTbl,IphoneUseTbl,ProductSearchTbl,
                               PageAccessingTbl,SystemCrashDownTbl,
                               nil];
        
        success = YES;
        
        NSString *sql = nil;
        
        for (NSString *tableName in dataTables)
        {
            sql = [NSString stringWithFormat:@"delete from %@", tableName];
            
            [db executeUpdate:sql];
            
            if (db.hadError) 
            {
                success = NO;
                
                DLog(@"Error occurred when clear table %@, and the error message is %@", tableName, db.lastErrorMessage);
                
                break;
                
            }
        }
        
    }];
    return success;
}


- (BOOL)clearIphoneUseTblInformationData
{
    __block BOOL sucess = YES;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = nil;
        
        sql = [NSString stringWithFormat:@"delete from %@", IphoneUseTbl];
        
        [db executeUpdate:sql];
        
        if (db.hadError) 
        {
            sucess = NO;
        } 
    }];
    
    return sucess;
}



@end
