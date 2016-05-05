//
//  AddressInfoService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AddressInfoService.h"
#import "AddressInfoDTO.h"

@interface AddressInfoService()

- (void)getProvinceDidFinish:(BOOL)isSuccess list:(NSArray *)list;
- (void)getCityDidFinish:(BOOL)isSuccess list:(NSArray *)list;
- (void)getDistrictDidFinish:(BOOL)isSuccess list:(NSArray *)list;
- (void)getTownDidFinish:(BOOL)isSuccess list:(NSArray *)list;


- (void)parseProvince:(NSDictionary *)item;
- (void)parseCity:(NSDictionary *)item;
- (void)parseDistrict:(NSDictionary *)item;
- (void)parseTown:(NSDictionary *)item;

@end

/*********************************************************************/

@implementation AddressInfoService

@synthesize delegate = _delegate;


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(provinceHttpMsg);
    HTTPMSG_RELEASE_SAFELY(cityHttpMsg);
    HTTPMSG_RELEASE_SAFELY(districtHttpMsg);
    HTTPMSG_RELEASE_SAFELY(townHttpMsg);
}

- (void)cancelHttpRequest
{
    HTTPMSG_RELEASE_SAFELY(cityHttpMsg);
    HTTPMSG_RELEASE_SAFELY(districtHttpMsg);
    HTTPMSG_RELEASE_SAFELY(townHttpMsg);
}

#pragma mark -
#pragma mark operation

- (void)beginGetProvinceList
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneProvinceView"];
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey, nil];
    
    HTTPMSG_RELEASE_SAFELY(provinceHttpMsg);
    self.provinceDic = nil;
    provinceHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_AddressProvince];
    provinceHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:provinceHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginGetCityListByProvinceCode:(NSString *)provinceCode
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneCityView"];
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey, 
                                 provinceCode?provinceCode:@"", @"provinceCode",
                                 nil];
    
    HTTPMSG_RELEASE_SAFELY(cityHttpMsg);
    self.cityDic = nil;
    cityHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:postDataDic
                                                cmdCode:CC_AddressCity];
    cityHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:cityHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginGetDistrictListByCityCode:(NSString *)cityCode
{
//    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneDistrictView"];
//    
//    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey,
//                                 cityCode?cityCode:@"", @"cityID",
//                                 nil];
//
//    kHostAddressForHtml
    
//    伪静态请求链接：
//http://b2cpre.cnsuning.com/emall/snmtDistrict_{storeId}_{cityID}_.html
//    伪静态请求样例：
//http://b2cpre.cnsuning.com/emall/snmtDistrict_10052_9173_.html
    
    NSDictionary *postDataDic = [[NSDictionary alloc] init];
    
    NSString *url = nil;
    
    url = [NSString stringWithFormat:@"%@/snmtDistrict_%@_%@_.html",
           kHostAddressForHtml,
           @"10052",
           cityCode?cityCode:@""];

    
    
    HTTPMSG_RELEASE_SAFELY(districtHttpMsg);
    self.districtDic = nil;
    districtHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_AddressDistrict];
    districtHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:districtHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}


- (void)beginGetTownListByDistrictCode:(NSString *)districtCode
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneTownView"];
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey,
                                 districtCode?districtCode:@"", @"distID",
                                 nil];
    
    HTTPMSG_RELEASE_SAFELY(townHttpMsg);
    self.townDic = nil;
    townHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:postDataDic
                                                cmdCode:CC_AddressTown];
    townHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:townHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark customer method

- (void)getProvinceDidFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getProvinceListCompletionWithResult:provinceList:)])
    {
        [_delegate getProvinceListCompletionWithResult:isSuccess provinceList:list];
    }
}

- (void)getCityDidFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getCityListCompletionWithResult:cityList:)]) {
        [_delegate getCityListCompletionWithResult:isSuccess cityList:list];
    }
}

- (void)getDistrictDidFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getDistrictListCompletionWithResult:districtList:)]) {
        [_delegate getDistrictListCompletionWithResult:isSuccess districtList:list];
    }
}

- (void)getTownDidFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getTownListCompletionWithResult:townList:)]) {
        [_delegate getTownListCompletionWithResult:isSuccess townList:list];
    }
}

