//
//  SNiPhoneDistrictViewDT.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-19.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "CommonDataTask.h"
#import "AddressInfoDTO.h"

/**
 @abstract  获取某一city下的区列表
 @param     `cityCode`, 城市编码，必须
 @result    `resultDistrictList`, 区列表，元素是`AddressInfoDTO`对象
 */
@interface SNiPhoneDistrictViewDT : CommonDataTask

/** result */
@property (nonatomic, strong) NSArray *resultDistrictList;

@end
