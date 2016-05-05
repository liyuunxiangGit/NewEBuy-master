//
//  AddressInfoDAO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

static BOOL isUpdateAddressOk = NO;
static BOOL isUpdateProviceOk = NO;
static BOOL isUpdateCityOk = NO;
static BOOL isLoadingProvince = NO;
static BOOL isLoadingCity = NO;

#import "AddressInfoDAO.h"

static AddressInfoDAO *sharedUpdateDAO = nil;

@interface AddressInfoDAO()

@property (nonatomic, strong) AddressInfoService *service;

- (void)updateAddressInfo;

@end

/*********************************************************************/

@implementation AddressInfoDAO

@synthesize service = _service;

- (void)dealloc {
    SERVICE_RELEASE_SAFELY(_service);
}

+ (BOOL)isUpdateAddressOk
{
    if (!isUpdateAddressOk) {
        if (isLoadingCity || isLoadingProvince)
        {
            
        }
        else
        {
            sharedUpdateDAO = [[AddressInfoDAO alloc] init];
            [sharedUpdateDAO updateAddressInfo];
        }
    }
    return isUpdateAddressOk;
}

- (BOOL)isNeedUpdate
{
    NSNumber *lastUpdateDttm = [Config currentConfig].addressUpdateDttm;
    NSDate *lastUpdateTime = [NSDate dateWithTimeIntervalSince1970:[lastUpdateDttm doubleValue]];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastUpdateTime];
    //离上次更新时间超过一天则更新
    if (interval > 60*60*24) {
        return YES;
    }
   
    return NO;
}


- (void)updateAddressInfo
{
    //每天更新一次
    if (![self isNeedUpdate]) {
        isUpdateProviceOk = YES;
        isUpdateCityOk = YES;
        isUpdateAddressOk = YES;
        //        sharedUpdateDAO = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:ADDRESS_UPDATE_OK_MESSAGE
                                                            object:nil];
        
        return;
    }
    if (!_service) {
        self.service = [[AddressInfoService alloc] init];
        self.service.delegate = self;
    }
    
    if (!isUpdateProviceOk && !isLoadingProvince)
    {
        NSNumber *addressUpdateLast = [Config currentConfig].addressUpdateProvinceLast;
        NSDate *lastSendUpdateTime = [NSDate dateWithTimeIntervalSince1970:[addressUpdateLast doubleValue]];
        NSTimeInterval sendInterval = [[NSDate date] timeIntervalSinceDate:lastSendUpdateTime];
        if (sendInterval < 60) {
            return;
        }
        
        
        NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        [Config currentConfig].addressUpdateProvinceLast = [NSNumber numberWithDouble:currentTimeInterval];
        

        isLoadingProvince = YES;
        //进入后台线程，为了能够接收回调，retain一次
        [self.service beginGetProvinceList];
    }
    
    if (!isUpdateCityOk && !isLoadingCity)
    {
        NSNumber *addressUpdateLast = [Config currentConfig].addressUpdateProvinceCodeLast;
        NSDate *lastSendUpdateTime = [NSDate dateWithTimeIntervalSince1970:[addressUpdateLast doubleValue]];
        NSTimeInterval sendInterval = [[NSDate date] timeIntervalSinceDate:lastSendUpdateTime];
        if (sendInterval < 60) {
            return;
        }
        
        
        NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        [Config currentConfig].addressUpdateProvinceCodeLast = [NSNumber numberWithDouble:currentTimeInterval];
        

        
        isLoadingCity = YES;
        //进入后台线程，为了能够接收回调，retain一次
        [self.service beginGetCityListByProvinceCode:nil];
    }
    
}

#pragma mark -
#pragma mark service delegate

- (void)requestFinished
{
    if (isUpdateProviceOk && isUpdateCityOk)
    {
        isUpdateAddressOk = YES;
        NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        [Config currentConfig].addressUpdateDttm = [NSNumber numberWithDouble:currentTimeInterval];
        [[NSNotificationCenter defaultCenter] postNotificationName:ADDRESS_UPDATE_OK_MESSAGE
                                                            object:nil];
        
//        sharedUpdateDAO = nil;
    }
    
    if (!isLoadingProvince && !isLoadingCity)
    {
        self.service = nil;
    }
}

