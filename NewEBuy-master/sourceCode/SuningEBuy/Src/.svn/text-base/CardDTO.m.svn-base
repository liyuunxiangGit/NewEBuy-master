//
//  CardDTO.m
//  SuningEBuy
//
//  Created by YANG on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CardDTO.h"

@implementation CardDTO
- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }

    self.custNum = EncodeStringFromDic(dic, @"custNum");
    self.userNickName = EncodeStringFromDic(dic, @"userNickName");
    self.expSummary = EncodeStringFromDic(dic, @"expSummary");
    self.sysHeadPicFlag = EncodeStringFromDic(dic, @"sysHeadPicFlag");
    self.indSignature = EncodeStringFromDic(dic, @"indSignature");
    self.sysHeadPicNum = EncodeStringFromDic(dic, @"sysHeadPicNum");
    self.gender = EncodeStringFromDic(dic, @"gender");
}
@end

