//
//  HomeModuleDTO.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomeModuleDTO.h"

@implementation HomeModuleDTO


- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    
    self.orderNO = EncodeStringFromDic(dict, @"orderno");
    self.moduleName = EncodeStringFromDic(dict, @"moduleid");
    self.moduleName = EncodeStringFromDic(dict, @"modulename");
    self.bgColor = EncodeStringFromDic(dict, @"bgcolor");
    self.bgImg = EncodeStringFromDic(dict, @"bgimg");
    self.targetType = EncodeStringFromDic(dict, @"targettype");
    self.targetURL = EncodeStringFromDic(dict, @"targeturl");
}
@end
