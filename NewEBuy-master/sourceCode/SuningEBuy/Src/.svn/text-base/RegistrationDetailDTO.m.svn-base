//
//  RegistrationDetailDTO.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RegistrationDetailDTO.h"

@implementation RegistrationDetailDTO

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    self.errorCode = EncodeStringFromDic(dic,@"errorCode");
    
    self.isSucess = EncodeStringFromDic(dic, @"isSucess");
    self.largessPoints = EncodeStringFromDic(dic, @"largessPoints");
    self.couponValue = EncodeStringFromDic(dic, @"couponValue");
    self.errorCode = EncodeStringFromDic(dic, @"errorCode");
    self.errorMessage = EncodeStringFromDic(dic, @"errorMessage");
}
@end
