//
//  DAO.m
//  SuningEBuy
//
//  Created by liukun on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DAO.h"
#import "DatabaseManager.h"

@implementation DAO

@synthesize databaseQueue = _databaseQueue;



- (id)init{
    self = [super init];
    
	if(self)
    {
        
		self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
	}
    
	return self;
}


- (FMDatabaseQueue *)databaseQueue
{
    if (![[DatabaseManager currentManager] isDatabaseOpened]) {
        [[DatabaseManager currentManager] openDataBase];
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
        if (_databaseQueue)  [DAO createTablesNeeded];
    }
    return _databaseQueue;
}

+ (void)createTablesNeeded
{
    @autoreleasepool {
        FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
        
        
        [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
            
            //信息收集的表建立
            
            /*info_system*/
            NSString *sql4 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS info_system (system_id INTEGER PRIMARY KEY NOT NULL,app_version TEXT NOT NULL,sys_kind TEXT NOT NULL,os_version TEXT NOT NULL,platform TEXT NOT NULL,user_ip TEXT NOT NULL,unique_id TEXT NOT NULL,session_id TEXT NOT NULL,app_down_way TEXT NOT NULL,field1 TEXT,field2 TEXT)"];
            
            /*info_useinfo*/
            NSString *sql5 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS info_useinfo (useinfo_id INTEGER PRIMARY KEY NOT NULL,is_login TEXT NOT NULL,login_name TEXT,app_start_time TEXT NOT NULL,app_stop_time TEXT NOT NULL)"];
            
            /*info_search*/
            NSString *sql8 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS info_search (search_id INTEGER PRIMARY KEY NOT NULL,is_login TEXT NOT NULL,login_name TEXT,search_key TEXT NOT NULL,search_result TEXT NOT NULL)"];
            
            /*info_page*/
            NSString *sql9 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS info_page (page_id INTEGER PRIMARY KEY NOT NULL,is_login TEXT NOT NULL,login_name TEXT,page_key TEXT NOT NULL,page_name TEXT NOT NULL,page_in_time TEXT NOT NULL,page_out_time TEXT NOT NULL)"];
            
            /*info_crash*/
            NSString *sql10 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS info_crash (crash_id INTEGER PRIMARY KEY NOT NULL,is_login TEXT NOT NULL,login_name TEXT,crash_info TEXT NOT NULL)"];
            
            //浏览历史记录的表
            
            /*browsing_history*/
//            NSString *sql11 = @"CREATE TABLE IF NOT EXISTS browsing_history (history_id integer PRIMARY KEY NOT NULL, product_code text unique, product_id text, product_name text, price text, evaluation text, city_code text, aux_description text, product_imageurl text, add_dttm real)";
            
            /*browsing_history*/
            NSString *sql11_n = @"CREATE TABLE IF NOT EXISTS browsing_history_n (history_id integer PRIMARY KEY NOT NULL, product_id text unique, product_code text, shop_code text, product_name text, price text, evaluation text, city_code text, aux_description text, product_imageurl text, add_dttm real)";
            
            /*search_history*/
            NSString *sql12 = @"CREATE TABLE IF NOT EXISTS search_history (keyword_id integer PRIMARY KEY NOT NULL, keywords text UNIQUE)";
            
            /*扫描历史记录*/
            NSString *sql12_1 = @"CREATE TABLE IF NOT EXISTS scan_history (history_id integer PRIMARY KEY NOT NULL, product_id text unique, product_code text, product_name text, price text, evaluation text, city_code text, aux_description text, product_imageurl text, add_dttm real)";
            
            // 短信发送次数表格的建立。
            //dic_sendCount
            NSString  *sql13 = @"CREATE TABLE IF NOT EXISTS dic_sendCount (count text,phonenum text PRIMARY KEY,todaydate text);";
            
            //地址表
            /*dic_province*/
            NSString *sql14 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS dic_province (province_id INTEGER PRIMARY KEY NOT NULL, province_code TEXT NOT NULL, province_name TEXT NOT NULL)"];
            
            /*dic_city*/
            NSString *sql15 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS dic_city (city_id INTEGER PRIMARY KEY NOT NULL, city_code TEXT NOT NULL, city_name TEXT NOT NULL, province_code TEXT NOT NULL)"];
            
            //来源渠道   渠道明细  商品编码  价格---二维码销售明细
            NSString *sql16 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS dic_sell (source_channel TEXT  NOT NULL, channel_detail TEXT NOT NULL, produce_code TEXT NOT NULL, produce_price TEXT NOT NULL)"];
              
            [database executeUpdate:sql4];
            [database executeUpdate:sql5];
            [database executeUpdate:sql8];
            [database executeUpdate:sql9];
            [database executeUpdate:sql10];
            [database executeUpdate:sql11_n];
            [database executeUpdate:sql12];
            [database executeUpdate:sql12_1];
            [database executeUpdate:sql13];
            [database executeUpdate:sql14];
            [database executeUpdate:sql15];
            [database executeUpdate:sql16];
             
        }];
        
    } 
}


@end