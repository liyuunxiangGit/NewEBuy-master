//
//  TopADInfoDTO.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "TopADInfoDTO.h"

@implementation TopADInfoDTO


- (void)parseFromDict:(NSDictionary *)dict {
    if (NotNilAndNull(dict)) {
        self.contentType = EncodeStringFromDic(dict, @"contenttype");
        self.adImg = EncodeStringFromDic(dict, @"adimg");
        self.targetType = EncodeStringFromDic(dict, @"targettype");
        self.targetURL = EncodeStringFromDic(dict, @"targeturl");
        self.activityInfo = EncodeStringFromDic(dict, @"adcontent");
    }
}
@end
