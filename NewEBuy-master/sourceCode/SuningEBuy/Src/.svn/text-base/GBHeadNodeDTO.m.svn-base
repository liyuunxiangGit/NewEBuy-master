//
//  GBHeadNodeDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBHeadNodeDTO.h"

@implementation GBHeadNodeDTO

@synthesize name = _name;
@synthesize idNode = _idNode;
@synthesize pinyin = _pinyin;
@synthesize count = _count;
@synthesize children = _children;
@synthesize fatherId = _fatherId;
@synthesize level = _level;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_idNode);
    TT_RELEASE_SAFELY(_pinyin);
    TT_RELEASE_SAFELY(_count);
    TT_RELEASE_SAFELY(_children);
    TT_RELEASE_SAFELY(_fatherId);
    TT_RELEASE_SAFELY(_level);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.name = EncodeStringFromDic(dic, @"name");
    self.idNode = EncodeStringFromDic(dic, @"id");
    self.pinyin = EncodeStringFromDic(dic, @"pinyin");
    self.count = EncodeStringFromDic(dic, @"count");
    self.children = [EncodeArrayFromDic(dic, @"children") mutableCopy];
    self.fatherId = EncodeStringFromDic(dic, @"fatherId");
    self.level = EncodeStringFromDic(dic, @"level");
}

@end
