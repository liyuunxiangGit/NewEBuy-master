//
//  BigImageTypeDTO.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BigImageTypeDTO.h"

@implementation BigImageTypeDTO

@synthesize typeId=_typeId;
@synthesize title=_title;
@synthesize publishTime=_publishTime;
@synthesize imgUrl=_imgUrl;
@synthesize summary=_summary;
@synthesize infoId=_infoId;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_typeId);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_summary);
    TT_RELEASE_SAFELY(_publishTime);
    TT_RELEASE_SAFELY(_imgUrl);
    TT_RELEASE_SAFELY(_infoId);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.typeId = EncodeStringFromDic(dic, @"typeId");
    self.title = EncodeStringFromDic(dic, @"title");
    self.summary = EncodeStringFromDic(dic, @"summary");
    self.publishTime = EncodeStringFromDic(dic, @"publishTime");
    self.imgUrl = EncodeStringFromDic(dic, @"imgUrl");
    self.infoId = EncodeStringFromDic(dic, @"infoId");
    
}

@end
