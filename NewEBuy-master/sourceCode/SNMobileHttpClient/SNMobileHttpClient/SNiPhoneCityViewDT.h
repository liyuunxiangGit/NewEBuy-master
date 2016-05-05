//
//  SNiPhoneCityViewDT.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-19.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "CommonDataTask.h"
#import "AddressInfoDTO.h"

/**
 @abstract  获取某一省份下或所有省份的城市列表
 @param     `provinceCode`, 省份编码. 为空或nil时，返回所有城市列表
 @result    `resultCityList`,城市列表，元素是`AddressInfoDTO`对象
 */
@interface SNiPhoneCityViewDT : CommonDataTask

/** result */
@property (nonatomic, strong) NSArray *resultCityList;

@end
