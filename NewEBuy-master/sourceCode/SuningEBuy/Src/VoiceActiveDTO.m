//
//  VoiceActiveDTO.m
//  SuningEBuy
//
//  Created by JackyWu on 14-10-30.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceActiveDTO.h"

@implementation VoiceActiveDTO

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    if(NotNilAndNull(EncodeStringFromDic(dic, @"Type")))
    {
        self.actityType =EncodeStringFromDic(dic, @"Type");
    }
    if(NotNilAndNull(EncodeStringFromDic(dic,@"State")))
    {
        NSString *isActity = EncodeStringFromDic(dic, @"State");
        self.isActity = [isActity isEqualToString:@"1"]?YES:NO;
    }
    if(NotNilAndNull(EncodeStringFromDic(dic,@"ActiveTypeID")))
    {
        self.ActiveTypeID = EncodeStringFromDic(dic,@"ActiveTypeID");
    }
    if(NotNilAndNull(EncodeStringFromDic(dic,@"ActiveID")))
    {
        self.ActiveID = EncodeStringFromDic(dic,@"ActiveID");
    }
    if(NotNilAndNull(EncodeStringFromDic(dic, @"adTypeCode")))
    {
        self.adTypeID = EncodeStringFromDic(dic, @"adTypeCode");
    }
    
    if(NotNilAndNull(EncodeStringFromDic(dic, @"adID")))
    {
        self.adID = EncodeStringFromDic(dic, @"adID");
    }
    if(NotNilAndNull(EncodeStringFromDic(dic,@"WapURL")))
    {
        self.wapUrl = EncodeStringFromDic(dic,@"WapURL");
    }
    
    if(NotNilAndNull(EncodeStringFromDic(dic,@"Value2")))
    {
        self.value2 = EncodeStringFromDic(dic,@"Value2");
    }
    
}

@end
