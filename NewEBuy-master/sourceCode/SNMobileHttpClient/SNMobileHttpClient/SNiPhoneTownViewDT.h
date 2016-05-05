//
//  SNiPhoneTownViewDT.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-19.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "CommonDataTask.h"
#import "AddressInfoDTO.h"

/**
 @abstract  获取某一区下的镇列表
 @param     `districtCode`, 区编码，必须
 @result    `resultTownList`, 镇列表，元素是`AddressInfoDTO`对象
 */
@interface SNiPhoneTownViewDT : CommonDataTask

/** result */
@property (nonatomic, strong) NSArray *resultTownList;

@end
