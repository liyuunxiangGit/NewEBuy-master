//
//  AddressInfoDAO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      AddressInfoDAO
 @abstract    地址信息的数据库操作，包括地址更新
 @author      刘坤
 @version     v1.0.002  12-8-28
 */

#import "DAO.h"
#import "AddressInfoDTO.h"
#import "AddressInfoService.h"

#define ADDRESS_UPDATE_OK_MESSAGE       @"ADDRESS_UPDATE_OK_MESSAGE"

@interface AddressInfoDAO : DAO <AddressInfoServiceDelegate>

/*!
 @method        isUpdateAddressOk
 @abstract      省份和城市是否更新到本地数据库 ,只有在该方法返回yes时，后面的方法才能被调用
 @result        BOOL    yes，更新成功
 */
+ (BOOL)isUpdateAddressOk;

//update
- (BOOL)updateProvices:(NSArray *)provinces;
- (BOOL)updateCitys:(NSArray *)citys;

//query
- (NSArray *)getAllProvince;
- (NSArray *)getCityByProvinceCode:(NSString *)provinceCode;
- (NSString *)getProvinceNameByProvinceCode:(NSString *)provinceCode;
- (NSString *)getCityNameByCityCode:(NSString *)cityCode;
- (AddressInfoDTO *)getProvinceAndCityInfoByCityCode:(NSString *)cityCode;
- (AddressInfoDTO *)getProvinceAndCityInfoByCityName:(NSString *)cityName;

//add by gjf
-(NSString *)setProvinceCode:(NSString *)cityCode;

//查询类似的
- (AddressInfoDTO *)getProvinceAndCityInfoLikeCityName:(NSString *)cityName;

//delete
- (void)deleteProvincesFromDB;
- (void)deleteCitysFromDB;

@end
