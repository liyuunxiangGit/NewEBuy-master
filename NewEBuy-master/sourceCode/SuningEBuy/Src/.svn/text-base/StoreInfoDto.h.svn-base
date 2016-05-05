//
//  StoreInfoDto.h
//  SuningEBuy
//
//  Created by wangrui on 12/15/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import <Foundation/Foundation.h>

@interface StoreInfoDto : BaseHttpDTO <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *provinceId;    //省ID

@property (nonatomic, copy) NSString *provinceName;  //省名称

@property (nonatomic, copy) NSString *cityId;        //市id

@property (nonatomic, copy) NSString *cityName;      //市名称

@property (nonatomic, copy) NSString *districtId;    //区ID

@property (nonatomic, copy) NSString *districtName;  //区名

@property (nonatomic, copy) NSString *receiptName;    // 收货人姓名

@property (nonatomic, copy) NSString *receiptPhone;   // 手机号码

@property (nonatomic, copy) NSString *storeAddress;   // 门店地址

@property (nonatomic, copy) NSString *storeName;      // 门店名称

@property (nonatomic, copy) NSString *storeCode;      // 门店编码


- (void)encodeFromDictionary:(NSDictionary *)dic;

//解析最后提货信息
- (void)encodeLastPickUpInfoFromDictionary:(NSDictionary *)dic;

@end
