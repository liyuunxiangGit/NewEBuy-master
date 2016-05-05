//
//  ReturnGoodsStatusDTO.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-8-8.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "ReturnGoodsStatusDTO.h"
#import "RegexKitLite.h"

@implementation ReturnGoodsStatusDTO

@synthesize returnTime  = _returnTime;
@synthesize returnRecord = _returnRecord;
@synthesize timeAndRecord = _timeAndRecord;

- (void)dealloc {

    TT_RELEASE_SAFELY(_timeAndRecord);
    TT_RELEASE_SAFELY(_returnRecord);
    TT_RELEASE_SAFELY(_returnTime);
    
}


- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    
    self.returnTime = EncodeStringFromDic(dic, @"time");
    NSString *returnRecord = EncodeStringFromDic(dic, @"record");
    
    returnRecord = [returnRecord stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    returnRecord = [returnRecord removeHtmlTags];
    self.returnRecord = returnRecord;
    
    if (self.returnTime.length >= 20 && self.returnRecord.length)
    {
        NSString *returnTime = [self.returnTime substringWithRange:NSMakeRange(0, 19)];
        
        self.timeAndRecord = [NSString stringWithFormat:@"%@   %@",returnTime,self.returnRecord];
    }
    
}


@end