- (void)getProvinceListCompletionWithResult:(BOOL)isSuccess 
                               provinceList:(NSArray *)list
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            if (isSuccess && list && [list count] > 0) {
                
                if ([self updateProvices:list])
                {
                    DLog(@"\n ======Update province======= \n Update province ok, province count is %d \n ======Update province======= \n", [list count]);
                    isUpdateProviceOk = YES;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isLoadingProvince = NO;
                [self requestFinished];
            });
        } 
    });
}

- (void)getCityListCompletionWithResult:(BOOL)isSuccess 
                               cityList:(NSArray *)list
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            if (isSuccess && list && [list count] > 0) {
                                
                if ([self updateCitys:list])
                {
                    DLog(@"\n ======Update city======= \n Update city ok, city count is %d \n ======Update city======= \n", [list count]);
                    isUpdateCityOk = YES;
                }
            
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isLoadingCity = NO;
                [self requestFinished];
            });

        } 
    });
}

//update
- (BOOL)updateProvices:(NSArray *)provinces
{
    __block BOOL isSuccess = NO;
    
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *deleteSql = @"delete from dic_province";
        if (![db executeUpdate:deleteSql])
        {
            *rollback = YES;
            return;
        }
        
        NSString *insertSql = @"insert into dic_province(province_code, province_name)values(?,?)";
        for (AddressInfoDTO *dto in provinces)
        {
            if (![db executeUpdate:insertSql, dto.province, dto.provinceContent])
            {
                *rollback = YES;
                return;
            }
        }
        
        isSuccess = YES;
    }];
    
    return isSuccess;
}

- (BOOL)updateCitys:(NSArray *)citys
{
    __block BOOL isSuccess = NO;
    
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *deleteSql = @"delete from dic_city";
        if (![db executeUpdate:deleteSql])
        {
            *rollback = YES;
            return;
        }
        
        NSString *insertSql = @"insert into dic_city(city_code,city_name,province_code)values(?,?,?)";
        for (AddressInfoDTO *dto in citys)
        {
            if (![db executeUpdate:insertSql, dto.city, dto.cityContent, dto.province])
            {
                *rollback = YES;
                return;
            }
        }
        
        isSuccess = YES;
    }];
    
    return isSuccess;
}


#pragma mark -
#pragma mark db method

- (NSArray *)getAllProvince{
	
	//DLog(@"getShelfArray SQL:%@",sql);
    
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select province_code,province_name from dic_province order by province_code"];
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:32];	
        while ([rs next]) {			
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            [dto setProvince:[rs stringForColumn:kDatabaseProvinceCode ]];
            [dto setProvinceContent:[rs stringForColumn:kDatabaseProvinceName]];
            
            [array addObject:dto];
        }	
        //DLog(@"Province -- the size of the array :%d",array.count);
        [rs close];	
    }];
    return array;
}


//add by gjf
-(NSString *)setProvinceCode:(NSString *)cityCode{
    if (cityCode == nil) {
		return nil;
	}
    __block NSString *provinceCode = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select c.city_name,c.province_code from dic_city c where c.city_code = ?"];
        //DLog(@"getContent SQL:%@",sql);
        FMResultSet *rs = [db executeQuery:sql,cityCode];
        if(!rs){
            [rs close];
            return;
        }
        
        while ([rs next]) {
            provinceCode = [rs stringForColumn:kDatabaseProvinceCode];
            break;
        }
        
        //DLog(@"City -- the size of the array :%d",array.count);
        [rs close];
    }];
    return provinceCode;
}


- (NSArray *)getCityByProvinceCode:(NSString *)provinceCode {
	if (provinceCode == nil) {
		return nil;
	}	
    __block NSMutableArray *array = nil;
    
	[self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select c.city_code,c.city_name,c.province_code from dic_city c where c.province_code = ?"];
        //DLog(@"getContent SQL:%@",sql);
        FMResultSet *rs = [db executeQuery:sql,provinceCode];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:16];	
        while ([rs next]) {		
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            [dto setCity:[rs stringForColumn:kDatabaseCityCode]];
            [dto setCityContent:[rs stringForColumn:kDatabaseCityName]];		
            [dto setProvince:[rs stringForColumn:kDatabaseProvinceCode]];
            [array addObject:dto];		
            
        }	
        //DLog(@"City -- the size of the array :%d",array.count);
        [rs close];
    }];
    return array;
}

