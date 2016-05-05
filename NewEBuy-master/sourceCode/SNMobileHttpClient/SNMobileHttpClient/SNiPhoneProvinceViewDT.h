//
//  SNiPhoneProvinceViewDT.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-6.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "CommonDataTask.h"
#import "AddressInfoDTO.h"

/**
 @abstract  获取所有配送省份
 @param     无入参
 @result    `resultProvinceList`,所有配送省份列表，元素是`AddressInfoDTO`对象
 */
@interface SNiPhoneProvinceViewDT : CommonDataTask

/** result */
@property (nonatomic, strong) NSArray *resultProvinceList;

@end
