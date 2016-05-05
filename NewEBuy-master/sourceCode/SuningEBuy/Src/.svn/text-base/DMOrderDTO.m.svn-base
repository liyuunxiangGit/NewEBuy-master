//
//  DMOrderDTO.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DMOrderDTO.h"
@implementation DMOrderResultDTO

- (void)encodeFromDictionary:(NSDictionary *)dic{
	if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *__DMurl = [dic objectForKey:kHttpResponseDMUrl];
    NSString *__adid = [dic objectForKey:kHttpResponseAdId];
    NSString *__rule = [dic objectForKey:kHttpResponseRule];
    NSString *__title = [dic objectForKey:kHttpResponseTitle];
    NSString *__activityUrl = [dic objectForKey:kHttpResponseActivityUrl];
    NSString *__typeCode = [dic objectForKey:kHttpResponseTypeCode];
    NSString *__dmId = [dic objectForKey:@"dmId"];

	
    if (NotNilAndNull(__DMurl))
        self.dmPictureUrlStr = __DMurl;
    
    if (NotNilAndNull(__adid))
        self.adId = __adid ;
    
    if (NotNilAndNull(__rule))
        self.activityRule = __rule;
    
    if (NotNilAndNull(__title))
        self.activityTitle = __title;
    
    if (NotNilAndNull(__activityUrl))
        self.activityPictureUrlStr = __activityUrl;
    
    if (NotNilAndNull(__typeCode))
        self.adTypeCode = __typeCode;
    
    if (NotNilAndNull(__dmId)) {
        self.dmId = __dmId;
    }
}


- (void)dealloc{
    
    TT_RELEASE_SAFELY(_activityPictureUrlStr);
    TT_RELEASE_SAFELY(_activityRule);
    TT_RELEASE_SAFELY(_activityTitle);
    TT_RELEASE_SAFELY(_adId);
    TT_RELEASE_SAFELY(_adTypeCode);
    TT_RELEASE_SAFELY(_dmPictureUrlStr);
	
}
@end

@implementation DMOrderDTO

- (void)dealloc{

    TT_RELEASE_SAFELY(_appId);
    TT_RELEASE_SAFELY(_platform);
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_districtId);
    TT_RELEASE_SAFELY(_provinceId);
    TT_RELEASE_SAFELY(_cityId);
	
}
@end
