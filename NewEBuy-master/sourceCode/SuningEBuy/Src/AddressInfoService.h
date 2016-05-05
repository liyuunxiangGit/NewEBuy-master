//
//  AddressInfoService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      AddressInfoService
 @abstract    地址信息的获取
 @author      刘坤
 @version     v1.0.002  12-8-28
 */


/*!
 @protocol       AddressInfoServiceDelegate
 @abstract       AddressInfoService的一个代理
 @discussion     获取省、市、区、镇完成的回调
 */
@protocol AddressInfoServiceDelegate <NSObject>

@optional
/*!
 @method        getProvinceListCompletionWithResult:provinceList:
 @abstract      获取省份列表完成回调
 @param         isSuccess  是否获取成功
 @param         list 省份列表数组 数组元素：AddressInfoDTO
 */
- (void)getProvinceListCompletionWithResult:(BOOL)isSuccess 
                               provinceList:(NSArray *)list;


/*!
 @method        getCityListCompletionWithResult:cityList:
 @abstract      获取城市列表完成回调
 @param         isSuccess  是否获取成功
 @param         list 城市列表数组 数组元素：AddressInfoDTO
 */
- (void)getCityListCompletionWithResult:(BOOL)isSuccess 
                               cityList:(NSArray *)list;


/*!
 @method        getDistrictListCompletionWithResult:districtList:
 @abstract      获取区列表完成回调
 @param         isSuccess  是否获取成功
 @param         list 区列表数组 数组元素：AddressInfoDTO
 */
- (void)getDistrictListCompletionWithResult:(BOOL)isSuccess 
                               districtList:(NSArray *)list;


/*!
 @method        getTownListCompletionWithResult:townList:
 @abstract      获取镇列表完成回调
 @param         isSuccess  是否获取成功
 @param         list 镇列表数组 数组元素：AddressInfoDTO
 */
- (void)getTownListCompletionWithResult:(BOOL)isSuccess 
                               townList:(NSArray *)list;

@end

//------------------------------------------------------------------------


#import "DataService.h"
/*!
 @class     AddressInfoService
 @abstract  地址
 */
@interface AddressInfoService : DataService
{
    HttpMessage     *provinceHttpMsg;
    HttpMessage     *cityHttpMsg;
    HttpMessage     *districtHttpMsg;
    HttpMessage     *townHttpMsg;
}

@property (nonatomic, weak) id<AddressInfoServiceDelegate> delegate;

@property (nonatomic, strong) NSDictionary *provinceDic;
@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *districtDic;
@property (nonatomic, strong) NSDictionary *townDic;


/*!
 @method        beginGetProvinceList
 @abstract      获取省份列表
 */
- (void)beginGetProvinceList;


/*!
 @method        beginGetCityListByProvinceCode:
 @abstract      获取某一省份下的城市列表
 @param         provinceCode  省份的id ， 当传入nil 或空字符串时， 默认获取所有城市
 */
- (void)beginGetCityListByProvinceCode:(NSString *)provinceCode;


/*!
 @method        beginGetDistrictListByCityCode:
 @abstract      获取某一城市下的区列表
 @param         cityCode  城市id
 */
- (void)beginGetDistrictListByCityCode:(NSString *)cityCode;


/*!
 @method        beginGetTownListByDistrictCode:
 @abstract      获取区下的镇列表
 @param         districtCode  区id
 */
- (void)beginGetTownListByDistrictCode:(NSString *)districtCode;


/*!
 @method        cancelHttpRequest
 @abstract      取消城市、区、镇的数据请求
 @discussion    在AddressInfoPickerView中获取数据之前调用  需要取消市、区、镇的数据请求
 */
- (void)cancelHttpRequest;

@end
