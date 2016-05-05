//
//  StoresRegistrationDTO.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoresRegistrationDTO : NSObject

@property (nonatomic, copy) NSString  *isCheckin;     //是否可以签到,0可以，1不可以
@property (nonatomic, copy) NSString  *errorCode;     //5代表不参加活动，4代表不在范围内，3代表已签

- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