#pragma mark -
#pragma mark service delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    switch (receiveMsg.cmdCode) {
        case CC_AddressProvince:
        {
            [self getProvinceDidFinish:NO list:nil];
            break;
        }
        case CC_AddressCity:
        {
            [self getCityDidFinish:NO list:nil];
            break;
        }
        case CC_AddressDistrict:
        {
            [self getDistrictDidFinish:NO list:nil];
            break;
        }
        case CC_AddressTown:
        {
            [self getTownDidFinish:NO list:nil];
            break;
        }
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    switch (receiveMsg.cmdCode) {
        case CC_AddressProvince:
        {
            if (receiveMsg.jasonItems) {
                [self parseProvince:receiveMsg.jasonItems];
            }else{
                [self getProvinceDidFinish:NO list:nil];
            }
            break;
        }
        case CC_AddressCity:
        {
            if (receiveMsg.jasonItems) {
                [self parseCity:receiveMsg.jasonItems];
            }else{
                [self getCityDidFinish:NO list:nil];
            }
            break;
        }
        case CC_AddressDistrict:
        {
            if (receiveMsg.jasonItems) {
                [self parseDistrict:receiveMsg.jasonItems];
            } else {
                [self getDistrictDidFinish:NO list:nil];
            }
            break;
        }
        case CC_AddressTown:
        {
            if (receiveMsg.jasonItems) {
                [self parseTown:receiveMsg.jasonItems];
            } else {
                [self getTownDidFinish:NO list:nil];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark parse data

- (void)parseProvince:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *provinceList = [item objectForKey:@"provinceList"];
            NSArray *retArray = nil;
            if (NotNilAndNull(provinceList) && [provinceList count] > 0) {
                NSMutableArray *provinceArray = [[NSMutableArray alloc] initWithCapacity:[provinceList count]];
                NSMutableDictionary *provinceDic = [[NSMutableDictionary alloc] initWithCapacity:[provinceList count]];
                NSUInteger index = 0;
                for (NSDictionary *province in provinceList)
                {
                    NSString *provinceCode = [province objectForKey:@"provinceCode"];
                    NSString *provinceName = [province objectForKey:@"provinceName"];
                    
                    if (provinceCode.length && provinceName.length) {
                        
                        AddressInfoDTO *provinceInfo = [[AddressInfoDTO alloc] init];
                        provinceInfo.province = provinceCode;
                        provinceInfo.provinceContent = provinceName;
                        [provinceArray addObject:provinceInfo];
                        
                        [provinceDic setObject:@{@"dto": provinceInfo,
                                                 @"index": @(index)}
                                        forKey:provinceCode];
                        index ++;
                    }
                }
                retArray = [provinceArray copy];
                self.provinceDic = [provinceDic copy];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getProvinceDidFinish:YES list:retArray];
            });
        }
    });
}

- (void)parseCity:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *retArray = nil;
            NSArray *list = [item objectForKey:@"cityList"];
            if (NotNilAndNull(list) && [list count] > 0) {
                NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:[list count]];
                NSMutableDictionary *cityDic = [[NSMutableDictionary alloc] initWithCapacity:[list count]];
                NSUInteger index = 0;
                for (NSDictionary *dic in list)
                {
                    NSString *city = [dic objectForKey:@"cityNo"];
                    NSString *cityName = [dic objectForKey:@"cityName"];
                    NSString *provinceCode = [dic objectForKey:@"provinceCode"];

                    if (city.length && cityName.length) {
                        
                        AddressInfoDTO *info = [[AddressInfoDTO alloc] init];
                        info.city = city;
                        info.cityContent = cityName;
                        info.province = provinceCode;
                        [resultArray addObject:info];
                        [cityDic setObject:@{@"dto": info,
                                             @"index": @(index)}
                                    forKey:city];
                        index ++;
                    }
                    
                }
                retArray = [resultArray copy];
                self.cityDic = [cityDic copy];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getCityDidFinish:YES list:retArray];
            });
            
        } 
    });
}

- (void)parseDistrict:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *retArray = nil;
            NSArray *list = [item objectForKey:@"districtList"];
            if (NotNilAndNull(list) && [list count] > 0) {
                NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:[list count]];
                NSMutableDictionary *districtDic = [[NSMutableDictionary alloc] initWithCapacity:[list count]];
                NSUInteger index = 0;
                for (NSDictionary *dic in list)
                {
                    NSString *district = [dic objectForKey:@"distNo"];
                    NSString *districtName = [dic objectForKey:@"distName"];
                    
                    if (district.length && districtName.length) {
                        AddressInfoDTO *info = [[AddressInfoDTO alloc] init];
                        info.district = district;
                        info.districtContent = districtName;
                        [resultArray addObject:info];
                        [districtDic setObject:@{@"dto": info,
                                                 @"index": @(index)}
                                        forKey:district];
                        index ++;
                    }
                }
                retArray = [resultArray copy];
                self.districtDic = [districtDic copy];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getDistrictDidFinish:YES list:retArray];
            });

        } 
    });
}

- (void)parseTown:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *retArray = nil;
            NSArray *list = [item objectForKey:@"townList"];
            if (NotNilAndNull(list) && [list count] > 0) {
                NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:[list count]];
                NSMutableDictionary *townDic = [[NSMutableDictionary alloc] initWithCapacity:[list count]];
                NSUInteger index = 0;
                for (NSDictionary *dic in list)
                {
                    NSString *town = [dic objectForKey:@"townNo"];
                    NSString *townName = [dic objectForKey:@"townName"];
                    
                    if (town.length && townName.length) {
                        AddressInfoDTO *info = [[AddressInfoDTO alloc] init];
                        info.town = town;
                        info.townContent = townName;
                        [resultArray addObject:info];
                        
                        [townDic setObject:@{@"dto": info,
                                                 @"index": @(index)}
                                        forKey:town];
                        index ++;
                    }
                }
                retArray = [resultArray copy];
                self.townDic = [townDic copy];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getTownDidFinish:YES list:retArray];
            });

        } 
    });
}
@end
