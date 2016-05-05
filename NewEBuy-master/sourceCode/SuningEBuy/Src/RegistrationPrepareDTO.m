//
//  RegistrationPrepareDTO.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RegistrationPrepareDTO.h"

@implementation RegistrationPrepareDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    self.errCode   = EncodeStringFromDic(dic,@"errorCode");
    
    self.checkType = EncodeStringFromDic(dic, @"checkType");
    self.checkTitle = EncodeStringFromDic(dic, @"checkTitle");
    self.isCheck = EncodeStringFromDic(dic, @"isCheck");
    self.checkRuleDesc = EncodeStringFromDic(dic, @"checkRuleDesc");
    self.checkCount = EncodeStringFromDic(dic, @"checkCount");
    self.largessType = EncodeStringFromDic(dic, @"largessType");
    self.dayNum = EncodeStringFromDic(dic, @"dayNum");
    self.residueDay = EncodeStringFromDic(dic, @"residueDay");
    
    
    self.checkInfoList = EncodeArrayFromDic(dic, @"checkInfoList");
    self.prePointsList = EncodeArrayFromDic(dic, @"prePointsList");
    self.curPointsList = EncodeArrayFromDic(dic, @"curPointsList");
    self.nextPointsList = EncodeArrayFromDic(dic, @"nextPointsList");
    self.preCouponList = EncodeArrayFromDic(dic, @"preCouponList");
    self.curCouponList = EncodeArrayFromDic(dic, @"curCouponList");
    self.nextPointsList = EncodeArrayFromDic(dic, @"nextCouponList");
    
    self.currentDate = EncodeStringFromDic(dic, @"currentDate");
    self.activeStartDate = EncodeStringFromDic(dic, @"ActiveStartDate");
}
@end