- (NSString *)getCityNameByCityCode:(NSString *)cityCode
{
    
    if (cityCode == nil) {
		return nil; 
	}
    
    __block NSString *cityName = nil;
	
	[self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString 
                         stringWithFormat:@"select city_name from dic_city where city_code= ?"];
        
        FMResultSet *rs = [db executeQuery:sql,cityCode];	
        if(!rs){
            [rs close];
            return;
        }	
        
        while ([rs next]) {	
            cityName = [rs stringForColumn:@"city_name"];
            break;
        }
        
        [rs close];
    }];
	
	
	return cityName;
    
}

- (NSString *)getProvinceNameByProvinceCode:(NSString *)provinceCode{
    if (provinceCode == nil) {
		return nil; 
	}
	
    __block NSString *provinceName = nil;
	
	[self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString 
                         stringWithFormat:@"select province_name from dic_province where province_code= ?"];
        
        FMResultSet *rs = [db executeQuery:sql,provinceCode];	
        if(!rs){
            [rs close];
            return;
        }	
        
        while ([rs next]) {	
            provinceName = [rs stringForColumn:@"province_name"];
            break;
        }
        
        [rs close];
        
    }];	
	
	return provinceName;
}

- (AddressInfoDTO *)getProvinceAndCityInfoByCityCode:(NSString *)cityCode
{
	if (cityCode == nil) {
        return nil;
    }
    __block AddressInfoDTO *addressInfo = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = @"select distinct a.city_code,a.city_name,b.province_code,b.province_name from dic_city a,dic_province b where a.city_code = ? and a.province_code = b.province_code";
        FMResultSet *rs = [db executeQuery:sql, cityCode];
        if (!rs) {
            [rs close];
            return;
        }
        while ([rs next]) {
            addressInfo = [[AddressInfoDTO alloc] init];
            addressInfo.province = [rs stringForColumn:@"province_code"];
            addressInfo.provinceContent = [rs stringForColumn:@"province_name"];
            addressInfo.city = [rs stringForColumn:@"city_code"];
            addressInfo.cityContent = [rs stringForColumn:@"city_name"];
            break;
        }
        [rs close];
    }];
    return addressInfo;
}

- (AddressInfoDTO *)getProvinceAndCityInfoByCityName:(NSString *)cityName
{
	if (cityName == nil) {
        return nil;
    }
    __block AddressInfoDTO *addressInfo = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = @"select distinct a.city_code,a.city_name,b.province_code,b.province_name from dic_city a,dic_province b where a.city_name = ? and a.province_code = b.province_code";
        FMResultSet *rs = [db executeQuery:sql, cityName];
        if (!rs) {
            [rs close];
            return;
        }
        while ([rs next]) {
            addressInfo = [[AddressInfoDTO alloc] init];
            addressInfo.province = [rs stringForColumn:@"province_code"];
            addressInfo.provinceContent = [rs stringForColumn:@"province_name"];
            addressInfo.city = [rs stringForColumn:@"city_code"];
            addressInfo.cityContent = [rs stringForColumn:@"city_name"];
            break;
        }
        [rs close];
    }];
    return addressInfo;
}

- (AddressInfoDTO *)getProvinceAndCityInfoLikeCityName:(NSString *)cityName
{
    if (cityName == nil) {
        return nil;
    }
    
    if ([cityName hasSuffix:L(@"Constant_City")])
    {
        cityName = [cityName substringToIndex:[cityName length]-1];
    }
    
    cityName = [cityName stringByAppendingString:@"%"];
    
    __block AddressInfoDTO *addressInfo = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = @"select distinct a.city_code,a.city_name,b.province_code,b.province_name from dic_city a,dic_province b where a.city_name like ? and a.province_code = b.province_code";
        FMResultSet *rs = [db executeQuery:sql, cityName];
        if (!rs) {
            [rs close];
            return;
        }
        while ([rs next]) {
            addressInfo = [[AddressInfoDTO alloc] init];
            addressInfo.province = [rs stringForColumn:@"province_code"];
            addressInfo.provinceContent = [rs stringForColumn:@"province_name"];
            addressInfo.city = [rs stringForColumn:@"city_code"];
            addressInfo.cityContent = [rs stringForColumn:@"city_name"];
            break;
        }
        [rs close];
    }];
    return addressInfo;
}

#pragma mark -
#pragma mark 清空数据库

- (void)deleteProvincesFromDB
{
    NSString *sql1 = [NSString stringWithFormat:@"delete from dic_province"];
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        [db executeUpdate:sql1]; 
    }];
}

- (void)deleteCitysFromDB
{
    NSString *sql2 = [NSString stringWithFormat:@"delete from dic_city"];
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        [db executeUpdate:sql2]; 
    }];
}


@end
