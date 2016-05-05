//
//  PromotionInfoDTO.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PromotionInfoDTO.h"

@implementation PromotionInfoDTO
@synthesize elementId = _elementId;
@synthesize areaIdenty = _areaIdenty;
@synthesize linkUrl = _linkUrl;
@synthesize elementName = _elementName;
@synthesize elementDesc = _elementDesc;
@synthesize elementSeq = _elementSeq;
@synthesize imgUrl = _imgUrl;
@synthesize type = _type;
@synthesize isRead = _isRead;


-(void)dealloc
{
    TT_RELEASE_SAFELY(_elementId);
    TT_RELEASE_SAFELY(_areaIdenty);
    TT_RELEASE_SAFELY(_linkUrl);
    TT_RELEASE_SAFELY(_elementName);
    TT_RELEASE_SAFELY(_elementDesc);
    TT_RELEASE_SAFELY(_elementSeq);
    TT_RELEASE_SAFELY(_imgUrl);
    TT_RELEASE_SAFELY(_type);
    
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if(NotNilAndNull( [dic objectForKey:@"elementId"])){
        self.elementId= [dic objectForKey:@"elementId"];
    }
    if(NotNilAndNull([dic objectForKey:@"areaIdenty"])){
        self.areaIdenty=[dic objectForKey:@"areaIdenty"];
    }
    if(NotNilAndNull([dic objectForKey:@"linkUrl"])){
        self.linkUrl=[dic objectForKey:@"linkUrl"];
    }
    
    NSString *infoElementName = [dic objectForKey:@"elementName"];
    
    if (NotNilAndNull(infoElementName) && ![infoElementName isEmptyOrWhitespace]) 
    {
        //去除前后的空格和换行符
        infoElementName =  [infoElementName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
         self.elementName = infoElementName;
    }
    
    if(NotNilAndNull([dic objectForKey:@"elementDesc"])){
        self.elementDesc=[dic objectForKey:@"elementDesc"];
    }
    if(NotNilAndNull([dic objectForKey:@"elementSeq"])){
        self.elementSeq=[dic objectForKey:@"elementSeq"];
    }
    if(NotNilAndNull([dic objectForKey:@"imgUrl"])){
        self.imgUrl=[dic objectForKey:@"imgUrl"];
    }
    if(NotNilAndNull([dic objectForKey:@"type"])){
        self.type=[dic objectForKey:@"type"];
    }

    
}






@end
