//
//  OnlineServiceDAO.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OnlineServiceDAO.h"

@implementation OnlineServiceDAO

+ (NSString *)createTableSql
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS os_message (\
    msg_id integer PRIMARY KEY NOT NULL,\
    product_code text unique,\
    product_id text,\
    product_name text,\
    price text,\
    evaluation text,\
    city_code text,\
    aux_description text,\
    product_imageurl text,\
    add_dttm real);";
    return sql;
}

@end
